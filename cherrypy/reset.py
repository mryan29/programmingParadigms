# Meg Ryan
# Mar 10 2018


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
            output['result'] = 'Success'
            
        else:
            key = str(key)
            temp = _movie_database()
            temp.load_movies('data/movies.dat')
            
            try:
                self.mdb.movies[key] = temp.get_movie(key)
                output['result'] = 'Success'
            except KeyError:
                output['result'] = 'Error'
                output['message'] = 'Key not found'
                
                
        return json.dumps(output)
