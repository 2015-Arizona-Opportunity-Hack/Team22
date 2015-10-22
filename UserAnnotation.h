//
//  UserAnnotation.h
//  Kickback
//
//  Created by Mallikarjun Patil on 10/11/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface UserAnnotation : NSObject<MKAnnotation>
{
    
    CLLocationCoordinate2D  coordinate;
    NSString*               title;
    NSString*               subtitle;
    NSInteger index;
}
@property NSInteger index;
@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate;
@property (nonatomic, copy)     NSString*               title;
@property (nonatomic, copy)     NSString*               subtitle;


@end
