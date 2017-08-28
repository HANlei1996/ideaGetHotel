//
//  HotelDetailViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "Constants.h"
@interface HotelDetailViewController (){
    NSInteger flag;
}
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *HotelLabel;

@property (weak, nonatomic) IBOutlet UILabel *hotelPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *MapBtn;
- (IBAction)MapAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *StartDateBtn;
- (IBAction)startDateAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
- (IBAction)endDateAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *hotelRoom;
@property (weak, nonatomic) IBOutlet UIButton *SmallTalkBtn;
- (IBAction)SmallTalkAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)BuyAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *TooBar;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)confirmAction:(UIBarButtonItem *)sender;



@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置导航栏样式
- (void)setNavigationItem{
    //self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:HEAD_THEMECOLOR];
    //实例化一个button 类型为UIButtonTypeSystem
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //设置位置大小
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    //设置其背景图片为返回图片
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    //给按钮添加事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
//自定的返回按钮的事件
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setDefaultDateForButton{
    //初始化日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //定义日期格式
    formatter.dateFormat = @"MM月dd日";
    //当前时间
    NSDate *date = [NSDate date];
    //明天的日期
    NSDate *dateTom = [NSDate dateTomorrow];
    
    //将时间转换为字符串
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *dateTomStr = [formatter stringFromDate:dateTom];
    //将处理好的时间字符串设置给两个button
    [_StartDateBtn setTitle:dateStr forState:UIControlStateNormal];
    [_endDateBtn setTitle:dateTomStr forState:UIControlStateNormal];
}
//设置导航栏样式
-(void)networkRequest{
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    NSMutableDictionary *parameters=[NSMutableDictionary new];
    
    [RequestAPI requestURL:@"/findHotelById" withParameters:parameters andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        
        [aiv stopAnimating];
        if([responseObject[@"resultFlag"]integerValue] == 8001){
            
        }else{
            NSString *errorMsg=[ErrorHandler getProperErrorString:[responseObject[@"resultFlag"]integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
            
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        [aiv stopAnimating];
        //业务逻辑失败的情况下
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - buttonAction

//开始日期按钮点击事件
- (IBAction)startDateAction:(UIButton *)sender forEvent:(UIEvent *)event {
    flag = 0;
    _TooBar.hidden = NO;
    _DatePicker.hidden = NO;
}
//结束日期按钮点击事件
- (IBAction)endDateAction:(UIButton *)sender forEvent:(UIEvent *)event {
    flag = 1;
    _TooBar.hidden = NO;
    _DatePicker.hidden = NO;
}
//取消item点击事件（取消选择的日期）
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    _TooBar.hidden = YES;
    _DatePicker.hidden = YES;
}
//确认item点击事件（确认选择的日期）
- (IBAction)confirmAction:(UIBarButtonItem *)sender {
    //拿到当前datepicker选择的时间
    NSDate *date = _DatePicker.date;
    //初始化一个日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //定义日期的格式为yyyy-MM-dd
    formatter.dateFormat = @"MM月dd日";
    //将日期转换为字符串（通过日期格式器中的stringFromDate方法）
    NSString *theDate = [formatter stringFromDate:date];
    
    if (flag == 0) {
        [_StartDateBtn setTitle:theDate forState:UIControlStateNormal];
    }else{
        [_endDateBtn setTitle:theDate forState:UIControlStateNormal];
    }
    
    _TooBar.hidden = YES;
    _DatePicker.hidden = YES;
}


- (IBAction)MapAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)SmallTalkAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)BuyAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
