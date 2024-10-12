import { defineAsyncComponent } from "vue";
import { createRouter, createWebHashHistory } from "vue-router";
import Layout from "@/layout/main.js";

export const routes = [
  {
    path: "/404",
    component: () => import("@/views/404.vue"),
    hidden: true,
  },

  {
    path: "/",
    name: "Dashboard",
    meta: { title: "Dashboard", icon: "help" },
    component: Layout,
    redirect: "/dashboard",
    children: [
      {
        path: "/dashboard",
        component: () => import("@/views/dashboard/index.vue"),
        meta: { title: "Dashboard", icon: "House" },
      },
    ],
  },

  {
    path: "/watch",
    name: "开发监控",
    meta: { icon: "Tools" },
    component: Layout,
    children: [
      {
        path: "/watch/request",
        component: () => import("@/views/watch/request.vue"),
        meta: { title: "request", icon: "House" },
      },
    ],
  },

  {
    path: "/Devtools",
    name: "工具箱",
    meta: { icon: "Stopwatch" },
    component: Layout,
    children: [
      {
        path: "/devtools/musql",
        component: () => import("@/views/devtools/table.vue"),
        meta: { title: "musql", icon: "FirstAidKit" },
      },
      {
        path: "/devtools/redis",
        component: () => import("@/views/devtools/redis.vue"),
        meta: { title: "Redis", icon: "Memo" },
      },
    ],
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
