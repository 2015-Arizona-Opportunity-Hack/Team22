import json,httplib
import requests

connection = httplib.HTTPSConnection('api.parse.com', 443)
connection.connect()
connection.request('GET', '/1/users/', '', {
       "X-Parse-Application-Id": "VbEx3WzVqLJvCIx77RAnKEaNYt9kHBIIJVhhzOHn",
       "X-Parse-REST-API-Key": "W0dSfaEOLGOWi14UUDKBjmUzKLajYCsQ1cYVZltv"
     })
result = json.loads(connection.getresponse().read())
print result
fout = open('output4.json', 'w')

url = "http://access.alchemyapi.com/calls/text/TextGetRankedNamedEntities"


completeData = []
val=len(result["results"])
print val
default = '123'
fout.write("{")
for i in range(0,val):
    username = result["results"][i]["username"]
    name_1 = result["results"][i]["firstName"]
    finalData = result["results"][i]["description"]
    payload = "text="+finalData.encode("utf-8")
    newitem = dict()
    newitem['id'] = username


    headers = {
        'cache-control': "no-cache",
        'content-type': "application/x-www-form-urlencoded"
    }
    print username
    print name_1

    Anatomy = float(0.0)
    Anniversary = float(0.0)
    Automobile = float(0.0)
    City= float(0.0)
    Company= float(0.0)
    Continent= float(0.0)
    Country= float(0.0)
    Crime= float(0.0)
    Degree= float(0.0)
    Drug= float(0.0)
    EntertainmentAward= float(0.0)
    Facility= float(0.0)
    FieldTerminology= float(0.0)
    FinancialMarketIndex= float(0.0)
    GeographicFeature= float(0.0)
    HealthCondition= float(0.0)
    Holiday= float(0.0)
    JobTitle= float(0.0)
    Movie= float(0.0)
    MusicGroup= float(0.0)
    NaturalDisaster= float(0.0)
    OperatingSystem= float(0.0)
    Organization= float(0.0)
    Person= float(0.0)
    PrintMedia= float(0.0)
    Product= float(0.0)
    ProfessionalDegree= float(0.0)
    RadioProgram= float(0.0)
    RadioStation= float(0.0)
    Region= float(0.0)
    Sport= float(0.0)
    SportingEvent= float(0.0)
    StateOrCounty= float(0.0)
    Technology= float(0.0)
    TelevisionShow= float(0.0)
    TelevisionStation= float(0.0)
    EmailAddress= float(0.0)
    TwitterHandle= float(0.0)
    Hashtag= float(0.0)
    IPAddress= float(0.0)
    Quantity= float(0.0)
    Money = float(0.0)


    response = requests.request("POST", url, data=payload, headers=headers, params=querystring)
    response = json.loads(response.text)
    userInfo =[]
    for j in range(0,len(response.get("entities"))):
        if(response.get("entities")[j].get("type") == "Anatomy"):
            anatomy = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Anniversary"):
            Anniversary = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Automobile"):
            Automobile = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "City"):
            City = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Company"):
            Company = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Continent"):
            Continent = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Country"):
            Country = float(response.get("entities")[j].get("relevance"))
        if(response.get("entities")[j].get("type") == "Crime"):
            Crime = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Degree"):
            Degree = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Drug"):
            Drug = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "EntertainmentAward"):
            EntertainmentAward = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Facility"):
            Facility = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "FieldTerminology"):
            FieldTerminology = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "FinancialMarketIndex"):
            FinancialMarketIndex = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "GeographicFeature"):
            GeographicFeature = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "HealthCondition"):
            HealthCondition = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Holiday"):
            Holiday = float(response.get("entities")[j].get("relevance"))
        if(response.get("entities")[j].get("type") == "JobTitle"):
            JobTitle = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Movie"):
            Movie = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "MusicGroup"):
            MusicGroup = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "NaturalDisaster"):
            NaturalDisaster = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "OperatingSystem"):
            OperatingSystem = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Organization"):
            Organization = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Person"):
            Person = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "PrintMedia"):
            PrintMedia = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Product"):
            Product = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "ProfessionalDegree"):
            ProfessionalDegree = float(response.get("entities")[j].get("relevance"))
        if(response.get("entities")[j].get("type") == "RadioProgram"):
            RadioProgram = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "RadioStation"):
            RadioStation = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Region"):
            Region = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Sport"):
            Sport = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "SportingEvent"):
            SportingEvent = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "StateOrCounty"):
            StateOrCounty = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Technology"):
            Technology = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "TelevisionShow"):
            TelevisionShow = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "TelevisionStation"):
            TelevisionStation = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "EmailAddress"):
            EmailAddress = float(response.get("entities")[j].get("relevance"))
        if(response.get("entities")[j].get("type") == "TwitterHandle"):
            TwitterHandle = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Hashtag"):
            Hashtag = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "IPAddress"):
            IPAddress = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Quantity"):
            Quantity = float(response.get("entities")[j].get("relevance"))
        elif(response.get("entities")[j].get("type") == "Money"):
            Money = float(response.get("entities")[j].get("relevance"))

    fout.write("\"" + username + "\"" + ":")
    json.dump({"Anatomy" : Anatomy, "Anniversary" : Anniversary, "Automobile" : Automobile, "City" : City, "Company" : Company, "Continent" : Continent, "Country" : Country, "Crime" : Crime, "Degree" : Degree, "Drug" : Drug, "EntertainmentAward" : EntertainmentAward, "Facility" : Facility, "FieldTerminology" : FieldTerminology, "FinancialMarketIndex" : FinancialMarketIndex, "GeographicFeature" : GeographicFeature, "HealthCondition" : HealthCondition, "Holiday" : Holiday, "JobTitle" : JobTitle, "Movie" : Movie, "MusicGroup" : MusicGroup, "NaturalDisaster" : NaturalDisaster, "OperatingSystem" : OperatingSystem, "Organization" : Organization, "Person" : Person, "PrintMedia" : PrintMedia, "Product" : Product, "ProfessionalDegree" : ProfessionalDegree, "RadioProgram" : RadioProgram, "RadioStation" : RadioStation, "Region" : Region, "Sport" : Sport, "SportingEvent" : SportingEvent, "StateOrCounty" : SportingEvent, "Technology" : Technology, "TelevisionShow" : TelevisionShow, "TelevisionStation" : TelevisionStation, "EmailAddress" : EmailAddress, "TwitterHandle" : TwitterHandle, "Hashtag" : Hashtag, "IPAddress" : IPAddress, "Quantity" : Quantity, "Money" : Money},fout)
    fout.write(',')
    fout.write('\n')
fout.write('"test": {}')
fout.write('}')

		#print response.get("entities")[j].get("type") + " - " + response.get("entities")[j].get("relevance")

