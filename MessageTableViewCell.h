//
//  MessageTableViewCell.h
//  Ducklive
//
//  Created by HungCao on 6/24/15.
//  Copyright (c) 2015 app.21ilab.{PRODUCT_NAME:rfc1034identifier}. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAvatarSize 50.0
#define kMinimumHeight 70.0

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;
@property (nonatomic, strong) UIImageView *thumbnailView;
@property (nonatomic, strong) UIImageView *attachmentView;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, readonly) BOOL needsPlaceholder;
@property (nonatomic) BOOL usedForMessage;
@end
