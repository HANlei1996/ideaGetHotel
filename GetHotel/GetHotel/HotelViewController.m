//
//  HotelViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelViewController.h"
#import "HotelsViewTableCellTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "HotelsModel.h"
@interface HotelViewController()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    BOOL isLoading;
    BOOL firstVisit;
    BOOL flag;
    BOOL time;
    BOOL pageNum;
    BOOL pageSize;
}
@property (weak, nonatomic) IBOutlet UIButton *kaishi;
@property (weak, nonatomic) IBOutlet UIButton *likai;
@property (weak, nonatomic) IBOutlet UITableView *hotelsView;
- (IBAction)Btn1:(id)sender forEvent:(UIEvent *)event;
- (IBAction)quxiao:(UIBarButtonItem *)sender;
- (IBAction)queding:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet UIToolbar *bar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
- (IBAction)Btn2:(id)sender forEvent:(UIEvent *)event;
- (IBAction)Btn3:(id)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
- (IBAction)Btn4:(id)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property(strong,nonatomic) NSArray*arr;
@property (strong,nonatomic) CLLocationManager *locMgr;
@property (strong,nonatomic) CLLocation *location;
@property (strong,nonatomic) UIActivityIndicatorView *avi;
@property(strong,nonatomic) NSMutableArray *arr1;


@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netRequest];
    _arr=@[@{@"hotelsName":@"无锡君乐登酒店",@"hotelsAddr":@"无锡",@"hotelsDistance":@"距离我3公里",@"hotelsImage":@"酒店信息图片",@"hotelsmoney":@"¥318"},@{@"hotelsName":@"无锡喜来登酒店",@"hotelsAddr":@"无锡",@"hotelsDistance":@"距离我5公里",@"hotelsImage":@"酒店1",@"hotelsmoney":@"¥235"},@{@"hotelsName":@"无锡齐天登酒店",@"hotelsAddr":@"无锡",@"hotelsDistance":@"距离我2公里",@"hotelsImage":@"酒店信息图片",@"hotelsmoney":@"¥360"}];
    _arr1 = [NSMutableArray new];
    UIRefreshControl *ref = [UIRefreshControl new];
    [ref addTarget:self action:@selector(netRequest) forControlEvents:UIControlEventValueChanged];
    ref.tag = 10004;
    [_hotelsView addSubview:ref];
    
    
    _hotelsView.tableFooterView = [UIView new];
    
    [self naviConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//当前页面将要显示的时候，隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)naviConfig {
    //设置导航条标题文字
    self.navigationItem.title = @"Get Hotels";
    //导航条的颜色（风格颜色）
    // self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:100/255.0 blue:255/255.0 alpha:1.0]];
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏
    self.navigationController.navigationBar.hidden = NO;
}

//设置表格视图一共有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//设置表格视图中每一组由多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelsViewTableCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"hotelscell" forIndexPath:indexPath];
    NSDictionary *dict = _arr[indexPath.section];
    cell.hotelsImage.image = [UIImage imageNamed:dict[@"hotelsImage"]];
    cell.hotelsName.text=dict[@"hotelsName"];
    cell.hotelsAddr.text=dict[@"hotelsAddr"];
    cell.hotelsmoney.text=dict[@"hotelsmoney"];
    cell.hotelsDistance.text=dict[@"hotelsDistance"];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消细胞的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *Navi=[Utilities getStoryboardInstance:
                                  @"HotelDetail"byIdentity:@"Detail"];
    [self presentViewController:Navi animated:YES completion:nil];
}



- (IBAction)Btn2:(id)sender forEvent:(UIEvent *)event {
    time =1;
    if (flag) {
        
        _bar.hidden=NO;
        _picker.hidden=NO;
        _image2.image = [UIImage imageNamed:@"展开的副本"];
        flag = NO;
    }else{
        _bar.hidden=YES;
        _picker.hidden=YES;
        _image2.image = [UIImage imageNamed:@"收起的副本"];
        flag = YES;
    }
    
    
    
}

- (IBAction)Btn3:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)Btn4:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)Btn1:(id)sender forEvent:(UIEvent *)event {
    time = 0;
    if (flag) {
        _bar.hidden=NO;
        _picker.hidden=NO;
        _image1.image = [UIImage imageNamed:@"展开的副本"];
        flag = NO;
    }else{
        _bar.hidden=YES;
        _picker.hidden=YES;
        _image1.image = [UIImage imageNamed:@"收起的副本"];
        flag = YES;
    }
}




- (IBAction)quxiao:(UIBarButtonItem *)sender {
    _bar.hidden=NO;
    _picker.hidden=NO;
}

- (IBAction)queding:(UIBarButtonItem *)sender {
    //拿到当前datepicker选择的时间
    NSDate *date = _picker.date;
    //初始化一个日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //定义日期的格式为yyyy-MM-dd
    formatter.dateFormat = @"yyyy-MM-dd";
    //将日期转换为字符串（通过日期格式器中的stringFromDate方法）
    NSString *theDate = [formatter stringFromDate:date];
    
    if (time == 0) {
        [ _kaishi setTitle:theDate forState:UIControlStateNormal];
    }
    else
    {
        [_likai setTitle:theDate forState:UIControlStateNormal];
    }
    
    _bar.hidden = YES;
    _picker.hidden = YES;
}



- (void)netRequest{
    _avi = [Utilities getCoverOnView:self.view];
    NSDictionary *para =  @{@"city_name":_cityBtn,@"inTime":_kaishi,@"outTime":_likai};
    [RequestAPI requestURL:@"/findHotelByCity_edu" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        [_avi stopAnimating];
        
        if([responseObject[@"result"] integerValue] == 1){
            NSDictionary *content = responseObject[@"content"];
            NSArray *result = content[@"hotel"][@"list"];
            NSArray *Aarr = content[@"advertising"];
            for (NSDictionary *dict in Aarr) {
                HotelsModel *model = [[HotelsModel alloc]initWithDict:dict];
                [_arr1 addObject:model];
                
                
                
            }
            
            
            for (NSDictionary *dict in result) {
                HotelsModel *Model = [[HotelsModel alloc] initWithDict:dict];
                
                [_arr1 addObject:Model];
            }
            
            [_hotelsView reloadData];
            
        }else{
            
            NSString *er = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:er andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        
    }];
    
}

//定位失败时
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    if (error) {
        switch (error.code) {
            case kCLErrorNetwork:
                [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"NetworkError", nil) andTitle:nil onView:self];
                break;
            case kCLErrorDenied:
                [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"GPSDisabled", nil) andTitle:nil onView:self];
                break;
            case kCLErrorLocationUnknown:
                [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"LocationUnkonw", nil) andTitle:nil onView:self];
                break;
                
                
            default:[Utilities popUpAlertViewWithMsg:NSLocalizedString(@"SystemError", nil) andTitle:nil onView:self];
                break;
        }
    }
}
//定位成功时
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    //NSLog(@"纬度: %f",newLocation.coordinate.latitude);
    //NSLog(@"经度: %f",newLocation.coordinate.longitude);
    _location = newLocation;
    //用flag思想判断是否可以去根据定位拿到城市
    if (firstVisit) {
        firstVisit = !firstVisit;
        //根据定位拿到城市
        [self getRegeoViaCoordinate];
    }
}
-(void)getRegeoViaCoordinate{
    //duration表示从now开始过三个sec
    dispatch_time_t duration= dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    //用duration这个设置好的策略去做某些事
    dispatch_after(duration,dispatch_get_main_queue(), ^{
        //正式做事情
        CLGeocoder *geo = [CLGeocoder new];
        //方向地理编码
        [geo reverseGeocodeLocation:_location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error) {
                CLPlacemark *first = placemarks.firstObject;
                NSDictionary *locDict = first.addressDictionary;
                NSLog(@"locDict = %@",locDict);
                NSString *cityStr = locDict[@"City"];
                //把city的市子去掉
                cityStr = [cityStr substringToIndex:(cityStr.length - 1)];
                [[StorageMgr singletonStorageMgr]removeObjectForKey:@"LocCity"];
                //将定位到的城市保存进单例化全局变量
                [[StorageMgr singletonStorageMgr] addKey:@"LocCity" andValue:cityStr];
                if (![cityStr isEqualToString:_cityBtn.titleLabel.text]) {
                    //将定位的城市和当前选则的城市不一样的时候去弹窗询问用户是否要切换城市
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前定位到的城市为%@,请问您是否需要切换" ,cityStr] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //修改城市按钮标题
                        [_cityBtn setTitle:cityStr forState:UIControlStateNormal];
                        //修改用户选择的城市记忆体
                        [Utilities removeUserDefaults:@"UserCity"];
                        [Utilities setUserDefaults:@"UserCity" content:cityStr];
                        //重新执行网络请求
                        //[self network];
                    }];
                    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:yesAction];
                    [alert addAction:noAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
            }
        }];
        //关掉开关
        [_locMgr stopUpdatingLocation];
    });
}

-(void)checkCityState:(NSNotification *)note{
    NSString *cityStr = note.object;
    if (![cityStr isEqualToString:_cityBtn.titleLabel.text]){
        //修改城市按钮标题
        [_cityBtn setTitle:cityStr forState:UIControlStateNormal];
        //修改用户选择的城市记忆体
        [Utilities removeUserDefaults:@"UserCity"];
        [Utilities setUserDefaults:@"UserCity" content:cityStr];
        //重新执行网络请求
       // [self network];
    }
}
//这个方法处理开始定位
-(void)locationStart{
    //判断用户有没有选择过是否使用定位
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //询问用户是否愿意使用定位
#ifdef __IPHONE_8_0
        //使用“使用中打开定位”这个策略去运用定位功能
        [_locMgr requestWhenInUseAuthorization];
#endif
    }
    //打开定位服务的开关（开始定位）
    [_locMgr startUpdatingLocation];
}


@end
