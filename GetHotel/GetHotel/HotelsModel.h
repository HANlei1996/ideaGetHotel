//
//  HotelsModel.h
//  Get Hotels
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelsModel : NSObject
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *addr;
@property (strong,nonatomic) NSString *distance;
@property(strong,nonatomic)NSString *money;
- (instancetype)initWithDict: (NSDictionary *)dict;
@end
