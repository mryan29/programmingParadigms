# Meg Ryan
# Mar 10 2018

import cherrypy
import json
from _movie_database import _movie_database

class RatingController(object):

    def __init__(self, mdb):
        self.mdb = mdb

    def GET(self, key):
        output = {}
        key = int(key)
        
        output['rating'] = self.mdb.get_rating(key)
        output['movie_id'] = key
        output['result'] = 'Success'
        return json.dumps(output)
