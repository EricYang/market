//
//  marketHttpRequest.m
//  market
//
//  Created by Eric Yang on 2014/7/30.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "marketHttpRequest.h"

@implementation marketHttpRequest
@synthesize info;
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
-(NSMutableDictionary *)Info{
    return self.info;
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
-(void)register:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    
    self.info[@"register"][@"params"]=params;
    [self connect:self.info[@"register"][@"uri"] andMethod:self.info[@"register"][@"method"] andBody:[ self.jsonObj dictionaryToNSData:self.info[@"register"][@"params"]] andParams:nil withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             //NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"register"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             self.info[@"token"]=self.info[@"register"][@"response"][@"data"][@"token"];
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
-(void)readDemands:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:self.info[@"demands"][@"get"][@"uri"] andMethod:self.info[@"demands"][@"get"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"demands"][@"get"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)readProfile:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:self.info[@"profile"][@"get"][@"uri"] andMethod:self.info[@"profile"][@"get"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"profile"][@"get"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)readSupplies:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:self.info[@"supplies"][@"get"][@"uri"] andMethod:self.info[@"supplies"][@"get"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"supplies"][@"get"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)updateProfile:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:self.info[@"profile"][@"update"][@"uri"] andMethod:self.info[@"profile"][@"update"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"profile"][@"update"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)updateSupplies:(NSDictionary*)params updateID:(NSString*)uid withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:[NSString stringWithFormat:@"%@/%@",self.info[@"supplies"][@"update"][@"uri"],uid] andMethod:self.info[@"supplies"][@"update"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"supplies"][@"update"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)updateDemands:(NSDictionary*)params updateID:(NSString*)uid withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:[NSString stringWithFormat:@"%@/%@",self.info[@"demands"][@"update"][@"uri"],uid] andMethod:self.info[@"demands"][@"update"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"demands"][@"update"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)addSupplies:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:self.info[@"supplies"][@"add"][@"uri"] andMethod:self.info[@"supplies"][@"add"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"supplies"][@"add"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)addDemands:(NSDictionary*)params withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:self.info[@"demands"][@"add"][@"uri"] andMethod:self.info[@"demands"][@"add"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"demands"][@"add"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)deteleDemands:(NSDictionary *)params deteleID:(NSString *)uid withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:[NSString stringWithFormat:@"%@/%@",self.info[@"demands"][@"delete"][@"uri"],uid] andMethod:self.info[@"demands"][@"delete"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"demands"][@"delete"][@"response"]=[self.jsonObj nsdataToDictionary:response];
             callback();
         }
         else
         {
             // Display you error NSError object
             NSLog(@"error:%@",error);
         }
     }];
    
}
-(void)deteleSupplies:(NSDictionary *)params deteleID:(NSString *)uid withCallback:(ASCompletionBlockCallFunc)callback
{
    NSMutableDictionary *_params=[[NSMutableDictionary alloc]initWithDictionary:@{@"token":self.info[@"token"]}];
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    [self connect:[NSString stringWithFormat:@"%@/%@",self.info[@"supplies"][@"delete"][@"uri"],uid] andMethod:self.info[@"supplies"][@"delete"][@"method"] andBody:nil andParams:_params withCallback:^(BOOL success, NSData *response, NSError *error)
     {
         if (success)
         {
             // Use your response NSDictionary object
             NSLog(@"success:%@",[self.jsonObj nsdataToDictionary:response]);
             self.info[@"supplies"][@"delete"][@"response"]=[self.jsonObj nsdataToDictionary:response];
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
