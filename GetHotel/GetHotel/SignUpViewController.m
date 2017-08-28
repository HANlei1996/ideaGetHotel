//
//  SignUpViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTelTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    //[self uiLayout];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)naviConfig{
    
    //设置导航条的颜色（风格颜色）
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:100/255.0 blue:255.0 alpha:1.0]];
    self.navigationController.navigationBar.barTintColor=UIColorFromRGB(20, 100, 255);
    //设置导航条的标题颜色
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName : [UIColor whiteColor] };
    //设置导航条是否隐藏
    self.navigationController.navigationBar.hidden=NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent=YES;
    //为导航条左上角创建一个按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
}
//用Model的方式返回上一页
- (void)backAction {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)uiLayout{
    //判断是否存在用户名记忆体
    if (![[Utilities getUserDefaults:@"tel"] isKindOfClass:[NSNull class]]) {
        if ([Utilities getUserDefaults:@"tel"] != nil) {
            //将他显示在用户名输入框
            _userTelTextField.text=[Utilities getUserDefaults:@"tel"];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self request];
    if (_userTelTextField.text.length== 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入你的手机号" andTitle:nil onView:self];
        return;
    }
    //判断某个字符串中是否每个字符都是数字
    NSCharacterSet *notDigits=[[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    if ([_userTelTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound || _userTelTextField.text.length != 11) {
        [Utilities popUpAlertViewWithMsg:@"请输入有效的手机号码" andTitle:nil onView:self];
        return;
    }
    if (_passWordTextField.text.length==0) {
        [Utilities popUpAlertViewWithMsg:@"请输入密码" andTitle:nil onView:self];
        return;
    }
    if (_passWordTextField.text.length < 6 || _passWordTextField.text.length > 18) {
        [Utilities popUpAlertViewWithMsg:@"你输入的密码必须在6~18之间" andTitle:nil onView:self];
        return;
    }
    if ([_passWordTextField.text isEqualToString:_confirmTextField.text]) {
        
    }else{
        [Utilities popUpAlertViewWithMsg:@"密码输入不一致，请重新输入" andTitle:@"提示" onView:self];
        // _passWordTextField.text = @"";
        _confirmTextField.text = @"";
    }
    
}
- (void)request{
    //点击按钮的时候创建一个蒙层，并显示在当前页面
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //参数
    NSDictionary *para = @{@"tel":_userTelTextField.text,@"pwd":_passWordTextField.text};
    NSLog(@"参数:%@",para);
    //网络请求
    [RequestAPI requestURL:@"/register" withParameters:para andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        //当网络请求成功时让蒙层消失
        [avi stopAnimating];
        
        if ([responseObject[@"flag"] isEqualToString:@"success"]) {
            NSDictionary *result = responseObject[@"result"];
            NSString *token = result[@"token"];
            NSLog(@"token: %@", token);
            //把token存入单例化全局变量中
            [[StorageMgr singletonStorageMgr] removeObjectForKey:@"token"];
            [[StorageMgr singletonStorageMgr] addKey:@"token" andValue:token];
            
            //客户的电话号码是否要加密处理，根据接口返回的hidePhone判断。把hidePhone处理后存入单例化全局变量中，在其他有客户信息显示的页面上判断
            NSDictionary *agent = result[@"agent"];
            BOOL showPhone = [agent[@"hidePhone"] boolValue];
            
            [[StorageMgr singletonStorageMgr] removeObjectForKey:@"showPhone"];
            [[StorageMgr singletonStorageMgr] addKey:@"showPhone" andValue:@(showPhone)];
            
            //保存用户名
            [Utilities removeUserDefaults:@"tel"];
            [Utilities setUserDefaults:@"pwd" content:_userTelTextField.text];
            
            _passWordTextField.text = @"";
            
            [self performSegueWithIdentifier:@"loginToTask" sender:self];
        }else{
            [Utilities popUpAlertViewWithMsg:responseObject[@"message"] andTitle:@"提示" onView:self];
            
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [avi stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"网络错误,请稍等再试" andTitle:@"提示" onView:self];
        
    }];
}
//键盘收回
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //让根视图结束编辑状态达到收起键盘的目的
    [self.view endEditing:YES];
}
//按return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _userTelTextField || textField == _passWordTextField || textField == _confirmTextField ) {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
