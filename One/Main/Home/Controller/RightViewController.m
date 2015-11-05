//
//  RightViewController.m
//  One
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "RightViewController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "UIView+viewController.h"
#import "SeekViewController.h"
#import "BaseNaviController.h"
#import "SeekArticleViewController.h"

@interface RightViewController ()
{
    UITextField *_dateTextField;
    UITableView *_tableView;
    NSArray *_sectionTitles;
    NSArray *_rowTitles;
    
    UIDatePicker *_datePicker;
    NSString *_dateSel;
    NSString *_timeSp;  //时间戳
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ceateTable];
    [self loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)ceateTable
{
    // 创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(-5, 0, 165, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = nil;
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置内填充
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:_tableView];
}

// 1.初始化数据
- (void)loadData
{
    _sectionTitles = @[@"跳转至日期",@"分享"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [_rowTitles[section] count];
    if (section == 0) {
        return 2;
    }else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"rightCellId";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                NSDate *datenow = [[NSDate alloc] init];
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"YYYY-MM-dd"];
                NSString *date=[dateformatter stringFromDate:datenow];
                cell.textLabel.text = [NSString stringWithFormat:@"例如:%@",date];
                cell.textLabel.tag = 100;
                cell.textLabel.textColor = [UIColor colorWithRed:194 / 255.0 green:195 / 255.0 blue:197 / 255.0 alpha:0.8];
            }
            return cell;
        }else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                enterBtn.frame = CGRectMake(40, 10, 80, 30);
                [enterBtn setTitle:@"GOGO" forState:UIControlStateNormal];
                [enterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [enterBtn addTarget:self action:@selector(enterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:enterBtn];
            }
            return cell;
        }
        
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            shareBtn.frame = CGRectMake(40, 5, 30, 30);
            [shareBtn setImage:[UIImage imageNamed:@"share_sina@2x"] forState:UIControlStateNormal];
            shareBtn.tintColor = [UIColor blackColor];

            [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:shareBtn];
        }
        return cell;
    }
    
}

- (void)shareBtnAction:(UIButton *)btn
{
    NSLog(@"新浪微博分享");
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    sectionLabel.backgroundColor = [UIColor clearColor];
    sectionLabel.font = [UIFont boldSystemFontOfSize:18];
    sectionLabel.text = [NSString stringWithFormat:@"   %@", _sectionTitles[section]];
    return sectionLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self datePicker];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kScreenHeight - 216 - 49, kScreenWidth, 216)];
        //设置地区，语言
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        //默认为当天
        [_datePicker setCalendar:[NSCalendar currentCalendar]];
        
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

        _datePicker.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
       
        AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myDelegate.window addSubview:_datePicker];
    }else
        _datePicker.hidden = !_datePicker.hidden;
}

-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate *date = control.date;
//    给跳转段落用的时间
    NSDateFormatter *dateformatter =[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    _dateSel = [dateformatter stringFromDate:date];
    
    UILabel *cellLabel = (UILabel *)[self.view viewWithTag:100];
    cellLabel.text = [NSString stringWithFormat:@"%@",_dateSel];
    cellLabel.textColor = [UIColor blackColor];
    
//    给跳转文章用的时间戳
    _timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enterBtnAction:(UIButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"选定日期不能大于今天哟" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", @"文章(只可看十天)", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    if (_dateSel != nil) {
        if (buttonIndex == 1)
        {
            SeekViewController *seekVC = [[SeekViewController alloc] init];
            BaseNaviController *navC = [[BaseNaviController alloc] initWithRootViewController:seekVC];
            seekVC.dateSel = _dateSel;
            
            _datePicker.hidden = YES;
            [self presentViewController:navC animated:YES completion:nil];
        }
        if (buttonIndex == 2) {
            SeekArticleViewController *seekAKV = [[SeekArticleViewController alloc] init];
            BaseNaviController *navC = [[BaseNaviController alloc] initWithRootViewController:seekAKV];
            
            seekAKV.timeSp = _timeSp;
            
            _datePicker.hidden = YES;
            [self presentViewController:navC animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择日期" message:@"再不选择就自动用当前日期了哟" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            NSDate *datenow = [[NSDate alloc] init];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            _dateSel = [dateformatter stringFromDate:datenow];
        });
        
    }
    return;
}

- (void)viewRemove
{
    UIView *view = (UIView *)[self.view viewWithTag:198];
    [view removeFromSuperview];
}

#pragma mark - 消失键盘（取消第一响应者）
- (void)viewDidDisappear:(BOOL)animated
{
    [_dateTextField resignFirstResponder];
    _datePicker.hidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_dateTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_dateTextField resignFirstResponder];
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
