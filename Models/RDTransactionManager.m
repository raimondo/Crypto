//
//  RDTransactionManager.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTransactionManager.h"
#import "RDTransaction.h"
#import "RDApiRateManager.h"
#import "RDCryto.h"
#import "RDMarketCap.h"
#import "RDPersistanceManager.h"




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



-(RDTrade*)addTransaction:(TransactionType)type transaction:(id)transaction
{
    if (!transactions) {
        transactions = [[NSMutableArray alloc]init];
        
    }
    
    double  eth_price = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:@"ETH"];

    
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
            
            double  usd_price_from = [[RDTransactionManager sharedTransactionManager] marKetUSDPriceOf:tradeSell.symbol];
            double  price_from = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:tradeSell.symbol];

            
            tradeSell.dollar_rand_rate = [NSString stringWithFormat:@"%f", rate.rate ];
            tradeSell.prim_price_USD = [NSString stringWithFormat:@"%f", usd_price_from];
            tradeSell.prim_price_BTC = [NSString stringWithFormat:@"%f", price_from];
            tradeSell.prim_ZAR = [NSString stringWithFormat:@"%f", usd_price_from * rate.rate];
            tradeSell.prim_price_ETH = [NSString stringWithFormat:@"%f", price_from/eth_price];
            tradeSell.type = @"sell";
          
         
            [transactions addObject:tradeSell];
            
             return tradeSell;
        }
    
    if (type == TransactionTypeBye) {
        RDTrade *tradeBye = transaction;
        
        
        double  usd_price_to = [[RDTransactionManager sharedTransactionManager] marKetUSDPriceOf:tradeBye.symbol];
        double  price_to = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:tradeBye.symbol];

        
        tradeBye.dollar_rand_rate = [NSString stringWithFormat:@"%f", rate.rate ];
        tradeBye.prim_price_USD = [NSString stringWithFormat:@"%f", usd_price_to];
        tradeBye.prim_price_BTC = [NSString stringWithFormat:@"%f", price_to];
        tradeBye.prim_ZAR = [NSString stringWithFormat:@"%f", usd_price_to * rate.rate];
        tradeBye.prim_price_ETH = [NSString stringWithFormat:@"%f", price_to/eth_price];
        

        tradeBye.type = @"bye";
        
        
        [transactions addObject:tradeBye];
        
        return tradeBye;
        
        
    }
    
   // NSDate * date =    [NSDate dateWithTimeIntervalSince1970:[key doubleValue]/1000000];

    
    NSLog(@"transactions %@",transactions);
    
    
    for (id obj in transactions) {
        [RDCryto logObject:obj];
    }
    return nil;
}


-(void)persistTransactionSell:(RDTrade*)sell  bye: (RDTrade*)bye
{
    RDTransaction * trans = [[RDTransaction alloc]init];
    NSString *  dateKey ;
    if (bye.date)
    {
        dateKey = bye.date ;
    }
    else
        if ( sell.date)
        {
            dateKey = sell.date;
        }
        else
    {
        NSDate * date = [NSDate date];
       
        dateKey = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]*1000000];
        bye.date = dateKey;
        sell.date = dateKey;
    }
   
    trans.date = dateKey;
    trans.bye = bye;
    trans.sell = sell;
    [[RDPersistanceManager sharedPersistanceManager] addTransaction:trans];
}



-(double)marKetCap_volume:(NSString*)symbol
{
    NSString *sym = symbol;
    NSLog(@"symbol %@",symbol);
    
    if ([symbol isEqualToString:@"ZAR"]) {
        return  rate.rate;
    }
    
    RDMarketCap *marketCap = [self.marketCaps objectForKey:sym];
    // NSLog(@"marKetPriceOf");
       [RDCryto logObject:marketCap];
    //
        NSLog(@"market_cap_usd %f",[marketCap.market_cap_usd doubleValue]);
    NSLog(@"_24h_volume_usd %f",[marketCap._24h_volume_usd doubleValue]);

    
    return [marketCap.market_cap_usd doubleValue]/ [marketCap._24h_volume_usd doubleValue];
}


-(double)marKetPriceOf:(NSString*)symbol
{
    NSString *sym = symbol;
   // NSLog(@"symbol %@",symbol);
    
    if ([symbol isEqualToString:@"ZAR"]) {
        return  rate.rate;
    }
    RDMarketCap *marketCap = [self.marketCaps objectForKey:sym];
   // NSLog(@"marKetPriceOf");
//    [RDCryto logObject:marketCap];
//
//    NSLog(@"marKetPriceOf %f",[marketCap.price_btc doubleValue]);

    return [marketCap.price_btc doubleValue];
}


-(double)marKetUSDPriceOf:(NSString*)symbol
{
    NSString *sym = symbol;
    NSLog(@"symbol %@",symbol);
   
    
    if ([symbol isEqualToString:@"ZAR"]) {
        return  rate.rate;
    }
    RDMarketCap *marketCap = [self.marketCaps objectForKey:sym];
    NSLog(@"marKetPriceOf");
    [RDCryto logObject:marketCap];
    
    NSLog(@"marKetUSDPriceOf %f",[marketCap.price_usd doubleValue]);
    
    return [marketCap.price_usd doubleValue];
}


-(double)marKetPercentageChangeOf:(NSString*)symbol
{
    NSString *sym = symbol;
    NSLog(@"symbol %@",symbol);
    
    
    if ([symbol isEqualToString:@"ZAR"]) {
        return  rate.rate;
    }
    RDMarketCap *marketCap = [self.marketCaps objectForKey:sym];
    NSLog(@"marKetPriceOf");
    [RDCryto logObject:marketCap];
    
    NSLog(@"marKetUSDPriceOf %f",[marketCap.percent_change_24h doubleValue]);
    
    return [marketCap.percent_change_24h doubleValue];
}





@end
