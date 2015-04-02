//
//  ViewController.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/15.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "ViewController.h"
#import "EasySample.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupView
{
    [self.navigationItem setTitle:@"Main Page"];
    
    //Background
    UIImageView *imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    imgBackground.image = [UIImage imageNamed:@"background_568h.png"];
    [self.view addSubview:imgBackground];
    
    UIButton *barButtonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButtonRight setFrame:CGRectMake (0, 0, 45, 30) ];
    [barButtonRight setBackgroundImage:[[UIImage imageNamed:@"btn_next_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [barButtonRight setBackgroundImage:[[UIImage imageNamed:@"btn_next_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    
    [barButtonRight addTarget:self action:@selector(actionNextPage:) forControlEvents:UIControlEventTouchUpInside];
    barButtonRight.accessibilityLabel = @"mainPageBarRight";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: barButtonRight];
    
    // text
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(0, 70, 320, 400)];
    [text setTextColor:[UIColor blackColor]];
    text.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:text];
    text.accessibilityLabel = @"mainPageText";
    
    return;
    UITextView *text1 = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [text1 setTextColor:[UIColor blackColor]];
    text1.font = [UIFont systemFontOfSize:30];
    [text1 setText:@"hello"];
    [self.view addSubview:text1];
}

- (void) actionNextPage:(id)sender
{
    EasySample *easy = [[EasySample alloc] init];
    [self.navigationController pushViewController:easy animated:YES];
}

@end
