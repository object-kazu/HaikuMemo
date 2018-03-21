//
//  KSEditViewController.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/08.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSEditViewController.h"

@interface KSEditViewController ()

- (void)haikuDataSet;

@end

@implementation KSEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //keyboard
    [self.kami5text setDelegate:self];
    [self.naka7text setDelegate:self];
    [self.shimo5text setDelegate:self];
    
    // keybord select
    _kami5text.keyboardType  = UIKeyboardTypeDefault;
    _naka7text.keyboardType  = UIKeyboardTypeDefault;
    _shimo5text.keyboardType = UIKeyboardTypeDefault;
    
    //set tag
    _kami5text.tag  = kamiKu;
    _naka7text.tag  = nakaKu;
    _shimo5text.tag = shimoKu;
    
    //textfield mode
    _kami5text.clearButtonMode  = UITextFieldViewModeAlways;
    _naka7text.clearButtonMode  = UITextFieldViewModeAlways;
    _shimo5text.clearButtonMode = UITextFieldViewModeAlways;
    
    [_kami5text becomeFirstResponder];
    
    [self haikuDataSet];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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
    
    swipeGesture           = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeMenu:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.menuBar addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark ---------- swipe ----------

- (void)didSwipeMenu:(UISwipeGestureRecognizer *)swipe {
    
    UIImage        *img       = [UIImage imageNamed:DEFAULTMENU];
    UIImageView    *slideView = [[UIImageView alloc] initWithImage:img];
    CGRect         screen     = [UIScreen mainScreen].bounds;
    slideView.frame = CGRectMake(screen.size.width, 0, img.size.width, img.size.height);
    [_menuBar addSubview:slideView];
    
    if ( swipe.direction == UISwipeGestureRecognizerDirectionRight ) {
        //done
        
        slideView.frame = CGRectMake(-1 * screen.size.width, 0, _menuBar.image.size.width, _menuBar.image.size.height);
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             _menuBar.frame = CGRectMake(screen.size.width, 0, _menuBar.image.size.width, _menuBar.image.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             [self done];
                             _menuBar.hidden = YES;
                             
                         }];
        
    } else if ( swipe.direction == UISwipeGestureRecognizerDirectionLeft ) {
        // back
        
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             _menuBar.frame = CGRectMake(-1 * screen.size.width, 0, _menuBar.image.size.width, _menuBar.image.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             [self back];
                             _menuBar.hidden = YES;
                             
                         }];
        
    }
    
    slideView = nil;
    
}

- (void)haikuDataSet {
    
    if ( _indexPath == nil ) return;
    
    NSArray    *array = [[NSArray alloc] initWithArray:[[KSCoreDataController sharedManager] extractEntityByChild:NO]];
    
    _haiku = [array objectAtIndex:_indexPath.row];
    
    _kami5text.text  = _haiku.kami5;
    _naka7text.text  = _haiku.naka7;
    _shimo5text.text = _haiku.shimo5;
    NSData     *imgData  = _haiku.image;
    UIImage    *photoImg = [UIImage imageWithData:imgData];
    [_haiku_img setImage:photoImg];
    
}

- (void)back {
    //画面遷移
    if ( ![self isBeingDismissed] ) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)done {
    
    // old data (edited data) save
    Haiku    *newHaiku;
    
    newHaiku           = [[KSCoreDataController sharedManager] insertNewEntity];
    newHaiku.identifer =   _haiku.identifer;
    newHaiku.child     =   [NSNumber numberWithBool:YES];
    newHaiku.date      =   _haiku.date;
    newHaiku.kami5     =   _haiku.kami5;
    newHaiku.naka7     =   _haiku.naka7;
    newHaiku.shimo5    =   _haiku.shimo5;
    newHaiku.haiku575  =   _haiku.haiku575;
    newHaiku.image     =   Nil;
    newHaiku.thumbnail =   Nil;
    
    // data 更新
    _haiku.kami5    = _kami5text.text;
    _haiku.naka7    = _naka7text.text;
    _haiku.shimo5   = _shimo5text.text;
    _haiku.haiku575 = [NSString stringWithFormat:@"%@%@%@", _kami5text.text, _naka7text.text, _shimo5text.text];
    _haiku.date     = [NSDate date];
    _haiku.child    = [NSNumber numberWithBool:NO];
    
    [[KSCoreDataController sharedManager] save];
    
    [self back];
    
}

#pragma mark -
#pragma mark ---------- touch ----------

//keyboard hidden
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_kami5text resignFirstResponder];
    [_naka7text resignFirstResponder];
    [_shimo5text resignFirstResponder];
    
}

#pragma mark -
#pragma mark ---------- textFields delegate ----------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ( textField.tag == kamiKu ) {
        [_naka7text becomeFirstResponder];
    }
    
    if ( textField.tag == nakaKu ) {
        [_shimo5text becomeFirstResponder];
    }
    
    if ( textField.tag == shimoKu ) {
        [_kami5text becomeFirstResponder];
    }
    
    return NO;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger    maxLengthOfCharactor = 0;
    if ( textField.tag == kamiKu ) {
        maxLengthOfCharactor = CHARACTOR_MAX_KAMI_5;
    }
    if ( textField.tag == nakaKu ) {
        maxLengthOfCharactor = CHARACTOR_MAX_NAKA_7;
    }
    if ( textField.tag == shimoKu ) {
        maxLengthOfCharactor = CHARACTOR_MAX_SHIMO_5;
    }
    
    // すでに入力されているテキストを取得
    NSMutableString    *text = [textField.text mutableCopy];
    
    // すでに入力されているテキストに今回編集されたテキストをマージ
    [text replaceCharactersInRange:range withString:string];
    
    // 結果が文字数をオーバーしていないならYES，オーバーしている場合はNO
    return ([text length] <= maxLengthOfCharactor);
    
}

@end
