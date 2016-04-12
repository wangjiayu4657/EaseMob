//
//  LoginViewController.m
//  RingLetter
//
//  Created by fangjs on 16/4/8.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)registerAction:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:username password:password withCompletion:^(NSString *username, NSString *password, EMError *error) {
        NSLog(@"%@",[NSThread currentThread]);
        
        if (!error) {
             NSLog(@"注册成功");
        }
        else {
             NSLog(@"注册失败 %@",error);
        }
        
    } onQueue:dispatch_get_main_queue()];
}

- (IBAction)LoginAction:(id)sender {
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if (username.length == 0 || password.length == 0) {
        NSLog(@"请输入账号");
        return;
    }
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username password:password completion:^(NSDictionary *loginInfo, EMError *error) {
      
        if (!error) {
            NSLog(@"登陆成功 %@",loginInfo);

            //设置自动登录
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            
            //登录成功来到主界面
            self.view.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
        }else {
            NSLog(@"登录失败 %@",error);
        }
        
       
    } onQueue:dispatch_get_main_queue()];
}

@end
