
import cherrypy
import json
from _movie_database import _movie_database

class RecommendationController(object):

    def __init__(self, mdb):
        self.mdb = mdb

    def GET(self, key):
        output = {}
        key = int(key)
        recomendation = self.mdb.get_highest_rated_unvoted_movie(key)
        
        if recomendation is None:
            output['result'] = 'Error'
            output['message'] = 'User id not found'
        output['result'] = 'Success'
        output['movie_id'] = recomendation
        
        return json.dumps(output)

    def PUT(self, key):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        uID = int(key)
        output = {}
        
        try:
            mID = user_input['movie_id']
            rating = user_input['rating']
            result = self.mdb.set_user_movie_rating(uID, mID, rating)
            output['result'] = 'Success'
        except KeyError:
            output['result'] = 'Error'
            output['message'] = 'Invalid input'
            
        return json.dumps(output)

    def DELETE(self):
        output = {}
        self.ratings = {}
        output['result'] = 'Success'
        return json.dumps(output)