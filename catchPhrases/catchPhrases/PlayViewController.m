//
//  PlayViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PhraseHelper.h"



@interface PlayViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) AVPlayer *avPlayer;

@end



@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGesture];
    [self startCountDown];
    [self showNextPhrase];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)startCountDown {
    NSString *filepath  = [[NSBundle mainBundle] pathForResource:@"countdown320.mp3" ofType:nil inDirectory:@"Media"];
    NSURL *fileURL      = [NSURL fileURLWithPath:filepath];
    self.avPlayer                   = [AVPlayer playerWithURL:fileURL];
    self.avPlayer.actionAtItemEnd   = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
    
    [self.avPlayer play];
}


- (void)itemDidFinishPlaying:(NSNotification *)notification {
    [self backButtonPressed:nil];
}


- (IBAction)backButtonPressed:(id)sender {
    [self.avPlayer pause];
    self.avPlayer = nil;
    if ([_delegate respondsToSelector:@selector(playViewController:backButtonPressed:)])
        [_delegate playViewController:self backButtonPressed:nil];
}


- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextPhrase)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setDelegate:self];
    //[self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:tapGesture];
}


- (void)showNextPhrase {
    NSString *phrase = [PhraseHelper nextPhrase];
    if (!phrase) {
        [self backButtonPressed:nil];
        return;
    }
    self.title = phrase;
}




@end
