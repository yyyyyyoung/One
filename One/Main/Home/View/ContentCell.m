//
//  ContentCell.m
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ContentCell.h"
#import "UIViewExt.h"
#import "UIImageView+HighlightedWebCache.h"
#import "UIImage+MultiFormat.h"

@implementation ContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *contentStr = _dataDic[@"strContent"];
    CGFloat width = CGRectGetWidth(self.frame) - 100;
    _contentLabel.linespace = 5;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor whiteColor];
//    _contentLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"contBack@2x"]];
    //计算Label高度
    CGFloat textHeight = [WXLabel getTextHeight:14 width:width text:contentStr linespace:5];
    _contentLabel.height = textHeight;
    _contentLabel.text = contentStr;
    
    UIImage *image = [UIImage imageNamed:@"contBack@2x"];
    UIImage *bgimage = [image stretchableImageWithLeftCapWidth:15 topCapHeight:15];
//    bgimage = @"contBack@2x";
    
    _bgImage.image = bgimage;
    _bgImage.height = textHeight + 20;
    
    _dayLabel.textColor = [UIColor colorWithRed:40 / 255.0 green:181 / 255.0 blue:241 / 255.0 alpha:1];
    
    NSString *date=_dataDic[@"strMarketTime"];
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    
    _dayLabel.text = dateArray[2];
    
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
    
    NSString *dayyy = dateArray[1];
    _dateLabel.text = [NSString stringWithFormat:@"%@,%@",dateDic[dayyy],dateArray[0]];
    _dateLabel.textColor = [UIColor colorWithRed:194 / 255.0 green:195 / 255.0 blue:197 / 255.0 alpha:0.8];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
