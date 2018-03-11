# _webservice_primer.py
# Meg Ryan
# March 1st, 2018

import requests
import json

class _webservice_primer:
	
	def __init__(self):
		self.SITE_URL   = 'http://ash.campus.nd.edu:40001'
		self.MOVIE_URL  = self.SITE_URL + '/movies/'
		self.RESET_URL  = self.SITE_URL + '/reset/'
	
	def get_movie(self, m_id):
		r			= requests.get(self.MOVIE_URL + str(m_id))	# returns a JSON object
		resp  		= json.loads(r.content.decode('utf-8'))		# translate it into a dictionary using the JSON module
		return resp
	
	def set_movie_title(self, m_id, title):
		resp          = self.get_movie(m_id)
		resp['title'] = title
		resp          = json.dumps(resp)
		r					= requests.put(self.MOVIE_URL + str(m_id), data = resp)
		result              = json.loads(r.content.decode('utf-8'))
		return result
		
	def delete_movie(self, m_id):
		r     	= requests.delete(self.MOVIE_URL + str(m_id))
		result  = json.loads(r.content.decode('utf-8'))
		return result
	
	def reset_movie(self, m_id):
		r     	= requests.put(self.RESET_URL + str(m_id))
		result  = json.loads(r.content.decode('utf-8'))
		return result

if __name__ == "__main__":
	MID = 56		# pre-assigned MID
	ws  = _webservice_primer()
	movie = ws.get_movie(MID)
	
	if movie['result'] == 'success':
		print("Title:\t%s" % movie['title'])
	else:
		print("Error:\t%s" % movie['message'])
