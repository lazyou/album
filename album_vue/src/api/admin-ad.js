import request from '@/utils/http'

export function adList(query) {
  return request({
    url: '/ad',
    method: 'get',
    params: query
  })
}

export function adDetail(id) {
  return request({
    url: `/ad/${id}`,
    method: 'get'
  })
}

export function updateAd(id, data) {
  return request({
    url: `/ad/${id}`,
    method: 'post',
    data
  })
}

export function deleteAd(id) {
  return request({
    url: `/ad/${id}`,
    method: 'delete'
  })
}
