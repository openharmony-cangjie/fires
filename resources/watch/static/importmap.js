const im = document.createElement("script");
im.type = "importmap";

// 这里模拟node工程引用, 优先使用esm
im.textContent = JSON.stringify({
  imports: {
    "@/": "./",
    vue: "./modules/vue.js",
    request: "./static/request.js",
    "element-plus": "./modules/element-plus.js",
    "@element-plus/icons-vue":
      "https://unpkg.com/@element-plus/icons-vue@2.3.1/dist/index.js",
    "vue-router":
      "https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-M/vue-router/4.0.13/vue-router.esm-browser.min.js",
    "@vue/devtools-api":
      "https://unpkg.com/@vue/devtools-api@6.6.1/lib/esm/index.js",
    "vue3-sfc-loader":
      "https://unpkg.com/vue3-sfc-loader/dist/vue3-sfc-loader.esm.js",
  },
});
document.currentScript.after(im);
