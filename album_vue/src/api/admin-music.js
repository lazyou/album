import request from '@/utils/http'

export function musicList(query) {
  return request({
    url: '/music',
    method: 'get',
    params: query
  })
}

export function updateMusic(data) {
  return request({
    url: '/music',
    method: 'post',
    data
  })
}

export function deleteMusic(id) {
  return request({
    url: `/music/${id}`,
    method: 'delete'
  })
}
