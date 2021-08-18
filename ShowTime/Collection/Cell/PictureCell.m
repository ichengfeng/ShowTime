//
//  PictureCell.m
//  ShowTime
//
//  Created by chengfeng on 2021/8/15.
//

#import "PictureCell.h"
#import "BigPictureViewController.h"

@interface PictureCell ()

@end

@implementation PictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 10, 20));
        }];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            BigPictureViewController *bigPicVC = [[BigPictureViewController alloc]init];
            bigPicVC.imageUrl = self.imgName;
            bigPicVC.hidesBottomBarWhenPushed = YES;
            [[UIViewController topMost] presentViewController:bigPicVC animated:YES completion:nil];
        }];
        [_imgView addGestureRecognizer:tapGes];
    }
    return _imgView;
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    self.imgView.image = [UIImage imageNamed:imgName];
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
