//
//  HotelModel.m
//  GetHotel
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelModel.h"

@interface HotelModel ()

@end

@implementation HotelModel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithDict: (NSDictionary *)dict{
  self = [super init];
    if(self){
        self.inTime=[[Utilities nullAndNilCheck:dict[@"inTime"] replaceBy:0]integerValue];
        self.outTime=[[Utilities nullAndNilCheck:dict[@"inTime"] replaceBy:0]integerValue];
           }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
