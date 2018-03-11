import cherrypy
import json
from _movie_database import _movie_database

class MovieController(object):

    def __init__(self, mdb):
        self.mdb = mdb

    def GET(self, key = None):
        output = {}
        if key is None:
            output['movies'] = []
            for mid in self.mdb.movies:
                movie = {}
                movie['genres'] = self.mdb.movies[mid]['genres']
                movie['title'] = self.mdb.movies[mid]['title']
                movie['id'] = mid
                output['movies'].append(movie)
            output['result'] = 'Success'
        else:
            key = int(key)
            movie = self.mdb.get_movie(key)
            if movie is None:
                output['result'] = 'Error'
                output['message'] = 'Key not found'
            else:
                output['genres'] = movie['genres']
                output['title'] = movie['title']
                output['id'] = key
                output['result'] = 'Success'
                output['img'] = self.mdb.get_image(key)
        return json.dumps(output)

    def PUT(self, key):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        key = int(key)
        output = {}
        try:
            info = {}
            info['title'] = user_input['title']
            info['genres'] = user_input['genres']
            self.mdb.set_movie(key, info)
            output['result'] = 'Success'
        except KeyError:
            output['result'] = 'Error'
            output['message'] = 'Invalid input'
        return json.dumps(output)

    def POST(self):
        user_input = cherrypy.request.body.read().decode()
        user_input = json.loads(user_input)
        output = {}
        try:
            info = {}
            info['title'] = user_input['title']
            info['genres'] = user_input['genres']
            mid = self.mdb.get_unused_key("movies")
            self.mdb.set_movie(mid, info)
            output['result'] = 'Success'
            output['id'] = mid
        except KeyError:
            output['result'] = 'Error'
            output['message'] = 'Invalid input'
        return json.dumps(output)

    def DELETE(self, key = None):
        output = {}
        if key is None:
            self.mdb.movies = {}
            output['result'] = 'Success'
        else:
            key = int(key)
            try:
                del self.mdb.movies[key]
                output['result'] = 'Success'
            except KeyError:
                output['result'] = 'Error'
                output['message'] = 'Key not found'
        return json.dumps(output)