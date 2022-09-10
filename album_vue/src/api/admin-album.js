import request from '@/utils/http'

export function albumList(query) {
  return request({
    url: '/album',
    method: 'get',
    params: query
  })
}

export function albumDetail(id) {
  return request({
    url: `/album/${id}`,
    method: 'get'
  })
}

export function updateAlbum(id, data) {
  return request({
    url: `/album/${id}`,
    method: 'post',
    data
  })
}
