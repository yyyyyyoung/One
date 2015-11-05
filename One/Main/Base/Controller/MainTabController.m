//
//  MainTabController.m
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MainTabController.h"
#import "Common.h"
#import "TabBarBtn.h"
#import "BaseNaviController.h"

static NSInteger _flag = 0;

@interface MainTabController ()
{
    NSArray *_tabNorImageArray;
    NSArray *_tabSelImageArray;
    NSArray *_tabNameArray;
    
    NSMutableArray *_btnArray;
}
@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTab];
    [self createStoryBoard];
}

- (void)createTab
{
    //除去自带标签按钮在BaseViewController
    
    _tabNorImageArray = @[@"home",
                          @"reading"];
    _tabSelImageArray = @[@"homeSelected@2x",
                          @"readingSelected@2x"];
    _tabNameArray = @[@"首页",@"文章"];
    
    CGFloat btnwidth = kScreenWidth / _tabNameArray.count;
    _btnArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _tabNameArray.count; i++) {
        TabBarBtn *button = [[TabBarBtn alloc] initWithTitle:_tabNameArray[i] imageName:_tabNorImageArray[i] frame:CGRectMake(i * btnwidth, 0, btnwidth, 49)];
        if (i == 0) {
            [button setSelImage:_tabSelImageArray[i]];
            [button setSelTitle:_tabNameArray[i]];
        }
        button.tag = i;
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnArray addObject:button];
        [self.tabBar addSubview:button];
    }
}

- (void)btnAction:(TabBarBtn *)button
{
    self.selectedIndex = button.tag;
    
    if (_flag != button.tag) {
        TabBarBtn *btn = _btnArray[_flag];
        
        [btn setNorImage:_tabNorImageArray[_flag]];
        [btn setNorTitle:_tabNameArray[_flag]];
        
        [button setSelImage:_tabSelImageArray[button.tag]];
        [button setSelTitle:_tabNameArray[button.tag]];
    }
    _flag = button.tag;
}

- (void)createStoryBoard
{
    NSArray *name = @[@"Home",
                      @"Article"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:name.count];
    
    for (int i = 0; i < name.count; i++) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name[i] bundle:nil];
        
        BaseNaviController *navC = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:navC];
    }
    
    self.viewControllers = navArray;
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
