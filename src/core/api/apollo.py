import logging
import json
import traceback
import ast
from libs import baseview
from libs.cryptoAES import cryptoAES
from libs import con_database
from core.task import grained_permissions
from libs import util
from rest_framework.response import Response
from django.http import HttpRequest
from django.http import HttpResponse
from django.db import transaction
from libs.serializers import Sqllist
from libs.apollo import ApolloLib
from libs.serializers import Envlist
from libs.serializers import Servicelist
from settingConf import settings

CUSTOM_ERROR = logging.getLogger('Yearning.core.views')


class Apollo(baseview.AnyLogin):
    '''

    :argument 服务管理页面api 接口

    '''

    def get(self, request, args: str = None):
        print(args)
        apollo = ApolloLib()
        return HttpResponse(apollo.rawGet('/' + args))

    def post(self, request, args=None):
        print(request.data)
        apollo = ApolloLib()
        request.data['data']['dataChangeCreatedBy'] = "apollo"
        return HttpResponse(apollo.rawPost('/' + args, request.data['data']))

    def put(self, request, args=None):
        print(request.data)
        apollo = ApolloLib()
        request.data['data']['dataChangeCreatedBy'] = "apollo"
        return HttpResponse(apollo.rawPut('/' + args, request.data['data']))

    def delete(self, request, args=None):
        apollo = ApolloLib()
        return HttpResponse(apollo.rawDelete('/' + args+"?"+request.GET.urlencode()))
