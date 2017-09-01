//
//  PhrasesDatabase.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhrasesDatabase : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)catchphrasePhrasesArray;
- (NSArray *)passwordPhrasesArray;
- (NSArray *)usedPhrasesArray;
- (void)phraseWasUsed:(NSString *)phrase;

- (void)preparePhrasesForGameSession;

- (void)clearUsedPhrases;
- (int)nounsCount;
- (int)moviesCount;
- (int)idiomsCount;

@end
