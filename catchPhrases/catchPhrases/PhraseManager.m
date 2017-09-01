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

#pragma mark - Init
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



#pragma mark - Game session
- (void)startNewGameSesion {
    if ([SettingsHelper loadSettings].clearUsedPhrases)
        [self.phrasesDatabase clearUsedPhrases];
}


- (NSString *)catchphraseGameNextPhrase {
    return [self nextPhrase:self.phrasesDatabase.catchphrasePhrasesArray];
}

- (NSString *)passwordGameNextPhrase {
    return [self nextPhrase:self.phrasesDatabase.passwordPhrasesArray];
}


- (NSString *)nextPhrase:(NSArray *)phrasesArray {
    if ([phrasesArray count] == 0) return nil;
    
    NSString *newPhrase  = [self newPhrase:phrasesArray];
    int allPhrasesCount  = (int)[phrasesArray count];
    int tryNumber = 0;

    while ([self wasThisPhraseUsed:newPhrase usedPhrases:self.phrasesDatabase.usedPhrasesArray]) {
        if (tryNumber >= allPhrasesCount * 2)
            [self.phrasesDatabase clearUsedPhrases];
        
        tryNumber++;
        newPhrase = [self newPhrase:phrasesArray];
    }
    
    [self.phrasesDatabase phraseWasUsed:newPhrase];
    
    NSLog(@"all phrases: %ld", [phrasesArray count]);
    NSLog(@"used phrases: %ld\n", [self.phrasesDatabase.usedPhrasesArray count]);
    return newPhrase;
}



#pragma mark - Helpers
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
