//
//  RDMarketCap.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/07.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDMarketCap : NSObject


//rank = 61;
//"available_supply" = "360482334.0";
//"market_cap_usd" = "589731074.0";
//"price_btc" = "0.00009887";
//"price_usd" = "1.63595";
//name = "Power Ledger";
//symbol = POWR;
//"24h_volume_usd" = "56689800.0";
//"max_supply" = "<null>";
//"percent_change_1h" = "1.14";
//"percent_change_24h" = "7.65";
//"percent_change_7d" = "94.15";
//"total_supply" = "1000000000.0";
//"last_updated" = 1515242955;



@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* symbol;

@property (nonatomic, copy) NSString* price_usd;

@property (nonatomic ,copy) NSString*  rank;

@property (nonatomic, copy) NSString* price_btc;

@property (nonatomic, copy) NSString*  market_cap_usd;

@property (nonatomic, copy) NSString*   _24h_volume_usd;

@property (nonatomic, copy) NSString* max_supply;

@property (nonatomic, copy) NSString*  percent_change_1h;

@property (nonatomic, copy) NSString*  percent_change_24h;

@property (nonatomic, copy) NSString*  percent_change_7d;

@property (nonatomic, copy) NSString*  total_supply;

@property (nonatomic, copy) NSString*  last_updated;


+(RDMarketCap*)parseMarketCapDTOToModel:(NSDictionary*)dic;

@end
