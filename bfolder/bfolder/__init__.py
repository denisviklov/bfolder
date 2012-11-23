from pyramid.config import Configurator
from pyramid.events import BeforeRender, NewRequest
from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.session import UnencryptedCookieSessionFactoryConfig

from bfolder.resources import Root, SimpleAdmin
from subscribers import (add_renderer_globals, 
                         set_accepted_languages_locale, add_localizer)

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    authentication_policy = AuthTktAuthenticationPolicy('seekrit')
    authorization_policy = ACLAuthorizationPolicy()
    my_session_factory = UnencryptedCookieSessionFactoryConfig('itsaseekreet')
    config = Configurator(root_factory=Root, settings=settings, 
                          authentication_policy=authentication_policy,
                          authorization_policy=authorization_policy,
                          session_factory = my_session_factory)
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
    config.add_route('upload', '/upload')
    config.add_view('bfolder.views.upload', route_name='upload')
    config.add_route('get_by_tag', '/tag_search/{tag}')
    config.add_view('bfolder.views.get_by_tag', route_name='get_by_tag', renderer='bfolder:templates/index.mako')
    config.add_route('reload_table', '/table_reload')
    config.add_view('bfolder.views.table_ajax', route_name='reload_table')
    config.add_route('img_from_client', '/img_from_client')
    config.add_view('bfolder.views.img_from_client', route_name='img_from_client')
    config.add_view('bfolder.views.img_admin_page', route_name='img_admin_page', context=SimpleAdmin,
                                                                                    permission='add')
    config.add_route('img_admin_page', '/img_admin_page')
    config.add_view('bfolder.views.admin_login', route_name='admin_login')
    config.add_route('admin_login', '/admin_login')
    config.add_static_view('static', 'bfolder:static', cache_max_age=3600)
    config.add_subscriber(set_accepted_languages_locale, NewRequest)
    config.add_subscriber(add_localizer, NewRequest)
    config.add_subscriber(add_renderer_globals, BeforeRender)
    config.add_translation_dirs('bfolder:locale/')
    return config.make_wsgi_app()
