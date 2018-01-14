//
//  ViewController.m
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/25.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import "ViewController.h"
#import "RDCryto.h"
#import "RDExchangeRate.h"
#import "RDApiRateManager.h"
#import "RDLunoRate.h"
#import "RDMarketCap.h"
#import "RDApiCryptoManager.h"
#import "AppDelegate.h"



@interface ViewController ()
{
    UITableView  * tableView;
    double exchanceRate;
    double originalExchanceRate;
     double totalPrimaryInvestment;
    UILabel * lunoBTCRateLabel ;
    UILabel * lunoETHRateLabel ;
     RDLunoRate * lunoBTCRate ;
     RDLunoRate * lunoETHRate ;
}



@end

@implementation ViewController

@synthesize cryptos;



- (void)loadView {
    [super loadView];
    
    originalExchanceRate = 12.4;
    totalPrimaryInvestment = 0;
    // Do any additional setup after loading the view, typically from a nib.
    
    

    
    
     lunoBTCRateLabel = [[UILabel alloc]init];
    lunoBTCRateLabel.frame = CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, 20);
    lunoBTCRateLabel.textAlignment = NSTextAlignmentCenter;
    lunoBTCRateLabel.textColor = [UIColor cyanColor];
    [self.view addSubview:lunoBTCRateLabel];
    
    lunoETHRateLabel = [[UILabel alloc]init];
    lunoETHRateLabel.textAlignment = NSTextAlignmentCenter;
     lunoETHRateLabel.textColor = [UIColor magentaColor];
    lunoETHRateLabel.frame = CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 20);
    [self.view addSubview:lunoETHRateLabel];
    

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
    
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cryptos:) name:@"cryptos" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rates:) name:@"rates" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(marketCap:) name:@"marketCap" object:nil];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lunoRate:) name:@"lunoRate" object:nil];
    
    UIButton * profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    profileButton.frame = CGRectMake(self.view.bounds.size.width - 50, 60 , 50,50);
    [profileButton setImage:[UIImage imageNamed:@"menuIconW"] forState:UIControlStateNormal];
    profileButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [profileButton addTarget:self action:@selector(profileButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    profileButton.backgroundColor = [UIColor greenColor];
    
    UINavigationController *navVC = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];

    [self.view addSubview:profileButton];

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
        
        NSLog(@"dic %@",dic);
        //lunoBTCRateLabel.text =  [NSString stringWithFormat:@"R%.2f",[rate.last_trade doubleValue] ];
        if (dic[@"ETH"]) {
            RDMarketCap *marketCap = dic[@"ETH"];
            
            double premium =   (([lunoETHRate.last_trade doubleValue]*[lunoBTCRate.last_trade doubleValue] ) -   exchanceRate * [marketCap.price_usd doubleValue])/(exchanceRate * [marketCap.price_usd doubleValue])*100;
            
             lunoETHRateLabel.text =  [NSString stringWithFormat:@"R %.2f  (%.2f)  ETH",[lunoBTCRate.last_trade doubleValue] *[lunoETHRate.last_trade doubleValue] ,premium];
        }
        
        if (dic[@"BTC"]) {
            RDMarketCap *marketCap = dic[@"BTC"];
            
            
            double premium =   (([lunoBTCRate.last_trade doubleValue] ) -   exchanceRate * [marketCap.price_usd doubleValue])/(exchanceRate * [marketCap.price_usd doubleValue])*100;
            
            lunoBTCRateLabel.text =  [NSString stringWithFormat:@"R %.2f  (%.2f)  BTC",[lunoBTCRate.last_trade doubleValue] ,premium];
            
            
        }
    }
  
    
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


-(void)cryptos:(NSNotification*)notification
{
    NSDictionary * note = [notification userInfo];
    cryptos = note[@"cryptos"];
    double total = 0;
    totalPrimaryInvestment = 0;
    for (RDCryto *crypto in cryptos) {
        total += crypto.priceChangeDouble;
        totalPrimaryInvestment += crypto.currentExchangedValue*exchanceRate;
        NSLog(@" symbol %@  rimaryInvestment %f price %@",crypto.symbol,crypto.currentExchangedValue*exchanceRate,crypto.price);
        NSLog(@"totalPrimaryInvestment %f",totalPrimaryInvestment);
    }
    
    self.title = [NSString stringWithFormat:@"R%.2f",totalPrimaryInvestment-65000];
    
    
     [RDApiRateManager fetchExchangeRates];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cryptos.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
         cell.detailTextLabel.textColor = [UIColor greenColor];
         cell.textLabel.textColor = [UIColor blueColor];
    }
    RDCryto * crypto = [cryptos objectAtIndex:indexPath.row];
    cell.textLabel.text =crypto.symbol;
    cell.detailTextLabel.text = crypto.priceChangePercent;
    
     if ([crypto.priceChangePercent rangeOfString:@"-"].location == NSNotFound) {
          cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    else
         cell.detailTextLabel.textColor = [UIColor redColor];
    
   
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
