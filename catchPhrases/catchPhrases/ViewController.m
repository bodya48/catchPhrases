//
//  ViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/29/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "ViewController.h"
#import "CatchPhraseViewController.h"
#import "PasswordViewController.h"
#import "SettingsTableViewController.h"



@interface ViewController () <UIPopoverPresentationControllerDelegate, SettingsTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)startCatchphrasePressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Catchphrase" bundle:nil];
    CatchphraseViewController *catchphraseVC = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:catchphraseVC animated:YES];
}


- (IBAction)startPasswordPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Password" bundle:nil];
    PasswordViewController *passwordVC = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:passwordVC animated:YES];
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
