//
//  RDExchangeRate.h
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/26.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDExchangeRate : NSObject

@property (nonatomic, copy) NSString* symbol;

@property (nonatomic) double rate;


+(RDExchangeRate*)parseExchabgeRateDTOToModel:(double)rate;

@end
