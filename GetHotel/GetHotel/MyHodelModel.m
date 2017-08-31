//
//  MyHodelModel.m
//  GetHotel
//
//  Created by 233 on 2017/8/30.
//  Copyright © 2017年 com. All rights reserved.
//

#import "MyHodelModel.h"

@implementation MyHodelModel
- (instancetype)initWithDict: (NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.MyHotel = [Utilities nullAndNilCheck:dict[@"MyHotel"] replaceBy:@""];
        self.location = [Utilities nullAndNilCheck:dict[@"location"] replaceBy:@""];
        self.peopleNum = [Utilities nullAndNilCheck:dict[@"peopleNum"] replaceBy:@""];
        self.time = [Utilities nullAndNilCheck:dict[@"time"] replaceBy:@""];
        self.ctime = [Utilities nullAndNilCheck:dict[@"ctime"] replaceBy:@""];
        self.picture = [Utilities nullAndNilCheck:dict[@"picture"] replaceBy:@""];
        
    }
    return self;
    
}
- (instancetype)initWithDictForAcquire: (NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.MyHotel = [Utilities nullAndNilCheck:dict[@"MyHotel"] replaceBy:@""];
        self.location = [Utilities nullAndNilCheck:dict[@"location"] replaceBy:@""];
        self.peopleNum = [Utilities nullAndNilCheck:dict[@"peopleNum"] replaceBy:@""];
        self.time = [Utilities nullAndNilCheck:dict[@"time"] replaceBy:@""];
        self.ctime = [Utilities nullAndNilCheck:dict[@"ctime"] replaceBy:@""];
        self.picture = [Utilities nullAndNilCheck:dict[@"picture"] replaceBy:@""];
        
    }
    return self;
    
    
}
- (instancetype)initWithDictForFollow: (NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.MyHotel = [Utilities nullAndNilCheck:dict[@"MyHotel"] replaceBy:@""];
        self.location = [Utilities nullAndNilCheck:dict[@"location"] replaceBy:@""];
        self.peopleNum = [Utilities nullAndNilCheck:dict[@"peopleNum"] replaceBy:@""];
        self.time = [Utilities nullAndNilCheck:dict[@"time"] replaceBy:@""];
        self.ctime = [Utilities nullAndNilCheck:dict[@"ctime"] replaceBy:@""];
        self.picture = [Utilities nullAndNilCheck:dict[@"picture"] replaceBy:@""];
        
    }
    return self;
    
    
}

@end
