//
//  marketHttpRequest.h
//  market
//
//  Created by Eric Yang on 2014/7/30.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "HttpRequest.h"
#import "MarketUser.h"

@interface marketHttpRequest : HttpRequest
@property (retain) NSMutableDictionary*info;
@property (retain) MarketUser *user;
typedef void (^ASCompletionBlockCallFunc)();
+(marketHttpRequest*)getInstance;
-(void)setLoginParams:(NSMutableDictionary*)params;
-(void)setup:(NSString*)domain;
-(void)fblogin:(NSString*)accesstoken withCallback:(ASCompletionBlockCallFunc)callback;
-(void)register:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)login:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)readProfile:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)readDemands:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)readSupplies:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)updateProfile:(NSDictionary*)params  withCallback:(ASCompletionBlockCallFunc)callback;
-(void)updateDemands:(NSDictionary*)params  updateID:(NSString*)uid  withCallback:(ASCompletionBlockCallFunc)callback;
-(void)updateSupplies:(NSDictionary*)params  updateID:(NSString*)uid  withCallback:(ASCompletionBlockCallFunc)callback;
-(void)deteleDemands:(NSDictionary*)params deteleID:(NSString*)uid withCallback:(ASCompletionBlockCallFunc)callback;
-(void)deteleSupplies:(NSDictionary*)params deteleID:(NSString*)uid withCallback:(ASCompletionBlockCallFunc)callback;

-(void)addDemands:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)addSupplies:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;

@end
