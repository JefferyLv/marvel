//
//  TableViewCell.h
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;

- (void)configureCellWithName:(NSString *)name andDescription:(NSString *)descritpion;

@end
