import request from '@/utils/http'

export function cateList(query) {
  return request({
    url: '/cate',
    method: 'get',
    params: query
  })
}

export function updateCate(data) {
  return request({
    url: '/cate',
    method: 'post',
    data
  })
}

export function deleteCate(id) {
  return request({
    url: `/cate/${id}`,
    method: 'delete'
  })
}
