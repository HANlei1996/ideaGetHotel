//
//  MyModel.m
//  GetHotel
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 com. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel
- (instancetype)initWithDict: (NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.name = [Utilities nullAndNilCheck:dict[@"nick_name"] replaceBy:@"游客"];
        self.picture = [Utilities nullAndNilCheck:dict[@"head_img"] replaceBy:@"用户"];
    }
    return self;
}

@end
