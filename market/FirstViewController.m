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
@property (nonatomic, retain) LoginedViewController *nViewController;

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
        LoginedViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginedViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
        /*
        [self performSegueWithIdentifier:@"loginedStoryboard" sender:self];
        
        if (newViewController == nil)
        {
            LoginedViewController *newViewController =
            [[LoginedViewController alloc]
             initWithNibName:@"LoginedViewController"
             bundle:[NSBundle mainBundle]];
            
            self.nViewController = newViewController;
        }
        
        // How you reference your navigation controller will
        // probably be a little different
        [self.navigationController
         pushViewController:self.nViewController
         animated:YES];*/
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
