//
//  BigPictureViewController.m
//  ShowTime
//
//  Created by chengfeng on 2021/8/15.
//

#import "BigPictureViewController.h"

@interface BigPictureViewController ()

@property(nonatomic,strong)UIImageView *userHeadPic;

@end

@implementation BigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.navigationController setNavigationBarHidden:YES animated:YES];
    self.userHeadPic.hidden = NO;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    if (imageUrl.length > 0) {
        if ([imageUrl hasPrefix:@"http"]) {
            [self.userHeadPic sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }else {
            self.userHeadPic.image = [UIImage imageNamed:imageUrl];
        }
        
    }
    
}

- (UIImageView *)userHeadPic {
    if (!_userHeadPic) {
        _userHeadPic = [[UIImageView alloc]init];
        _userHeadPic.userInteractionEnabled = YES;
        _userHeadPic.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_userHeadPic];
        [_userHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [_userHeadPic addGestureRecognizer:tapGes];
    }
    return _userHeadPic;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
