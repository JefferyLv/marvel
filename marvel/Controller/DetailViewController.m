//
//  DetailViewController.h
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "DetailViewController.h"
#import "TableViewCell.h"

#import "UIImageView+Cache.h"
#import "UILabel+Size.h"

#import "Character.h"
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
    [self.characterImage.layer setCornerRadius:CGRectGetHeight([self.characterImage bounds]) / 2];
    [self.characterImage.layer setMasksToBounds:YES];
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
    
    Item *item = [self getItems:indexPath.section][indexPath.row];
    [cell configureCellWithName:item.name
                 andDescription:item.resourceURI];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    NSArray *items = [self getItems:section];
    return items.count >= 3 ? 3 : items.count;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat FontSize = 16;
    UIFont *font = [UIFont systemFontOfSize:FontSize];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    Item *item = [self getItems:indexPath.section][indexPath.row];
    return [UILabel getHeightByWidth:screenSize.width title:item.resourceURI font:font] + 60;
}

#pragma mark <MISC>

- (NSArray<Item*> *)getItems:(NSInteger)section {
    switch (section) {
        case Comics:
            return self.character.comics.items;
        case Events:
            return self.character.events.items;
        case Stories:
            return self.character.stories.items;
        case Series:
        default:
            return self.character.series.items;
    }
}

@end
