//
//  LoginedViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/31.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "LoginedViewController.h"

@interface LoginedViewController ()

@end

@implementation LoginedViewController
static void *user=&user;
static void *token=&token;
- (IBAction)chaeckBtnPressed:(id)sender {
    NSLog(@"the token:%@",[self.marketReq info][@"token"]);
    NSLog(@"the email:%@",[self.user email]);
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.marketReq=[marketHttpRequest getInstance];
    self.user=[MarketUser getInstance];
    [self.marketReq  addObserver:self forKeyPath:@"info.token" options:NSKeyValueObservingOptionNew context:token];
    [self.marketReq addObserver:self forKeyPath:@"info.profile.get.response.data" options:NSKeyValueObservingOptionNew context:user];
    
    // Do any additional setup after loading the view.
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context==user) {
        NSLog(@"user:%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
    if (context==token) {
         NSLog(@"!!!!outside token:%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
