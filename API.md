# ProcessInfo Class
## Delegates
**Delegate Sub ActivityMethod()**
Method signature for performing activities

## Methods
**Arguments() As String()**
Returns the arguments that were passed to the current process

**AutomaticTerminationSupportEnabled() As Boolean**
Returns True if Automatic Termination is supported

**BeginActivity(reason as string, paramarray options as NSActivityOptions) As Ptr**
Starts an activity which allows preventing the system to sleep (and other options). You should keep the returned pointer for use with the EndActivity method.

**DisableAutomaticTermination(reason as string)**
Disables automatic termination (macOS)

**DisableSuddenTermination()**
Disables sudden termination (macOS)

**EnableAutomaticTermination(reason as string)**
Enables automatic termination (macOS)

**EnableSuddenTermination()**
Enables sudden termination (macOS)

**EndActivity(obj as ptr)**
Ends an activity which was started with the BeginActivity method

**Environment() As Dictionary**
Returns the environment that was passed to the current process

**Shared Info() As ProcessInfo**
Shared. Returns the shared ProcessInfo object. This method exists for code readability and does the exact same thing as the Version method. 

**Shared Version() as ProcessInfo**
Shared. Returns the shared ProcessInfo object. This method exists for code readability and does the exact same thing as the Info method. 

**Operator_Compare(version as string) As Integer**
Compares the passed string with the operating system so you can easily check if the user is running the necessary OS version for the feature you are implementing.

**PerformActivity(reason as string, method as ActivityMethod, paramarray options as NSActivityOptions)**
Performs an activity in a particular method

## Properties
**FullUsername As String (Read Only)**
Returns the user's full name (macOS)

**GUID As String (Read Only)**
Returns the globally unique identifier for the current process

**iOSAppOnMac As Boolean (Read Only)**
Returns true if the current process is an iOS app running on macOS

**ProcessID As Integer (Read Only)**
Returns the process identifier for the current process

**ProcessName As String (Read Only)**
Returns the name of the current process

**SystemActiveProcessorCount As Integer (Read Only)**
Returns the number of active processors

**SystemHostname As String (Read Only)**
Returns the system hostname

**SystemLowPowerModeEnabled As Boolean (Read Only)**
Returns True if the current system is in low power mode (macOS 12, iOS 9)

**SystemPhysicalMemory As UInt64 (Read Only)**
Returns the system's physical memory in bytes

**SystemProcessorCount As Integer (Read Only)**
Returns the number of processor cores

**SystemThermalState As NSProcessInfoThermalState (Read Only)**
Returns the current thermal state of the system

**SystemUptime As Double (Read Only)**
Returns the amount of time the system has been awake since the last time it was restarted, in seconds

**SystemVersion As NSOperatingSystemVersion (Read Only)**
Returns the operating system version as an NSOperatingSystemVersion structure

**SystemVersionString As String (Read Only)**
Returns a string that shows the operating system version and build number

**Username As String (Read Only)**
Returns the user's username (macOS)

## Structures
**Structure NSOperatingSystemVersion**
A structure for storing the operating system version
MajorVersion as Integer
MinorVersion as Integer
PatchVersion as Integer

## Enums
**Enumeration NSActivityOptions**
Reasons for use with the PerformActivity and BeginActivity methods
Background = 255
SuddenTerminationDisabled = 16384
AutomaticTerminationDisabled = 32768
IdleSystemSleepDisabled = 1048576
UserInitiatedAllowingIdleSystemSleep = 15728639
UserInitiated = 16777215
LatencyCritical = 1095216660480
IdleDisplaySleepDisabled = 1099511627776
AnimationTrackingEnabled = 35184372088832
TrackingEnabled = 70368744177664
UserInteractive = 1095233437695

**Enumeration NSProcessInfoThermalState**
Thermal states
NotSupported = -1
Nominal = 0
Fair = 1
Serious = 2
Critical = 3

