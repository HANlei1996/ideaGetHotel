//
//  HotelViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelViewController.h"
#import "HotelsViewTableCellTableViewCell.h"
@interface HotelViewController()<UITableViewDataSource,UITableViewDelegate>{
    BOOL flag;
    BOOL time;
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

@property (weak, nonatomic) IBOutlet UIImageView *image1;
- (IBAction)Btn2:(id)sender forEvent:(UIEvent *)event;
- (IBAction)Btn3:(id)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
- (IBAction)Btn4:(id)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property(strong,nonatomic) NSArray*arr;

@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr=@[@{@"hotelsName":@"无锡君乐登酒店",@"hotelsAddr":@"无锡",@"hotelsDistance":@"距离我3公里",@"hotelsImage":@"酒店1",@"hotelsmoney":@"¥318"}];
    
    
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
    return 1;
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
/*- (void)setDefaultDateForButton{
 
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 
 formatter.dateFormat = @"yyyy-MM-dd";
 
 NSDate *date = [NSDate date];
 
 // NSDate *dateTom = [NSDate dateTomorrow];
 
 
 
 NSString *dateStr = [formatter stringFromDate:date];
 NSString *dateTomStr = [formatter stringFromDate:dateStr];
 
 [_kaishi setTitle:dateStr forState:UIControlStateNormal];
 [_likai setTitle:dateTomStr forState:UIControlStateNormal];
 }
 */
@end
