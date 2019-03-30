<style lang="less">
  @import "./home.less";
  @import "../../styles/common.less";

  .fuc {
  }

  .fuc li {
    margin-top: 2%;
    margin-left: 15%;
  }

  .fuc h4 {
    margin-top: 2%;
    margin-left: 10%;
  }

  .fuc h3 {
  }
</style>
<template>
  <div class="home-main">
        <Row>
            <Col>
              <Alert>Tips:2019年3月28日:新增sql美化</Alert>
            </Col>
        </Row>
        <Row>
          <Col span="4">
            <infor-card id-name="user_created_count" :end-val="count.createUser" iconType="md-person-add"
                        color="#2d8cf0" intro-text="平台用户"></infor-card>
          </Col>
          <Col span="4" class-name="padding-left-5">
            <infor-card id-name="visit_count" :end-val="count.link" iconType="ios-eye" color="#64d572" :iconSize="50"
                        intro-text="数据库连接地址"></infor-card>
          </Col>
          <Col span="4" class-name="padding-left-5">
            <infor-card id-name="transfer_count" :end-val="count.order" iconType="md-shuffle" color="#f25e43"
                        intro-text="我提交的工单"></infor-card>
          </Col>
          <Col span="4" class-name="padding-left-5">
            <infor-card id-name="env_count" :end-val="count.env" iconType="logo-buffer" color="#515a6e"
                        intro-text="当前环境"></infor-card>
          </Col>
          <Col span="4" class-name="padding-left-5">
            <infor-card id-name="service_count" :end-val="count.service" iconType="ios-apps" color="#2d8cf0"
                        intro-text="当前服务"></infor-card>
          </Col>
          <Col span="4" class-name="padding-left-5">
            <infor-card id-name="application_count" :end-val="count.application" iconType="ios-appstore" color="#2d8cf0"
                        intro-text="当前应用"></infor-card>
          </Col>
        </Row>

        <Row style="margin-top:10px">
          <Col span="4" >
            <infor-card id-name="merchant_count" :end-val="count.merchant" iconType="ios-people" color="#2d8cf0" intro-text="当前商户"></infor-card>
          </Col> 
        </Row>

        


            <!-- <Col span="8">
        <Row class="margin-top-10">
          <Card>
            <p slot="title" class="card-title">
              <Icon type="md-person" size="24"/>
              个人信息
            </p>
            <userinfomation></userinfomation>
          </Card>
        </Row> 
      </Col> -->


  </div>
</template>

<script>
  import axios from 'axios'
  import dataSourcePie from './components/dataSourcePie.vue'
  import inforCard from './components/inforCard.vue'
  import toDoListItem from './components/toDoListItem.vue'
  import userinfomation from '../personalCenter/own-space'

  export default {
    components: {
      dataSourcePie,
      inforCard,
      toDoListItem,
      userinfomation

    },
    data () {
      return {
        toDoList: [{
          title: ''
        }],
        count: {
          createUser: 0,
          order: 0,
          link: 0,
          env: 0,
          service: 0,
          application: 0,
          merchant: 0
        },
        newToDoItemValue: '',
        time: '',
        username: sessionStorage.getItem('user'),
        board: {
          'title': ['1.DDL语句生成', '2.SQL语句审核及回滚', '3.工单流程化', '4.可视化数据查询', '5.细粒度的权限划分']
        }
      }
    },
    methods: {
      formatDate () {
        let date = new Date()
        let month = date.getMonth() + 1
        this.time = date.getFullYear() + '/' + month + '/' + date.getDate() + '  ' + date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds()
      }
    },
    mounted () {
      var _this = this
      axios.get(`${this.$config.url}/homedata/infocard`)
        .then(res => {
          _this.count = res.data
          _this.count.application = 0
          _this.count.merchant = 0
        })
        .catch(error => {
          this.$config.err_notice(this, error)
        })
      this.formatDate()
    }
  }
</script>
