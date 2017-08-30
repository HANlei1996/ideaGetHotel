//
//  UserModel.m
//  GetHotel
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(id)initWithDictionary:(NSDictionary *)dict{
    self=[super init];
    if(self){
        
        _openid=[Utilities nullAndNilCheck:dict[@"openid"] replaceBy:@"0"];
        _phone=[Utilities nullAndNilCheck:dict[@"contactTel"] replaceBy:@"未设置"];
<<<<<<< HEAD
        _nickname=[Utilities nullAndNilCheck:dict[@"nick_namee"] replaceBy:@"未设置"];
=======
        _nickname=[Utilities nullAndNilCheck:dict[@"nick_name"] replaceBy:@"未设置"];
>>>>>>> 0a0545610af3fa4346962e42f8cc9c6cdd2e1aa6
        _age=[Utilities nullAndNilCheck:dict[@"age"] replaceBy:@"0"];
        _dob=[Utilities nullAndNilCheck:dict[@"birthday"] replaceBy:@"未设置"];
        _idCardNo=[Utilities nullAndNilCheck:dict[@"identificationcard"] replaceBy:@"未设置"];
        _credit=[Utilities nullAndNilCheck:dict[@"memberPoint"] replaceBy:@"0"];
        _avatarUrl=[Utilities nullAndNilCheck:dict[@"head_img"] replaceBy:@""];
<<<<<<< HEAD
        _token=[Utilities nullAndNilCheck:dict[@"key"] replaceBy:@""];
=======
   //     _tokenKey=[Utilities nullAndNilCheck:dict[@"key"] replaceBy:@""];
>>>>>>> 0a0545610af3fa4346962e42f8cc9c6cdd2e1aa6
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
