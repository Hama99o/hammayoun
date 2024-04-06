import { createRouter, createWebHistory } from "vue-router";
const Index = () => import('@/pages/unconnected_user/IndexPage.vue');
const About = () => import('@/pages/unconnected_user/AboutPage.vue');
const Login = () => import('@/pages/unconnected_user/LoginPage.vue');
const Signup = () => import('@/pages/unconnected_user/SignupPage.vue');
const Users = () => import('@/layouts/connected_user/users/Index.vue');
const Panel = () => import('@/pages/connected_user/IndexPage.vue');

// import PersonalProfile from '@/components/portfolio/PersonalProfile.vue'

const routes = [
  {
    path: '/',
    name: 'index',
    components: {
      default: Index,
    },
  },
  {
    path: '/about',
    name: 'about',
    components: {
      default: About,
    },
  },
  {
    path: '/login',
    name: 'login',
    components: {
      default: Login,
    },
  },
  {
    path: '/signup',
    name: 'signup',
    components: {
      default: Signup,
    },
  },
  {
    path: '/panel/users',
    name: 'users',
    components: {
      default: Users,
    },
  },
  {
    path: '/panel',
    name: 'Panel',
    components: {
      default: Panel,
    },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;


