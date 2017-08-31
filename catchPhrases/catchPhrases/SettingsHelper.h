//
//  SettingsHelper.h
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/31/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SettingsEntity;


@interface SettingsHelper : NSObject

+ (void)saveSettings:(SettingsEntity *)settings;
+ (SettingsEntity *)loadSettings;

+ (BOOL)isSetting:(SettingsEntity *)oldSettings equalTo:(SettingsEntity *)newSetting;

@end
