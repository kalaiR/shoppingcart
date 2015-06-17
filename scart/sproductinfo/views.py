import logging
import random
import string

from sproductinfo.models import *
from actor.models import *
from commerce.models import *

# from scart import settings
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from django.core.context_processors import csrf 
from django.views.decorators.csrf import csrf_protect
from django.shortcuts import render_to_response, render, redirect
from django.core.urlresolvers import reverse
from django.template import RequestContext
from django.contrib.auth import authenticate, login
from django.http import HttpResponseRedirect, HttpResponse
from django import forms
from django.contrib.auth.tokens import default_token_generator
from django.utils.translation import ugettext_lazy as _
from django.utils.translation import ugettext, string_concat
from urllib import unquote, urlencode, unquote_plus
from django.conf import settings
from django.utils.encoding import smart_unicode, force_unicode
from django.utils.http import urlquote
from urllib import urlencode
from urllib import unquote_plus


def displayhomepage(request):
    # if request.user.is_authenticated():
    #     return HttpResponseRedirect("/dashboard/start/")
    product=Product.objects.all()
    # recentad=Product.objects.filter().order_by('-id')[:3]
    # path = request.path    
    # locality =Locality.objects.all()
    # banner=SiteBanner.objects.all()
    print 'setting', settings.STATIC_ROOT    
    return render_to_response('sproductinfo/indexshop.html', {'product':product}, context_instance=RequestContext(request)) 

def productdetails(request, pk):
    product=Product.objects.get(pk=int(pk))
    print 'setting-product', product  
    return render_to_response('sproductinfo/shopsingle.html', {'products':product}, context_instance=RequestContext(request))     

def productlist(request):
    products=Product.objects.all()
    if request.user.is_authenticated():
        actor = request.user.actor
        actor_basket = Basket.get_actor_basket(actor)
        basket = actor_basket['basket']
        basketline = actor_basket['basket_lines']
        subtotal = actor_basket['sub_total']
        total = actor_basket['total']
        return render_to_response('commerce/listpageshop.html', {'products':products, 'total':total, 'subtotal':subtotal}, context_instance=RequestContext(request))     
    else:
        return render_to_response('commerce/listpageshop.html', {'products':products}, context_instance=RequestContext(request))    

def searchlist(request):        
      return render_to_response('sproductinfo/search.html', context_instance=RequestContext(request))        

