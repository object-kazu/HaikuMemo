//
//  KSHelpViewController.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/20.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSHelpViewController.h"
#import "def.h"

#define LISTVIEW_HELP @"listhelp.png"
#define EDITVIEW_HELP @"edithelp.png"
#define ADDVIEW_HELP  @"addhelp.png"
#define HISTORY_HELP  @"historyhelp.png"
#define HELP_MENU     @"helpview.png"

@interface KSHelpViewController ()
@property (nonatomic, retain) UIImageView    *listViewhelp;
@property (nonatomic, retain) UIImageView    *editViewHelp;
@property (nonatomic, retain) UIImageView    *addViewHelp;
@property (nonatomic, retain) UIImageView    *historyHelp;
@property (nonatomic, retain) NSArray        *arrView;
@property (nonatomic) NSInteger              swipCount;
@property (nonatomic, retain) UILabel* pageLabel;

@end

@implementation KSHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect         screen = [UIScreen mainScreen].bounds;
    
    //background
    CGRect         bRect       = CGRectMake(0, 0, screen.size.width, screen.size.height);
    UIImageView    *background = [[UIImageView alloc] initWithFrame:bRect];
    UIImage        *back_img   = [UIImage imageNamed:@"backWashi.png"];
    [background setImage:back_img];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    background = nil;
    back_img   = nil;
    
    //swipe
    _swipCount = 0;
    
    // list view help
    _listViewhelp = [[UIImageView alloc]initWithFrame:CGRectMake(0, NAVIBAR_Height, screen.size.width, screen.size.height - NAVIBAR_Height)];
    UIImage    *img = [UIImage imageNamed:LISTVIEW_HELP];
    _listViewhelp.contentMode = UIViewContentModeCenter;
    [_listViewhelp setImage:img];
    img = nil;
    
    CGRect    rec = CGRectMake(screen.size.width * -1, NAVIBAR_Height, screen.size.width, screen.size.height - NAVIBAR_Height);
    _addViewHelp             = [[UIImageView alloc]initWithFrame:rec];
    img                      = [UIImage imageNamed:ADDVIEW_HELP];
    _addViewHelp.contentMode = UIViewContentModeCenter;
    [_addViewHelp setImage:img];
    img = nil;
    
    _editViewHelp             = [[UIImageView alloc]initWithFrame:rec];
    img                       = [UIImage imageNamed:EDITVIEW_HELP];
    _editViewHelp.contentMode = UIViewContentModeCenter;
    [_editViewHelp setImage:img];
    img = nil;
    
    _historyHelp             = [[UIImageView alloc]initWithFrame:rec];
    img                      = [UIImage imageNamed:HISTORY_HELP];
    _historyHelp.contentMode = UIViewContentModeCenter;
    [_historyHelp setImage:img];
    img = nil;
    
    _arrView = [NSArray arrayWithObjects:
                _listViewhelp,
                _addViewHelp,
                _editViewHelp,
                _historyHelp,
                nil];
    
    //LOG(@"array number: %d", [_arrView count]);
    [self.view addSubview:(UIImageView *)[_arrView objectAtIndex:_swipCount]];
    
    // page label
    CGFloat pageLabel_width = 40;
    CGFloat pageLabel_height = 40;
    self.pageLabel = [UILabel new];
    self.pageLabel.textColor = [UIColor blackColor];
    self.pageLabel.backgroundColor = [UIColor clearColor];
    self.pageLabel.frame = CGRectMake(screen.size.width - pageLabel_width, NAVIBAR_Height, pageLabel_width, pageLabel_height);
    [self.view addSubview:self.pageLabel];
    [self showHelpPageIndex];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    UIImage    *img = [UIImage imageNamed:HELP_MENU];
    [_menuBar setImage:img];
    _menuBar.hidden                 = NO;
    _menuBar.frame                  = CGRectMake(0, 0, _menuBar.image.size.width, _menuBar.image.size.height);
    _menuBar.userInteractionEnabled = YES;
    
    //swip
    UISwipeGestureRecognizer    *swipeGesture =
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self action:@selector(didSwipeMenu:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.menuBar addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    swipeGesture           = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.menuBar addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)didSwipeMenu:(UISwipeGestureRecognizer *)swipe {
    _swipCount++;
    LOG(@"arrView count :%d", [_arrView count]);
    
    if ( _swipCount > [_arrView count] - 1 ) [self back];
    UIImageView    *view = (UIImageView *)[_arrView objectAtIndex:_swipCount];
    [self.view addSubview:view];
    
    CGRect         screen = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.frame = CGRectMake(0, NAVIBAR_Height, screen.size.width, screen.size.height - NAVIBAR_Height);
                     } completion:Nil];

    [self showHelpPageIndex];

}

-(void) showHelpPageIndex{
    self.pageLabel.text = [NSString stringWithFormat:@"%d/4", _swipCount +1 ];
}

- (void)back {
    
    _swipCount = 0;
    if ( ![self isBeingDismissed] ) {
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
