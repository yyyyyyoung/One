//
//  SeekViewController.m
//  One
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "SeekViewController.h"
#import "HomeTableView.h"
#import "Common.h"
#import "RightViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface SeekViewController ()
{
    NSMutableData *_receivedData;
    HomeTableView *_tableView;
}
@end

@implementation SeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTable];
    [self createNavBtn];
    [self addNaviImage];
    [self loadData];
}

- (void)addNaviImage
{
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 56) / 2, (44 - 17) / 2 , 56, 17)];
    logoImage.image = [UIImage imageNamed:@"navLogo@2x"];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationController.navigationBar addSubview:logoImage];
}

- (void)createNavBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftbtn;
}

- (void)fanhui
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTable
{
    _tableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) style:UITableViewStylePlain];
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
}

- (void)loadData
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/getHp_N?strDate=%@&strRow=1",_dateSel];
//    NSString *urlStr =@"http://rest.wufazhuce.com/OneForWeb/one/getHp_N?strDate=2015-09-10&strRow=1";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - 请求协议
//获取到响应头时会调用的协议方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"检查一下网络哟" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"网络请求发送成功");
    //定义NSData用来接收数据包
    _receivedData = [[NSMutableData alloc] init];
}

//接收数据时会调用的协议方法，此方法可能被调用多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //将每次接收到的数据包附加在_receivedData后
    [_receivedData appendData:data];
}

//接收数据完毕时会被调用的协议方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //将接收到的所有数据转化为NSString
    
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *data1 = [jsonDic objectForKey:@"hpEntity"];
    
    if (data1 == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有更多了哟" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        _tableView.dataDic = data1;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _tableView.hidden = NO;
            [_tableView reloadData];
        });
    }
    
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
