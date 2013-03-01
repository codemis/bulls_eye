#import "InfoViewController.h"
@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation InfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.webView loadData:htmlData
                  MIMEType:@"text/html"
          textEncodingName:@"UTF-8"
                   baseURL:baseURL];
}
@end
