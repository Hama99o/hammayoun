import {createApp} from "vue";
import App from '@/layouts/website/MainLayout.vue';
import {registerPlugins} from "@/plugins/index.js";

const app = createApp(App);

// plugins
registerPlugins(app)
app.mount("#app");