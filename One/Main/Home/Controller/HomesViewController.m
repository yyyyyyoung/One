//
//  HomesViewController.m
//  One
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "HomesViewController.h"
#import "Common.h"
#import "ContentView.h"
#import "HomeModel.h"
#import "ContentView.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

static

@interface HomesViewController ()
{
    NSMutableArray *_contentViewArray;  //视图数组
    NSMutableData *_receivedData;
    
    NSMutableArray *_modelArry;  //数据数组
    NSMutableArray *_urlArray;
    
    NSInteger _index;
    
    BOOL _isExist;

}
@end

@implementation HomesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createScroll];
    [self getUrl];
    [self createNaviBtn];
    
    
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

- (void)createScroll
{
    _index = 0;
    _isExist = NO;
    _contentViewArray = [[NSMutableArray alloc] initWithCapacity:10];
    _modelArry = [[NSMutableArray alloc] initWithCapacity:10];
    _urlArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    UIScrollView * scrllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49)];
    scrllView.contentSize = CGSizeMake(kScreenWidth * 10, kScreenHeight - 64 - 49);
    scrllView.delegate = self;
    scrllView.pagingEnabled = YES;
    scrllView.showsHorizontalScrollIndicator = NO;
    scrllView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < 10; i++) {
        ContentView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:self options:nil] lastObject];
        contentView.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight - 64 - 49);
        contentView.tag = i;
        
        contentView.hidden = YES;
        
        [_contentViewArray addObject:contentView];
        [scrllView addSubview:contentView];
    }
    [self.view addSubview:scrllView];
    
    NSDate *datenow = [[NSDate alloc] init];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date=[dateformatter stringFromDate:datenow];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/getHp_N?strDate=%@&strRow=1",date];

    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)getUrl
{
    NSDate *datenow = [[NSDate alloc] init];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date=[dateformatter stringFromDate:datenow];
    for (int i = 1; i <= 10; i++) {
        NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/getHp_N?strDate=%@&strRow=%d",date,i];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        [_urlArray addObject:url];
    }
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
    NSDictionary *data1 = [jsonDic objectForKey:@"hpEntity"];
    
    HomeModel *model = [[HomeModel alloc] initWithDataDic:data1];
    
//  防止相同的数据加入数组
    if (_modelArry.count != 0) {
        for (HomeModel *homemodel in _modelArry) {
            if ([model.strMarketTime isEqualToString:homemodel.strMarketTime]) {
                
                _isExist = YES;
                
            }
            else
                _isExist = NO;
            if (_isExist == YES) {
                break;
            }
        }
        if (!_isExist) {
            [_modelArry addObject:model];
        }
    }else
        [_modelArry addObject:model];
    
    
   
    
    ContentView *contentView = _contentViewArray[_index];
    if (contentView.model == nil ){
        if ( _modelArry.count > _index) {
            contentView.model = _modelArry[_index];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"滑的慢一点。。。T^T" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissWithClickedButtonIndex:0 animated:YES];
            });
        }
    }
    
    contentView.hidden = NO;


}

#pragma mark - 结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //计算偏移量
    NSInteger contentOffset = (NSInteger)(*targetContentOffset).x;
    //计算当前页数
    _index = contentOffset / kScreenWidth ;
    
    NSURL *url = _urlArray[_index];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    

}


@end
