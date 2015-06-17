# Import the UserProfile model individually.
from actor.models import *
from django.contrib import admin

class ActorAdmin(admin.ModelAdmin):
  ordering = ('-date_joined',)
  list_display = ('id', 'email', 'first_name', 'last_name', 'signup_method', 
                  'phone_number', 'email_subscribed', 'language', 'last_login', 'date_joined')
  list_filter = ['language', 'partner_status', 'signup_method']
  search_fields = [ 'id', 'username', 'ssn', 'email', 'first_name', 'last_name', 
                     'phone_number', 'alt_phone_number']
  readonly_fields = ['address']
  date_hierarchy = 'date_joined'
  # actions = ['delete_selected', 'export_csv']
  # inlines = [NoteInline]
  fieldsets = [
      ('Basics', {
          'fields': [ 'email', 'is_sellerregistered','seller_commission', 'sales_email', 'is_first', 
                      'email_confirmation', 'email_subscribed', 'lockout_times']
      }),
      #TODO ADD FIRST_NAME AND LAST_NAME FROM ACTOR> AS OF NOW IT COMES FROM USE AND NOT POSSIBLE SOMEHOW?!!!
      (None, {'fields': ['first_name', 'last_name']}),
      (None, {'fields': ['ssn']}),
      (None, {'fields': ['address']}),  
      # (None, {'fields': ['company']}), 
      (None, {'fields': ['phone_number']}),
      ('Alternative contact information', {
          'fields': ['alt_phone_number', 'alt_email'], 'classes': ['collapse']
      }),
      ('Online information', {
          'fields': ['skype', 'twitter','website', 'blog'],
          'classes': ['collapse']
      }),
      (None, {'fields': ['linkedin_name', 'linkedin_ref']}),      
      ('Description', {
          'fields': ['description']
      }),
      ('Localization', {
          'fields': ['language', 'currency', 'timezone', 'Registration_IPnumber', 'Login_IPnumber']
      }),      
      # ('Partner information', {
      #     'fields': ['partner_status', 'partner_commission', 'pkb_email', 'partner'], 
      #     'classes': ['collapse']
      # }),
      ('Client ID', {
          'fields': ['google_client_id']
      }),
      # ('Invoice detail', {
      #     'fields': ['invoice_limit']
      # }),
      ('Date information', {
          'fields': ['last_login', 'date_joined']
      }),
      ('User API Key', {
          'fields': ['secret_key', 'access_key', 'actor_key'], 
          'classes': ['collapse']
      }),      
      ('NOT IN USE', {
          'description': 'These fields will are not currently in use. Only for future purpose!', 
          'fields': ['type', 'category'], 
          'classes': ['collapse']
      }),
      
  ]
  
  list_per_page = 100
  list_max_show_all = 50000

admin.site.register(Actor, ActorAdmin)