//
//  RDTradeCell.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/28.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDTradeCell : UITableViewCell
{
    UILabel *percentLabel;
     UILabel *volLabel;
}

@property (nonatomic,strong) UILabel *percentLabel;
@property (nonatomic,strong) UILabel *volLabel;

@end
