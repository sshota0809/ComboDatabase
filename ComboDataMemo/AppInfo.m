

#import "AppInfo.h"

@implementation AppInfo

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"このアプリについて";
    
    // メインとなるビュー
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    backView.backgroundColor = [UIColor whiteColor];
    

    
    // ここから UIImage を設定する
    // 初期設定：デフォルト画像を使用
    UIImage *imageBefore = [UIImage imageNamed:@"dedspice.png"];
    // リサイズ処理
    
    CGFloat width = 70;
    CGFloat height = 70;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [imageBefore drawInRect:CGRectMake(0, 0, width, height)];
    appImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView = [[UIImageView alloc] initWithImage:appImage];
    // 初期設定
    imageView.frame = CGRectMake(125, 50, 70, 70);
    [backView addSubview:imageView];
    
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 125, 190, 40)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.numberOfLines = 2;
    infoLabel.font = [UIFont systemFontOfSize:10];
    infoLabel.text = @"ComboDataBase Version 1.0.0\nsshota0809 All right reserved";
    [backView addSubview:infoLabel];
    
    profLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 180, 270, 120)];
    profLabel.textAlignment = NSTextAlignmentCenter;
    profLabel.numberOfLines = 7;
    profLabel.font = t systemFontOfSize:14];
    profLabel.text = @"sshota0809\n使用キャラ\nBBCP: ラグナ\nP4U2: 里中千枝\nUSF4: ケン";
    [backView addSubview:profLabel];
    
    text = [[infoTextView alloc] initWithFrame:CGRectMake(25, 300, 270, 120)];
    text.text = @"要望・指摘はレビューにてお願いいたします。";
    [backView addSubview:text];
    
    
    // 最後にメインに格納
    [self.view addSubview:backView];
    
    

    
    
    
    
}

@end
