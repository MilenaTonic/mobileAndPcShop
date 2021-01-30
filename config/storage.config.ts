export const StorageConfig = {
    photo: {
        destination: '../storage/photos/',
        urlPrefix: '/assets/photos',
        maxAge: 1000 * 60 * 60 * 24 * 7, // 7 dana
        maxSize: 3 * 1024 * 1024, // = 3MB u bajtovima
        resize: {
            thumb: {
                widht: 120, 
                height: 100,
                directory: 'thumb/'
            },
            small: {
                widht: 320, 
                height: 240,
                directory: 'small/'
            },
        },
    },
};
