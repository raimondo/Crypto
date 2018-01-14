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
#import "RDTrade.h"

@interface RDTradeVC ()
{
   UITextField * fromTextField;
    UITextField * locationTextField ;
     UITextField * toTextField ;
     UITextField * priceTextField ;
     UITextField * fromAmountTextField ;
    UITextField * toAmountTextField ;
    UILabel * currencyLabel;
    BOOL ETHon;
}

@end

@implementation RDTradeVC

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    fromTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,106,self.view.bounds.size.width/2  - 40, 40)];
    fromTextField.tag = 1;
    fromTextField.textColor = [UIColor blueColor];
    fromTextField.backgroundColor = [UIColor clearColor];
    //fromTextField.placeholder = @"Add alternative number";
    fromTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"From" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //fromTextField.text = altNo;
    fromTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    fromTextField.returnKeyType =  UIReturnKeyDone;
    fromTextField.delegate = self;
    fromTextField.font =  [UIFont systemFontOfSize:13]  ;
    [self.view addSubview:fromTextField];
    
    
    fromAmountTextField = [[UITextField alloc] initWithFrame:CGRectMake(20+self.view.bounds.size.width/2,106,self.view.bounds.size.width/2  - 40, 40)];
    fromAmountTextField.tag = 3;
    fromAmountTextField.textColor = [UIColor blueColor];
    fromAmountTextField.backgroundColor = [UIColor clearColor];
    //fromAmountTextField.placeholder = @"Add alternative number";
    fromAmountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Amount" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //fromAmountTextField.text = altNo;
    fromAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    fromAmountTextField.returnKeyType =  UIReturnKeyDone;
    fromAmountTextField.delegate = self;
    fromAmountTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:fromAmountTextField];
    
    
    toTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,146,self.view.bounds.size.width  - 40, 40)];
    toTextField.tag = 2;
    toTextField.textColor = [UIColor blueColor];
    toTextField.backgroundColor = [UIColor clearColor];
    //toTextField.placeholder = @"Add alternative number";
    toTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"To" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //toTextField.text = altNo;
    toTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    toTextField.returnKeyType =  UIReturnKeyDone;
    toTextField.delegate = self;
    toTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:toTextField];
    
    
    toAmountTextField = [[UITextField alloc] initWithFrame:CGRectMake(20+self.view.bounds.size.width/2,146,self.view.bounds.size.width/2  - 40, 40)];
    toAmountTextField.tag = 3;
    toAmountTextField.textColor = [UIColor blueColor];
    toAmountTextField.backgroundColor = [UIColor clearColor];
    //toAmountTextField.placeholder = @"Add alternative number";
    toAmountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Amount" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //toAmountTextField.text = altNo;
    toAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    toAmountTextField.returnKeyType =  UIReturnKeyDone;
    toAmountTextField.delegate = self;
    toAmountTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:toAmountTextField];
    
    
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,190,self.view.bounds.size.width  - 40, 40)];
    priceTextField.tag = 3;
    priceTextField.textColor = [UIColor blueColor];
    priceTextField.backgroundColor = [UIColor clearColor];
    //priceTextField.placeholder = @"Add alternative number";
    priceTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //priceTextField.text = altNo;
    priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    priceTextField.returnKeyType =  UIReturnKeyDone;
    priceTextField.delegate = self;
    priceTextField.font =  [UIFont systemFontOfSize:13];
    [self.view addSubview:priceTextField];
    
    
    UISwitch * notificationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20+self.view.bounds.size.width/2,196,100, 40)];
    [notificationSwitch addTarget: self action: @selector(switchPromoFlip) forControlEvents:UIControlEventValueChanged];
    notificationSwitch.on =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"promNotificationsOn" ]boolValue];
    [self.view addSubview:notificationSwitch];
    
    
    currencyLabel = [[UILabel alloc]init];
    currencyLabel.frame = CGRectMake(100+self.view.bounds.size.width/2,196,100, 40);
    currencyLabel.textColor =    [UIColor blueColor];
    //currencyLabel.backgroundColor = [UIColor redColor];
    currencyLabel.font =   [UIFont systemFontOfSize:13];
    currencyLabel.highlightedTextColor = [UIColor blueColor];
    currencyLabel.adjustsFontSizeToFitWidth = YES;
    currencyLabel.text = @"BTC";
    [self.view addSubview:currencyLabel];
    
    
    locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,236,self.view.bounds.size.width  - 40, 40)];
    locationTextField.tag = 4;
    locationTextField.textColor = [UIColor blueColor];
    locationTextField.backgroundColor = [UIColor clearColor];
    //locationTextField.placeholder = @"Add alternative number";
    locationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //locationTextField.text = @"Location";
    //locationTextField.keyboardType = UIKeyboardTypeNumberPad;
    locationTextField.returnKeyType =  UIReturnKeyDone;
     locationTextField.delegate = self;
    locationTextField.font =  [UIFont systemFontOfSize:13]  ;
    [self.view addSubview:locationTextField];
    // Do any additional setup after loading the view.
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
    
    if ( textField.tag==1)
    {
        if (screen.bounds.size.height < 667 )
        {
            CGPoint newScrollOrigin = CGPointMake( 0.0,  100);
            // [slidingView setContentOffset:newScrollOrigin animated:YES];
        }
        [locationTextField becomeFirstResponder];
    }
    else
        if ( textField.tag==3)
        {
            
            NSLog(@"toTextField%@",toTextField.text);
            NSLog(@"fromTextField%@",fromTextField.text);

            
            
            double  price_to ;
            if (ETHon)
                  price_to = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:fromTextField.text];

            else
                price_to = [[RDTransactionManager sharedTransactionManager] marKetPriceOf:toTextField.text];
            
            
           // priceTextField.text = [NSString stringWithFormat:@"%f", price_to  ];
            
            fromAmountTextField.text = [NSString stringWithFormat:@"%f", price_to * [toAmountTextField.text doubleValue]];
            
            priceTextField.text = [NSString stringWithFormat:@"R %.2f", price_to* [toAmountTextField.text doubleValue] *[RDTransactionManager sharedTransactionManager].rate.rate ];
            
        }
    else
        if ( textField.tag==4)
    {
        [textField resignFirstResponder];
        
        RDTrade * tradeSell =[[RDTrade alloc]init];
        tradeSell.location = locationTextField.text;
        NSString *symbol = @"BTC";
        if (ETHon) {
            symbol = @"ETH";
        }
        tradeSell.symbol = symbol;
        tradeSell.quantity = fromAmountTextField.text;
        
        
        [[RDTransactionManager sharedTransactionManager] addTransaction:TransactionTypeSell transaction:tradeSell];
        
        
        
        
        
        
        
        
        RDTrade * tradeBye =[[RDTrade alloc]init];
        tradeBye.location = locationTextField.text;
        
        tradeBye.symbol = toTextField.text;
        tradeBye.quantity = toAmountTextField.text;
        
        [[RDTransactionManager sharedTransactionManager] addTransaction:TransactionTypeBye transaction:tradeBye];
        
        
        
        
        
        
        
        
        
        UINavigationController *navVCc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
        [navVCc popViewControllerAnimated:YES];
        
    }
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
