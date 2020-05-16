<template>
  <div class="text-center">

    <div class="header">
      <div class="bg-white shadow-lg p-4">
        <h1>About Me</h1>
        <hr class="w-64 mx-auto my-2 border-black">
      </div>
    </div>

      <p class="about-content">I am a digital artist from South Dakota. I graduated from Dakota State University with a Bachelor of Science in Computer Game Design in May 2018. 
      I have a passion for games as an art form. I believe the experiences games provide can connect with people on a level no other medium can match. 
      I want to use my art to help create new memorable experiences for all sorts of players.</p>

  </div>
</template>

<script>
export default {
  name: "About"
}
</script>

<style scoped>
.header {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 200px;
  @apply bg-gray-400;
}

.about-content {
  width: 80%;
  margin: 0 auto;
  padding: 3rem 0;
}
</style>
