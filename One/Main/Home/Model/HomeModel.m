
//
//  HomeModel.m
//  One
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (NSDictionary *)attributeMapDictionary
{
    NSDictionary *attrMap = @{@"strContent":@"strContent",
                              @"strThumbnailUrl":@"strThumbnailUrl",
                              @"strMarketTime":@"strMarketTime",
                              @"strHpTitle":@"strHpTitle",
                              @"strAuthor":@"strAuthor",
                              @"strPn":@"strPn",
                              @"strLastUpdateDate":@"strLastUpdateDate",
                              @"strOriginalImgUrl":@"strOriginalImgUrl",
                              @"strDayDiffer":@"strDayDiffer",
                              @"sWebLk":@"sWebLk",
                              @"wImgUrl":@"wImgUrl",
                              @"strHpId":@"strHpId"};
    return attrMap;
}

@end
