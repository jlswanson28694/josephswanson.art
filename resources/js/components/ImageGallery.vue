<template>
    <div>
        <!-- I switched to using lower resolution "thumbnails" for the image gallery. The full resolution loads when you open the project. -->
        <!-- I didn't want to use an image that was too small. On the 4k monitor, the images are displayed at a pretty large resolution. If I downsize them too much, they will look bad.-->
        <!-- Looks like the lowest I can set the thumbnails is to 1500px max width, and 800px max height. Any lower and they start to look pretty blurry. It doesn't seem like a huge improvement, but it does cut the file size significantly. -->

        <ul v-for="row in finalGallery" :key="row.id" :class="{'flex justify-center' : !onMobile}">
            <li v-for="thumbnail in row.images" :key="thumbnail.id" :style="getImageWidth(thumbnail.percentOfRow)" class="relative m-1 shadow-md">
                <i class="fas fa-clone absolute right-0 bottom-0 text-white text-lg bg-gray-700 p-1 rounded-lg mr-2 mb-2 z-10" v-if="thumbnail.imageCount > 1"></i>
                <router-link :to="'/' + tab + '/project/' + thumbnail.project_id" class="image-hover"></router-link>
                <img :src="getImgUrl(thumbnail.path)" alt="">
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    name: "ImageGallery",

    props: {
        type: {required : true},
        tab: {required : true},
    },

    data() {
        return {
            finalGallery: [],
            onMobile: false,
        }
    },

    mounted() {
        // Grab the project thumbnails
        axios.get('/api/projects?type=' + this.type)
            .then(response => {
                let gallery = response.data.projects;
                this.generateImageLayout(gallery);
            });

        // Each image should get their own row on small screens, this checks whether the screen is small.
        this.setScreenType();
        window.addEventListener('resize', this.setScreenType);  
    },

    methods: {
        setScreenType() {
            if(window.innerWidth <= 425) {
                // Mobile screen
                this.onMobile = true;
            } else {
                // Not a mobile screen
                this.onMobile = false;
            }
        },

        getImageWidth(width) {
            if(this.onMobile) {
                // Always fill 100% of the row on mobile
                width = 100;
            }

            return `width: ${width}%;`;
        },

        getImgUrl(path) {
            return '/images/' + path;
        },

        generateImageLayout(gallery) {
            // I'M CONSIDERING AN OPTIONAL PROP ARRAY THAT SPECIFIES HOW MANY IMAGES I WANT IN A GIVEN ROW. SAY I WANT TWO IMAGES IN THE FIRST ROW NO MATTER WHAT, BUT I WANT THE REST OF THE ROWS GENERATED AUTOMATICALLY. IT WOULD BE NICE.

            // SHOULD THIS BE PASSED IN AS A PROP? IT'S POSSIBLE I MIGHT WANT DIFFERENT VALUES FOR DIFFERENT IMAGE GALLERIES. RIGHT NOW IT'S FINE THOUGH.
            const minAspectRatio = .33;
            const maxAspectRatio = .6;

            console.log("Starting image gallery");

            // Start the first row with the first image
            let row = new Row(this.finalGallery.length);
            row.addImage(gallery[0]);
            
            // Iterate through the remaining images
            for (let i = 1; i < gallery.length; i++) {
                // Gallery is immutable, store the current image so I can mess with it
                // Come to think of it, isn't this just storing a pointer? I assume it wouldn't let me assign values to currentImage if it was a pointer.
                let currentImage = gallery[i];

                console.log("Attempting to add another image to the row...");

                if(row.aspectRatio > maxAspectRatio) {
                    // If the row is too big, always add the current image to make it smaller
                    console.log("Row is too big, adding image to make it smaller...");
                    
                    row.addImage(currentImage);
                } else {
                    // The current row's aspect ratio is below the maxAspectRatio, but may or may not be able to handle another image without it going below the minAspectRatio

                    
                    // I need to add the current image to the row to check if the aspect ratio drops below minAspectRatio
                    // However, I don't want to mess with the actual row in case I want to keep it, so I copy it over to a temporary object
                    // I need a deep copy since the row object has both methods and a nested array of images. I use lodash cloneDeep for this.
                    let tmpRow = _.cloneDeep(row);

                    // Now I can add the image to test the aspect ratio without affecting the actual row
                    tmpRow.addImage(currentImage);

                    console.log("The row's height would be " + (tmpRow.aspectRatio * 100) + "% of the row's width.");

                    if (tmpRow.aspectRatio < minAspectRatio) {
                        // If the row's aspect ratio would be too low, I need to start a new row
                        console.log("This percentage is below the minimum, starting new row...");

                        // Push the current row to the final gallery
                        this.finalGallery.push(row);
                    
                        // Set up a new row with the current image
                        row = new Row(this.finalGallery.length);
                        row.addImage(currentImage);
                    } else {
                        // The height is within the limits, so persist the temporary row
                        console.log("This percentage is above the minumum, adding image to row...");

                        row = tmpRow;
                    }
                }
            }

            // After iterating through all the images, the current row instance still needs to be pushed to the final gallery
            console.log("Last image in the gallery. Adding row...");

            if(row.aspectRatio > maxAspectRatio) {
                // Just like above, I want to check to make sure the row isn't huge. However, this time I don't have any more images to add to make it smaller
                // Instead, I have to tell the images in the row to take up a smaller percentage of the row, which sort of "scales it down"
                // I take the row, and calculate the width at which the aspect ratio of the row would be the same as minAspectRatio
                let desiredWidth = row.height / minAspectRatio;

                // Set that width, then set the percent of the width each image would take up in the new, larger row
                row.width = desiredWidth;

                row.setWidthPercentages();
            }

            // Add the last row to the final gallery
            this.finalGallery.push(row);
        },
    }
}

// ---- HELPER CODE ---- //
// ---- MAYBE EXTRACT THIS TO ITS OWN FILE ---- //

function scale(width, height, scaleTo, dimension) {
    // I'm generally scaling from the current height to another given height, so I need to pass in the current values, and the value I'm scaling to
    // Dimension is whether I'm scaling based on a given height or width. Width = 0, height = 1

    let scaleFactor = 1;

    if (dimension === 0) {
        scaleFactor = scaleTo / width;
        width = width * scaleFactor;
        height = height * scaleFactor;
    } else {
        scaleFactor = scaleTo / height;
        width = width * scaleFactor;
        height = height * scaleFactor;
    }

    return { width: width, height: height };
}

class Row {
    constructor(id) {
        this.id = id;
        this.width = 0;
        this.height = 0;
        this.aspectRatio = 0;
        this.images = [];
    }

    addImage(image) {
        if(this.images.length == 0) {
            // First image in the row
            this.images.push(image);
            this.height = image.height;
            this.width = image.width;
        } else {
            // Scale the image to match the height of the row
            let scaleResult = scale(image.width, image.height, this.height, 1);
            image.height = scaleResult.height;
            image.width = scaleResult.width;

            // Add the image to the array
            this.images.push(image);

            // Add the new image's width to the row's width
            this.width = this.width + image.width;
        }

        this.setWidthPercentages();

        this.setAspectRatio();
    }

    setWidthPercentages() {
        for(let i in this.images) {
            this.images[i].percentOfRow = (this.images[i].width / this.width) * 100;
        }
    }

    setAspectRatio() {
        // I'm honestly not sure whether aspect ratio should be height / width or width / height
        this.aspectRatio = this.height / this.width;
    }
}
</script>

<style scoped>
img {
    width: 100%;
}

.image-hover {
    position: absolute;
    width: 100%;
    height: 100%;
    cursor: pointer;
}

.image-hover:hover {
    @apply bg-black;
    @apply bg-opacity-25;
}

</style>