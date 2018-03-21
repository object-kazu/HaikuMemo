//
//  def.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#ifndef HaikuMemo_def_h
#define HaikuMemo_def_h

#define DEFAULT_IMG            @"haikuImgs.png"
#define DEF_SPRING             @"spring.png"
#define DEF_SUMMER             @"summer.png"
#define DEF_AUTUM              @"autum.png"
#define DEF_WINTER             @"winter.png"
//#define LIB @"lib"
//#define PHOTO @"photo"

#define RGBA(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]
#define RGB(r, g, b)     [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : 1]

#define CELL_Rotation          (M_PI * 90 / 180.0f)
#define CELL_Height            80
#define NAVIBAR_Height         44.0f

//thumbnail
#define Thumbnail_width        80
#define Thumbnail_height       80
#define THUMIMAGE_SIZE         250
#define SMALL_THUMIMAGE_SIZE   38

//touch move limit
#define TOUCH_MOVE_LITMIT      20
#define MOVE_Amount_High_Limit 1400
#define MOVE_Amount_Low_Limit  800

//slide touch main img
#define kDragDistance          75
//#define NORTIFICATION          @"ksnortification"
#define DEFAULTMENU            @"defaultmenu.png"
#define DELETE_FLUG_YES        @"deleteFlugYes"
#define DELETE_FLUG_NO         @"deleteFlugNo"

#define CHARACTOR_MAX_KAMI_5   8
#define CHARACTOR_MAX_NAKA_7   10
#define CHARACTOR_MAX_SHIMO_5  8

typedef NS_ENUM (NSInteger, kuUnit) {
    kamiKu = 0,
    nakaKu,
    shimoKu,
    maxKu
};

typedef NS_ENUM (NSInteger, ACTION) {
    ACT_PHOT = 0,
    ACT_LIB,
    ACT_BACK,
    ACT_DONE,
    ACT_TAP,
    ACT_MAX
};

typedef NS_ENUM (NSInteger, SEASON) {
    SEASON_IN = 0,
    SEASON_SPRING,
    SEASON_SUMMER,
    SEASON_AUTUM,
    SEASON_WINTER,
    SEASON_OUT
    
};

//typedef NS_ENUM (NSInteger, TAG) {
//    MIN_TAG = 0,
//    photoControllView_TAG,
//
//    MAX_TAG
//};

//typedef NS_ENUM (NSInteger, touchDirection) {
//    moveMin = 0,
//    moveLeft,
//    moveRight,
//    moveDown,
//    moveUp,
//    moveNone,
//    moveMax
//};

//typedef struct {
//    float    dx;
//    float    dy;
//} dxdy;

#endif
