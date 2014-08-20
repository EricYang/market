//
//  HttpRequest.h
//  market
//
//  Created by Eric Yang on 2014/7/28.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonObject.h"
@interface HttpRequest : NSObject
@property(nonatomic,strong) JsonObject *jsonObj;
typedef void (^ASCompletionBlock)(BOOL success, NSData *response, NSError *error);
-(void)connect:(NSString*)uri andMethod:(NSString*)method andBody:(NSData*)body andParams:(NSDictionary*)data withCallback:(ASCompletionBlock)callback;

@end
