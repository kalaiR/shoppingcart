import logging
import traceback
from decimal import Decimal

from django.conf import settings
from templated_email import send_templated_mail
from django.contrib.sites.models import get_current_site

# from actors import actor_ip
# from actors.models import Actor, InvoiceApplication
# from leads.models import Lead, Bid
# from models import *
# from control.models import *
from core import config


def get_vat_percentage(country=None, vat_number=None):
  """Returns vat percentage for the given country."""

  vat = settings.OTHER_COUNTRY_VAT

  if not country:
    vat = settings.SWEDEN_VAT_PERCENT

  elif country.upper() == 'SE':
    vat = settings.SWEDEN_VAT_PERCENT
  
  # elif config.EU_COUNTRIES_DICT.has_key(country.upper()) and not vat_number:
  #   vat = settings.SWEDEN_VAT_PERCENT

  return Decimal(vat)


def calculate_vat(amount, country=None, vat_number=None):
  """Returns vat amount for the given amount and country."""

  if amount == 0:
    return 0

  vat_percent = get_vat_percentage(country, vat_number)

  return Decimal(amount) * vat_percent

