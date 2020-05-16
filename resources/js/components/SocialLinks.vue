<template>
    <div class="flex" :class="'text-' + iconColor">
        <a href="mailto:joexswanson@gmail.com" target="_blank" class="far fa-envelope social-icon" :class="'bg-' + buttonColor"></a>
        <a href="https://www.artstation.com/josephswanson" target="_blank" class="fab fa-artstation social-icon" :class="'bg-' + buttonColor"></a>
        <a href="https://www.instagram.com/zenpheeart/" target="_blank" class="fab fa-instagram social-icon" :class="'bg-' + buttonColor"></a>
        <a href="https://twitter.com/Zenphee" target="_blank" class="fab fa-twitter social-icon" :class="'bg-' + buttonColor"></a>
        <a href="http://linkedin.com/in/joseph-swanson-2a2a22161" target="_blank" class="fab fa-linkedin social-icon" :class="'bg-' + buttonColor"></a>
    </div>
</template>

<script>
export default {
    name: "SocialLinks",

    props: {
        buttonColor: { default: 'black' },
        iconColor: { default: 'white' }
    },
}
</script>

<style scoped>

.social-icon {
    padding: .5rem;
    border-radius: 100%;
    margin: 0 .2rem;
}

</style>
