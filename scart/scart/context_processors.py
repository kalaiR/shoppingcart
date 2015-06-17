# from util import get_global_language
# from core.config import LANGUAGE_CURRENCIES

def basketcontext(request):
    from actor.models import Actor
    from commerce.models import Basket, BasketLine

    basketline = None
    currency = None #CurrencyExchangeRate.BaseCurrency()
    
    try:
        actor = Actor.objects.get(pk=int(request.user.id))
        if actor.currency:
            currency = actor.currency

        try:
            basket = Basket.objects.get(actor=actor, status='active')
            basketline = BasketLine.objects.filter(basket=basket)
        except:
            basket = None
            basketline = None
    except:
        pass

    # if currency is None:
    #     lang = get_global_language(request)
    #     if lang and lang in LANGUAGE_CURRENCIES:
    #         currency = LANGUAGE_CURRENCIES[lang]

    # if currency is None:
    #     currency = CurrencyExchangeRate.BaseCurrency()

    # if currency:
    #     currency = currency.upper()

    return {'basketline':basketline}