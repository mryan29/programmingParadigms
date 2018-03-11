
class _movie_database(object):
	
	def __init__(self):	
		self.movies	= {}	# will use movieID as key
		self.users = {}	# will use userID as key
		self.ratings = {}	# will use movieID as key
		self.mID = 0		# movieID
		self.uID = 0		# userID
	
	def load_movies(self, movie_file):	# will open file, load data into dict/list of dicts
		with open(movie_file) as movies:
			for line in movies:
				line = line.rstrip()
				components = line.split("::")
				
				mID = int(components[0])
				mName = components[1]
				mGenres = components[2]
				
				self.movies[mid] = {'name': mName, 'genres': mGenres}
	
	def get_movie(self, mID):		# returns list w 2 elmnts (mName, mGenre) || none
		if mID in self.movies:
			return [self.movies[mID]['name'], self.movies[mID]['genres']]
		else:
			return None
		
	def get_movies(self):		# returns list of ints containig all mIds
		mIDList = []
		for movie in self.movies:
			mIDList.append(movie)
		return mIDList
	
	def set_movie(self, mID, info):	# updates movie data entry w mID or creates new one
		self.movies[mID] = {'name':info[0], 'genres':info[1]}	
	
	def delete_movie(self, mID):	# remove specified mID from objects movie data member
		if mID in self.movies:
			del self.movies[mID]
			
	def load_users(self, users_file):	# open file and load user data into dict/list of dicts
		with open(users_file) as use:
			for line in use:
				line = line.rstrip()
				components = line.split("::")
				
				uid = int(components[0])
				ugender = components[1]
				uage = int(components[2])
				uocc = int(components[3])
				uzip = components[4]
				
				self.users[uid] = {'gender': ugender, 'age':uage, 'occupationcode':uocc, 'zipcode':uzip}
				
	def get_user(self, uID):		# returns list w user's gender, age, occupation code, zip code
		if uID in self.users:
			return [self.users[uID]['gender'], self.users[uID]['age'], self.users[uID]['occupationcode'], self.users[uID]['zipcode']]
		else:
			return None
			
	def get_users(self):		# returns list of all uIDs
		uidList = []
		for use in self.users:
			uidList.append(use)
		return uidList
		
	def set_user(self, uid, user):	# update objects user data member
		self.users[uid] = {'gender':user[0], 'age':user[1], 'occupationcode':user[2], 'zipcode':user[3]}
	
	def delete_user(self, uID):	# remove user from objects user data member
		if uid in self.users:
			del self.users[uID]
	
	def load_ratings(self, ratings_file):	# open file, load ratings data into dict of dicts
		with open(ratings_file) as rat:
			for line in rat:
				components = line.split("::")
				uid = int(components[0])
				mid = int(components[1])
				urat = int(components[2])
				if mid in self.ratings:
					self.ratings[mid][uid] = urat
				else:
					self.ratings[mid] = {}
					self.ratings[mid][uid] = urat
	
	def get_ratings(self, mID):	# computes avg rating for movie
		tot=0
		sumRat = 0
		if mid in self.ratings:
			for use in self.ratings[mID]:
				sumRat+=self.ratings[mID][use]
				tot+=1
			return float(sumRat)/tot
		else:
			return 0
			
	def get_highest_rated_movie(self):	# returns ID of highest avg rated movie
		maxAv = 0
		for mov in self.movies:
			if self.get_rating(mov) > maxAv:
				maxAv = self.get_rating(mov)
				movID = mov
		if maxAv == 0:
			return None
		else:
			return movID
			
	def set_user_movie_rating(self, uID, mID, rating):	# set movies rating from that user
		if uID in self.users:
			if mID in self.ratings:
				self.ratings[mID][uID] = rating
			else:
				self.ratings[mID] = {}
				self.ratings[mID][uID] = rating
				
	def get_user_movie_rating(self, uID, mID):	# returns user's rating for that movie
		if mID in self.movies:
			if uID in self.ratings[mID]:
				return self.ratings[mID][uID]
		else:
			return None
	
	def delete_all_ratings(self):	# clear db of all user ratings for all movies
		self.ratings.clear()
