//
//  MDRestaurantManager.m
//  MrDelivery
//
//  Created by Ray de Rose on 2017/10/23.
//  Copyright © 2017 Mr Delivery. All rights reserved.
//

#import "RDApiCryptoManager.h"
#import "RDCryto.h"





@implementation RDApiCryptoManager


+(void)fetchCrypyos
{

    // NSString*  newString = @"https://api.fixer.io/latest?base=USD";
    
    NSString*  newString =   @"https://api.coinmarketcap.com/v1/ticker/?limit=1000";
    
   // NSString*  newString = @"https://api.binance.com//api/v3/ticker/price";
     NSLog(@"newString %@",newString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:35.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (data) {
                                                        
                                                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        
                                                    NSArray *favorites = @[@"BTCUSDT",@"ETHUSDT",@"ICXBTC",@"ICXETH",@"XRPETH"/*,@"XVGBTC"*/,@"DASHBTC",@"QTUMETH",@"LSKETH",@"LTCETH"];
                                                    
                                                     // NSArray *favorites = @[@"BTCUSDT",@"ETHUSDT",@"LTCETH"];
                                                    
                                                    NSDictionary *primaryPrce = @{@"BTCUSDT":@{@"PRIMARYPRICE":[NSNumber numberWithDouble:15800],
                                                                                             //  @"QUANTITY":[NSNumber numberWithDouble:0.082789],
                                                                                               @"QUANTITY":[NSNumber numberWithDouble:0.1011],
                                                                                                   @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:15800],},
                                                                                  
                                                                                  @"ETHUSDT": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:700],
                                                                                               @"QUANTITY":[NSNumber numberWithDouble:0.4593],
                                                                                                //@"QUANTITY":[NSNumber numberWithDouble:3.2089],
                                                                                               @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:700],},
                                                                                  
                                                                                  @"ICXETH": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:700],
                                                                                               @"QUANTITY":[NSNumber numberWithDouble:66.57],
                                                                                               @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.00563],},

                                                                                  @"ICXBTC": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:15000],
                                                                                               @"QUANTITY":[NSNumber numberWithDouble:53.40],
                                                                                               @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.0004820],},
                                                                                  
//                                                                                  @"ICXBTC": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:15000],
//                                                                                               @"QUANTITY":[NSNumber numberWithDouble:119.85],
//                                                                                               @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.0004301],},

                                                                                  @"XRPETH":   @{@"PRIMARYPRICE":[NSNumber numberWithDouble:700],
                                                                                                 @"QUANTITY":[NSNumber numberWithDouble:207],
                                                                                                  @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.00146701],},

                                                                                  @"XVGBTC": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:15800],
                                                                                               @"QUANTITY":[NSNumber numberWithDouble:1903],
                                                                                               @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.00000931],},

                                                                                  @"DASHBTC": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:15800],
                                                                                                @"QUANTITY":[NSNumber numberWithDouble:0.46353600],
                                                                                                @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.074788],},

                                                                                  @"QTUMETH": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:700],
                                                                                                @"QUANTITY":[NSNumber numberWithDouble:3.04],
                                                                                                @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.066678],},

                                                                                  @"LSKETH": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:700],
                                                                                               @"QUANTITY":[NSNumber numberWithDouble:10.31],
                                                                                               @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.029501],},
                                                                                  
                                                                                  @"LTCETH": @{@"PRIMARYPRICE":[NSNumber numberWithDouble:700],
                                                                                                @"QUANTITY":[NSNumber numberWithDouble:1.934054],
                                                                                                @"PRIMARYPRICEforOne":[NSNumber numberWithDouble:0.37499]}
                                                                                  
                                                                                  };
                                                    
                                                    if (json) {
                                                        NSArray *crytos = json;
                                                        NSMutableArray * cryptoRows = [[NSMutableArray alloc]init];
                                                        
                                                        double btcUsd = 0;
                                                        double ethUsd = 0;
                                                        
                                                        for (NSDictionary *cryptoDic in crytos)
                                                        {
                                                            RDCryto *cryto = [RDCryto parseCryptoDTOToModel:cryptoDic];
                                                            if ([cryto.symbol isEqualToString:@"BTCUSDT"])
                                                            {
                                                                btcUsd = [cryto.price doubleValue];
                                                            }
                                                            if ([cryto.symbol isEqualToString:@"ETHUSDT"])
                                                            {
                                                                ethUsd = [cryto.price doubleValue];
                                                            }
                                                        }
                                                        
                                                        for (NSDictionary *cryptoDic in crytos)
                                                        {
                                                            RDCryto *cryto = [RDCryto parseCryptoDTOToModel:cryptoDic];
                                                            
                                                            for (NSString * symbol in favorites)
                                                            {
                                                                if ([symbol isEqualToString:cryto.symbol])
                                                                {
                                                                    
                                                                     NSDictionary *CRUPTODIC = primaryPrce[symbol] ;
                                                                    
                                                                    double primaryPriceForOne = ([CRUPTODIC[@"PRIMARYPRICEforOne"] doubleValue]) ;
                                                                      double priceForOne  = ([cryto.price doubleValue]) ;
                                                                   
                                                                    double QUANT = [CRUPTODIC[@"QUANTITY"] doubleValue];
                                                                    cryto.quantity = QUANT;
                                                                    double priceChange =  priceForOne - primaryPriceForOne;
                                                                    
                                                                    double currentCryptoPrice = 0;
                                                                    
                                                                    if ([symbol rangeOfString:@"ETH"].location != NSNotFound)
                                                                    {
                                                                        currentCryptoPrice = ethUsd;
                                                                        NSLog(@"symbol ETH %@",symbol);
                                                                    }
                                                                    else if ([symbol rangeOfString:@"BTC"].location != NSNotFound)
                                                                    {
                                                                        currentCryptoPrice = btcUsd;
                                                                    }
                                                                    
                                                                     if ([cryto.symbol isEqualToString:@"BTCUSDT"]||[cryto.symbol isEqualToString:@"ETHUSDT"])
                                                                         currentCryptoPrice = 1;
                                                                   
                                                                    NSLog(@"currentCryptoPrice %f",currentCryptoPrice);
                                                                    
                                                                    cryto.priceChangePercent = [NSString stringWithFormat:@"R%.2f", (priceChange)*12.6*QUANT*currentCryptoPrice];
                                                                    cryto.priceChangeDouble = (priceChange)*12.6*QUANT*currentCryptoPrice;
                                                                     cryto.primaryInvestment = QUANT*primaryPriceForOne *12.6*currentCryptoPrice;
                                                                       [cryptoRows addObject:cryto];
                                                                    cryto.currentExchangedValue = [cryto.price doubleValue]*QUANT*currentCryptoPrice;
                                                                }
                                                            }
                                                        }
                                                        
                                                        for (RDCryto *crypto in cryptoRows)
                                                        {
                                                            [RDCryto logObject:crypto];
                                                        }
                                                        [self postCurationRows:cryptoRows];
                                                    }
                                                    }
                                                }];
    [dataTask resume];
                                                    
                                                
    
}


+ (void)postDownMode:(NSDictionary*)error
{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.mycompany.myqueue", 0);
    dispatch_async(backgroundQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // [[MDErrorManager sharedErrorManager]checkServerDown:error] ;
        });
    });
}



+ (void)postCurationRows:(NSArray*)response
{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.mycompany.myqueue", 0);
    dispatch_async(backgroundQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cryptos" object:nil userInfo:@{@"cryptos" : response}];
        });
    });
}





@end
