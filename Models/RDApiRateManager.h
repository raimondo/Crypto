//
//  RDApiRateManager.h
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/26.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RDExchangeRate.h"

@interface RDApiRateManager : NSObject



+(void)fetchExchangeRates;

+ (RDExchangeRate *)rate;



@end
