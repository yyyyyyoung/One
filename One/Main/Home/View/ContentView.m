//
//  ContentView.m
//  One
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ContentView.h"
#import "UIImageView+WebCache.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setModel:(HomeModel *)model
{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
        
        [self setNeedsDisplay];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//期刊
    _periodLabel.text = _model.strHpTitle;
    
//图片
    [_image sd_setImageWithURL:[NSURL URLWithString:_model.strOriginalImgUrl]];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    
//作品名&作者
    NSString *authorStr = _model.strAuthor;
    NSArray *authorArray = [authorStr componentsSeparatedByString:@"&"];
    _imageNameLabel.text = authorArray[0];
    _authorLabel.text = authorArray[1];
    
//日子&日期
    NSString *date=_model.strMarketTime;    //格式2015-10-29
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    NSDictionary *dateDic = @{@"01":@"Jan",
                              @"02":@"Feb",
                              @"03":@"Mar",
                              @"04":@"Apr",
                              @"05":@"May",
                              @"06":@"Jun",
                              @"07":@"Jul",
                              @"08":@"Aug",
                              @"09":@"Sept",
                              @"10":@"Oct",
                              @"11":@"Nov",
                              @"12":@"Dec"};
    
    _dayLabel.textColor = [UIColor colorWithRed:40 / 255.0 green:181 / 255.0 blue:241 / 255.0 alpha:1];
    _dayLabel.text = dateArray[2];
    
    NSString *dayyy = dateArray[1];
    _dateLabel.text = [NSString stringWithFormat:@"%@,%@",dateDic[dayyy],dateArray[0]];
    _dateLabel.textColor = [UIColor colorWithRed:194 / 255.0 green:195 / 255.0 blue:197 / 255.0 alpha:0.8];
    
//内容
    //计算文本高度
    NSString *contentStr = _model.strContent;
    CGFloat width = CGRectGetWidth(self.frame) - 104;
    CGFloat textHeight = [WXLabel getTextHeight:14 width:width text:contentStr linespace:5];
    
    _contentLabel.height = textHeight;
    _contentLabel.text = contentStr;
    _contentLabel.linespace = 5;
    _contentLabel.textColor = [UIColor whiteColor];
    
//内容背景
    UIImage *image = [UIImage imageNamed:@"contBack@2x"];
    UIImage *bgimage = [image stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    
    _bgImage.image = bgimage;
    _bgImage.height = textHeight + 25;
    
}

@end
