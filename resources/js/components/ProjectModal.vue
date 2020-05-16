<template>
    <div class="project-modal">

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

        <ul class="project-display custom-scrollbar" @scroll="onScroll($event.target.scrollTop)">
            <li>
                <transition name="fade-down">
                    <div class="fixed scroll-arrow text-2xl bg-gray-800 px-2 rounded-lg" v-show="displayScrollPrompt">
                        <i class="fas fa-angle-double-down"></i>
                    </div>
                </transition>
            </li>
            <li class="p-2" v-for="image in currentProject.images" :key="image.id">
                <img :src="getImgUrl(image.path)" alt="">
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
            previousUrl: ''
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
                
                // Scroll prompt should only appear if there are multiple images
                if(this.currentProject.images.length > 1) {
                    this.displayScrollPrompt = true;
                }
            });
        
        window.addEventListener('resize', this.setScreenType);
        this.setScreenType();
    },

    methods: {
        onScroll(scrollTop) {
            if(scrollTop == 0) {
                this.displayScrollPrompt = true;
            } else {
                this.displayScrollPrompt = false;
            }
        },

        getImgUrl(path) {
            return '/images/' + path;
        },

        toggleDescription() {
            this.displayDescription = !this.displayDescription;
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
