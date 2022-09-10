import request from '@/utils/http'

export function userList(query) {
  return request({
    url: '/user',
    method: 'get',
    params: query
  })
}

export function updateUser(data) {
  return request({
    url: '/user',
    method: 'post',
    data
  })
}
