//
//  WordsHelper.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PhraseHelper.h"
#import "PhrasesDatabase.h"



@implementation PhraseHelper

+ (NSString *)nextPhrase {
    PhrasesDatabase *container  = [PhrasesDatabase sharedInstance];
    NSArray *usedPhrases        = container.usedPhrasesArray;
    NSString *newPhrase         = [self newPhrase:container.allPhrasesArray];
    
    while ([self wasThisPhraseUsed:newPhrase usedPhrases:usedPhrases]) {
        if ([container.allPhrasesArray count] == [container.usedPhrasesArray count]) {
            newPhrase = nil;
            break;
        }
        newPhrase = [self newPhrase:container.allPhrasesArray];
    }
    
    [container phraseWasUsed:newPhrase];
    return newPhrase;
}


+ (BOOL)wasThisPhraseUsed:(NSString *)phrase usedPhrases:(NSArray *)usedPhrases {
    return [usedPhrases containsObject:phrase];
}


+ (NSString *)newPhrase:(NSArray *)phrasesArray {
    int randomNumber = [self randomValueLimitedByNumber:(int)[phrasesArray count]];
    return phrasesArray[randomNumber];
}


+ (int)randomValueLimitedByNumber:(int)limit {
    int randomNumber = arc4random() %limit;
    return randomNumber;
}

    



@end
