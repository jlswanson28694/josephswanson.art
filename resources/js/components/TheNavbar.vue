<template>
    <nav class="bg-black text-white">
        <div class="grid grid-cols-3">
            <div class="invisible lg:visible flex col-start-2 col-span-1 items-center justify-center">
                <router-link to="/" class="navbar-link" :class="{'bg-gray-800' : portfolioActive}" exact>Portfolio</router-link>
                <a href="https://docs.google.com/document/d/13AYspkAHKvTgH9T-o5F-ev5tyaNkn4UV1X0-rBE_aQw/edit" target="_blank" class="navbar-link">Resume</a>
                <router-link to="/about" class="navbar-link" active-class="bg-gray-800">About</router-link>
            </div>

            <div class="flex lg:hidden col-start-3 col-span-1 items-center justify-end m-2">
                <i class="fas fa-bars align-middle p-3 rounded-lg hover:bg-gray-800" @click="toggleLinks()"></i>
            </div>
        </div>
        <div class="absolute w-full block lg:hidden text-center bg-gray-900 z-10" v-if="displayLinks" @click="toggleLinks()">
            <router-link to="/" class="navbar-link" :class="{'bg-gray-800' : portfolioActive}" exact>Portfolio</router-link>
            <a href="https://docs.google.com/document/d/13AYspkAHKvTgH9T-o5F-ev5tyaNkn4UV1X0-rBE_aQw/edit" target="_blank" class="navbar-link">Resume</a>
            <router-link to="/about" class="navbar-link" active-class="bg-gray-800">About</router-link>
        </div>
    </nav>
</template>

<script>
export default {
    name: "TheNavbar",

    data() {
        return {
            displayLinks: false,
        }
    },

    computed: {
        portfolioActive() {
            // Almost all pages on this site are part of the portfolio page. So, I want the portfolio link to be styled as if it is active for every page but the about page
            if(this.$route.path == '/about') {
                return false;
            } else {
                return true;
            }
        }
    },

    methods: {
        toggleLinks() {
            this.displayLinks = !this.displayLinks;
        },
    },
}
</script>

<style scoped>
.navbar-link {
    display: block;
    padding: 1rem 1.5rem;
}

.navbar-link:hover {
    /* I use Tailwind @apply when I want to reference a Tailwind preset color without looking up the exact hex code. I also use it when the Tailwind class is significantly cleaner, like when setting up a grid */
    @apply bg-gray-800;
}

</style>