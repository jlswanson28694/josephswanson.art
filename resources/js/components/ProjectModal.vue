<template>
    <div class="project-modal">
        <!-- If a project image has a smaller pixel width than the container's pixel width, it doesn't fill the container, it just remains the original width. -->
        <!-- If I want to have it grow to fill the container, I will need to use some javascript -->
        <!-- On large screens: -->
        <!-- Landscape images should be set to 100% width until the max height of 97vh is reached -->
        <!-- Portrait images should be set to 100vh until the max width of 100% is reached -->
        <!-- This might be too much of a pain. I would need to make an image component that listens for window resize and applies styling based on the image's aspect ratio and type of screen -->
        <!-- It's much easier to save the initial images for use on a 4k monitor (lanscape width should be 2022px+, portrait height should be 1300px+) -->
        <!-- These seem like reasonable sizes. Downsizing like that is going to kill some detail for those who want to zoom in on the image, but for the most part it really shouldn't matter -->
        <!-- If I decide to downsize the images further, I WILL have to deal with the "image not filling the container" problem -->
        <!-- If I change the dimensions at all I'll have to deal with the problem. I am NOT going to resize every image just because I downsized the width of the description panel -->
        <!-- There is a little leeway when it comes to those dimensions. If the image is just a little too small, it's not a big deal -->

        <div class="description-panel">
            <div class="flex justify-between items-center bg-gray-900 p-4">
                <div>
                    <p class="text-lg font-bold">
                        {{ currentProject.name }}
                    </p>
                </div>
                <router-link :to="previousUrl" class="cursor-pointer text-2xl hover:text-gray-500">
                    <i class="fas fa-window-close"></i>
                </router-link>
            </div>

            <div class="hide-on-large bg-black p-3 cursor-pointer" @click="toggleDescription">
                <div class="flex items-center">
                    <div class="mr-2">
                        <p v-show="!displayDescription">Tap to view project description</p>
                        <p v-show="displayDescription">Tap to close project description</p>
                    </div>
                    <i class="far fa-caret-square-down text-lg"></i>
                </div>
            </div>

            <div class="project-description custom-scrollbar" v-show="!onMobile || displayDescription">
                <div v-html="currentProject.description"></div>
            </div>
        </div>

        <ul class="project-display custom-scrollbar" @scroll="onScroll()" ref="projectDisplay">
            <li>
                <transition name="fade-down">
                    <div class="fixed scroll-arrow text-2xl bg-gray-800 px-2 rounded-lg" v-show="displayScrollPrompt">
                        <i class="fas fa-angle-double-down"></i>
                    </div>
                </transition>
            </li>
            
            <li class="p-2" v-for="image in currentProject.images" :key="image.id">
                <img :src="getImgUrl(image.path)" alt="" @load="setDisplayScrollPrompt()">
                <p class="text-center">
                    {{ image.caption }}
                </p>
            </li>
        </ul>

    </div>
</template>

<script>
// TO DO: 
// * SET MAX IMAGE HEIGHT HIGHER FOR HORIZONTAL PHONE SCREENS?

export default {
    name: "ProjectModal",

    props: ['id'],

    data() {
        return {
            currentProject: '',
            displayDescription: false,
            onMobile: false,
            displayScrollPrompt: false,
            previousUrl: '',
        }
    },

    mounted() {
        // Grab the project information and images
        axios.get("/api/projects/" + this.id)
            .then(response => {
                this.currentProject = response.data.project;

                // The close button should return to the correct gallery
                if(this.currentProject.type == "Concept Art") {
                    this.previousUrl = "/";
                } else {
                    this.previousUrl = "/3d-art";
                }

                // I was having this really irritating problem where the ref I had to the project display wasn't updating to account for the images that were being added. Even when I used nextTick, it wasn't giving me the correct number.
                // I thought that was how nextTick worked. I set the data in this function, then the DOM should be updated on the next tick, right? Well it wasn't working.
                // Maybe it was something about how $refs work? The ref gave me the correct number when I ran a test function onclick, but I couldn't get that number to show up using nextTick.
                // It took me a long time to figure out how to get the correct number, but I found out there is a Javascript event each time an element is loaded.
                // I set a v-on:load for each img that is added to the project display, and I have it run setDisplayScrollPrompt. Works like a charm.
            })

        window.addEventListener('resize', this.onResize);
        this.setScreenType();
    },

    beforeDestroy() {
        // The event listener I assigned when the component starts stays when it is destroyed. If it tries to run code on a component that doesn't exist, there are some problems, so I have to remove the event listener.
        window.removeEventListener('resize', this.onResize);
    },

    methods: {
        setDisplayScrollPrompt() {
            if(this.currentProject) {
                if(this.currentProject.images.length > 1 && (this.$refs.projectDisplay.scrollHeight - 70) > this.$refs.projectDisplay.clientHeight) {
                    // There are multiple images in the project, and the scrollbar is active
                    if(this.$refs.projectDisplay.scrollTop == 0) {
                        // The scrollbar is at the top, so display the scroll prompt
                        this.displayScrollPrompt = true;
                    } else {
                        // The scrollbar is not at the top, hide the scroll prompt
                        this.displayScrollPrompt = false;
                    }
                } else {
                    this.displayScrollPrompt = false;
                }
            }   
        },

        onScroll() {
            this.setDisplayScrollPrompt();
        },

        getImgUrl(path) {
            return '/images/' + path;
        },

        toggleDescription() {
            this.displayDescription = !this.displayDescription;
        },

        onResize() {
            this.setScreenType();
            this.setDisplayScrollPrompt();
        },

        setScreenType() {
            if(window.innerWidth < 1024) {
                this.onMobile = true;
            } else {
                this.onMobile = false;
            }
        }
    }
}
</script>

<style scoped>
.project-modal {
    display: flex;
    flex-direction: column;
    position: fixed;
    height: 100vh;
    top: 0;
    left: 0;
    right: 0;
    @apply bg-gray-800;
    @apply bg-opacity-75;
    color: white;
    z-index: 9999;
}

img {
    /* I would like each image to always fit on the screen. It's kind of hard to view an image if half of it is trailing off the bottom of the screen */
    /* Unfortunately, I can't use percentage units for setting the maximum height an image can be. For some reason, I have to use pixels or v-units */
    /* It's not possible without javascript, and I really don't like that. I think I'm just going to stick with max-height being 80vh. */
    /* 80vh should be plenty for almost any phone screen. Portrait images do become pretty small if the phone is flipped, but not so small you can't tell what it is */
    /* If the flipped phone thing is a big enough issue, I can use a media query to set the max-height higher, or off entirely when the phone is flipped */
    max-height: 80vh;
    max-width: 100%;
    margin: 0 auto;
}

.project-display {
    overflow-y: auto;
    padding-bottom: 50px;
}

.scroll-arrow {
    right: 10px;
    bottom: 5px;
}

.fade-down-enter-active, .fade-down-leave-active {
    transition: opacity .5s, transform .5s;
}

.fade-down-enter, .fade-down-leave-to {
    opacity: 0;
    transform: translate(0px, 50px);
}

.description-panel {
    background-color: #273042;
    width: 100%;
    order: 0;
}

.project-description {
    position: absolute;
    background-color: #273042;
    max-height: 50vh;
    overflow-y: auto;
    padding: 1rem;
    width: 100%;
}

.hide-on-large {
    display: block;
}

.custom-scrollbar::-webkit-scrollbar {
    width: 5px;
}

.custom-scrollbar::-webkit-scrollbar-track {
    background-color: #464646;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
    background-color: #838383;
}

@media screen and (min-width: 1024px) {
    .project-modal {
        display: flex;
        flex-direction: row;
    }

    img {
        max-height: 97vh;
        max-width: 100%;
    }

    .project-display {
        width: 80vw;
        padding: 0;
    }

    .scroll-arrow {
        right: 20vw; 
        bottom: 5px; 
        margin-right: 15px;
    }

    .description-panel {
        height: auto;
        right: 0;
        top: 0;
        bottom: 0;
        width: 20%;
        position: static;
        order: 2;
    }

    .project-description {
        position: static;
        display: block;
        max-height: none;
    }

    .hide-on-large {
        display: none;
    }

    .custom-scrollbar::-webkit-scrollbar {
        width: 10px;
    }

    .custom-scrollbar::-webkit-scrollbar-track {
        background-color: #464646;
    }

    .custom-scrollbar::-webkit-scrollbar-thumb {
        background-color: #838383;
    }
}

</style>
