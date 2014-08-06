//
//  FirstViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/19.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "FirstViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface FirstViewController () <FBLoginViewDelegate>
{
    LoginedViewController *newViewController;
}
@property (nonatomic, retain) LoginedViewController *viewController;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) JsonObject *jsonObj;
@property (strong,nonatomic) marketHttpRequest *marketReq;

@property (weak, nonatomic) IBOutlet UITextField *reg_username;
@property (weak, nonatomic) IBOutlet UITextField *reg_email;
@property (weak, nonatomic) IBOutlet UITextField *reg_password;
@property (weak, nonatomic) IBOutlet UITextField *reg_passwordConfirmation;

@end

@implementation FirstViewController
{
    NSString *fbAccessToken;
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

- (IBAction)registerBtnPressed:(UIButton *)sender {
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"username"]=self.reg_username.text;
    params[@"email"]=self.reg_email.text;
    params[@"passwordConfirmation"]=self.reg_passwordConfirmation.text;
    params[@"password"]=self.reg_password.text;
    [self.marketReq register:params withCallback:^(int isSuccess){
        if(isSuccess){
            NSLog(@"go next page");
            [self nextpage];
        }else{
            NSLog(@"wrong");
        }
    }];
}
- (IBAction)registerhandler:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _registerView.frame=self.view.frame;
    }];
}
-(void)fbhandler
{
    self.fbloginView.readPermissions=@[@"public_profile",@"email",@"user_friends" ];
}
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    fbAccessToken = [FBSession activeSession].accessTokenData.accessToken;
    NSLog(@"user:%@,token:%@",user,fbAccessToken);
    [self.marketReq fblogin:fbAccessToken withCallback:^(int isSuccess){
        if(isSuccess){
            NSLog(@"fb login");
            //[self nextpage];
        }else{
            NSLog(@"wrong");
        }
    }];
}
-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    fbAccessToken = @"";
}
-(void)fbDialogLogin:(NSString *)token expirationDate:(NSDate *)expirationDate
{
    NSLog(@"token:%@",token);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.jsonObj=[[JsonObject alloc] init];
    self.marketReq=[marketHttpRequest getInstance];
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    self.marketReq.info[@"uuid"]=(NSString *)CFBridgingRelease(CFUUIDCreateString(NULL,uuidRef));
    NSLog(@"id%@",self.marketReq.info[@"uuid"]);
    [self.marketReq setup:@"http://54.178.199.96:8000"];
    [self fbhandler];
   
}
    // Do any additional setup after loading the view, typically from a nib.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
