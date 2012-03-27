from model import Image, CursorWrapper
from webhelpers import paginate
from pyramid.httpexceptions import HTTPNotFound

def my_view(request):
    return {'project':'bfolder'}

def index(request):
    cursor = Image.objects.all()
    p = request.params.get('page',1)
    page = paginate.Page(CursorWrapper(cursor), items_per_page=20, page=p, url=paginate.PageURL_WebOb(request))
    return {'pager':page}

def full_img(request):
    img_id = request.matchdict.get('img_id')
    if img_id:
        img_obj = Image.objects(name=img_id).first()
        return {'img':img_obj}
    else:
        return HTTPNotFound('Page not found')