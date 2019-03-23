# 权限节点
PERM = {
    'ddl': '0',
    'ddlcon': [],
    'dml': '0',
    'dmlcon': [],
    'user': '0',
    'base': '0',
    'person': [],
    'query': '0',
    'querycon': [],
    'env': '0',
    'service': '0',
    # 应用管理
    'application': '0',
    # 构建管理
    'build': '0',
    # 商户管理
    'merchant': '0',
    # 节点监控
    'nodes_monitor':'0',
    # 基础监控
    'basic_monitor':'0',
    # 订单推送监控
    'order_push_monitor':'0',
    # 精准定位
    'pinpoint': '0',
}
# 获取权限节点
def GET_PERM():
    return PERM