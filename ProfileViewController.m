//
//  ProfileViewController.m
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load the data from parse for the user ID
    
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    _contactInformation=@"no";
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"currentUser is %@", currentUser.username);
        _username.text= currentUser.username;
        _currentObjID=currentUser.objectId;
    } else {
        // show the signup or login screen
    }
    
//#warning replace this
//    _username.text=@"gkumbhat";
//    _currentObjID=@"yGlyaA8BBJ";
    
    //get the screen details of username
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:_username.text];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *contactObject, NSError *error) {
        if (!contactObject) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            [_name setText:contactObject[@"firstName"]];
            [_gender setText:contactObject[@"sex"]];
            [_age setText:contactObject[@"age"]];
            [_phoneNumber setText:contactObject[@"phoneNumber"]];
            [_address setText:contactObject[@"address"]];
            [_descriptionText setText:contactObject[@"description"]];
            NSString* requestB= contactObject[@"contactPermission"];
            if([requestB isEqualToString:@"yes"]){
                [_switchControl setOn:YES animated:YES];
            }else{
                [_switchControl setOn:NO animated:YES];
            }
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateInfoButtonPressed:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:_username.text];
    //update the object id and make a call
    [query getObjectInBackgroundWithId:_currentObjID
                                 block:^(PFObject *profile, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     if(profile){
                                         
                                         profile[@"firstName"] = _name.text;
                                         profile[@"sex"] = _gender.text;
                                         profile[@"age"] = _age.text;
                                         profile[@"phoneNumber"] = _phoneNumber.text;
                                         //                                    profile[@"address"] = _address.text;
                                         //                                    profile[@"description"] = _description.text;
                                         
                                         profile[@"contactPermission"] = _contactInformation;
                                         [profile saveInBackground];
                                         [_resultLabel setText:@"Updated Successfully"];
                                     }else{
                                        [_resultLabel setText:@"Updated Successfully"];
                                     }
                                 }];
}

-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)logOutButtonPressed:(id)sender {
    [PFUser logOut];
}
- (IBAction)switchButtonChanged:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        NSLog(@"its on!");
        _contactInformation=@"yes";
    } else {
        NSLog(@"its off!");
        _contactInformation=@"no";
    }

}
@end
