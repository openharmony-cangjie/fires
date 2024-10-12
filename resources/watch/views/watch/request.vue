<template>
  <el-table :data="tableData" style="width: 100%">
    <el-table-column prop="id" label="id" width="80" />
    <el-table-column prop="method" label="method" width="100" />
    <el-table-column prop="decodedUri" label="URI">
      <template #default="scope">
        {{ decodeUri(scope.row.uri) }}
      </template>
    </el-table-column>
    <el-table-column prop="status" label="status" width="80" />
  </el-table>
</template>

<script lang="ts" setup>
import { ref } from "vue";
import { get } from "request";

const tableData = ref([]);

get("/show/request").then((res: any) => {
  tableData.value = res.list;
});

function decodeUri(encodedUri: string): string {
  return decodeURIComponent(encodedUri);
}
</script>
