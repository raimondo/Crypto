//
//  RDLunoRate.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/07.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDLunoRate : NSObject


@property (nonatomic, copy) NSString* pair;

@property (nonatomic, copy) NSString* last_trade;

@property (nonatomic, copy) NSString* rolling_24_hour_volume;


+(RDLunoRate*)parseLunoRatesDTOToModel:(NSDictionary*)dic;


//timestamp: 1515335817534,
//bid: "222800.00",
//ask: "222801.00",
//last_trade: "222801.00",
//rolling_24_hour_volume: "454.821703",
//pair: "XBTZAR"

//timestamp: 1515336735328,
//bid: "0.0648",
//ask: "0.0649",
//last_trade: "0.0648",
//rolling_24_hour_volume: "5049.09",
//pair: "ETHXBT"

@end
