//
//  ViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/29/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "ViewController.h"
#import "PlayViewController.h"


@interface ViewController () <PlayViewControllerDelegate>

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


@end
