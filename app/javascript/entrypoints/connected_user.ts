
import {createApp} from "vue";
import App from '@/layouts/connected_user/MainLayout.vue';
import {registerPlugins} from "@/plugins/index.js";
import '@/assets/css/connected_user.scss';

const app = createApp(App);

// plugins
registerPlugins(app)
app.mount("#app");