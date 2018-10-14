//
//  RDPersistanceManager.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/21.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDTransaction.h"

@interface RDPersistanceManager : NSObject

+ (RDPersistanceManager *)sharedPersistanceManager;


- (void)addTransaction :(RDTransaction*)transaction;

-(RDTransaction*)getTransaction:(NSString*)key;


-(NSArray*)getCryptos;

@end
