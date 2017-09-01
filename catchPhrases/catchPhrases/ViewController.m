//
//  ViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/29/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "ViewController.h"
#import "PlayViewController.h"
#import "SettingsTableViewController.h"



@interface ViewController () <UIPopoverPresentationControllerDelegate, SettingsTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)startGamePressed:(id)sender {
    UIStoryboard *storyboard        = [UIStoryboard storyboardWithName:@"Play" bundle:nil];
    PlayViewController *gameVC = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:gameVC animated:YES];
}



- (IBAction)settingsButtonPressed:(id)sender {
    UIStoryboard *storyboard        = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UINavigationController *navVC   = [storyboard instantiateInitialViewController];
    navVC.preferredContentSize      = CGSizeMake(350, 500);
    navVC.modalPresentationStyle    = UIModalPresentationPopover;
    navVC.popoverPresentationController.delegate = self;
    
    SettingsTableViewController *settingsVC = (SettingsTableViewController *)[[navVC viewControllers] firstObject];
    settingsVC.delegate = self;
    
    [self presentViewController:navVC animated:YES completion:nil];
}


- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    popoverPresentationController.permittedArrowDirections  = UIPopoverArrowDirectionAny;
    popoverPresentationController.barButtonItem             = self.settingsButton;
}


- (void)settings:(SettingsTableViewController *)settingsVC backButtonPressed:(id)sender {
    [settingsVC dismissViewControllerAnimated:YES completion:nil];
}


@end
