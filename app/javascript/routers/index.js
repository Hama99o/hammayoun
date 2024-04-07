import { createRouter, createWebHistory } from "vue-router";
const Index = () => import('@/views/Home.vue');
const About = () => import('@/views/AboutPage.vue');
const Login = () => import('@/views/LoginPage.vue');
const Logout = () => import('@/views/Logout.vue');
const Signup = () => import('@/views/SignupPage.vue');
const Users = () => import('@/views/users/Index.vue');

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
    path: '/users',
    name: 'users',
    components: {
      default: Users,
    },
  },
  {
    path: '/logout',
    name: 'logout',
    components: {
      default: Logout,
    },
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;


