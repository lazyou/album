<template>
  <div v-loading="listLoading" class="app-container">
    <el-form ref="ruleForm" :model="ruleForm" :rules="rules" label-width="100px" class="demo-ruleForm">
      <el-form-item label="排序" prop="displayorder">
        <el-input v-model="ruleForm.displayorder" type="number" />
      </el-form-item>

      <el-form-item label="模板名称" prop="title">
        <el-input v-model="ruleForm.title" />
      </el-form-item>

      <!--   TODO:   ajax 获取-->
      <el-form-item label="模板分类" prop="cid">
        <el-select v-model="ruleForm.cid" placeholder="请选择选择模板">
          <el-option
            v-for="cate in cateList"
            :key="cate.id"
            :value="cate.id"
            :label="cate.title"
          /></el-select>
      </el-form-item>

      <el-form-item label="模板属性" prop="ishot">
        <el-radio-group v-model="ruleForm.ishot">
          <el-radio :label="0">普通</el-radio>
          <el-radio :label="1">最新</el-radio>
          <el-radio :label="2">热门</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="影集属性" prop="ishide">
        <el-radio-group v-model="ruleForm.ishide">
          <el-radio :label="0">显示</el-radio>
          <el-radio :label="1">隐藏</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="背景音乐" prop="music">
        <QiniuSingleAudio v-model="ruleForm.music" style=" width: 400px;" />
        <!--        <p style="color: #999; margin-top:-10px; font-size:12px;">此处暂时仅支持上传音乐，如果需要选择音乐请去音乐管理复制链接。</p>-->
      </el-form-item>

      <el-form-item label="模板缩略图" prop="thumb">
        <Upload v-model="ruleForm.thumb" />
      </el-form-item>

      <el-form-item label="模板背景图" prop="bgimg">
        <Upload v-model="ruleForm.bgimg" />
      </el-form-item>

      <el-form-item label="模板遮罩图层" prop="frameimg">
        <Upload v-model="ruleForm.frameimg" />
        <p style="color: #999; margin-top:-10px; font-size:12px;">此图层大于照片层级，展现立体感，没有请留空</p>
      </el-form-item>

      <el-form-item label="照片动画选择" prop="model">
        <el-radio-group v-model="ruleForm.model">
          <el-radio label="1">淡入浅出</el-radio>
          <el-radio label="2">旋转浅入</el-radio>
          <el-radio label="3">拉伸旋转</el-radio>
          <el-radio label="4">弹出旋转</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="相册特效选择" prop="ani">
        <el-checkbox-group v-model="ruleForm.ani" :max="2">
          <el-checkbox label="a">叶子</el-checkbox>
          <el-checkbox label="b">花</el-checkbox>
          <el-checkbox label="c">圆点</el-checkbox>
          <el-checkbox label="d">蝴蝶</el-checkbox>
          <el-checkbox label="e">爱心</el-checkbox>
          <el-checkbox label="f">云彩</el-checkbox>
          <el-checkbox label="g">雪花飘落</el-checkbox>
          <el-checkbox label="h">落叶知秋</el-checkbox>
          <el-checkbox label="i">彩旗</el-checkbox>
          <el-checkbox label="j">蜻蜓</el-checkbox>
          <el-checkbox label="k">小黄花</el-checkbox>
          <el-checkbox label="l">蒲公英</el-checkbox>
        </el-checkbox-group>
        <p style="color: #999; margin-top:-10px; font-size:12px;">为了保证相册整体渲染速度和性能，特效最多只能选择两个，多选无效。</p>
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
import { cateList } from '@/api/admin-cate'
import { skinDetail, updateSkin } from '@/api/admin-skin'
import QiniuSingleAudio from '@/components/Upload/QiniuSingleAudio'

export default {
  components: { Upload, QiniuSingleAudio },
  data() {
    return {
      dialogImageUrl: '',
      dialogVisible: false,
      listLoading: false,
      id: 0,
      cateList: [],
      ruleForm: {
        displayorder: 0,
        title: '',
        cid: undefined,
        ishot: 0,
        ishide: 0,
        music: '',
        thumb: '',
        bgimg: '',
        frameimg: '',
        model: 1,
        ani: []
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

    this.getCateList()
  },
  methods: {
    getDetail(id) {
      this.listLoading = true
      skinDetail(id).then(response => {
        this.ruleForm = response
        this.listLoading = false
      })
    },

    getCateList() {
      cateList().then(response => {
        this.cateList = response
      })
    },

    submitForm(formName) {
      this.listLoading = true
      updateSkin(this.id, this.ruleForm).then(response => {
        this.listLoading = false
        this.$router.push('/skin/index')
      })
    }
  }
}
</script>
