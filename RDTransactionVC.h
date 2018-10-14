//
//  RDTransactionVC.h
//  Cryto
//
//  Created by Ray de Rose on 2018/02/03.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDTransactionVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

- (instancetype)initWithTransactions:(NSArray*)transactions;

@end
