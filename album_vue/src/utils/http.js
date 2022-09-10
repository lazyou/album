import axios from 'axios'
import { MessageBox, Message } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'

// create an axios instance
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_ADMIN_API, // url = base url + request url
  // withCredentials: true, // send cookies when cross-domain requests
  timeout: 5000 // request timeout
})

// request interceptor
service.interceptors.request.use(
  config => {
    // do something before request is sent

    if (store.getters.token) {
      // let each request carry token
      // ['X-Token'] is a custom headers key
      // please modify it according to the actual situation
      const token = getToken()
      config.headers['Authorization'] = `Bearer ${token}`
    }

    return config
  },
  error => {
    // do something with request error
    console.log('http.js request error:') // for debug
    console.log(error) // for debug
    return Promise.reject(error)
  }
)

// response interceptor
service.interceptors.response.use(
  /**
   * If you want to get http information such as headers or status
   * Please return  response => response
  */

  /**
   * Determine the request status by custom code
   * Here is just an example
   * You can also judge the status by HTTP Status Code
   */
  response => {
    // console.log('http.js response response:')
    // console.log(response)
    const res = response.data

    // 根据 http 状态码来判定接口情况
    if (response.status > 204) {
      Message({
        message: res.message || 'Error',
        type: 'error',
        duration: 5 * 1000
      })

      // 50008: Illegal token; 50012: Other clients logged in; 50014: Token expired;
      // TODO: 待调整
      if (res.code === 50008 || res.code === 50012 || res.code === 50014) {
        // to re-login
        MessageBox.confirm('You have been logged out, you can cancel to stay on this page, or log in again', 'Confirm logout', {
          confirmButtonText: 'Re-Login',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          store.dispatch('user/resetToken').then(() => {
            location.reload()
          })
        })
      }

      return Promise.reject(new Error(res.message || 'Error'))
    } else {
      return res
    }
  },
  error => {
    // console.log('http.js response error:')
    // console.log(error) // TODO: 打印出来不是一个对象, 太坑了...
    // console.log(error.response) // TODO: 只有这样才能访问到 400 错误响应的数据

    let message = error.message
    const response = error.response

    if (response.status === 401) {
      window.location.href = '/login'
    }

    if (response.status === 400 && response.data) {
      message = response.data.message
    }

    Message({
      message: message,
      type: 'error',
      duration: 5 * 1000
    })

    return Promise.reject(error)
  }
)

export default service
