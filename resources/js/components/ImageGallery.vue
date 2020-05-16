<template>
    <div>
        <!-- I have a lot of images on my site, it ends up totaling over 24mb to load the main page. That will increase as the image galleries increase (the 3D image gallery isn't done yet) -->
        <!-- I'm not sure how much data is too much, but I know I'm using images with 3k or even 4k resolution when almost no screens would ever need to display that many pixels -->
        <!-- There may be some abnormal screens where the image would need to be 3k or 4k -->
        <!-- For large "process" type images, the ability to zoom in to see finer detail is kind of important too -->
        <!-- Still, some of these images are way too big -->

        <!-- Alright so after going on Artstation to check, they just load in 3k images that are over 1mb all the time. Large posts with lots of images could easily hit 24mb -->
        <!-- That said, I don't really think I need to load in 24mb for my site. I'd like it to be less. -->
        <!-- Well, I guess the images are cached on the hard drive, right? It would only be a one-time thing until the user cleared their cache -->
        <!-- I'm not sure my computer is caching the images...hmmm -->

        <!-- Side note: If a project image has a smaller pixel width than the container's pixel width, it doesn't fill the container, it just remains the original width. -->
        <!-- If I want to have it grow to fill the container, I will need to use some javascript -->
        <!-- On large screens: -->
        <!-- Landscape images should be set to 100% width until the max height of 97vh is reached -->
        <!-- Portrait images should be set to 100vh until the max width of 100% is reached -->
        <!-- This might be too much of a pain. I would need to make an image component that listens for window resize and applies styling based on the image's aspect ratio and type of screen -->
        <!-- It's much easier to save the initial images for use on a 4k monitor (lanscape width should be 2022px+, portrait height should be 1300px+)(Portrait images might have a problem on vertical 4k monitors, but I really don't think it matters) -->
        <!-- These seem like reasonable sizes. Downsizing like that is going to kill some detail for those who want to zoom in on the image, but for the most part it really shouldn't matter -->
        <!-- If I decide to downsize the images further, I WILL have to deal with the "image not filling the container" problem -->
        <!-- If I change the dimensions at all I'll have to deal with the problem. I am NOT going to resize every image just because I downsized the width of the description panel -->
        <!-- There is a little leeway when it comes to those dimensions. If the image is just a little too small, it's not a big deal -->

        <!-- I just thought of something that I should have thought of earlier, and I'm not really sure what's happening -->
        <!-- My 4k monitor will scale up apps so text, buttons, etc are actually readable. What does this mean for images? -->
        <!-- The screen is just over 2k pixels in height, but an image that takes up the height of the screen in Chrome says it is 1300 pixels in height -->
        <!-- The only way it takes up the entire screen is if it is actually a smaller image that is being scaled up to fit my monitor -->
        <!-- The question is, what does it do with an image who's original size actually does take up the full 2k pixels in height? -->
        <!-- Chrome would still say the image is only 1300 px in height, but is it doing the same thing? -->
        <!-- Is the full size 2k image being scaled down to 1300px, and that smaller image being blown up to fit my monitor? -->
        <!-- It seems really weird that it would do that when the original full size image would actually fit the screen. -->
        <!-- I have my images sized to fit what Chrome dev tools says is "4k," but if Chrome was to actually display 4k resolution, they would be too small -->
        <!-- I'm just a bit concerned because Windows is scaling up my images to fit a 4k monitor, and scaling up reduces perceived quality -->
        <!-- Making my images bigger would only benefit those with a 4k monitor who choose not to scale their apps, or those who zoom out in their web browser -->
        <!-- You would think Chrome would have a way to make the text, icons, etc bigger so the full 4k resolution could be utilized -->

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
    // TO DO: THE IMAGE INFORMATION SHOULD COME FROM A DATABASE, NOT FROM A JSON OBJECT SAVED IN THE ASSETS FOLDER 
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
                    // There might be an easier way to make a deep copy of an object...
                    let tmpRow = new Row(row.id);
                    tmpRow.width = row.width;
                    tmpRow.height = row.height;
                    tmpRow.aspectRatio = row.aspectRatio;
                    // Images is an array, which assigns a pointer, so I have to make a copy
                    tmpRow.images = JSON.parse(JSON.stringify(row.images));
                    
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