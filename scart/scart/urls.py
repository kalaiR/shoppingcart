from django.conf.urls import patterns, include, url
from django.contrib import admin
from sproductinfo.views import *
admin.autodiscover()

urlpatterns = patterns('',
    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^(?i)tickets/', include('sproductinfo.urls')),
    url(r'^(?i)tickets/', include('actor.urls')),
    url(r'^(?i)tickets/', include('commerce.urls')),
    url(r'^$', 'sproductinfo.views.displayhomepage', name='home'),
    url(r'^search/', 'sproductinfo.views.searchlist', name='searchlist'),
    # Search & Advance Search     
    # url(r'^(?i)search/', NewAdjodSearchView(
    #   template='searchflow/newquikr_search_v2.html', 
    #   form_class=NewProductSearchFilter, 
    #   #results_per_page=settings.SEARCH_PAGE_NUMBER_OF_LEADS
    # ), name='newsearchPageV2'),
)
