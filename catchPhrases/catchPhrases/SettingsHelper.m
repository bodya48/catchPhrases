//
//  SettingsHelper.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/31/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "SettingsHelper.h"
#import "SettingsEntity.h"

#define KEY_FOR_SETTINGS_ENTITY @"KEY_FOR_SETTINGS_ENTITY"



@implementation SettingsHelper

+ (void)saveSettings:(SettingsEntity *)settings {
    if (!settings) return;
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:settings];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:KEY_FOR_SETTINGS_ENTITY];
}


+ (SettingsEntity *)loadSettings {
    NSData *settingsData     = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_FOR_SETTINGS_ENTITY];
    SettingsEntity *settings = [NSKeyedUnarchiver unarchiveObjectWithData:settingsData];
    if (!settings) settings  = [self defaultSettings];
    return settings;
}


+ (BOOL)isSetting:(SettingsEntity *)oldSettings equalTo:(SettingsEntity *)newSetting {
    if (oldSettings.nouns   != newSetting.nouns)    return NO;
    if (oldSettings.movies  != newSetting.movies)   return NO;
    if (oldSettings.idioms  != newSetting.idioms)   return NO;
    if (oldSettings.nounsAmount != newSetting.nounsAmount) return NO;
    
    return YES;
}


+ (SettingsEntity *)defaultSettings {
    SettingsEntity *settings = [[SettingsEntity alloc] init];
    
    [settings setNouns:YES];
    [settings setMovies:NO];
    [settings setIdioms:NO];
    
    [settings setRussian:YES];
    [settings setEnglish:NO];
    
    [settings setNounsAmount:NounsAmountAll];
    [settings setPhraseFontSize:CatchPhraseFontSizeSmall];
    [settings setClearUsedPhrases:NO];
    
    [self saveSettings:settings];
    return settings;
}

@end
