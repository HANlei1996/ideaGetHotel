//
//  MyHotelViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "MyHotelViewController.h"
#import "MyHotelTableViewCell.h"
#import "HMSegmentedControl.h"


@interface MyHotelViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *MyHotelTableView;

@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic)HMSegmentedControl *segmentedControl;

@end

@implementation MyHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr = @[@{@"title":@"",@"content":@""}];
    _MyHotelTableView.tableFooterView = [UIView new];
    
    [self naviConfig];
    [self setSegment];
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
// 这个方法专门做导航条的控制
-(void)naviConfig{
    //设置导航条标题文字
    //self.navigationItem.title=@"活动列表";
    //设置导航条的颜色（风格颜色）
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:100/255.0 blue:255.0 alpha:1.0]];
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
  // [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - setSegment设置菜单栏
//初始化菜单栏的方法
- (void)setSegment{
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部订单",@"可使用",@"已过期"]];
    //设置位置
    _segmentedControl.frame = CGRectMake(0, 60,UI_SCREEN_W, 40);
    //设置默认选中的项
    _segmentedControl.selectedSegmentIndex = 0;
    //设置菜单栏的背景色
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    //设置线的高度
    _segmentedControl.selectionIndicatorHeight = 2.5f;
    //设置选中状态的样式
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    //选中时的标记的位置
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    //设置未选中的标题样式
    _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGBA(230, 230, 230, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
    //选中时的标题样式
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGBA(0, 122, 250, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
    
    __weak typeof(self) weakSelf = self;
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.MyHotelTableView scrollRectToVisible:CGRectMake(UI_SCREEN_W * index, 0, UI_SCREEN_W, 200) animated:YES];
    }];
    
    [self.view addSubview:_segmentedControl];
}



//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    NSDictionary *dict = _arr[indexPath.row];
    cell.textLabel.text = dict[@"myHotel"];
    return cell;
}
//设置每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.f;
}
//细胞选中后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
