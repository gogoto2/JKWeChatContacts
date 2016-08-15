//
//  JKSearchResultsController.h
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/15.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKContactsModel.h"
@interface JKSearchResultsController : UITableViewController
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, copy)void(^selectionBlock)(JKContactsModel *);
@end
