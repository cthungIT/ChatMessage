//
//  MessageView.m
//  Ducklive
//
//  Created by HungCao on 6/24/15.
//  Copyright (c) 2015 app.21ilab.{PRODUCT_NAME:rfc1034identifier}. All rights reserved.
//

#import "MessageView.h"

#import "MessageTableViewCell.h"
#import "MessageTextView.h"
#import "Message.h"
#import "Constants.h"
#import "Utils.h"

static NSString *MessengerCellIdentifier = @"MessengerCell";
static NSString *AutoCompletionCellIdentifier = @"AutoCompletionCell";

@interface MessageView ()

@property (nonatomic, strong) NSMutableArray *messages;

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *channels;

@property (nonatomic, strong) NSArray *searchResult;
@end

@implementation MessageView

- (id)init
{
    self = [super initWithTableViewStyle:UITableViewStylePlain];
    if (self) {
        // Register a subclass of SLKTextView, if you need any special appearance and/or behavior customisation.
        [self registerClassForTextView:[MessageTextView class]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Register a subclass of SLKTextView, if you need any special appearance and/or behavior customisation.
        [self registerClassForTextView:[MessageTextView class]];
    }
    return self;
}

+ (UITableViewStyle)tableViewStyleForCoder:(NSCoder *)decoder
{
    return UITableViewStylePlain;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //Generate data
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Message *message = [Message new];
        message.username = @"21iLab";
        message.textMessage = @"you have two required constraints that could conflict depending on how the view's superview's constraints are setup. If the superview were to have a required constraint that specifies it's height be some value less than 748";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:message.textMessage];
        [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0] range:NSMakeRange(0, message.textMessage.length)];
        message.attributedString = att;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATE_FORMAT_STRING];
        message.dateMessage = [dateFormatter dateFromString:@"July, 20, 2015 - 05:07 PM"];
        [array addObject:message];
    }
    
    NSArray *reversed = [[array reverseObjectEnumerator] allObjects];
    self.messages = [[NSMutableArray alloc] initWithArray:reversed];
    //end generate data
    
    
    self.users = @[@"HungCao", @"21iLAb", @"Mr.Kiem", @"Mr.KhaiHoang", @"Ms.Hoa", @"Mr.Andrea"];
    
    self.bounces = YES;
    self.shakeToClearEnabled = YES;
    self.keyboardPanningEnabled = YES;
    self.shouldScrollToBottomAfterKeyboardShows = YES;
    self.inverted = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:MessengerCellIdentifier];
    
//    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.rightButton setTitle:CustomLocalisedString(@"Send",nil) forState:UIControlStateNormal];
    [self.rightButton setBackgroundColor:YELLOW_COLOR];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton.layer setCornerRadius:5];
    [self.rightButton setClipsToBounds:YES];
    
    [self.textInputbar.editorTitle setTextColor:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0]];
//    [self.textInputbar.editortLeftButton setTintColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];
//    [self.textInputbar.editortRightButton setTintColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
    self.textInputbar.autoHideRightButton = YES;
    self.textInputbar.maxCharCount = 256;
    self.textInputbar.counterStyle = SLKCounterStyleSplit;
    self.textInputbar.counterPosition = SLKCounterPositionBottom;
    
    self.typingIndicatorView.canResignByTouch = YES;
    
    [self.autoCompletionView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:AutoCompletionCellIdentifier];
    [self registerPrefixesForAutoCompletion:@[@"@", @"#", @":"]];
}

#pragma mark - Action Methods

- (void)fillWithText:(id)sender
{
    if (self.textView.text.length == 0)
    {
        self.textView.text = @"you have two required constraints that could conflict depending on how the view's superview's constraints are setup. If the superview were to have a required constraint that specifies it's height be some value less than 748";
    }
    else {
        [self.textView slk_insertTextAtCaretRange:@"you have two required constraints that could conflict depending on how the view's superview's constraints are setup. If the superview were to have a required constraint that specifies it's height be some value less than 748"];
    }
}

- (void)simulateUserTyping:(id)sender
{
    if (!self.isEditing && !self.isAutoCompleting) {
        [self.typingIndicatorView insertUsername:@"Hung Cao"];
    }
}

- (void)editCellMessage:(UIGestureRecognizer *)gesture
{
    MessageTableViewCell *cell = (MessageTableViewCell *)gesture.view;
    Message *message = self.messages[cell.indexPath.row];
    
    [self editText:message.textMessage];
    
    [self.tableView scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)editRandomMessage:(id)sender
{
    [self editText:@"you have two required constraints that could conflict depending on how the view's superview's constraints are setup. If the superview were to have a required constraint that specifies it's height be some value less than 748"];
}

- (void)editLastMessage:(id)sender
{
    if (self.textView.text.length > 0) {
        return;
    }
    
    NSInteger lastSectionIndex = [self.tableView numberOfSections]-1;
    NSInteger lastRowIndex = [self.tableView numberOfRowsInSection:lastSectionIndex]-1;
    
    Message *lastMessage = [self.messages objectAtIndex:lastRowIndex];
    
    [self editText:lastMessage.textMessage];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - Overriden Methods

- (void)didChangeKeyboardStatus:(SLKKeyboardStatus)status
{
    // Notifies the view controller that the keyboard changed status.
}

- (void)textWillUpdate
{
    // Notifies the view controller that the text will update.
    
    [super textWillUpdate];
}

- (void)textDidUpdate:(BOOL)animated
{
    // Notifies the view controller that the text did update.
    
    [super textDidUpdate:animated];
}

- (void)didPressLeftButton:(id)sender
{
    // Notifies the view controller when the left button's action has been triggered, manually.
    
    [super didPressLeftButton:sender];
}

- (void)didPressRightButton:(id)sender
{
    // Notifies the view controller when the right button's action has been triggered, manually or by using the keyboard return key.
    
    // This little trick validates any pending auto-correction or auto-spelling just after hitting the 'Send' button
    [self.textView refreshFirstResponder];
    
    Message *message = [Message new];
    message.username = [self.users objectAtIndex:(rand()%self.users.count)];
    message.textMessage = [self.textView.text copy];
    message.attributedString = [self.textView.attributedText copy];
    message.dateMessage = [NSDate date];
    
    //reset att
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"c"];
//    [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0] range:NSMakeRange(0, 1)];
//    [self.textView setAttributedText:att];
    [self.textView refreshFirstResponder1];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    UITableViewRowAnimation rowAnimation = self.inverted ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop;
//    UITableViewScrollPosition scrollPosition = self.inverted ? UITableViewScrollPositionBottom : UITableViewScrollPositionTop;

    UITableViewRowAnimation rowAnimation = UITableViewRowAnimationTop;
    UITableViewScrollPosition scrollPosition = UITableViewScrollPositionTop;
    
    [self.tableView beginUpdates];
    [self.messages insertObject:message atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:rowAnimation];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:YES];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [super didPressRightButton:sender];
}

- (void)didPressArrowKey:(id)sender
{
    [super didPressArrowKey:sender];
    
    UIKeyCommand *keyCommand = (UIKeyCommand *)sender;
    
    if ([keyCommand.input isEqualToString:UIKeyInputUpArrow]) {
        [self editLastMessage:nil];
    }
}

- (NSString *)keyForTextCaching
{
    return [[NSBundle mainBundle] bundleIdentifier];
}


- (void)willRequestUndo
{
    // Notifies the view controller when a user did shake the device to undo the typed text
    
    [super willRequestUndo];
}

//- (void)didCommitTextEditing:(id)sender
//{
//    // Notifies the view controller when tapped on the right "Accept" button for commiting the edited text
//    
//    Message *message = [Message new];
//    message.username = @"Hung Cao";
//    message.textMessage = [self.textView.text copy];
//    
//    [self.messages removeObjectAtIndex:0];
//    [self.messages insertObject:message atIndex:0];
//    [self.tableView reloadData];
//    
//    [super didCommitTextEditing:sender];
//}

- (void)didCancelTextEditing:(id)sender
{
    // Notifies the view controller when tapped on the left "Cancel" button
    
    [super didCancelTextEditing:sender];
}

- (BOOL)canPressRightButton
{
    return [super canPressRightButton];
}

- (BOOL)canShowAutoCompletion
{
    NSArray *array = nil;
    NSString *prefix = self.foundPrefix;
    NSString *word = self.foundWord;
    
    self.searchResult = nil;
    
    if ([prefix isEqualToString:@"@"]) {
        if (word.length > 0) {
            array = [self.users filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self BEGINSWITH[c] %@", word]];
        }
        else {
            array = self.users;
        }
    }
    else if ([prefix isEqualToString:@"#"] && word.length > 0) {
        array = [self.channels filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self BEGINSWITH[c] %@", word]];
    }
    
    if (array.count > 0) {
        array = [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    self.searchResult = [[NSMutableArray alloc] initWithArray:array];
    
    return self.searchResult.count > 0;
}

- (CGFloat)heightForAutoCompletionView
{
    CGFloat cellHeight = [self.autoCompletionView.delegate tableView:self.autoCompletionView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return cellHeight*self.searchResult.count;
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return self.messages.count;
    }
    else {
        return self.searchResult.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        return [self messageCellForRowAtIndexPath:indexPath];
    }
    else {
        return [self autoCompletionCellForRowAtIndexPath:indexPath];
    }
}

- (MessageTableViewCell *)messageCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = (MessageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:MessengerCellIdentifier];
    
    if (!cell.textLabel.text) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(editCellMessage:)];
        [cell addGestureRecognizer:longPress];
    }
    
    Message *message = self.messages[indexPath.row];
    
    cell.titleLabel.text = message.username;
    cell.bodyLabel.text = message.textMessage;
    cell.bodyLabel.attributedText = message.attributedString;
    
    cell.indexPath = indexPath;
    cell.usedForMessage = YES;
    NSDateFormatter *dateFotmatter = [[NSDateFormatter alloc] init];
    [dateFotmatter setDateFormat:DATE_FORMAT_STRING];
    cell.timeLabel.text = [Utils getTimeStringWithType:COMMENT time:[dateFotmatter stringFromDate:message.dateMessage]];
    
    if (cell.needsPlaceholder)
    {
//        CGFloat scale = [UIScreen mainScreen].scale;
//        
//        if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)]) {
//            scale = [UIScreen mainScreen].nativeScale;
//        }
        cell.thumbnailView.image = [UIImage imageNamed:@"img/test/avartaKing.jpg"];
        cell.thumbnailView.layer.shouldRasterize = YES;
        cell.thumbnailView.layer.rasterizationScale = [UIScreen mainScreen].scale;

    }
    
    // Cells must inherit the table view's transform
    // This is very important, since the main table view may be inverted
    cell.transform = self.tableView.transform;
    return cell;
}

- (MessageTableViewCell *)autoCompletionCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = (MessageTableViewCell *)[self.autoCompletionView dequeueReusableCellWithIdentifier:AutoCompletionCellIdentifier];
    cell.indexPath = indexPath;
    
    NSString *item = self.searchResult[indexPath.row];
    
    if ([self.foundPrefix isEqualToString:@"#"]) {
        item = [NSString stringWithFormat:@"# %@", item];
    }
    else if ([self.foundPrefix isEqualToString:@":"]) {
        item = [NSString stringWithFormat:@":%@:", item];
    }
    
    cell.titleLabel.text = item;
    cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        Message *message = self.messages[indexPath.row];
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        CGFloat width = CGRectGetWidth(tableView.frame)-kAvatarSize;
        width -= 25.0;
        
        CGRect titleBounds = [message.username boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
        CGRect bodyBounds = [message.textMessage boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
        
        if (message.textMessage.length == 0) {
            return 0.0;
        }
        
        CGFloat height = CGRectGetHeight(titleBounds);
        height += CGRectGetHeight(bodyBounds);
        height += 40.0;
        if (message.attachment) {
            height += 80.0 + 10.0;
        }
        
        if (height < kMinimumHeight) {
            height = kMinimumHeight;
        }
        //
        return height;
    }
    else {
        return kMinimumHeight;
    }
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.autoCompletionView]) {
        
        NSMutableString *item = [self.searchResult[indexPath.row] mutableCopy];
        
//        if ([self.foundPrefix isEqualToString:@"@"] && self.foundPrefixRange.location == 0) {
//            [item appendString:@":"];
//        }
//        else if ([self.foundPrefix isEqualToString:@":"]) {
//            [item appendString:@":"];
//        }
        
        [item appendString:@" "];
        
        [self acceptAutoCompletionWithString:item keepPrefix:YES];
    }
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Since SLKTextViewController uses UIScrollViewDelegate to update a few things, it is important that if you ovveride this method, to call super.
    [super scrollViewDidScroll:scrollView];
}


#pragma mark - UIScrollViewDelegate Methods

/** UITextViewDelegate */
- (BOOL)textView:(SLKTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return [super textView:textView shouldChangeTextInRange:range replacementText:text];
}


@end
