//
//  CategoryTableViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "CategoryTableViewController.h"



@interface CategoryTableViewController ()

@end



@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - Table view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) // deal with language
        [self handleSingleSelectionForTableView:tableView indexPath:indexPath];
    
    else // deal with categories
        if (cell.accessoryType == UITableViewCellAccessoryNone)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) // deal with language
        [self handleSingleSelectionForTableView:tableView indexPath:indexPath];
    
    else // deal with categories
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
            cell.accessoryType = UITableViewCellAccessoryNone;
    
}



#pragma mark - Single selection
- (void)handleSingleSelectionForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger index;
    if (indexPath.row == 0) index = indexPath.row + 1;
    else index = indexPath.row - 1;
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:index inSection:indexPath.section];
    
    [self reverseCellSelection:cell];
    [self tryToDeselectCellSelection:[tableView cellForRowAtIndexPath:newIndexPath]];
}

- (void)reverseCellSelection:(UITableViewCell *)cell {
    if (cell.accessoryType == UITableViewCellAccessoryNone)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)tryToDeselectCellSelection:(UITableViewCell *)cell {
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
        cell.accessoryType = UITableViewCellAccessoryNone;
}



#pragma mark - Navigation
- (IBAction)backButtonPressed:(id)sender {
    if ([_delegate respondsToSelector:@selector(category:backButtonPressed:)])
        [_delegate category:self backButtonPressed:nil];
}


@end
