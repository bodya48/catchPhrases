//
//  SettingsTableViewController.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingsTableViewController;


@protocol SettingsTableViewControllerDelegate <NSObject>

- (void)settings:(SettingsTableViewController *)settingsVC backButtonPressed:(id)sender;

@end



@interface SettingsTableViewController : UITableViewController

@property (weak, nonatomic) id<SettingsTableViewControllerDelegate> delegate;

@end
