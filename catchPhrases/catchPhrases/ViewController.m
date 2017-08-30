//
//  ViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/29/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "ViewController.h"
#import "PlayViewController.h"
#import "CategoryTableViewController.h"



@interface ViewController () <PlayViewControllerDelegate, UIPopoverPresentationControllerDelegate, CategoryTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *categoryButton;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)startGamePressed:(id)sender {
    UIStoryboard *storyboard        = [UIStoryboard storyboardWithName:@"Play" bundle:nil];
    UINavigationController *gameVC  = [storyboard instantiateInitialViewController];
    gameVC.modalTransitionStyle     = UIModalTransitionStyleCrossDissolve;
    
    id viewController = [gameVC viewControllers][0];
    if ([viewController isKindOfClass:[PlayViewController class]])
        [((PlayViewController *)viewController) setDelegate:self];
    
    [self presentViewController:gameVC animated:YES completion:nil];
}



- (void)playViewController:(PlayViewController *)viewController backButtonPressed:(id)sender {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)categoryButtonPressed:(id)sender {
    UIStoryboard *storyboard        = [UIStoryboard storyboardWithName:@"Category" bundle:nil];
    UINavigationController *navVC   = [storyboard instantiateInitialViewController];
    navVC.preferredContentSize      = CGSizeMake(self.view.bounds.size.width / 3, self.view.bounds.size.height / 2);
    navVC.modalPresentationStyle    = UIModalPresentationPopover;
    navVC.popoverPresentationController.delegate = self;
    
    CategoryTableViewController *categoryVC = (CategoryTableViewController *)[[navVC viewControllers] firstObject];
    categoryVC.delegate = self;
    
    [self presentViewController:navVC animated:YES completion:nil];
}


- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    popoverPresentationController.permittedArrowDirections  = UIPopoverArrowDirectionAny;
    popoverPresentationController.barButtonItem             = self.categoryButton;
}


- (void)category:(CategoryTableViewController *)categoryVC backButtonPressed:(id)sender {
    [categoryVC dismissViewControllerAnimated:YES completion:nil];
}


@end
