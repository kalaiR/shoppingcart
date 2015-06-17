from django.conf.urls import patterns, url
    
urlpatterns = patterns('core.rest.handler',
  (r'^(?P<app>\w+)/(?P<model>\w+)/(?P<pk>\d+)/$', 'handler', {'action':'get'}),
  (r'^(?P<app>\w+)/(?P<model>\w+)/(?P<action>\w+)/(?P<pk>\d+)/$', 'handler'),
  (r'^(?P<app>\w+)/(?P<model>\w+)/new/$', 'handler', {'action':'update', 'pk':None}),
  (r'^(?P<app>\w+)/(?P<model>\w+)/list/$', 'handler', {'action':'list'}),
  (r'^(?P<app>\w+)/(?P<model>\w+)/custom/(?P<view>\w+)/$', 'handler', {'action':'custom'}),
  (r'^(?P<app>\w+)/(?P<model>\w+)/custom/(?P<view>\w+)/$', 'handler', {'action':'custom'}),
  (r'^(?P<app>\w+)/(?P<model>\w+)/fixido_lead_gen_plugin/$', 'handler', {'action':'update', 'pk':None}),
  
)
