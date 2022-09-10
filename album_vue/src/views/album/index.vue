<template>
  <div class="app-container">
    <!--    列表过滤条件-->
    <div class="filter-container">
      <el-input v-model="listQuery.title" placeholder="标题" clearable style="width: 200px;" class="filter-item" @keyup.enter.native="handleFilter" />

      <el-select v-model="listQuery.status" placeholder="状态" clearable class="filter-item" style="width: 130px">
        <el-option v-for="item in statusOptions" :key="item.key" :label="`${item.display_name}(${item.key})`" :value="item.key" />
      </el-select>

      <el-select v-model="listQuery.ishot" placeholder="属性" clearable class="filter-item" style="width: 130px">
        <el-option v-for="item in ishotOptions" :key="item.key" :label="`${item.display_name}(${item.key})`" :value="item.key" />
      </el-select>

      <el-select v-model="listQuery.sort" placeholder="排序" clearable style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>

      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">搜索</el-button>

      <router-link :to="`/album/0`">
        <el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit">创建</el-button>
      </router-link>
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
      <el-table-column label="ID" prop="id" sortable="custom" align="center" width="80" :class-name="getSortClass('id')">
        <template slot-scope="{row}">
          <span>{{ row.id }}</span>
        </template>
      </el-table-column>

      <el-table-column label="缩略图" align="center">
        <template slot-scope="{row}">
          <el-avatar shape="square" :src="row.thumb" />
        </template>
      </el-table-column>

      <el-table-column label="标题">
        <template slot-scope="{row}">
          <span>{{ row.title }}</span>
        </template>
      </el-table-column>

      <el-table-column label="属性" class-name="status-col">
        <template slot-scope="{row}">
          <el-tag :type="row.ishot | ishotFilter">
            {{ row.ishot | ishotStr }}
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="点击量" prop="click" sortable="custom" :class-name="getSortClass('click')">
        <template slot-scope="{row}">
          <span>{{ row.click }}</span>
        </template>
      </el-table-column>

      <el-table-column label="送花数">
        <template slot-scope="{row}">
          <span>{{ row.best }}</span>
        </template>
      </el-table-column>

      <el-table-column label="加入时间" align="center">
        <template slot-scope="{row}">
          <span>{{ row.created_at }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" width="230" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <router-link :to="`/album/${row.id}`">
            <el-button type="primary" size="small">编辑</el-button>
          </router-link>
        </template>
      </el-table-column>
    </el-table>

    <!--    分页 -->
    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />
  </div>
</template>

<script>
import { albumList, updateAlbum } from '@/api/admin-album'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

const statusOptions = [
  { key: 0, display_name: '启用' },
  { key: 1, display_name: '禁用' }
]

const statusMapOptions = statusOptions.reduce((acc, cur) => {
  acc[cur.key] = cur.display_name
  return acc
}, {})

const ishotOptions = [
  { key: 0, display_name: '正常' },
  { key: 1, display_name: '推荐' }
]

const ishotMapOptions = ishotOptions.reduce((acc, cur) => {
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
    },
    ishotFilter(ishot) {
      const ishotMap = {
        0: 'success',
        1: 'danger'
      }
      return ishotMap[ishot]
    },
    ishotStr(ishot) {
      return ishotMapOptions[ishot]
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
        // sort: '+id'
        sort: undefined
      },
      statusOptions,
      ishotOptions,
      sortOptions: [
        { label: 'ID 升序', key: '+id' },
        { label: 'ID 降序', key: '-id' },
        { label: '点击量升序', key: '+click' },
        { label: '点击量降序', key: '-click' }
      ],
      dialogFormVisible: false,
      dialogStatus: '',
      dialogPvVisible: false
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      albumList(this.listQuery).then(response => {
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
      switch (prop) {
        case 'id':
          this.sortByID(order)
          break
        case 'click':
          this.sortByClick(order)
          break
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+id'
      } else {
        this.listQuery.sort = '-id'
      }
      this.handleFilter()
    },
    sortByClick(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+click'
      } else {
        this.listQuery.sort = '-click'
      }
      this.handleFilter()
    },
    updateData() {
      this.$refs['dataForm'].validate((valid) => {
        if (valid) {
          const tempData = Object.assign({}, this.temp)
          updateAlbum(tempData).then(() => {
            const index = this.list.findIndex(v => v.id === this.temp.id)
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
