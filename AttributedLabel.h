/*
 AttributedLabel.h
 
 Author: Makoto Kinoshita
 
 Copyright 2010 HMDT. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface AttributedLabel : UILabel
{
    NSMutableAttributedString    *_attrStr;
    CTFrameRef                   _ctFrame;
    BOOL                         _needsRefreshAttrStr;
    NSMutableArray               *_boldFontRanges;
    NSMutableArray               *_foregroundColors;
    NSMutableArray               *_foregroundColorRanges;
    
}

@property (nonatomic, retain) NSMutableArray    *KS_UnderLineRanges;
@property (nonatomic) BOOL                      tateGaki;
@property (nonatomic, retain) NSString          *str;
@property (nonatomic) BOOL                      isItalic;

//font size change
@property (nonatomic) BOOL                      changeFontSize;
@property (nonatomic) float                     fontSize;

// Attributes
- (void)addBoldFontAttrWithRange:(NSRange)range;
- (void)addForegroundColorAttrWithColor:(UIColor *)color range:(NSRange)range;

- (void)KS_addUnderLineWithRange:(NSRange)range;
- (void)KS_tateGaki:(BOOL)tate text:(NSString *)text;
- (void)KS_addItalicAttr:(BOOL)italic;
- (void)KS_fontSize:(float)fontSize;

@end
