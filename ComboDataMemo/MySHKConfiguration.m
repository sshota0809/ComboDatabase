//
//  MySHKConfiguration.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/03.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "MySHKConfiguration.h"

@implementation MySHKConfiguration

- (NSString *)appName{
    return @"コンボデータベース";
}
- (NSString *)appURL{
    return @"https://twitter.com/DJMYMR";
}

#pragma mark - Twitter
- (NSString*)twitterConsumerKey {
    return @"vkEyYs7getMa77uirzdL582CH";
}
- (NSString*)twitterSecret {
    return @"Br2Ne8wapvA9gIC79dBOoZKNSOrOae5ynDHcXPK6r0rpLSA6Sz";
}
// You need to set this if using OAuth, see note above (xAuth users can skip it)
- (NSString*)twitterCallbackUrl {
    return @"https://twitter.com/DJMYMR";
}
// To use xAuth, set to 1
- (NSNumber*)twitterUseXAuth {
    return [NSNumber numberWithInt:0];
}
// Enter your app's twitter account if you'd like to ask the user to follow it when logging in. (Only for xAuth)
- (NSString*)twitterUsername {
    return @"";
}

@end
