//
//  MDProfileVC.h
//  MrDelivery
//
//  Created by Raimondo De Rose on 2015/09/10.
//  Copyright (c) 2015 Mr Delivery. All rights reserved.
//

#import <UIKit/UIKit.h>







@interface MDProfileSliderVC : UIView <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
  UITableView *tableView;
    UIView *tintV;
    UIImage *landingImage;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tintV;
@property (nonatomic, strong)  UIImage *landingImage;


-(void)slideOutProfileView;

-(void)slideInProfileView;

@end
