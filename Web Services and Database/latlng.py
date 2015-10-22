import urllib
import simplejson
import requests
import json,httplib,urllib
import colorsys
googleGeocodeUrl = 'http://maps.googleapis.com/maps/api/geocode/json?'

def get_coordinates(query, from_sensor=False):

    connection = httplib.HTTPSConnection('api.parse.com', 443)

    params = urllib.urlencode({"where":json.dumps({
           "username": query.encode('utf-8')
         })})
    connection.connect()
    connection.request('GET', '/1/users?%s' %params, '' , {
           "X-Parse-Application-Id": "VbEx3WzVqLJvCIx77RAnKEaNYt9kHBIIJVhhzOHn",
           "X-Parse-REST-API-Key": "W0dSfaEOLGOWi14UUDKBjmUzKLajYCsQ1cYVZltv"
         })
    receiverInfo = json.loads(connection.getresponse().read())
    print (receiverInfo)
    address=receiverInfo["results"][0]["address"]
    firstname=receiverInfo["results"][0]["firstName"]
    params = {
        'address': address,
        'sensor': "true" if from_sensor else "false"
    }
    url = googleGeocodeUrl + urllib.urlencode(params)
    json_response = urllib.urlopen(url)
    response = simplejson.loads(json_response.read())
    if response['results']:
        location = response['results'][0]['geometry']['location']
        latitude, longitude = location['lat'], location['lng']
        print latitude, longitude
        print firstname
    else:
        latitude, longitude = None, None
        print query, "<no results>"
    return latitude, longitude, firstname.encode("utf-8")


def pseudocolor(val, minval, maxval):
    # convert val in range minval..maxval to the range 0..120 degrees which
    # correspond to the colors red..green in the HSV colorspace
    h = (float(val-minval) / (maxval-minval)) * 120
    # convert hsv color (h,1,1) to its rgb equivalent
    # note: the hsv_to_rgb() function expects h to be in the range 0..1 not 0..360
    r, g, b = colorsys.hsv_to_rgb((h/360), 1., 1.)
    return r, g, b


if __name__ == '__main__':
    data=get_coordinates("gkumbhat")
    data1 = pseudocolor(98,-100,100)

    print data1