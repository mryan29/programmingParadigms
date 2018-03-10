import cherrypy
import json
from _movie_database import _movie_database

class ResetController(object):

    def __init__(self, mdb):
        self.mdb = mdb

    def PUT(self, key = None):
        output = {}
        if key is None:
            self.mdb.load_users('data/users.dat')
            self.mdb.load_movies('data/movies.dat')
            self.mdb.load_ratings('data/ratings.dat')
            self.mdb.load_images('data/images.dat')
            output['result'] = 'success'
        else:
            key = str(key)
            temp = _movie_database()
            temp.load_movies('data/movies.dat')
            try:
                self.mdb.movies[key] = temp.get_movie(key)
                output['result'] = 'success'
            except KeyError:
                output['result'] = 'error'
                output['message'] = 'key not found'
        return json.dumps(output)