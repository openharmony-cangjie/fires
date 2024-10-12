const apiConfig = {
  baseUrl: "http://127.0.0.1:8080", // 默认域名
  prefix: "/watch", // 默认前缀
};

const defaultHeaders = {
  "Content-Type": "application/json",
  // 可以根据需要添加其他默认头部
};

// 基础的请求封装函数
const request = (endpoint, options = {}) => {
  const url = `${apiConfig.baseUrl}${apiConfig.prefix}${endpoint}`;
  const config = {
    ...options,
    headers: {
      ...defaultHeaders,
      ...options.headers,
    },
  };

  return fetch(url, config)
    .then((response) => {
      if (!response.ok) {
        return response.text().then((errorText) => {
          throw new Error(
            `HTTP error! Status: ${response.status} - ${errorText}`
          );
        });
      }
      try {
        return response.json();
      } catch (error) {
        console.error("JSON parsing error:", error);
        throw error;
      }
    })
    .then((result) => {
      if (result.code == 0) {
        return result.data;
      } else if (result.msg !== undefined) {
        ElementPlus.ElMessage.error(result.msg);
        throw new Error(result.msg);
      }
      return result.data;
    });
};

// GET 请求封装
// try {
//    const data = await api.get('https://api.example.com/data');
//    console.log(data);
// } catch (error) {
//    console.error('GET request failed', error);
// }
const get = (endpoint, headers = {}) => {
  return request(endpoint, {
    method: "GET",
    headers,
  });
};

// POST 请求封装
const post = (endpoint, body = {}, headers = {}) => {
  return request(endpoint, {
    method: "POST",
    headers,
    body: JSON.stringify(body),
  });
};

// 文件上传封装
// 假设这里有一个文件对象
// const file = new File(['content'], 'example.txt', { type: 'text/plain' });
// upload(file);
const uploadFile = (endpoint, file, headers = {}) => {
  const formData = new FormData();
  formData.append("file", file);

  const config = {
    method: "POST",
    headers: {
      ...headers,
      // FormData 会自动设置合适的 Content-Type 头部
    },
    body: formData,
  };

  return fetch(`${apiConfig.baseUrl}${apiConfig.prefix}${endpoint}`, config)
    .then((response) => {
      if (!response.ok) {
        return response.text().then((errorText) => {
          throw new Error(
            `HTTP error! Status: ${response.status} - ${errorText}`
          );
        });
      }
      return response.json();
    })
    .catch((error) => {
      console.error("File upload error:", error.message);
      throw error;
    });
};

// 导出封装的请求函数
export { get, post, uploadFile };
