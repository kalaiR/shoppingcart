from django.contrib import admin
from django.db.models import Q
from django.utils.translation import ugettext_lazy as _
from django.http import HttpResponseRedirect
from django.http import HttpResponse, Http404
from commerce.models import *

class AdminBasket(admin.ModelAdmin):
  list_display = ('actor', 'active', 'status','created')
  search_fields = ['actor__email','active', 'status','basketline__lead__title','basketline__lead__id',]
  date_hierarchy = 'modified'
  readonly_fields = ('actor', )

  fieldsets = [
    ('Basket', {'fields': ['actor', 'active', 'status']}),
  ]
  
  list_per_page = 100

class AdminBasketLine(admin.ModelAdmin):
  list_display = ('basket', 'product', 'quantity', 'created') 
  search_fields = ['basket__actor__email', 'lead__title','lead__id','quantity','basket__actor__username']
  date_hierarchy = 'modified'
  readonly_fields = ('basket', 'product', 'quantity')

  list_per_page = 100  

admin.site.register(Basket, AdminBasket)
admin.site.register(BasketLine, AdminBasketLine)  