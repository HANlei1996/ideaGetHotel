//
//  HotelDetailViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "Constants.h"
@interface HotelDetailViewController ()
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
    [leftBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
//自定的返回按钮的事件
- (void)leftButtonAction: (UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)uiLayout{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)MapAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
- (IBAction)startDateAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
- (IBAction)endDateAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)SmallTalkAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)BuyAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
}

- (IBAction)confirmAction:(UIBarButtonItem *)sender {
}
@end
