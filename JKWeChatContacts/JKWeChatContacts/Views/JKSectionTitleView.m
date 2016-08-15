//
//  JKSectionTitleView.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/4/6.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKSectionTitleView.h"
#import "NSString+JKExtension.h"

NSString * const JKSectionHeaderReuseKey = @"JKSectionHeaderReuseKey";

@interface JKSectionTitleView ()

@end

@implementation JKSectionTitleView

+ (void)registerHeaderViewWithTableView:(UITableView *)tableView {
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:JKSectionHeaderReuseKey];
}

+ (instancetype)headerWithTableView:(UITableView *)tableView {
    JKSectionTitleView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:JKSectionHeaderReuseKey];
    if (headerView == nil) {
        headerView = [[JKSectionTitleView alloc] initWithReuseIdentifier:JKSectionHeaderReuseKey];
    }
    return headerView;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:17]];
//    size.height -= 2;
    CGRect frame = self.titleLabel.frame;
    frame.origin.y = 1;
    frame.size = size;
    self.titleLabel.frame = frame;
}



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = JCBGColor;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.opaque = YES;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 13, 22)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}

@end
