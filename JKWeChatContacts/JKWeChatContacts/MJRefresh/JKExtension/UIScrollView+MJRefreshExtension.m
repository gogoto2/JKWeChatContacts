//
//  UIScrollView+MJRefreshExtension.m
//  MJRefreshExtension
//
//  Created by 蒋鹏 on 16/6/14.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "UIScrollView+MJRefreshExtension.h"
#import "MJRefresh.h"



@implementation UIScrollView (MJRefreshExtension)
@dynamic footerNoMoreDataRefreshText;

- (MJRefreshHeader *)header{
    return self.mj_header;
}

- (MJRefreshFooter *)footer{
    return self.mj_footer;
}

- (void)hidesHeaderLastUpdatedTimeLabel{
    ((MJRefreshNormalHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = YES;
}

- (void)addFooterWithTarget:(id)target action:(SEL)action{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}

- (void)addHeaderWithTarget:(id)target action:(SEL)action{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
}

- (void)headerBeginRefreshing{
    [self.mj_header beginRefreshing];
}

- (void)footerBeginRefreshing{
    [self.mj_footer beginRefreshing];
}

- (void)headerEndRefreshing{
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing{
    [self.mj_footer endRefreshing];
}

- (void)setFooterRefreshingText:(NSString *)title{
    [(MJRefreshAutoNormalFooter *)self.mj_footer setTitle:title forState:MJRefreshStateRefreshing];
}

- (void)setHeaderRefreshingText:(NSString *)title{
    [(MJRefreshNormalHeader *)self.mj_header setTitle:title forState:MJRefreshStateRefreshing];
}

/** 崔宇轩：自定义设置footer的文字 */
- (void)setFooterNoMoreDataRefreshText:(NSString *)footerNoMoreDataRefreshText {
    [(MJRefreshAutoNormalFooter *)self.mj_footer setTitle:footerNoMoreDataRefreshText forState:MJRefreshStateNoMoreData];
}

- (void)removeHeader{
    if (self.mj_header) {
        [self.mj_header removeFromSuperview];
        self.mj_header = nil;
    }
}

- (void)setHeaderPullToRefreshText:(NSString *)headerPullToRefreshText{
    [(MJRefreshNormalHeader *)self.mj_header setTitle:headerPullToRefreshText forState:MJRefreshStatePulling];
}

- (NSString *)headerPullToRefreshText{
    return ((MJRefreshNormalHeader *)self.mj_header).stateTitles[@(MJRefreshStatePulling)];
}

- (BOOL)isHeaderRefreshing{
    return [self.mj_header isRefreshing];
}

- (void)endHeaderRefreshingWithNoMoreData{
    [(MJRefreshHeader *)self.mj_header endRefreshingWithNoMoreData];
}

- (void)resetHeaderNoMoreData{
    [(MJRefreshHeader *)self.mj_header resetNoMoreData];
}

- (void)endFooterRefreshingWithNoMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterNoMoreData{
    [self.mj_footer resetNoMoreData];
}


- (void)endRefresh{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }else if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

@end
