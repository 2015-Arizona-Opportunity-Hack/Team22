import cherrypy
import csv
import ast
import latlng
from recommendation import *
import json

songs = {
    '1': {
        'title': 'Lumberjack Song',
        'artist': 'Canadian Guard Choir'
    },

    '2': {
        'title': 'Always Look On the Bright Side of Life',
        'artist': 'Eric Idle'
    },

    '3': {
        'title': 'Spam Spam Spam',
        'artist': 'Monty Python'
    }
}




class ReSTPaths1:
  @cherrypy.expose
  def index(self):
    http_method = getattr(self,cherrypy.request.method)
    return (http_method)()
 
  def GET(self):
    return "In GET 1.."
 
class ReSTPaths2:
  @cherrypy.expose
  def index(self):
    http_method = getattr(self,cherrypy.request.method)
    return (http_method)()
 
  def GET(self):
    return "In GET 2.."
 
class ReSTPaths3:
  @cherrypy.expose
  def index(self,client_id=None):
    http_method = getattr(self,cherrypy.request.method)
    return (http_method)(client_id)
 
  def GET(self,client_id):
    # print (client_id)
    # print (songs)
    myval = topMatches(critics, client_id ,n=10000)
    val = len(myval)
    val=val-1
    a = []
    # print val
    newitem = dict()
    master = dict()
    # data=latlng.get_coordinates(myval[0][1])
    # newitem['username'] = myval[0][1]
    # newitem['Name'] = data[2]
    for i in range(0,val):
        print i
        # rgb_val = latlng.pseudocolor(myval[i][0],0,1)
        try:
            newitem['id']= i
            r = (1-myval[i][0])
            g=myval[i][0];
            b=0
            data=latlng.get_coordinates(myval[i][1])
            newitem['username'] = myval[i][1]
            newitem['Name'] = data[2]
            newitem['lat'] = data[0]
            newitem['lng'] = data[1]
            newitem['r'] = r
            newitem['g'] = g
            newitem['b'] = b
            # newitem['rgb'] = rgb_val
            a.append(dict(newitem))
        except:
            continue
        #json.dump({'id' : id ,'user': newitem['username'], 'Name': newitem['Name'], 'lat':newitem['lat'], 'lng' : newitem['lng'], 'r' : r, 'g' : g, 'b' : b}, fout)
       # fout.write(",")
    # #
    # fout.write('{}}')
    # with open ("output_final.txt", "r") as myfile:
    #     final=myfile.readlines()
    result=json.dumps(a)

    return "%s\n" % (result)
 
 
# cherrypy.server.socket_port=8080
#
#
#
# root=ReSTPaths1()
# root.username = ReSTPaths2()
# root.username.findsimilar = ReSTPaths3()
# cherrypy.quickstart(root)

root=ReSTPaths1()
root.username = ReSTPaths2()
root.username.findsimilar = ReSTPaths3()

conf = {
   'global': {
       'server.socket_host': '0.0.0.0',
       'server.socket_port': 8080,
   },

}

cherrypy.quickstart(root,'/', conf)