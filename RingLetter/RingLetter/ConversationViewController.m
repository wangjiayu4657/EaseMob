//
//  ConversationViewController.m
//  RingLetter
//
//  Created by fangjs on 16/4/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "ConversationViewController.h"
#import "EaseMob.h"

@interface ConversationViewController ()<EMChatManagerDelegate>

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"会话";
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

#pragma mark - chatManager 代理方法
//监听网络状态
//eEMConnectionConnected,   //连接成功
//eEMConnectionDisconnected,//未连接
-(void)didConnectionStateChanged:(EMConnectionState)connectionState {
    if (connectionState == eEMConnectionDisconnected) {
        self.title = @"未连接";
    }
    else {
        self.title = @"会话";
    }
}

//将自动连接
-(void)willAutoReconnect {
        self.title = @"连接中...";
}

//自动重连接
- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    if (!error) {
        self.title = @"会话";
    }
    else {
        self.title = @"网络已断开";
    }
}

- (void)didAcceptedByBuddy:(NSString *)username {
    [self showMessageUsername:username WithStatus:@"通过了你的请求"];
}

- (void)didRejectedByBuddy:(NSString *)username {
    [self showMessageUsername:username WithStatus:@"拒绝了你的请求"];    
}


- (void) showMessageUsername:(NSString *) username WithStatus:(NSString *) status {
    NSString *message = [NSString stringWithFormat:@"我是%@%@",username,status];
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"好友添加结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alter addAction:ok];
    [self presentViewController:alter animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

@end
