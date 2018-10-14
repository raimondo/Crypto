//
//  RDTransactionVC.m
//  Cryto
//
//  Created by Ray de Rose on 2018/02/03.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTransactionVC.h"
#import "ViewController.h"
#import "RDCryto.h"
#import "RDExchangeRate.h"
#import "RDApiRateManager.h"
#import "RDLunoRate.h"
#import "RDMarketCap.h"
#import "RDApiCryptoManager.h"
#import "AppDelegate.h"
#import "RDPersistanceManager.h"
#import "RDTradeCell.h"
#import "RDTradeVC.h"

#import "RDTransactionManager.h"

@interface RDTransactionVC ()
{
    UITableView  * tableView;
    double exchanceRate;
    double originalExchanceRate;
    double totalPrimaryInvestment;
    UILabel * lunoBTCRateLabel ;
    UILabel * lunoETHRateLabel ;
    RDLunoRate * lunoBTCRate ;
    RDLunoRate * lunoETHRate ;
    double premium ;
}

@property(nonatomic,strong)  NSArray *transactions;


@end

@implementation RDTransactionVC




- (instancetype)initWithTransactions:(NSArray*)transactions
{
    if (!(self = [super init])) { return nil; }
    
    _transactions = transactions;
    
    return self;
}


- (void)loadView {
    [super loadView];
    
    originalExchanceRate = 12.4;
    totalPrimaryInvestment = 0;
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
   
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-160) style:UITableViewStylePlain];
    tableView.rowHeight = 56;
    
    [tableView setAutoresizesSubviews:YES];
    [tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor blackColor];
    [[self view] addSubview:tableView];
    tableView.sectionIndexMinimumDisplayRowCount = 12;
    self.title = @"Crypto's";
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cryptos:) name:@"cryptos" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rates:) name:@"rates" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(marketCap:) name:@"marketCap" object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lunoRate:) name:@"lunoRate" object:nil];
    
 
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    
}


-(void)profileButtonPressed
{
    MDProfileSliderVC *profileVC =  [(AppDelegate *)[[UIApplication sharedApplication] delegate] profileVC];
    [profileVC slideInProfileView];
    
}


-(void)marketCap:(NSNotification*)notification
{
    NSDictionary * note = [notification userInfo];
    
    
    // (D27-C27)/C27*100
    
    if (note[@"marketCap"]) {
        
        NSDictionary *dic = note[@"marketCap"];
        
        //  NSLog(@"dic %@",dic);
        //lunoBTCRateLabel.text =  [NSString stringWithFormat:@"R%.2f",[rate.last_trade doubleValue] ];
        if (dic[@"ETH"]) {
            RDMarketCap *marketCap = dic[@"ETH"];
            
            double premium =   (([lunoETHRate.last_trade doubleValue]*[lunoBTCRate.last_trade doubleValue] ) -   exchanceRate * [marketCap.price_usd doubleValue])/(exchanceRate * [marketCap.price_usd doubleValue])*100;
            
            lunoETHRateLabel.text =  [NSString stringWithFormat:@"R %.2f  (%.2f)  ETH",[lunoBTCRate.last_trade doubleValue] *[lunoETHRate.last_trade doubleValue] ,premium];
        }
        
        if (dic[@"BTC"]) {
            RDMarketCap *marketCap = dic[@"BTC"];
            
            
            premium =   (([lunoBTCRate.last_trade doubleValue] ) -   exchanceRate * [marketCap.price_usd doubleValue])/(exchanceRate * [marketCap.price_usd doubleValue])*100;
            
            lunoBTCRateLabel.text =  [NSString stringWithFormat:@"R %.2f  (%.2f)  BTC",[lunoBTCRate.last_trade doubleValue] ,premium];
            
            
        }
    }
    
    [tableView reloadData];
    
    
}


-(void)lunoRate:(NSNotification*)notification
{
    NSDictionary * note = [notification userInfo];
    
    
    
    if (note[@"XBTZAR"]) {
        lunoBTCRate = note[@"XBTZAR"];
        // lunoBTCRateLabel.text =  [NSString stringWithFormat:@"R%.2f",[lunoBTCRate.last_trade doubleValue] ];
        
    }
    if (note[@"ETHXBT"]) {
        lunoETHRate = note[@"ETHXBT"];
        //lunoETHRateLabel.text =  [NSString stringWithFormat:@"R%.2f",[lunoBTCRate.last_trade doubleValue] *[lunoETHRate.last_trade doubleValue] ];
        
        [RDApiCryptoManager fetchMarketCap];
        
    }
    // self.title = [NSString stringWithFormat:@"R%.2f",[rate.last_trade doubleValue] ];
    
}


-(void)rates:(NSNotification*)notification
{
    NSDictionary * note = [notification userInfo];
    RDExchangeRate * rate = note[@"rates"];
    exchanceRate = rate.rate;
    
    if (totalPrimaryInvestment>0)
    {
        self.title = [NSString stringWithFormat:@"R%.2f",totalPrimaryInvestment-65000 ];
        NSLog(@"exchanceRate %f",exchanceRate);
    }
    [tableView reloadData];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _transactions.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (nonnull RDTradeCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    RDTradeCell *cell = (RDTradeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[RDTradeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor greenColor];
        cell.textLabel.textColor = [UIColor blueColor];
    }
    RDTrade * trade = [_transactions objectAtIndex:indexPath.row];
    cell.textLabel.text =trade.type;
    
    NSLog(@"[lunoBTCRate.last_trade doubleValue]  %f",[lunoBTCRate.last_trade doubleValue] );
    
    double averagePrice = ([trade.prim_ZAR doubleValue] *[trade.quantity doubleValue]  ) ;
    cell.detailTextLabel.text =   [NSString stringWithFormat:@"R%.2f",averagePrice ];// * [lunoBTCRate.last_trade doubleValue]  ];
    
   cell.percentLabel.text = [NSString stringWithFormat:@"%@",trade.quantity ];
    cell.volLabel.text =  [NSString stringWithFormat:@"%.2f", [trade.prim_ZAR doubleValue] ];
//    if ([crypto.priceChangePercent rangeOfString:@"-"].location == NSNotFound) {
        cell.percentLabel.textColor = [UIColor greenColor];
        cell.volLabel.textColor = [UIColor greenColor];
//    }
//    else
//    {
//        cell.percentLabel.textColor = [UIColor redColor];
//        cell.volLabel.textColor = [UIColor redColor];
   // }
//    NSLog(@"crypto.primaryPriceInZAR %f",crypto.primaryPriceInZAR/crypto.transactions.count);
//    NSLog(@"market price %f",[[RDTransactionManager sharedTransactionManager] marKetPriceOf:crypto.symbol]*exchanceRate);
    
//    if ( averagePrice <= ([[RDTransactionManager sharedTransactionManager] marKetPriceOf:crypto.symbol]*exchanceRate)/crypto.quantity) {
       // cell.detailTextLabel.textColor = [UIColor greenColor];
//    }
//    else
//        cell.detailTextLabel.textColor = [UIColor redColor];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDTrade * selected_trade = [_transactions objectAtIndex:indexPath.row];
    
    RDTrade *byeTrade;
    RDTrade *sellTrade;
    for (RDTrade *trade in _transactions) {
        if (selected_trade.date == trade.date) {
            if ([trade.type isEqualToString:@"bye"]) {
                byeTrade = trade;
            }
            if ([trade.type isEqualToString:@"sell"]) {
                sellTrade = trade;
            }
        }
    }
    
//    [RDCryto logObject:sellTrade];
//    [RDCryto logObject:byeTrade];
    
   
    RDTransaction * trans = [[RDPersistanceManager sharedPersistanceManager]getTransaction:selected_trade.date];
     [RDCryto logObject:trans];
    RDTradeVC * tradeVC = [[RDTradeVC alloc]initTransaction:trans];
     [self.navigationController pushViewController:tradeVC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
