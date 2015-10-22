//
//  EventsTableTableViewController.m
//  Kickback
//
//  Created by Mallikarjun Patil on 10/11/15.
//  Copyright © 2015 Mallikarjun. All rights reserved.
//

#import "EventsTableTableViewController.h"
#import <Parse/Parse.h>

@interface EventsTableTableViewController ()

@end

@implementation EventsTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewWillAppear:(BOOL)animated{
    PFQuery *query = [PFQuery queryWithClassName:@"events"];
    [query whereKey:@"eventActive" equalTo:@"yes"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // Do something with the found objects
            _eventsArray=objects;
            NSLog(@"Count of events %lu", (unsigned long)[objects count]);
            
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_eventsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellReuseIdentifier = @"cellReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseIdentifier];
        
        cell.textLabel.text=[[_eventsArray objectAtIndex:[indexPath row]] objectForKey:@"eventName"];
        cell.textLabel.frame=CGRectMake(0, 0, self.view.frame.size.width, 50);
        NSString*str=[NSString stringWithFormat:@"%@ \n%@", [[_eventsArray objectAtIndex:[indexPath row]] objectForKey:@"eventDesc"], [[_eventsArray objectAtIndex:[indexPath row]] objectForKey:@"eventDate"]];
        cell.detailTextLabel.text=str;
                cell.detailTextLabel.frame=CGRectMake(0, 50, self.view.frame.size.width, 250);
        cell.detailTextLabel.numberOfLines = 10;
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
    return 200;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
