//
//  RDCryto.m
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/25.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import "RDCryto.h"
#import <objc/runtime.h>
#import "RDTransaction.h"


@implementation RDCryto


+(RDCryto*)parseCryptoDTOToModel:(NSDictionary*)dic
{
        RDCryto * crypto = [[RDCryto alloc]init];
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([RDCryto class], &count);
        for (int i = 0; i < count; i++)
        {
            NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            
            if (![key isEqualToString:@"priceChangeDouble"]&& ![key isEqualToString:@"primaryPriceInUSD"] && ![key isEqualToString:@"primaryPriceInZAR"] && ![key isEqualToString:@"primaryPriceInBTC"] && ![key isEqualToString:@"quantity"] && ![key isEqualToString:@"currentExchangedValue"]  && ![key isEqualToString:@"marketCap_volume"]  && ![key isEqualToString:@"transactions"] ) {
                [crypto setValue:dic[key] forKey:key];

            }
            
        }
    
        free(properties);
    
    //[self logObject:crypto];
        return crypto;
}


+(void)logObject:(id)object
{
    NSLog(@"========================= %@ =========================",[object description]);
//    MDLog(@"%@",object);
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSLog(@"%@ = %@",key ,[object valueForKey:key]);
        
        if ([key isEqualToString:@"bye"]) {
            if ([object valueForKey:key]) {
                [self logObject:[object valueForKey:key]];
            }
        }
        if ([key isEqualToString:@"sell"]) {
            if ([object valueForKey:key]) {
                [self logObject:[object valueForKey:key]];

            }
        }
        if ([key isEqualToString:@"transactions"]) {
            NSArray * transactions = [object valueForKey:key];
            for (RDTransaction * trans in transactions) {
                [self logObject:trans];
            }
        }
    }
    free(properties);
    NSLog(@"===============================================================");
}

@end
