import json

from urllib2 import quote
from django.db import models
from django.http import HttpResponseRedirect
from django.http import HttpResponse
from django.core import serializers
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.csrf import ensure_csrf_cookie, csrf_exempt, csrf_protect

from django.core.serializers.json import DjangoJSONEncoder
from django.utils import simplejson
from django.conf import settings
from django.db.models import get_app, get_models, get_model
from django.template import RequestContext
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import cache_control
from django.views.generic.simple import direct_to_template

from core import config

class RestJSONEncoder(DjangoJSONEncoder):

  def default(self, o):
    if isinstance(o, models.Model):
      return dict((k,v) for k,v in vars(o).iteritems() if not k.startswith('_'))
    else:
      return super(RestJSONEncoder, self).default(o)



@csrf_exempt #FIXIT: Its Crime, quick solution for supporting POST via AJAX
def handler(request, app, model, action='', pk=0, view='', template='' ):
  """
  Handel all REST request. It supports following actions via REST API
  
  Actions
  =======
  * List: /rest/[app_name]/[model_name]/ - List all objects in the model
  * Get: /rest/[app_name]/[model_name]/[ID]/ - Get object for the give id, if no values found for the object, it will throw exception
  * Update: /rest/[app_name]/[model_name]/update/[ID]/ - Update a model object with given values on POST params
  * Delete: /rest/[app_name]/[model_name]/update/[ID]/ - Deletes the model object of given ID
  * Custom Views: /rest/[app_name]/[model_name]/[viewname]/ - Performs custom logics from the view class and return the result
  
  
  Example Usage
  =============
  $.post('/rest/actors/Consumer/new/?o=json', {'name':'Actor Name 1'}, function(){console.log(arguments)}, 'json')
  $.post('/rest/actors/Consumer/new/?o=json', {'name':'Actor Name 2'}, function(){console.log(arguments)}, 'json')
  $.post('/rest/control/ActorBoughtLead/new/?o=json', {'i_want':'i_want1','categories':'categories 1','keywords':'keywords 1','region':'region 1' }, function(){console.log(arguments)}, 'json')
  $.post('/rest/actors/Consumer/update/1/?o=json', {'name':'Actor Name Updated'}, function(){console.log(arguments)}, 'json')
  
  wordpressplugin
    =============
   $.post('http://192.168.1.12:8000/rest/leads/custom_fixidoleadgen/?jsoncallback=?&o=json', {'title':'title'}, function(){console.log(arguments)}, 'json')
   $.post('http://192.168.1.12:8000/rest/leads/consumer/add/?jsoncallback=?&o=json', {'first_name':'first_name'}, function(){console.log(arguments)}, 'json')
   
  $.getJSON('/rest/actors/Consumer/delete/2/?o=json', function(){console.log(arguments)})
  $.getJSON('/rest/actors/Consumer/list/?o=json', function(){console.log(arguments)})
  
  Cross Domain Support
  --------------------
  $.post('http://localhost:8000/rest/actors/Consumer/new/?jsoncallback=?&o=json', {'name':'Actor Name 123'}, function(){console.log(arguments)}, 'json')
  $.post('http://localhost:8000/rest/actors/Consumer/update/1/?jsoncallback=?&o=json', {'name':'Actor Name 123 Updated'}, function(){console.log(arguments)}, 'json')
  $.getJSON('http://localhost:8000/rest/actors/Consumer/delete/2/?jsoncallback=?&o=json', function(){console.log(arguments)})
  $.getJSON('http://localhost:8000/rest/actors/Consumer/list/?jsoncallback=?&o=json', function(){console.log(arguments)})
  $.getJSON('http://192.168.1.11:8000/rest/leads/leadcategory/list/?jsoncallback=?&o=json', function(){console.log(arguments)})
  
  
  """
  
  @csrf_protect
  def get(request, model, pk, template=''):
  
    (is_new, item) = get_model_object(request, model, pk)
    #TODO: Handle None object case
    
    data = get_formated_data(request, get_object_dict(item), {}, None, False)
    return process_request_data(request,data) or \
         direct_to_template(request, get_template_path(model,'get') if template == '' else template,
                  {'item': data})
  
  
  #@login_required
  @csrf_protect
  def delete(request, model, pk, template=''):
    (is_new, item) = get_model_object(request, model, pk)
    if item:
      item.delete()
      
    data = get_formated_data(request, {'status':True, 'pk':pk}, {}, None, False)
    return process_request_data(request,data) or \
         direct_to_template(request, get_template_path(model,'get') if template == '' else template,
                  {'item': data})
    
  #@login_required
  def update(request, model, pk=None, template=''):
  
    (is_new, item) = get_model_object(request, model, pk)
    #TODO: Handle Null object case
    
    if item:
      local_fields = model._meta.get_all_field_names()#[f.attname for f in model._meta.local_fields]
      local_fields = list(set(local_fields + [f.attname for f in model._meta.local_fields]))      
      for field in local_fields:
        if field in request.REQUEST and field != "pk":
          val = request.REQUEST[field]
          #FIXIT: it must read from only POST
          setattr(item, field, val)
          
      item.save()
      
    data = get_formated_data(request, get_object_dict(item), {}, None, False)

    if '_post_save_action' in request.REQUEST:
      namespace = get_namespace(model)
      view = request.REQUEST['_post_save_action']
      view_class = __import__(namespace.split('.')[0] + '.views', globals(), locals(), ['fixido'])
      view_method = getattr(view_class, 'action_rest_'+view)
      data = view_method(request, item, data)


    return process_request_data(request,data) or \
         direct_to_template(request, get_template_path(model,'get') if template == '' else template,
                  {'item': item})


  
  try:
    model = get_model(app, model)
    
    filter = request.GET.get('f', '')
    select = request.GET.get('s', '')
    related = request.GET.get('r', '')
    limit = request.GET.get('l', '')
    orderby = request.GET.get('ob', '')
    
    if action == 'get':
      return get(request, model, pk, template)
    elif action == 'list':
      return list_data(request, model, select, filter, related, limit, template, orderby)
    elif action == 'update':
      return update(request, model, pk, template)
      #TODO: Do batch update, which updates data in many models and many rows
    elif action == 'delete':
      return delete(request, model, pk, template)
    elif action == 'custom':
      return custom_view(request, model, select, filter, related, limit, template, orderby, view)
    
  except Exception as e:
    if settings.DEBUG:
      raise e
    else:
      return error_response(request, model, select, filter, related, limit, template, e.__str__())  
    

def get_formated_data(request, data, params=None, related=None, partial=True, error=None):
  
  partial_result = {
    'data':data,
    'params':params,
    'related':related,
    'error':error
  }
  
  result = {
    'version':config.API_VERSION,
    'content':partial_result
  }

  if not partial:
    format = request.GET.get('o','json')
    jsback = request.GET.get('jsoncallback', '')
    
    params = partial_result["params"]
    if not  'q' in params:
      qs = request.META['QUERY_STRING'];
      if jsback != '':
        qs = '&'.join(request.META['QUERY_STRING'].split('&')[2:-1])
       
      params['q'] = qs;
     
    for (k,v) in request.GET.iteritems():
      if k not in ['o', 'jsoncallback']:
        params[k] = v
       
  
    partial_result["params"] = params
  
  return partial_result if partial  else result

def get_namespace(model):
    return "{0}.{1}".format(model._meta.app_label, model._meta.object_name)

def get_template_path(model, action):
  return ("%s/%s/%s.html") % (model.__module__.split('.')[0],  model.__name__.lower(), action)

def process_request_data(request, data, params=None, error=None):
   
  format = request.GET.get('o','html')
  
  if request.is_ajax() or format != 'html':
    format = request.GET.get('o','json')
    jsback = request.GET.get('jsoncallback', '')
  
    if format == 'xml':
      mimetype = 'application/xml'
    else:
      mimetype = 'application/javascript'

    if error:
      data["error"] = error
    
    if format == "json":
      data =  json.dumps(data, cls=DjangoJSONEncoder)
    else:
      data = serializers.serialize(format, data)
    
    if jsback != '':
      data = ("%s(%s)") % (jsback, data)
           
    return HttpResponse(data,mimetype)
  
  return None

def error_response(request, model, select='*', filter='', related='', limit='', template='', errors=''):
    params = {'pk_name': model._meta.pk.attname, 'namespace':get_namespace(model)}
    items = get_formated_data(request, None, params, error=errors)
     
    return process_request_data(request,items, params) or \
           direct_to_template(request, get_template_path(model,'list') if template == '' else template,
                              {'items': items})
  
def get_related_data(request, model, data, model_data, related_model_names):
     
  fields = model._meta.get_all_field_names()
  local_fields = [f.attname for f in model._meta.local_fields]
  related_fields = [f.var_name for f in model._meta.get_all_related_objects()]
  id_list = [d[model._meta.pk.attname] for d in model_data]
  related_model_names = [r.lower() for r in related_model_names]
   
   
  for related_model_name in related_model_names[:]:
    related_object = None
    related_data = None
    params = {}
     
    if related_model_name in related_fields:
      related_object = model._meta.get_field_by_name(related_model_name)[0].model
      params = {model._meta.module_name+'__in':id_list}
      related_data = list(related_object.objects.filter(**params).values())
       
    elif related_model_name in fields:
      related_object = model._meta.get_field_by_name(related_model_name)[0].rel.to
      relation_name = related_model_name + '_id'
      related_ids = [d[relation_name] for d in model_data]
      params = {'pk__in':related_ids}
      related_data = list(related_object.objects.filter(**params).values())
     
    else:
      continue
     
    namespace = get_namespace(related_object)
    (k,v) = params.popitem()

    filter = "f="
    if len(v) == 1:
      filter = filter+k.replace('__in','')+ "=" + str(v[0])
    else:
      filter = filter+k+"="+"|".join(map(str,v))
       
    params = {'f':filter, 'q':'o=json&'+filter, 'pk_name':related_object._meta.pk.attname, 'namespace':namespace}
    
    if data['content']['related'] is None:
      data['content']['related'] = {}
    
    data['content']['related'][namespace] = get_formated_data(request, related_data, params)
    related_model_names.remove(related_model_name)
     
    if(len(related_model_names) > 0):  
      data = get_related_data(request, related_object, data, related_data, related_model_names)      
       
  return data  

   

def list_data(request, model, select='*', filter='', related='', limit='', template='', orderby=''):
 
  items = model.objects
   
  if filter == '':
    items = items.all()
  else:
    keys = ((k.split('=') for k in filter.split(',')))
     
    filters = {}
    for (k,v) in keys:
      if (v.find('|') > 0):
        v = v.split('|')
      filters[k.encode('ascii', 'ignore')] = v
       
    items = items.filter(
      **filters
    )
     
  if orderby !='':  
    oby = orderby.split(',')  
    items = items.order_by(*oby)
    
  if limit !='':
    (s,e) = limit.split(':')
    if e == '' or int(e) == 0:
      items = items[int(s):]      
    else:
      items = items[int(s):int(e)]
   
  if select != '':
    items = items.values(*(select.split(',')))
  else:
    items = items.values()
       
  params = {'pk_name': model._meta.pk.attname, 'namespace':get_namespace(model)}
  
  data = list(items)
  items = get_formated_data(request, data, params, None, False)
   
  if related != '':  
    items = get_related_data(request, model, items, data, related.split(',') )
   
  return process_request_data(request,items, params) or \
       direct_to_template(request, get_template_path(model,'list') if template == '' else template,
                {'items': items})
                


def custom_view(request, model, select='*', filter='', related='', limit='', template='', orderby='', view=''):
   
    namespace = get_namespace(model)
    view_class = __import__(namespace.split('.')[0] + '.views', globals(), locals(), ['fixido'])
    view_method = getattr(view_class, 'rest_'+view)
    items = view_method(request, model, select, filter, related, limit, template, orderby)
    
    params = {'pk_name': model._meta.pk.attname, 'namespace':namespace}
    items = get_formated_data(request, items, params, None, False)

    return process_request_data(request,items, params) or \
           direct_to_template(request, get_template_path(model,'list') if template == '' else template,
                              {'items': items})
           
def post_multipart(host, selector, fields, files):
    content_type, body = encode_multipart_formdata(fields, files)
    h = httplib.HTTPConnection(host)
    headers = {
        'User-Agent': 'INSERT USERAGENTNAME',
        'Content-Type': content_type
        }
    h.request('POST', selector, body, headers)
    res = h.getresponse()
    return res.status, res.reason, res.read()
                
def get_model_object(request, model, pk=None):
  is_new = pk == None or len(pk) == 0 or pk == 0

  if is_new:
    item = model()
  else:
    try:
      item = model.objects.get(pk=pk)
    except ObjectDoesNotExist:
      item = None
      
  return (is_new, item)
  
def get_object_dict(item):
  return dict([(k,v) for k,v in vars(item).iteritems() if not k.startswith('_')])   


def write_error(self, status_code, **kwargs):
    if (not self.settings.get("debug")):
      static_path = 'templates/400.html'
      filename = None

      if status_code >= 400 and status_code <500:
        filename = '4xx'
      elif status_code >= 500 and status_code <600:
        filename = '5xx'

    #super(RequestHandler, self).write_error(status_code, **kwargs)
    self.set_header('Content-Type', 'text/plain')
    if "exc_info" in kwargs:
      for line in traceback.format_exception(*kwargs["exc_info"]):
          self.write(line)
    else:
      self.write("Something wrong")
    self.finish()