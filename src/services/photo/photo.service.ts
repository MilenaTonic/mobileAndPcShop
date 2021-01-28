import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Photo } from "src/entities/photo.entity";
import { Repository } from "typeorm";

@Injectable()
export class PhotoService extends TypeOrmCrudService<Photo> {
    constructor(@InjectRepository(Photo) private readonly photo: Repository<Photo>) // Ovo evidentiramo u nasem glavnom app.modulu
    {
        super(photo);
    }

    add(newPhoto: Photo): Promise<Photo> {
       return this.photo.save(newPhoto);
    }

    // Brisanje slike po ID-ju iz baze podataka
    async deleteById(id: number) {
        return await this.photo.delete(id);
    }
}
