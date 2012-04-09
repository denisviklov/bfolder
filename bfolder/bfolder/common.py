import random
import hashlib
from PIL import Image as Img
from os.path import abspath

def remove_tags(input_text):
    s_list = list(input_text)
    i,j = 0,0
    while i < len(s_list):
        if s_list[i] == '<':
            while s_list[i] != '>':
                s_list.pop(i)
            s_list.pop(i)
        else:
            i=i+1
    join_char=''
    return join_char.join(s_list)

def name_file():
    m = hashlib.md5()
    m.update(str(random.randrange(1000000000)))
    file_name = m.hexdigest()
    return file_name

def img_con(f_object, filename):
    f = open(abspath('.')+'/bfolder/static/img/pack/'+filename+'_full.jpg','w')
    f.write(f_object.read())
    f.close()
    f_object.seek(0)
    img = Img.open(f_object)
    '''
    try:
        img.verify()
    except Exception as e:
        return e.message
    '''
    max_x, max_y = 200, 200
    x, y = float(img.size[0]), float(img.size[1])
    if x > max_x or y > max_y:
        r = min(max_x/x, max_y/y)
        img = img.resize([int(s*r) for s in img.size], Img.ANTIALIAS)
    img.save(abspath('.')+'/bfolder/static/img/pack/'+filename+'.jpg')
    return True