//
//  SettingsTableViewController.m
//  catchPhrases
//
//  Created by Bogdan Laukhin on 8/30/17.
//  Copyright © 2017 ua.org. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SettingsHelper.h"
#import "SettingsEntity.h"
#import "PhraseHelper.h"
#import "PhrasesDatabase.h"



@interface SettingsTableViewController ()

@property (strong, nonatomic) SettingsEntity *oldSettings;

@end




@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.estimatedRowHeight   = 40;
    self.tableView.rowHeight            = UITableViewAutomaticDimension;
    [self prepopulateCategoriesTitles];
    [self prepopulateSettings];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveSettings];
}




#pragma mark - Table view
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectDeselectCell:tableView indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectDeselectCell:tableView indexPath:indexPath];
}

- (void)selectDeselectCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) return;
    
    if (indexPath.section == 1) // deal with language
        [self handleSingleSelectionForTableView:tableView indexPath:indexPath];
    
    else // deal with categories
        [self reverseCellSelection:[tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Single selection
- (void)handleSingleSelectionForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger index;
    if (indexPath.row == 0) index = indexPath.row + 1;
    else index = indexPath.row - 1;
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:index inSection:indexPath.section];
    
    [self reverseCellSelection:cell];
    [self tryToDeselectCellSelection:[tableView cellForRowAtIndexPath:newIndexPath]];
}

- (void)reverseCellSelection:(UITableViewCell *)cell {
    if (cell.accessoryType == UITableViewCellAccessoryNone)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)tryToDeselectCellSelection:(UITableViewCell *)cell {
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
        cell.accessoryType = UITableViewCellAccessoryNone;
}



#pragma mark - Navigation
- (IBAction)backButtonPressed:(id)sender {
    if ([_delegate respondsToSelector:@selector(settings:backButtonPressed:)])
        [_delegate settings:self backButtonPressed:nil];
}




#pragma mark - Settings
- (void)prepopulateCategoriesTitles {
    PhrasesDatabase *database = [PhrasesDatabase sharedInstance];
    UITableViewCell *cell;
    
    cell                = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.textLabel.text = [NSString stringWithFormat:@"Существительные [%d]", [database nounsCount]];
    
    cell                = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.textLabel.text = [NSString stringWithFormat:@"Существительные 2 [%d]", [database nounsCount]];
    
    cell                = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.text = [NSString stringWithFormat:@"Фильмы / мультфильмы [%d]", [database moviesCount]];
    
    cell                = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.text = [NSString stringWithFormat:@"Идиомы / Фразеологизмы [%d]", [database idiomsCount]];
}

- (void)prepopulateSettings {
    SettingsEntity *settings = [SettingsHelper loadSettings];
    self.oldSettings = settings;
    
    if (settings.nouns)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    if (settings.nouns2)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    if (settings.movies)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    if (settings.idioms)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (settings.russian)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].accessoryType = UITableViewCellAccessoryCheckmark;
    if (settings.english)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]].accessoryType = UITableViewCellAccessoryCheckmark;
}


- (void)saveSettings {
    SettingsEntity *newSettings = [SettingsEntity new];
    
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryType == UITableViewCellAccessoryCheckmark)
        [newSettings setNouns:YES];
    else [newSettings setNouns:NO];
    
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryType == UITableViewCellAccessoryCheckmark)
        [newSettings setNouns2:YES];
    else [newSettings setNouns2:NO];
    
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryType == UITableViewCellAccessoryCheckmark)
        [newSettings setMovies:YES];
    else [newSettings setMovies:NO];
    
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]].accessoryType == UITableViewCellAccessoryCheckmark)
        [newSettings setIdioms:YES];
    else [newSettings setIdioms:NO];
    
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].accessoryType == UITableViewCellAccessoryCheckmark)
        [newSettings setRussian:YES];
    else [newSettings setRussian:NO];
    
    if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]].accessoryType == UITableViewCellAccessoryCheckmark)
        [newSettings setEnglish:YES];
    else [newSettings setEnglish:NO];
    
    if (!newSettings.nouns && !newSettings.movies && !newSettings.idioms)
        [newSettings setNouns:YES];
    
    if (![SettingsHelper isSetting:self.oldSettings equalTo:newSettings]) {
        [SettingsHelper saveSettings:newSettings];
        [PhraseHelper updateAllPhrasesAccordingToSettings];
    }
}


@end
