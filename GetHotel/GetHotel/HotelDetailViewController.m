//
//  HotelDetailViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "Constants.h"
#import "HotelDetail.h"

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
@property (weak, nonatomic) IBOutlet UILabel *hotelRoomType;
@property (weak, nonatomic) IBOutlet UILabel *early;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *size;

@property (weak, nonatomic) IBOutlet UIButton *SmallTalkBtn;
- (IBAction)SmallTalkAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)BuyAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *TooBar;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)confirmAction:(UIBarButtonItem *)sender;
@property (strong,nonatomic)UIActivityIndicatorView *avi;

@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItem];
    [self networkRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当前页面将要显示的时候，显示导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
     
}
//设置导航栏样式
- (void)setNavigationItem{
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:100/255.0 blue:255.0 alpha:1.0]];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
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
//设置默认时间
- (void)setDefaultDateForButton{
    //初始化日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //定义日期格式
    formatter.dateFormat = @"MM月dd日";
    //当前时间
    NSDate *date = [NSDate date];
    //明天的日期
    NSDate *dateTom = [NSDate dateTomorrow];
    //将日期转换为字符串
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *dateTomStr = [formatter stringFromDate:dateTom];
    //将处理好的时间字符串设置给两个button
    [_StartDateBtn setTitle:dateStr forState:UIControlStateNormal];
    [_endDateBtn setTitle:dateTomStr forState:UIControlStateNormal];
}
//设置导航栏样式
-(void)networkRequest{
    _avi=[Utilities getCoverOnView:self.view];
    
    NSDictionary *para = @{@"id":@1};
    
    [RequestAPI requestURL:@"/findHotelById" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [_avi stopAnimating];
        if([responseObject[@"resultFlag"]integerValue] == 1){
            NSDictionary *content = responseObject[@"content"];
            HotelDetail *detailModel = [[HotelDetail alloc]initWithDetailDictionary:content];
            NSString *startDate =[[[StorageMgr singletonStorageMgr] objectForKey:@"in_time"] substringFromIndex:2 ];
            NSString *endDate =[[[StorageMgr singletonStorageMgr]objectForKey:@"out_time"] substringFromIndex:2 ];
            [_StartDateBtn setTitle:startDate forState:(UIControlStateNormal)];
            [_endDateBtn setTitle:endDate forState:UIControlStateNormal];
            _HotelLabel.text = detailModel.hotel_name;
            _hotelPriceLabel.text = [NSString stringWithFormat:@"¥ %@",detailModel.price];
            _AddressLabel.text = detailModel.hotel_address;
            NSArray *arr = content[@"hotel_types"];
            for(int i=0;i<arr.count;i++){
                switch (i) {
                    case 0:
                        _hotelRoomType.text= arr[i];
                        break;
                    case 1:
                        _early.text = arr[i];
                        break;
                    case 2:
                        _type.text = arr[i];
                        break;
                    case 3:
                        _size.text = arr[i];
                        break;
                        
                    default:
                        break;
                }
            }

        }else{
            NSString *errorMsg=[ErrorHandler getProperErrorString:[responseObject[@"resultFlag"]integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:nil];
            
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        //业务逻辑失败的情况下
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:@"提示" onView:self];
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
    //拿到当前datePicker选择时间
    NSDate *date = _DatePicker.date;
    //初始化一个日期格式器
    NSDateFormatter *formatter =[NSDateFormatter new];
    //定义日期的格式为yyyy-MM-dd
    formatter.dateFormat = @"MM-dd";
    //将日期转换为字符串
    NSString *theDate = [formatter stringFromDate:date];
    if(flag == 0){
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
    if ([Utilities loginCheck]) {
        [self performSegueWithIdentifier:@"pay" sender:self];
        
    }else{
        UINavigationController *signNavi=[Utilities getStoryboardInstance:@"Sign"byIdentity:@"SignNavi"];
        [self presentViewController:signNavi animated:YES completion:nil];
        
    }
}
@end

