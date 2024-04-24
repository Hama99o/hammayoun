import { createRouter, createWebHistory } from "vue-router";
import AuthService from '@/services/auth.service';

const Index = () => import('@/views/Home.vue');
const About = () => import('@/views/AboutPage.vue');
const Login = () => import('@/views/LoginPage.vue');
const ForgetPassword = () => import('@/views/ForgetPassword.vue');
const ResetPassword = () => import('@/views/ResetPassword.vue');

const Logout = () => import('@/views/Logout.vue');
const Signup = () => import('@/views/SignupPage.vue');
const Users = () => import('@/views/users/Index.vue');
const UserShow = () => import('@/views/users/Show.vue');
const UserEdit = () => import('@/views/users/Edit.vue');

// Note App imports
const Notes = () => import('@/views/note_app/notes/Index.vue');


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
    path: '/forget_password',
    name: 'forget_password',
    components: {
      default: ForgetPassword,
    },
  },
  {
    path: '/reset_password',
    name: 'reset_password',
    components: {
      default: ResetPassword,
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
  },
  {
    path: "/note_app/notes",
    name: 'notes',
    components: {
      default: Notes
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


