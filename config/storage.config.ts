export const StorageConfig = {
    photo: {
        destination: '../storage/photos/',
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
