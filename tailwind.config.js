module.exports = {
  purge: {
    content: [
      './resources/js/App.vue',
      './resources/js/views/About.vue',
      './resources/js/views/NotFound.vue',
      './resources/js/views/Portfolio.vue',
      './resources/js/components/ImageGallery.vue',
      './resources/js/components/ProjectModal.vue',
      './resources/js/components/SocialLinks.vue',
      './resources/js/components/TheFooter.vue',
      './resources/js/components/TheNavbar.vue',
    ],

    options: {
      whitelist: ['text-black', 'text-white', 'bg-black', 'bg-white'],
    }
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
}
