//
//  RDMarketCap.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/07.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDMarketCap.h"
#import <objc/runtime.h>
#import "RDTransactionManager.h"


@implementation RDMarketCap


+(RDMarketCap*)parseMarketCapDTOToModel:(NSDictionary*)dic
{
    RDMarketCap * crypto = [[RDMarketCap alloc]init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([RDMarketCap class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        //NSLog(@"key %@ %@",key,dic[@"name"]);
        if ([key isEqualToString:@"_24h_volume_usd"]) {
            
            
            [crypto setValue:dic[@"24h_volume_usd"] forKey:@"_24h_volume_usd"];
        }
        else
        
            [crypto setValue:dic[key] forKey:key];
       
    }
    
    free(properties);
    return crypto;
}






@end
