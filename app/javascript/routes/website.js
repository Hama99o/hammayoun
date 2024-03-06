import { createRouter, createWebHistory } from "vue-router";
const MyPortfolio = () => import('@/pages/website/MyPortfolio.vue');
const Index = () => import('@/pages/website/IndexPage.vue');
const About = () => import('@/pages/website/AboutPage.vue');
const Login = () => import('@/pages/website/LoginPage.vue');
const Signup = () => import('@/pages/website/SignupPage.vue');
// import PersonalProfile from '@/components/portfolio/PersonalProfile.vue'

const routes = [
  {
    path: '/',
    name: 'portfolio',
    components: {
      default: MyPortfolio,
    },
  },
  {
    path: '/app',
    name: 'index',
    component: Index,
    children: [
      {
        path: '',
        name: 'PersonalProfile',
        // component: PersonalProfile
      },
    ],
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
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
