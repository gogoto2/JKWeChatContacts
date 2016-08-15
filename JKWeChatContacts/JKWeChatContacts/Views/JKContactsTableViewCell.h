//
//  JKContactsTableViewCell.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/3.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKContactsModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+JKExtension.h"

@interface JKContactsTableViewCell : UITableViewCell



+ (void)registerCellWithTableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;



- (void)configureCellWithModel:(JKContactsModel *)model;

- (void)configureCellWithTitle:(NSString *)title icon:(UIImage *)image;


@end
