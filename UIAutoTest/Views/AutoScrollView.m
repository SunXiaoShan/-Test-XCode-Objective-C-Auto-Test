//
//  AutoScrollView.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/15.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "AutoScrollView.h"
#import "AutoTableView.h"

@interface AutoScrollView ()
{
    UIScrollView *mScroll;
}
@end

@implementation AutoScrollView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupView
{
    [self.navigationItem setTitle:@"AutoScrollView"];
    
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
    barButtonRight.accessibilityLabel = @"AutoScrollViewScrollviewBarRight";
    
    // ui view
    mScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, 280, 400)];
    [mScroll setBackgroundColor:[UIColor blueColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 200, 200, 200)];
    [label setTextColor:[UIColor whiteColor]];
    label.text = @"test label";
    [mScroll addSubview:label];
    [mScroll setContentSize:CGSizeMake(400, 900)];
    
    mScroll.contentOffset = CGPointMake(60, 50);
    mScroll.accessibilityLabel = @"AutoScrollViewScrollview";
    label.accessibilityLabel = @"AutoScrollViewLabelView";
    
    [self.view addSubview:mScroll];
}

- (void) actionNextPage:(id)sender
{
    AutoTableView *next = [[AutoTableView alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

@end
