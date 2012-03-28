from model import Image, CursorWrapper
from webhelpers import paginate
from pyramid.httpexceptions import HTTPNotFound

def index(request):
    if request.method == 'GET':
        cursor = Image.objects.all()
        #p = request.params.get('page',1)
        #page = paginate.Page(CursorWrapper(cursor), items_per_page=20, page=p, url=paginate.PageURL_WebOb(request))
        #return {'pager':page}
    else:
        q = request.POST.get('q')
        cursor = Image.objects(title__icontains=q)
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
    
def search_autocomplete(request):
    q = request.GET.get('term')
    if q:
        search_results = Image.objects(title__icontains=q)
        result = [{'id':res.title, 'value':res.title} for res in search_results]
        return result
    
def search(request):
    q = request.POST.get('q')
    if q:
        cursor = Image.objects(title__icontains=q)
        if cursor:
                p = request.params.get('page',1)
                page = paginate.Page(CursorWrapper(cursor), items_per_page=20, page=p, url=paginate.PageURL_WebOb(request))
                return {'pager':page}
        