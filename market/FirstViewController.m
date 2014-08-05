//
//  FirstViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/19.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    LoginedViewController *newViewController;
}
@property (nonatomic, retain) LoginedViewController *viewController;

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
    [self.marketReq login:params withCallback:^(int isSuccess){
        if(isSuccess){
            
        NSLog(@"go next page");
            [self nextpage];
        }else{
            NSLog(@"wrong");
        }
    }];

    }
-(void)nextpage
{
    dispatch_queue_attr_t queue=dispatch_get_main_queue();
    dispatch_async(queue, ^{
        LoginedViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginedStoryboard"] ;
        [[self navigationController] pushViewController:viewController animated:YES];

    });

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
