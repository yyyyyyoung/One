//
//  HomeTableView.h
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *dataDic;

@end
