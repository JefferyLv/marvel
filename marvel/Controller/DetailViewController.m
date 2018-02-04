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
#import "Item.h"
#import "FavoriteManager.h"
#import "MarvelService.h"

static NSString * const cellIdentifier = @"DetailCell";

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (nonatomic, weak) IBOutlet UITextView *characterName;
@property (nonatomic, weak) IBOutlet UIImageView *characterImage;
@property (nonatomic, weak) IBOutlet UITableView *characterDetails;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characterName.text = self.character.name;
    self.likeButton.selected = [[FavoriteManager sharedInstance] isFavorited:self.character];
    
    [self.characterImage setImageFromCache:[self.character.thumbnail toString]];
    [self.characterImage.layer setCornerRadius:CGRectGetHeight([self.characterImage bounds]) / 2];
    [self.characterImage.layer setMasksToBounds:YES];
    
    [self loadDetails];
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
                 andDescription:item.desc];
    
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

    CGFloat height = 36;
    CGFloat margin = 36;
    Item *item = [self getItems:indexPath.section][indexPath.row];
    if (item.desc) {
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        height += [UILabel getHeightByWidth:screenSize.width - margin title:item.desc font:font];
    }
    return height;
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

- (void)loadDetails {
    NSString *id = [NSString stringWithFormat:@"%ld", (long)self.character.idField];
    NSInteger offset = 0;
    NSInteger limit = 3;
    for (int tp = 0; tp < 4; tp++) {
        NSArray<Item *>* olditems = [self getItems:tp];
        [[MarvelService sharedInstance] getItemByType:tp
                                            character:id
                                               offset:offset
                                                limit:limit
                                           completion:^(NSArray<Item *> *items, NSError *error)
             {
                 if (!error)
                 {
                     for (int i = 0; i < items.count; i++) {
                         if ([olditems[i].resourceURI isEqualToString:items[i].resourceURI]) {
                             olditems[i].desc = items[i].desc;
                         }
                     }
        
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [self.characterDetails reloadSections:[NSIndexSet indexSetWithIndex:tp] withRowAnimation:NO];
                     });
                 }
             }];
    }

}

@end
