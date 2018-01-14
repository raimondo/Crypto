//
//  RDFiatIn.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDFiat_In : NSObject

@property (nonatomic, copy) NSString* type;

@property (nonatomic,strong) NSString *symbol;

@property (nonatomic,strong) NSString *location;

@property (nonatomic,strong) NSString *prim_price_USD;

//@property (nonatomic,strong) NSString *prim_price_BTC;
//
//@property (nonatomic,strong) NSString *prim_price_ETH;

@property (nonatomic,strong) NSString *dollar_rand_rate;

@property (nonatomic,strong) NSString *prim_ZAR;

@end
