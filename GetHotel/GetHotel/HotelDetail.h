//
//  HotelDetail.h
//  GetHotel
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelDetail : NSObject
@property (nonatomic) NSInteger city_id;
@property (strong, nonatomic) NSString *hotel_address;
@property (strong, nonatomic) NSString *hotel_facilities;
@property (strong, nonatomic) NSString *hotel_img;
@property (strong, nonatomic) NSString *hotel_name;
@property (strong, nonatomic) NSString *hotel_types;
@property (nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *in_time;
@property (strong, nonatomic) NSString *is_pet;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *now_price;
@property (strong, nonatomic) NSString *out_time;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *room_img;
- (instancetype) initWithDetailDictionary: (NSDictionary *)dict;

@end
