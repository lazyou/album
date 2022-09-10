<template>
  <div v-loading="listLoading" class="app-container">
    <el-form ref="ruleForm" :model="ruleForm" :rules="rules" label-width="100px" class="demo-ruleForm">
      <el-form-item label="排序" prop="displayorder">
        <el-input v-model="ruleForm.displayorder" type="number" />
      </el-form-item>

      <el-form-item label="模板缩略图" prop="thumb">
        <Upload v-model="ruleForm.thumb" />
      </el-form-item>

      <el-form-item label="广告位置" prop="weizhi">
        <el-radio-group v-model="ruleForm.weizhi">
          <el-radio :label="0">小程序列表</el-radio>
          <el-radio :label="1">首页漂浮</el-radio>
          <el-radio :label="2">影集页面漂浮1</el-radio>
          <el-radio :label="3">影集页面漂浮2</el-radio>
          <el-radio :label="4">首页幻灯片(可多个)</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="广告类型" prop="istype">
        <el-radio-group v-model="ruleForm.istype">
          <el-radio :label="0">跳转小程序</el-radio>
          <el-radio :label="1">内嵌网页</el-radio>
        </el-radio-group>
        <p style="color: #999; margin-top:-10px; font-size:12px;">注意：首页漂浮全局只能设置一个，影集页面只能设置两个，过多设置无效。</p>
      </el-form-item>

      <el-form-item label="标题" prop="title">
        <el-input v-model="ruleForm.title" />
      </el-form-item>

      <el-form-item label="介绍" prop="text">
        <el-input v-model="ruleForm.text" />
      </el-form-item>

      <el-form-item v-show="ruleForm.istype === 0" label="appid" prop="appid">
        <el-input v-model="ruleForm.appid" />
      </el-form-item>

      <el-form-item v-show="ruleForm.istype === 1" label="跳转路径" prop="path">
        <el-input v-model="ruleForm.path" />
        <p style="color: #999; margin-top:-10px; font-size:12px;">内嵌网页时在此添加链接地址，开头需加：http</p>
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
import { adDetail, updateAd } from '@/api/admin-ad'

export default {
  components: { Upload },
  data() {
    return {
      dialogImageUrl: '',
      dialogVisible: false,
      listLoading: false,
      id: 0,
      ruleForm: {
        displayorder: 1,
        thumb: '',
        weizhi: 0,
        istype: 0,
        title: '',
        text: '',
        appid: '',
        path: ''
      },
      rules: {}
    }
  },
  computed: {
  },
  created() {
    this.id = this.$route.params.id
    if (this.id > 0) {
      this.getDetail(this.id)
    }
  },
  methods: {
    getDetail(id) {
      this.listLoading = true
      adDetail(id).then(response => {
        this.ruleForm = response
        this.listLoading = false
      })
    },

    submitForm(formName) {
      this.listLoading = true
      updateAd(this.id, this.ruleForm).then(response => {
        this.$router.push('/ad/index')
      }).finally(() => {
        this.listLoading = false
      })
    }
  }
}
</script>
