//
//  MyHotelViewController.m
//  GetHotel
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 com. All rights reserved.
//

#import "MyHotelViewController.h"
#import "AcquireTableViewCell.h"
#import "NotAcquireTableViewCell.h"
#import "FollowTableViewCell.h"
#import "HMSegmentedControl.h"
#import "MyHodelModel.h"

@interface MyHotelViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger notAcquireFlag;
    NSInteger followFlag;
    
    NSInteger acquirePageNum;
    BOOL acquireLast;
    
    NSInteger notAcquirePageNum;
    BOOL notAcquireLast;
    
    NSInteger followPageNum;
    BOOL followLast;
    
    NSInteger pageSize;
}
@property (weak, nonatomic) IBOutlet UIScrollView *MyHotelScrollView;
@property (weak, nonatomic) IBOutlet UITableView *NotAcquireTableView;
@property (weak, nonatomic) IBOutlet UITableView *FollowTableView;
@property (weak, nonatomic) IBOutlet UITableView *AcquireTableView;




@property (strong, nonatomic) NSMutableArray *allOrderArr;
@property (strong, nonatomic)HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) UIActivityIndicatorView *avi;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *acquireArr;
@property (strong, nonatomic) NSMutableArray *notAcquireArr;
@property (strong, nonatomic) NSMutableArray *followArr;
@property (strong, nonatomic) UIImageView *acquireNothingImg;
@property (strong, nonatomic) UIImageView *notAcquireNothingImg;
@property (strong, nonatomic) UIImageView *followNothingImg;
@end

@implementation MyHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    notAcquireFlag = 1;
    followFlag = 1;
    
    acquirePageNum = 1;
    notAcquirePageNum = 1;
    followPageNum = 1;
    pageSize = 20;
    //初始化数组，分配内存
    _acquireArr = [NSMutableArray new];
    _notAcquireArr = [NSMutableArray new];
    _followArr = [NSMutableArray new];
    
    //去掉tableview底部多余的线
    _AcquireTableView.tableFooterView = [UIView new];
    _NotAcquireTableView.tableFooterView = [UIView new];
    _FollowTableView.tableFooterView = [UIView new];
    
    //菜单栏
    [self setSegment];
    //刷新指示器
    [self setRefreshControl];
    //调用tableView没数据时显示图片的方法
    if (_acquireArr.count == 0) {
        [self nothingForTableView];
    }
    
    //已获取任务的网络请求（带蒙层）
    [self acquireInitializeData];
    
    //监听名为@"refreshHome"的通知，监听到后执行refreshHome方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHome) name:@"refreshHome" object:nil];
}
- (void)refreshHome{
    [self acquireRef];
    [self followRef];
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
//第一次进行网络请求的时候需要盖上蒙层，而下拉刷新的时候不需要蒙层，所以我们把第一次网络请求和下拉刷新分开来
- (void)acquireInitializeData{
    _avi = [Utilities getCoverOnView:self.view];
    [self acquireRequest];
}
- (void)notAcquireInitializeData{
    _avi = [Utilities getCoverOnView:self.view];
    [self notAcquireRequest];
}
- (void)followInitializeData{
    _avi = [Utilities getCoverOnView:self.view];
    [self followRequest];
}
//当tableView没有数据时显示图片的方法
- (void)nothingForTableView{
    _acquireNothingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_things"]];
    _acquireNothingImg.frame = CGRectMake((UI_SCREEN_W - 100) / 2, 50, 100, 100);
    
    _notAcquireNothingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_things"]];
    _notAcquireNothingImg.frame = CGRectMake(UI_SCREEN_W + (UI_SCREEN_W - 100) / 2, 50, 100, 100);
    
    _followNothingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_things"]];
    _followNothingImg.frame = CGRectMake(UI_SCREEN_W * 2 + (UI_SCREEN_W - 100) / 2, 50, 100, 100);
    
    [_MyHotelScrollView addSubview:_acquireNothingImg];
    [_MyHotelScrollView addSubview:_notAcquireNothingImg];
    [_MyHotelScrollView addSubview:_followNothingImg];
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
        [weakSelf.MyHotelScrollView scrollRectToVisible:CGRectMake(UI_SCREEN_W * index, 0, UI_SCREEN_W, 200) animated:YES];
    }];
    
    [self.view addSubview:_segmentedControl];
    
}
//scrollView已经停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _MyHotelScrollView) {
        NSInteger page = [self scrollCheck:scrollView];
        //NSLog(@"page = %ld", (long)page);
        //将_segmentedControl设置选中的index为page（scrollView当前显示的tableview）
        [_segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
}
//scrollView已经结束滑动的动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == _MyHotelScrollView) {
        [self scrollCheck:scrollView];
    }
}
//判断scrollView滑动到那里了
- (NSInteger)scrollCheck: (UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / (scrollView.frame.size.width);
    
    
    if (notAcquireFlag == 1 && page == 1) {
        notAcquireFlag = 0;
        NSLog(@"第一次滑动scollview来到未获取");
        [self notAcquireInitializeData];
    }
    if (followFlag == 1 && page == 2) {
        followFlag = 0;
        NSLog(@"第一次滑动scollview来到跟进");
        [self followInitializeData];
    }
    
    return page;
}


#pragma mark - request



//网络请求
- (void)acquireRequest{
    //获取token请求接口
    
    
    NSDictionary *para = @{@"openid": @1,@"id": @1};
    
    [RequestAPI requestURL:@"/findOrders_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
        
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_AcquireTableView viewWithTag:10001];
        [ref endRefreshing];
        
        NSLog(@"acquire: %@", responseObject);
        if ([responseObject[@"flag"] isEqualToString:@"success"]) {
            //将数据中的result拿出来放到字典中
            NSDictionary *result = responseObject[@"result"];
            //将上一步拿到的字典中的list数组提取出来
            NSArray *list = result[@"list"];
            acquireLast = [result[@"isLastPage"] boolValue];
            
            //当页码为1的时候让数据先清空，再重新添加
            if (acquirePageNum == 1) {
                [_acquireArr removeAllObjects];
            }
            //遍历list
            for (NSDictionary *dict in list) {
                //将遍历得来的字典转换为model
                MyHodelModel *aModel = [[MyHodelModel alloc] initWithDict:dict];
                //将model存进全局数组
                [_acquireArr addObject:aModel];
            }
            //当数组没有数据时将图片显示，反之隐藏
            if (_acquireArr.count == 0) {
                _acquireNothingImg.hidden = NO;
            }else{
                _acquireNothingImg.hidden = YES;
            }
            //让_acquireTableView重载数据
            [_AcquireTableView reloadData];
        }else{
            [Utilities popUpAlertViewWithMsg:@"请求发生了错误，请稍后再试" andTitle:@"提示" onView:self];{
            }           }
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_AcquireTableView viewWithTag:10001];
        [ref endRefreshing];
        
//        [Utilities forceLogoutCheck:statusCode fromViewController:self];
        
    }];
}
-(void)notAcquireRequest{
    NSDictionary *para = @{@"openid": @1,@"id": @2};
    
    [RequestAPI requestURL:@"/findOrders_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
        
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_NotAcquireTableView viewWithTag:10001];
        [ref endRefreshing];
        
        NSLog(@"notAcquire: %@", responseObject);
        if ([responseObject[@"flag"] isEqualToString:@"success"]) {
            //将数据中的result拿出来放到字典中
            NSDictionary *result = responseObject[@"result"];
            //将上一步拿到的字典中的list数组提取出来
            NSArray *list = result[@"list"];
            notAcquireLast = [result[@"isLastPage"] boolValue];
            
            //当页码为1的时候让数据先清空，再重新添加
            if (notAcquirePageNum == 1) {
                [_notAcquireArr removeAllObjects];
            }
            //遍历list
            for (NSDictionary *dict in list) {
                //将遍历得来的字典转换为model
                MyHodelModel *aModel = [[MyHodelModel alloc] initWithDictForAcquire:dict];
                //将model存进全局数组
                [_notAcquireArr addObject:aModel];
            }
            //当数组没有数据时将图片显示，反之隐藏
            if (_notAcquireArr.count == 0) {
                _notAcquireNothingImg.hidden = NO;
            }else{
                _notAcquireNothingImg.hidden = YES;
            }
            //让_acquireTableView重载数据
            [_NotAcquireTableView reloadData];
        }else{
            [Utilities popUpAlertViewWithMsg:@"请求发生了错误，请稍后再试" andTitle:@"提示" onView:self];{
            }            }
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_NotAcquireTableView viewWithTag:10001];
        [ref endRefreshing];
        
//        [Utilities forceLogoutCheck:statusCode fromViewController:self];
        
    }];
    
}
-(void)followRequest{
    NSDictionary *para = @{@"openid": @1,@"id": @3};
    
    [RequestAPI requestURL:@"/findOrders_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
        
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_FollowTableView viewWithTag:10001];
        [ref endRefreshing];
        
        NSLog(@"follow: %@", responseObject);
        if ([responseObject[@"flag"] isEqualToString:@"success"]) {
            //将数据中的result拿出来放到字典中
            NSDictionary *result = responseObject[@"result"];
            //将上一步拿到的字典中的list数组提取出来
            NSArray *list = result[@"list"];
            followLast = [result[@"isLastPage"] boolValue];
            
            //当页码为1的时候让数据先清空，再重新添加
            if (followPageNum == 1) {
                [_followArr removeAllObjects];
            }
            //遍历list
            for (NSDictionary *dict in list) {
                //将遍历得来的字典转换为model
                MyHodelModel *aModel = [[MyHodelModel alloc] initWithDictForFollow:dict];
                //将model存进全局数组
                [_followArr addObject:aModel];
            }
            //当数组没有数据时将图片显示，反之隐藏
            if (_followArr.count == 0) {
                _followNothingImg.hidden = NO;
            }else{
                _followNothingImg.hidden = YES;
            }
            //让_acquireTableView重载数据
            [_FollowTableView reloadData];
        }else{
            [Utilities popUpAlertViewWithMsg:@"请求发生了错误，请稍后再试" andTitle:@"提示" onView:self];{
            }            }
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_FollowTableView viewWithTag:10001];
        [ref endRefreshing];
        
        //        [Utilities forceLogoutCheck:statusCode fromViewController:self];
        
    }];
    

}
- (void)setRefreshControl{
    //已获取列表的刷新指示器
    UIRefreshControl *acquireRef = [UIRefreshControl new];
    [acquireRef addTarget:self action:@selector(acquireRef) forControlEvents:UIControlEventValueChanged];
    acquireRef.tag = 10001;
    [_AcquireTableView addSubview:acquireRef];
    
    //未获取列表的刷新指示器
    UIRefreshControl *notAcquireRef = [UIRefreshControl new];
    [notAcquireRef addTarget:self action:@selector(notAcquireRef) forControlEvents:UIControlEventValueChanged];
    notAcquireRef.tag = 10002;
    [_NotAcquireTableView addSubview:notAcquireRef];
    
    //跟进列表的刷新指示器
    UIRefreshControl *followRef = [UIRefreshControl new];
    [followRef addTarget:self action:@selector(followRef) forControlEvents:UIControlEventValueChanged];
    followRef.tag = 10003;
    [_FollowTableView addSubview:followRef];
}

//已获取列表下拉刷新事件
- (void)acquireRef{
    acquirePageNum = 1;
    [self acquireRequest];
}
//未获取列表下拉刷新事件
- (void)notAcquireRef{
    notAcquirePageNum = 1;
    [self notAcquireRequest];
}
//跟进列表下拉刷新事件
- (void)followRef{
    followPageNum = 1;
    [self followRequest];
}
//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _AcquireTableView) {
        return _acquireArr.count;
    }else if (tableView == _NotAcquireTableView) {
        return _notAcquireArr.count;
    }else{
        return _followArr.count;
    }
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _AcquireTableView) {
        AcquireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AcquireCell" forIndexPath:indexPath];
        MyHodelModel *aModel = _acquireArr[indexPath.section];
        
        return cell;
    }else if (tableView == _NotAcquireTableView) {
        
        NotAcquireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotAcquireCell" forIndexPath:indexPath];
        MyHodelModel *bModel = _notAcquireArr[indexPath.section];
        return cell;
        
    }else{
        FollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowCell" forIndexPath:indexPath];
        MyHodelModel *cModel = _followArr[indexPath.section];
        
        return cell;
    }
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
