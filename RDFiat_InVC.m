//
//  RDFiat_InVC.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/13.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//



#import "RDFiat_InVC.h"
#import "AppDelegate.h"
#import "RDTransactionManager.h"
#import "RDFiat_In.h"
#import "RDTrade.h"



@interface RDFiat_InVC ()
{
    UITextField* amountTextField;
    UITextField* locationTextField;
}

@end

@implementation RDFiat_InVC

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,106,self.view.bounds.size.width  - 40, 40)];
    amountTextField.tag = 1;
    amountTextField.textColor = [UIColor blueColor];
    amountTextField.backgroundColor = [UIColor clearColor];
    //amountTextField.placeholder = @"Add alternative number";
    amountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Amount" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];

    //amountTextField.text = altNo;
    amountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    amountTextField.returnKeyType =  UIReturnKeyDone;
    amountTextField.delegate = self;
    amountTextField.font =  [UIFont systemFontOfSize:13]  ;
    [self.view addSubview:amountTextField];
    
    
    locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,146,self.view.bounds.size.width  - 40, 40)];
    locationTextField.tag = 2;
    locationTextField.textColor = [UIColor blueColor];
    locationTextField.backgroundColor = [UIColor clearColor];
    //locationTextField.placeholder = @"Add alternative number";
    locationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    locationTextField.text = @"Luno";
    //locationTextField.keyboardType = UIKeyboardTypeNumberPad;
    locationTextField.returnKeyType =  UIReturnKeyDone;
    locationTextField.delegate = self;
    locationTextField.font =  [UIFont systemFontOfSize:13]  ;
    [self.view addSubview:locationTextField];
    // Do any additional setup after loading the view.
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
    {
        [textField resignFirstResponder];
        
        RDFiat_In * fiat_In =[[RDFiat_In alloc]init];
        fiat_In.location = locationTextField.text;
        fiat_In.prim_ZAR = amountTextField.text;
        
        [[RDTransactionManager sharedTransactionManager] addTransaction:TransactionTypeFiat_Inn transaction:fiat_In];
        
        
        RDTrade * tradeBye =[[RDTrade alloc]init];
        tradeBye.location = locationTextField.text;
        tradeBye.symbol = @"BTC";
        double btcrate = [[RDTransactionManager sharedTransactionManager].BTCZARprice doubleValue];
        tradeBye.quantity =      [NSString stringWithFormat:@"%f",   [amountTextField.text doubleValue]/  btcrate ];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
