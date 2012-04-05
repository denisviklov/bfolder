from pyramid.config import Configurator
from bfolder.resources import Root
from pyramid.events import BeforeRender
from subscribers import add_renderer_globals

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(root_factory=Root, settings=settings)
    config.add_view('bfolder.views.index',
                    context='bfolder:resources.Root',
                    renderer='bfolder:templates/index.mako')
    config.add_route('full_image', '/full_image/{img_id}')
    config.add_view('bfolder.views.full_img', route_name='full_image', renderer='bfolder:templates/full_img.mako')
    config.add_route('download_img', '/download_image')
    config.add_view('bfolder.views.download_img', route_name='download_img')
    config.add_route('search_autocomplete', '/search_autocomplete')
    config.add_view('bfolder.views.search_autocomplete', route_name='search_autocomplete', renderer='json')
    config.add_route('voit', '/voit')
    config.add_view('bfolder.views.raiting', route_name='voit', renderer='json')
    config.add_route('add_comment', '/add_comment')
    config.add_view('bfolder.views.add_comment', route_name='add_comment')
    config.add_static_view('static', 'bfolder:static', cache_max_age=3600)
    config.add_subscriber(add_renderer_globals, BeforeRender)
    return config.make_wsgi_app()
