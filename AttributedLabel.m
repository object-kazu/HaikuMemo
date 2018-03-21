/*
 AttributedLabel.m
 
 Author: Makoto Kinoshita
 
 Copyright 2010 HMDT. All rights reserved.
 */

#import "AttributedLabel.h"

@interface AttributedLabel (private)

// Attributed string
- (void)_refreshAttributedString;

@end

@implementation AttributedLabel

//--------------------------------------------------------------//
#pragma mark -- Initialize --
//--------------------------------------------------------------//

- (void)_init {
    // Initialize instance variables
    _boldFontRanges        = [NSMutableArray array];
    _foregroundColors      = [NSMutableArray array];
    _foregroundColorRanges = [NSMutableArray array];
    
    _KS_UnderLineRanges = [NSMutableArray array];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) {
        return nil;
    }
    
    // Common init
    [self _init];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if ( !self ) {
        return nil;
    }
    
    // Common init
    [self _init];
    
    return self;
}

//--------------------------------------------------------------//
#pragma mark -- Property --
//--------------------------------------------------------------//

- (void)setText:(NSString *)text {
    // Invoke super
    [super setText:text];
    
    // Set needs refresh attributed string
    _needsRefreshAttrStr = YES;
}

//--------------------------------------------------------------//
#pragma mark -- Attributes --
//--------------------------------------------------------------//

- (void)addBoldFontAttrWithRange:(NSRange)range {
    // Add bold font range
    [_boldFontRanges addObject:[NSValue valueWithRange:range]];
    
    // Set needs refresh attributed string
    _needsRefreshAttrStr = YES;
}

- (void)addForegroundColorAttrWithColor:(UIColor *)color range:(NSRange)range {
    // Add foreground color and range
    [_foregroundColors addObject:color];
    [_foregroundColorRanges addObject:[NSValue valueWithRange:range]];
    
    // Set needs refresh attributed string
    _needsRefreshAttrStr = YES;
}

#pragma mark -
#pragma mark ---------- KS method ----------

- (void)KS_addUnderLineWithRange:(NSRange)range {
    
    [_KS_UnderLineRanges addObject:[NSValue valueWithRange:range]];
    _needsRefreshAttrStr = YES;
}

- (void)KS_tateGaki:(BOOL)tate text:(NSString *)text {
    _tateGaki            = tate;
    _str                 = text;
    _needsRefreshAttrStr = YES;
}

- (void)KS_addItalicAttr:(BOOL)italic {
    _isItalic            = YES;
    _needsRefreshAttrStr = YES;
}

- (void)KS_fontSize:(float)fontSize {
    
    _fontSize            = fontSize;
    _changeFontSize      = YES;
    _needsRefreshAttrStr = YES;
    
}

#pragma mark -
#pragma mark ---------- KS mthod End ----------

- (void)_refreshAttributedString {
    // Release old attributed string and frame
    _attrStr = nil;
    if ( _ctFrame ) {
        CFRelease(_ctFrame), _ctFrame = NULL;
    }
    
    // Create attributed string
    
    //LOG(@"attr str :%@",self.text);
    _attrStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    // Get length
    int    length;
    length = [_attrStr length];
    
    //
    // Set font attribute
    //
    
    // Set normal font attribute
    CTFontRef    ctFont;
    ctFont = CTFontCreateWithName(
                                  (__bridge CFStringRef)self.font.fontName,
                                  self.font.pointSize,
                                  NULL);
    [_attrStr addAttribute:(NSString *)kCTFontAttributeName
                     value:(__bridge id)ctFont range:NSMakeRange(0, length)];
    
    // Get bold font ranges
    UIFont       *boldFont;
    CTFontRef    ctBoldFont;
    boldFont   = [UIFont boldSystemFontOfSize:12.0f];
    ctBoldFont = CTFontCreateWithName(
                                      (__bridge CFStringRef)boldFont.fontName, self.font.pointSize, NULL);
    
    //NSLog(@"bold range :%@",[_boldFontRanges description]);
    
    for ( NSValue *boldFontRangeValue in _boldFontRanges ) {
        // Add bold font
        NSRange    boldFontRange;
        boldFontRange = [boldFontRangeValue rangeValue];
        if ( NSMaxRange(boldFontRange) <= length ) {
            [_attrStr addAttribute:(NSString *)kCTFontAttributeName
                             value:(__bridge id)ctBoldFont range:boldFontRange];
        }
    }
    
    //italic
    
    UIFont       *italicFont;
    CTFontRef    ctItalicFont;
    if ( _isItalic ) {
        italicFont   = [UIFont italicSystemFontOfSize:9.0f];
        ctItalicFont = CTFontCreateWithName((__bridge CFStringRef)italicFont.fontName, self.font.pointSize, NULL);
        [_attrStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)ctItalicFont range:NSMakeRange(0, length)];
        
    }
    
    //font size
    if ( _changeFontSize ) {
        CTFontRef    ctFontSize;
        UIFont       *_font_;
        _font_     = [UIFont systemFontOfSize:_fontSize];
        ctFontSize = CTFontCreateWithName((__bridge CFStringRef)_font_.fontName, _font_.pointSize, NULL);
        [_attrStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)ctFontSize range:NSMakeRange(0, length)];
        CFRelease(ctFontSize);
    }
    
    // Release font
    if ( ctFont ) {
        CFRelease(ctFont), ctFont = NULL;
    }
    if ( ctBoldFont ) {
        CFRelease(ctBoldFont), ctBoldFont = NULL;
    }
    
#pragma mark -
#pragma mark ---------- KS test ----------
    
    //
    // set  underline attribute
    //
    
    CTFontRef    ctUnder;
    ctUnder = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName, self.font.pointSize, NULL);
    
    for ( NSValue *underlineRangeValue in _KS_UnderLineRanges ) {
        NSRange    underlineRange;
        underlineRange = [underlineRangeValue rangeValue];
        [_attrStr addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt : kCTUnderlineStyleSingle] range:underlineRange];
        
    }
    
    CFRelease(ctUnder), ctUnder = NULL;
   
    // set tate gaki
    if ( _tateGaki ) {
        
        //NSLog(@"str text:%@ length :%d",_str,_str.length);
//        [_attrStr addAttribute:(NSString *)kCTVerticalFormsAttributeName value:@YES range:NSMakeRange(0, length)];
        [_attrStr addAttribute:(NSString *)kCTVerticalFormsAttributeName value:[NSNumber numberWithBool:YES] range:NSMakeRange(0, length)];

    }
    
#pragma mark -
#pragma mark ---------- kokomade ----------
    
    //
    // Set foreground color attribute
    //
    
    // Set normal body forgrond color
    UIColor    *bodyForegroundColor;
    //    if (self.highlighted) {
    //        bodyForegroundColor = self.highlightedTextColor;
    //    }
    //    else {
    //        bodyForegroundColor = self.textColor;
    //    }
    bodyForegroundColor = self.textColor;
    [_attrStr addAttribute:(NSString *)kCTForegroundColorAttributeName
                     value:(id)bodyForegroundColor.CGColor range:NSMakeRange(0, length)];
    
    // Get foreground colors
    int    i;
    for ( i = 0; i < [_foregroundColors count]; i++ ) {
        // Get foreground color and range
        UIColor    *foregroundColor;
        NSRange    foregroundColorRange;
        foregroundColor      = [_foregroundColors objectAtIndex:i];
        foregroundColorRange = [[_foregroundColorRanges objectAtIndex:i] rangeValue];
        
        // Add foreground color attribute
        if ( NSMaxRange(foregroundColorRange) <= length ) {
            [_attrStr addAttribute:(NSString *)kCTForegroundColorAttributeName
                             value:(id)foregroundColor.CGColor range:foregroundColorRange];
        }
    }
    
    //
    // Create frame
    //
    
    // Create frame
    CGMutablePathRef    path;
    CTFramesetterRef    framesetter;
    path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSDictionary    *frameDict = @{
                                   (id)kCTFrameProgressionAttributeName: @(kCTFrameProgressionRightToLeft)
                                   };
#pragma mark -
#pragma mark ---------- leaking !!!!!!!!!!! ----------
    framesetter = CTFramesetterCreateWithAttributedString(
                                                          (__bridge CFMutableAttributedStringRef)_attrStr);
    _ctFrame = CTFramesetterCreateFrame(
                                        framesetter, CFRangeMake(0, length), path, (__bridge CFDictionaryRef)frameDict /*NULL*/);
    CGPathRelease(path);
    
    // Clear flag
    _needsRefreshAttrStr                = NO;
    CFRelease(framesetter), framesetter = NULL;
    
}

//--------------------------------------------------------------//
#pragma mark -- Drawing --
//--------------------------------------------------------------//

- (void)drawRect:(CGRect)rect {
    // Refresh attributed string
    if ( _needsRefreshAttrStr ) {
        [self _refreshAttributedString];
    }
    
    // Get current context
    CGContextRef    context;
    context = UIGraphicsGetCurrentContext();
    
    // Get bounds
    CGRect    bounds;
    bounds = self.bounds;
    
    // Save context
    CGContextSaveGState(context);
    
    // Flip context
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, CGRectGetHeight(bounds));
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    // Draw frame
    CTFrameDraw(_ctFrame, context);
    
    // Restore context
    CGContextRestoreGState(context);
}

@end
