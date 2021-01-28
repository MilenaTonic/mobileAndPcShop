import { Body, Controller, Delete, Param, Post, Req, UploadedFile, UseInterceptors } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ArticleService } from "src/services/article/article.service";
import { FileInterceptor } from "@nestjs/platform-express";
import { diskStorage } from "multer"
import { StorageConfig } from "config/storage.config";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "src/entities/photo.entity";
import { ApiResponse } from "src/misc/api.response.class";
import * as fileType from 'file-type';
import * as fs from 'fs';
import * as sharp from 'sharp';

@Controller('api/article')
@Crud({
    model: {
        type: Article
    },
    params: {
        id: {
            field: 'articleId',
            type: 'number',
            primary: true
        }
    },
    query: {
        join: {
            category: {
                eager: true
            },
            photos: {
                eager: true
            },
            articlePrices: {
                eager: true
            },
            articleFeatures: {
                eager: true
            },
            features: {
                eager: true
            }
        }
    }
})
export class ArticleController {
    constructor(
        public service: ArticleService,
        public photoService: PhotoService,
     ) {}

    @Post('createFull') // POST:    http://localhost:3000/api/article/createFull/
    createFullArticle(@Body() data: AddArticleDto) {
        return this.service.createFullArticle(data);
    }

    @Post(':id/uploadPhoto/') // POST http://localhost:3000/api/article/:id/uploadPhoto/
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
                filename: (req, file, callback) => {
                    let original: string = file.originalname;

                    let normalized = original.replace(/\s+/g, '-');
                    normalized.replace(/[^A-z0-9\.\-]/g, '');
                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth() + 1).toString();
                    datePart += sada.getDate().toString();

                    let randomPart: string =
                        new Array(10)
                        .fill(0)
                        .map(e => (Math.random() * 9).toFixed(0).toString())
                        .join('');

                    let fileName = datePart + '-' + randomPart + '-' + normalized;

                    fileName = fileName.toLocaleLowerCase();

                    callback(null, fileName);
                }
            }),
            fileFilter: (req, file, callback) => {
                // #1
                if(!file.originalname.toLowerCase().match(/\.(jpg|png)$/)) {
                //if(!file.originalname.match(/\.(jpg|png)$/)) {
                    req.fileFilterError = 'Bad file extension!';
                    callback(null, false);
                    return;
                }
                // #2
                if(!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) {
                    req.fileFilterError = 'Bad file content!';
                    callback(null, false);
                    return;
                }

                callback(null, true);
            },
            limits: {
                files: 1,
                fileSize: StorageConfig.photo.maxSize,
            },
        })
    )
    async uploadPhoto(
        @Param('id') articleId: number,
        @UploadedFile() photo,
        @Req() req
    ): Promise<ApiResponse | Photo> {
        if(req.fileFilterError) {
            return new ApiResponse('error', -4002, req.fileFilterError); // Bad File Extension ILI Bad File Content
        }

        if(!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!'); // Slika ne postoji
        }

        const fileTypeResult = await fileType.fromFile(photo.path);
        if(!fileTypeResult) {
            // TODO: Obrisati taj file
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Cannot detect file type!'); // File ne valja
        }

        // TODO: Real Mime Type check
        const realMimeType = fileTypeResult.mime;
        if(!(realMimeType.includes('jpeg') || realMimeType.includes('png'))) {
            // TODO: Obrisati taj file
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Bad file content type!'); // Tip ne valja
        }

        // TODO: Save a resized file
        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb);
        await this.createResizedImage(photo, StorageConfig.photo.resize.small);

        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if(!savedPhoto) {
            return new ApiResponse('error', -4001);
        }

        return savedPhoto;
    }

    async createResizedImage(photo, resizeSettings) {
        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath = 
        StorageConfig.photo.destination + 
        resizeSettings.directory + 
        fileName;

        await sharp(originalFilePath)
        .resize({
            fit: 'cover',
            widht: resizeSettings.widht,
            height: resizeSettings.height,
        })
        .toFile(destinationFilePath);
    }

    @Delete(':articleId/deletePhoto/:photoId') // http:/localhost:3000/api/article/1/deletePhoto/3
    public async deletePhoto(
        @Param('articleId') articleId: number,
        @Param('photoId') photoId: number,
    ) {
        const photo = await this.photoService.findOne({
            articleId: articleId,
            photoId: photoId
        });

        if(!photo) {
            return new ApiResponse('error', -4004, 'Photo not found!');
        }

        try {
            // Brisanje svih 3 slika
            fs.unlinkSync(StorageConfig.photo.destination + photo.imagePath);
            fs.unlinkSync(StorageConfig.photo.destination + 
                StorageConfig.photo.resize.thumb.directory + 
                photo.imagePath);
            fs.unlinkSync(StorageConfig.photo.destination + 
                StorageConfig.photo.resize.small.directory + 
                photo.imagePath);
        } catch (e) {
            // OVDE NE MORA NISTA DA SE STAVI ZATO JE I PRAZNO
        }

        // Brisanje slike iz baze podataka
        const deleteResult = await this.photoService.deleteById(photoId);

        // affected - Koliko je zapisa iz baze obrisano
        if(deleteResult.affected === 0) {
            return new ApiResponse('error', -4004, 'Photo not found!');
        }

        return new ApiResponse('ok', 0, 'One photo deleted!');
    }
}
