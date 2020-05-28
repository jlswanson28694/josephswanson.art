<template>
  <div id="app" class="app bg-gray-200 flex flex-col justify-between" :class="{'h-screen overflow-hidden' : $route.params.projectId}">
  <!-- I'm setting the screen to overflow hidden when displaying a project so the scrollbar doesn't appear -->
  
      <div>
        <the-navbar></the-navbar>
        <router-view class="page-content"/>
      </div>

      <the-footer></the-footer>
  </div>
</template>

<script>
import TheNavbar from './components/TheNavbar.vue';
import TheFooter from './components/TheFooter.vue';
export default {
  name: "App",

  components: { TheNavbar, TheFooter },
}
</script>

<style>
.app {
  min-height: 100vh;
  max-width: 100vw;
  font-family: 'Roboto', sans-serif;
}

h1 {
  font-family: 'Lobster', cursive;
  font-size: 2.5rem !important;
}

.page-content {
    width: 100%;
    margin: 0 auto;
    background-color: white;
    @apply shadow-lg;
}

@media screen and (min-width: 1024px) {
    .page-content {
        width: 60vw;
    }
}

</style>
