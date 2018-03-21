//
//  KSViewController.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/21.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSAddHaikuViewController.h"

@interface KSAddHaikuViewController ()

- (void)defaultImageSelect;
- (void)naviBarRecovery;

@end

@implementation KSAddHaikuViewController

static KSAddHaikuViewController    *sharedController = nil;

+ (KSAddHaikuViewController *)shardView {
    if ( !sharedController ) {
        sharedController = [[KSAddHaikuViewController alloc]init];
    }
    
    return sharedController;
}

#pragma mark -
#pragma mark ---------- life cycle ----------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //identifer
    _uuidString = [[NSUUID UUID] UUIDString];
    
    [self.textKami5 setDelegate:self];
    [self.textNaka7 setDelegate:self];
    [self.textShimo5 setDelegate:self];
    
    // keybord select
    _textKami5.keyboardType  = UIKeyboardTypeDefault;
    _textNaka7.keyboardType  = UIKeyboardTypeDefault;
    _textShimo5.keyboardType = UIKeyboardTypeDefault;
    
    //set tag
    _textKami5.tag  = kamiKu;
    _textNaka7.tag  = nakaKu;
    _textShimo5.tag = shimoKu;
    
    //textfield mode
    _textKami5.clearButtonMode  = UITextFieldViewModeAlways;
    _textNaka7.clearButtonMode  = UITextFieldViewModeAlways;
    _textShimo5.clearButtonMode = UITextFieldViewModeAlways;
    
    [_textKami5 becomeFirstResponder];
    
    [self defaultImageSelect];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //swip
    //menu bar
    _naviBarEdit.hidden                 = NO;
    _naviBarEdit.frame                  = CGRectMake(0, 0, _naviBarEdit.image.size.width, _naviBarEdit.image.size.height);
    _naviBarEdit.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer    *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(didSwipeMenu:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.naviBarEdit addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(didSwipeMenu:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.naviBarEdit addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(didSwipeMenu:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.naviBarEdit addGestureRecognizer:swipeGesture];
    swipeGesture = nil;


    //ios 7でメニューバーを上にスワイプする動作が、iosと衝突するので廃止とする
    //代わりに、double tapに変更する
//    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                             action:@selector(didSwipeMenu:)];
//    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.naviBarEdit addGestureRecognizer:swipeGesture];
//    swipeGesture = nil;
//    
    
    //swipe upに変わりDoubleTappedに変更する
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTapped:)];
    //タップされた回数を設定します。ダブルタップなので ２ で設定。
    doubleTapGesture.numberOfTapsRequired = 2;
    
    //Viewへ関連付けします。
    [self.naviBarEdit addGestureRecognizer:doubleTapGesture];
    doubleTapGesture = nil;
    

    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    if ( [self.view window] == nil ) {
        
        self.barTouchControllView = nil;
        
        self.textKami5    =   nil;
        self.textNaka7    =   nil;
        self.textShimo5   =   nil;
        self.haiku575     =   nil;
        self.photoImg     =   nil;
        self.thumbnailImg =   nil;
        self.naviBarEdit  =   nil;
        
        self.uuidString = nil;
    }
    
}

- (void)defaultImageSelect {
    
    KSCalc     *calc  = [[KSCalc alloc]init];
    SEASON     season = [calc selectSeason:[NSDate date]];
    UIImage    *defaultImg;
    
    switch ( season ) {
        case SEASON_SPRING:
            defaultImg = [UIImage imageNamed:DEF_SPRING];
            
            break;
            
        case SEASON_SUMMER:
            defaultImg = [UIImage imageNamed:DEF_SUMMER];
            
            break;
            
        case SEASON_AUTUM:
            defaultImg = [UIImage imageNamed:DEF_AUTUM];
            
            break;
            
        case SEASON_WINTER:
            defaultImg = [UIImage imageNamed:DEF_WINTER];
            
            break;
            
        default:
            defaultImg = [UIImage imageNamed:DEFAULT_IMG];
            
            break;
    }
    
    [_photoImg setImage:defaultImg];
    
    calc = nil;
}

#pragma mark -
#pragma mark ---------- swip ----------

- (void)didSwipeMenu:(UISwipeGestureRecognizer *)swipe {
    
    UIImage        *img       = [UIImage imageNamed:DEFAULTMENU];
    UIImageView    *slideView = [[UIImageView alloc] initWithImage:img];
    CGRect         screen     = [UIScreen mainScreen].bounds;
    slideView.frame = CGRectMake(screen.size.width, 0, img.size.width, img.size.height);
    [self.naviBarEdit addSubview:slideView];
    
    if ( swipe.direction == UISwipeGestureRecognizerDirectionLeft ) {
        // back
        
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             _naviBarEdit.frame = CGRectMake(-1 * screen.size.width, 0, _naviBarEdit.image.size.width, _naviBarEdit.image.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             [self back];
                             _naviBarEdit.hidden = YES;
                             
                         }];
        
    } else if ( swipe.direction == UISwipeGestureRecognizerDirectionRight ) {
        //done
        slideView.frame = CGRectMake(-1 * screen.size.width, 0, _naviBarEdit.image.size.width, _naviBarEdit.image.size.height);
        
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             _naviBarEdit.frame = CGRectMake(screen.size.width, 0, _naviBarEdit.image.size.width, _naviBarEdit.image.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             [self done];
                             _naviBarEdit.hidden = YES;
                             
                         }];
        
    } //else if ( swipe.direction == UISwipeGestureRecognizerDirectionUp ) {
//        //lib
//        CGFloat    high = _naviBarEdit.image.size.height;
//        [UIView animateWithDuration:0.4f
//                              delay:0.0f
//                            options:UIViewAnimationOptionCurveEaseOut
//                         animations:^{
//                             
//                             _naviBarEdit.frame = CGRectMake(0, -1 * high, _naviBarEdit.image.size.width, high);
//                             _naviBarEdit.alpha = 0.0f;
//                             
//                         } completion:^(BOOL finished) {
//                             
//                             [self photoLib:ACT_LIB];
//                             
//                         }];
        
//    }
    else if ( swipe.direction == UISwipeGestureRecognizerDirectionDown ) {
        //photo
        CGFloat    high = _naviBarEdit.image.size.height;
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             _naviBarEdit.frame = CGRectMake(0, high, _naviBarEdit.image.size.width, high);
                             _naviBarEdit.alpha = 0.0f;
                             
                         } completion:^(BOOL finished) {
                             [self photoLib:ACT_PHOT];
                             
                         }];
        
    }
    
    slideView = nil;
    
}

-(void) didDoubleTapped:(UITapGestureRecognizer*)dubleTapp{
    //lib
    CGFloat    high = _naviBarEdit.image.size.height;
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         _naviBarEdit.frame = CGRectMake(0, -1 * high, _naviBarEdit.image.size.width, high);
                         _naviBarEdit.alpha = 0.0f;
                         
                     } completion:^(BOOL finished) {
                         
                         [self photoLib:ACT_LIB];
                         
                     }];

}

#pragma mark -
#pragma mark Touch and Photo

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self tapOutside];
    
    UITouch    *touch = [[event allTouches] anyObject];
    if ( touch.view.tag == _barTouchControllView.tag ) {
        //        _startPoint         = [[touches anyObject] locationInView:self.view];
        //        _isPhotoButtonTouch = YES;
        
    } else {
        
        //        _isPhotoButtonTouch = NO;
        //        [self tapOutside];
        
    }
}

#pragma mark -
#pragma mark ---------- called by touch ----------

- (void)done {
    
    //save用データの用意
    NSString    *_kami5_  = [NSString stringWithString:_textKami5.text];
    NSString    *_naka7_  = [NSString stringWithString:_textNaka7.text];
    NSString    *_shimo5_ = [NSString stringWithString:_textShimo5.text];
    _haiku575 = [NSString stringWithFormat:@"%@%@%@", _kami5_, _naka7_, _shimo5_];
    
    [self saveHaiku];
    [self back];
}

- (void)back {
    
    //画面遷移
    if ( ![self isBeingDismissed] ) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

- (void)tapOutside {
    
    [_textKami5 resignFirstResponder];
    [_textNaka7 resignFirstResponder];
    [_textShimo5 resignFirstResponder];
}

//フォトライブラリーを呼び出す
- (void)photoLib:(ACTION)act {
    
    UIImagePickerController    *imagePickerController = [[UIImagePickerController alloc]init];
    
    switch ( act ) {
        case ACT_LIB:
            //使用可能か確認
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imagePickerController setAllowsEditing:YES];
                [imagePickerController setDelegate:self];
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
            break;
            
        case ACT_PHOT:
            
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                [imagePickerController setDelegate:self];
                [imagePickerController setAllowsEditing:YES];
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
            break;
            
        default:
            
            LOG(@"Do nothing");
            break;
    }
//    _naviBarEdit.hidden = NO;
//    _naviBarEdit.alpha  = 1.0f;
    [self naviBarRecovery];
    
    imagePickerController = nil;
}


#pragma mark -
#pragma mark ---------- image picker delegate ----------
//フォトライブラリー選択後に呼ばれるデリゲート
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // オリジナル画像
    UIImage    *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    // 編集画像
    UIImage    *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage    *saveImage;
    
    if ( editedImage ) {
        saveImage = editedImage;
    } else {
        saveImage = originalImage;
    }
    
    // UIImageViewに画像を設定
    KSImage    *_ksImg = [[KSImage alloc]init];
    UIImage    *img    = [_ksImg cropImageView:saveImage isSmall:NO];
    [_photoImg setImage:img];
    _thumbnailImg = [_ksImg cropImageView:saveImage isSmall:YES];
    
    if ( picker.sourceType == UIImagePickerControllerSourceTypeCamera ) {
        
        // カメラから呼ばれた場合は画像をフォトライブラリに保存してViewControllerを閉じる
        UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
        [self naviBarRecovery];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if ( picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary ) {
        
        [self naviBarRecovery];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        // フォトライブラリから呼ばれた場合はPopOverを閉じる（iPad）
        //		[popover dismissPopoverAnimated:YES];
        //		[popover release];
        //		popover = nil;
    }
    
    _ksImg = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self naviBarRecovery];
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

- (void)naviBarRecovery {
    
    [UIView animateWithDuration:0.1f animations:^{
        _naviBarEdit.frame = CGRectMake(0, 0, _naviBarEdit.image.size.width, _naviBarEdit.image.size.height);
        _naviBarEdit.alpha = 1.0f;
        
    }];
    _naviBarEdit.hidden = NO;
    
}

#pragma mark -
#pragma mark ---------- save  ----------

- (void)saveHaiku {
    
    //入力確認
    if ( [_textKami5.text isEqualToString:@""] &&
        [_textNaka7.text isEqualToString:@""] &&
        [_textShimo5.text isEqualToString:@""] ) {
        LOG(@"do not save because of no text data");
        
        return; // text未入力ならsave しない
    }
    // save
    Haiku    *newHaiku;
    newHaiku            = [[KSCoreDataController sharedManager] insertNewEntity];
    newHaiku.identifer  =  _uuidString;
    newHaiku.child      =  [NSNumber numberWithBool:NO];
    newHaiku.date       =  [NSDate date];
    newHaiku.kami5      =  _textKami5.text;
    newHaiku.naka7      =  _textNaka7.text;
    newHaiku.shimo5     =  _textShimo5.text;
    newHaiku.haiku575   =  _haiku575;
    newHaiku.image      =  UIImagePNGRepresentation(_photoImg.image);
    newHaiku.thumbnail  =  UIImagePNGRepresentation(_thumbnailImg);
    newHaiku.deleteFlug =  DELETE_FLUG_NO;
    
    //    LOG(@"------ newData check --------");
    //    LOG(@"child is %@", newHaiku.child ? @"yes" : @"no");
    //
    [[KSCoreDataController sharedManager] save];
}

#pragma mark -
#pragma mark ---------- textFields delegate ----------

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ( textField.tag == kamiKu ) {
        [_textNaka7 becomeFirstResponder];
    }
    
    if ( textField.tag == nakaKu ) {
        [_textShimo5 becomeFirstResponder];
    }
    
    if ( textField.tag == shimoKu ) {
        [_textKami5 becomeFirstResponder];
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
