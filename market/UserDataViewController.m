//
//  UserDataViewController.m
//  market
//
//  Created by Eric Yang on 2014/8/19.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "UserDataViewController.h"

@interface UserDataViewController ()

@property (strong)NSArray *roleArray;
@end

@implementation UserDataViewController

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
    self.roleArray = [[NSArray alloc] initWithObjects:@{@"title":@"test"},nil];
    [self setTitle:@"LEGO Heroica"];
    self.marketReq=[marketHttpRequest getInstance];
    [self.marketReq readSupplies:nil withCallback:^(int isSuccess2){
        if(isSuccess2){
            NSLog(@"read go next page");
            self.roleArray=self.marketReq.info[@"supplies"][@"get"][@"response"][@"data"];
            [self.tableView reloadData];
        }else{
            NSLog(@"wrong");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.roleArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //製作可重複利用的表格欄位Cell
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //設定欄位的內容與類
    cell.textLabel.text = [self.roleArray objectAtIndex:indexPath.row][@"title"];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
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
-(void)nextpage{
    dispatch_queue_attr_t queue=dispatch_get_main_queue();
    dispatch_async(queue, ^{
        LoginedViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginedStoryboard"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    });
    
}
- (IBAction)addbtnPressed:(id)sender {
    NSLog(@"add btn pressed");
    //[self nextpage];
}
@end
