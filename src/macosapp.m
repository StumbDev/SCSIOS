#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (strong, nonatomic) NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSRect frame = NSMakeRect(0, 0, 800, 600);
    self.window = [[NSWindow alloc] initWithContentRect:frame
                                               styleMask:(NSWindowStyleMaskTitled |
                                                          NSWindowStyleMaskClosable |
                                                          NSWindowStyleMaskResizable |
                                                          NSWindowStyleMaskMiniaturizable)
                                                 backing:NSBackingStoreBuffered
                                                   defer:NO];
    [self.window setTitle:@"SCSIOS Utility"];
    [self.window makeKeyAndOrderFront:nil];
    
    [self setupMenu];
    
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(20, 200, 200, 40)];
    [button setTitle:@"Perform Utility Task"];
    [button setTarget:self];
    [button setAction:@selector(performUtilityTask:)];
    [self.window.contentView addSubview:button];
}

- (void)setupMenu {
    NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];
    [NSApp setMainMenu:mainMenu];
    
    NSMenuItem *appMenuItem = [[NSMenuItem alloc] initWithTitle:@"Application" action:nil keyEquivalent:@""];
    [mainMenu addItem:appMenuItem];
    
    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"Application"];
    [appMenuItem setSubmenu:appMenu];
    
    NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
    [appMenu addItem:quitMenuItem];
    
    NSMenuItem *fileMenuItem = [[NSMenuItem alloc] initWithTitle:@"File" action:nil keyEquivalent:@""];
    [mainMenu addItem:fileMenuItem];
    
    NSMenu *fileMenu = [[NSMenu alloc] initWithTitle:@"File"];
    [fileMenuItem setSubmenu:fileMenu];
    
    NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:@"New" action:@selector(newDocument:) keyEquivalent:@"n"];
    [fileMenu addItem:newMenuItem];
    
    NSMenuItem *openMenuItem = [[NSMenuItem alloc] initWithTitle:@"Open" action:@selector(openDocument:) keyEquivalent:@"o"];
    [fileMenu addItem:openMenuItem];
    
    NSMenuItem *editMenuItem = [[NSMenuItem alloc] initWithTitle:@"Edit" action:nil keyEquivalent:@""];
    [mainMenu addItem:editMenuItem];
    
    NSMenu *editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
    [editMenuItem setSubmenu:editMenu];
    
    NSMenuItem *copyMenuItem = [[NSMenuItem alloc] initWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
    [editMenu addItem:copyMenuItem];
    
    NSMenuItem *pasteMenuItem = [[NSMenuItem alloc] initWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
    [editMenu addItem:pasteMenuItem];
}

- (void)performUtilityTask:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Utility Task"];
    [alert setInformativeText:@"Performing a utility task..."];
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    // For example, save application state or release resources
    NSLog(@"Application is terminating. Performing cleanup...");
    // Add any additional cleanup code here
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [app setDelegate:delegate];
        [app run];
    }
    return EXIT_SUCCESS;
}
#import <IOKit/IOKitLib.h>
#import <IOKit/usb/IOUSBLib.h>
#import <IOKit/firewire/IOFireWireLib.h>

@interface AppDelegate ()
- (void)setupUSBNotifications;
- (void)setupFireWireNotifications;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Existing code...
    
    [self setupUSBNotifications];
    [self setupFireWireNotifications];
}

- (void)setupUSBNotifications {
    // Setup USB device notifications
    IONotificationPortRef notificationPort;
    io_iterator_t addedIter;
    CFMutableDictionaryRef matchingDict;
    
    notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
    matchingDict = IOServiceMatching(kIOUSBDeviceClassName);
    
    IOServiceAddMatchingNotification(notificationPort,
                                     kIOMatchedNotification,
                                     matchingDict,
                                     USBDeviceAdded,
                                     (__bridge void *)(self),
                                     &addedIter);
    
    // Iterate existing devices
    USBDeviceAdded((__bridge void *)(self), addedIter);
}

void USBDeviceAdded(void *refCon, io_iterator_t iterator) {
    io_service_t usbDevice;
    while ((usbDevice = IOIteratorNext(iterator))) {
        // Handle USB device added
        NSLog(@"USB device added: %d", usbDevice);
        IOObjectRelease(usbDevice);
    }
}

- (void)setupFireWireNotifications {
    // Setup FireWire device notifications
    IONotificationPortRef notificationPort;
    io_iterator_t addedIter;
    CFMutableDictionaryRef matchingDict;
    
    notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
    matchingDict = IOServiceMatching("IOFireWireDevice");
    
    IOServiceAddMatchingNotification(notificationPort,
                                     kIOMatchedNotification,
                                     matchingDict,
                                     FireWireDeviceAdded,
                                     (__bridge void *)(self),
                                     &addedIter);
    
    // Iterate existing devices
    FireWireDeviceAdded((__bridge void *)(self), addedIter);
}

void FireWireDeviceAdded(void *refCon, io_iterator_t iterator) {
    io_service_t fireWireDevice;
    while ((fireWireDevice = IOIteratorNext(iterator))) {
        // Handle FireWire device added
        NSLog(@"FireWire device added: %d", fireWireDevice);
        IOObjectRelease(fireWireDevice);
    }
}

@end