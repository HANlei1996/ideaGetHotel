//
//  SignInViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordnameTextField;
- (IBAction)signBtnAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
//@property (strong,nonatomic) UIActivityIndicatorView *avi;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    
    // Do any additional setup after loading the view.
    _signBtn.enabled = NO;
    _signBtn.backgroundColor = UIColorFromRGB(200, 200, 200);
    
    
    if (![[Utilities getUserDefaults:@"tel"] isKindOfClass:[NSNull class]] && [Utilities getUserDefaults:@"tel"] != nil) {
        _usernameTextField.text = [Utilities getUserDefaults:@"tel"];
    }
    
    //添加事件监听当输入框的内容改变时调用textChange:方法
    [_usernameTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwordnameTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)naviConfig{
    
    //设置导航条的颜色（风格颜色）
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:100/255.0 blue:255/255.0 alpha:1.0]];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textChange: (UITextField *)textField{
    //当文本框中的内容改变时判断内容长度是否为0，是：禁用按钮   否：启用按钮
    if (_usernameTextField.text.length != 0 && textField.text.length != 0) {
        _signBtn.enabled = YES;
        _signBtn.backgroundColor = UIColorFromRGB(99, 163, 210);
    }else{
        _signBtn.enabled = NO;
        _signBtn.backgroundColor = UIColorFromRGB(200, 200, 200);
    }
}


#pragma mark - request

#pragma mark - Btn


- (IBAction)signBtnAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    if (_usernameTextField.text.length==0) {
        [Utilities popUpAlertViewWithMsg:@"请输入你的手机号" andTitle:nil onView:self];
        return;
    }
    //判断某个字符串中是否每个字符都是数字
    NSCharacterSet *notDigits=[[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    if ([_usernameTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound || _usernameTextField.text.length != 11) {
        [Utilities popUpAlertViewWithMsg:@"请输入有效的手机号码" andTitle:nil onView:self];
        return;
    }
    
    if (_passwordnameTextField.text.length==0) {
        [Utilities popUpAlertViewWithMsg:@"请输入密码" andTitle:nil onView:self];
        return;
    }
    if (_passwordnameTextField.text.length < 6 || _passwordnameTextField.text.length > 18) {
        [Utilities popUpAlertViewWithMsg:@"你输入的密码必须在6~18之间" andTitle:nil onView:self];
        return;
    }
    //无输入异常的情况，开始正式执行登录接口
    //[self readyForEncoding];
     [self request];
}
#pragma mark - request
- (void)request{
    //点击按钮的时候创建一个蒙层，并显示在当前页面
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //参数
    NSDictionary *para = @{@"tel":_usernameTextField.text,@"pwd":_passwordnameTextField.text};
    NSLog(@"参数:%@",para);
    //网络请求
    [RequestAPI requestURL:@"/login" withParameters:para andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
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
            [Utilities setUserDefaults:@"pwd" content:_usernameTextField.text];
            
            _passwordnameTextField.text = @"";
            
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
    if (textField == _usernameTextField || textField == _passwordnameTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
