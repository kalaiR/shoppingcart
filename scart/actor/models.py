import time
import uuid
from django.db import models
from django.db.models import Q
from django.db.models.signals import pre_save, post_save
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User
from django.utils.translation import ugettext as _
from django.conf import settings

from core import helper
from core.config import COUNTRIES, LANGUAGES, COUNTRIES_DICT
from core.config import COUNTRY_CURRENCIES, LANGUAGE_CURRENCIES

def make_uuid():
    return str(uuid.uuid4().hex)

def remove_none(field, empty_str=''):
    ''' This utility remove none and select strings
    '''
    try:
        if not field or field.lower() == 'none' or field.lower() == 'select':
            return empty_str
    except Exception, e:
        pass
    return field    

class Actor(User):

  ssn = models.CharField(max_length=32, default='', blank=True, help_text="Social security number")
  address = models.CharField(max_length=150, null=True, blank=True, help_text="Actor full address information")  
  phone_number = models.CharField(max_length=32, default='', blank=True, help_text="Actor main phone number (Format: + and country-code eg +4670323435)") 
  alt_phone_number = models.CharField(max_length=32, default='', blank=True, help_text="Actor alternative phone number")
  alt_email = models.EmailField(default='', blank=True, help_text="Actor alternative email")
  skype = models.CharField(max_length=128, default='', blank=True, help_text="Actor Skype ID")
  twitter = models.CharField(max_length=128, default='', blank=True, help_text="Actor Twitter account")
  website = models.URLField(max_length=200, default='', blank=True, help_text="Actor Website URL")
  blog = models.URLField(max_length=200, default='', blank=True, help_text="Actor Blog URL")   
  linkedin_name = models.CharField(max_length=128, default='', blank=True, help_text="Actor LinkedIn account name") 
  linkedin_ref = models.CharField(max_length=128, default='', blank=True, help_text="Actor LinkedIn reference number")
  description = models.TextField(blank=True, help_text="More information about Actor")     
  language = models.CharField(max_length=8, choices=LANGUAGES, default='', blank=True, help_text="Stored as ISO codes (Sv, En, etc) in the DB")
  timezone = models.CharField(max_length=10, default='UTC+01:00', blank=True, help_text="UTC TimeZone <a href='http://en.wikipedia.org/wiki/Time_zone' target='_blank'>(http://en.wikipedia.org/wiki/Time_zone)</a>, eg UTC+01:00 for London")
  invite_code = models.CharField(max_length=16, default='', blank=True, help_text="invite code")
  updated_on = models.DateTimeField(auto_now=True, auto_now_add=True, help_text="Auto generated by system")
  # rating = models.ForeignKey('actors.ActorRating', null=True, blank=True, help_text="Rating done by User")
  lockout_times = models.CharField(max_length=10, default='', blank=True, help_text="lockout times")
    
  def create_actor_number():
      try:
          return int(Actor.objects.order_by('-id')[0].actor_key) + 1
      except:
          return 5001

  actor_key = models.CharField(max_length=128, default=create_actor_number, help_text="Actor unique key key used for identification")
  secret_key = models.CharField(max_length=128, default=make_uuid, help_text="Actor unique secret key used to identify the Actor in API calls")
  access_key = models.CharField(max_length=128, default=make_uuid, help_text="Actor unique access key used to identify the Actor in API calls")

  confirmation_key = models.CharField(max_length=128, default=make_uuid, help_text="Registered user validate email")
  email_confirmation = models.BooleanField(default=False, help_text="To Check if User validated email")    
  type = models.CharField(max_length=128, default='', blank=True, help_text="NOT IN USE")
  category = models.CharField(max_length=128, default='', blank=True, help_text="NOT IN USE")

  partner_status = models.BooleanField(default=False, blank=False, help_text="Describe whether the actor is partner of Fixido. If Actor is partner, True will be stored. False is the default value.")
  partner_commission = models.FloatField(default=0.0, help_text="Commission percentage allocated to Fixido partner")  
  # partner = models.ForeignKey('actors.Actor', related_name='partner_from', limit_choices_to = {"partner_status": "true"}, null=True, blank=True, help_text="This actor is connected to Fixido partner.")
  #To Check if User Logged in for the first time
  is_first = models.BooleanField(default=True, help_text="To Check if user logged in for the first time.")
  signup_method = models.CharField(max_length=128, default='', blank=True, help_text="Determine how the user is registered in Fixido")
  pkb_email = models.BooleanField(default=True, verbose_name='Send partner kickback email', help_text="To check e-mail should be sent to partner")

  email_subscribed = models.BooleanField(default=True, help_text="Subscribe to notice e-mail")
  sales_email = models.BooleanField(default=True, help_text="To check e-mail should be sent to seller")
  is_sellerregistered = models.BooleanField(default=False, help_text="To check if user registered for seller account.")
  
  Login_IPnumber = models.CharField(max_length=100, default='', blank=True, help_text="stores user ip when log in.")
  Registration_IPnumber = models.CharField(max_length=100, default='', blank=True, help_text="stores user ip when registration.")
  
  google_client_id = models.CharField(max_length=50, default='', blank=True, help_text="Google client ID.")
  seller_commission = models.FloatField(default=-1.0, help_text="Seller commission percentage. Standard 50, 40, 30 or -1 for 0 commission")

  currency = models.CharField(max_length=6, default=settings.BASE_CURRENCY, help_text="Actor's currency in ISO format")
  # objects = ActorManager() 
  
  def clean(self):
    self.first_name = remove_none(self.first_name)
    self.last_name = remove_none(self.last_name)
    self.language = remove_none(self.language)
    self.description = remove_none(self.description)
    self.phone_number = remove_none(self.phone_number)
    self.alt_phone_number = remove_none(self.alt_phone_number)
    self.email = remove_none(self.email)

  def save(self, force_insert=False, force_update=False):
    self.clean()
    self.username = self.email
    if not self.currency:
      currency = settings.BASE_CURRENCY

      if self.language and self.language in LANGUAGE_CURRENCIES:
        currency = LANGUAGE_CURRENCIES[self.language]
      elif self.address and self.address.country and \
        self.address.country in COUNTRY_CURRENCIES:
        currency = COUNTRY_CURRENCIES[self.address.country]

      self.currency = currency

    if not self.lockout_times:
      self.lockout_times = 0
    super(Actor, self).save(force_insert, force_update)


  @staticmethod
  def default_data():
    """
      This method will be called whenever the database is created (after syncdb)      
    """
    pass

def create_user(sender, instance, created, **kwargs):
    """
    Post Save Signal To Create Actor Details For Social Network User Login
    """    
    if created:
        user = User.objects.all().order_by('-id')[0]
        actor = Actor(user.pk)
        actor.username = user.username
        actor.first_name = user.first_name
        actor.last_name = user.last_name
        actor.email = user.email
        actor.save()

post_save.connect(create_user, sender=User)