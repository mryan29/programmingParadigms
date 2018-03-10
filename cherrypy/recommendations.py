import cherrypy
import json
from _movie_database import _movie_database

class RecommendationController(object):

    def __init__(self, mdb):
        self.mdb = mdb

    def GET(self, key):
        output = {}
        key = int(key)
        reccomendation = self.mdb.get_highest_rated_unvoted_movie(key)
        if reccomendation is None:
            output['result'] = 'error'
            output['message'] = 'user id not found'
        output['result'] = 'success'
        output['movie_id'] = reccomendation
        return json.dumps(output)

    def PUT(self, key):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        uid = int(key)
        output = {}
        try:
            mid = user_input['movie_id']
            rating = user_input['rating']
            result = self.mdb.set_user_movie_rating(uid, mid, rating)
            output['result'] = 'success'
        except KeyError:
            output['result'] = 'error'
            output['message'] = 'invalid input'
        return json.dumps(output)

    def DELETE(self):
        output = {}
        self.ratings = {}
        output['result'] = 'success'
        return json.dumps(output)