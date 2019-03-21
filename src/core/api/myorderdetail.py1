import logging, json, ast
from libs import baseview, util
from core.models import SqlOrder
from libs.serializers import OrderDetail
from django.http import HttpResponse
from rest_framework.response import Response
import traceback;
from django.core import serializers

CUSTOM_ERROR = logging.getLogger('Yearning.core.views')


class myorderdetail(baseview.BaseView):
    '''

    :argument 我的工单展示接口api

    '''

    def get(self, request, args: str = None):
        try:
            order_id = int(args)
        except KeyError as e:
            CUSTOM_ERROR.error(f'{e.__class__.__name__}: {e}')
        else:
            try:
                info = SqlOrder.objects.filter(id=order_id)[0]
                return Response({'data': info.sql})
            except Exception as e:
                print(e)
                CUSTOM_ERROR.error(f'{e.__class__.__name__}: {e}')
                return HttpResponse(status=500)
