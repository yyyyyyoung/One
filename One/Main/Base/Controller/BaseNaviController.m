//
//  BaseNaviController.m
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseNaviController.h"
#import "Common.h"

@interface BaseNaviController ()

@end

@implementation BaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNaviImage];
}

- (void)addNaviImage
{
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 56) / 2, (44 - 17) / 2 , 56, 17)];
    logoImage.image = [UIImage imageNamed:@"navLogo@2x"];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.topViewController.navigationController.navigationBar addSubview:logoImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
