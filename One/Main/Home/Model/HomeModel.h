//
//  HomeModel.h
//  One
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel
/*
 [0]	(null)	@"strContent" : @"星星发亮是为了让每一个人有一天都能找到属于自己的星星。 from 《小王子》"
 [1]	(null)	@"strThumbnailUrl" : @"http://pic.yupoo.com/hanapp/F2T98bny/gA5ra.jpg"
 [2]	(null)	@"strLastUpdateDate" : @"2015-10-22 16:44:44"
 [3]	(null)	@"strOriginalImgUrl" : @"http://pic.yupoo.com/hanapp/F2T98bny/gA5ra.jpg"
 [4]	(null)	@"strHpId" : @"1136"
 [5]	(null)	@"strDayDiffer" : @""
 [6]	(null)	@"strHpTitle" : @"VOL.1117"
 [7]	(null)	@"strAuthor" : @"Holy Light&田楚炀 作品"
 [8]	(null)	@"sWebLk" : @"http://m.wufazhuce.com/one/2015-10-29"
 [9]	(null)	@"strPn" : @"18853"
 [10]	(null)	@"wImgUrl" : @"http://211.152.49.184:9000/upload/onephoto/f1445503484043.jpg"
 [11]	(null)	@"strMarketTime" : @"2015-10-29"
 */

@property (nonatomic, copy) NSString *strContent;   //内容
@property (nonatomic, copy) NSString *strThumbnailUrl;  //图片
@property (nonatomic, copy) NSString *strMarketTime;    //发布时间
@property (nonatomic, copy) NSString *strHpTitle;   //期刊
@property (nonatomic, copy) NSString *strAuthor;    //作者
@property (nonatomic, copy) NSString *strPn;    //点赞

@property (nonatomic, copy) NSString *strLastUpdateDate;
@property (nonatomic, copy) NSString *strOriginalImgUrl;
@property (nonatomic, copy) NSString *strDayDiffer;
@property (nonatomic, copy) NSString *sWebLk;
@property (nonatomic, copy) NSString *wImgUrl;
@property (nonatomic, copy) NSString *strHpId;
@end
