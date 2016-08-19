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

@property (nonatomic, strong)UIImageView * maskImageView;
@property (nonatomic, strong)UIImageView * maskImageView_copy;

@property (nonatomic, strong)UIImage * placeholder;
@property (weak, nonatomic) IBOutlet UIImageView *testImageCopy;

@end

@implementation JKContactsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.detailTextLabel.backgroundColor = [UIColor whiteColor];
    
    // 有2个圆角ImageView用来测试FPS,roundMaskImageView.image是本地圆角图
    
    // 方案1.使用imageView.layer.cornerRadius和imageView.layer.masksToBounds设置圆角
    // 方案2.使用imageView.layer.mask = roundMaskImageView.layer
    // 方案3.使用imageView.maskView = roundMaskImageView;
    // 方案4.用原图绘制圆角图 self.iconImageView.image = [image roundImage];
    
    
    // 测试结果
    // 方案1.  47-50 FPS
    // 方案2.  33-38 FPS
    // 方案3.  33-38 FPS,跟方案2差不多
    // 方案4.  55-60 FPS,界面最流畅
    
    
    /**
     *  方案4 > 方案1 > 方案2 == 方案3
     */
    
    
    
    // 方案1.
//    self.iconImageView.layer.cornerRadius = 20.0;
//    self.iconImageView.layer.masksToBounds = YES;
//    self.testImageCopy.layer.cornerRadius = 20.0;
//    self.testImageCopy.layer.masksToBounds = YES;
    
    // 方案4
    [[UIImage imageNamed:@"icon_b"] roundImageWithCompletion:^(UIImage *cornerImage) {
        self.placeholder = cornerImage;
    }];
}

+ (void)registerCellWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"JKContactsTableViewCell" bundle:nil] forCellReuseIdentifier:JKCellKey];
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    return [tableView dequeueReusableCellWithIdentifier:JKCellKey];
}

- (void)configureCellWithModel:(JKContactsModel *)model andSearchText:(NSString *)searchText{
    if (searchText) {
        NSRange nameRange = [model.name rangeOfString:searchText];
        NSRange phoneRange = [model.phone rangeOfString:searchText];
        
        NSMutableAttributedString * nameAttStr = [[NSMutableAttributedString alloc]initWithString:model.name];
        [nameAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:nameRange];
        self.nameLabel.attributedText = nameAttStr;
        
        NSMutableAttributedString * phoneAttStr = [[NSMutableAttributedString alloc]initWithString:model.phone];
        [phoneAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:phoneRange];
        self.subTitleLabel.attributedText = phoneAttStr;
        
        
    }else{
        self.nameLabel.text = model.name;
        self.subTitleLabel.text = model.phone;
    }
    
    
    
    
    // 方案1.2.3共用代码
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"icon_b"]];
//    [self.testImageCopy sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"icon_b"]];
    
    
    // 方案4.
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:self.placeholder options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [image roundImageWithCompletion:^(UIImage *cornerImage) {
            self.iconImageView.image = cornerImage;
            self.testImageCopy.image = cornerImage;
        }];
    }];
    
    [self maskImage];
}


- (void)configureCellWithTitle:(NSString *)title icon:(UIImage *)image{
    self.nameLabel.text = title;
    
    // 方案1.2.3共用代码
    self.iconImageView.image = image;
    self.testImageCopy.image = image;
    
    // 方案4.
    [image roundImageWithCompletion:^(UIImage *cornerImage) {
        self.iconImageView.image = cornerImage;
        self.testImageCopy.image = cornerImage;
    }];
    self.subTitleLabel.text = @"";
    [self maskImage];
}

- (void)maskImage{
    // 方案2.3共用代码
//    self.maskImageView.frame = self.iconImageView.bounds;
//    self.maskImageView_copy.frame = self.testImageCopy.bounds;
    
    // 方案3.
//    self.testImageCopy.maskView = self.maskImageView_copy;
//    self.iconImageView.maskView = self.maskImageView;
    
    // 方案2.
//    self.iconImageView.layer.mask = self.maskImageView.layer;
//    self.testImageCopy.layer.mask = self.maskImageView_copy.layer;
}

- (UIImageView *)maskImageView{
    if (!_maskImageView) {
        UIImage * maskImage = [UIImage imageNamed:@"JKRoundImage"];
        _maskImageView = [[UIImageView alloc]initWithImage:maskImage];
    }return _maskImageView;
}

- (UIImageView *)maskImageView_copy{
    if (!_maskImageView_copy) {
        UIImage * maskImage = [UIImage imageNamed:@"JKRoundImage"];
        _maskImageView_copy = [[UIImageView alloc]initWithImage:maskImage];
    }return _maskImageView_copy;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
