//
//  LoginedViewController.h
//  market
//
//  Created by Eric Yang on 2014/7/31.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "marketHttpRequest.h"
#import "MarketUser.h"
@interface LoginedViewController : UIViewController
@property (nonatomic,strong) marketHttpRequest *marketReq;
@property (nonatomic,strong) MarketUser *user;
@end
