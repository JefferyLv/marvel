//
//  DetailViewController.h
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "DetailViewController.h"
#import "TableViewCell.h"
#import "Character.h"

#import "UIImageView+Cache.h"
#import "FavoriteManager.h"

static NSString * const cellIdentifier = @"DetailCell";

enum {
    Comics = 0,
    Events,
    Stories,
    Series,
} ItemType;

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (nonatomic, weak) IBOutlet UITextView *characterName;
@property (nonatomic, weak) IBOutlet UITextView *characterDesc;
@property (nonatomic, weak) IBOutlet UIImageView *characterImage;
@property (nonatomic, weak) IBOutlet UITableView *characterDetails;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characterName.text = self.character.name;
    if (self.character.descriptionField.length > 0) {
        self.characterDesc.text = self.character.descriptionField;
    }
    self.likeButton.selected = [[FavoriteManager sharedInstance] isFavorited:self.character];
    
    [self.characterImage setImageFromCache:[self.character.thumbnail toString]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <IBAction>

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[FavoriteManager sharedInstance] persist];
}

- (IBAction)like:(id)sender {
    [self.likeButton setSelected:![self.likeButton isSelected]];
    
    if ([self.likeButton isSelected]) {
        [[FavoriteManager sharedInstance] add:self.character];
    } else {
        [[FavoriteManager sharedInstance] remove:self.character];
    }
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                          forIndexPath:indexPath];
    
    NSArray<Item*> *items;
    switch (indexPath.section) {
        case Comics:
            items = self.character.comics.items;
            break;
        case Events:
            items = self.character.events.items;
            break;
        case Stories:
            items = self.character.stories.items;
            break;
        case Series:
        default:
            items = self.character.series.items;
    }
    
    [cell configureCellWithName:items[indexPath.row].name
                 andDescription:items[indexPath.row].resourceURI];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    NSArray<Item*> *items;
    switch (section) {
        case Comics:
            items = self.character.comics.items;
            break;
        case Events:
            items = self.character.events.items;
            break;
        case Stories:
            items = self.character.stories.items;
            break;
        case Series:
        default:
            items = self.character.series.items;
    }
    return items.count >= 3 ? 3 : items.count;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case Comics:
            return @"Comics";
        case Events:
            return @"Events";
        case Stories:
            return @"Stories";
        case Series:
        default:
            return @"Series";
    }
}

#pragma mark <UITableViewDelegate>

@end
