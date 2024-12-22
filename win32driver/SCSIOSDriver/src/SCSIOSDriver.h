#ifndef SCSIOS_DRIVER_H
#define SCSIOS_DRIVER_H

// Function prototypes
NTSTATUS SCSIOSDriverEntry(PDRIVER_OBJECT DriverObject, PUNICODE_STRING RegistryPath);
void SCSIOSDriverUnload(PDRIVER_OBJECT DriverObject);
NTSTATUS SCSIOSHandleDeviceIoControl(PDEVICE_OBJECT DeviceObject, PIRP Irp);
NTSTATUS SCSIOSHandleUsbEvent(PDEVICE_OBJECT DeviceObject, PVOID EventData);

// Data structures
typedef struct _SCSIOS_DEVICE_EXTENSION {
    PDEVICE_OBJECT DeviceObject;
    // Add other device-specific data here
} SCSIOS_DEVICE_EXTENSION, *PSCSIOS_DEVICE_EXTENSION;

// Constants
#define SCSIOS_DRIVER_NAME L"SCSIOSDriver"
#define SCSIOS_DEVICE_NAME L"\\Device\\SCSIOSDevice"

#endif // SCSIOS_DRIVER_H