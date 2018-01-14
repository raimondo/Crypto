//
//  MDProfileVC.m
//  MrDelivery
//
//  Created by Raimondo De Rose on 2015/09/10.
//  Copyright (c) 2015 Mr Delivery. All rights reserved.
//

#import "MDProfileSliderVC.h"
#import "UIView+Animation.h"
#import "AppDelegate.h"

#import "MDProfileSliderCell.h"
#import "RDFiat_InVC.h"

#import "RDTradeVC.h"






@interface MDProfileSliderVC ()
{
    NSArray *tableRows;
    NSArray *tableRowImages;
    UILabel * quantityLabel;
    NSString * quantity;
    UILabel * nameLabel;
    UILabel * emailLabel;
    UIImageView *logoImageView;
    UILabel * versionLabel;
}

@end

@implementation MDProfileSliderVC
@synthesize tableView;
@synthesize tintV;
@synthesize landingImage;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIScreen *screen = [UIScreen mainScreen];
        
      
     /*
        tintV = [[UIView alloc]init];
        tintV.frame= CGRectMake(0, 0,screen.bounds.size.width, screen.bounds.size.height);
        tintV.backgroundColor = [UIColor blackColor];
        tintV.alpha = 0.70f;
        tintV.hidden = YES;
        tintV.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slideOutProfileView)];
        tap.cancelsTouchesInView = YES;
        tap.numberOfTapsRequired = 1;
        tap.delegate = self ;
        [tintV addGestureRecognizer:tap];
        
        [self addSubview:tintV];*/
        
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150,screen.bounds.size.width, screen.bounds.size.height-150) style:UITableViewStylePlain];
        tableView.rowHeight = 64;
        [tableView setAutoresizesSubviews:YES];
        [tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor blackColor];
        [self  addSubview:tableView];
        
     
        
        
        UIButton *closeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton2.frame = CGRectMake(screen.bounds.size.width-50, 20, 50.0, 50.0);
        closeButton2.userInteractionEnabled = YES;
        [closeButton2 setImage:[UIImage imageNamed:@"closeIconWhite"] forState:UIControlStateNormal];
        closeButton2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [closeButton2 addTarget:self action:@selector(slideOutProfileView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton2];
        
       /* UIView *logoBackground2 = [[UIView alloc]initWithFrame:CGRectMake(screen.bounds.size.width*.20, 0, screen.bounds.size.width,100)];
        logoBackground2.backgroundColor = [UIColor grayColor];
        logoBackground2.alpha = 0.1f;
        [self addSubview:logoBackground2];*/
        
       
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(25, 58,(self.bounds.size.width)-50,40);
        nameLabel.textColor =     [UIColor blackColor] ;
        nameLabel.textAlignment = NSTextAlignmentLeft;
       // nameLabel.font =  [UIFont fontWithName:kFontMedium size:32];
        nameLabel.text = @"";
        [self addSubview: nameLabel];
        
        emailLabel = [[UILabel alloc]init];
        emailLabel.frame = CGRectMake(25,102,(self.bounds.size.width)-50,20);
        emailLabel.textColor =     [UIColor blackColor] ;
        emailLabel.textAlignment = NSTextAlignmentLeft;
        //emailLabel.font =  [UIFont fontWithName:kFontRegular size:16];
        emailLabel.text = @"";
        [self addSubview: emailLabel];
        
        versionLabel = [[UILabel alloc]init];
        versionLabel.frame = CGRectMake(25, (tableView.rowHeight *7)+20,self.bounds.size.width-50,20);
        versionLabel.textColor =     [UIColor whiteColor] ;
//        versionLabel.backgroundColor =  kLightGrayColor;
        versionLabel.textAlignment = NSTextAlignmentCenter;
        //versionLabel.font =  [UIFont fontWithName:kFontRegular size:11];
      
        NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSString * versionBuildString = [NSString stringWithFormat:@"Version: %@ (%@) %@", appVersionString, appBuildString,@""];
        versionLabel.text = versionBuildString;
        [tableView addSubview:versionLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLogin) name:@"userLogedInProfileSlider" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLogin) name:@"userLogedInFromLanding" object:nil];
        
        tableRows = @[@"Transact",@"Move",@"Fiat",@"",@""];

        
    }
    return self;
}



-(void)updateLogin
{
    
    //    TODO thse strings need to be changed
   // quantity = [NSString stringWithFormat:@"%d",[MDCartManager getCurrentCart].quantity];
    quantityLabel.text = quantity;
    NSString *signInText = @"Sign out";
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"email"])
    {
        signInText = @"Login";
    }
    tableRows = @[@"Profile",@"Order history",@"Help",@"Terms & Conditions",@"Notifications",signInText,@""];
   
    //  tableRowImages = @[[UIImage imageNamed:@"profileIcon"],[UIImage imageNamed:@"ordersIcon"],[UIImage imageNamed:@"helpIcon"],[UIImage imageNamed:@"termsIcon"],[UIImage imageNamed:@"faqIcon"],[UIImage imageNamed:@"notification icon"],[UIImage imageNamed:@"signIcon"],[UIImage imageNamed:@"profileIcon"]];
    tableRowImages = @[[UIImage imageNamed:@"profileIcon"],[UIImage imageNamed:@"orderIcon"],[UIImage imageNamed:@"helpIcon"],[UIImage imageNamed:@"termsIcon"],[UIImage imageNamed:@"notificationIcon"],[UIImage imageNamed:@"logoutIcon"],[UIImage imageNamed:@"profileIcon"]];

    [self.tableView reloadData];
    
   // NSDictionary * userProfile =  [[MDPersistenceManager sharedPersistenceManager]getUserProfile];
    
//    NSDictionary * profile = userProfile[@"profile"];
//    NSString *userName = @"";
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"email"])
//    {
//        if (profile[@"first_name"])
//        {
//            userName = [NSString stringWithFormat:@"%@ %@",profile[@"first_name"],profile[@"last_name"]];
//        }
//        nameLabel.text = userName;
//        emailLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
//        logoImageView.hidden = YES;
//    }
//    else
//    {
//        nameLabel.text = @"";
//        emailLabel.text =  @"";
//        logoImageView.hidden = NO;
//    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row==2)
    {
        [self slideOutProfileView];
       
        RDFiat_InVC * fiatVC = [[RDFiat_InVC alloc]init];
        
        UINavigationController *navVC = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
        
         [navVC pushViewController:fiatVC animated:YES];


    }
    else
        if (indexPath.row==1)
        {
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"email"])
            {
                [self pushLogin];
            }
            else
            {
                [self slideOutProfileView];
             
            }
        }
        else
            if (indexPath.row==0)
            {
                   [self slideOutProfileView];
                RDTradeVC *tradeVC = [[RDTradeVC alloc]init];
                UINavigationController *navVC = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
                
                [navVC pushViewController:tradeVC animated:YES];
            }
            else
                if (indexPath.row==3)
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.mrdfood.com/appterms"]];
                   // [FIRAnalytics logEventWithName:@"view_tnc_screen" parameters:nil];
                    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

                }
                else
                        if (indexPath.row==4)
                        {
                            [self slideOutProfileView];
                           //MDNotificationsVC * notificationVC = [[MDNotificationsVC alloc]init];
                            UINavigationController *navVCc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
                          // [navVCc pushViewController:notificationVC animated:YES];
                        }
                        else
                        if (indexPath.row==5)
                        {
                            if ([tableRows[5]isEqualToString:@"Login"])
                            {
                                [self slideOutProfileView];
                                [self fadeInLogin];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogedInProfileSlider" object:self userInfo:nil];
                            }
                            else
                            {
                                //[[MDPersistenceManager sharedPersistenceManager]removeUser];
                                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"email"];
                                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"password"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                [self unsubscribeToPush];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogedInProfileSlider" object:self userInfo:nil];
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFindFoodFastButton" object:self userInfo:nil];
                               // [FIRAnalytics logEventWithName:@"log_out" parameters:nil];
                                UINavigationController *navVCc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
                                 [navVCc popToRootViewControllerAnimated:YES];
                                [self updateLogin];
                            }
                        }
}





-(void)slideModalWithView :(UIViewController*)viewC
{
    UINavigationController *navVC = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];
    self.backgroundColor = [UIColor clearColor];
    [navVC presentViewController:viewC animated:YES completion:nil];
}




-(void)unsubscribeToPush
{
    NSString *userId = [NSString stringWithFormat:@"user_%d", [[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]intValue]];
    NSLog(@"                                                                                         UN-SUBSCRIBING %@",userId);
    //Firebase Push
   // [[FIRMessaging messaging] unsubscribeFromTopic:[NSString stringWithFormat:@"/topics/%@",userId]];
    
    [self performSelector:@selector(unSubscribeToMarketingAterDelay) withObject:nil afterDelay:4];
}



-(void)unSubscribeToMarketingAterDelay
{
   // [[FIRMessaging messaging] unsubscribeFromTopic:[NSString stringWithFormat:@"/topics/marketing"]];
    NSLog(@"                                                                                         UN-SUBSCRIBING marketing");
    [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"promNotificationsOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




-(void)pushLogin
{
    [self slideOutProfileView];
    [self fadeInLogin];
}



-(void)fadeInLogin
{
//    MDLoginVC * loginVC = [[MDLoginVC alloc]init];
//    loginVC.transitionFrom = @"MDProfileSliderVC";
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    UINavigationController *navVC = [(AppDelegate *)[[UIApplication sharedApplication] delegate] navVC];

    [navVC.view.layer addAnimation:transition forKey:kCATransition];
    [self slideOutProfileView];
    //[navVC pushViewController:loginVC animated:NO];
}




#pragma mark - Slider Animations




-(void)slideInProfileView
{
    //[self updateLogin];
    [self moveTo:CGPointMake(0,0) duration:0.3 option:UIViewAnimationOptionCurveEaseInOut completion:^(BOOL finished) {tintV.hidden = NO;}];
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  // [FIRAnalytics logEventWithName:@"view_side_nav" parameters:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideButton" object:nil userInfo:nil];

}



-(void)slideOutProfileView;
{
    UIScreen *screen = [UIScreen mainScreen];
    [self moveTo:CGPointMake(screen.bounds.size.width,0) duration:0.3 option:UIViewAnimationOptionCurveEaseInOut];
    tintV.hidden = YES;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableRows.count;
}



- (UITableViewCell *)tableView:(UITableViewCell *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
        MDProfileSliderCell *cell = (MDProfileSliderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[MDProfileSliderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
           
        }
            [cell.icon setImage: [tableRowImages objectAtIndex:indexPath.row]];
    
    if (indexPath.row==6) {
        cell.icon.hidden = YES;
        cell.line.hidden = YES;
    }
    else
    {
        cell.icon.hidden = NO;
        cell.line.hidden = NO;
    }
    

    cell.txtLabel.text = [tableRows objectAtIndex:indexPath.row];
    return cell;
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"userLogedInFromLanding" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"userLogedInProfileSlider" object:nil];
}



@end
