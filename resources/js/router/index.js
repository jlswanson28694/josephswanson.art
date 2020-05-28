import Vue from 'vue'
import VueRouter from 'vue-router'
import Portfolio from '../views/Portfolio.vue'
import About from '../views/About.vue'
import NotFound from '../views/NotFound.vue'

Vue.use(VueRouter)

const routes = {
    mode: 'history',

    routes: [
        {
            path: '*',
            name: 'NotFound',
            component: NotFound
        },

        {
            path: '/',
            name: 'Portfolio',
            component: Portfolio
          },
      
          {
            path: '/3d-art',
            name: '3D Art',
            component: Portfolio
          },
      
          {
            path: '/:tab/project/:projectId',
            name: 'Project',
            component: Portfolio
          },
      
          {
            path: '/about',
            name: 'About',
            component: About
          },
    ],

    scrollBehavior (to, from, savedPosition) {
      if (savedPosition) {
        return savedPosition
      } else {
        return { x: 0, y: 0 }
      }
    }
}

const router = new VueRouter(routes)

export default router
