//
//  HotelDetail.m
//  GetHotel
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelDetail.h"

@implementation HotelDetail
- (instancetype) initWithDetailDictionary: (NSDictionary *)dict{
    
    self = [super init];
    if (self){
        _id = [[Utilities nullAndNilCheck:@"id" replaceBy:0] integerValue];
        _price = [Utilities nullAndNilCheck:dict[@"price"] replaceBy:0];
        self.hotel_img = [Utilities nullAndNilCheck:dict[@"hotel_img"] replaceBy:@""];
        self.hotel_name = [Utilities nullAndNilCheck:dict[@"hotel_name"] replaceBy:@""];
        _hotel_address = [Utilities nullAndNilCheck:dict[@"hotel_address"] replaceBy:@""];
        _in_time = [Utilities nullAndNilCheck:dict[@"in_time"] replaceBy:@""];
        _out_time = [Utilities nullAndNilCheck:dict[@"out_time"] replaceBy:@""];
        _room_img = [Utilities nullAndNilCheck:dict[@"room_img"] replaceBy:@""];
        _hotel_facilities = [Utilities nullAndNilCheck:dict[@"hotel_facilitys"] replaceBy:@""];
        _hotel_types = [Utilities nullAndNilCheck:dict[@"hotel_types"] replaceBy:@""];
        _remark = [Utilities nullAndNilCheck:dict[@"remark"] replaceBy:@""];
        _hotel_img = [Utilities nullAndNilCheck:dict[@"_hotel_img"] replaceBy:@""];
        if([dict[@"is_pet"] isKindOfClass:[NSNull class]]){
            _is_pet = @"";
        }else{
            switch ([dict[@"is_pet"]integerValue]) {
                case 0:
                    _is_pet = @"不可携带宠物";
                    break;
                case 1:
                    _is_pet = @"可携带宠物";
                    break;
                default:
                    _is_pet = @"未设置";
                    break;
            }
        }
    }
    return self;
}
@end
