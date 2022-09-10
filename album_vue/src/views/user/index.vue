<template>
  <div class="app-container">
    <!--    列表过滤条件-->
    <div class="filter-container">
      <el-input v-model="listQuery.nickname" placeholder="昵称" clearable style="width: 200px;" class="filter-item" @keyup.enter.native="handleFilter" />

      <el-select v-model="listQuery.status" placeholder="状态" clearable class="filter-item" style="width: 130px">
        <el-option v-for="item in statusOptions" :key="item.key" :label="item.display_name+'('+item.key+')'" :value="item.key" />
      </el-select>

      <el-select v-model="listQuery.sort" placeholder="排序" clearable style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>

      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
        搜索
      </el-button>
    </div>

    <!--    列表数据-->
    <el-table
      :key="tableKey"
      v-loading="listLoading"
      :data="list"
      border
      fit
      highlight-current-row
      style="width: 100%;"
      @sort-change="sortChange"
    >
      <el-table-column label="UID" prop="uid" sortable="custom" align="center" width="80" :class-name="getSortClass('uid')">
        <template slot-scope="{row}">
          <span>{{ row.uid }}</span>
        </template>
      </el-table-column>

      <el-table-column label="头像" align="center">
        <template slot-scope="{row}">
          <el-avatar :src="row.avatar" />
        </template>
      </el-table-column>

      <el-table-column label="昵称">
        <template slot-scope="{row}">
          <span class="link-type" @click="handleUpdate(row)">{{ row.nickname }}</span>
        </template>
      </el-table-column>

      <el-table-column label="状态" class-name="status-col">
        <template slot-scope="{row}">
          <el-tag :type="row.status | statusFilter">
            {{ row.status | statusStr }}
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="加入时间" align="center">
        <template slot-scope="{row}">
          <span>{{ row.created_at }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" width="230" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-button type="primary" size="mini" @click="handleUpdate(row)">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--    分页 -->
    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />

    <!--编辑-->
    <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form ref="dataForm" :model="temp" label-position="left" label-width="70px" style="width: 400px; margin-left:50px;">
        <el-form-item label="UID" prop="uid">
          <el-input v-model="temp.uid" disabled />
        </el-form-item>

        <el-form-item label="头像" prop="avatar">
          <el-avatar :src="temp.avatar" />
        </el-form-item>

        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="temp.nickname" disabled />
        </el-form-item>

        <el-form-item label="状态">
          <el-select v-model="temp.status" class="filter-item">
            <el-option
              v-for="item in statusOptions"
              :key="item.key"
              :label="item.display_name"
              :value="item.key"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="加入时间" prop="created_at">
          <el-date-picker v-model="temp.created_at" type="datetime" disabled />
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogStatus === 'create' ? createData() : updateData()">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { userList, updateUser } from '@/api/admin-user'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

const statusOptions = [
  { key: 0, display_name: '启用' },
  { key: 1, display_name: '禁用' }
]

// arr to obj, such as { CN : "China", US : "USA" }
const statusMapOptions = statusOptions.reduce((acc, cur) => {
  acc[cur.key] = cur.display_name
  return acc
}, {})

export default {
  name: 'ComplexTable',
  components: { Pagination },
  directives: { waves },
  filters: {
    statusFilter(status) {
      const statusMap = {
        0: 'success',
        1: 'danger'
      }
      return statusMap[status]
    },
    statusStr(status) {
      return statusMapOptions[status]
    }
  },
  data() {
    return {
      tableKey: 0,
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        page: 1,
        limit: 10,
        nickname: undefined,
        status: undefined,
        // sort: '+uid'
        sort: undefined
      },
      statusOptions,
      sortOptions: [{ label: 'UID 升序', key: '+uid' }, { label: 'UID 降序', key: '-uid' }],
      temp: {
        uid: undefined,
        avatar: '',
        nickname: '',
        status: undefined,
        created_at: ''
      },
      dialogFormVisible: false,
      dialogStatus: '',
      textMap: {
        update: 'Edit',
        create: 'Create'
      },
      dialogPvVisible: false
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      userList(this.listQuery).then(response => {
        this.list = response.data
        this.total = response.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    handleModifyStatus(row, status) {
      this.$message({
        message: '操作Success',
        type: 'success'
      })
      row.status = status
    },
    sortChange(data) {
      const { prop, order } = data
      if (prop === 'uid') {
        this.sortByID(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+uid'
      } else {
        this.listQuery.sort = '-uid'
      }
      this.handleFilter()
    },
    resetTemp() {
      this.temp = {
        uid: undefined,
        avatar: '',
        nickname: '',
        status: undefined,
        created_at: ''
      }
    },
    handleUpdate(row) {
      this.temp = Object.assign({}, row) // copy obj
      this.dialogStatus = 'update'
      this.dialogFormVisible = true
      this.$nextTick(() => {
        this.$refs['dataForm'].clearValidate()
      })
    },
    updateData() {
      this.$refs['dataForm'].validate((valid) => {
        if (valid) {
          const tempData = Object.assign({}, this.temp)
          updateUser(tempData).then(() => {
            const index = this.list.findIndex(v => v.uid === this.temp.uid)
            this.list.splice(index, 1, this.temp)
            this.dialogFormVisible = false
            this.$notify({
              title: 'Success',
              message: 'Update Successfully',
              type: 'success',
              duration: 2000
            })
          })
        }
      })
    },
    getSortClass: function(key) {
      let className = ''
      const sort = this.listQuery.sort
      if (sort) {
        className = sort === `+${key}` ? 'ascending' : 'descending'
      }

      return className
    }
  }
}
</script>
