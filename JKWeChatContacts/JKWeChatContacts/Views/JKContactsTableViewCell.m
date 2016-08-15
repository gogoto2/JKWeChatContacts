//
//  JKContactsTableViewCell.m
//  JKWeChatContacts
//
//  Created by 蒋鹏 on 16/8/3.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import "JKContactsTableViewCell.h"
static NSString * const JKCellKey = @"UIContactsTableViewCellReuseKey";




@interface JKContactsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation JKContactsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.detailTextLabel.backgroundColor = [UIColor whiteColor];
}

+ (void)registerCellWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"JKContactsTableViewCell" bundle:nil] forCellReuseIdentifier:JKCellKey];
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    return [tableView dequeueReusableCellWithIdentifier:JKCellKey];
}

- (void)configureCellWithModel:(JKContactsModel *)model{
    self.nameLabel.text = model.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"icon_b"]];
    self.subTitleLabel.text = model.phone;
}


- (void)configureCellWithTitle:(NSString *)title icon:(UIImage *)image{
    self.nameLabel.text = title;
    self.iconImageView.image = image;
    self.subTitleLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
