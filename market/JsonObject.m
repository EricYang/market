//
//  JsonObject.m
//  market
//
//  Created by Eric Yang on 2014/7/28.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "JsonObject.h"

@implementation JsonObject

-(NSArray*)nsstringToArray:(NSString*)string
{
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return jsonArray;
}
-(NSDictionary*)nsstringToDictionary:(NSString*)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    return jsonDict;
}
-(NSArray*)nsdataToArray:(NSData*)data
{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
-(NSDictionary*)nsdataToDictionary:(NSData*)data
{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}
-(NSString*)arrayToNSString:(NSArray*)array
{
    return [NSString stringWithFormat:@"%@", array];
}
-(NSString*)dictionaryToNSString:(NSDictionary*)data
{
    return [NSString stringWithFormat:@"%@", data];
}
-(NSData*)dictionaryToNSData:(NSDictionary*)dict
{
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONReadingAllowFragments error:nil];
}
@end
