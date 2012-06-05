from model import Image, Comment, CursorWrapper
from common import remove_tags, name_file, img_con, get_image_from_remote

from webhelpers import paginate
from webhelpers.containers import unique

from pyramid.httpexceptions import HTTPNotFound, HTTPFound
from pyramid.response import Response
from pyramid.renderers import render_to_response

import time, json

from os.path import abspath

def index(request):
    if request.method == 'GET':
        cursor = Image.objects.all().order_by('-ctime')
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
        comments_obj = Comment.objects(to_image_name = img_id)
        return {'img':img_obj, 'comments':comments_obj}
    else:
        return HTTPNotFound('Page not found')
    
def search_autocomplete(request):
    q = request.GET.get('term')
    if q:
        search_results = Image.objects(title__icontains=q)
        result = unique([res.title for res in search_results])
        uresult = [{'id':res, 'value':res} for res in result]
        return uresult
    
def search(request):
    q = request.POST.get('q')
    if q:
        cursor = Image.objects(title__icontains=q)
        if cursor:
                p = request.params.get('page',1)
                page = paginate.Page(CursorWrapper(cursor), items_per_page=20, page=p, url=paginate.PageURL_WebOb(request))
                return {'pager':page}
            
def download_img(request):
    file_name = request.POST.get('file_name')
    #f = open('/home/denis/Aptana Studio 3 Workspace/bfolder/bfolder/bfolder/static/img/pack/'+file_name+'_full.jpg')
    f = open(abspath('.')+'/bfolder/static/img/pack/'+file_name+'_full.jpg') 
    return Response(body=f.read(), content_type='application/octet-stream',
                    content_disposition='filename=%s'%f.name.split('/')[-1])

def raiting(request):
    file_name = request.POST.get('oid')
    action = {request.POST.get('action')+'__raiting':1}
    Image.objects(name=file_name).update_one(**action)
    r = Image.objects(name=file_name).first()
    return {'rait':r.raiting}

def add_comment(request):
    comment = request.POST.get('comment')
    comment = remove_tags(comment)
    file_name = request.POST.get('file_name')
    c = Comment(body=comment, time=int(time.time()), to_image_name = file_name)
    c.save()
    return HTTPFound('/full_image/%s' % file_name)

def upload(request):
    try:
        f = request.POST.get(u'files[]').file
        filename = request.POST.get(u'files[]').filename
        title = remove_tags(request.POST.get('title[]'))
        tags = remove_tags(request.POST.get('tags[]'))
        tags = [tag.strip() for tag in tags.split(',')]
        if title:
            n_f = name_file()
            img_con(f, n_f)
            try:
                img = Image(name=n_f, title=title, category='', raiting=0, ctime=int(time.time()), tags=tags)
                img.save()
            except Exception as e:
                print e
            resp = []
            resp.append({'name':filename})
            return Response(json.dumps(resp))
        else:
            resp = []
            resp.append({'name':filename})
            return Response(json.dumps(resp))
    except AttributeError:
        print 'Attribute Error'

def img_from_client(request):
    img_url = request.GET.get('q')
    title = request.GET.get('img_title')
    if not title:
        return Response('Image title required')
    try:
        img = open(get_image_from_remote(img_url))
    except:
        return Response('Bad url')
    n_f = name_file()
    img_con(img, n_f)
    i = Image(name=n_f, title=title, category='', raiting=0, ctime=int(time.time()), tags=[])
    i.save()
    return Response('Job well done')

def get_by_tag(request):
    tag = request.matchdict.get('tag')
    cursor = Image.objects(tags=tag).order_by('-ctime')
    p = request.params.get('page',1)
    page = paginate.Page(CursorWrapper(cursor), items_per_page=20, page=p, url=paginate.PageURL_WebOb(request))
    return {'pager':page}

def table_ajax(request):
    cursor = Image.objects.all().order_by('-ctime')
    p = request.params.get('page',1)
    page = paginate.Page(CursorWrapper(cursor), items_per_page=20, page=p, url=paginate.PageURL_WebOb(request))
    return render_to_response('table.mako',{'pager':page})
    

    
            
            
            
            
            
            
            
            
            
            
        
