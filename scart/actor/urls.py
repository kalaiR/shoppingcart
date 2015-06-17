from django.conf.urls import patterns, include, url
from django.contrib import admin
from sproductinfo.views import *
admin.autodiscover()

urlpatterns = patterns('',
    # # Uncomment the next line to enable the admin:
    # url(r'^(?i)register/$', 'actor.views.create_new_user', name='createNewUser'),
    url(r'^login/', 'actor.views.login_view', name='login_view'),
    url(r'^logout/', 'actor.views.logout_view', name='logout_view'),      
    url(r'^register/', 'actor.views.create_new_user', name='create_new_user'),
    url(r'^newregister/', 'actor.views.register_form', name='register_form'),
)
