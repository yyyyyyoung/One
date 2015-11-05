//
//  HomeTableView.m
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "HomeTableView.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "ContentCell.h"

@interface HomeTableView ()
{
    UILabel *_authorLabel1;
    UILabel *_authorLabel2;
    UILabel *_periodLabel;
    
    UIImageView *_image;
    
    CGFloat _contentLabelWidth;
}
@end

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor clearColor];
        
        _dataDic = [[NSDictionary alloc] init];
        //消除单元格的线
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        
        UINib *nib = [UINib nibWithNibName:@"ContentCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"ContentCell"];
    }
    return self;
}

#pragma mark - 表协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            _periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 20, 30)];
            [cell addSubview:_periodLabel];
        }
        _periodLabel.text = _dataDic[@"strHpTitle"];
        //单元格无法选中
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 260)];
            _image.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:_image];
        }
        [_image sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"strThumbnailUrl"]]];
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.row == 2)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            _authorLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth - 30, 20)];
            [cell addSubview:_authorLabel1];
            _authorLabel1.textAlignment = NSTextAlignmentRight;
            _authorLabel1.font = [UIFont systemFontOfSize:13];
            _authorLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, kScreenWidth - 30, 20)];
            [cell addSubview:_authorLabel2];
            _authorLabel2.textAlignment = NSTextAlignmentRight;
            _authorLabel2.font = [UIFont systemFontOfSize:13];
        }
        NSString *authorStr = _dataDic[@"strAuthor"];
        NSArray *authorArray = [authorStr componentsSeparatedByString:@"&"];
    
        _authorLabel1.text = authorArray[0];
        _authorLabel2.text = authorArray[1];
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else
    {
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell" forIndexPath:indexPath];
        cell.dataDic = _dataDic;
        _contentLabelWidth = cell.contentLabel.height;
        cell.userInteractionEnabled = NO;
        return cell;
    }
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }else if (indexPath.row == 1)
        return 260;
    else if (indexPath.row == 2)
        return 45;
    else
        return 100 + _contentLabelWidth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
