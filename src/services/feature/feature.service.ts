import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import DistinctFeatureValueDto from "src/dtos/feature/distinct.feature.value.dto";
import { ArticleFeature } from "src/entities/article-feature.entity";
import { Feature } from "src/entities/feature.entity";
import { Repository } from "typeorm";

@Injectable()
export class FeatureService extends TypeOrmCrudService<Feature> {
    constructor(
        @InjectRepository(Feature) private readonly feature: Repository<Feature>, // Ovo navodimo u app.module.ts gde treba
        @InjectRepository(ArticleFeature) private readonly articleFeature: Repository<ArticleFeature>,
    ) {
        super(feature);
    }

    async getDistinctValuesByCategoryId(categoryId: number): Promise<DistinctFeatureValueDto> {
        const features = await this.feature.find({
            categoryId: categoryId,
        });

        const result: DistinctFeatureValueDto = {
            features: [],
        };

        if(!features || features.length === 0) {
            return result;
        }

        result.features = await Promise.all(features.map(async feature => {
            const values: string[] =
            (
                await this.articleFeature.createQueryBuilder("af")
                .select("DISTINCT af.Column 4", 'value')
                .where('af.featureId = :featureId', { featureId: feature.featureId})
                .orderBy('af.Column 4', 'ASC')
                .getRawMany()
            ).map(item => item.value);

            return {
                featureId: feature.featureId,
                name: feature.name,
                // Ako ne radi ovde dodaj Column_4
                values: values,
            };
        }));

        return result;
    }
}
