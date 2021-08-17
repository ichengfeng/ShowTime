//
//  HomeSectionHeadView.m
//  SoundBox
//
//  Created by mac on 2020/11/9.
//  Copyright © 2020 辛橙. All rights reserved.
//

#import "HomeSectionHeadView.h"

@implementation HomeSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel.hidden = NO;
        self.moreControl.hidden = NO;
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"音乐畅听";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0*adjustRatio weight:UIFontWeightMedium];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16*adjustRatio);
            make.top.mas_offset(24*adjustRatio);
            make.width.mas_lessThanOrEqualTo(250*adjustRatio);
            make.height.mas_equalTo(22*adjustRatio);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc]init];
        _moreImageView.image = [UIImage imageNamed:@"ic_jump_arrow_1"];
        [self addSubview:_moreImageView];
        [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.mas_right).offset(-16*adjustRatio);
            make.width.height.mas_equalTo(10*adjustRatio);
        }];
    }
    return _moreImageView;
}

- (UILabel *)lookMoreLabel {
    if (!_lookMoreLabel) {
        _lookMoreLabel = [[UILabel alloc]init];
        _lookMoreLabel.text = @"更多";
        _lookMoreLabel.textColor = [UIColor colorWithHexString:@"#676B78"];
        _lookMoreLabel.textAlignment = NSTextAlignmentRight;
        _lookMoreLabel.font = [UIFont systemFontOfSize:12*adjustRatio weight:UIFontWeightRegular];
        [self addSubview:_lookMoreLabel];
        [_lookMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.moreImageView);
            make.right.equalTo(self.moreImageView.mas_left).offset(-2*adjustRatio);
            make.height.mas_equalTo(15*adjustRatio);
        }];
    }
    return _lookMoreLabel;
}

- (UIControl *)moreControl {
    if (!_moreControl) {
        _moreControl = [[UIControl alloc]init];
        [self addSubview:_moreControl];
        [_moreControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.moreImageView);
            make.left.height.equalTo(self.lookMoreLabel);
            make.right.equalTo(self.moreImageView);
        }];
        [_moreControl addTarget:self action:@selector(goToNext) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreControl;
}

- (void)goToNext {
    
}

@end
