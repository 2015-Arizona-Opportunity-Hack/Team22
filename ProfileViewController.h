//
//  ProfileViewController.h
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) NSString *contactInformation;

@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

- (IBAction)switchButtonChanged:(id)sender;

@property(weak, nonatomic) NSString*currentObjID;
@property (weak, nonatomic) IBOutlet UITextField *descriptionText;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)updateInfoButtonPressed:(id)sender;

- (IBAction)logOutButtonPressed:(id)sender;

@end
