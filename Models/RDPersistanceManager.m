//
//  RDPersistanceManager.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/21.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDPersistanceManager.h"
#import "RDCryto.h"
#import "RDTransactionManager.h"



@implementation RDPersistanceManager

static RDPersistanceManager *sharedPersistanceManager = nil;



+ (RDPersistanceManager *)sharedPersistanceManager
{
    if (sharedPersistanceManager == nil)
    {
        sharedPersistanceManager = [[RDPersistanceManager alloc] init];
    }
    return sharedPersistanceManager;
}


- (void)secureExistingFile:(NSString *)filePath
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil])
        return;
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (![attrs[NSFileProtectionKey] isEqual:NSFileProtectionCompleteUnlessOpen])
    {
        NSDictionary *newAttr = [NSDictionary dictionaryWithObject:NSFileProtectionCompleteUnlessOpen forKey:NSFileProtectionKey];;
        [[NSFileManager defaultManager] setAttributes:newAttr ofItemAtPath:filePath error:&error];
        NSLog(@"SAVED");
        if (error)
        {
            NSLog(@"Failed to set attributes for file %@ with error: %@", filePath, [error localizedDescription]);
        }
    }
}



- (void)writeSecureData:(NSDictionary *)dictionary toFile:(NSString *)filePath
{
    [dictionary writeToFile:filePath atomically:YES];
    NSError *error = nil;
    if (error)
    {
        NSLog(@"Failed to read file %@ with error: %@", filePath, [error localizedDescription]);
    }
    else
    {
        NSLog(@"SECURING");
        [self secureExistingFile:filePath];
    }
}


-(NSDictionary*)getSecureData :(NSString*)file
{
    NSArray* documentPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsPath = [documentPathArray objectAtIndex:0]; //Get the docs directory
    NSString* filePath = [documentsPath stringByAppendingPathComponent:file];
    
    NSMutableDictionary* dictionairy = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if (dictionairy == nil)
    {
        dictionairy = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return  dictionairy ;
}



-(void)removeSecureData :(NSString*)file
{
    NSArray* documentPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsPath = [documentPathArray objectAtIndex:0]; //Get the docs directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* filePath = [documentsPath stringByAppendingPathComponent:file];
    [fileManager removeItemAtPath:filePath error:NULL];
}



- (void) saveSecureData : (NSDictionary*)dictionary toFile:(NSString*)file
{
    NSArray* documentPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsPath = [documentPathArray objectAtIndex:0]; //Get the docs directory
    NSString* filePath = [documentsPath stringByAppendingPathComponent:file];
    [self writeSecureData:dictionary toFile:filePath];
}


- (void)addTransaction :(RDTransaction*)transaction
{
    NSDictionary * transactionsDic =   [self getSecureData:@"transactions"];
    
    NSMutableDictionary *transactionsTempDic  = [[NSMutableDictionary alloc]init];
    if (transactionsDic) {
        transactionsTempDic = [NSMutableDictionary dictionaryWithDictionary:transactionsDic];
    }
    
    [transactionsTempDic setValue:[RDTransaction parseTransactionToDic:transaction] forKey:transaction.date];
    [self saveSecureData:transactionsTempDic toFile:@"transactions"];
    
    NSLog(@"Transactions %@",transactionsTempDic);
}


-(RDTransaction*)getTransaction:(NSString*)key
{
    NSDictionary * transactionsDic =   [self getSecureData:@"transactions"];
    NSDictionary * transactions =  [transactionsDic objectForKey: key];
    
    RDTransaction * transaction = [RDTransaction parseTransactionToModel: transactions];
    
    
    
    RDTrade * byeTrade =  transaction.bye ;
    RDTrade * sellTrade =  transaction.sell ;
    return transaction;
}



//- (NSArray*)getCryptosFromTransactions
//{
//    
//    NSDictionary * transactionsDic =   [self getSecureData:@"transactions"];
//    
//    NSMutableDictionary *transactionsTempDic  = [[NSMutableDictionary alloc]init];
//    if (transactionsDic) {
//        transactionsTempDic = [NSMutableDictionary dictionaryWithDictionary:transactionsDic];
//    }
//    
//    [transactionsTempDic setValue:[RDTransaction parseTransactionToDic:transaction] forKey:transaction.date];
//    [self saveSecureData:transactionsTempDic toFile:@"transactions"];
//    
//    NSLog(@"Transactions %@",transactionsTempDic);
//}



-(NSArray*)getCryptos
{
    NSMutableArray * cryptoArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary * mutDic = [[NSMutableDictionary alloc]init];

    
    
    NSDictionary * transactionsDic =   [self getSecureData:@"transactions"];
    
    NSLog(@"transactionsDic %@",transactionsDic);
    
    NSMutableArray *allKeys = [[transactionsDic allKeys] mutableCopy];
    
    
    for (NSString *key in allKeys) {
        NSDictionary * transactions =  [transactionsDic objectForKey: key];
        
        RDTransaction * transaction = [RDTransaction parseTransactionToModel: transactions];
        
       
        
        RDTrade * byeTrade =  transaction.bye ;
        RDTrade * sellTrade =  transaction.sell ;
        
          if ((byeTrade && mutDic[byeTrade.symbol] )|| ( sellTrade && mutDic[sellTrade.symbol]) )
          {
        
        if (byeTrade && mutDic[byeTrade.symbol] ) {
            RDCryto * crypto = mutDic[byeTrade.symbol];
            crypto.symbol = byeTrade.symbol;
            crypto.quantity = [byeTrade.quantity doubleValue] + crypto.quantity ;
            crypto.currentExchangedValue = [RDTransactionManager sharedTransactionManager ].rate.rate;
            crypto.priceChangePercent = [NSString stringWithFormat:@"%f",[[RDTransactionManager sharedTransactionManager] marKetPercentageChangeOf:crypto.symbol]];
            crypto.marketCap_volume = [[RDTransactionManager sharedTransactionManager] marKetCap_volume:crypto.symbol];

            
            crypto.primaryPriceInBTC +=  [byeTrade.prim_price_BTC doubleValue];
            crypto.primaryPriceInZAR += [byeTrade.prim_ZAR doubleValue];
             crypto.primaryPriceInUSD += [byeTrade.prim_price_USD doubleValue];
            
            crypto.price =   [NSString stringWithFormat:@"R%.2f", crypto.primaryPriceInBTC * crypto.currentExchangedValue *crypto.quantity];
            
            [crypto.transactions addObject:byeTrade];
            
            [mutDic setObject:crypto forKey:crypto.symbol];
        }
        if (sellTrade &&  mutDic[sellTrade.symbol] ) {
            RDCryto * crypto = mutDic[sellTrade.symbol];
            crypto.symbol = sellTrade.symbol;
            crypto.currentExchangedValue = [RDTransactionManager sharedTransactionManager ].rate.rate;
            
            
            
            crypto.quantity =  crypto.quantity - [sellTrade.quantity doubleValue] ;
             crypto.priceChangePercent = [NSString stringWithFormat:@"%f",[[RDTransactionManager sharedTransactionManager] marKetPercentageChangeOf:crypto.symbol]];
            
            
            
            crypto.primaryPriceInBTC +=  [sellTrade.prim_price_BTC doubleValue];
            crypto.primaryPriceInZAR += [sellTrade.prim_ZAR doubleValue];
            crypto.primaryPriceInUSD += [sellTrade.prim_price_USD doubleValue];


            
            
            
            crypto.price =   [NSString stringWithFormat:@"R%.2f", crypto.primaryPriceInBTC * crypto.currentExchangedValue * crypto.quantity ];
            crypto.marketCap_volume = [[RDTransactionManager sharedTransactionManager] marKetCap_volume:crypto.symbol];

            
            [crypto.transactions addObject:sellTrade];

            [mutDic setObject:crypto forKey:crypto.symbol];
        }
          }
        else
        {
            if (byeTrade.symbol) {
                
            
            RDCryto * cryptoBye = [[RDCryto alloc]init];
                cryptoBye.transactions =[[NSMutableArray alloc]init];
                cryptoBye.symbol = byeTrade.symbol;
                cryptoBye.currentExchangedValue = [RDTransactionManager sharedTransactionManager ].rate.rate;
             cryptoBye.priceChangePercent = [NSString stringWithFormat:@"%f",[[RDTransactionManager sharedTransactionManager] marKetPercentageChangeOf:cryptoBye.symbol]];

            
            cryptoBye.quantity +=  [byeTrade.quantity doubleValue] ;
            
                cryptoBye.primaryPriceInBTC +=  [byeTrade.prim_price_BTC doubleValue];
                cryptoBye.primaryPriceInZAR += [byeTrade.prim_ZAR doubleValue];
                cryptoBye.primaryPriceInUSD += [byeTrade.prim_price_USD doubleValue];

            
            cryptoBye.price =   [NSString stringWithFormat:@"R%.2f", cryptoBye.primaryPriceInBTC * cryptoBye.currentExchangedValue * cryptoBye.quantity ];
            cryptoBye.marketCap_volume = [[RDTransactionManager sharedTransactionManager] marKetCap_volume:cryptoBye.symbol];

                [cryptoBye.transactions addObject:byeTrade];

               [mutDic setObject:cryptoBye forKey:byeTrade.symbol];
            
            
            
            }
             if (sellTrade.symbol) {
                 
            RDCryto * cryptoSell = [[RDCryto alloc]init];
            cryptoSell.transactions =[[NSMutableArray alloc]init];

            cryptoSell.symbol = sellTrade.symbol;
            cryptoSell.currentExchangedValue = [RDTransactionManager sharedTransactionManager ].rate.rate;

            
  cryptoSell.priceChangePercent = [NSString stringWithFormat:@"%f",[[RDTransactionManager sharedTransactionManager] marKetPercentageChangeOf:cryptoSell.symbol]];
            
           
            cryptoSell.quantity =  [sellTrade.quantity doubleValue] ;
            
                 cryptoSell.primaryPriceInBTC +=  [sellTrade.prim_price_BTC doubleValue];
                 cryptoSell.primaryPriceInZAR += [sellTrade.prim_ZAR doubleValue];
                 cryptoSell.primaryPriceInUSD += [sellTrade.prim_price_USD doubleValue];


            
            cryptoSell.price =   [NSString stringWithFormat:@"R%.2f", cryptoSell.primaryPriceInBTC * cryptoSell.currentExchangedValue * cryptoSell.quantity ];
                 
            cryptoSell.marketCap_volume = [[RDTransactionManager sharedTransactionManager] marKetCap_volume:cryptoSell.symbol];

                 [cryptoSell.transactions addObject:sellTrade];

                 
            [mutDic setObject:cryptoSell forKey:sellTrade.symbol];
            
            
             }
           
            
        }

        
      
    }
    
    for (RDTransaction * trans in cryptoArray) {
           [RDCryto logObject: trans];
    }
    
    
    NSMutableArray *allKeys2 = [[mutDic allKeys] mutableCopy];
    
    
    for (NSString *key in allKeys2) {
        RDCryto * crypto =  [mutDic objectForKey: key];
        
        [cryptoArray addObject:crypto];
        
   
    }
    
     cryptoArray =   [self arrayByOrderingArray:cryptoArray byKey:@"primaryPriceInBTC" ascending:NO];
    
    
    return cryptoArray;
    
}




//-(NSMutableDictionary*)getCryptos
//{
//    NSMutableArray * cryptoArray = [[NSMutableArray alloc]init];
//
//
//
//     NSDictionary * transactionsDic =   [self getSecureData:@"transactions"];
//
//      NSLog(@"transactionsDic %@",transactionsDic);
//
//    NSMutableArray *allKeys = [[transactionsDic allKeys] mutableCopy];
//
//
//    for (NSString *key in allKeys) {
//        NSDictionary * transactions =  [transactionsDic objectForKey: key];
//        [cryptoArray addObject:transactions];
//    }
//
//    NSMutableDictionary * mutDic = [[NSMutableDictionary alloc]init];
//
//    for (NSDictionary * transaction in cryptoArray) {
//        NSDictionary * tradeBye = transaction[@"bye"] ;
//        NSDictionary * tradeSell = transaction[@"sell"];
//
//        [RDCryto logObject:tradeSell];
//        [RDCryto logObject:tradeBye];
//
//
//        NSMutableDictionary * cryptoByeQuantity ;
//
//        NSMutableDictionary * cryptoSellQuantity ;
//
//        if (mutDic[tradeBye[@"symbol"]]|| mutDic[tradeSell[@"symbol"]])
//        {
//            if (mutDic[tradeBye[@"symbol"]])
//                {
//            double quantity = [[mutDic[tradeBye[@"quantity"]]objectForKey:@"quantity"] doubleValue];
//             //[mutDic setObject:[NSNumber numberWithDouble:[tradeBye[@"quantity"] doubleValue]+quantity] forKey:tradeBye[@"symbol"]];
//
//                    cryptoByeQuantity = [NSMutableDictionary dictionaryWithDictionary: [mutDic objectForKey:mutDic[tradeBye[@"symbol"]]]];
//
//                    [cryptoByeQuantity setObject:[NSNumber numberWithDouble:quantity+[tradeBye[@"quantity"] doubleValue]] forKey:@"quantity"];
//
//                    [mutDic setObject:cryptoByeQuantity forKey:tradeBye[@"symbol"]];
//
//                }
//            if (mutDic[tradeSell[@"symbol"]])
//            {
//                double quantity = [[mutDic[tradeSell[@"symbol"]] objectForKey:@"quantity"] doubleValue];
//               // [mutDic setObject:[NSNumber numberWithDouble:quantity-[tradeSell[@"quantity"] doubleValue]] forKey:tradeSell[@"symbol"]];
//
//                cryptoSellQuantity = [NSMutableDictionary dictionaryWithDictionary: [mutDic objectForKey:mutDic[tradeSell[@"symbol"]]]];
//
//
//                [cryptoSellQuantity setObject:[NSNumber numberWithDouble:quantity-[tradeSell[@"quantity"] doubleValue]] forKey:@"quantity"];
//
//                [mutDic setObject:cryptoSellQuantity forKey:tradeSell[@"symbol"]];
//
//            }
//
//
//
//    }
//        else
//        {
//            NSLog(@"tradeBye quantity %@",[NSNumber numberWithDouble:[tradeBye[@"quantity"] doubleValue]]);
//            NSLog(@"tradeSell quantity %@",[NSNumber numberWithDouble:-[tradeSell[@"quantity"] doubleValue]]);
//            cryptoSellQuantity = [[NSMutableDictionary alloc]init];
//             cryptoByeQuantity = [[NSMutableDictionary alloc]init];
//
//            [cryptoByeQuantity setObject:[NSNumber numberWithDouble:[tradeBye[@"quantity"] doubleValue]] forKey:@"quantity"];
//             [cryptoSellQuantity setObject:[NSNumber numberWithDouble:[tradeSell[@"quantity"] doubleValue]] forKey:@"quantity"];
//
//                [mutDic setObject:cryptoByeQuantity forKey:tradeBye[@"symbol"]];
//
//             [mutDic setObject:cryptoSellQuantity forKey:tradeSell[@"symbol"]];
//
//
//        }
//
//    }
//
//    return mutDic;
//
//}


//+(NSArray*)parseTransactions:(NSDictionary*)dic
//{
//    NSMutableArray * transactionHistoryArray = [[NSMutableArray alloc]init];
//    for(id key in dic)
//    {
//        [transactionHistoryArray addObject:[self parseOrder:dic[key]withKey:key]];
//    }
//    return  [self arrayByOrderingArray:transactionHistoryArray byKey:@"date" ascending:NO];
//}


- (id)arrayByOrderingArray:(NSArray *)array byKey:(NSString *)key ascending:(BOOL)ascending
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[array count]];
    for (id oneObject in array)
        if(oneObject!=nil)
            [ret addObject:oneObject];
    
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    [ret sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    
    return ret;
}





@end
