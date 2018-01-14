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
    RDTransaction * crypto = [[RDTransaction alloc]init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([RDTransaction class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        [crypto setValue:dic[key] forKey:key];
    }
    
    free(properties);
    return crypto;
}

@end
