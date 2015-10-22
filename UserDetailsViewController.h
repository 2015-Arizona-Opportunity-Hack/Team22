//
//  UserDetailsViewController.h
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsViewController : UIViewController

@property(nonatomic, strong) NSString* username;
@property(nonatomic, strong) NSString* fromUsername;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *decriptionView;
@property (weak, nonatomic) IBOutlet UIButton *requestInformationButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)requestInformationButtonPressed:(id)sender;

@end
