//
//  RDCryto.h
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/25.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDCryto : NSObject


@property (nonatomic, copy) NSString* symbol;

@property (nonatomic, copy) NSString* price;

@property (nonatomic, copy) NSString* lastPrice;

@property (nonatomic, copy) NSString* priceChangePercent;

@property (nonatomic) double priceChangeDouble;

@property (nonatomic) double primaryInvestment;

@property (nonatomic) double quantity;

@property (nonatomic)double currentExchangedValue;




+(RDCryto*)parseCryptoDTOToModel:(NSDictionary*)dic;


+(void)logObject:(id)object;


//askPrice = "0.05203000";
//askQty = "5.44800000";
//bidPrice = "0.05200000";
//bidQty = "2043.32100000";
//closeTime = 1514206915711;
//count = 265924;
//firstId = 9847436;
//highPrice = "0.05277000";
//lastId = 10113359;
//lastPrice = "0.05200000";
//lastQty = "0.01600000";
//lowPrice = "0.04790000";
//openPrice = "0.04841300";
//openTime = 1514120515711;
//prevClosePrice = "0.04836500";
//priceChange = "0.00358700";
//priceChangePercent = "7.409";
//quoteVolume = "12542.85558199";
//symbol = ETHBTC;
//volume = "248552.44100000";
//weightedAvgPrice = "0.05046362";

@end
