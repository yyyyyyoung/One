//
//  ArticleViewController.m
//  One
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ArticleViewController.h"
#import "Common.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface ArticleViewController ()
{
    NSMutableData *_receivedData;

    UIScrollView *_scrollView;
    NSDictionary *_data1;   //存放数据
}
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self createNaviBtn];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createNaviBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 19, 5.5);
    [btn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)shareAction
{
    MMDrawerController *mmDra = [self mm_drawerController];
    [mmDra openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)loadData
{
    NSDate *datenow = [[NSDate alloc] init];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date=[dateformatter stringFromDate:datenow];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/getC_N?strDate=%@&strRow=1&strMS=1",date];
//    NSString *urlStr =@"http://rest.wufazhuce.com/OneForWeb/one/getC_N?strDate=2015-10-28&strRow=2&strMS=1";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - 请求协议
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没网哟" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}

//获取到响应头时会调用的协议方法
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
    _data1 = [jsonDic objectForKey:@"contentEntity"];
    
    [self createScrollView];
    
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 64, kScreenWidth - 10, kScreenHeight - 64 - 49)];
    _scrollView.pagingEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.hidden = YES;
    [self.view addSubview:_scrollView];
    
//    头视图（包括日期，标题，作者）
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, _scrollView.bounds.size.width - 10, 88)];
    //日期
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _scrollView.bounds.size.width - 20, 15)];
    dateLabel.textColor = [UIColor colorWithRed:194 / 255.0 green:195 / 255.0 blue:197 / 255.0 alpha:1];
    dateLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *date=_data1[@"strContMarketTime"];
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    
    NSDictionary *dateDic = @{@"01":@"January",
                              @"02":@"February",
                              @"03":@"March",
                              @"04":@"April",
                              @"05":@"May",
                              @"06":@"June",
                              @"07":@"July",
                              @"08":@"August",
                              @"09":@"September",
                              @"10":@"October",
                              @"11":@"November",
                              @"12":@"December"};
    
    NSString *dayyy = dateArray[1];
    dateLabel.text = [NSString stringWithFormat:@"%@ %@,%@",dateDic[dayyy],dateArray[2],dateArray[0]];
    [titleView addSubview:dateLabel];
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, _scrollView.bounds.size.width - 20, 20)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = _data1[@"strContTitle"];
    [titleView addSubview:titleLabel];
    //作者
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 68, _scrollView.bounds.size.width - 20, 15)];
    authorLabel.font = [UIFont systemFontOfSize:14];
    authorLabel.text = _data1[@"strContAuthor"];
    authorLabel.textColor = [UIColor colorWithRed:194 / 255.0 green:195 / 255.0 blue:197 / 255.0 alpha:1];
    [titleView addSubview:authorLabel];
    
    [_scrollView addSubview:titleView];
    
//    webView（内容）
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 205, _scrollView.bounds.size.width - 10, 60)];
    webView.delegate = self;
    [webView loadHTMLString:_data1[@"strContent"] baseURL:nil];
    webView.scrollView.scrollEnabled = NO;
    [_scrollView addSubview:webView];

    UILabel *responsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 20, 10)];
    responsLabel.font = [UIFont systemFontOfSize:16];
    responsLabel.text = _data1[@"strContAuthorIntroduce"];
    responsLabel.tag = 10;
    [_scrollView addSubview:responsLabel];
    
//    尾视图（包括作者，作者信息）
    UIView *footView = [[UIView alloc] initWithFrame:_scrollView.bounds];
    footView.tag = 20;
    [_scrollView addSubview:footView];
    //作者
    UILabel *authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, _scrollView.bounds.size.width - 20, 20)];
    authorNameLabel.font = [UIFont systemFontOfSize:20];
    authorNameLabel.textColor = [UIColor blackColor];
    authorNameLabel.text = _data1[@"strContAuthor"];
    [footView addSubview:authorNameLabel];
    //作者信息
    UILabel *authorInterLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 45, _scrollView.bounds.size.width - 50, 50)];
    authorInterLabel.font = [UIFont systemFontOfSize:15];
    authorInterLabel.textColor = [UIColor blackColor];
    authorInterLabel.text = _data1[@"sAuth"];
    authorInterLabel.numberOfLines = 0;
    [footView addSubview:authorInterLabel];
    
//    线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-4, -17, kScreenWidth, 1)];
    lineView.bounds = CGRectMake(4, -10, kScreenWidth-8, 1);
    lineView.backgroundColor = [UIColor grayColor];
    lineView.tag = 30;
    [_scrollView addSubview:lineView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth - 10, height + 350);
    webView.frame = CGRectMake(5, 90, kScreenWidth - 20, height + 20);
    UILabel *responsLabel = (UILabel *)[self.view viewWithTag:10];
    responsLabel.frame = CGRectMake(15, height + 105, _scrollView.bounds.size.width - 40, 15);
    UIView *footView = (UIView *)[self.view viewWithTag:20];
    footView.frame = CGRectMake(5, height + 205, _scrollView.bounds.size.width - 10, 60);
    
    UIView *lineView = (UIView *)[self.view viewWithTag:30];
    lineView.frame = CGRectMake(4, height + 205, kScreenWidth - 10, 1);
    
    _scrollView.hidden = NO;
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
