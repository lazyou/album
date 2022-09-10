import request from '@/utils/http'

export function initSetting(query) {
  return request({
    url: '/setting',
    method: 'get',
    params: query
  })
}

export function updateSetting(data) {
  return request({
    url: '/setting',
    method: 'post',
    data
  })
}
