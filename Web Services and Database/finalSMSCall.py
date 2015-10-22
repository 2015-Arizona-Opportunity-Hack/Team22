import smtplib
import cherrypy
import csv
import ast
import requests
import json,httplib,urllib
import sys
from twilio.rest import TwilioRestClient

class ReSTPaths1(object):
	@cherrypy.expose
	def index(self):
		http_method = getattr(self,cherrypy.request.method)
		return (http_method)()

	def GET(self):
		return "In GET 1.."

class SendSMSService(object):

	@cherrypy.expose
	def index(self,senderUsername, recieverUsername):
		http_method = getattr(self,cherrypy.request.method, cherrypy.request.method)
		return (http_method)(senderUsername,recieverUsername)

	def GET(self, senderUsername, recieverUsername):

		try:
			connection = httplib.HTTPSConnection('api.parse.com', 443)

			params = urllib.urlencode({"where":json.dumps({
			       "username": recieverUsername
			     })})
			connection.connect()
			connection.request('GET', '/1/users?%s' %params, '' , {
			       "X-Parse-Application-Id": "VbEx3WzVqLJvCIx77RAnKEaNYt9kHBIIJVhhzOHn",
			       "X-Parse-REST-API-Key": "W0dSfaEOLGOWi14UUDKBjmUzKLajYCsQ1cYVZltv"
			     })
			receiverInfo = json.loads(connection.getresponse().read())
			number=receiverInfo["results"][0]["phoneNumber"]

			params = urllib.urlencode({"where":json.dumps({
			       "username": senderUsername
			     })})
			connection.request('GET', '/1/users?%s' %params, '' , {
			       "X-Parse-Application-Id": "VbEx3WzVqLJvCIx77RAnKEaNYt9kHBIIJVhhzOHn",
			       "X-Parse-REST-API-Key": "W0dSfaEOLGOWi14UUDKBjmUzKLajYCsQ1cYVZltv"
			     })
			senderInfo = json.loads(connection.getresponse().read())
			connection.close()

			message = "Hi, I am "+senderInfo["results"][0]["firstName"].encode("utf-8")+". I am a member of Children's Cancer Network. I would Like to contact you."
			message = message + " My contact Number is " + senderInfo["results"][0]["phoneNumber"] + ". Thank You."

			account_sid = "AC1be3d7a1124e65e2b0e80c8046d2843b"
			auth_token  = "51f2295dcc61ac16b6784368241f376a"
			client = TwilioRestClient(account_sid, auth_token)
			 
			message = client.messages.create(body=message,
			    to=number,
			    from_="+1 415-599-2671",)
			print message
			return '{"result":"True"}'
		except:
			print sys.exc_info()[0]
			print sys.exc_info()[1]
			return '{"result":"False"}'

#cherrypy.server.socket_port=8080	

root=ReSTPaths1()
root.sendsms =SendSMSService()
conf = {
    'global': {
        'server.socket_host': '0.0.0.0',
        'server.socket_port': 8080,
    },
    
}


cherrypy.quickstart(root,'/', conf)
