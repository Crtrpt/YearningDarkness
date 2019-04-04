<template>
  <div>
    <Modal v-model="ConfigModal" width="720" :title="newConfig.oldKey==''?'新增配置':'修改配置'">
      <Breadcrumb>
        <BreadcrumbItem>{{curFormItem.appId}}</BreadcrumbItem>
        <BreadcrumbItem>{{curFormItem.env_name}}</BreadcrumbItem>
        <BreadcrumbItem>{{curFormItem.cluster_name}}</BreadcrumbItem>
        <BreadcrumbItem>{{curFormItem.namespace_name}}</BreadcrumbItem>
      </Breadcrumb>
      <div style="margin-top:30px">
        <Form :model="formItem" :label-width="80">
          <FormItem label="Key">
            <Input v-model="newConfig.key" placeholder="key" :disabled="newConfig.oldKey!=''"></Input>
          </FormItem>
          <FormItem label="value">
            <Input v-model="newConfig.value" placeholder="value"></Input>
          </FormItem>
          <FormItem label="comment">
            <Input v-model="newConfig.comment" placeholder="comment"></Input>
          </FormItem>
        </Form>
      </div>
      <div slot="footer">
        <Button type="primary" size="large" long @click="addConfig">提交</Button>
      </div>
    </Modal>
    <Alert>default test 修改自动生效 stg prod 走审核流程</Alert>
    <Row>
      <Col span="6">
        <Card>
          <p slot="title">
            <Icon type="ios-redo"></Icon>Apollo配置
          </p>
          <div class="edittable-test-con">
            <Form :model="formItem" :label-width="100" ref="formItem" :rules="ruleValidate">
              <Form-item label="服务:" prop="project">
                <Select v-model="formItem.appId" placeholder="请选择" @on-change="projectChange">
                  <Option v-for="i in projectdataset" :value="i.appId" :key="i.appId">{{ i.name }}</Option>
                </Select>
              </Form-item>
              <Form-item label="环境:" prop="env">
                <Select v-model="formItem.env_id" placeholder="请选择" @on-change="envChange">
                  <Option v-for="i in envdataset" :value="i.id" :key="i.id">{{ i.name }}</Option>
                </Select>
              </Form-item>
              <Form-item label="集群:" prop="cluster">
                <Select v-model="formItem.cluster" placeholder="请选择" @on-change="clusterChange">
                  <Option v-for="i in clusterdataset" :value="i.id" :key="i.id">{{ i.name }}</Option>
                </Select>
              </Form-item>
              <Form-item label="名称空间:" prop="namespace">
                <Select
                  v-model="formItem.namespace_id"
                  placeholder="请选择"
                  @on-change="namespaceChange"
                >
                  <Option v-for="i in namespacedataset" :value="i.id" :key="i.id">{{ i.name }}</Option>
                </Select>
              </Form-item>
              <FormItem label="迭代版本:">
                <Input v-model="formItem.version" placeholder="请输入迭代版本"></Input>
              </FormItem>
              <Form-item>
                <Button type="primary" @click="getConfig">获取配置</Button>
              </Form-item>
            </Form>
          </div>
        </Card>
      </Col>
      <Col span="18" class="padding-left-10">
        <Card>
          <p slot="title">
            <Icon type="md-remove"></Icon>配置
          </p>
          <div class="edittable-table-height-con">
            <Tabs :value="tabs">
              <TabPane label="表格" name="current" icon="ios-cog-outline">
                <Breadcrumb v-if="workspace">
                  <BreadcrumbItem>{{curFormItem.appId}}</BreadcrumbItem>
                  <BreadcrumbItem>{{curFormItem.env_name}}</BreadcrumbItem>
                  <BreadcrumbItem>{{curFormItem.cluster_name}}</BreadcrumbItem>
                  <BreadcrumbItem>{{curFormItem.namespace_name}}</BreadcrumbItem>
                </Breadcrumb>
                <Table :columns="fieldColumns" :data="configData" style="margin-top:10px">
                  <template slot-scope="{ row, index }" slot="status">
                    <Button
                      type="error"
                      ghost
                      shape="circle"
                      size="small"
                      v-if="row.status===-1"
                    >已删除</Button>
                    <Button
                      type="success"
                      ghost
                      shape="circle"
                      size="small"
                      v-if="row.status===1"
                    >已发布</Button>
                     <Button
                      type="warning"
                      ghost
                      shape="circle"
                      size="small"
                      v-if="row.status===0"
                    >未发布</Button>
    
                  </template>
                  <template slot-scope="{ row, index }" slot="action">
                    <ButtonGroup type="button">
                      <Button @click="editConfigBtn(row)" size="small">修改</Button>
                      <Button type="success" @click="removeConfigBtn(row)" size="small">删除</Button>
                    </ButtonGroup>
                  </template>
                </Table>
                <Form style="margin-top:30px" v-if="workspace">
                  <FormItem>
                    <Button type="success" style="margin-left: 3%" @click="addConfigBtn">新增配置</Button>
                    <Button type="success" style="margin-left: 3%" @click="publishConfigBtn">发布配置</Button>
                  </FormItem>
                </Form>
              </TabPane>
              <TabPane label="文本" name="edit_current" icon="ios-cog" v-if="workspace">
                <Form v-if="workspace">
                  <FormItem>
                    <ConfigEditor v-model="config" @init="ConfigInit" @setCompletions="setCompletions"></ConfigEditor>
                  </FormItem>
                  <FormItem>
                    <Button type="success" style="margin-left: 3%" @click="resetConfig">重置</Button>
                    <Button type="success" style="margin-left: 3%" @click="submitConfig">提交工单</Button>
                  </FormItem>
                </Form>
              </TabPane>
            </Tabs>
          </div>
        </Card>
      </Col>
    </Row>
  </div>
</template>

<script>
//
import _ from 'lodash'
import axios from 'axios'
// import sqlFormatter from 'sql-formatter'
import ICol from 'iview/src/components/grid/col'

export default {
  components: {
    ICol,
    ConfigEditor: require('../../libs/ConfigEditor')
  },
  data () {
    return {
      // 默认key
      defaultNewConfig: {
        oldKey: '',
        key: '',
        value: '',
        comment: ''
      },
      newConfig: {
        oldKey: '',
        key: '',
        value: '',
        comment: ''
      },
      ConfigModal: false,
      ruleValidate: {},
      tabs: 'current',
      projectdataset: [{ appId: 10001, name: 'default' }],
      envdataset: [
        { id: 1, name: 'DEV' }
      ],
      clusterdataset: [
        {
          id: 0,
          name: 'default'
        },
        {
          id: 1,
          name: 'test'
        },
        {
          id: 2,
          name: 'stg'
        }, {
          id: 3,
          name: 'prod'
        }
      ],
      workspace: true,
      namespacedataset: [
        {
          id: 1, name: 'application'
        }
      ],
      config: 'aaa=111',
      formItem: {
        version: '',
        appId: 0,
        cluster_name: 'default',
        env_id: 1,
        env_name: 'DEV',
        namespace_id: 1,
        namespace_name: 'application'
      },
      curFormItem: {
        appId: 0,
        cluster_name: 'default',
        env_id: 1,
        env_name: 'DEV',
        namespace_id: 1,
        namespace_name: 'application'
      },
      fieldColumns: [
        {
          title: 'key',
          key: 'key'
        },
        {
          title: 'value',
          key: 'value',
          editable: true
        },
        {
          title: '备注',
          key: 'comment',
          editable: true,
          option: true
        },
        {
          title: '最后修改人',
          key: 'dataChangeLastModifiedBy',
          editable: true
        },
        {
          title: '最后修改时间',
          key: 'dataChangeLastModifiedTime'
        },
        {
          title: '状态',
          key: 'status',
          align: 'center',
          slot: 'status'
        },
        {
          title: '操作',
          key: 'action',
          align: 'center',
          slot: 'action'
        }
      ],
      // 全部配置
      configAllData: [],
      // 带发布状态的配置
      configData: [
        { key: 'aaa', value: '222', status: 0, comment: '提交配置', dataChangeLastModifiedBy: 'apollo', dataChangeLastModifiedTime: '111' }
      ],
      fieldData: []
    }
  },
  methods: {
    projectChange () {
      axios.get(`${this.$config.url}/apollo/openapi/v1/apps/${this.formItem.appId}/envclusters`)
        .then(res => {
          console.log(res.data[0].clusters)
          this.clusterdataset = res.data[0].clusters.map((element, i) => {
            return { id: i, name: element }
          });
          this.formItem.cluster = 0
          // this.formItem.clusterdataset = res.data[0].clusters;
        })
        .catch(error => {
          console.log(error)
        })
    },
    envChange () {

    },
    // 重置默认key
    resetDefaultNewConfig () {
      this.newConfig = _.cloneDeep(this.defaultNewConfig)
    },
    clusterChange (v) {
      for (let index = 0; index < this.clusterdataset.length; index++) {
        const element = this.clusterdataset[index];
        if (element.id === v) {
          this.formItem.cluster_name = element.name
          break
        }
      }
    },
    namespaceChange () {

    },
    // 完成回调
    setCompletions (editor, session, pos, prefix, callback) {
    },
    ConfigInit: function () {
      require('brace/mode/mysql')
      require('brace/theme/xcode')
    },
    // 提交配置
    submitConfig: function () {
       this.$Message.info('暂未实现')
      // var data = {
      //   oldConfig: this.configData,
      //   newConfig: this.config
      // }
      // axios.post(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}`, data)
      //   .then(res => {

      //   })
      //   .catch(error => {
      //     console.log(error)
      //   })
    },
    // 发布配置
    editConfig: function () {
      this.ConfigModal = true
    },
    // 发布配置
    editConfigBtn: function (row) {
      this.newConfig = row
      this.newConfig.oldKey = row.key
      this.ConfigModal = true
    },
    // 发布配置
    removeConfig: function () {
      axios.delete(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}/items/${this.newConfig.oldKey}?operator=apollo`)
        .then(res => {
          this.$Message.info('配置已删除,请发布生效')
          this.getConfig()
        })
        .catch(error => {
          console.log(error)
          this.$Message.info('提交配置错误 联系管理员')
        })
      this.resetDefaultNewConfig()
    },
    // 发布配置
    removeConfigBtn: function (row) {
      var _this = this;
      this.$Modal.confirm({
        title: '删除配置',
        content: '<p>确认删除配置?</p>',
        onOk: function () {
          _this.newConfig.oldKey = row.key
          _this.removeConfig()
        }
      });
    },
    // 增加配置
    addConfig: function () {
      var data = {}
      if (this.newConfig.oldKey === '') {
        // 新增
        data = {
          key: this.newConfig.key,
          value: this.newConfig.value,
          comment: this.newConfig.comment,
          dataChangeCreatedBy: 'apollo'
        }
        axios.post(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}/items`, { data: data })
          .then(res => {
            this.$Message.info('配置修改,请发布生效')
            this.ConfigModal = false
            this.getConfig()
          })
          .catch(error => {
            console.log(error)
            this.$Message.info('提交配置错误 联系管理员')
          })
      } else {
        // 修改
        data = {
          key: this.newConfig.key,
          value: this.newConfig.value,
          comment: this.newConfig.comment,
          dataChangeLastModifiedBy: 'apollo'
        }
        axios.put(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}/items/${this.newConfig.oldKey}`, { data: data })
          .then(res => {
            this.$Message.info('配置修改,请发布生效')
            this.ConfigModal = false
            this.getConfig()
          })
          .catch(error => {
            console.log(error)
            this.$Message.info('提交配置错误 联系管理员')
          })
      }
      this.resetDefaultNewConfig()
    },
    // 增加配置
    addConfigBtn: function () {
      this.ConfigModal = true
    },
    // 发布配置
    publishConfig: function () {
      var data = {
        releaseTitle: '2016-08-11',
        releaseComment: '修改timeout值',
        releasedBy: 'apollo'
      }
      axios.post(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}/releases`, { data: data })
        .then(res => {
          this.$Message.info('配置发布已生效')
          this.ConfigModal = false
          this.getConfig()
        })
        .catch(error => {
          console.log(error)
          this.$Message.info('提交配置错误 联系管理员')
        })
    },
    // 发布配置
    publishConfigBtn: function () {
      this.publishConfig()
    },
    // 重置配置
    resetConfig: function () {
      var compiled = _.template('<% _.forEach(config, function(c) { %><%- c.key %>=<%- c.value %> #<%- c.comment %> \n<% }); %>');
      this.config = compiled({ 'config': this.configAllData });
    },
    // 获取配置
    getConfig () {
      axios.get(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}`)
        .then(res => {
          this.configAllData = res.data.items
          this.curFormItem = _.cloneDeep(this.formItem)
          this.resetConfig()
          this.workspace = true
          // 渲染发布还是未发布
          this.configData = _.cloneDeep(this.configAllData)
          // axios.get(`${this.$config.url}/apollo/openapi/v1/envs/${this.formItem.env_name}/apps/${this.formItem.appId}/clusters/${this.formItem.cluster_name}/namespaces/${this.formItem.namespace_name}/releases/latest`)
          //   .then(res => {
          //     console.log(res.data.configurations)
          //     this.configAllData.forEach(element => {
          //       if (element.dataChangeCreatedBy === undefined) {
          //         element['status'] = -1
          //       } else {
          //         element['status'] = +(res.data.configurations[element.key] === element.value)
          //       }
          //     });
          //     this.configData = _.cloneDeep(this.configAllData)
          //   })
          //   .catch(error => {
          //     console.log(error)
          //   })
        })
        .catch(error => {
          console.log(error)
        })
    }
  },
  mounted () {
    this.projectdataset = JSON.parse('[{ "name": "demo-service", "appId": "100001", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 3, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-18T20:01:12.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-18T23:41:39.000+0800" },{ "name": "order-service", "appId": "100002", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 3, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-18T20:01:12.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-18T23:41:39.000+0800" }, { "name": "product-service", "appId": "100003", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 4, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-18T20:06:29.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-18T23:42:03.000+0800" }, { "name": "shopdevice-service", "appId": "100004", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 16, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-19T00:29:23.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-19T01:00:39.000+0800" }, { "name": "app-service", "appId": "100005", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 17, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-19T00:59:55.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-19T01:00:57.000+0800" }, { "name": "statement-service", "appId": "100006", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 18, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-19T01:02:46.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-19T01:02:46.000+0800" }, { "name": "organization-service", "appId": "100007", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 19, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-19T01:03:32.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-19T01:03:32.000+0800" }, { "name": "gateway", "appId": "100008", "orgId": "0001", "orgName": "研发部", "ownerName": "pengzai", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 20, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-19T01:04:30.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-19T01:04:30.000+0800" }, { "name": "eureka-server", "appId": "100009", "orgId": "0001", "orgName": "研发部", "ownerName": "apollo", "ownerEmail": "apollo@a.com", "id": 21, "isDeleted": false, "dataChangeCreatedBy": "apollo", "dataChangeCreatedTime": "2018-10-22T19:19:37.000+0800", "dataChangeLastModifiedBy": "apollo", "dataChangeLastModifiedTime": "2018-10-22T19:19:37.000+0800" }, { "name": "ops-service", "appId": "100011", "orgId": "0001", "orgName": "研发部", "ownerName": "jingzhixiang@chupinxiu.com", "ownerEmail": "jingzhixiang@chupinxiu.com", "id": 26, "isDeleted": false, "dataChangeCreatedBy": "jingzhixiang@chupinxiu.com", "dataChangeCreatedTime": "2018-11-20T12:31:43.000+0800", "dataChangeLastModifiedBy": "jingzhixiang@chupinxiu.com", "dataChangeLastModifiedTime": "2018-11-26T09:22:41.000+0800" }, { "name": "push-service", "appId": "100012", "orgId": "0001", "orgName": "研发部", "ownerName": "suxiaolin@chupinxiu.com", "ownerEmail": "suxiaolin@chupinxiu.com", "id": 27, "isDeleted": false, "dataChangeCreatedBy": "jingzhixiang@chupinxiu.com", "dataChangeCreatedTime": "2018-12-26T12:06:08.000+0800", "dataChangeLastModifiedBy": "jingzhixiang@chupinxiu.com", "dataChangeLastModifiedTime": "2018-12-26T12:06:08.000+0800" }, { "name": "material-service", "appId": "100013", "orgId": "0001", "orgName": "研发部", "ownerName": "wengjinpeng@chupinxiu.com", "ownerEmail": "wengjinpeng@chupinxiu.com", "id": 28, "isDeleted": false, "dataChangeCreatedBy": "jingzhixiang@chupinxiu.com", "dataChangeCreatedTime": "2019-01-12T11:07:57.000+0800", "dataChangeLastModifiedBy": "jingzhixiang@chupinxiu.com", "dataChangeLastModifiedTime": "2019-01-12T11:07:57.000+0800" }]')
  }
}
</script>

<style lang="less">
@import '../../styles/common.less';
@import 'components/table.less';

p {
  word-wrap: break-word;
  word-break: break-all;
  overflow: hidden;
}
</style>
