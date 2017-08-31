//
//  MyViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "SignModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *touxiangImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *dengjiLabel;
@property (strong, nonatomic) NSArray *myArr;
@property (weak, nonatomic) IBOutlet UITableView *myTabelView;
- (IBAction)loginBtn:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *loginLabel;

@end

@implementation MyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myArr = @[@{@"htImage":@"酒店",@"hotelsLabel":@"我的酒店"},@{@"htImage":@"航空",@"hotelsLabel":@"我的航空"},@{@"htImage":@"我的消息",@"hotelsLabel":@"我的消息"},@{@"htImage":@"设置",@"hotelsLabel":@"账户设置"},@{@"htImage":@"使用协议",@"hotelsLabel":@"使用协议"},@{@"htImage":@"联系客服",@"hotelsLabel":@"联系客服"}];
    _myTabelView.tableFooterView = [UIView new];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当前页面将要显示的时候，隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([Utilities loginCheck]) {
        //已登录
        _loginLabel.hidden=YES;
        _nameLable.hidden=NO;
       // _touxiangImage.image=[UIImage imageNamed:@"小葵"];
         SignModel *user=[[StorageMgr singletonStorageMgr]objectForKey:@"UserInfo"];
        
        [_touxiangImage sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageNamed:@"小葵"]];
        _nameLable.text=user.nickname;
        /*_grade.hidden=NO;
        UIImage  *stars=[UIImage imageNamed:@"star"];
    switch (user.state) {
            case 1:
                _star1.image=stars;
                break;
            case 2:
                _star1.image=stars;
                _star2.image=stars;
            case 3:
                _star1.image=stars;
                _star2.image=stars;
                _star3.image=stars;
            default:
                break;
        }

        */

    }else{
        //未登录
        _loginLabel.hidden=NO;
        _nameLable.hidden=YES;
        _touxiangImage.image=[UIImage imageNamed:@"头像"];
        
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

//设置表格视图一共有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _myArr.count;
}


//设置表格视图中每一组由多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myHotelsCell" forIndexPath:indexPath];
    NSDictionary *dict = _myArr[indexPath.section];
    cell.htImage.image = [UIImage imageNamed:dict[@"htImage"]];
    cell.hotelsLabel.text = dict[@"hotelsLabel"];
    return cell;
}
//设置组的底部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 5.f;
    }
    return 1.f;
}
//设置细胞高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}
//细胞选中后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消细胞的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

       // if ([Utilities loginCheck]) {
            switch (indexPath.section) {
                case 0:
                    [self performSegueWithIdentifier:@"wdjd" sender:self];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"wdhk" sender:self];
                    break;
                case 2:
                    [self performSegueWithIdentifier:@"wdxx" sender:self];
                    break;
                case 3:
                    [self performSegueWithIdentifier:@"zhsz" sender:self];
                    break;
                case 4:
                   [self performSegueWithIdentifier:@"syxy" sender:self];
                    break;
                    
                default:
                   [self performSegueWithIdentifier:@"lxkf" sender:self];
                    break;
            }
      // }else{
            //[self performSegueWithIdentifier:@"syxy" sender:self];
           //[self performSegueWithIdentifier:@"lxkf" sender:self];
            //UINavigationController *signNavi=[Utilities getStoryboardInstance:
           //                                   @"Sign"byIdentity:@"SignNavi"];
//[self presentViewController:signNavi animated:YES completion:nil];
    
      //  }
        }


- (IBAction)loginBtn:(UIButton *)sender forEvent:(UIEvent *)event {
    [self performSegueWithIdentifier:@"zhsz" sender:self];
}
#pragma mark - request
//网络请求
- (void)request{
    
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    
    //获取token请求接口
    //NSString *token = [[StorageMgr singletonStorageMgr] objectForKey:@"token"];
   // NSArray *headers = @[[Utilities makeHeaderForToken:token]];
    NSDictionary *para = @{@"openid":@2};
    [RequestAPI requestURL:@"/myUsers_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
        [avi stopAnimating];
        NSLog(@"responseObject: %@", responseObject);
        if ([responseObject[@"flag"] isEqualToString:@"success"]) {
            
        
        }else{
           
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [avi stopAnimating];
        
       
    
    }];
}



@end
