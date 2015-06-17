from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^details/(?P<pk>\d+)/', 'sproductinfo.views.productdetails', name='product_details'),    
    url(r'^list/', 'sproductinfo.views.productlist', name='product_list'),
)