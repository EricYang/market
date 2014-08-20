//
//  UserDataViewController.h
//  market
//
//  Created by Eric Yang on 2014/8/19.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginedViewController.h"
#import "marketHttpRequest.h"
@interface UserDataViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UINavigationController *navigationController;
@property (strong,nonatomic) marketHttpRequest *marketReq;
- (IBAction)addbtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
