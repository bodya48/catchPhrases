//
//  PasswordViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 9/1/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PasswordViewController.h"
#import "PhraseManager.h"
#import "SettingsHelper.h"
#import "SettingsEntity.h"



@interface PasswordViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) PhraseManager  *phraseManager;
@property (strong, nonatomic) SettingsEntity *settings;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *largeLabel;

@end



@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phraseManager    = [PhraseManager sharedInstance];
    self.settings         = [SettingsHelper loadSettings];
    [self.phraseManager startNewGameSesion];
    
    self.title            = nil;
    self.middleLabel.text = nil;
    self.largeLabel.text  = nil;
    
    [self addGesture];
    [self showNextPhrase];
}


- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextPhrase)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setDelegate:self];
    [self.view  addGestureRecognizer:tapGesture];
}


- (void)showNextPhrase {
    NSString *phrase = [self.phraseManager passwordGameNextPhrase];
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
