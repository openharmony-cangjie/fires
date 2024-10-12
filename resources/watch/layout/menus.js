export default {
    props: ['isCollapse'],
    computed: {
        routes() {
            return this.$router.options.routes
        },
    },
    template: `
<el-scrollbar wrap-class="scrollbar-wrapper">
    <el-menu
        active-text-color="#ffd04b"
        background-color="#304156"
        class="el-menu-vertical-demo"
        text-color="#fff"
        :collapse="isCollapse"
        :collapse-transition="false"
        :router="true"
    >
      <div v-for="item in routes">
        <div v-if="!item.hidden">
          <el-sub-menu :index="item.path" :key="item.path" :index="item.path">
            <template #title>
              <el-icon>
                <component :is="item.meta.icon"/>
              </el-icon>
              <span v-if="!isCollapse">{{ item.name }}</span>
            </template>
            <div v-if="item.children">
                <el-menu-item v-for="child in item.children" :index="child.path" :index="child.path">
                  <el-icon>
                    <component :is="child.meta.icon"/>
                  </el-icon>
                  <span>{{ child.meta.title }}</span>
                </el-menu-item>
            </div>
          </el-sub-menu>
        </div>
      </div>
    </el-menu>
  </el-scrollbar>`,
}
