
class .movie.database(object):
	
	__init__(self):		# class constructor
		self.movies		= {}	# will use movieID as key
		self.users		= {]	# will use userID as key
		self.ratings	= {}	# will use movieID as key
		self.mID		= 0		# movieID
		self.uID		= 0		# userID
	
	load.movies(movie.file):	# will open file, load data into dict/list of dicts
	
	get.movie(mID):		# returns list w 2 elmnts (mName, mGenre) || none
		
	get.movies():		# returns list of ints containig all mIds
	
	set.movie(mID, [title, genres]):	# updates movie data entry w mID or creates new one
	
	delete.movie(mID):	# remove specified mID from objects movie data member
	
	load.users(users.file):	# open file and load user data into dict/list of dicts
	
	get.user(uID):		# returns list w user's gender, age, occupation code, zip code
	
	get.users():		# returns list of all uIDs
	
	set.user(uid, [gender, age, occupatoincode, zipcode]):	# update objects user data member
	
	delete.user(uID):	# remove user from objects user data member
	
	load.ratings(ratings.file):	# open file, load ratings data into dict of dicts
	
	get.rating(mID):	# computes avg rating for movie
	
	get.highest.rated.movie():	# returns ID of highest avg rated movie
	
	set.user.movie.rating(uID, mID, rating):	# set movies rating from that user
	
	get.user.movie.rating(uID, mID):	# returns user's rating for that movie
	
	delete.all.ratings():	# clear db of all user ratings for all movies