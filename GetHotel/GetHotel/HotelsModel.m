//
//  HotelsModel.m
//  Get Hotels
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 com. All rights reserved.
//

#import "HotelsModel.h"

@implementation HotelsModel
- (instancetype)initWithDict: (NSDictionary *)dict{
    self = [super init];
   
    if(self){
        self.image = [dict[@"image"] isKindOfClass: [NSNull class]] ? @"" : dict[@"image"];
        self.name = [dict[@"name"]isKindOfClass:[NSNull class]] ? @"" : dict[@"name"];
    }
    return  self;
    }

    @end

