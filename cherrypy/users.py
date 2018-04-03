# Meg Ryan
# Mar 10 2018

import cherrypy
import json
from _movie_database import _movie_database

class UserController(object):

    def __init__(self, mdb):
        self.mdb = mdb

    def GET(self, key = None):
        output = {}
        if key is None:
            output['users'] = []
            for uid in self.mdb.users:
                user = {}
                user['zipcode'] = self.mdb.users[uid]['zipcode']
                user['age'] = self.mdb.users[uid]['age']
                user['gender'] = self.mdb.users[uid]['gender']
                user['occupation'] = self.mdb.users[uid]['occupation']
                user['id'] = uid
                user['img'] = self.mdb.get_image(key)
                output['users'].append(user)
            output['result'] = 'success'
        else:
            key = int(key)
            user = self.mdb.get_user(key)
            if user is None:
                output['result'] = 'error'
                output['message'] = 'key not found'
            else:
                output['zipcode'] = user['zipcode']
                output['age'] = user['age']
                output['gender'] = user['gender']
                output['occupation'] = user['occupation']
                output['id'] = key
                output['img'] = self.mdb.get_image(key)
                output['result'] = 'success'
        return json.dumps(output)

    def PUT(self, key):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        key = int(key)
        output = {}
        try:
            info = {}
            info['zipcode'] = user_input['zipcode']
            info['age'] = user_input['age']
            info['gender'] = user_input['gender']
            info['occupation'] = user_input['occupation']
            self.mdb.set_user(key, info)
            output['result'] = 'success'
        except KeyError:
            output['result'] = 'error'
            output['message'] = 'invalid input'
        return json.dumps(output)

    def POST(self):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        output = {}
        try:
            info = {}
            info['zipcode'] = user_input['zipcode']
            info['age'] = user_input['age']
            info['gender'] = user_input['gender']
            info['occupation'] = user_input['occupation']
            uid = self.mdb.get_unused_key("users")
            self.mdb.set_user(uid, info)
            output['result'] = 'success'
            output['id'] = uid
        except KeyError:
            output['result'] = 'error'
            output['message'] = 'invalid input'
        return json.dumps(output)

    def DELETE(self, key = None):
        output = {}
        if key is None:
            self.mdb.users = {}
            output['result'] = 'success'
        else:
            key = int(key)
            try:
                del self.mdb.users[key]
                output['result'] = 'success'
            except KeyError:
                output['result'] = 'error'
                output['message'] = 'key not found'
        return json.dumps(output)
