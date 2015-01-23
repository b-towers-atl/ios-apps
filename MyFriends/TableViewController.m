//
//  TableViewController.m
//  MyFriends
//
//  Created by Bobby Towers on 1/23/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "TableViewController.h"

#import <Parse/Parse.h>

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *friendTextField;

@end

@implementation TableViewController
{
    
    NSMutableArray * items;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PFUser currentUser].username = @"Bobby";
    
    [PFUser currentUser].password = @"password";
    
    [[PFUser currentUser] saveInBackground];
    
    items = [@[] mutableCopy];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateList) userInfo:nil repeats:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateList {
    
    PFQuery * listQuery = [PFQuery queryWithClassName:@"Message"];
    
    [listQuery orderByDescending:@"createdAt"];
    
    //    [messageQuery whereKey:@"owner" equalTo:[PFUser currentUser]];
    
    [listQuery includeKey:@"owner"];
    
    [listQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count > 0) {
            
            items = [objects mutableCopy];
            
            //            NSLog(@"found %@", messages);
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

- (IBAction)addItem:(id)sender {
    
    // PFObject is a blank template for any class name or item name
    PFObject * newItem = [PFObject objectWithClassName:@"Item"];
    
    newItem[@"text"] = self.friendTextField.text;
    
    // this is a singleton
    // a singleton alloc and inits once
    newItem[@"owner"] = [PFUser currentUser];
    
    [newItem saveInBackground];
    
    self.friendTextField.text = @"";
    
    // adds item to items array and reloads the tableView
    //    [items addObject:newItem];
    
    [items insertObject:newItem atIndex:0];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    PFObject * message = items[indexPath.row];
    PFUser * owner = message[@"owner"];
    
    cell.textLabel.text = owner.username;
    cell.detailTextLabel.text = message[@"text"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        PFObject * item = items[indexPath.row];
        
        [item deleteInBackground];
        
        [items removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


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
