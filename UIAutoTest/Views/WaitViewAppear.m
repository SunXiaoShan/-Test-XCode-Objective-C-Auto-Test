//
//  WaitViewAppear.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/18.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "WaitViewAppear.h"
#import "AutoDragview.h"

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

@interface WaitViewAppear ()
{
    UILabel *mLabelview;
    UIButton *mButton;
    NSTimer *mTimer;
    int time;
    int time_max;
    
    UIAlertView *mAlert;
    
}
@end

@implementation WaitViewAppear

static int step = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidDisappear:(BOOL)animated
{
    if (mTimer) {
        [mTimer invalidate];
        mTimer = nil;
    }
}

- (void) setupView
{
    [self.navigationItem setTitle:@"WaitViewAppear"];
    
    //Background
    UIImageView *imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    imgBackground.image = [UIImage imageNamed:@"background_568h.png"];
    [self.view addSubview:imgBackground];
    
    UIButton *barButtonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButtonRight setFrame:CGRectMake (0, 0, 45, 30) ];
    [barButtonRight setBackgroundImage:[[UIImage imageNamed:@"btn_next_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [barButtonRight setBackgroundImage:[[UIImage imageNamed:@"btn_next_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    
    [barButtonRight addTarget:self action:@selector(actionNextPage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: barButtonRight];
    barButtonRight.accessibilityLabel = @"WaitViewAppearBarRight";
    
    // label
    time_max = RAND_FROM_TO(3, 5);
    mLabelview = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 310, 100)];
    [mLabelview setTextColor:[UIColor blackColor]];
    [self.view addSubview:mLabelview];
    mLabelview.text = [NSString stringWithFormat:@"Wait time:%d sec", time_max];
    mLabelview.font = [UIFont systemFontOfSize:30];
    
    // button
    mButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70+170, 100, 30)];
    [mButton setTitle:@"Click" forState:UIControlStateNormal];
    [mButton setBackgroundColor:[UIColor redColor]];
    [mButton addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mButton];
    mButton.accessibilityLabel = @"WaitViewAppearButton";
    [mButton setHidden:YES];
    
    step = 0;
    // timer
    time = 0;
    mTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                             target: self
                                           selector: @selector(handleTimer)
                                           userInfo: nil
                                            repeats: YES];
    
    // alert
    mAlert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                        message:@"Messaget"
                                       delegate:self
                              cancelButtonTitle:@"0"
                              otherButtonTitles:@"1", nil];
    
    mAlert.accessibilityLabel = @"alertWaitViewAppear";
    [mAlert setIsAccessibilityElement:YES];
    
}

- (void) actionNextPage:(id)sender
{
    AutoDragview *next = [[AutoDragview alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void) actionClick:(id)sender
{
    [mLabelview setText:@"Button Click ...."];
    
    mTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                              target: self
                                            selector: @selector(handleTimer)
                                            userInfo: nil
                                             repeats: YES];
}

- (void) handleTimer
{
    if (time >= time_max) {
        if (step == 0) {
            [mButton setHidden:NO];
            time = 0;
            time_max = 1;
            
            if (mTimer) {
                [mTimer invalidate];
                mTimer = nil;
            }
            
            step = 1;
            
        } else if (step == 1) {
            
            [mLabelview setText:@"Wait alert view:1 sec"];
            time = 0;
            time_max = 1;
            
            step = 2;
            
        } else if (step == 2) {
            
            mAlert.delegate = self;
            [mAlert show];
            [mTimer invalidate];
            step = 0;
        }
    } else {
        time ++;
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [mLabelview setText:@"alert click ...."];
}

@end
