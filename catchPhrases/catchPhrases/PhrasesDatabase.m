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
@property (strong, nonatomic) NSArray *nounsLong;
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
        [instance pullAllPhrases];
    });
    return instance;
}

- (void)pullAllPhrases {
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
- (void)prepareAllPhrases {
    SettingsEntity *settings = [SettingsHelper loadSettings];
    
    if (settings.nouns)
        [self addPhrases:self.nouns toArray:self.allPhrases];
    if (settings.movies)
        [self addPhrases:self.movies toArray:self.allPhrases];
    if (settings.idioms)
        [self addPhrases:self.idioms toArray:self.allPhrases];
    
    [self randomizeAllPhrases];
}


- (void)updateAllPhrasesAccordingToSettings {
    self.allPhrases  = [[NSMutableArray alloc] init];
    
    if ([SettingsHelper loadSettings].clearUsedPhrases)
        self.usedPhrases = [[NSMutableArray alloc] init];
    
    [self prepareAllPhrases];
}


- (NSArray *)parseCSVFile:(NSString *)fileName {
    NSArray *parsedCSV        = [[NSMutableArray alloc] init];
    NSError *error;
    NSString *csvFilePath     = [[NSBundle mainBundle] pathForResource:fileName ofType:nil inDirectory:@"Phrases"];
    NSString *csvFileContents = [NSString stringWithContentsOfFile:csvFilePath encoding:NSUTF8StringEncoding error:&error];
    
    if (csvFileContents && !error)
        parsedCSV = [csvFileContents componentsSeparatedByString:@"\r\n"];
    return parsedCSV;
}


- (void)addPhrases:(NSArray *)phrasesArray toArray:(NSMutableArray *)originalArray {
    for (NSString *phrase in phrasesArray) {
        if (!phrase || [phrase length] == 0) return;
        [originalArray addObject:phrase];
    }
}

- (void)randomizeAllPhrases {
    for (NSInteger i = self.allPhrases.count - 1; i > 0; i--) {
        [self.allPhrases exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int)i + 1)];
    }
}



- (int)nounsCount {
    return (int)[self.nouns count];
}
- (int)nounsLongCount {
    return (int)[self.nounsLong count];
}
- (int)moviesCount {
    return (int)[self.movies count];
}
- (int)idiomsCount {
    return (int)[self.idioms count];
}


@end
