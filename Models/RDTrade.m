//
//  RDCrypto_In.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTrade.h"

#import <objc/runtime.h>


@implementation RDTrade


+(RDTrade*)parseTradeToModel:(NSDictionary*)dic
{
    RDTrade * trade = [[RDTrade alloc]init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([RDTrade class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
       
        
        [trade setValue:dic[key] forKey:key];
    }
    
    free(properties);
    return trade;
}

+(NSDictionary*)parseTradeToDic:(RDTrade*)trade
{
    NSMutableDictionary * crypto = [[NSMutableDictionary alloc]init];
    
    if (trade.type)[crypto setObject:trade.type forKey:@"type"];
    
     if (trade.symbol)[crypto setObject:trade.symbol forKey:@"symbol"];
    
     if (trade.prim_price_USD)[crypto setObject:trade.prim_price_USD forKey:@"prim_price_USD"];
    
     if (trade.prim_price_BTC)[crypto setObject:trade.prim_price_BTC forKey:@"prim_price_BTC"];
    
     if (trade.prim_price_ETH)[crypto setObject:trade.prim_price_ETH forKey:@"prim_price_ETH"];
    
     if (trade.dollar_rand_rate)[crypto setObject:trade.dollar_rand_rate forKey:@"dollar_rand_rate"];
    
     if (trade.prim_ZAR)[crypto setObject:trade.prim_ZAR forKey:@"prim_ZAR"];
    
     if (trade.location)[crypto setObject:trade.location forKey:@"location"];
    
     if (trade.quantity)[crypto setObject:trade.quantity forKey:@"quantity"];
    
     if (trade.date)[crypto setObject:trade.date forKey:@"date"];
    
    
    return crypto;
    
}

@end
