//
//  CollectionCell.m
//  ShowTime
//
//  Created by chengfeng on 2021/8/15.
//

#import "CollectionCell.h"
#import "BigPictureViewController.h"

@interface CollectionCell ()

@property(nonatomic,strong)UIImageView *userHeadPic;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *nickNameLabel;

@property(nonatomic,strong)UILabel *phoneLabel;

@end

@implementation CollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.phoneLabel.hidden = NO;
    }
    return self;
}

- (UIImageView *)userHeadPic {
    if (!_userHeadPic) {
        _userHeadPic = [[UIImageView alloc]init];
        _userHeadPic.layer.cornerRadius = 32*adjustRatio;
        _userHeadPic.layer.masksToBounds = YES;
        _userHeadPic.userInteractionEnabled = YES;
        _userHeadPic.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_userHeadPic];
        [_userHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(16*adjustRatio);
            make.width.height.mas_equalTo(64*adjustRatio);
//            make.height.mas_equalTo(1.75*64*adjustRatio);
        }];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            BigPictureViewController *bigPicVC = [[BigPictureViewController alloc]init];
            bigPicVC.imageUrl = self.model.user_icon;
            bigPicVC.hidesBottomBarWhenPushed = YES;
            [[UIViewController topMost] presentViewController:bigPicVC animated:YES completion:nil];
        }];
        [_userHeadPic addGestureRecognizer:tapGes];
    }
    return _userHeadPic;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:18*adjustRatio weight:UIFontWeightMedium];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeadPic);
            make.left.equalTo(self.userHeadPic.mas_right).offset(12*adjustRatio);
            make.right.mas_equalTo(-16*adjustRatio);
            make.height.mas_equalTo(20*adjustRatio);
        }];
    }
    return _nameLabel;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.font = [UIFont systemFontOfSize:14*adjustRatio weight:UIFontWeightRegular];
        [self.contentView addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(8*adjustRatio);
            make.left.equalTo(self.userHeadPic.mas_right).offset(12*adjustRatio);
            make.right.mas_equalTo(-16*adjustRatio);
            make.height.mas_equalTo(15*adjustRatio);
        }];
    }
    return _nickNameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.font = [UIFont systemFontOfSize:14*adjustRatio weight:UIFontWeightRegular];
        [self.contentView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickNameLabel.mas_bottom).offset(8*adjustRatio);
            make.left.equalTo(self.userHeadPic.mas_right).offset(12*adjustRatio);
            make.right.mas_equalTo(-16*adjustRatio);
            make.height.mas_equalTo(15*adjustRatio);
        }];
    }
    return _phoneLabel;
}


- (void)setModel:(UserModel *)model {
    
    _model = model;
    
    [self.userHeadPic sd_setImageWithURL:[NSURL URLWithString:model.user_icon]];
    
    self.nameLabel.text = [NSString stringWithFormat:@"名字：%@",model.name];
    
    self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@",model.nickname];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",model.phone];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
