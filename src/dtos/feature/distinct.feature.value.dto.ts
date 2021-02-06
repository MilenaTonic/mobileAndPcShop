export default class DistinctFeatureValueDto {
    features: {
        featureId: number;
        name: string;
        values: string[];
    }[];
}
