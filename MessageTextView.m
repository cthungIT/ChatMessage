//
//  MessageTextView.m
//  Ducklive
//
//  Created by HungCao on 6/24/15.
//  Copyright (c) 2015 app.21ilab.{PRODUCT_NAME:rfc1034identifier}. All rights reserved.
//

#import "MessageTextView.h"

@implementation MessageTextView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.placeholder = CustomLocalisedString(@"Add Comment...",nil);
    self.placeholderColor = [UIColor lightGrayColor];
    self.pastableMediaTypes = SLKPastableMediaTypeAll;
    
    self.layer.borderColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
