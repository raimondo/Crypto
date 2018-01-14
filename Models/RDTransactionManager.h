//
//  RDTransactionManager.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDFiat_In.h"
#import "RDExchangeRate.h"


typedef enum
{
    TransactionTypeBye = 1,
    TransactionTypeSell,
    TransactionTypeFiat_Out,
    TransactionTypeFiat_Inn
} TransactionType;

@interface RDTransactionManager : NSObject


{
    NSMutableArray *transactions;
    RDExchangeRate * rate;
    NSString *BTCZARprice;
    NSString *ETHBTCRate;
    NSDictionary * marketCaps;
    
}

@property (nonatomic,strong) NSMutableArray *transactions;

@property (nonatomic,strong)  RDExchangeRate * rate;

@property (nonatomic,strong)  NSString *BTCZARprice;

@property (nonatomic,strong)  NSString *ETHBTCRate;

@property (nonatomic,strong)  NSDictionary *marketCaps;


+ (RDTransactionManager *)sharedTransactionManager;


-(void)addTransaction:(TransactionType)type transaction:(id)transaction;

-(double)marKetPriceOf:(NSString*)symbol;



@end
