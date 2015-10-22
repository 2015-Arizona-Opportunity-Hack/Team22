//
//  UserDetailsViewController.m
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import "UserDetailsViewController.h"
#import <Parse/Parse.h>
@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.decriptionView.layer.borderWidth = 0.5f;
    self.decriptionView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    NSLog(@"Getting details for user: %@", _username);
    //make a call to database and enable or disable the contact information button
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:self.username];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *contactObject, NSError *error) {
        if (!contactObject) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            [_name setText:contactObject[@"firstName"]];
            [_age setText:contactObject[@"age"]];
            [_gender setText:contactObject[@"sex"]];
            [_decriptionView setText:contactObject[@"description"]];
            NSString* requestB= contactObject[@"contactPermission"];
            if([requestB isEqualToString:@"yes"]){
                _requestInformationButton.enabled=YES;
            }else{
                _requestInformationButton.enabled=NO;
            }
        }
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)requestInformationButtonPressed:(id)sender {
    
    //call service to send message to the person
    NSString* str= [NSString stringWithFormat:@"http://192.168.114.139:8080/sendsms/?senderUsername=%@&recieverUsername=%@",_fromUsername, self.username ];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                          URLWithString:str]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    NSError *jsonParsingError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jsonParsingError];
    
    if (!jsonObject) {
        NSLog(@"Error parsing JSON: %@", jsonParsingError);
    } else {
        NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
        NSLog(@"jsonDictionary - %@",jsonDictionary);
        if ([[jsonDictionary objectForKey:@"result"] isEqualToString:@"True"]) {
            //update the result label
            [_resultLabel setText:@"Successfully sent the message"];
        }
    }

    }

@end
