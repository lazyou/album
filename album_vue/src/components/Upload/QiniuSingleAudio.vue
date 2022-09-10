<template>
  <div class="singleAudioUpload upload-container">
    <el-upload
      :data="dataObj"
      :multiple="false"
      :show-file-list="false"
      :before-upload="beforeUpload"
      :on-success="handleImageSuccess"
      class="image-uploader"
      action="https://up-z2.qiniup.com"
      accept="audio/mp3"
      drag
    >
      <i v-if="!audioUrl" class="el-icon-upload" />
      <div v-if="!audioUrl" class="el-upload__text">
        Drag或<em>点击上传</em>
      </div>
    </el-upload>
    <div v-show="audioUrl.length>0" class="image-preview">
      <div v-show="audioUrl.length>1" class="image-preview-wrapper">
        <audio :src="audioUrl" preload="none" controls="controls" style="width: 100%;">
          Your browser does not support the audio tag.
        </audio>
        <div class="image-delete-action">
          <i class="el-icon-delete" style="margin-top: 10%;" @click="rmImage" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/**
 * 音频上传组件
 */
import { getToken } from '@/api/admin-qiniu'

export default {
  name: 'SingleAudioUpload',
  props: {
    value: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      tempUrl: '',
      dataObj: { token: '', key: '' }
    }
  },
  computed: {
    audioUrl() {
      return this.value
    }
  },
  methods: {
    rmImage() {
      this.$confirm('是否继续删除该文件?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.emitInput('')
      })
    },
    emitInput(val) {
      this.$emit('input', val)
    },
    handleImageSuccess() {
      this.emitInput(this.tempUrl)
    },
    beforeUpload(file) {
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
    }
  }
}
</script>

<style lang="scss" scoped>
  .upload-container {
    width: 100%;
    height: 100%;
    position: relative;
    .image-uploader {
      height: 100%;
    }
    .image-preview {
      width: 100%;
      height: 100%;
      position: absolute;
      left: 0px;
      top: 0px;
      .image-preview-wrapper {
        position: relative;
        width: 100%;
        height: 100%;
        margin-top: 10%;
        img {
          width: 100%;
          height: 100%;
        }
      }
      .image-delete-action {
        position: absolute;
        width: 100%;
        height: 44%;
        left: 0;
        cursor: default;
        text-align: center;
        color: #fff;
        opacity: 0;
        font-size: 20px;
        background-color: rgba(0, 0, 0, .5);
        transition: opacity .3s;
        cursor: pointer;
        text-align: center;
        .el-icon-delete {
          font-size: 36px;
        }
      }
      &:hover {
        .image-delete-action {
          opacity: 1;
        }
      }
    }
  }
</style>
