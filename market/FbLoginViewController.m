//
//  FbLoginViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/20.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "FbLoginViewController.h"

@interface FbLoginViewController ()

@end

@implementation FbLoginViewController

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
    
    // Do any additional setup after loading the view.
    NSURL *url=[NSURL URLWithString:@"http://54.178.199.96:8000/auth/facebook"];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    //NSString *submitContent =@"{\"username\":\"ericyang\",\"password\":\"book37\"}";
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue=[NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *reponse,NSData *data,NSError *error){
        NSString *json =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@/%@",json,error);
        [self.webView loadHTMLString:json baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }];
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
