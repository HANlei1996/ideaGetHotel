//
//  HotelsModel.m
//  GetHotel
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelsModel.h"

@implementation HotelsModel
-(id)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if(self){
        _city_name=[Utilities nullAndNilCheck:dict[@"dict_name"] replaceBy:@"无锡"];
        _pageNum=[Utilities nullAndNilCheck:dict[@"pageNum"] replaceBy:@""];
       _startId=[Utilities nullAndNilCheck:dict[@"startId"] replaceBy:@""];
         _priceId=[Utilities nullAndNilCheck:dict[@"priceId"] replaceBy:@""];
        _sortingId=[Utilities nullAndNilCheck:dict[@"sortingId"] replaceBy:@""];
        _inTime=[dict[@"endDate"]isKindOfClass:[NSNull class]] ? (NSTimeInterval)0: (NSTimeInterval)[dict[@"endDate"]integerValue];
        _outTime=[dict[@"endDate"]isKindOfClass:[NSNull class]] ? (NSTimeInterval)0: (NSTimeInterval)[dict[@"endDate"]integerValue];

    }
return  self;
}

@end
