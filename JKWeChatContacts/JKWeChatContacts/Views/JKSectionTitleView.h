//
//  JKSectionTitleView.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/4/6.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JColor_RGB_Float(R,G,B)   ([UIColor colorWithRed:R green:G blue:B alpha:1.0])
#define JColor_RGB(R,G,B)         ([UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0])
#define JCBGColor     JColor_RGB_Float(0.937255,0.937255,0.956863)


UIKIT_EXTERN NSString * const JKSectionHeaderReuseKey;


@interface JKSectionTitleView : UITableViewHeaderFooterView

@property (nonatomic, strong)UILabel * titleLabel;



@property (nonatomic, copy)NSString * title;

+ (void)registerHeaderViewWithTableView:(UITableView *)tableView;

+ (instancetype)headerWithTableView:(UITableView *)tableView;


@end
