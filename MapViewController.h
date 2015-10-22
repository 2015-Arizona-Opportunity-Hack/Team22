//
//  MapViewController.h
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface MapViewController : UIViewController<MKMapViewDelegate,  CLLocationManagerDelegate>

@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong, nonatomic) NSString*username;
@property(strong, nonatomic) NSArray*jsonArray;
@end
