//
//  PlayViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PhraseManager.h"
#import "SettingsHelper.h"
#import "SettingsEntity.h"



@interface PlayViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) PhraseManager  *phraseManager;
@property (strong, nonatomic) AVPlayer       *avPlayer;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *largeLabel;

@end



@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phraseManager    = [PhraseManager sharedInstance];
    self.title            = nil;
    self.middleLabel.text = nil;
    self.largeLabel.text  = nil;
    
    [self.phraseManager startNewGameSesion];
    [self addGesture];
    [self startCountDown];
    [self showNextPhrase];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - Countdown
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



#pragma mark - Actions
- (IBAction)backButtonPressed:(id)sender {
    [self.avPlayer pause];
    self.avPlayer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextPhrase)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setDelegate:self];
    [self.view  addGestureRecognizer:tapGesture];
}


- (void)showNextPhrase {
    NSString *phrase = [self.phraseManager nextPhrase];
    if (!phrase) {
        [self backButtonPressed:nil];
        return;
    }
    
    SettingsEntity *settings = [SettingsHelper loadSettings];
    switch (settings.phraseFontSize) {
        
        case CatchPhraseFontSizeSmall:
            self.title = phrase;
            break;
            
        case CatchPhraseFontSizeMiddle:
            self.middleLabel.text = phrase;
            break;
        
        case CatchPhraseFontSizeLarge:
            self.largeLabel.text = phrase;
            break;
            
        default: break;
    }
    
}





@end
