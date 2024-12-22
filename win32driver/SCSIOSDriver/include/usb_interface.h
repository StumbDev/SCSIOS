#ifndef USB_INTERFACE_H
#define USB_INTERFACE_H

// Function prototypes for USB communication
void InitializeUSBInterface(void);
void CleanupUSBInterface(void);
int SendDataToUSB(const void* data, size_t length);
int ReceiveDataFromUSB(void* buffer, size_t length);
void HandleUSBDeviceEvent(int eventType);

#endif // USB_INTERFACE_H