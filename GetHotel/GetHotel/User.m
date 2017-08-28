//
//  User.m
//  GetHotel
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 com. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithDictionary:(NSDictionary *)dict{
    self=[super init];
    if(self){
        
        
        _tel=[Utilities nullAndNilCheck:dict[@"contactTel"] replaceBy:@"未设置"];
        _nickname=[Utilities nullAndNilCheck:dict[@"memberName"] replaceBy:@"未设置"];
        _age=[Utilities nullAndNilCheck:dict[@"age"] replaceBy:@"0"];
        _dob=[Utilities nullAndNilCheck:dict[@"birthday"] replaceBy:@"未设置"];
        _idCardNo=[Utilities nullAndNilCheck:dict[@"identificationcard"] replaceBy:@"未设置"];
        _credit=[Utilities nullAndNilCheck:dict[@"memberPoint"] replaceBy:@"0"];
        _avatarUrl=[Utilities nullAndNilCheck:dict[@"memberUrl"] replaceBy:@""];
        
        if ([dict[@"memberSex"] isKindOfClass:[NSNull class]]) {
            _gender=@"";
            
        }else{
            switch ([dict[@"memberSex"] integerValue]) {
                case 1:
                    _gender=@"男";
                    break;
                case 2:
                    _gender=@"女";
                    break;
                default:
                    _gender=@"未设置";
                    break;
            }
        }
    }
    return self;
}
@end
