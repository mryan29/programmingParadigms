# Meg Ryan
# Mar 10 2018

import cherrypy
import re, json

class DictionaryController(object):

    def __init__(self):
        self.d  = {}

    def GET(self, key = None):
        output = {}
        
        if key is None:
            output['result'] = 'Success'
            value = []
            for key_in_dict in self.d:
                entry = {}
                entry['key']        = key_in_dict
                entry['value']      = self.d[key_in_dict]
                value.append(entry)
            output['entries']       = value
      
        else:
            key = str(key)
            try:
                value               = self.d[key]
                output['key']       = key
                output['value']     = value
                output['result']    = 'Success'
            except KeyError:
                output['result']    = 'Error'
                output['message']   = 'Key not found'
        
        return json.dumps(output)

    def PUT(self, key):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        key        = str(key)
        output     = {}
        
        try:
            self.d[key]         = user_input['value']
            output['result']    = 'Success'
        except KeyError:
            output['result']    = 'Error'
            output['message']   = 'Invalid input'
        return json.dumps(output)

    def POST(self):
        user_input  = cherrypy.request.body.read().decode()
        user_input  = json.loads(user_input)
        output      = {}
        
        try:
            key                 = user_input['key']
            value               = user_input['value']
            self.d[key]         = value
            output['result']    = 'Success'
        except KeyError:
            output['result']    = 'Error'
            output['message']   = 'Invalid input'
        return json.dumps(output)

    def DELETE(self, key = None):
        output = {}
        if key is None:
            self.d              = {}
            output              = {}
            output['result']    = 'Success'
        else:
            key = str(key)
            try:
                del self.d[key]
                output['result']    = 'Success'
            except KeyError:
                output['result']    = 'Error'
                output['message']   = 'Key not found'
        return json.dumps(output)
