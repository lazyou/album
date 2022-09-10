import http from '@/utils/http'

/**
 * @param data 一般传入 name, size, type. 后来后台api生成 key -- 或者不传前面三个参数,直接传入key.
 * @returns {AxiosPromise}
 */
export function getToken(data) {
  return http({
    url: '/qiniu/token', // 假地址 自行替换
    method: 'post',
    data
  })
}
