//
//  ViewController.h
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/25.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *cryptos;
}

@property (nonatomic,strong)NSArray *cryptos;


@end

