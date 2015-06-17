from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^addtobasket/', 'commerce.views.addToBasket', name='addtobasket'),
    url(r'^removeItemFromBasket/', 'commerce.views.removeItemFromBasket', name='removeItemFromBasket'),
    # url(r'^paymentType/', 'commerce.views.process_checkout_basket', name='paymentType'),
    # url(r'^showcheckout/', 'commerce.views.showcheckout', name='show_checkout'),
    url(r'^checkout/', 'commerce.views.checkout', name='checkout'),
    url(r'^testpaypal/', 'commerce.views.testpaypal', name='testpaypal'),
    # url(r'^feedback/', 'commerce.views.feedback'),    
    # url(r'^receipt/(?P<sid>\w+)/(?P<order_number>\d+)/', 'commerce.views.receipt', name='receipt'),
    # url(r'^invoice/(?P<sid>\w+)/(?P<lead_id>\d+)/(?P<order_number>\d+)/', 'commerce.views.invoice', name='invoice'),
    # url(r'^pdf/(?P<sid>\w+)/(?P<order_number>\d+)/(?P<lead_id>\d+)/$', 'commerce.views.generate_pdf', name='generatepdf'),
    # url(r'^pdf/(?P<sid>\w+)/(?P<order_number>\d+)/$', 'commerce.views.generate_pdf', name='generatepdf'),    
    # url(r'^actorinvoice/$', 'commerce.views.actor_invoice', name='actorinvoice'),
)


