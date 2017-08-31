//
//  SettingsEntity.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/31/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "SettingsEntity.h"


#define kNounsKey   @"nouns"
#define kNouns2Key  @"nouns2"
#define kMoviesKey  @"movies"
#define kIdiomsKey  @"idioms"
#define kRussianKey @"russian"
#define kEnglishKey @"english"



@implementation SettingsEntity

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithInt:self.nouns]   forKey:kNounsKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.nouns2]  forKey:kNouns2Key];
    [encoder encodeObject:[NSNumber numberWithInt:self.movies]  forKey:kMoviesKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.idioms]  forKey:kIdiomsKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.russian] forKey:kRussianKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.english] forKey:kEnglishKey];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.nouns      = [[decoder decodeObjectForKey:kNounsKey] intValue];
        self.nouns2     = [[decoder decodeObjectForKey:kNouns2Key] intValue];
        self.movies     = [[decoder decodeObjectForKey:kMoviesKey] intValue];
        self.idioms     = [[decoder decodeObjectForKey:kIdiomsKey] intValue];
        self.russian    = [[decoder decodeObjectForKey:kRussianKey] intValue];
        self.english    = [[decoder decodeObjectForKey:kEnglishKey] intValue];
    }
    return self;
}


@end
