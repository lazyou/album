<template>
  <div v-loading="isLoading" class="app-container setting-container">
    <el-form ref="ruleForm" :model="ruleForm" :rules="rules" label-width="150px" label-position="left">
      <h3>基本设置</h3><el-divider />
      <el-form-item label="名称设置" prop="appname">
        <el-input v-model="ruleForm.appname" />
      </el-form-item>

      <el-form-item label="影集默认标题" prop="phototitle">
        <el-input v-model="ruleForm.phototitle" />
      </el-form-item>

      <el-form-item label="字幕位置" prop="zimu">
        <el-radio-group v-model="ruleForm.zimu">
          <el-radio :label="0">底部</el-radio>
          <el-radio :label="1">顶部</el-radio>
          <el-radio :label="2">独立字幕</el-radio>
        </el-radio-group>
        <p style="color: #999; margin-top:-10px; font-size:12px;">独立字幕抛离图片独立显示，顶部和底部则显示到图片上指定位置。</p>
      </el-form-item>

      <el-form-item label="头像框样式" prop="touxiang">
        <el-radio-group v-model="ruleForm.touxiang">
          <el-radio :label="1">红色样式</el-radio>
          <el-radio :label="2">新年样式</el-radio>
          <el-radio :label="3">细框样式</el-radio>
          <el-radio :label="4">VIP样式</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="默认分享标题" prop="sharetitle">
        <el-input v-model="ruleForm.sharetitle" />
      </el-form-item>

      <el-form-item label="默认分享图片" prop="shareimg" style="margin-bottom: 30px;">
        <QiniuSingleImage v-model="ruleForm.shareimg" />
      </el-form-item>

      <h3>影集展示页面设置</h3><el-divider />
      <el-form-item label="跳转首页按钮" prop="indexbtn">
        <QiniuSingleImage v-model="ruleForm.indexbtn" />
      </el-form-item>

      <el-form-item label="送花按钮" prop="flowerbtn">
        <QiniuSingleImage v-model="ruleForm.flowerbtn" />
      </el-form-item>

      <el-form-item label="分享群友按钮" prop="sharebtn">
        <QiniuSingleImage v-model="ruleForm.sharebtn" />
      </el-form-item>

      <el-form-item label="保存相册按钮" prop="savebtn">
        <QiniuSingleImage v-model="ruleForm.savebtn" />
      </el-form-item>

      <el-form-item label="制作按钮" prop="editbtn">
        <QiniuSingleImage v-model="ruleForm.editbtn" />
      </el-form-item>

      <el-form-item label="顶部提示按钮" prop="addapp">
        <QiniuSingleImage v-model="ruleForm.addapp" />
      </el-form-item>

      <el-form-item label="提示内容" prop="addapp1">
        <QiniuSingleImage v-model="ruleForm.addapp1" />
      </el-form-item>

      <h3>流量主设置</h3><el-divider />
      <el-form-item label="影集首页流量主代码" prop="llads">
        <el-input v-model="ruleForm.llads" />
      </el-form-item>

      <el-form-item label="我的页面流量主代码" prop="userllads">
        <el-input v-model="ruleForm.userllads" />
      </el-form-item>

      <el-form-item label="影集展示页面流量主代码" prop="albumllads">
        <el-input v-model="ruleForm.albumllads" />
      </el-form-item>

      <el-form-item label="模板页面流量主代码" prop="skinllads">
        <el-input v-model="ruleForm.skinllads" />
      </el-form-item>

      <el-form-item label="影集首页插屏广告" prop="albumads">
        <el-input v-model="ruleForm.albumads" />
      </el-form-item>

      <el-form-item label="影集页面插屏广告" prop="albumconads">
        <el-input v-model="ruleForm.albumconads" />
        <p style="color: #999; margin-top:-10px; font-size:12px;">影集内容页面插屏广告，不需要请留空，比较影响用户体验。</p>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
        <!--        <el-button @click="resetForm('ruleForm')">重置</el-button>-->
      </el-form-item>

    </el-form>
  </div>
</template>

<script>
import { initSetting, updateSetting } from '@/api/admin-setting'
import QiniuSingleImage from '@/components/Upload/QiniuSingleImage2'

export default {
  components: { QiniuSingleImage },
  data() {
    return {
      isLoading: false,
      ruleForm: {
        appname: '',
        phototitle: '打开看看，这是我做的影集',
        zimu: 0,
        touxiang: 0,
        sharetitle: '',
        shareimg: '',
        indexbtn: '',
        flowerbtn: '',
        sharebtn: '',
        savebtn: '',
        editbtn: '',
        addapp: '',
        addapp1: '',
        llads: '',
        userllads: '',
        albumllads: '',
        skinllads: '',
        albumads: '',
        albumconads: ''
      },
      rules: {
        appname: [
          { message: '请输入名称', trigger: 'blur' },
          { min: 3, max: 30, message: '长度在 3 到 30 个字符', trigger: 'blur' }
        ],
        phototitle: [
          { message: '请输入名称', trigger: 'blur' },
          { min: 3, max: 30, message: '长度在 3 到 30 个字符', trigger: 'blur' }
        ],
        // zimu: [
        //   { message: '请选择字幕位置', trigger: 'change' }
        // ],
        // touxiang: [
        //   { message: '请选择字头像框样式', trigger: 'change' }
        // ],
        sharetitle: [
          { message: '请输入默认分享标题', trigger: 'blur' }
        ],
        shareimg: [
          { message: '请输入默认分享图片', trigger: 'blur' }
        ],
        indexbtn: [
          { message: '请选择跳转首页按钮', trigger: 'blur' }
        ],
        flowerbtn: [
          { message: '请选择送花按钮', trigger: 'blur' }
        ],
        sharebtn: [
          { message: '请选择分享群友按钮', trigger: 'blur' }
        ],
        savebtn: [
          { message: '请选择保存相册按钮', trigger: 'blur' }
        ],
        editbtn: [
          { message: '请选择制作按钮', trigger: 'blur' }
        ],
        addapp: [
          { message: '请选择顶部提示按钮', trigger: 'blur' }
        ],
        addapp1: [
          { message: '请选择提示内容', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.init()
  },
  methods: {
    init() {
      this.isLoading = true
      initSetting().then(resp => {
        this.ruleForm = resp
        this.isLoading = false
      })
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.isLoading = true
          updateSetting(this.ruleForm).then(resp => {
            this.isLoading = false
            this.$message.success('操作成功')
          })
        } else {
          console.log('error submit!!')
          console.log(valid)
          return false
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.setting-container {
  .el-form-item__label {
    width: 150px;
  }
}
</style>
