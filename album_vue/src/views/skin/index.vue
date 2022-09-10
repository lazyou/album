<template>
  <div class="app-container">
    <!--    列表过滤条件-->
    <div class="filter-container">
      <el-input v-model="listQuery.title" placeholder="标题" clearable style="width: 200px;" class="filter-item" @keyup.enter.native="handleFilter" />

      <el-select v-model="listQuery.ishot" placeholder="属性" clearable class="filter-item" style="width: 130px">
        <el-option v-for="item in ishotOptions" :key="item.key" :label="`${item.display_name}(${item.key})`" :value="item.key" />
      </el-select>

      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">搜索</el-button>

      <router-link :to="`/skin/0`">
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
    >
      <el-table-column label="ID" prop="id" align="center" width="80">
        <template slot-scope="{row}">
          <span>{{ row.id }}</span>
        </template>
      </el-table-column>

      <el-table-column label="缩略图" align="center">
        <template slot-scope="{row}">
          <el-image
            :src="row.thumb"
            :preview-src-list="[row.thumb, row.bgimg]"
            style="width:60px;"
          />
        </template>
      </el-table-column>

      <el-table-column label="分类">
        <template slot-scope="{row}">
          <span>{{ row.cate.title }}</span>
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

      <el-table-column label="配乐" width="300">
        <template slot-scope="{row}">
          <audio :src="row.music" preload="none" controls="controls" style="width: 100%;">
            Your browser does not support the audio tag.
          </audio>
        </template>
      </el-table-column>

      <el-table-column label="加入时间" align="center">
        <template slot-scope="{row}">
          <span>{{ row.created_at }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" width="230" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <router-link :to="`/skin/${row.id}`">
            <el-button type="primary" size="small">编辑</el-button>
          </router-link>

          <el-button type="danger" size="small" @click="confirmDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--    分页 -->
    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />
  </div>
</template>

<script>
import { skinList } from '@/api/admin-skin'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

const ishotOptions = [
  { key: 0, display_name: '普通' },
  { key: 1, display_name: '最新' },
  { key: 2, display_name: '热门' }
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
    ishotFilter(ishot) {
      const ishotMap = {
        0: '',
        1: 'success',
        2: 'danger'
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
      ishotOptions,
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
      skinList(this.listQuery).then(response => {
        this.list = response.data
        this.total = response.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    confirmDelete(row) {
      this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // TODO: http 请求
        const index = this.list.findIndex(item => item.id === row.id)
        this.list.splice(index, 1)

        this.$message({
          type: 'success',
          message: '删除成功!'
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
