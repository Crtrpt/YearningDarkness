import Index from './main.vue'

const mainchild = [{
    path: 'home',
    title: '首页',
    name: 'home_index',
    component: resolve => {
      require(['./components/home/home.vue'], resolve)
    }
  },
  {
    path: 'queryready',
    title: '查询申请进度',
    name: 'queryready',
    component: resolve => {
      require(['./components/query/submitPage.vue'], resolve)
    }
  },
  {
    path: 'querypage',
    title: '查询',
    name: 'querypage',
    component: resolve => {
      require(['./components/query/querySql.vue'], resolve)
    }
  },
  {
    path: 'querylist',
    title: '查询审计详情',
    name: 'querylist',
    component: resolve => {
      require(['./components/audit/expend.vue'], resolve)
    }
  },
  {
    path: 'orderlist',
    title: '工单详情',
    name: 'orderlist',
    component: resolve => {
      require(['./components/order/components/myorderList.vue'], resolve)
    }
  },
  {
    path: 'myorder',
    name: 'myorder',
    title: '我的工单',
    icon: 'person',
    component: resolve => {
      require(['./components/order/myOrder.vue'], resolve)
    }
  }
]

export const loginRouter = {
  path: '/login',
  name: 'login',
  meta: {
    title: 'Login - 登录'
  },
  component: resolve => {
    require(['./login.vue'], resolve)
  }
}

export const otherRouter = {
  path: 'other',
  name: 'other',
  title: '其他',
  component: resolve => {
    require(['./components/other/page.vue'], resolve)
  }

}

export const locking = {
  path: '/locking',
  name: 'locking',
  component: resolve => {
    require(['./main_components/locking-page.vue'], resolve)
  }
}

export const page401 = {
  path: '/401',
  meta: {
    title: '401-权限不足'
  },
  name: 'error_401',
  component: resolve => {
    require(['./components/error/401.vue'], resolve)
  }
}

export const appRouter = [
  {
    path: '/',
    icon: 'md-home',
    name: 'main',
    title: '首页',
    component: Index,
    redirect: '/home',
    children: [
      ...mainchild
    ]
  },
  {
    path: '/order',
    icon: 'md-folder',
    name: 'order',
    title: '工单提交',
    component: Index,
    children: [{
        path: 'ddledit',
        name: 'ddledit',
        title: 'DDL',
        icon: 'md-git-merge',
        meta: {
          keepAlive: true
        },
        component: resolve => {
          require(['./components/order/ddlOrder.vue'], resolve)
        }
      },
      {
        path: 'dmledit',
        name: 'dmledit',
        title: 'DML',
        icon: 'md-code',
        meta: {
          keepAlive: true
        },
        component: resolve => {
          require(['./components/order/dmlOrder.vue'], resolve)
        }
      },
      {
        path: 'apollo',
        name: 'apollo',
        title: 'APOLLO',
        icon: 'ios-cog-outline',
        component: resolve => {
          require(['./components/order/apolloOrder.vue'], resolve)
        }
      }
    ]
  },
  {
    path: '/view',
    icon: 'md-search',
    name: 'view',
    title: '查询',
    component: Index,
    children: [{
      path: 'serach-sql',
      name: 'serach-sql',
      title: 'SQL查询',
      icon: 'ios-podium',
      component: resolve => {
        require(['./components/query/workFlow.vue'], resolve)
      }
    }]
  },
  {
    path: '/audit',
    icon: 'md-open',
    name: 'audit',
    title: '审核',
    component: Index,
    access: 0,
    children: [{
        path: 'audit-order',
        name: 'audit-audit',
        title: '工单',
        icon: 'md-create',
        component: resolve => {
          require(['./components/audit/sqlAudit.vue'], resolve)
        }
      },
      {
        path: 'audit-permissions',
        name: 'audit-permissions',
        title: '权限',
        icon: 'md-share',
        component: resolve => {
          require(['./components/audit/permissions.vue'], resolve)
        }
      },
      {
        path: 'query-audit',
        name: 'query-audit',
        title: '查询',
        icon: 'logo-rss',
        component: resolve => {
          require(['./components/audit/queryAudit.vue'], resolve)
        }
      }
    ]
  },
  {
    path: '/record',
    icon: 'md-pie',
    name: 'record',
    title: '记录',
    component: Index,
    access: 0,
    children: [{
        path: 'query-review',
        name: 'query-review',
        title: '查询审计',
        icon: 'md-pulse',
        component: resolve => {
          require(['./components/assistantManger/queryRecord.vue'], resolve)
        }
      },
      {
        path: 'audit-record',
        name: 'audit-record',
        title: '工单记录',
        icon: 'md-list',
        component: resolve => {
          require(['./components/assistantManger/record.vue'], resolve)
        }
      }
    ]
  },
  {
    path: '/management',
    icon: 'logo-buffer',
    name: 'management',
    title: '管理',
    access: 0,
    component: Index,
    children: [{
        path: 'management-user',
        name: 'management-user',
        title: '用户',
        icon: 'md-people',
        component: resolve => {
          require(['./components/management/userInfo.vue'], resolve)
        }
      },
      {
        path: 'management-database',
        name: 'management-database',
        title: '数据库',
        icon: 'md-medal',
        component: resolve => {
          require(['./components/management/databaseManager.vue'], resolve)
        }
      },
      {
        path: 'management-env',
        name: 'management-env',
        title: '环境',
        icon: 'md-medal',
        component: resolve => {
          require(['./components/management/envManager.vue'], resolve)
        }
      },
      {
        path: 'management-service',
        name: 'management-service',
        title: '服务',
        icon: 'md-medal',
        component: resolve => {
          require(['./components/management/serviceManager.vue'], resolve)
        }
      },
      {
        path: 'setting',
        name: 'setting',
        title: '设置',
        icon: 'md-settings',
        component: resolve => {
          require(['./components/management/setting.vue'], resolve)
        }
      },
      {
        path: 'auth-group',
        name: 'auth-group',
        title: '权限组',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/authGroup.vue'], resolve)
        }
      },
      {
        path: 'app-list',
        name: 'application',
        title: '应用',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      },
      {
        path: 'buildList',
        name: 'build',
        title: '构建',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      },
      {
        path: 'merchant',
        name: 'merchant',
        title: '商户',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      },
      {
        path: 'nodes_monitor',
        name: 'nodes_monitor',
        title: '节点监控',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      },
      {
        path: 'basic_monitor',
        name: 'basic_monitor',
        title: '基础监控',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      },
      {
        path: 'order_push_monitor',
        name: 'order_push_monitor',
        title: '订单推送监控',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      },
      {
        path: 'pinpoint',

        name: 'pinpoint',
        title: 'pinpoint',
        icon: 'ios-switch',
        component: resolve => {
          require(['./components/management/iframe.vue'], resolve)
        }
      }

    ]
  }
]

export const MainRoute = [
  loginRouter,
  otherRouter,
  locking,
  ...appRouter,
  page401
]
