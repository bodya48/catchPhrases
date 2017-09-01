//
//  PhrasesDatabase.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PhrasesDatabase.h"
#import "SettingsHelper.h"
#import "SettingsEntity.h"


#define csvNounsFileName     @"nouns.csv"
#define csvMoviesFileName    @"movies.csv"
#define csvIdiomsFileName    @"idioms.csv"



@interface PhrasesDatabase ()

@property (strong, nonatomic) NSMutableArray    *allPhrases;
@property (strong, nonatomic) NSMutableArray    *usedPhrases;

@property (strong, nonatomic) NSArray *nouns;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSArray *idioms;

@end



@implementation PhrasesDatabase

#pragma mark - Init
+ (instancetype)sharedInstance {
    static PhrasesDatabase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance             = [[PhrasesDatabase alloc] init];
        instance.allPhrases  = [[NSMutableArray alloc] init];
        instance.usedPhrases = [[NSMutableArray alloc] init];
        [instance pullAllPhrasesFromCSV];
    });
    return instance;
}

- (void)pullAllPhrasesFromCSV {
    self.nouns      = [self parseCSVFile:csvNounsFileName];
    self.movies     = [self parseCSVFile:csvMoviesFileName];
    self.idioms     = [self parseCSVFile:csvIdiomsFileName];
}

- (NSMutableArray *)allPhrasesArray {
    return self.allPhrases;
}

- (NSMutableArray *)usedPhrasesArray {
    return self.usedPhrases;
}

- (void)phraseWasUsed:(NSString *)phrase {
    if (!phrase || [phrase length] == 0) return;
    [self.usedPhrases addObject:phrase];
}



#pragma mark - Prepare phrases for game
- (void)preparePhrasesForGameSession {
    SettingsEntity *settings = [SettingsHelper loadSettings];
    self.allPhrases          = [[NSMutableArray alloc] init];
    if (settings.clearUsedPhrases)
        self.usedPhrases     = [[NSMutableArray alloc] init];
    
    if (settings.nouns)
        [self addPhrases:self.nouns  withLimitNumber:settings.nounsAmount];
    
    if (settings.movies)
        [self addPhrases:self.movies withLimitNumber:NounsAmountAll];
    
    if (settings.idioms)
        [self addPhrases:self.idioms withLimitNumber:NounsAmountAll];
    
    [self randomizeAllPhrases];
}



#pragma mark - Helpers
- (NSArray *)parseCSVFile:(NSString *)fileName {
    NSArray *parsedCSV        = [[NSMutableArray alloc] init];
    NSError *error;
    NSString *csvFilePath     = [[NSBundle mainBundle] pathForResource:fileName ofType:nil inDirectory:@"Phrases"];
    NSString *csvFileContents = [NSString stringWithContentsOfFile:csvFilePath encoding:NSUTF8StringEncoding error:&error];
    
    if (csvFileContents && !error)
        parsedCSV = [csvFileContents componentsSeparatedByString:@"\r\n"];
    return parsedCSV;
}



- (void)addPhrases:(NSArray *)phrasesArray withLimitNumber:(NounsAmount)limitNumber {
    NSInteger limit;
    switch (limitNumber) {
        case NounsAmount50:
            limit = 50; break;
        case NounsAmount100:
            limit = 100; break;
        case NounsAmount200:
            limit = 200; break;
        case NounsAmount300:
            limit = 300; break;
        case NounsAmount500:
            limit = 500; break;
        case NounsAmount1000:
            limit = 1000; break;
        case NounsAmount2000:
            limit = 2000; break;
        case NounsAmountAll:
            limit = [phrasesArray count]; break;
        default:
            limit = [phrasesArray count]; break;
    }
    
    for (int index = 0; index < limit; index++) {
        if (index >= [phrasesArray count]) return;
        
        NSString *phrase = phrasesArray[index];
        if (!phrase || [phrase length] == 0) return;
        
        [self.allPhrases addObject:phrase];
    }
}

- (void)randomizeAllPhrases {
    for (NSInteger i = self.allPhrases.count - 1; i > 0; i--) {
        [self.allPhrases exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int)i + 1)];
    }
}


- (void)clearUsedPhrases {
    self.usedPhrases = [[NSMutableArray alloc] init];
}

- (int)nounsCount {
    return (int)[self.nouns count];
}
- (int)moviesCount {
    return (int)[self.movies count];
}
- (int)idiomsCount {
    return (int)[self.idioms count];
}


@end
