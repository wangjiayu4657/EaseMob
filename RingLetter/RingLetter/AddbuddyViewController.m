//
//  AddbuddyViewController.m
//  RingLetter
//
//  Created by fangjs on 16/4/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "AddbuddyViewController.h"

@interface AddbuddyViewController ()<UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AddbuddyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//搜索好友
- (IBAction)searchAction:(id)sender {
    
    NSString *loginUsername = self.textField.text;
    NSString *message = [@"我是" stringByAppendingString:[[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    EMError *error = nil;
    [[EaseMob sharedInstance].chatManager addBuddy: loginUsername message:message error:&error];
    if (!error) {
        NSLog(@"添加好友成功...");
    }
    else {
        NSLog(@"添加好友失败 %@",error);
    }
    
}


@end
