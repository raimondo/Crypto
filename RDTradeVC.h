//
//  RDTradeVC.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/14.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDTrade.h"
#import "RDTransaction.h"



@interface RDTradeVC : UIViewController <UITextFieldDelegate>


- (instancetype)initTransaction:(RDTransaction*)transaction;

@end
