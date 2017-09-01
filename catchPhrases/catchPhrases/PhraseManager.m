//
//  PhraseManager.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PhraseManager.h"
#import "PhrasesDatabase.h"
#import "SettingsHelper.h"
#import "SettingsEntity.h"



@interface PhraseManager ()

@property (strong, nonatomic) PhrasesDatabase *phrasesDatabase;

@end


@implementation PhraseManager

+ (instancetype)sharedInstance {
    static PhraseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PhraseManager alloc] init];
        instance.phrasesDatabase = [PhrasesDatabase sharedInstance];
    });
    return instance;
}

- (void)updateAllPhrasesAccordingToSettings {
    [self.phrasesDatabase preparePhrasesForGameSession];
}



- (void)startNewGameSesion {
    if ([SettingsHelper loadSettings].clearUsedPhrases)
        [self.phrasesDatabase clearUsedPhrases];
}


- (NSString *)nextPhrase {
    if ([self.phrasesDatabase.allPhrasesArray count] == 0) return nil;
    
    NSString *newPhrase  = [self newPhrase:self.phrasesDatabase.allPhrasesArray];
    int allPhrasesCount  = (int)[self.phrasesDatabase.allPhrasesArray count];
    int triesAmount = 0;

    while ([self wasThisPhraseUsed:newPhrase usedPhrases:self.phrasesDatabase.usedPhrasesArray]) {
        if (triesAmount >= allPhrasesCount * 2)
            [self.phrasesDatabase clearUsedPhrases];
        
        triesAmount++;
        newPhrase = [self newPhrase:self.phrasesDatabase.allPhrasesArray];
    }
    
    [self.phrasesDatabase phraseWasUsed:newPhrase];
    
    NSLog(@"all phrases: %ld", [self.phrasesDatabase.allPhrasesArray count]);
    NSLog(@"used phrases: %ld\n", [self.phrasesDatabase.usedPhrasesArray count]);
    
    return newPhrase;
}


- (BOOL)wasThisPhraseUsed:(NSString *)phrase usedPhrases:(NSArray *)usedPhrases {
    return [usedPhrases containsObject:phrase];
}


- (NSString *)newPhrase:(NSArray *)phrasesArray {
    int randomNumber = [self randomValueLimitedByNumber:(int)[phrasesArray count]];
    return phrasesArray[randomNumber];
}


- (int)randomValueLimitedByNumber:(int)limit {
    int randomNumber = arc4random() %limit;
    return randomNumber;
}


- (int)nounsCount {
    return [self.phrasesDatabase nounsCount];
}

- (int)moviesCount {
    return [self.phrasesDatabase moviesCount];
}

- (int)idiomsCount {
    return [self.phrasesDatabase idiomsCount];
}


@end
