//
//  SettingsEntity.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/31/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SettingsEntity : NSObject <NSCoding>

@property (assign, nonatomic) BOOL nouns;
@property (assign, nonatomic) BOOL nouns2;
@property (assign, nonatomic) BOOL movies;
@property (assign, nonatomic) BOOL idioms;

@property (assign, nonatomic) BOOL russian;
@property (assign, nonatomic) BOOL english;

@end
