//
//  KSListViewController.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/26.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSListViewController.h"

@interface KSListViewController ()

- (void)historyListview:(NSIndexPath *)indexPath;
- (void)accessoryButtonTapped:(UIControl *)button withEvent:(UIEvent *)event;
- (void)deleteHaiku:(NSIndexPath *)indexPath;

@end

@implementation KSListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _calc = [[KSCalc alloc] init];
    
    _selectedIndexPath = nil;
    
    //ios6からの変更に伴う追加コード
    [self.tableView registerClass:[KSHaikuCell class] forCellReuseIdentifier:@"KSHaikuCell"];

#pragma mark -
#pragma mark ---------- rotate table ----------
    // bgView の回転 (時計回りに90°)
    // -90°にしないのにはわけがある！
    //http://hamken100.blogspot.jp/2012/04/ios-uitableview.html
    
    CGRect    originalFrame = self.bgView.frame;
    self.bgView.center    = CGPointMake(320 / 2, 480 / 2);
    self.bgView.transform = CGAffineTransformMakeRotation(CELL_Rotation);
    self.bgView.frame     = originalFrame;
    
    // ページ単位でスクロールをかっちり止めるにはYES
    self.tableView.pagingEnabled = NO;
    
    // スクロールバー(インジケーター)が上部に出るので、気になる場合は消しておく
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    //help view
    CGRect     screen          = [UIScreen mainScreen].bounds;
    CGFloat    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat    img_y           = NAVIBAR_Height + statusBarHeight;
    CGRect     rec             = CGRectMake(screen.size.width * -1, NAVIBAR_Height, screen.size.width, screen.size.height - img_y);
    
    _helpview                 = [[UIImageView alloc] initWithFrame:rec];
    _helpview.backgroundColor = [UIColor redColor];
    _helpview.alpha           = 0.0f;
    [self.view addSubview:_helpview];
    _helpview.userInteractionEnabled = YES;

    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //table　更新
    [self.tableView reloadData];
   
    
  
    _menuBar.hidden    = NO;
    _menuBar.frame     = CGRectMake(0, 0, _menuBar.image.size.width, _menuBar.image.size.height);
    _selectedIndexPath = nil;
    
    NSArray    *haikus;
    haikus = [[KSCoreDataController sharedManager] extractEntityByChild:NO];
    
    if ( [haikus count] == 0 ) {
        [_gotoEditView setEnabled:NO];
    } else {
        [_gotoEditView setEnabled:YES];
    }
    
    
    //swip
    UISwipeGestureRecognizer    *swipeGesture =
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self action:@selector(didSwipeCell:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight; // 下
    [self.tableView addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    swipeGesture           = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeCell:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    _menuBar.userInteractionEnabled = YES;
    swipeGesture                    = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeMenu:)];
    swipeGesture.direction          = UISwipeGestureRecognizerDirectionLeft;
    [_menuBar addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    swipeGesture           = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showhelp:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_menuBar addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    
    self.tableView.scrollsToTop = NO;

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark ---------- swipe delegate----------

- (void)didSwipeMenu:(UISwipeGestureRecognizer *)swipe {
    
    UIImage        *img       = [UIImage imageNamed:DEFAULTMENU];
    UIImageView    *slideView = [[UIImageView alloc] initWithImage:img];
    CGRect         screen     = [UIScreen mainScreen].bounds;
    slideView.frame = CGRectMake(screen.size.width, 0, img.size.width, img.size.height);
    [_menuBar addSubview:slideView];
    
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         _menuBar.frame = CGRectMake(-1 * screen.size.width, 0, _menuBar.image.size.width, _menuBar.image.size.height);
                         
                     } completion:^(BOOL finished) {
                         
                         KSAddHaikuViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"add"];
                         
                         controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                         [self presentViewController:controller animated:YES completion:nil];
                         
                         controller = nil;
                         _menuBar.hidden = YES;
                         
                     }];
    
    slideView = nil;
    
}

- (void)didSwipeCell:(UISwipeGestureRecognizer *)swipeRecognizer {
    
    if ( [[self.tableView indexPathsForVisibleRows] count] == 0 ) {
        return;
    }
    
    CGPoint        loc        = [swipeRecognizer locationInView:self.tableView];
    NSIndexPath    *indexPath = [self.tableView indexPathForRowAtPoint:loc];
    KSHaikuCell    *cell      = (KSHaikuCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    CGRect         frame = cell.main_img.frame;
    CGFloat        ori_x = frame.origin.x;
    CGFloat        ori_y = frame.origin.y;
    frame.origin = CGPointMake(ori_x + 80, ori_y);
    
    if ( swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight ) {
        
        [UIView animateWithDuration:0.4
                              delay:0.3
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.main_img.frame = frame;
                             
                         }
         
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  _selectedIndexPath = indexPath;
                                                  [self goToEditView];
                                                  
                                              } completion:nil];
                             
                         }];
        
    } else if ( swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft ) {
        
        _deleteIndex = indexPath;
        
        UIAlertView    *alert = [[UIAlertView alloc] initWithTitle:@"Delete ?"
                                                           message:@"delete"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Delete", nil];
        [alert show];
        alert = nil;
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch ( buttonIndex ) {
        case 0:
            if ( alertView.visible ) {
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
            }
            break;
        case 1:
            
            [self deleteHaiku:_deleteIndex];
            
        default:
            break;
    }
}

- (void)deleteHaiku:(NSIndexPath *)indexPath {
    
    //delete cell
    KSHaikuCell    *cell = (KSHaikuCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    //anime
    CGRect         frame = cell.blindCell.frame;
    frame.origin = CGPointMake(0, 0);
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         cell.blindCell.frame = frame;
                         
                     }
     
                     completion:^(BOOL finished) {
                         
                         //delete
                         [[KSCoreDataController sharedManager] deleteItems:cell.identifer];
                         [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                         
                     }];
    
}

- (void)showhelp:(UISwipeGestureRecognizer *)swipeRecognizer {
    
    if ( swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight ) {
        
        KSHelpViewController    *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"help"];
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:controller animated:YES completion:nil];
        
        controller = nil;
        
    }
    
}

#pragma mark -
#pragma mark ---------- view transition ----------

- (IBAction)goToEditView {
    
    // index が設定されているか確認
    if ( _selectedIndexPath == Nil ) {
        return;
    }
    
    //画面遷移
    UIStoryboard            *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KSEditViewController    *controller = [storyboard instantiateViewControllerWithIdentifier:@"editview"];
    //controller.delegate = self;
    
    //indexPath を渡してEditViewでデーターを展開すること！
    controller.indexPath = _selectedIndexPath;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -
#pragma mark ---------- touch accessory ----------
- (void)accessoryButtonTapped:(UIControl *)button withEvent:(UIEvent *)event {
    
    NSIndexPath    *indexPath = [self.tableView indexPathForRowAtPoint:
                                 [[[event touchesForView:button] anyObject] locationInView:self.tableView]];
    if ( indexPath == nil ) {
        return;
    }
    
    [self historyListview:indexPath];
}

- (void)historyListview:(NSIndexPath *)indexPath {
    
    KSHistoryListViewController    *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"history"];
    
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.indexPath            = indexPath;
    
    [self presentViewController:controller animated:YES completion:^{

        //        LOG(@"called history");
    }];

}

#pragma mark -
#pragma mark ---------- update table data ----------
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    KSHaikuCell    *haikuCell;
    haikuCell = (KSHaikuCell *)cell;
    
    Haiku          *aHaiku = nil;
    NSArray        *haikus;
    haikus = [[KSCoreDataController sharedManager] extractEntityByChild:NO];
    if ( indexPath.row < [haikus count] ) {
        aHaiku = [haikus objectAtIndex:indexPath.row];
    }
    
    
    NSString    *_haiku575 = aHaiku.haiku575;
    haikuCell.haiku575  = _haiku575;
    haikuCell.identifer = aHaiku.identifer;
//    [haikuCell setNeedsLayout];
    
//    CGRect target = haikuCell.haikuLabel.frame;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[KSCoreDataController sharedManager] extractEntityByChild:NO].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString       *cellName = @"KSHaikuCell";
    KSHaikuCell    *cell;
    
//    cell = (KSHaikuCell *)[tableView dequeueReusableCellWithIdentifier:cellName]; ******* old *******
    cell = (KSHaikuCell* )[tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];

//    if ( !cell ) {
//        cell = [[KSHaikuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    }******* old *******
    
    // Set backgroundView
    UIImageView    *imageView;
    UIImage        *image;
    image               = [UIImage imageNamed:@"jpaper2.jpg"];
    imageView           = [[UIImageView alloc] initWithImage:image];
    cell.backgroundView = imageView;
    
    //haiku child yes ---> 表示しない
    NSArray             *array = [[NSArray alloc] initWithArray:[[KSCoreDataController sharedManager] extractEntityByChild:NO]];
    Haiku               *haiku = [array objectAtIndex:indexPath.row];
    
    //edit date
    KSKansuuji          *kansuji     = [[KSKansuuji alloc]init];
    NSDateComponents    *dateComps   = [_calc separateDateComponets:haiku.date];
    NSString            *kansu_date_ = [kansuji dateForHaikuMemo:dateComps.year month:dateComps.month day:dateComps.day];
    cell.editDate.text = kansu_date_;
    
    //haiku
    cell.haikuLabel.text = haiku.haiku575;
    
    //image
    NSData     *imgData  = haiku.image;
    UIImage    *photoImg = [UIImage imageWithData:imgData];
    [cell.main_img setImage:photoImg];
    
    //selection style
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //accessory
    UIButton    *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    button.transform = CGAffineTransformMakeRotation(CELL_Rotation * -1);
    [button    addTarget:self
                  action:@selector(accessoryButtonTapped:withEvent:)
        forControlEvents:UIControlEventTouchDown];
    cell.accessoryView = button;
    
    kansuji = nil;
    
    [self updateCell:cell atIndexPath:indexPath];


    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( _selectedIndexPath == Nil ) {
        _selectedIndexPath = indexPath;
    } else {
        _selectedIndexPath = Nil;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}

@end
