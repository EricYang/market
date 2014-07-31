//
//  marketHttpRequest.m
//  market
//
//  Created by Eric Yang on 2014/7/30.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "marketHttpRequest.h"

@implementation marketHttpRequest

static marketHttpRequest *instance = nil;

+(marketHttpRequest *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [marketHttpRequest new];
            instance.info=[[NSMutableDictionary alloc] init];
        }
    }
    return instance;
}

-(void)setup:(NSString *)domain
{
    self.info[@"domain"]=domain;
    self.info[@"login"] = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                             @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/login"],@"method":@"POST"
                                                                             }],
        self.info[@"register"]  = [[NSMutableDictionary alloc] initWithDictionary:@{
                                 @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/register"],@"method":@"POST"
                                 }];
        self.info[@"profile"]  =[[NSMutableDictionary alloc] initWithDictionary:@{
                                @"get":[[NSMutableDictionary alloc] initWithDictionary:@{
                                 @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/profile"],@"method":@"GET"
  
                                 }],
                                @"update":[[NSMutableDictionary alloc] initWithDictionary:@{
                                        @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/profile"],@"method":@"POST"
                                        
                                        }]
                                }],
        self.info[@"demands"]  =[[NSMutableDictionary alloc] initWithDictionary:@{
                                  @"get":@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/demands"],@"method":@"GET"
                                          
                                          },
                                  @"add":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/demands"],@"method":@"POST"
                                          
                                          } ],
                                  @"update":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/demands"],@"method":@"PUT"
                                          
                                          } ],
                                  @"delete":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/demands"],@"method":@"DELETE"
                                          
                                          }]
                                  }],
        self.info[@"supplies"]  =[[NSMutableDictionary alloc] initWithDictionary:@{
                                  @"get":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/supplies"],@"method":@"GET"
                                          
                                          }],
                                  @"add":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/supplies"],@"method":@"POST"
                                          
                                          }],
                                  @"update":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/supplies"],@"method":@"PUT"
                                          
                                          }],
                                  @"delete":[[NSMutableDictionary alloc] initWithDictionary:@{
                                          @"uri": [NSString stringWithFormat:@"%@%@",self.info[@"domain"],@"/ajax/supplies"],@"method":@"DELETE"
                                          
                                          }]
                                  }];
    
    
    
}
-(void)setLoginParams:(NSMutableDictionary*)params
{
    
    NSLog(@"%@",[self.jsonObj dictionaryToNSString:self.info[@"login"]]);
}
-(void)setProfileParams:(NSMutableDictionary*)params
{
    
    self.info[@"profile"][@"get"][@"params"]=params;
}

-(void)login:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{

    self.info[@"login"][@"params"]=params;
    [self connect:self.info[@"login"][@"uri"] andMethod:self.info[@"login"][@"method"] andBody:[ self.jsonObj dictionaryToNSData:self.info[@"login"][@"params"]] andParams:nil withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             //NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"login"][@"response"]=[self.jsonObj nsdataToDictionary:response];
              self.info[@"token"]=self.info[@"login"][@"response"][@"data"][@"token"];
             NSLog(@"token:%@",[self.jsonObj dictionaryToNSString:self.info[@"token"]]);
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];

}
-(void)gProfile:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSDictionary *_params=@{@"token":self.info[@"token"]};
    if(params){
        _params=params;
    }
    [self connect:self.info[@"profile"][@"get"][@"uri"] andMethod:self.info[@"profile"][@"get"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"login"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}

@end
