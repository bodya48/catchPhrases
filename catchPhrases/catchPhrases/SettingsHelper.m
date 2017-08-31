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
    return settings;
}


+ (BOOL)isSetting:(SettingsEntity *)oldSettings equalTo:(SettingsEntity *)newSetting {
    if (oldSettings.nouns   != newSetting.nouns)    return NO;
    if (oldSettings.movies  != newSetting.movies)   return NO;
    if (oldSettings.idioms  != newSetting.idioms)   return NO;
    if (oldSettings.russian != newSetting.russian)  return NO;
    if (oldSettings.english != newSetting.english)  return NO;
    return YES;
}

@end
