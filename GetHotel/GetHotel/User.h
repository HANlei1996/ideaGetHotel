//
//  User.h
//  GetHotel
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(strong,nonatomic) NSString *tel;//手机号
@property(strong,nonatomic) NSString *nickname;//名称
@property(strong,nonatomic) NSString *age;//年龄
@property(strong,nonatomic) NSString *dob;//出身日期
@property(strong,nonatomic) NSString *idCardNo;//身份证号
@property(strong,nonatomic) NSString *gender;//性别
@property(strong,nonatomic) NSString *credit;//积分
@property(strong,nonatomic) NSString *avatarUrl;//头像


-(id)initWithDictionary:(NSDictionary *)dict;
@end
