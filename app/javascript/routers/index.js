import { createRouter, createWebHistory } from "vue-router";
import AuthService from '@/services/auth.service';

const Index = () => import('@/views/Home.vue');
const About = () => import('@/views/AboutPage.vue');
const Login = () => import('@/views/LoginPage.vue');
const Logout = () => import('@/views/Logout.vue');
const Signup = () => import('@/views/SignupPage.vue');
const Users = () => import('@/views/users/Index.vue');
const UserShow = () => import('@/views/users/Show.vue');
const UserEdit = () => import('@/views/users/Edit.vue');

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
    path: '/users/:id',
    name: 'user',
    components: {
      default: UserShow,
    },
  },
  {
    path: '/users/:id/edit',
    name: 'user_edit',
    components: {
      default: UserEdit,
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

router.beforeEach(async (to, from, next) => {
  const user = AuthService.getUser();

  if (to.path.split('/').includes('login') && user) {
    next('/');
  } else {
    next();
  }

});

export default router;


