//
//  TabBarBtn.h
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarBtn : UIButton

{
    UIImageView *_btnTabImage;
    UILabel *_btnTabTitle;
}

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame;

- (void)setNorImage:(NSString *)imageName;
- (void)setSelImage:(NSString *)imageName;

- (void)setNorTitle:(NSString *)title;
- (void)setSelTitle:(NSString *)title;

@end
