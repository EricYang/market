//
//  JsonObject.h
//  market
//
//  Created by Eric Yang on 2014/7/28.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonObject : NSObject
-(NSArray*)nsstringToArray:(NSString*)string;
-(NSDictionary*)nsstringToDictionary:(NSString*)string;
-(NSArray*)nsdataToArray:(NSData*)data;
-(NSDictionary*)nsdataToDictionary:(NSData*)data;
-(NSString*)arrayToNSString:(NSArray*)array;
-(NSString*)dictionaryToNSString:(NSDictionary*)data;
-(NSData*)dictionaryToNSData:(NSDictionary*)dict;
@end
