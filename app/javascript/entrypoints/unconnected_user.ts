import {createApp} from "vue";
import App from '@/layouts/unconnected_user/MainLayout.vue';
import {registerPlugins} from "@/plugins/index.js";
import '@/assets/css/panel.scss';

const app = createApp(App);

// plugins
registerPlugins(app)
app.mount("#app");