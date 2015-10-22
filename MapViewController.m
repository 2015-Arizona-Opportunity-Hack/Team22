//
//  MapViewController.m
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import "MapViewController.h"
#define METERS_PER_MILE 1609.344
#import "UserDetailsViewController.h"
#import <Parse/Parse.h>
#import "UserAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    mapView.showsUserLocation = YES;
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //setting region
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 400*METERS_PER_MILE, 400*METERS_PER_MILE);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) {
        // show the signup or login screen
        NSLog(@"Unidentified Current User");
    } else {
        // do stuff with the user
        NSLog(@"Get data related to %@", currentUser.username);
        _username=currentUser.username;
    }
    NSLog(@"Getting data for user %@", _username);
    //call service to send message to the person
    NSString* str= [NSString stringWithFormat:@"http://192.168.115.41:8080/username/findsimilar/?client_id=%@",_username ];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *jsonParsingError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jsonParsingError];
    
    CLLocationDegrees lat;
    CLLocationDegrees longi;
    NSString* name;
    NSString* username;
    if (!jsonObject) {
        NSLog(@"Error parsing JSON: %@", jsonParsingError);
    } else {
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSLog(@"its an array!");
            _jsonArray = (NSArray *)jsonObject;
            NSLog(@"jsonArray - %@",_jsonArray);
            for(int i=0;i<[_jsonArray count];i++){
                
                lat = [[[_jsonArray objectAtIndex:i] objectForKey:@"lat"] doubleValue];
                longi = [[[_jsonArray objectAtIndex:i] objectForKey:@"lng"] doubleValue];
                name = [[_jsonArray objectAtIndex:i] objectForKey:@"Name"];
                username = [[_jsonArray objectAtIndex:i] objectForKey:@"username"];
                
                UserAnnotation *userAnnotation = [[UserAnnotation alloc]init];
                userAnnotation.coordinate = CLLocationCoordinate2DMake(lat,longi);
                userAnnotation.title = name;
                userAnnotation.subtitle = username;
                userAnnotation.index=i;
                [self.mapView addAnnotation:userAnnotation];
            }
        }
        else {
            NSLog(@"its probably a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            NSLog(@"jsonDictionary - %@",jsonDictionary);
        }
        
    }

}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[UserAnnotation class]]) {
        MKPinAnnotationView *annView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
        UserAnnotation *userAnnotation = (UserAnnotation *)annotation;
        
        NSDictionary* userObject=[_jsonArray objectAtIndex:userAnnotation.index];
        float red;
        float green;
        float blue;
        red=[[userObject objectForKey:@"r"] doubleValue];
        green=[[userObject objectForKey:@"g"] doubleValue];
        blue=[[userObject objectForKey:@"b"] doubleValue];
        
        annView.canShowCallout = YES;
        annView.pinTintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annView.rightCalloutAccessoryView=detailButton;

        return annView;
    }
    
        return nil;
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
        //Here, the annotation tapped can be accessed using view.annotation
    NSLog(@"%@",view.annotation.title);
    NSLog(@"%@",view.annotation.subtitle);
    [self performSegueWithIdentifier:@"mapContactDetails" sender:view.annotation.subtitle];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"mapContactDetails"])
    {
        // Get reference to the destination view controller
        UserDetailsViewController *userDetailsViewController = [segue destinationViewController];
                    // Pass any objects to the view controller here, like...
        NSLog(@"user name is :%@", sender);
        userDetailsViewController.username=sender;
        userDetailsViewController.fromUsername=self.username;

    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 400*METERS_PER_MILE, 400*METERS_PER_MILE);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
