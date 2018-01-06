//
//  RDExchangeRate.m
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/26.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import "RDExchangeRate.h"

@implementation RDExchangeRate



+(RDExchangeRate*)parseExchabgeRateDTOToModel:(double)rate
{
    RDExchangeRate * exRate = [[RDExchangeRate alloc]init];
    exRate.symbol = @"R";
    exRate.rate = rate;
    return exRate;
}

@end
