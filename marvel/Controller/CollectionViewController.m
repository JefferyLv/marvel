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
#import "ModalTransitionDelegate.h"

#import "Character.h"
#import "MarvelService.h"
#import "FavoriteManager.h"

static NSString * const cellIdentifier = @"CharacterCell";
static NSString * const loadIdentifier = @"LoadMoreFooter";
static NSString * const detailViewCtrl = @"DetailViewCtrl";

@interface CollectionViewController () 

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) NSMutableArray *characters;
@property (nonatomic, strong) ModalTransition *presentTransition;

@property (nonatomic, weak) IBOutlet UIButton *homeButton;
@property (nonatomic, weak) IBOutlet UIButton *favoButton;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIView *progressView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characters = [NSMutableArray new];
    self.hasMore = NO;
    
    [self loadMore:nil];
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

- (IBAction)like:(id)sender {
    UIButton *like = (UIButton *)sender;
    UIView *prarentView = [sender superview];
    CollectionViewCell *cell = (CollectionViewCell *)[prarentView superview];
    NSIndexPath *index = [self.collectionView indexPathForCell:cell];
    
    like.selected = !like.selected;
    if (like.selected) {
        [[FavoriteManager sharedInstance] add:self.characters[index.row]];
    } else {
        [[FavoriteManager sharedInstance] remove:self.characters[index.row]];
    }
}

- (IBAction)loadMore:(id)sender {
    [self showProgress];
    
    NSInteger limit = 20;
    NSInteger offset = self.characters.count;
    NSString* nameStart = self.searchBar.text;
    
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
    BOOL like = [[FavoriteManager sharedInstance] isFavorited:character];
    [cell configureCellWithName:character.name
                       andImage:[character.thumbnail toString]
                       andLiked:like];
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.presentTransition = [ModalTransition new];
    
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:detailViewCtrl];
    detailView.character = self.characters[indexPath.row];
    detailView.transitioningDelegate = self.presentTransition;
    detailView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:detailView animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat margin = 30;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat cellWidth = (screenRect.size.width - margin) / 2.0;
    CGSize size = CGSizeMake(cellWidth, cellWidth + margin);
    
    return size;
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.characters removeAllObjects];
    
    [self loadMore:nil];
}

@end
