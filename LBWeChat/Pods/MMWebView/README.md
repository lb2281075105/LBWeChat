# MMWebView

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ChellyLau/MMWebView/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/MMWebView.svg?style=flat)](http://cocoapods.org/?q=MMWebView)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/MMWebView.svg?style=flat)](http://cocoapods.org/?q=MMWebView)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%209.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;


`MMWebView`继承于`WKWebView`，按照`UIWebViewDelegate`的方式，重写`WKNavigationDelegate`，并增加进度和标题的代理。写本控件的初衷是因为公司项目中多使用`UIWebView`，为了优化内存、添加侧滑返回和进度条，如果直接改成`WKWebView`，工作量比较大，所以写了`MMWebView`。


**PS**：有童靴给我[留言](https://github.com/ChellyLau/MMWebView/issues)：本控件与[WebViewJavascriptBridge](https://github.com/marcuswestin/WebViewJavascriptBridge)冲突，确实存在代理冲突，因此新版本中加入了[WebViewJavascriptBridge](https://github.com/marcuswestin/WebViewJavascriptBridge)，详见本控件代码。


## 功能介绍

1. 支持右滑(侧滑)返回；
2. 支持进度条；
3. 支持清理缓存；
4. 支持OC与Web交互。

## 使用 

1. `pod "MMWebView"`;
2. `pod install` / `pod update`;
3. `#import <MMWebView.h>`.

## 示例

```objc
NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
NSString * appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
NSURL * baseURL = [NSURL fileURLWithPath:htmlPath];
    
_webView = [[MMWebView alloc] initWithFrame:self.view.bounds];
_webView.delegate = self;
_webView.displayProgressBar = YES; // 显示进度条
 _webView.allowBackGesture = YES;  // 允许侧滑返回
[_webView setupJSBridge];  // JS交互
[_webView registerHandler:@"testObjcCallback" handler:^(id data, WVJSResponseCallback responseCallback) {
    responseCallback(@"Response from testObjcCallback");
}];
[_webView callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
[_webView loadHTMLString:appHtml baseURL:baseURL];
[self.view addSubview:_webView];
```

## 属性

```objc
// 代理
@property (nonatomic, assign) id<MMWebViewDelegate> delegate;
// 是否显示进度条[默认 NO]
@property (nonatomic, assign) BOOL displayProgressBar;
// 是否允许侧滑返回[默认 NO]
@property (nonatomic, assign) BOOL allowBackGesture;
// displayProgressBar为YES时可用
@property (nonatomic, strong) UIColor *progressTintColor;
// displayProgressBar为YES时可用
@property (nonatomic, strong) UIColor *trackTintColor;
```

## 方法

```objc
// 清缓存
- (void)clearCache;

// JS相关
- (void)setupJSBridge; // 需先setup，否则以下方法无效
- (void)registerHandler:(NSString *)handlerName handler:(WVJSHandler)handler;
- (void)removeHandler:(NSString *)handlerName;
- (void)callHandler:(NSString *)handlerName;
- (void)callHandler:(NSString *)handlerName data:(id)data;
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJSResponseCallback)responseCallback;
- (void)reset;
```


## 代理

`MMWebViewDelegate`仅包含常用代理，如果不能满足使用，请给我[留言](https://github.com/ChellyLau/MMWebView/issues)，我会及时添加。


```objc
@protocol MMWebViewDelegate <NSObject>
@optional
// 网页加载进度
- (void)webView:(MMWebView *)webView estimatedProgress:(CGFloat)progress;
// 网页标题更新
- (void)webView:(MMWebView *)webView didUpdateTitle:(NSString *)title;
// 网页开始加载
- (BOOL)webView:(MMWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType;
// 网页开始加载
- (void)webViewDidStartLoad:(MMWebView *)webView;
// 网页完成加载
- (void)webViewDidFinishLoad:(MMWebView *)webView;
// 网页加载出错
- (void)webView:(MMWebView *)webView didFailLoadWithError:(NSError *)error;

@end
```

## 清缓存

本控件是清除所有缓存，也可以清理指定缓存，所有缓存类型如下：

```objc
 NSString * const WKWebsiteDataTypeDiskCache；
 NSString * const WKWebsiteDataTypeMemoryCache；
 NSString * const WKWebsiteDataTypeOfflineWebApplicationCache；
 NSString * const WKWebsiteDataTypeCookies；
 NSString * const WKWebsiteDataTypeSessionStorage；
 NSString * const WKWebsiteDataTypeLocalStorage；
 NSString * const WKWebsiteDataTypeWebSQLDatabases；
 NSString * const WKWebsiteDataTypeIndexedDBDatabases；
```

清理缓存

```objc
// 清缓存
[_webView clearCache];
```
 
 具体实现如下：
 
```objc
- (void)clearCache
{
    // 所有类型缓存[详见WKWebsiteDataRecord]
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    // 所有时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    // 移除
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                               modifiedSince:date
                                           completionHandler:^{
                                               
                                           }];
}
``` 

## 后记

本控件中JSBridge来自[WebViewJavascriptBridge](https://github.com/marcuswestin/WebViewJavascriptBridge)，感谢[marcuswestin](https://github.com/marcuswestin)为我们带来的便捷。本控件不定时更新，如有问题欢迎给我[留言](https://github.com/ChellyLau/MMWebView/issues)，我会及时回复。如果这个工具对你有一些帮助，请给我一个star，谢谢🌹🌹。



