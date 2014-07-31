//
//  marketHttpRequest.h
//  market
//
//  Created by Eric Yang on 2014/7/30.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "HttpRequest.h"


@interface marketHttpRequest : HttpRequest
@property (nonatomic,strong) NSMutableDictionary *info;
typedef void (^ASCompletionBlockCallFunc)();
-(marketHttpRequest*)init;
-(void)setLoginParams:(NSMutableDictionary*)params;
-(void)setup:(NSString*)domain;
-(void)login:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
-(void)gProfile:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback;
+(marketHttpRequest*)getInstance;
/*
-(void)register;
-(void)putProfile*;
-(void)getDemand;
-(void)addDemand;
-(void)updateDemand;
-(void)deleteDemand;
-(void)getSupply;
-(void)addSupply;
-(void)updateSupply;
-(void)deleteSupply;
*/
@end
