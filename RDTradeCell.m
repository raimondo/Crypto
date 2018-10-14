//
//  RDTradeCell.m
//  Cryto
//
//  Created by Ray de Rose on 2018/01/28.
//  Copyright © 2018 Ray de Rose. All rights reserved.
//

#import "RDTradeCell.h"

@implementation RDTradeCell
@synthesize percentLabel;
@synthesize volLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIScreen *screen = [UIScreen mainScreen];
        self.percentLabel = [[UILabel alloc]init];
        self.percentLabel.frame = CGRectMake(screen.bounds.size.width/2 - 100,17,100,  20);
        self.percentLabel.textColor =     [UIColor blackColor] ;
        self.percentLabel.font =  [UIFont systemFontOfSize:12];
        [self addSubview:self.percentLabel];
        
        self.volLabel = [[UILabel alloc]init];
        self.volLabel.frame = CGRectMake(screen.bounds.size.width/2,17,100,  20);
        self.volLabel.textColor =     [UIColor blackColor] ;
        self.volLabel.font =  [UIFont systemFontOfSize:12];
        [self addSubview:self.volLabel];
        
    }
    
    
    return self;
}

@end
