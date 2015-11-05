//
//  UIView+viewController.m
//  新浪微博
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIView+viewController.h"

@implementation UIView (viewController)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

@end
