//
//  MarketUser.h
//  market
//
//  Created by Eric Yang on 2014/8/1.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarketUser : NSObject
+(MarketUser*)getInstance;
@property (nonatomic,strong) NSMutableString *username;
@property (retain) NSMutableString *email;
-(void)setEmail:(NSMutableString *)email;
@end
