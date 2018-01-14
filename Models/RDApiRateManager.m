//
//  RDApiRateManager.m
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/26.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import "RDApiRateManager.h"
#import "RDExchangeRate.h"
#import "RDTransactionManager.h"





@implementation RDApiRateManager

+(void)fetchExchangeRates
{
     NSString*  newString = @"https://api.fixer.io/latest?base=USD";
    NSLog(@"newString %@",newString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:35.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (data) {
                                                        
                                                    
                                                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                    
                                                    NSLog(@"json %@",json);
                                                    
                                                    if (json) {
                                                        NSDictionary *rates = json[@"rates"];
                                                        RDExchangeRate *rate = [RDExchangeRate parseExchabgeRateDTOToModel:[rates[@"ZAR"]doubleValue]];
                                                        [self postCurationRows:rate];
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



+ (void)postCurationRows:(RDExchangeRate*)response
{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.mycompany.myqueue", 0);
    dispatch_async(backgroundQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
          [RDTransactionManager sharedTransactionManager ].rate = response;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rates" object:nil userInfo:@{@"rates" : response}];
        });
    });
}



@end
