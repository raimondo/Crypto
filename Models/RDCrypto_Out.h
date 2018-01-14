//
//  RDCrypto_Out.h
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDCrypto_Out : NSObject


@property (nonatomic, copy) NSString* type;

@property (nonatomic,strong) NSString *symbol;

@property(nonatomic,strong) NSString * quantity;

@property (nonatomic,strong) NSString *location;


@end
