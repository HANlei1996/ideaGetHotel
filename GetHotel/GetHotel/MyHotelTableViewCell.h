//
//  MyHotelTableViewCell.h
//  GetHotel
//
//  Created by 233 on 2017/8/25.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHotelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myHotelLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
