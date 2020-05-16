<template>
    <div class="bg-black p-4 text-white text-center">
        <p>{{ 'Connect:' }}</p>
        <div class="flex justify-center py-2 text-xl">
            <social-links button-color="white" icon-color="black"></social-links>
        </div>
    </div>
</template>

<script>
import SocialLinks from './SocialLinks.vue';
export default {
    name: 'TheFooter',

    components: {
        SocialLinks
    }
}
</script>

<style scoped>

</style>