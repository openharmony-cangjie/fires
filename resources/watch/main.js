import ElementPlus from "element-plus";
import { createApp, ref, defineAsyncComponent } from "vue";
import LayoutSidebar from "./layout/sidebar.js";
import LayoutUserMenu from "./layout/user-menu.js";
import LayoutMenus from "./layout/menus.js";
import route from "./route.js";
import * as ElementPlusIconsVue from "@element-plus/icons-vue";

const app = createApp({
  components: {
    LayoutSidebar,
    LayoutUserMenu,
    LayoutMenus,
  },
  setup() {
    return {
      isCollapse: ref(false),
    };
  },
});

app.use(route);
app.use(ElementPlus);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}
app.mount("#app");
