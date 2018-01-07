//
//  RDLunoRate.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/07.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDLunoRate.h"
#import <objc/runtime.h>


@implementation RDLunoRate


+(RDLunoRate*)parseLunoRatesDTOToModel:(NSDictionary*)dic
{
    RDLunoRate * crypto = [[RDLunoRate alloc]init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([RDLunoRate class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            [crypto setValue:dic[key] forKey:key];
    }
    
    free(properties);
    return crypto;
}

@end
