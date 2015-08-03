//
//  Message.h
//  Ducklive
//
//  Created by HungCao on 6/24/15.
//  Copyright (c) 2015 app.21ilab.{PRODUCT_NAME:rfc1034identifier}. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Message content in Comment
@interface Message : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *textMessage;
@property (nonatomic, strong) NSString *timeSent;
@property (nonatomic, strong) UIImage *attachment;
@property (nonatomic, strong) NSDate *dateMessage;
// AttributedString a message
@property (nonatomic, strong) NSMutableAttributedString *attributedString;
@end
