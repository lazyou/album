<template>
  <div class="qiniu-multi-image">
    <el-upload
      :data="dataObj"
      action="https://up-z2.qiniup.com"
      list-type="picture-card"
      :before-upload="handleBeforeUpload"
      :on-success="handleImageSuccess"
      :on-preview="handlePreview"
      :before-remove="handleBeforeRemove"
      :on-remove="handleRemove"
      accept="image/*"
      :file-list="fileList"
    >
      <i class="el-icon-plus" />
    </el-upload>

    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>
  </div>
</template>

<script>
import { getToken } from '@/api/admin-qiniu'

export default {
  name: 'SingleImageUpload2',
  props: {
    value: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      dialogImageUrl: '',
      dialogVisible: false,
      tempUrl: '',
      dataObj: { token: '', key: '' }
    }
  },
  computed: {
    images() {
      return this.value
    },
    fileList() {
      const list = []
      this.value.forEach(image => {
        list.push({
          name: 'xx',
          url: image
        })
      })

      return list
    }
  },
  methods: {
    handleBeforeRemove() {
      return this.$confirm('是否继续删除该文件?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
    },
    emitImages(fileList) {
      const images = []
      fileList.forEach(image => {
        images.push(image.url)
      })
      this.$emit('input', images)
    },
    handleRemove(file, fileList) {
      this.emitImages(fileList)
    },
    handlePreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    handleBeforeUpload(file) {
      const fileInfo = {
        name: file.name,
        size: file.size,
        type: file.type
      }
      const _self = this
      return new Promise((resolve, reject) => {
        getToken(fileInfo).then(response => {
          _self._data.dataObj.token = response.token
          _self._data.dataObj.key = response.key
          this.tempUrl = response.url
          resolve(true)
        }).catch(() => {
          reject(false)
        })
      })
    },
    handleImageSuccess(response, file, fileList) {
      console.log('handleImageSuccess:')
      const len = fileList.length
      if (len) {
        fileList[len - 1].url = this.tempUrl
        console.log('fileList:')
        console.log(fileList)
        this.emitImages(fileList)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
