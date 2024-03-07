
import {createApp} from "vue";
import App from '@/layouts/panel/MainLayout.vue';
import {registerPlugins} from "@/plugins/index.js";
import '@/assets/css/panel.scss';

const app = createApp(App);

// plugins
registerPlugins(app)
app.mount("#app");