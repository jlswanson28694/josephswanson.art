<template>
    <div @keydown.enter="test">
        <div class="banner">
            <img src="/images/TwitterBanner.png" alt="" class="object-cover">
        </div>

        <header>
            <div class="header-content">
                <div class="social-links col-span-1">
                    <social-links></social-links>
                </div>

                <div class="header-text col-span-1">
                    <h1>Joseph Swanson</h1>
                    <h2 class="text-xl">Concept Art and 3D Assets for Games</h2>
                </div>
            </div>

            <div class="flex items-stretch text-center font-bold">
                <router-link to="/" exact class="tab" active-class="tab-active">
                    <p>Concept Art/Illustration</p>
                </router-link>

                <router-link to="/3d-art" class="tab" active-class="tab-active">
                    <p>3D Art</p>
                </router-link>
            </div>
        </header>

        <!-- I load them both in so the tab switching is instant, but I'm wondering if the component is cached -->
        <!-- If the component is cached, I could load just one image gallery (saving bandwith), and the tab switching would still be instant like I wanted -->
        <!-- The first tab switch wouldn't be instant, but any switch after that would be -->
        <div class="p-6">
            <image-gallery type="Concept Art" tab="concept-art" v-show="currentTab == 'concept-art'"></image-gallery>

            <image-gallery type="3D Art" tab="3d-art" v-show="currentTab == '3d-art'"></image-gallery>
        </div>

        <!-- Project modal -->
        <!-- So this is interesting. I'm using v-if, but the component is not destroyed if I return to the home page. I thought v-if destroyed the component. -->
        <div v-if="projectId">
            <project-modal :id="projectId"></project-modal>
        </div>

    </div>

</template>

<script>
import SocialLinks from '../components/SocialLinks.vue';
import ImageGallery from '../components/ImageGallery.vue';
import ProjectModal from '../components/ProjectModal.vue';

export default {
    name: 'Portfolio',

    components: {
        ImageGallery, ProjectModal, SocialLinks
    },

    data() {
        return {

        }
    },

    computed: {
        currentTab() {
            // I wanted different url's for each tab that wasn't a #tag or ?query string. However, I wanted to keep my setup where the image galleries are turned on and off with v-show as you switch tabs. 
            // That way the browser loads all the images at once instead of loading a different image gallery each time you change the tab. It's a bigger performance load at the start, but makes switching tabs instant.
            // To do this, I made a new route '/3d-art' that loads this page just like the home page does, but I check whether the route has been set to 3d-art. If it is, I want the 3d art image gallery to show.
            // Now I have unique links for each gallery, and instant tab switching
            if(this.$route.path.includes("/3d-art")) {
                return '3d-art';
            } else {
                return 'concept-art';
            }
        },

        projectId() {
            // I believe I have to have these parameters in the computed or watched properties
            // The Portfolio component is being reused across any project page, so it needs to know that the route has changed, and update these values
            return this.$route.params.projectId;
        },

        tab() {
            return this.$route.params.tab;
        }
    },
}
</script>

<style scoped>
.banner {
    overflow: hidden;
    height: 31vw;
}

.banner img {
    position: relative;
    object-fit: cover;
    top: -1vw;
    z-index: 0;
}

.header-content {
    display: flex; 
    flex-direction: column;
}

.header-text {
    padding: .5rem;
    text-align: center;
    @apply border-b;
}

.social-links {
    display: flex;
    justify-content: center;
    padding: 1rem 0;
    font-size: 1.4rem;
    order: 2;
    @apply border-b;
}

.tab {
    text-align: center;
    width: 50%;
    cursor: pointer;
    padding: 1rem 0;
    border-bottom-width: 4px; 
    @apply border-orange-200; 
}

.tab:hover {
    @apply bg-gray-300;
    @apply border-orange-300;
    border-bottom-width: 8px;
}

.tab-active {
    @apply bg-gray-300;
    @apply border-orange-300;
    border-bottom-width: 8px;
}

@media screen and (min-width: 426px) {
    .banner {
        height: 25vw;
    }

    .banner img {
        top: -3vw;
    }
}

@media screen and (min-width: 1024px) {
    .banner {
        height: 18vw;
    }

    .banner img {
        top: -2vw;
    }

    .header-content {
        position: relative;
        @apply grid-cols-3
    }

    .header-text {
        padding: 2rem 0;
    }

    .social-links {
        position: absolute;
        top: 0;
        left: .5rem;
        font-size: 1.1rem;
        border-bottom-width: 0px;
        padding: .5rem 0;
    }
}

</style>