//
//  MessageTableViewCell.m
//  Ducklive
//
//  Created by HungCao on 6/24/15.
//  Copyright (c) 2015 app.21ilab.{PRODUCT_NAME:rfc1034identifier}. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews
{
    [self.contentView addSubview:self.thumbnailView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bodyLabel];
    [self.contentView addSubview:self.attachmentView];
    [self.contentView addSubview:self.timeLabel];

    NSDictionary *views = @{@"thumbnailView": self.thumbnailView,
                            @"titleLabel": self.titleLabel,
                            @"bodyLabel": self.bodyLabel,
                            @"attachmentView": self.attachmentView,
                            @"timeLabel":self.timeLabel,
                            };
    
    NSDictionary *metrics = @{@"tumbSize": @(kAvatarSize),
                              @"trailing": @10,
                              @"trailing2":@30,
                              @"leading": @5,
                              @"width":@5,
                              @"attchSize": @80,
                              @"leftS:":@5,
                              };

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[thumbnailView(tumbSize)]-trailing-[titleLabel(>=0)]-trailing-[timeLabel(>=0)]-5-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-width-[thumbnailView(tumbSize)]-trailing-[bodyLabel(>=0)]-trailing2-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-width-[thumbnailView(tumbSize)]-trailing-[attachmentView]-trailing2-|" options:0 metrics:metrics views:views]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-trailing-[thumbnailView(tumbSize)]-(>=0)-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[titleLabel]-leading-[bodyLabel(>=0)]-leading-[attachmentView(>=0,<=attchSize)]-trailing-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[timeLabel]-(>=0)-|" options:0 metrics:metrics views:views]];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    self.bodyLabel.font = [UIFont systemFontOfSize:16.0];
}

#pragma mark - Getters

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.userInteractionEnabled = NO;
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.textColor = YELLOW_COLOR;
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel
{
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
        _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _bodyLabel.userInteractionEnabled = NO;
        _bodyLabel.numberOfLines = 0;
        
        _bodyLabel.font = [UIFont systemFontOfSize:16.0];
        _bodyLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
    }
    return _bodyLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        [_timeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_timeLabel setUserInteractionEnabled:NO];
        [_timeLabel setTextAlignment:NSTextAlignmentLeft];
        [_timeLabel setFont:[UIFont systemFontOfSize:16.0]];
        [_timeLabel setTextColor:GRAY_COLOR];
    }
    return _timeLabel;
}
- (UIImageView *)thumbnailView
{
    if (!_thumbnailView) {
        _thumbnailView = [UIImageView new];
        _thumbnailView.translatesAutoresizingMaskIntoConstraints = NO;
        _thumbnailView.userInteractionEnabled = NO;
        _thumbnailView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
        _thumbnailView.layer.cornerRadius = kAvatarSize/2.0;
        _thumbnailView.layer.masksToBounds = YES;
    }
    return _thumbnailView;
}

- (UIImageView *)attachmentView
{
    if (!_attachmentView) {
        _attachmentView = [UIImageView new];
        _attachmentView.translatesAutoresizingMaskIntoConstraints = NO;
        _attachmentView.userInteractionEnabled = NO;
        _attachmentView.backgroundColor = [UIColor clearColor];
        _attachmentView.contentMode = UIViewContentModeCenter;
        
        _attachmentView.layer.cornerRadius = kAvatarSize/4.0;
        _attachmentView.layer.masksToBounds = YES;
    }
    return _attachmentView;
}

- (BOOL)needsPlaceholder
{
    return YES;
}

@end
