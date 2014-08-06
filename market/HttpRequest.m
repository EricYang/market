//
//  HttpRequest.m
//  market
//
//  Created by Eric Yang on 2014/7/28.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
-(HttpRequest*)init
{
    if(self==[super init]){
        self.jsonObj=[[JsonObject alloc] init];
    }
    return self;
}
-(void)connect:(NSString*)uri andMethod:(NSString*)method andBody:(NSData*)body andParams:(NSDictionary*)data withCallback:(ASCompletionBlock)callback
{
    if (data) {
        NSString *sym=@"?";
        for (NSString* key in data) {
            NSString *value = [data objectForKey:key];
            uri=[uri stringByAppendingString:[NSString stringWithFormat:@"%@%@=%@",sym,key,value]];
            sym=@"&";
            // do stuff
        }
    }
    NSURL *url=[NSURL URLWithString:uri];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    if (body) {
        [request setHTTPBody:body];
        NSLog(@"body:%@",body);
    }
    NSLog(@"url:%@",uri);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSOperationQueue *queue=[NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *reponse,NSData *data,NSError *error){
        BOOL success = NO;
        
        if (!error)
        {
            success = YES;
            callback(success,data,nil);
        }else{
            callback(success,nil,error);
        }
        
        
        
    }];

}
@end
