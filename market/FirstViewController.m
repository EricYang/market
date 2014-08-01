//
//  FirstViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/19.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) JsonObject *jsonObj;
@property (strong,nonatomic) marketHttpRequest *marketReq;
@end

@implementation FirstViewController


- (IBAction)fbLoginHandler:(id)sender {
    
}

- (IBAction)loginHandler:(id)sender {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"username"]=self.username.text;
    params[@"password"]=self.password.text;
    [self.marketReq login:params withCallback:^(){
        [self.marketReq readProfile:nil withCallback:^(){
           // NSLog(@"outside token:%@",[self.marketReq info][@"login"][@"response"][@"data"][@"token"]);
        }];
    }];
    
    }
- (IBAction)registerhandler:(id)sender {
    
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.jsonObj=[[JsonObject alloc] init];
    self.marketReq=[marketHttpRequest getInstance];
    [self.marketReq setup:@"http://54.178.199.96:8000"];
   
}
    // Do any additional setup after loading the view, typically from a nib.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
