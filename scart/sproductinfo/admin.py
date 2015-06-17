# Import the UserProfile model individually.
from sproductinfo.models import *
from django.contrib import admin

class ProductAdmin(admin.ModelAdmin):
  list_display = ('product_title', 'product_shortdesc', 'product_code', )
  list_filter = ['product_title', 'product_code']
  search_fields = [
      'product_title', 'product_code',
  ]
  fieldsets = [
      ('Basics',            {'fields': ['product_title', 'product_desc', 'product_shortdesc', 'product_code', 'product_status', 'product_category']}),         
      ('Attributes',        {'fields': ['product_attributes']}),
      ('Brands',            {'fields': ['product_brands']}), 
      ('Offers',            {'fields': ['product_offers']}),            
      ('Reviews',           {'fields': ['product_reviews']}),
      ('Images',            {'fields': ['product_images']}),
      ('More Information', {'fields': ['product_price', 'product_currency', 'product_availability', 'product_sale', 'product_presold', 'product_sold', 'product_type']}),
  ]
readonly_fields = ('product_sale', 'product_sold', 'product_presold', 'product_availability')
admin.site.register(Product, ProductAdmin)
admin.site.register(Category)
admin.site.register(Attribute)
admin.site.register(Review)
admin.site.register(Brand)
admin.site.register(Image)
admin.site.register(Order)
# admin.site.register(BasketItem)
admin.site.register(Offer)
admin.site.register(ShippingMethod)