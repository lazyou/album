import request from '@/utils/http'

export function skinList(query) {
  return request({
    url: '/skin',
    method: 'get',
    params: query
  })
}

export function skinOptions() {
  return request({
    url: '/skin_options',
    method: 'get'
  })
}

export function skinDetail(id) {
  return request({
    url: `/skin/${id}`,
    method: 'get'
  })
}

export function updateSkin(id, data) {
  return request({
    url: `/skin/${id}`,
    method: 'post',
    data
  })
}
