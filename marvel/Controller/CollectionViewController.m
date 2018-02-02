//
//  ViewController.m
//  marvel
//
//  Created by lvwei on 31/01/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"

#import "Character.h"
#import "BaseResponse.h"

#import "MarvelService.h"
#import "FavoriteManager.h"

static NSString * const cellIdentifier = @"CharacterCell";
static NSString * const loadIdentifier = @"LoadMoreFooter";
static NSString * const detailViewCtrl = @"DetailViewCtrl";

@interface CollectionViewController () 

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) NSMutableArray *characters;

@property (nonatomic, weak) IBOutlet UIButton *searchButton;
@property (nonatomic, weak) IBOutlet UITextField *searchString;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIVisualEffectView *progressView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characters = [NSMutableArray new];
    self.hasMore = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <Progress View>

- (void)showProgress {
    [self.progressView setHidden:NO];
    [self.view bringSubviewToFront:self.progressView];
}

- (void)hideProgress {
    [self.progressView setHidden:YES];
    [self.view sendSubviewToBack:self.progressView];
}

#pragma mark <IBAction>

- (IBAction)search:(id)sender {

    [self.characters removeAllObjects];

    [self loadMore:sender];
}

- (IBAction)favorite:(id)sender {
    
    self.hasMore = NO;
    
    [self.characters removeAllObjects];
    [self.characters addObjectsFromArray:[[FavoriteManager sharedInstance] all]];
    [self.collectionView reloadData];
}

- (IBAction)loadMore:(id)sender {
    [self showProgress];
    
    NSInteger limit = 20;
    NSInteger offset = self.characters.count;
    NSString* nameStart = self.searchString.text;
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t highPriority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(highPriority, ^{
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        
        [[MarvelService sharedInstance] getCharacters:nameStart
                                               offset:offset
                                                limit:limit
                                           completion:^(NSArray *characters, NSInteger total, NSError *error)
         {
             if (error) {
                 
             } else {
                 
                 [strongSelf.characters addObjectsFromArray:characters];
                 strongSelf.hasMore = strongSelf.characters.count != total;
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [strongSelf hideProgress];
                     [strongSelf.collectionView reloadData];
                 });
             }
         }];
    });
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.characters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                         forIndexPath:indexPath];
    cell.layer.cornerRadius = 2.5;
    cell.clipsToBounds = YES;
    
    Character *character = self.characters[indexPath.row];
    [cell configureCellWithName:character.name
                       andImage:[character.thumbnail toString]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView* footerView =
            [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                               withReuseIdentifier:loadIdentifier
                                                      forIndexPath:indexPath];
        
        
        footerView.hidden = !self.hasMore;
        return footerView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:detailViewCtrl];
    Character *character = self.characters[indexPath.row];
    detailView.character = character;
    
    [self presentViewController:detailView animated:YES completion:nil];
}

@end
