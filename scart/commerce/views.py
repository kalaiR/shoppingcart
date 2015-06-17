import random
import string
import logging
import httplib

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

def testpaypal(request):
  # from paypaladaptive.models import Preapproval
  # from money.Money import Money
  # preapproval = Preapproval()
  # preapproval.money = Money(2000, 'usd')
  # preapproval.save()
  # preapproval.process(next='/home/', displayMaxTotalAmount=True)
  # # Redirect the user to the next_url() value
  # redirect_url = preapproval.next_url()
  from paypaladaptive.models import Payment
  from paypaladaptive.api import ReceiverList, Receiver
  from money.Money import Money
  key = 'APP-80W284485P519543T'
  platform = Receiver(amount=100, email="deepakkuppusamy.gs@gmail.com", primary=False)
  merchant = Receiver(amount=1900, email="deepakkuppusamy.gs@gmail.com", primary=True)
  receivers = ReceiverList([platform, merchant])

  p = Payment()
  p.money=Money(2000, 'USD')
  p.save()
  p.process(receivers, preapproval_key=key)
  return HttpResponseRedirect('/pay/return/')
    

def test_pay():
    response = paypal.pay(
        actionType = 'PAY',
        cancelUrl = cancelUrl,
        currencyCode = currencyCode,
        senderEmail = EMAIL_ACCOUNT,
        feesPayer = 'EACHRECEIVER',
        memo = 'Simple payment example',
        preapprovalKey = 'PA-0HA01893HK6322232',
        receiverList = { 'receiver': [
            { 'amount':"10.0", 'email':API_EMAIL, 'primary':True },
            { 'amount':"5.0", 'email':SECONDARY_EMAIL, 'primary':False }
        ]},
        clientDetailsType = { 'customerId': 1, 'customerType': 'Normal' },
        returnUrl = returnUrl,
        ipnNotificationUrl = notificationUrl
    )
#     if response['responseEnvelope']['ack'] == "Success":
    print response['responseEnvelope']['ack']
#     if response['paymentExecStatus'] == "COMPLETED":
    print response['paymentExecStatus']
#     if response.has_key('payKey'):
    print response['payKey']
    print response

# Util Functions - Format the Redirect Url #   
def format_redirect_url(redirect_path, query_string):
    ''' utility to format redirect url with fixido query string
    '''
    stop_popup = True if 'st=' in query_string else False
    
    url_join_str = '?'
    if url_join_str in redirect_path:
        redirect_path, qs = redirect_path.split(url_join_str, 1)
        query_string = qs + '&' + query_string
    
    qs = {}
    for q in query_string.split('&'):
        if '=' in q:
            k, v = q.split('=', 1)
            qs[k] = v
    
    if stop_popup:
        if qs.has_key('zr'): del qs['zr']
        if qs.has_key('lr'): del qs['lr']
        if qs.has_key('ler'): del qs['ler']
        if qs.has_key('thanks'): del qs['thanks']
    
    query_string = ''
    for k in qs:
        query_string += k + '=' + qs[k] + '&'
        
    return redirect_path + url_join_str + query_string[:-1]    

# AddTo the Basket item in Cart#
def addToBasket(request, redirect=None):
  ''' Add leads to Basket
  '''
  # if request.method != 'POST':
  #   redirect = '/search/?q=' + request.GET.get('q', '')
  #   return HttpResponseRedirect(redirect)
  
  if redirect is None:
    redirect = request.GET.get('next', '/search/')

  if request.user.is_authenticated():
    query_string = ''
    try:
      actor = request.user.actor
      if 'selected_listpage' in request.POST:
        product_id = request.POST.get('selected_listpage')[0] \
          if isinstance(request.POST.get('selected_listpage'), list) \
          else request.POST.get('selected_listpage')
      else:
        product_id = request.POST.get('selected_shopsingle')[0] \
          if isinstance(request.POST.get('selected_shopsingle'), list) \
          else request.POST.get('selected_shopsingle')

      print 'product_id==>', product_id          
      product = Product.objects.get(pk=int(product_id)) 
      print 'product==>', product
      
      # if BasketLine.objects.filter(product=product, basket__actor=actor).exists():
      #     return HttpResponseRedirect('/list')
      
      # if actor.actorboughtlead_set.filter(lead=lead).exists():
      #     return HttpResponseRedirect(redirect)
      
      # if actor.actorprovidedlead_set.filter(lead=lead).exists():
      #     return HttpResponseRedirect(redirect)

      # actor = Actor.objects.get(pk=int(request.user.id))
      # lead_id = request.POST.get('selected_lead')
      # lead = Lead.objects.get(pk=int(lead_id)) 
      # leadsboughts = ActorBoughtLead.objects.filter(actor=int(request.user.id), lead = lead )
      # providedlead = ActorProvidedLead.objects.filter(actor=int(request.user.id), lead = lead)
      # basketline = BasketLine.objects.filter(lead=lead, basket__actor=request.user.actor)
      # basket = Basket.objects.get_or_create(actor=actor, status='active')
      # basketline = BasketLine()
      # basketline.basket = basket[0]
      # basketline.lead = lead
      # basketline.save()
      
      # basket = Basket.objects.get(actor=actor, status='active')
      # basketline = BasketLine.objects.filter(basket=basket)      
      # actor_basket = Basket.get_actor_basket(actor, basket, basketline) 
      # basket.total = actor_basket['total']
      # basket.total_tax = actor_basket['vat_total']
      # basket.total_quantity = BasketLine.objects.filter(basket=basket).count()
      # basket.save()
      # data = serializers.serialize('json', BasketLine.objects.filter(basket=basket))
      # return HttpResponse(simplejson.dumps(data))
      basket, created = Basket.objects.get_or_create(actor=actor, status__iexact='active')
      basketline = BasketLine()
      basketline.basket = basket
      basketline.product = product      
          
      if 'selected_listpage' in request.POST:
          if BasketLine.objects.filter(product=product, basket__actor=actor).exists():
            defaultquantity = request.POST.get('def_quantity')
            getbasketline = BasketLine.objects.get(product=product, basket__actor=actor)
            getbasketline.quantity = getbasketline.quantity + int(defaultquantity)
            getbasketline.save()
          else:
            basketline.save()                  
            basket.total_quantity = BasketLine.objects.filter(basket=basket).count()
      elif 'selected_shopsingle' in request.POST:
          if BasketLine.objects.filter(product=product, basket__actor=actor).exists():
            defaultquantity = request.POST.get('def_quantity')
            getbasketline = BasketLine.objects.get(product=product, basket__actor=actor)
            getbasketline.quantity = getbasketline.quantity + int(defaultquantity)
            getbasketline.save()
          else:
            defaultquantity = request.POST.get('def_quantity')
            basketline.quantity = int(defaultquantity)
            basketline.save()
            basket.total_quantity = BasketLine.objects.filter(basket=basket).count()

      basketline = BasketLine.objects.filter(basket=basket)     
      actor_basket = Basket.get_actor_basket(actor, basket, basketline)
      basket.total = actor_basket['total']
      basket.total_tax = actor_basket['vat_total']          
      basket.save()              

    except Exception, e:
      # log.error("Error in addToBasket (%s)" % e)
      print 'outofexcept', e
      pass
      
  else:
    query_string = 'lr=2'
      
  # if '/search/' in redirect and 'q=' not in redirect:
  #   query_string = 'q=' + request.GET.get('q', '')
  
  redirect_url = format_redirect_url(redirect, query_string)
  return HttpResponseRedirect(redirect_url+'&addleadtobasket=1')
@login_required
def removeItemFromBasket(request):
  ''' Remove leads from Basket
  '''
  if request.method == 'POST':
    actor = request.user.actor
    basketline_ids = request.POST.getlist('selected_basketline')
    print basketline_ids

    for basketline_id in basketline_ids:      
      producttotalprice = 0
      getbasketline = BasketLine.objects.get(pk=int(basketline_id))      
      getbasket = Basket.objects.get(pk=int(getbasketline.basket_id), status='active')
      getproductdetail = Product.objects.get(pk=int(getbasketline.product_id))
      getbasket.total_quantity = getbasket.total_quantity - getbasketline.quantity
      producttotalprice = getbasketline.quantity * getproductdetail.product_price
      getbasket.total = int(getbasket.total) - int(producttotalprice)
      getbasket.save()
      BasketLine.objects.get(pk=int(basketline_id)).delete()
    return HttpResponseRedirect('/tickets/list/?deleteleadfrombasket=1') 


@login_required
def checkout(request):
  actor = request.user.actor
  error_status = request.GET.get('st', 0)
  error_message = None
  
  if int(error_status) == 1:
    error_message = _("Account balance is low, " + 
      "please make a deposit before you checkout")
  
  elif int(error_status) == 2:
    error_message = "Leads Selected Are No Longer Avilable"
      
  if request.user.is_authenticated():  
    actor_basket = Basket.get_actor_basket(actor)
    basket = actor_basket['basket']
    basketline = actor_basket['basket_lines']
    vat_total = actor_basket['vat_total']
    subtotal = actor_basket['sub_total']
    total = actor_basket['total']
    vat = 100 * actor_basket['vat_percent']

    return render_to_response('commerce/checkout.html', {
        'basketline':basketline, 'basket':basket, 
        'vat': int(vat), 'vat_total':vat_total, 
        'subtotal':subtotal, 'total':total, 
        'error_message':error_message, 
      }, context_instance=RequestContext(request))