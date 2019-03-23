import logging, json, ast
from libs import baseview, util
from core.models import SqlOrder
from libs.serializers import OrderDetail
from django.http import HttpResponse
from rest_framework.response import Response
import  traceback;

CUSTOM_ERROR = logging.getLogger('Yearning.core.views')


class order(baseview.BaseView):
    '''

    :argument 我的工单展示接口api

    '''

    def get(self, request, args: str = None):
        try:
            page = request.GET.get('page')
            qurey = json.loads(request.GET.get('query'))
            un_init = util.init_conf()
            custom_com = ast.literal_eval(un_init['other'])
        except KeyError as e:
            CUSTOM_ERROR.error(f'{e.__class__.__name__}: {e}')
        else:
            try:
                start = (int(page) - 1) * 20
                end = int(page) * 20
                if qurey['valve']:
                    if len(qurey['picker']) == 0:
                        info = SqlOrder.objects.filter(username=request.user,
                                                       version__contains=qurey['version'],
                                                       text__contains=qurey['text']).order_by(
                            '-id').defer('sql')[start:end]

                        page_number = SqlOrder.objects.filter(username=request.user,
                                                              text__contains=qurey['text']).only('id').count()
                    else:
                        print("查询")
                        picker = []
                        query_builder= SqlOrder.objects.filter(username=request.user,
                                                       text__contains=qurey['text'],
                                                       version__contains=qurey['version'])
                        for i in qurey['picker']:
                            picker.append(i)
                        if picker[0] == "":
                            info = query_builder.defer('sql').order_by('-id')[start:end]
                        else:
                            info = query_builder.filter(date__gte=picker[0], date__lte=picker[1]).defer('sql').order_by(
                                '-id')[start:end]

                        page_number = SqlOrder.objects.filter(username=request.user,
                                                              text__contains=qurey['text']).only('id').count()
                else:
                    info = SqlOrder.objects.filter(username=request.user).defer('sql').order_by('-id')[start:end]
                    page_number = SqlOrder.objects.filter(username=request.user).only('id').count()

                data = util.ser(info)
                return Response({'page': page_number, 'data': data, 'multi': custom_com['multi']})
            except Exception as e:
                CUSTOM_ERROR.error(f'{e.__class__.__name__}: {e}')
                return HttpResponse(status=500)


