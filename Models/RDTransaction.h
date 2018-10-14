//
//  RDTransaction.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDTrade.h"


@interface RDTransaction : NSObject


@property (nonatomic, copy) NSString* date;

@property (nonatomic, copy) NSString* type;

@property (nonatomic,strong) RDTrade *bye;

@property (nonatomic,strong) RDTrade *sell;


+(NSDictionary*)parseTransactionToDic:(RDTransaction*)transaction;

+(RDTransaction*)parseTransactionToModel:(NSDictionary*)dic;




@end
