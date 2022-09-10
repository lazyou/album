<template>
  <div class="app-container">
    <el-form ref="ruleForm" :model="ruleForm" :rules="rules" label-width="100px" class="demo-ruleForm">
      <el-form-item label="所属用户ID" prop="uid">
        <el-input v-model="ruleForm.uid" :disabled="isDisabled" />
      </el-form-item>

      <el-form-item label="标题" prop="title">
        <el-input v-model="ruleForm.title" />
      </el-form-item>

      <el-form-item label="头像" prop="avatar">
        <Upload v-model="ruleForm.avatar" :disabled="isDisabled" />
      </el-form-item>

      <el-form-item label="昵称" prop="nickname">
        <el-input v-model="ruleForm.nickname" :disabled="isDisabled" />
      </el-form-item>

      <!--      ajax 获取-->
      <el-form-item label="选择模板" prop="skin">
        <el-select v-model="ruleForm.skin" filterable placeholder="请选择选择模板">
          <el-option
            v-for="skin in this.skins"
            :key="skin.id"
            filterable
            :label="skin.title"
            :value="skin.id"
          />
        </el-select>
      </el-form-item>

      <el-form-item label="背景音乐" prop="music">
        <el-input v-model="ruleForm.music" />
        <p style="color: #999; margin-top:-10px; font-size:12px;">不填则自动从模板中获取背景音乐. 有填写音乐链接(从音乐管理获取)则覆盖模板音乐.</p>
      </el-form-item>

      <el-form-item label="影集属性" prop="ishot">
        <el-radio-group v-model="ruleForm.ishot">
          <el-radio :label="0">普通</el-radio>
          <el-radio :label="1">热门</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="影集属性" prop="status">
        <el-radio-group v-model="ruleForm.status">
          <el-radio :label="0">正常</el-radio>
          <el-radio :label="1">禁止</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="缩略图" prop="thmb">
        <Upload v-model="ruleForm.thumb" />
      </el-form-item>

      <el-form-item label="影集图片" prop="imgdataArr">
        <QiniuMultiImage v-model="ruleForm.imgdataArr" />
      </el-form-item>

      <el-form-item label="文字信息" prop="txtdata">
        <el-input v-model="ruleForm.txtdata" />
      </el-form-item>

      <el-form-item label="访问量" prop="click">
        <el-input v-model="ruleForm.click" type="number" />
      </el-form-item>

      <el-form-item label="送花数" prop="best">
        <el-input v-model="ruleForm.best" type="number" />
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
// TODO: disabled 属性的支持
import Upload from '@/components/Upload/QiniuSingleImage2'
import QiniuMultiImage from '@/components/Upload/QiniuMultiImage'

import { albumDetail, updateAlbum } from '@/api/admin-album'
import { skinOptions } from '@/api/admin-skin'

export default {
  components: { Upload, QiniuMultiImage },
  data() {
    return {
      dialogImageUrl: '',
      dialogVisible: false,
      id: 0,
      ruleForm: {
        uid: 0,
        title: '',
        avatar: '',
        nickname: '',
        skin: undefined,
        ishot: 0,
        status: 0,
        music: '',
        thumb: '',
        txtdata: '',
        click: 0,
        best: 0,
        imgdataArr: []
      },
      skins: [],
      rules: {}
    }
  },
  computed: {
    isDisabled: function() {
      return this.id > 0
    }
  },
  created() {
    this.getSkins()
    this.id = this.$route.params.id
    if (this.id > 0) {
      this.getDetail(this.id)
    }
  },
  methods: {
    getDetail(id) {
      this.listLoading = true
      albumDetail(id).then(response => {
        this.ruleForm = response
        this.listLoading = false
      })
    },
    getSkins() {
      skinOptions().then(response => {
        this.skins = response
      })
    },
    handleRemove(file, fileList) {
      console.log('handleRemove:')
      console.log(file, fileList)
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.listLoading = true
          updateAlbum(this.id, this.ruleForm).then(response => {
            this.listLoading = false
            this.$message.success(response.message)
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    }
  }
}
</script>
