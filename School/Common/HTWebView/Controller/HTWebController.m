//
//  HTWebController.m
//  GMat
//
//  Created by hublot on 2017/4/24.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import "HTWebController.h"
#import "HTShareView.h"
#import "HTAppDelegate.h"

@interface HTWebController () <UIScrollViewDelegate>

@property (nonatomic, copy) NSString *webviewTitle;

@property (nonatomic, assign) CGSize lastContentSize;

@end

@implementation HTWebController

- (void)dealloc {
	self.webView.scrollView.delegate = nil;
	[self.webView stopLoading];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    __weak HTWebController *weakController = self;
    self.showsBackgroundLabel = false;
    self.webView.scrollView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidExitFullscreen)
                                                 name:UIWindowDidResignKeyNotification
                                               object:nil];

    
    UIBarButtonItem *shareBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"Toeflshare"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        NSString *titleName = weakController.webviewTitle;
        NSString *urlString = weakController.URL.absoluteString;
        if (weakController.customShareBlock) {
            weakController.customShareBlock(titleName, urlString);
        } else {
            [HTShareView showTitle:nil detail:urlString image:nil url:nil type:SSDKContentTypeText];
        }
    }];
    shareBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[shareBarButtonItem];
    
}

- (BOOL)shouldAutorotate {
	HTAppDelegate *delegate = (HTAppDelegate *)[UIApplication sharedApplication].delegate;
	return [UIApplication sharedApplication].keyWindow == delegate.window;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}

- (void)playerDidExitFullscreen {
	[[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationNone];
	//	[[HTManagerController defaultManagerController] setDeviceOrientation:UIDeviceOrientationPortrait];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (!CGSizeEqualToSize(self.lastContentSize, scrollView.contentSize)) {
		[scrollView setContentOffset:CGPointZero animated:false];
	}
	self.lastContentSize = scrollView.contentSize;
}

- (void)didFinishLoad {
	[super didFinishLoad];
	WKWebView *webView = self.webView;
	NSString *resetImageSize = @"resizeImageWidth";
	NSString *resetImageScript = [NSString stringWithFormat:@"%@();", resetImageSize];
	CGFloat maxAllowImageWidth = [UIScreen mainScreen].bounds.size.width - 15;
	
	void(^javaScriptBlock)(NSString *javaScriptString, void(^complete)(id response)) = ^(NSString *javaScriptString, void(^complete)(id response)) {
		if (AX_WEB_VIEW_CONTROLLER_USING_WEBKIT) {
			[webView evaluateJavaScript:javaScriptString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
				if (complete) {
					complete(response);
				}
			}];
		} else {
			UIWebView *webView = (UIWebView *)webView;
			id response = [webView stringByEvaluatingJavaScriptFromString:javaScriptString];
			if (complete) {
				complete(response);
			}
		}
	};
	
	NSString *javaScriptImage = @"var script = document.createElement('script');"
	"script.type = 'text/javascript';"
	"script.text = \"function resizeImageWidth() {"
	"var image;"
	"var screenWidth = %f;"
	"for (i = 0; i < document.images.length; i ++) {"
	"image = document.images[i];"
	"if (image.width > screenWidth) {"
	"image.width = screenWidth"
	"}"
	"}"
	"}\";"
	"document.getElementsByTagName('head')[0].appendChild(script);";
	javaScriptImage = [NSString stringWithFormat:javaScriptImage, maxAllowImageWidth];
	
	NSString *javaScriptScale = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
	
	javaScriptBlock(javaScriptImage, ^(id response) {
		javaScriptBlock(resetImageScript, ^(id response) {
			javaScriptBlock(javaScriptScale, ^(id response) {
				
			});
		});
	});
	
#if AX_WEB_VIEW_CONTROLLER_USING_WEBKIT
	self.webviewTitle = [webView title];
#else
	self.webviewTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
#endif
	
}

- (void)updateNavigationItems {
	UIBarButtonItem *backBarButtonItem = [self valueForKey:@"navigationBackBarButtonItem"];
	[backBarButtonItem setTitleTextAttributes:self.navigationController.navigationBar.titleTextAttributes forState:UIControlStateNormal];
	backBarButtonItem.customView.tintColor = [UIColor whiteColor];
	
	UIBarButtonItem *closeBarButtonItem = [self valueForKey:@"navigationCloseBarButtonItem"];
	[self.navigationItem setLeftBarButtonItems:nil animated:NO];
	UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	spaceButtonItem.width = - 6.5;
	if (self.webView.canGoBack/* || self.webView.backForwardList.backItem*/) {// Web view can go back means a lot requests exist.
		self.navigationController.interactivePopGestureRecognizer.enabled = NO;
		if (self.navigationController.viewControllers.count == 1) {
			[self.navigationItem setLeftBarButtonItems:@[spaceButtonItem, backBarButtonItem, closeBarButtonItem] animated:NO];
		} else {
			[self.navigationItem setLeftBarButtonItems:@[spaceButtonItem, backBarButtonItem] animated:NO];
		}
	} else {
		self.navigationController.interactivePopGestureRecognizer.enabled = YES;
		[self.navigationItem setLeftBarButtonItems:@[spaceButtonItem, backBarButtonItem] animated:false];
	}
}

+ (instancetype)contactAdvisorWebController {
	NSString *urlString = @"http://p.qiao.baidu.com/im/index?siteid=7905926&ucid=18329536&cp=&cr=&cw=";
	NSMutableURLRequest *urlRequest = [[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] mutableCopy];
	[urlRequest setValue:@"http://www.gmatonline.cn/" forHTTPHeaderField:@"Referer"];
	HTWebController *webController = [[HTWebController alloc] initWithRequest:urlRequest];
	return webController;
}

@end
