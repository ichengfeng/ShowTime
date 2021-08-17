//
//  GirlCardCell.m
//  ShowTime
//
//  Created by mac on 2021/8/16.
//

#import "GirlCardCell.h"
#import "BigPictureViewController.h"

@interface GirlCardCell ()

@property(nonatomic, strong)UIImageView *bgImg;

@end

@implementation GirlCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.bgImg.hidden = NO;
        
    }
    return self;
}

- (void)setModel:(PictureModel *)model {
    
    _model = model;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ImgBaseUrl,model.imgUrl];
    
    NSString *bgImgEncodeUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:bgImgEncodeUrl]];
    
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.layer.cornerRadius = 10*adjustRatio;
        _bgImg.layer.masksToBounds = YES;
        _bgImg.userInteractionEnabled = YES;
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_bgImg];
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",ImgBaseUrl,self.model.imgUrl];
            NSString *bgImgEncodeUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            BigPictureViewController *bigPicVC = [[BigPictureViewController alloc]init];
            bigPicVC.imageUrl = bgImgEncodeUrl;
            bigPicVC.hidesBottomBarWhenPushed = YES;
            [[UIViewController topMost] presentViewController:bigPicVC animated:YES completion:nil];
        }];
        [_bgImg addGestureRecognizer:tapGes];
    }
    return _bgImg;
}

@end
