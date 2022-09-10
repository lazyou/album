<template>
  <div class="app-container">
    <el-button class="filter-item" style="margin-bottom: 10px;;" type="primary" icon="el-icon-edit" @click="handleCreate">创建</el-button>

    <!--    列表数据-->
    <el-table
      :key="tableKey"
      v-loading="listLoading"
      :data="list"
      border
      fit
      highlight-current-row
      style="width: 100%;"
    >
      <el-table-column label="ID" prop="id" align="center" width="50px">
        <template slot-scope="{row}">
          <span>{{ row.id }}</span>
        </template>
      </el-table-column>

      <el-table-column label="标题">
        <template slot-scope="{row}">
          <span>{{ row.title }}</span>
        </template>
      </el-table-column>

      <el-table-column label="音乐地址" width="500px">
        <template slot-scope="{row}">
          <audio :src="row.music" preload="none" controls="controls" style="width: 100%;">
            Your browser does not support the audio tag.
          </audio>
          <el-input
            v-model="row.music"
            type="textarea"
            :rows="2"
            readonly
          />
        </template>
      </el-table-column>

      <el-table-column label="添加时间" align="center">
        <template slot-scope="{row}">
          <span>{{ row.created_at }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-button type="primary" size="small" @click="handleUpdate(row)">编辑</el-button>
          <el-button type="danger" size="small" @click="confirmDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--    分页 -->
    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />

    <!--编辑-->
    <el-dialog :title="dialogFormTitle" :visible.sync="dialogFormVisible">
      <el-form ref="dialogForm" :model="dialogForm" :rules="dialogFormRules" label-position="left" label-width="70px" style="width: 400px; margin-left:50px;">
        <el-form-item label="ID" prop="id">
          <el-input v-model="dialogForm.id" disabled />
        </el-form-item>

        <el-form-item label="标题" prop="title">
          <el-input v-model="dialogForm.title" />
        </el-form-item>

        <el-form-item label="音乐" prop="music">
          <QiniuSingleAudio v-model="dialogForm.music" />
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="handlePost">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { musicList, updateMusic, deleteMusic } from '@/api/admin-music'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination
import QiniuSingleAudio from '@/components/Upload/QiniuSingleAudio'

export default {
  name: 'ComplexTable',
  components: { Pagination, QiniuSingleAudio },
  directives: { waves },
  filters: {
  },
  data() {
    return {
      tableKey: 0,
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        page: 1,
        limit: 10
      },
      dialogFormTitle: '',
      dialogFormVisible: false,
      dialogForm: {
        id: 0,
        title: '',
        music: ''
      },
      dialogFormRules: {
        title: [
          { required: true, message: '请输入音乐名称', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        music: [
          { required: true, message: '请选择音乐文件', trigger: 'change' }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    playMusic(music) {
      console.log('playMusic:')
      console.log(music)
    },
    getList() {
      this.listLoading = true
      musicList(this.listQuery).then(response => {
        this.list = response.data
        this.total = response.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    resetForm() {
      this.dialogForm = {
        id: 0,
        title: '',
        music: ''
      }
    },
    clearFormValidate() {
      this.$nextTick(() => {
        this.$refs['dialogForm'].clearValidate()
      })
    },
    handleCreate() {
      this.resetForm()
      this.clearFormValidate()
      this.dialogFormVisible = true
    },
    handleUpdate(row) {
      this.dialogForm = row
      this.clearFormValidate()
      this.dialogFormVisible = true
    },
    handlePost() {
      this.$refs['dialogForm'].validate((valid) => {
        if (valid) {
          updateMusic(this.dialogForm).then((res) => {
            this.list.unshift(res)
            this.dialogFormVisible = false
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    confirmDelete(row) {
      this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteMusic(row.id).then(() => {
          const index = this.list.findIndex(item => item.id === row.id)
          this.list.splice(index, 1)

          this.$message({
            type: 'success',
            message: '删除成功!'
          })
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    }
  }
}
</script>
