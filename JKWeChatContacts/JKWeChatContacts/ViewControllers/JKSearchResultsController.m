//
//  JKSearchResultsController.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/15.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKSearchResultsController.h"
#import "JKSectionTitleView.h"
#import "JKContactsTableViewCell.h"

@implementation JKSearchResultsController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 61;
    self.tableView.tableFooterView = UIView.new;
    [JKContactsTableViewCell registerCellWithTableView:self.tableView];
}


- (void)setSearchResults:(NSArray *)searchResults{
    _searchResults = searchResults.copy;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JKContactsTableViewCell *cell = [JKContactsTableViewCell cellForTableView:tableView];
    [cell configureCellWithModel:self.searchResults[indexPath.row]];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JKSectionTitleView * headerView = [JKSectionTitleView headerWithTableView:tableView];
    headerView.title = @"好友";
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectionBlock) {
        self.selectionBlock(self.searchResults[indexPath.row]);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}


@end
