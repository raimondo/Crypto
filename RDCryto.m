//
//  RDCryto.m
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/25.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import "RDCryto.h"
#import <objc/runtime.h>


@implementation RDCryto


+(RDCryto*)parseCryptoDTOToModel:(NSDictionary*)dic
{
        RDCryto * crypto = [[RDCryto alloc]init];
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([RDCryto class], &count);
        for (int i = 0; i < count; i++)
        {
            NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            
            if (![key isEqualToString:@"priceChangeDouble"]&& ![key isEqualToString:@"primaryInvestment"] && ![key isEqualToString:@"quantity"] && ![key isEqualToString:@"currentExchangedValue"] ) {
                [crypto setValue:dic[key] forKey:key];

            }
            
        }
    
        free(properties);
        return crypto;
}


+(void)logObject:(id)object
{
    NSLog(@"========================= logObject =========================");
//    MDLog(@"%@",object);
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSLog(@"%@ = %@",key ,[object valueForKey:key]);
        
        if ([key isEqualToString:@"active_promotion"]) {
            if ([object valueForKey:key]) {
                [self logObject:[object valueForKey:key]];
            }
        }
        if ([key isEqualToString:@"indicators"]) {
            if ([object valueForKey:key]) {
                NSArray *indicators =[object valueForKey:key];
                for (id obj in indicators) {
                    [self logObject:obj];
                }
            }
        }
    }
    free(properties);
    NSLog(@"===============================================================");
}

@end
