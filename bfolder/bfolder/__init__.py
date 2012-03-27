from pyramid.config import Configurator
from bfolder.resources import Root

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(root_factory=Root, settings=settings)
    config.add_view('bfolder.views.index',
                    context='bfolder:resources.Root',
                    renderer='bfolder:templates/index.mako')
    config.add_route('full_image', '/full_image/{img_id}')
    config.add_view('bfolder.views.full_img', route_name='full_image', renderer='bfolder:templates/full_img.mako')
    config.add_static_view('static', 'bfolder:static', cache_max_age=3600)
    return config.make_wsgi_app()
