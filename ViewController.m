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



@interface ViewController ()
{
    UITableView  * tableView;
    double exchanceRate;
    double originalExchanceRate;
     double totalPrimaryInvestment;
}



@end

@implementation ViewController

@synthesize cryptos;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    originalExchanceRate = 12.4;
    totalPrimaryInvestment = 0;
    // Do any additional setup after loading the view, typically from a nib.
    

     tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-60) style:UITableViewStylePlain];
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
    
   // self.title = [NSString stringWithFormat:@"R%.2f",totalPrimaryInvestment-65000];
    
    
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
