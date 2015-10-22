//
//  LoginViewController.h
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)closeButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;


@end
