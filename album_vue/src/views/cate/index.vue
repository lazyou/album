<template>
  <div class="app-container">
    <el-button
      class="filter-item"
      style="margin-bottom: 10px;"
      type="primary"
      icon="el-icon-edit"
      @click="handleCreate"
    >创建</el-button>

    <el-table v-loading="listLoading" :data="list" border fit highlight-current-row style="width: 100%">
      <!--      <el-table-column align="center" label="ID" width="80">-->
      <!--        <template slot-scope="{row}">-->
      <!--          <span>{{ row.id }}</span>-->
      <!--        </template>-->
      <!--      </el-table-column>-->

      <el-table-column width="120px" align="center" label="排序">
        <template slot-scope="{row}">
          <template v-if="row.edit">
            <!--            TODO: max 无效?-->
            <el-input v-model="row.displayorder" type="number" min="0" max="10000" size="small" />
          </template>
          <span v-else>{{ row.displayorder }}</span>
        </template>
      </el-table-column>

      <el-table-column min-width="300px" label="标题">
        <template slot-scope="{row}">
          <template v-if="row.edit">
            <el-input v-model="row.title" size="small" />
          </template>
          <span v-else>{{ row.title }}</span>
        </template>
      </el-table-column>

      <el-table-column align="center" label="操作" width="200">
        <template slot-scope="{row}">
          <el-button type="primary" size="small" @click="handleUpdate(row)">编辑</el-button>
          <el-button type="danger" size="small" @click="confirmDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--编辑-->
    <el-dialog :title="dialogFormTitle" :visible.sync="dialogFormVisible">
      <el-form ref="dialogForm" :model="dialogForm" :rules="dialogFormRules" label-position="left" label-width="70px" style="width: 400px; margin-left:50px;">
        <el-form-item label="排序" prop="displayorder">
          <el-input v-model="dialogForm.displayorder" type="number" />
        </el-form-item>

        <el-form-item label="标题" prop="title">
          <el-input v-model="dialogForm.title" />
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
import { cateList, updateCate, deleteCate } from '@/api/admin-cate'

export default {
  name: 'InlineEditTable',
  filters: {
  },
  data() {
    return {
      list: null,
      listLoading: true,
      listQuery: {
        page: 1,
        limit: 10
      },
      dialogFormTitle: '新增',
      dialogFormVisible: false,
      dialogForm: {
        id: 0,
        title: '',
        displayorder: 0
      },
      dialogFormRules: {
        title: [
          { required: true, message: '请输入分类名称', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        displayorder: [
          { required: true, message: '请输入分类排序', trigger: 'change' }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    async getList() {
      this.listLoading = true
      const items = await cateList(this.listQuery)
      this.list = items.map(item => {
        this.$set(item, 'edit', false) // https://vuejs.org/v2/guide/reactivity.html
        item.originalTitle = item.title //  will be used when user click the cancel botton
        item.originalDisplayorder = item.displayorder //  will be used when user click the cancel botton
        return item
      })
      this.listLoading = false
    },
    sortList() {
      function sortData(a, b) {
        return a.displayorder - b.displayorder
      }

      this.list.sort(sortData)
    },
    resetForm() {
      this.dialogForm = {
        id: 0,
        title: '',
        displayorder: 0
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
          updateCate(this.dialogForm).then((res) => {
            if (this.dialogForm.id === 0) {
              this.list.unshift(res)
            }

            this.sortList()
            this.dialogFormVisible = false
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    confirmEdit(row) {
      if (row.title === '' || row.displayorder === '') {
        this.$message.info('请输入标题 排序')
        return false
      }

      updateCate(row).then(() => {
        this.$message.success('操作成功')
      })
    },

    confirmDelete(row) {
      this.$confirm('此操作将永久删除该数据, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteCate(row.id).then(() => {
          const index = this.list.findIndex(item => item.id === row.id)
          this.list.splice(index, 1)
          this.$message.success('删除成功')
        })
      }).catch(() => {
        this.$message.info('已取消删除')
      })
    }
  }
}
</script>

<style scoped>
  .edit-input {
    padding-right: 100px;
  }
  .cancel-btn {
    position: absolute;
    right: 15px;
    top: 10px;
  }
</style>
