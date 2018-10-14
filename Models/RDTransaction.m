//
//  RDTransaction.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTransaction.h"

#import <objc/runtime.h>


@implementation RDTransaction





+(RDTransaction*)parseTransactionToModel:(NSDictionary*)dic
{
    RDTransaction * transaction = [[RDTransaction alloc]init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([RDTransaction class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        if ([key isEqualToString:@"bye"]) {
            
            NSLog(@"bye %@",[RDTrade parseTradeToModel:dic[@"bye"]] );
            
            transaction.bye = [[RDTrade alloc]init];
            
            [transaction setValue:[RDTrade parseTradeToModel:dic[@"bye"]] forKey:key];
        }
        else
        if ([key isEqualToString:@"sell"]) {
            transaction.sell = [[RDTrade alloc]init];
            [transaction setValue:[RDTrade parseTradeToModel:dic[@"sell"]] forKey:key];
        }
        else
        
        [transaction setValue:dic[key] forKey:key];
    }
    
    free(properties);
    return transaction;
}




+(NSDictionary*)parseTransactionToDic:(RDTransaction*)transaction
{
    NSMutableDictionary * crypto = [[NSMutableDictionary alloc]init];
    
    if (transaction.date)[crypto setObject:transaction.date forKey:@"date"];
    
    if (transaction.type)[crypto setObject:transaction.type forKey:@"type"];
    
    if (transaction.bye)[crypto setObject:[RDTrade parseTradeToDic: transaction.bye] forKey:@"bye"];
    
    if (transaction.sell)[crypto setObject:[RDTrade parseTradeToDic: transaction.sell] forKey:@"sell"];
    
    
    
    return crypto;
    
}

@end
