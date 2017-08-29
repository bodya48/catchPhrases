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

- (NSArray *)allPhrasesArray;
- (NSArray *)usedPhrasesArray;
- (void)phraseWasUsed:(NSString *)phrase;

@end
