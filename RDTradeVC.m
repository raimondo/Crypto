//
//  RDTradeVC.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/14.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTradeVC.h"
#import "AppDelegate.h"
#import "RDTransactionManager.h"
#import "RDPersistanceManager.h"


@interface RDTradeVC ()
{
   UITextField * fromTextField;
    UITextField * locationTextField ;
     UITextField * toTextField ;
     UITextField * priceTextField ;
     UITextField * fromAmountTextField ;
    UITextField * toAmountTextField ;
    UITextField *exchangePriceTextField;
    UILabel * currencyLabel;
    BOOL ETHon;
    double exchangePrice ;
    BOOL rateChanged;
    BOOL isEdit;
}

@property(nonatomic,strong) RDTrade *byeTrade;
@property(nonatomic,strong) RDTrade *sellTrade;
@property(nonatomic,strong) RDTransaction *transaction;

@end

@implementation RDTradeVC



- (instancetype)initTransaction:(RDTransaction*)transaction
{
    if (!(self = [super init])) { return nil; }
    
    _byeTrade = transaction.bye;
    _sellTrade = transaction.sell;
    _transaction = transaction;
    isEdit = YES;
    
    return self;
}




- (void)loadView
{
    [super loadView];
    
    if (isEdit) {
        exchangePrice = (_byeTrade)?[_byeTrade.dollar_rand_rate doubleValue]:[_sellTrade.dollar_rand_rate doubleValue];
    }
    else
    exchangePrice = (!ETHon)?[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue]:[[RDTransactionManager sharedTransactionManager].ETHBTCRate doubleValue]*[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue];
    
    exchangePriceTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,66,self.view.bounds.size.width/2  - 40, 40)];
    exchangePriceTextField.tag = 0;
    exchangePriceTextField.textColor = [UIColor cyanColor];
    exchangePriceTextField.backgroundColor = [UIColor clearColor];
    fromTextField.placeholder = [NSString stringWithFormat:@"%f", exchangePrice];
    exchangePriceTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%f", [RDTransactionManager sharedTransactionManager].rate.rate] attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //fromTextField.text = altNo;
    exchangePriceTextField.keyboardType = UIKeyboardTypeDefault;
    exchangePriceTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    exchangePriceTextField.returnKeyType =  UIReturnKeyDone;
    exchangePriceTextField.delegate = self;
    exchangePriceTextField.font =  [UIFont systemFontOfSize:13]  ;
    [self.view addSubview:exchangePriceTextField];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    fromTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,106,self.view.bounds.size.width/2  - 40, 40)];
    fromTextField.tag = 1;
    fromTextField.textColor = [UIColor cyanColor];
    fromTextField.backgroundColor = [UIColor clearColor];
    //fromTextField.placeholder = @"Add alternative number";
    fromTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"From" attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //fromTextField.text = altNo;
    if (_sellTrade) {
        fromTextField.text = _sellTrade.symbol;
    }
    
    fromTextField.keyboardType = UIKeyboardTypeDefault;
    fromTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    fromTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    fromTextField.returnKeyType =  UIReturnKeyDone;
    fromTextField.delegate = self;
    fromTextField.font =  [UIFont systemFontOfSize:13]  ;
    [self.view addSubview:fromTextField];
    
    
    fromAmountTextField = [[UITextField alloc] initWithFrame:CGRectMake(20+self.view.bounds.size.width/2,106,self.view.bounds.size.width/2  - 40, 40)];
    fromAmountTextField.tag = 2;
    fromAmountTextField.textColor = [UIColor cyanColor];
    fromAmountTextField.backgroundColor = [UIColor clearColor];
    //fromAmountTextField.placeholder = @"Add alternative number";
    fromAmountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Amount" attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //fromAmountTextField.text = altNo;
    fromAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    fromAmountTextField.returnKeyType =  UIReturnKeyDone;
    fromAmountTextField.delegate = self;
    fromAmountTextField.font =  [UIFont systemFontOfSize:13];
    
    if (_sellTrade) {
        fromAmountTextField.text =  _sellTrade.quantity;
    }
    
    [self.view addSubview:fromAmountTextField];
    
    
    toTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,146,self.view.bounds.size.width  - 40, 40)];
    toTextField.tag = 3;
    toTextField.textColor = [UIColor cyanColor];
    toTextField.backgroundColor = [UIColor clearColor];
    //toTextField.placeholder = @"Add alternative number";
    toTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"To" attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //toTextField.text = altNo;
    if (_byeTrade) {
        toTextField.text = _byeTrade.symbol;
    }
    toTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    toTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    //toTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    toTextField.returnKeyType =  UIReturnKeyDone;
    toTextField.delegate = self;
    toTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:toTextField];
    
    
    toAmountTextField = [[UITextField alloc] initWithFrame:CGRectMake(20+self.view.bounds.size.width/2,146,self.view.bounds.size.width/2  - 40, 40)];
    toAmountTextField.tag = 4;
    toAmountTextField.textColor = [UIColor cyanColor];
    toAmountTextField.backgroundColor = [UIColor clearColor];
    //toAmountTextField.placeholder = @"Add alternative number";
    toAmountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Amount" attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //toAmountTextField.text = altNo;
    toAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    toAmountTextField.returnKeyType =  UIReturnKeyDone;
    toAmountTextField.delegate = self;
    if (_byeTrade) {
        toAmountTextField.text =  _byeTrade.quantity;
    }
    toAmountTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:toAmountTextField];
    
    
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,190,self.view.bounds.size.width  - 40, 40)];
    priceTextField.tag = 5;
    priceTextField.textColor = [UIColor cyanColor];
    priceTextField.backgroundColor = [UIColor clearColor];
    //priceTextField.placeholder = @"Add alternative number";
    priceTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //priceTextField.text = altNo;
    priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    priceTextField.returnKeyType =  UIReturnKeyDone;
    priceTextField.delegate = self;
    priceTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:priceTextField];
    
    
//    UISwitch * notificationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20+self.view.bounds.size.width/2,196,100, 40)];
//    [notificationSwitch addTarget: self action: @selector(switchPromoFlip) forControlEvents:UIControlEventValueChanged];
//    notificationSwitch.on =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"promNotificationsOn" ]boolValue];
//    [self.view addSubview:notificationSwitch];
//
//
//    currencyLabel = [[UILabel alloc]init];
//    currencyLabel.frame = CGRectMake(100+self.view.bounds.size.width/2,196,100, 40);
//    currencyLabel.textColor =    [UIColor cyanColor];
//    //currencyLabel.backgroundColor = [UIColor redColor];
//    currencyLabel.font =   [UIFont systemFontOfSize:13];
//    currencyLabel.highlightedTextColor = [UIColor cyanColor];
//    currencyLabel.adjustsFontSizeToFitWidth = YES;
//    currencyLabel.text = @"BTC";
//    [self.view addSubview:currencyLabel];
    
    
    locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,236,self.view.bounds.size.width  - 40, 40)];
    locationTextField.tag = 6;
    locationTextField.textColor = [UIColor cyanColor];
    locationTextField.backgroundColor = [UIColor clearColor];
    //locationTextField.placeholder = @"Add alternative number";
    locationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: [UIColor cyanColor]}];
    
    //locationTextField.text = @"Location";
    //locationTextField.keyboardType = UIKeyboardTypeNumberPad;
    locationTextField.returnKeyType =  UIReturnKeyDone;
     locationTextField.delegate = self;
    locationTextField.font =  [UIFont systemFontOfSize:13]  ;
    
    NSLog(@"_byeTrade.location %@",_byeTrade.location);
    if (isEdit) {
        locationTextField.text = (_byeTrade)?_byeTrade.location:_sellTrade.location;
    }
    [self.view addSubview:locationTextField];
    // Do any additional setup after loading the view.
     if (_byeTrade && _sellTrade) {
         [self updatePrice];
     }
}


-(void)updatePrice
{
    NSString *toTextFieldtxt = [toTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    double price_to = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:toTextFieldtxt];
    priceTextField.text = [NSString stringWithFormat:@"R %.2f", price_to * [toAmountTextField.text doubleValue]*[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue]];
    
    
    NSLog(@"[toAmountTextField.text %@",toAmountTextField.text);
    
     NSLog(@"BTCZARprice %f",[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue]);
    
}


-(void)switchPromoFlip
{
    if (ETHon) {
         currencyLabel.text = @"BTC";
        ETHon = NO;
    }
    else
    {
        ETHon = YES;
        currencyLabel.text = @"ETH";

    }
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIScreen *screen = [UIScreen mainScreen];
    if ( textField.tag==2)
    {
        NSLog(@"screen.bounds.size.height %f",screen.bounds.size.height);
        
    }
    else
    {
        
    }
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    UIScreen *screen = [UIScreen mainScreen];
    
    
    NSString *fromTextFieldtxt = [fromTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *toTextFieldtxt = [toTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
 
    
    double    price_from = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:fromTextFieldtxt];
    
    double price_to = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:toTextFieldtxt];
    
    
    NSLog(@"textField.tag %ld",(long)textField.tag);
    
    if ( textField.tag==0)
    {
        rateChanged = YES;
    }
    
    if ( textField.tag==1)
    {
        if (screen.bounds.size.height < 667 )
        {
            CGPoint newScrollOrigin = CGPointMake( 0.0,  100);
            // [slidingView setContentOffset:newScrollOrigin animated:YES];
        }
        [toTextField becomeFirstResponder];
    }
    else
        if ( textField.tag==2)
        {
        
    
            
//            if (ETHon)
            
         
            if ([fromTextFieldtxt isEqualToString:@"ZAR"]) {
                 priceTextField.text = [NSString stringWithFormat:@"R %.2f", price_to* exchangePrice];
                toAmountTextField.text =  [NSString stringWithFormat: @"%f",[fromAmountTextField.text doubleValue]/(exchangePrice)];
            }
            else
            {
                
                
               

            
            
            
            
            
            NSLog(@"priceTextField =  (price_to) %f x (toAmountTextField) %@ x (exchangePrice) %f",price_to,toAmountTextField.text,exchangePrice);
            NSLog(@"[fromAmountTextField  %f  =  ( price_to %f / price_from %f ) x  toAmountTextField %@",[toAmountTextField.text doubleValue],price_to,price_from,toAmountTextField.text);
                
                // if (toAmountTextField.text.length == 0|| [toAmountTextField.text doubleValue]==0) {
                toAmountTextField.text =  [NSString stringWithFormat: @"%f",[fromAmountTextField.text doubleValue]/(price_to)];
                // }

            NSLog(@"[rate.rate %f",[RDTransactionManager sharedTransactionManager].rate.rate);
            
            
            NSLog(@"From %@  Amount %@",fromTextField.text,fromAmountTextField.text);
            NSLog(@"To %@ Amount %@",toTextField.text,toAmountTextField.text);
           // NSLog(@"Price %@",price_to* toAmountTextField.text);
                
                 [self updatePrice];

                [locationTextField becomeFirstResponder];
            }
        }
        else
            if ( textField.tag==3)
            {
//                double exchangePrice = (!ETHon)?[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue]:[[RDTransactionManager sharedTransactionManager].ETHBTCRate doubleValue]*[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue];
//
//
//                //            if (ETHon)
//
//                priceTextField.text = [NSString stringWithFormat:@"R %.2f", price_to * [toAmountTextField.text doubleValue]*exchangePrice];
//                 if (fromAmountTextField.text.length == 0 || [fromAmountTextField.text doubleValue]==0) {
//                fromAmountTextField.text = [NSString stringWithFormat:@"%f",(price_to/price_from)*[toAmountTextField.text doubleValue]];
//                 }
                 if (fromAmountTextField.text.length == 0 || [fromAmountTextField.text doubleValue]==0) {
                [fromAmountTextField becomeFirstResponder];
                 }
                else
                    [toAmountTextField becomeFirstResponder];

                
            }
    else
        if ( textField.tag==4) {
          
            
            
            //            if (ETHon)
            
            NSLog(@"fromAmountTextField %@",toAmountTextField.text);
            
            if (fromAmountTextField.text.length == 0 || [fromAmountTextField.text doubleValue]==0) {
                fromAmountTextField.text = [NSString stringWithFormat:@"%f",(price_to/price_from)*[toAmountTextField.text doubleValue]];

            }
            

            
            priceTextField.text = [NSString stringWithFormat:@"R %.2f", price_to * [toAmountTextField.text doubleValue]*[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue]];

            [locationTextField becomeFirstResponder];
        }
    else
        if ( textField.tag==6 )
    {
        
        [textField resignFirstResponder];
        
        if (rateChanged) {
            [RDTransactionManager sharedTransactionManager].rate.rate = [exchangePriceTextField.text doubleValue];
        }
        
         if ([fromTextFieldtxt isEqualToString:@"ZAR"]) {
             
             RDTrade * tradeBye =[[RDTrade alloc]init];
             tradeBye.location = locationTextField.text;
             
             tradeBye.symbol = toTextField.text;
             tradeBye.quantity = toAmountTextField.text;
             tradeBye.prim_price_BTC = [RDTransactionManager sharedTransactionManager].BTCZARprice ;// [NSString stringWithFormat:@"%f", exchangePrice ];
             
             tradeBye.prim_price_ETH = [NSString stringWithFormat:@"%f",[[RDTransactionManager sharedTransactionManager].ETHBTCRate doubleValue]*[[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue]];
             
             tradeBye =   [[RDTransactionManager sharedTransactionManager] addTransaction:TransactionTypeBye transaction:tradeBye];
             
             [[RDTransactionManager sharedTransactionManager]persistTransactionSell:nil bye:tradeBye];
             
         }
        else
        {
            
        
        RDTrade * tradeSell =[[RDTrade alloc]init];
        tradeSell.location = locationTextField.text;
        NSString *symbol = @"BTC";
        if (ETHon) {
            symbol = @"ETH";
        }
        tradeSell.symbol = fromTextField.text;
        tradeSell.quantity = fromAmountTextField.text;
//        tradeSell.prim_price_BTC = [NSString stringWithFormat:@"%f",price_to];
//             tradeSell.prim_price_USD = [NSString stringWithFormat:@"%f",usd_price_to];
        
        
   tradeSell =     [[RDTransactionManager sharedTransactionManager] addTransaction:TransactionTypeSell transaction:tradeSell];
        
        
        
        
        
        
        
        
        RDTrade * tradeBye =[[RDTrade alloc]init];
        tradeBye.location = locationTextField.text;
        
        tradeBye.symbol = toTextField.text;
        tradeBye.quantity = toAmountTextField.text;
//         tradeBye.prim_price_BTC = [NSString stringWithFormat:@"%f",price_from];
//            tradeBye.prim_price_USD = [NSString stringWithFormat:@"%f",usd_price_from];

            NSLog(@"fromAmountTextField %@ priceTextField.text %@",fromAmountTextField.text,priceTextField.text);
     tradeBye =   [[RDTransactionManager sharedTransactionManager] addTransaction:TransactionTypeBye transaction:tradeBye];
        
        
        
        
            if (isEdit) {
                [self editTransaction];
            }
            else
        
        [[RDTransactionManager sharedTransactionManager]persistTransactionSell:tradeSell bye:tradeBye];
        
        }
        UINavigationController *navVCc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
        [navVCc popViewControllerAnimated:YES];
        
    }
    return NO;
}

-(void)editTransaction
{
    _sellTrade.location = locationTextField.text;
      _byeTrade.location = locationTextField.text;
    
    _sellTrade.quantity =  fromAmountTextField.text;
    _byeTrade.quantity =  toAmountTextField.text;
    
    _byeTrade.symbol = toTextField.text;
     _sellTrade.symbol = fromTextField.text;
    
    _sellTrade.dollar_rand_rate = exchangePriceTextField.text ;
    _byeTrade.dollar_rand_rate = exchangePriceTextField.text ;
    
    _transaction.bye = _byeTrade;
    _transaction.sell = _sellTrade;
    
    
    [[RDTransactionManager sharedTransactionManager]persistTransactionSell:_sellTrade bye:_byeTrade];




}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
