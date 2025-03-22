<template>
  <div>
    <h1>Network Monitoring</h1>
    <!-- 父容器，固定高度，允许子容器横向滚动 -->
    <div class="table-wrapper">
      <div class="table-container">
        <table v-if="netData.length">
          <thead>
            <tr>
              <th>Source</th>
              <th>Destination</th>
              <th>Process</th>
              <th>Upload</th>
              <th>Download</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in netData" :key="index">
              <td>{{ item.src }}</td>
              <td>{{ item.dst }}</td>
              <td>{{ item.process || 'N/A' }}</td>
              <td>{{ item.upload }} KB/s</td>
              <td>{{ item.download }} KB/s</td>
            </tr>
          </tbody>
        </table>
        <p v-else>No data available</p>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue';
import axios from 'axios';

export default {
  setup() {
    const netData = ref([]);
    let interval;

    const fetchData = async () => {
      try {
        const response = await axios.get('/api');
        netData.value = response.data;
      } catch (error) {
        console.error('Failed to fetch data:', error);
      }
    };

    // 自动刷新数据
    onMounted(() => {
      fetchData(); // 页面加载时获取一次数据
      interval = setInterval(fetchData, 2000); // 每5秒钟刷新一次数据
    });

    // 清理定时器
    onUnmounted(() => {
      clearInterval(interval);
    });

    return { netData };
  },
};
</script>

<style scoped>
.table-wrapper {
  width: 100%;
  max-height: 70vh; /* 固定高度 */
  overflow-y: auto; /* 允许纵向滚动 */
}

.table-container {
  width: 100%;
  overflow-x: auto; /* 允许横向滚动 */
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

th {
  background-color: #f4f4f4;
  font-weight: bold;
}
</style>
