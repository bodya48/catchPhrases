//
//  PhraseManager.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhraseManager : NSObject

+ (instancetype)sharedInstance;

- (void)startNewGameSesion;

- (NSString *)catchphraseGameNextPhrase;
- (NSString *)passwordGameNextPhrase;

- (void)updateAllPhrasesAccordingToSettings;

- (int)nounsCount;
- (int)moviesCount;
- (int)idiomsCount;

@end
