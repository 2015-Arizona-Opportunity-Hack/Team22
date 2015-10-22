//
//  DonateViewController.m
//  Kickback
//
//  Created by Mallikarjun Patil on 10/11/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController ()

@end

@implementation DonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    NSString *urlString = @"http://childrenscancernetwork.org/donate/now";
    
//    NSString *urlString = @"https://www.google.com";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
