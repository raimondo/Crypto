//
//  RDTransactionManager.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTransactionManager.h"
#import "RDTransaction.h"
#import "RDTrade.h"
#import "RDApiRateManager.h"
#import "RDCryto.h"
#import "RDMarketCap.h"




@interface RDTransactionManager ()



@end;




@implementation RDTransactionManager

static RDTransactionManager *sharedTransactionManager = nil;

@synthesize transactions;
@synthesize rate;
@synthesize BTCZARprice;
@synthesize ETHBTCRate;
@synthesize marketCaps;





+ (RDTransactionManager *)sharedTransactionManager
{
    if (sharedTransactionManager == nil)
    {
        sharedTransactionManager = [[RDTransactionManager alloc] init];
        
    }
    return sharedTransactionManager;
}



-(void)addTransaction:(TransactionType)type transaction:(id)transaction
{
    if (!transactions) {
        transactions = [[NSMutableArray alloc]init];
        
    }
    
    if (type == TransactionTypeFiat_Inn) {
        RDFiat_In *fiat_In = transaction;
        
        fiat_In.dollar_rand_rate = [NSString stringWithFormat:@"%f", rate.rate ];
        fiat_In.prim_price_USD = [NSString stringWithFormat:@"%f",  [fiat_In.prim_ZAR doubleValue] /rate.rate];
        fiat_In.type = @"fiat_In";
        fiat_In.symbol = @"ZAR";

        [transactions addObject:fiat_In];
    }
    else
        if (type == TransactionTypeSell) {
            RDTrade *tradeSell = transaction;
            
            tradeSell.dollar_rand_rate = [NSString stringWithFormat:@"%f", rate.rate ];
            tradeSell.prim_price_USD = [NSString stringWithFormat:@"%f",  [tradeSell.prim_ZAR doubleValue] /rate.rate];
            tradeSell.type = @"sell";
            
          
            
            [transactions addObject:tradeSell];
        }
    
    if (type == TransactionTypeBye) {
        RDTrade *tradeSell = transaction;
        
        tradeSell.dollar_rand_rate = [NSString stringWithFormat:@"%f", rate.rate ];
        tradeSell.prim_price_USD = [NSString stringWithFormat:@"%f",  [tradeSell.prim_ZAR doubleValue] /rate.rate];
        tradeSell.type = @"bye";
        
        
        
        [transactions addObject:tradeSell];
    }
    
    NSLog(@"transactions %@",transactions);
    
    
    for (id obj in transactions) {
        [RDCryto logObject:obj];
    }
 
    
   
}


-(double)marKetPriceOf:(NSString*)symbol
{
    NSDictionary * dic = marketCaps ;
    NSLog(@"symbol %@",symbol);
    NSString *sym = [NSString stringWithFormat:@"%@",symbol];
    RDMarketCap *cap =  [dic objectForKey:sym];
    RDMarketCap *cap2 =  [dic objectForKey:@"BTC"];
    
    NSLog(@"dic objectForKey %@", [dic objectForKey:symbol]);
    RDMarketCap *marketCap = [marketCaps objectForKey:symbol];
    NSLog(@"marKetPriceOf");
    [RDCryto logObject:marketCap];
    return [marketCap.price_btc doubleValue];
}





@end
