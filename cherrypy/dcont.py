import cherrypy
import re, json

class DictionaryController(object):

    def __init__(self):
        self.d  = {}

    def GET(self, key = None):
        output = {}
        if key is None:
            output['result'] = 'success'
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
                output['result']    = 'success'
            except KeyError:
                output['result']    = 'error'
                output['message']   = 'key not found'
        return json.dumps(output)

    '''
    def GET_KEY(self, key):
        key = str(key)
        try:
            value               = self.d[key]
            output['key']       = key
            output['value']     = value
            output['result']    = 'succcess'
        except KeyError:
            output['result']    = 'error'
            output['message']   = 'key not found'
        return json.dumps(output)
    '''

    def PUT(self, key):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        key        = str(key)
        output     = {}
        try:
            self.d[key]         = user_input['value']
            output['result']    = 'success'
        except KeyError:
            output['result']    = 'error'
            output['message']   = 'invalid input'
        return json.dumps(output)

    def POST(self):
        user_input  = cherrypy.request.body.read().decode()
        user_input  = json.loads(user_input)
        output      = {}
        try:
            key                 = user_input['key']
            value               = user_input['value']
            self.d[key]         = value
            output['result']    = 'success'
        except KeyError:
            output['result']    = 'error'
            output['message']   = 'invalid input'
        return json.dumps(output)

    def DELETE(self, key = None):
        output = {}
        if key is None:
            self.d              = {}
            output              = {}
            output['result']    = 'success'
        else:
            key = str(key)
            try:
                del self.d[key]
                output['result']    = 'success'
            except KeyError:
                output['result']    = 'error'
                output['message']   = 'key not found'
        return json.dumps(output)