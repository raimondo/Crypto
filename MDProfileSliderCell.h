//
//  MDProfileSliderCell.h
//  MrDelivery
//
//  Created by Ray de Rose on 2016/10/05.
//  Copyright © 2016 Mr Delivery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDProfileSliderCell : UITableViewCell
{
    UIImageView *icon;
    UILabel * txtLabel;
    UIView * line ;

}

@property (nonatomic,strong) UIImageView *icon;

@property (nonatomic,strong) UILabel * txtLabel;

@property (nonatomic,strong) UIView * line ;

@end
