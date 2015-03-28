//
//  EasySample.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/15.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "EasySample.h"
#import "AutoScrollView.h"

@interface EasySample ()
{
    UILabel *mLabel;
    UITextField *mText;
    UIButton *mBtn;
}
@end

@implementation EasySample

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
    [self.navigationItem setTitle:@"Easy Sample"];
    
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
    barButtonRight.accessibilityLabel = @"EasySampleBarRight";
    
    // setup ui view
    mLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+50, 320, 30)];
    [mLabel setTextColor:[UIColor blackColor]];
    mLabel.text = @"Hello Label";
    [self.view addSubview:mLabel];
    
    mText = [[UITextField alloc] initWithFrame:CGRectMake(0, 70+110, 320, 30)];
    [mText setTextColor:[UIColor blackColor]];
    mText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"NULL" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    [self.view addSubview:mText];
    mText.text = @"";
    mText.accessibilityLabel = @"EasySampleText";
    
    mBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70+170, 100, 30)];
    [mBtn setTitle:@"Button" forState:UIControlStateNormal];
    [mBtn setBackgroundColor:[UIColor redColor]];
    [mBtn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    mBtn.accessibilityLabel = @"EasySampleButton";
    
}

- (void) actionNextPage:(id)sender
{
    AutoScrollView *next = [[AutoScrollView alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void) actionClick:(id)sender
{
    if (mText.text == nil || [mText.text isEqualToString:@""]) {
        mLabel.text = @"string is empty";
    } else {
        mLabel.text = [NSString stringWithFormat:@"%@", mText.text];
    }
}

@end
