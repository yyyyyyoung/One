//
//  ContentCell.h
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"

@interface ContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet WXLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (nonatomic, strong) NSDictionary *dataDic;

@end
