//
//  RDMarketCap.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/07.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDMarketCap : NSObject


//"24h_volume_usd" = "8241760000.0";
//"available_supply" = "16831750.0";
//id = bitcoin;
//"last_updated" = 1517165966;
//"market_cap_usd" = 197163753150;
//"max_supply" = "21000000.0";
//name = Bitcoin;
//"percent_change_1h" = "-0.13";
//"percent_change_24h" = "1.82";
//"percent_change_7d" = "0.61";
//"price_btc" = "1.0";
//"price_usd" = "11713.8";
//rank = 1;
//symbol = BTC;
//"total_supply" = "16831750.0";




@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* symbol;

@property (nonatomic, copy) NSString* price_usd;

@property (nonatomic ,copy) NSString*  rank;

@property (nonatomic, copy) NSString* price_btc;

@property (nonatomic, copy) NSString*  market_cap_usd;

@property (nonatomic, copy) NSString*  _24h_volume_usd;

@property (nonatomic, copy) NSString* max_supply;

@property (nonatomic, copy) NSString*  percent_change_1h;

@property (nonatomic, copy) NSString*  percent_change_24h;

@property (nonatomic, copy) NSString*  percent_change_7d;

@property (nonatomic, copy) NSString*  total_supply;

@property (nonatomic, copy) NSString*  last_updated;


+(RDMarketCap*)parseMarketCapDTOToModel:(NSDictionary*)dic;

@end
