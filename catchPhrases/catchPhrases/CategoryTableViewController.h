//
//  CategoryTableViewController.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryTableViewController;


@protocol CategoryTableViewControllerDelegate <NSObject>

- (void)category:(CategoryTableViewController *)categoryVC backButtonPressed:(id)sender;

@end



@interface CategoryTableViewController : UITableViewController

@property (weak, nonatomic) id<CategoryTableViewControllerDelegate> delegate;

@end
