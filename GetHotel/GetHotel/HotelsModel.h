//
//  HotelsModel.h
//  GetHotel
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelsModel : NSObject
@property(strong,nonatomic)NSString *city_name;
@property(strong,nonatomic)NSString *pageNum;
@property(strong,nonatomic)NSString *startId;
@property(strong,nonatomic)NSString *priceId;
@property(strong,nonatomic)NSString *sortingId;
@property(nonatomic)NSTimeInterval inTime;
@property(nonatomic)NSTimeInterval outTime;
-(id)initWithDict:(NSDictionary *)dict;

@end
