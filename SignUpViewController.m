//
//  SignUpViewController.m
//  Kickback
//
//  Created by Mallikarjun Patil on 10/10/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "MapViewController.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.descriptionTextView.layer.borderWidth = 1.0f;
    self.descriptionTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.descriptionTextView setText:@"Description"];
    
    self.address.layer.borderWidth = 1.0f;
    self.address.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.address setText:@"Address"];
    
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    
    
}

-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signupButtonPressed:(id)sender {
    
    if([_name.text length]==0 || [_username.text length]==0 || [_password.text length]==0 || [_age.text length]==0 || [_phoneNumber.text length]==0 || [_address.text length]==0 || [_descriptionTextView.text length]==0){
        [_statusLabel setText:@"All the feilds are mandatory"];
        
    }else{

        PFUser *user = [PFUser user];
        user.username = [_username text];
        user.password = [_password text];
        user[@"firstName"] = [_name text];
        user[@"age"] = [_age text] ;
        user[@"phoneNumber"] = [_phoneNumber text];
        user[@"address"] = [_address text];
        user[@"description"] = [_descriptionTextView text];
        user[@"gender"] = [_gender text];
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Insertion successful. Move to Home Page");
                [self performSegueWithIdentifier:@"signUpToHome" sender:self];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"errorString %@", errorString);
                [_statusLabel setText:@"Unable to sign up right now"];
            }
        }];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"signUpToHome"])
    {
        //prepare for segue signUpToHome
        MapViewController *mapViewController = [segue destinationViewController];
    }
}
@end
