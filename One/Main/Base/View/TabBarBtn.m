//
//  TabBarBtn.m
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "TabBarBtn.h"

@implementation TabBarBtn

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnTabImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 25) / 2, 4, 25, 25)];
        _btnTabImage.image = [UIImage imageNamed:imageName];
        _btnTabImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_btnTabImage];
        
        _btnTabTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, self.bounds.size.width, 15)];
        _btnTabTitle.text = title;
        _btnTabTitle.font = [UIFont systemFontOfSize:13];
        _btnTabTitle.textColor = [UIColor colorWithRed:88 / 255.0 green:88 / 255.0 blue:88 / 255.0 alpha:1];
        _btnTabTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_btnTabTitle];
    }
    return self;
}

- (void)setNorImage:(NSString *)imageName
{
    _btnTabImage.image = [UIImage imageNamed:imageName];
}
- (void)setSelImage:(NSString *)imageName
{
    _btnTabImage.image = [UIImage imageNamed:imageName];
}

- (void)setNorTitle:(NSString *)title
{
    _btnTabTitle.text = title;
    _btnTabTitle.textColor = [UIColor colorWithRed:88 / 255.0 green:88 / 255.0 blue:88 / 255.0 alpha:1];
}
- (void)setSelTitle:(NSString *)title
{
    _btnTabTitle.text = title;
    _btnTabTitle.textColor = [UIColor colorWithRed:21 / 255.0 green:168 / 255.0 blue:234 / 255.0 alpha:1];
}

@end
