//
//  PlayViewController.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlayViewController;

@protocol PlayViewControllerDelegate <NSObject>

- (void)playViewController:(PlayViewController *)viewController backButtonPressed:(id)sender;

@end



@interface PlayViewController : UIViewController

@property (weak, nonatomic) id<PlayViewControllerDelegate> delegate;

@end
