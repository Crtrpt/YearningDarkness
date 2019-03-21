<style lang="less">
  @import '../../styles/common.less';
  @import '../order/components/table.less';
</style>
<template>
  <div>
    <Col span="5">
      <Card>
        <p slot="title">
          <Icon type="md-refresh"/>
          添加服务
        </p>
        <div class="edittable-testauto-con">
          <Form ref="formValidate" :model="formItem" :label-width="100" :rules="ruleInline">
            <Form-item label="环境:">
              <Select v-model="formItem.env_id" placeholder="请选择">
                <Option v-for="list in envList" :value="list.id" :key="list.id">{{ list.env_name }}</Option>
              </Select>
            </Form-item>
            <Form-item label="服务名称:" prop="name">
              <Input v-model="formItem.service_name" placeholder="请输入服务名称"></Input>
            </Form-item>
            <Button type="success" @click="addConnection()" style="margin-left: 5%">确定</Button>
            <Button type="warning" @click="resetForm()" style="margin-left: 5%">重置</Button>
          </Form>
        </div>
      </Card>
    </Col>
    <Col span="19" class="padding-left-10">
      <Card>
        <p slot="title">
          <Icon type="md-apps"/>
          服务列表
        </p>
        <Input v-model="query.service_name" placeholder="服务名" style="width: 20%" clearable />
        <Input v-model="query.env_name" placeholder="环境" style="width: 20%" clearable />
        <Button @click="queryData" type="primary">查询</Button>
        <Button @click="queryCancel" type="warning">重置</Button>
        <div class="edittable-con-1">
          <Table :columns="columns" :data="tableData">
            <template slot-scope="{ row, index }" slot="action">
              <Button type="info" size="small" @click="viewConnectionModal(row)" style="margin-right: 5px">查看</Button>
              <Button type="success" size="small" @click="dingInfoModal(row)" style="margin-right: 5px">钉钉消息</Button>
              <Poptip
                confirm
                title="确定要删除此连接名吗？"
                @on-ok="delConnection(row)">
                <Button type="warning" size="small">删除</Button>
              </Poptip>
            </template>
          </Table>
        </div>
        <br>
        <Page :total="pagenumber" show-elevator @on-change="getPageInfo" :page-size="10" ref="page"></Page>
      </Card>
    </Col>

  </div>
</template>
<script>
  import '../../assets/tablesmargintop.css'
  import axios from 'axios'

  import ICol from '../../../node_modules/iview/src/components/grid/col'

  export default {
    components: {
      ICol
    },
    name: 'envlist',
    data () {
      return {
        tableData: [],
        columns: [
          {
            title: '服务名',
            key: 'service_name'
          },
          {
            title: '环境',
            key: 'env_name'
          }
        ],
        // 添加数据库信息
        formItem: {
          service_name: '',
          env_id: '',
          env_name: ''
        },
        // 添加表单验证规则
        ruleInline: {
          service_name: [{
            required: true,
            message: '请填写连接名称',
            trigger: 'blur'
          }]
        },
        pagenumber: 1,
        ding: {
          modal: false,
          before: '',
          after: '',
          connection_name: '',
          id: null
        },
        envList: [],
        baseinfo: false,
        editbaseinfo: {},
        query: {
          service_name: '',
          env_name: '',
          valve: false
        }
      }
    },
    methods: {
      resetForm () {
        this.formItem = this.$config.clearObj(this.formItem)
      },
      addConnection () {
            let data = {
                'service_name': this.formItem.service_name,
                'env_id': this.formItem.env_id,
                'env_name': (() => {
                            for (const env in this.envList) {
                              console.log(this.envList[env].id);
                              if (this.envList[env].id === this.formItem.env_id) {
                                return this.envList[env].env_name
                              }
                            }
                })()
            }
            axios.post(this.$config.url + '/management_service/', {
              'data': JSON.stringify(data)
            })
              .then(() => {
                this.$config.notice('服务添加成功')
                this.getPageInfo(this.$refs.page.currentPage)
                this.$refs['formValidate'].resetFields()
              })
              .catch(error => {
                this.$config.err_notice(this, error)
              })
      },
      viewConnectionModal (row) {
        this.baseinfo = true
        this.editbaseinfo = row
      },
      dingInfoModal (vl) {
        this.ding = this.$config.sameMerge(this.ding, vl, this.ding)
        this.ding.modal = true
      },
      delConnection (vl) {
        let step = this.$refs.page.currentPage
        if (this.tableData.length === 1) {
          step = step - 1
        }
        axios.delete(`${this.$config.url}/management_db/${vl.connection_name}`)
          .then(res => {
            this.$config.notice(res.data)
            this.getPageInfo(step)
          })
          .catch(error => {
            this.$config.err_notice(this, error)
          })
      },
      getPageInfo (vl = 1) {
        axios.get(`${this.$config.url}/management_service/all/?page=${vl}&permissions_type=service&con=${JSON.stringify(this.query)}`)
          .then(res => {
            [this.tableData, this.pagenumber, this.envList] = [res.data.data, parseInt(res.data.page), res.data.envList]
          })
          .catch(error => {
            this.$config.err_notice(this, error)
          })
      },
      saveDingding () {
        axios.post(`${this.$config.url}/dingding/`, {
          'before': this.ding.before,
          'after': this.ding.after,
          'id': this.ding.id
        })
          .then(() => {
            this.$config.notice('钉钉推送消息已设置成功!')
            this.getPageInfo(this.$refs.page.currentPage)
            this.ding.modal = false
          })
          .catch(error => {
            this.$config.err_notice(this, error)
          })
      },
      modifyBase () {
        axios.put(`${this.$config.url}/management_db/update`, {
          'data': JSON.stringify(this.editbaseinfo)
        })
          .then(res => this.$config.notice(res.data))
          .catch(err => this.$config.err_notice(this, err))
      },
      queryData () {
        this.query.valve = true
        this.getPageInfo()
      },
      queryCancel () {
        this.$config.clearObj(this.query)
        this.getPageInfo()
      }
    },
    mounted () {
      this.getPageInfo()
    }
  }
</script>
