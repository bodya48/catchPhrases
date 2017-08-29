//
//  PhrasesDatabase.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "PhrasesDatabase.h"



@interface PhrasesDatabase ()

@property (strong, nonatomic) NSArray           *allPhrases;
@property (strong, nonatomic) NSMutableArray    *usedPhrases;

@end




@implementation PhrasesDatabase

+ (instancetype)sharedInstance {
    static PhrasesDatabase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PhrasesDatabase alloc] init];
        [instance initAllPhrases];
        instance.usedPhrases = [[NSMutableArray alloc] init];
    });
    return instance;
}



- (NSArray *)allPhrasesArray {
    return self.allPhrases;
}


- (NSArray *)usedPhrasesArray {
    return [NSArray arrayWithArray:self.usedPhrases];
}


- (void)phraseWasUsed:(NSString *)phrase {
    if (!phrase || [phrase length] == 0) return;
    [self.usedPhrases addObject:phrase];
}


- (void)initAllPhrases {
    NSArray *phrases = @[@"Водить за нос",
                         @"Волосы дыбом",
                         @"Вот где собака зарыта!",
                         @"Втирать очки",
                         @"Железный занавес",
                         @"Желтая пресса",
                         @"Зарубить на носу",
                         @"Медвежья услуга",
                         @"На козе не подъедешь",
                         @"Типун тебе на язык",
                         @"Филькина грамота",
                         @"Ящик Пандоры",
                         @"Когда рак на горе свиснет"];
    self.allPhrases = phrases;
}



@end
