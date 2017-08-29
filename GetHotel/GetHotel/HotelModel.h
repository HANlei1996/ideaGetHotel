//
//  HotelModel.h
//  GetHotel
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelModel : UIViewController
@property(nonatomic)NSTimeInterval inTime;
@property(nonatomic)NSTimeInterval outTime;
@property(strong,nonatomic)NSString *city_name;
- (instancetype)initWithDict: (NSDictionary *)dict;

@end
