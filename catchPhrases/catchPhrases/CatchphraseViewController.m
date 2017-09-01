//
//  CatchphraseViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "CatchphraseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PhraseManager.h"
#import "SettingsHelper.h"
#import "SettingsEntity.h"



@interface CatchphraseViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) PhraseManager  *phraseManager;
@property (strong, nonatomic) SettingsEntity *settings;
@property (strong, nonatomic) AVPlayer       *avPlayer;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *largeLabel;

@end



@implementation CatchphraseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phraseManager    = [PhraseManager sharedInstance];
    self.settings         = [SettingsHelper loadSettings];
    [self.phraseManager startNewGameSesion];
    
    self.title            = nil;
    self.middleLabel.text = nil;
    self.largeLabel.text  = nil;
    
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
    NSString *phrase = [self.phraseManager catchphraseGameNextPhrase];
    if (!phrase) {
        [self backButtonPressed:nil];
        return;
    }
    
    switch (self.settings.phraseFontSize) {
        
        case PhraseFontSizeSmall:
            self.title = phrase;
            break;
            
        case PhraseFontSizeMiddle:
            self.middleLabel.text = phrase;
            break;
        
        case PhraseFontSizeLarge:
            self.largeLabel.text = phrase;
            break;
            
        default: break;
    }
}





@end
