import requests
import json
from core.models import (
    globalpermissions
)

url = "http://localhost:8070"
version = "/openapi/v1"
token = "ec26bbcf74812e1fc1931fd0bd6ee417e3f16b2f"


class ApolloLib:
    url = "http://localhost:8070"
    version = "/openapi/v1"
    token = "ec26bbcf74812e1fc1931fd0bd6ee417e3f16b2f"
    headers = {"Authorization": "", "Content-Type": "application/json;charset=UTF-8"}
    endpoint = {
        # 获取全部app
        "ALL_APP": "{portal_address}/openapi/v1/apps",
        # 获取单个app信息
        "APP": "{portal_address}/openapi/v1/apps?appIds={appIds}",
        # 获取App的环境，集群信息
        "APPID": "{portal_address}/openapi/v1/apps/{appId}/envclusters",
        # 获取集群下所有Namespace信息接口
        "ENV_APPID_CLUSTERNAME": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces",
        # 获取某个Namespace信息接口
        "ENV_APPID_CLUSTERNAME_NAMESPACENAME": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}",
        # 创建namespace
        "CREATE_NAMESPACE": "{portal_address}/openapi/v1/apps/{appId}/appnamespaces",
        # 获取某个Namespace当前编辑人接口
        "ENV_APPID_CLUSTERNAME_NAMESPACENAME_LOCK": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}/lock",
        #  新增配置接口
        "ADD_CONFIG": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}/items",
        #  修改配置接口
        "SAVE_CONFIG": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}/items/{key}",
        # 删除配置
        "DELETC_CONFIG": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}/items/{key}?operator={operator}",
        # 发布配置
        "PUBLISH_CONFIG": "{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}/releases",
        # 获取生效配置
        "GET_LATEST_CONFIG": "http://{portal_address}/openapi/v1/envs/{env}/apps/{appId}/clusters/{clusterName}/namespaces/{namespaceName}/releases/latest",
    }

    def __init__(self, url: str = "", version: str = "", token: str = ""):
        apollo_coonfig = globalpermissions.objects.filter(authorization="global").first().apollo
        print(apollo_coonfig)
        self.url = apollo_coonfig['url']
        self.version = self.version if version == "" else version
        self.token = apollo_coonfig['token']
        self.headers['Authorization'] = self.token

    def get(self, url=""):
        print(">>>" + url)
        r = requests.get(url, headers=self.headers)
        print(r.text)

    def rawGet(self, url=""):
        print("RAWGET:>>" + url)
        r = requests.get(self.url + url, headers=self.headers)
        return r.text

    def rawPost(self, url="", data={}):
        print("RAWPOST:>>" + url + json.dumps(data))
        r = requests.post(self.url + url, headers=self.headers, data=json.dumps(data))
        return r.text

    def rawPut(self, url="", data={}):
        print("RAWPOST:>>" + url + json.dumps(data))
        r = requests.put(self.url + url, headers=self.headers, data=json.dumps(data))
        return r.text

    def rawDelete(self, url=""):
        print("RAWDELETE:>>" + url )
        r = requests.delete(self.url + url, headers=self.headers)
        return r.text

    def post(self, url=""):
        requests.get(url, self.headers)

    def get_all_app(self):
        url = self.endpoint['ALL_APP'].format(portal_address=self.url)
        self.get(url)

    def get_env_cluster_info(self, appId=""):
        url = self.endpoint['APPID'].format(portal_address=self.url, appId=appId)
        self.get(url)

    def get_all_namespace(self, env="DEV", appId="", clusterName="default"):
        url = self.endpoint['ENV_APPID_CLUSTERNAME'].format(portal_address=self.url, env=env, appId=appId,
                                                            clusterName=clusterName)
        self.get(url)

    def get_namespace(self, env="DEV", appId="", clusterName="default", namespace="application"):
        url = self.endpoint['ENV_APPID_CLUSTERNAME_NAMESPACENAME'].format(portal_address=self.url, env=env, appId=appId,
                                                                          clusterName=clusterName,
                                                                          namespaceName=namespace)
        self.get(url)

# apollo = ApolloLib(url=url, version=version, token=token)
# apollo.get_env_cluster_info("100008")
# apollo.rawGet(url="/openapi/v1/envs/DEV/apps/SampleApp1/clusters/default/namespaces/application")
#                     /openapi/v1/envs/DEV/apps/100008/clusters/default/namespaces/application

# requests.get(http://localhost:8070)
