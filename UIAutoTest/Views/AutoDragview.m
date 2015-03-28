//
//  AutoDragview.m
//  UIAutoTest
//
//  Created by Gemtek_Phineas_Huang on 2015/1/18.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import "AutoDragview.h"

#define FIRST_VIEW 11
#define SECOND_VIEW 12
#define THIRD_VIEW 13

@interface AutoDragview ()
{
    UIView * mViewGrid;
    
    UIImageView *firstPieceView;
    UIImageView *secondPieceView;
    UIImageView *thirdPieceView;
    
    CGPoint currentPoint;
    
    float xd;
    float yd;
}
@end

@implementation AutoDragview



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
    [self.navigationItem setTitle:@"AutoDragView"];
    
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
    barButtonRight.accessibilityLabel = @"AutoDragViewBarRight";
    
    // setup view
    firstPieceView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 79, 50, 50)];
    firstPieceView.image = [UIImage imageNamed:@"CyanSquare.png"];
    firstPieceView.tag = FIRST_VIEW;
    [firstPieceView setUserInteractionEnabled:YES];
    [self.view addSubview:firstPieceView];
    firstPieceView.accessibilityLabel = @"blueAutoDragView";
    
    secondPieceView = [[UIImageView alloc] initWithFrame:CGRectMake(115, 79+50+10, 50, 50)];
    secondPieceView.image = [UIImage imageNamed:@"MagentaSquare.png"];
    secondPieceView.tag = SECOND_VIEW;
    [secondPieceView setUserInteractionEnabled:YES];
    [self.view addSubview:secondPieceView];
    secondPieceView.accessibilityLabel = @"redAutoDragView";
    
    thirdPieceView = [[UIImageView alloc] initWithFrame:CGRectMake(215, 400, 50, 50)];
    thirdPieceView.image = [UIImage imageNamed:@"YellowSquare.png"];
    thirdPieceView.tag = THIRD_VIEW;
    [thirdPieceView setUserInteractionEnabled:YES];
    [self.view addSubview:thirdPieceView];
    thirdPieceView.accessibilityLabel = @"yellowAutoDragView";
    
}

- (void) actionNextPage:(id)sender
{
    AutoDragview *next = [[AutoDragview alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark -
#pragma mark - Touch handling
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // If the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition.
    if (gestureRecognizer.view != firstPieceView && gestureRecognizer.view != secondPieceView && gestureRecognizer.view != thirdPieceView) {
        return NO;
    }
    
    // If the gesture recognizers are on different views, don't allow simultaneous recognition.
    if (gestureRecognizer.view != otherGestureRecognizer.view) {
        return NO;
    }
    
    // If either of the gesture recognizers is the long press, don't allow simultaneous recognition.
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    
    return YES;
}

- (IBAction)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

- (IBAction)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (touch.view.tag > 0) {
        
        NSLog(@"point x:%f y:%f", [touch view].frame.origin.x, [touch view].frame.origin.y);
        
        currentPoint = [touch locationInView:[self view]];
        xd = currentPoint.x - [[touch view]center].x;
        yd = currentPoint.y - [[touch view]center].y;
        
        //            CGPoint pt = [[touches anyObject] locationInView:self.view];
        //            currentPoint = pt;
        //            [self.view bringSubviewToFront:self.view];
    }
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (touch.view.tag > 0) {
        [UIView beginAnimations:@"viewMove" context:(__bridge void *)(touch.view)];
        
        CGPoint cp = [touch locationInView:[self view]];
        [[touch view]setCenter:CGPointMake(cp.x-xd, cp.y-yd)];
        
        //        CGPoint pt = [[touches anyObject] locationInView:[touch view]];
        //        CGRect frame = [self.view frame];
        //        frame.origin.x = (pt.x );
        //        frame.origin.y = (pt.y );
        //
        //        touch.view.center = frame.origin;
        //        [UIView commitAnimations];
    }
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
