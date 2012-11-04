import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.txt')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = ['pyramid', 'pyramid_debugtoolbar', 'mongoengine', 
	    'pyramid_beaker', 'PIL', 'webhelpers', 'mock']

setup(name='bfolder',
      version='0.0',
      description='bfolder',
      long_description=README + '\n\n' +  CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Pylons",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
        ],
      author='',
      author_email='',
      url='',
      keywords='web pyramid pylons',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      install_requires=requires,
      message_extractors = {'.': [
                  ('**.py', 'lingua_python', None),
                  ('**.pt', 'lingua_xml', None),
                  ('bfolder/templates/**.html', 'mako', None),
                  ('bfolder/templates/**.mako', 'mako', None),
                  ('bfolder/static/**', 'ignore', None),
                   ]},
      tests_require=requires,
      test_suite="bfolder",
      entry_points = """\
      [paste.app_factory]
      main = bfolder:main
      """,
      paster_plugins=['pyramid'],
      )

