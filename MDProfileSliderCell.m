//
//  MDProfileSliderCell.m
//  MrDelivery
//
//  Created by Ray de Rose on 2016/10/05.
//  Copyright © 2016 Mr Delivery. All rights reserved.
//

#import "MDProfileSliderCell.h"
//#import "Constants.h"
//#import "UIColor+MDIAdditions.h"


@implementation MDProfileSliderCell

@synthesize icon;
@synthesize txtLabel;
@synthesize line;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        UIImage *pinImageYellow = [UIImage imageNamed:@"yellowStatusIcon"];
        icon =[[UIImageView alloc]initWithImage:pinImageYellow ];
        icon.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-54,20, 25,25);
       [self addSubview:icon];
        
        
        UIImage *selectedBackground = [UIImage imageNamed:@"selectedArea"];
       UIImageView * background =[[UIImageView alloc]initWithImage:selectedBackground ];

        self.selectedBackgroundView = background;
        
        
        
         txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 22, [UIScreen mainScreen].bounds.size.width-50, 20)];
        //txtLabel.font = [UIFont fontWithName:kFontRegular size:16];
        txtLabel.textColor = [UIColor whiteColor];
        [self addSubview:txtLabel];
        
        
        line = [[UIView alloc]initWithFrame:CGRectMake(25, 62, [UIScreen mainScreen].bounds.size.width-50, 2)];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        
        self.backgroundColor = [UIColor blackColor];
       // self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
