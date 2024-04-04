import { VueQueryPlugin } from 'vue-query';
import { pinia } from '@/stores';
import { setHTTPHeader } from '@/services/http.service';
import AuthService from '@/services/auth.service';
import i18n from "@/plugins/i18n.js";
import router from "@/routes/website.js";
import { showToast } from '@/utils/showToast';
// import BootstrapVue from 'bootstrap-vue'; // Uncomment this line
// import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import jQuery from 'jquery'

window.$ = window.jQuery = jQuery;
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';
export const globalProperties = {
  $showToast: showToast,
};

// STYLES
import '@/assets/css/style.scss';

const token = AuthService.getToken();

if (token) {
  setHTTPHeader({ Authorization: token });
}

export const registerPlugins = (app) => {
  app.use(router);
  app.use(pinia);
  app.use(VueQueryPlugin);
  app.use(i18n);
  // app.use(BootstrapVue)
  // Make BootstrapVue available throughout your project
  // app.use(BootstrapVue)
  // Optionally install the BootstrapVue icon components plugin
  // app.use(IconsPlugin)
  app.config.globalProperties = { ...app.config.globalProperties, ...globalProperties };
};
