from django.conf.urls.defaults import *
from django.conf import settings

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns(
    '',

    # Example:
    # (r'^tbb/', include('tbb.foo.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
    # to INSTALLED_APPS to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    (r'^admin/', include(admin.site.urls)),

    (r'^e/(?P<name>[ A-Za-z_0-9]+)$', 'metaize.views.episode'),

    (r'^_/(?P<path>(.+))$', 'django.views.static.serve', {
            'document_root': settings.MEDIA_ROOT
            }),
)
