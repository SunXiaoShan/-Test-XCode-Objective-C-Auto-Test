//
//  AutoTableView.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/15.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "AutoTableView.h"
#import "WaitViewAppear.h"

@interface AutoTableView ()
{
    UITableView *mTableView;
    NSMutableArray *arrFirst;
    NSMutableArray *arrSecond;
    UILabel *mLabelView;
}
@end

@implementation AutoTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupData];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupData
{
    arrFirst = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [arrFirst addObject:[NSString stringWithFormat:@"first section cell:%d", i+1]];
    }
    
    arrSecond = [[NSMutableArray alloc] init];
    for (int i=0; i<30; i++) {
        [arrSecond addObject:[NSString stringWithFormat:@"cell:%d", i+1]];
    }
}

- (void) setupView
{
    [self.navigationItem setTitle:@"AutoTableView"];
    
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
    barButtonRight.accessibilityLabel = @"AutoTableViewBarRight";
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 50+10, 310, 400)];
    [self.view addSubview:mTableView];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.accessibilityLabel = @"AutoTableViewTable";
    
    mLabelView = [[UILabel alloc] initWithFrame:CGRectMake(5, 450, 310, 100)];
    [mLabelView setTextColor:[UIColor blackColor]];
    [self.view addSubview:mLabelView];
    mLabelView.text = @"None";
    mLabelView.font = [UIFont systemFontOfSize:30];
}

- (void) actionNextPage:(id)sender
{
    WaitViewAppear *next = [[WaitViewAppear alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - setup table view

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [arrFirst count];
    } else {
        return [arrSecond count];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"ParentalControlDeviceControlDetailRightBarCell";
    static NSString *CellIdentifier2 = @"ParentalControlDeviceControlDetailRightBarCell2";
    
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1];
                [cell setBackgroundColor:[UIColor clearColor]];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            cell.textLabel.text = arrFirst[indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            
            cell.detailTextLabel.text = @"detail";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
            return cell;
        }

            
        case 1:
        {
            AutoTableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                cell = [[AutoTableViewCell alloc] init];
                // [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            cell.mLabel.text = arrSecond[indexPath.row];
            cell.mTextField.accessibilityLabel = @"AutoTableViewTableCellText";
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return nil;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        mLabelView.text = arrFirst[indexPath.row];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *mySectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 50)];
        mySectionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 10, 15, 300, 30)];
        label.numberOfLines = 0;
        [label setFont:[UIFont systemFontOfSize:16]];
        label.text = @"First";
        [label setTextColor:[UIColor blackColor]];
        [mySectionView addSubview:label];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 200, 15, 100, 30)];
        [button setTitle:@"Button" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor blueColor]];
        [mySectionView addSubview:button];
        button.accessibilityLabel = @"AutoTableViewTableCellText";
        return mySectionView;
        
    } else {
        
        UIView *mySectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 50)];
        mySectionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 10, 5, 300, 30)];
        label.numberOfLines = 0;
        [label setFont:[UIFont systemFontOfSize:16]];
        label.text = @"Second";
        [label setTextColor:[UIColor blackColor]];
        [mySectionView addSubview:label];
        
        return mySectionView;
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mTableView.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        SLog(@"[click] ...%d", (int)indexPath.row);
//        
//        [mArrApplicationSelectData removeObjectAtIndex:indexPath.row];
//        
//        [mSubCateoriesTableView beginUpdates];
//        [mSubCateoriesTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [mSubCateoriesTableView endUpdates];
    }
}

- (void) action:(id)sender
{
    mLabelView.text = @"First Header click";
}




@end
