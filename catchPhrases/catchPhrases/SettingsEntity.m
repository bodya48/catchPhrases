//
//  SettingsEntity.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/31/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "SettingsEntity.h"


#define kNounsKey           @"nouns"
#define kMoviesKey          @"movies"
#define kIdiomsKey          @"idioms"

#define kRussianKey         @"russian"
#define kEnglishKey         @"english"

#define kNounsAmountKey     @"nounsamount"
#define kPhraseFontSizeKey  @"phrasefontsize"
#define kClearPhrasesKey    @"clearusedphrases"



@implementation SettingsEntity

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithInt:self.nouns]   forKey:kNounsKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.movies]  forKey:kMoviesKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.idioms]  forKey:kIdiomsKey];
    
    [encoder encodeObject:[NSNumber numberWithInt:self.russian] forKey:kRussianKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.english] forKey:kEnglishKey];
    
    [encoder encodeObject:[NSNumber numberWithInt:self.nounsAmount]      forKey:kNounsAmountKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.phraseFontSize]   forKey:kPhraseFontSizeKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.clearUsedPhrases] forKey:kClearPhrasesKey];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.nouns      = [[decoder decodeObjectForKey:kNounsKey] intValue];
        self.movies     = [[decoder decodeObjectForKey:kMoviesKey] intValue];
        self.idioms     = [[decoder decodeObjectForKey:kIdiomsKey] intValue];
        
        self.russian    = [[decoder decodeObjectForKey:kRussianKey] intValue];
        self.english    = [[decoder decodeObjectForKey:kEnglishKey] intValue];
        
        self.nounsAmount      = [[decoder decodeObjectForKey:kNounsAmountKey]    intValue];
        self.phraseFontSize   = [[decoder decodeObjectForKey:kPhraseFontSizeKey] intValue];
        self.clearUsedPhrases = [[decoder decodeObjectForKey:kClearPhrasesKey]   intValue];
    }
    return self;
}


@end
