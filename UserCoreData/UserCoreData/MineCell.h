//
//  MineCell.h
//  UserCoreData
//
//  Created by ford Gao on 2018/9/10.
//  Copyright © 2018年 ford Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowHeight;


@end
