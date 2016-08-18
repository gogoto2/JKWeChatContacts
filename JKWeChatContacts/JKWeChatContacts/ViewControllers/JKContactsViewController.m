//
//  ViewController.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/3.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKContactsViewController.h"
#import "JKSearchResultsController.h"
#import "JKViewController.h"

#import "JKContactsTableViewCell.h"
#import "JKContactsModel.h"
#import "ContactDataHelper.h"
#import "JKSectionTitleView.h"

#define JKThemeColor [UIColor colorWithRed:12/255.0 green:196/255.0 blue:120/255.0 alpha:1]
#define JKScreenWidth       [UIScreen mainScreen].bounds.size.width

#define WEAK(objct) typeof(objct) __weak weak##objct = objct
#define STRONG(objct) typeof(weak##objct) __strong objct = weak##objct

@interface JKContactsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * indexArray;
@property (nonatomic, weak)IBOutlet UITableView * tableView;

@property (nonatomic, strong)UISearchController * searchController;
@property (nonatomic, strong)JKSearchResultsController * searchResultController;
@end

@implementation JKContactsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通讯录";
    self.view.backgroundColor = JCBGColor;
    self.tableView.backgroundColor = JCBGColor;
    self.navigationItem.titleView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.sectionIndexColor = [UIColor blackColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 10);
    self.tableView.tableFooterView = UITableViewHeaderFooterView.new;
    
    
    [JKSectionTitleView registerHeaderViewWithTableView:self.tableView];
    [JKContactsTableViewCell registerCellWithTableView:self.tableView];
    
    
    self.searchResultController = [[JKSearchResultsController alloc]initWithStyle:UITableViewStylePlain];
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchResultController];
    CGRect searchBarFrame = self.searchController.searchBar.frame;
    searchBarFrame.size.height = 44;
    self.searchController = searchController;
    self.searchController.searchBar.frame = searchBarFrame;
    self.searchController.delegate = self;
    
    self.searchController.searchBar.barTintColor = JCBGColor;
    self.searchController.searchBar.tintColor = [UIColor darkGrayColor];
    UITextField *searchField = [self.searchController.searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.font = [UIFont systemFontOfSize:17];
        searchField.leftView.bounds = CGRectMake(0, 0, 25, 25);
        searchField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    [self.searchController.searchBar setBackgroundImage:[UIImage imageWithRGBColor:JCBGColor imageSize:CGSizeMake(JKScreenWidth, 66)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"jk_search_icon"]
                          forSearchBarIcon:UISearchBarIconSearch
                                     state:UIControlStateNormal];
    
    WEAK(self);
    WEAK(searchController);
    self.searchResultController.selectionBlock = ^(JKContactsModel * model){
        STRONG(self);
        STRONG(searchController);
        
        [searchController setActive:NO];
        NSLog(@"%@",model.description);
        JKViewController * myVC = [[JKViewController alloc]init];
        [self.navigationController pushViewController:myVC animated:YES];
    };
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    NSMutableArray * originDatas = [JKContactsModel loadMyContacts];
    self.dataArray = [ContactDataHelper getFriendListDataBy:originDatas];
    self.indexArray = [ContactDataHelper getFriendListSectionBy:self.dataArray addSearchFlag:YES];
}






#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        NSArray * sectionDatas = self.dataArray[section-1];
        return sectionDatas.count;
    }return 3;
}



- (JKContactsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JKContactsTableViewCell * cell = [JKContactsTableViewCell cellForTableView:tableView];
    if (indexPath.section) {
        NSArray * sectionDatas = self.dataArray[indexPath.section-1];
        JKContactsModel * model = sectionDatas[indexPath.row];
        [cell configureCellWithModel:model];
    }else{
        if (indexPath.row == 0) {
            [cell configureCellWithTitle:@"群聊" icon:[UIImage imageNamed:@"icon_a"]];
        }else if (indexPath.row == 1){
            [cell configureCellWithTitle:@"公众号" icon:[UIImage imageNamed:@"icon_b"]];
        }else{
            [cell configureCellWithTitle:@"联系人" icon:[UIImage imageNamed:@"icon_c"]];
        }
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (index) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        return index;
    }else {
        [tableView setContentOffset:CGPointMake(0, -64) animated:NO];
        return NSNotFound;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JKSectionTitleView * headerView = [JKSectionTitleView headerWithTableView:tableView];
    if (section > 0 && self.indexArray.count) {
        headerView.title = self.indexArray[section];
    }else{
        headerView.title = nil;
    }
    return headerView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section ? 24 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }else {
        return 0.01;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat insetX = 15;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, insetX, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, insetX, 0, 0)];
    }
}


#pragma mark - 模糊查询
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString * searchText = searchController.searchBar.text;
//    self.searchResultController.searchResults =
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
