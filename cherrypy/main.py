import cherrypy
from _movie_database import _movie_database
from movies import MovieController
from users import UserController
from recommendations import RecommendationController
from ratings import RatingController
from reset import ResetController

def start_service():
    dispatcher = cherrypy.dispatch.RoutesDispatcher()
    mdb = _movie_database()
    movieController = MovieController(mdb)
    userController = UserController(mdb)
    recommendationController = RecommendationController(mdb)
    ratingController = RatingController(mdb)
    resetController = ResetController(mdb)

    # movie handlers
    dispatcher.connect('movie_get', '/movies/', controller = movieController, action = 'GET', conditions = dict(method=['GET']))
    dispatcher.connect('movie_get_key', '/movies/:key', controller = movieController, action = 'GET', conditions = dict(method=['GET']))
    dispatcher.connect('movie_put_key', '/movies/:key', controller = movieController, action = 'PUT', conditions = dict(method=['PUT']))
    dispatcher.connect('movie_post', '/movies/', controller = movieController, action = 'POST', conditions = dict(method=['POST']))
    dispatcher.connect('movie_delete', '/movies/', controller = movieController, action = 'DELETE', conditions = dict(method=['DELETE']))
    dispatcher.connect('movie_delete_key', '/movies/:key', controller = movieController, action = 'DELETE', conditions = dict(method=['DELETE']))

    # user handlers
    dispatcher.connect('user_get', '/users/', controller = userController, action = 'GET', conditions = dict(method=['GET']))
    dispatcher.connect('user_get_key', '/users/:key', controller = userController, action = 'GET', conditions = dict(method=['GET']))
    dispatcher.connect('user_put_key', '/users/:key', controller = userController, action = 'PUT', conditions = dict(method=['PUT']))
    dispatcher.connect('user_post', '/users/', controller = userController, action = 'POST', conditions = dict(method=['POST']))
    dispatcher.connect('user_delete', '/users/', controller = userController, action = 'DELETE', conditions = dict(method=['DELETE']))
    dispatcher.connect('user_delete_key', '/users/:key', controller = userController, action = 'DELETE', conditions = dict(method=['DELETE']))

    # recommendation handlers
    dispatcher.connect('recommendation_get_key', '/recommendations/:key', controller = recommendationController, action = 'GET', conditions = dict(method=['GET']))
    dispatcher.connect('recommendation_put_key', '/recommendations/:key', controller = recommendationController, action = 'PUT', conditions = dict(method=['PUT']))
    dispatcher.connect('recommendation_delete', '/recommendations/', controller = recommendationController, action = 'DELETE', conditions = dict(method=['DELETE']))

    # rating handler
    dispatcher.connect('rating_get_key', '/ratings/:key', controller = ratingController, action = 'GET', conditions = dict(method=['GET']))

    # reset handlers
    dispatcher.connect('reset_put', '/reset/', controller = resetController, action = 'PUT', conditions = dict(method=['PUT']))
    dispatcher.connect('reset_put_key', '/reset/:key', controller = resetController, action = 'PUT', conditions = dict(method=['PUT']))

    cfg = {'global': {'server.socket_host': 'ash.campus.nd.edu', 'server.socket_port': 40110}, '/': {'request.dispatch': dispatcher} }
    cherrypy.config.update(cfg)
    app = cherrypy.tree.mount(None, config = cfg)
    cherrypy.quickstart(app)

if __name__ == '__main__':
    start_service()
