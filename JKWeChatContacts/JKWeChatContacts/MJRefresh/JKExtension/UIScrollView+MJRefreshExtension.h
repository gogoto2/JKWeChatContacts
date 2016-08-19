//
//  UIScrollView+MJRefreshExtension.h
//  MJRefreshExtension
//
//  Created by 蒋鹏 on 16/6/14.
//  Copyright © 2016年 深圳市见康云科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJRefreshHeader,MJRefreshFooter;


/**    因为老版本和新版本的方法名不同，特意加此分类重写老版本的方法    */
@interface UIScrollView (MJRefreshExtension)
@property (strong, nonatomic, readonly) MJRefreshHeader *header;
@property (strong, nonatomic, readonly) MJRefreshFooter *footer;
@property (nonatomic, copy)NSString * headerPullToRefreshText;

/** 崔宇轩：自定义设置footer的文字 */
@property (nonatomic, copy)NSString * footerNoMoreDataRefreshText;


/**    隐藏刷新时间    */
- (void)hidesHeaderLastUpdatedTimeLabel;

/**    头部    */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

/**    尾部    */
- (void)addFooterWithTarget:(id)target action:(SEL)action;

/**    头部开始刷新    */
- (void)headerBeginRefreshing;

/**    尾部开始刷新    */
- (void)footerBeginRefreshing;

/**    头部结束刷新    */
- (void)headerEndRefreshing;


/**    尾部结束刷新    */
- (void)footerEndRefreshing;

/**    设置尾部刷新时的提示内容    */
- (void)setFooterRefreshingText:(NSString *)title;

/**    设置头部刷新时的提示内容    */
- (void)setHeaderRefreshingText:(NSString *)title;


/**    移除尾部    */
- (void)removeHeader;

/**    头部是否正在刷新    */
- (BOOL)isHeaderRefreshing;

- (void)endHeaderRefreshingWithNoMoreData;
- (void)resetHeaderNoMoreData;

- (void)endFooterRefreshingWithNoMoreData;
- (void)resetFooterNoMoreData;


/**    结束头部、尾部刷新    */
- (void)endRefresh;
@end
