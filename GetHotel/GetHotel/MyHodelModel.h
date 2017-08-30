//
//  MyHodelModel.h
//  GetHotel
//
//  Created by 233 on 2017/8/30.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHodelModel : NSObject
@property (strong, nonatomic) NSString * MyHotel;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *peopleNum;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *ctime;
@property (strong, nonatomic) NSString *picture;

- (instancetype)initWithDict: (NSDictionary *)dict;
- (instancetype)initWithDictForAcquire: (NSDictionary *)dict;
- (instancetype)initWithDictForFollow: (NSDictionary *)dict;
@end

