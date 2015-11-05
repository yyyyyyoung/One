//
//  ContentView.h
//  One
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"
#import "HomeModel.h"

@interface ContentView : UIView<WXLabelDelegate>

@property (nonatomic, weak) IBOutlet UILabel *periodLabel;   //期刊
@property (nonatomic, weak) IBOutlet UIImageView *image;     //图片
@property (nonatomic, weak) IBOutlet UILabel *imageNameLabel;    //作品名
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;   //作者

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;  //日子
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;     //年月
@property (weak, nonatomic) IBOutlet WXLabel *contentLabel;  //内容
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;   //内容背景

@property (nonatomic, strong) HomeModel *model;
@end
