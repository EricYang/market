//
//  MarketUser.m
//  market
//
//  Created by Eric Yang on 2014/8/1.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "MarketUser.h"

@implementation MarketUser
@synthesize email=_email;

static MarketUser *instance = nil;
+(MarketUser *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [MarketUser new];
            
        }
    }
    return instance;
}


@end
