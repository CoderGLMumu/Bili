//
//  UIView+GQFrame.m
//  Bili
//
//  Created by sunny on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "UIView+GQFrame.h"

@implementation UIView (GQFrame)
/************* X ****************/
-(void)setBili_x:(CGFloat)bili_x
{
    CGRect frame = self.frame;
    frame.origin.x = bili_x;
    self.frame = frame;
}

-(CGFloat)bili_x
{
    return self.frame.origin.x;
}

/************* Y ****************/
-(void)setBili_y:(CGFloat)bili_y
{
    CGRect frame = self.frame;
    frame.origin.y = bili_y;
    self.frame = frame;
}

-(CGFloat)bili_y
{
    return self.frame.origin.y;
}
/************* width ****************/
-(void)setBili_width:(CGFloat)bili_width
{
    CGRect frame = self.frame;
    frame.size.width = bili_width;
    self.frame = frame;
}
-(CGFloat)bili_width
{
    return self.frame.size.width;
}

/************* height ****************/
-(void)setBili_height:(CGFloat)bili_height
{
    CGRect frame = self.frame;
    frame.size.width = bili_height;
    self.frame = frame;
}
-(CGFloat)bili_height
{
    return self.frame.size.height;
}

/************* size ****************/
-(void)setBili_size:(CGSize)bili_size
{
    CGRect frame = self.frame;
    frame.size = bili_size;
    self.frame = frame;
}
-(CGSize)bili_size
{
    return self.frame.size;
}

/************* centerX ****************/
- (void)setBili_centerX:(CGFloat)bili_centerX
{
    CGPoint center = self.center;
    center.x = bili_centerX;
    self.center = center;
}

- (CGFloat)bili_centerX
{
    return self.center.x;
}

/************* centerY ****************/
- (void)setBili_centerY:(CGFloat)bili_centerY
{
    CGPoint center = self.center;
    center.y = bili_centerY;
    self.center = center;
}

- (CGFloat)bili_centerY
{
    return self.center.y;
}
@end
