//
//  MyModel.h
//  GetHotel
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property (strong, nonatomic) NSString *name;   //姓名
@property (strong, nonatomic) NSString *picture; //头像
- (instancetype)initWithDict: (NSDictionary *)dict;
@end
