//
//  SettingsEntity.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/31/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NounsAmount50,
    NounsAmount100,
    NounsAmount200,
    NounsAmount300,
    NounsAmount500,
    NounsAmount1000,
    NounsAmount2000,
    NounsAmountAll
} NounsAmount;

typedef enum {
    CatchPhraseFontSizeSmall,
    CatchPhraseFontSizeMiddle,
    CatchPhraseFontSizeLarge
} CatchPhraseFontSize;


@interface SettingsEntity : NSObject <NSCoding>

@property (assign, nonatomic) BOOL nouns;
@property (assign, nonatomic) BOOL movies;
@property (assign, nonatomic) BOOL idioms;

@property (assign, nonatomic) BOOL russian;
@property (assign, nonatomic) BOOL english;

@property (assign, nonatomic) NounsAmount           nounsAmount;
@property (assign, nonatomic) CatchPhraseFontSize   phraseFontSize;
@property (assign, nonatomic) BOOL                  clearUsedPhrases;

@end
