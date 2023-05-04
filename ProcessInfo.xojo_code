#tag Class
Protected Class ProcessInfo
	#tag DelegateDeclaration, Flags = &h0, Description = 4D6574686F64207369676E617475726520666F7220706572666F726D696E672061637469766974696573
		Delegate Sub ActivityMethod()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Arguments() As String()
		  // Returns the arguments that were passed to the current process
		  #If TargetMacOS Or TargetIOS
		    // @property(readonly, copy) NSArray<NSString *> *arguments;
		    Declare Function getArguments Lib "Foundation" Selector "arguments" (obj As ptr) As Ptr
		    Declare Function count Lib "Foundation" Selector "count" (obj As ptr) As Integer
		    Declare Function stringAtIndex Lib "Foundation" Selector "objectAtIndex:" (obj As ptr, index As Integer) As CFStringRef
		    
		    Dim args As ptr = getArguments(mObj)
		    Dim c As Integer = count(args)
		    
		    Dim rv() As String
		    For i As Integer = 0 To c-1
		      rv.add stringAtIndex(args, i)
		    Next
		    
		    Return rv
		    
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function AutomaticTerminationSupportEnabled() As Boolean
		  // Returns True if Automatic Termination is supported
		  
		  #If TargetMacOS
		    // @property BOOL automaticTerminationSupportEnabled;
		    Declare Function getAutomaticTerminationSupportEnabled Lib "Foundation" Selector "automaticTerminationSupportEnabled" (obj As ptr) As Boolean
		    
		    Return getAutomaticTerminationSupportEnabled(mObj)
		    
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeginActivity(reason as string, paramarray options as NSActivityOptions) As Ptr
		  // Starts an activity which allows preventing the system to sleep (and other options). You should keep the returned pointer for use with the EndActivity method.
		  
		  #If TargetMacOS Or TargetIOS
		    // - (id<NSObject>)beginActivityWithOptions:(NSActivityOptions)options reason:(NSString *)reason;
		    Declare Function beginActivityWithOptions_reason Lib "Foundation" Selector "beginActivityWithOptions:reason:" ( obj As ptr , options As UInt64 , reason As CFStringRef ) As Ptr
		    
		    Dim opts As UInt64
		    For i As Integer = 0 To UBound(options)
		      opts = Bitwise.BitOr(opts, CType(options(i), UInt64))
		    Next
		    
		    Return beginActivityWithOptions_reason(mObj, opts, reason)
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // prevent users from creating these
		  
		  // @property(class, readonly, strong) NSProcessInfo *processInfo;
		  Declare Function getProcessInfo Lib "Foundation" Selector "processInfo" (cls As ptr) As Ptr
		  Declare Function NSClassFromString Lib "Foundation" (name As cfstringref) As ptr
		  
		  mObj = getProcessInfo(NSClassFromString("NSProcessInfo"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub DisableAutomaticTermination(reason as string)
		  // Disables automatic termination (macOS)
		  #If TargetMacOS
		    // - (void)disableAutomaticTermination:(NSString *)reason;
		    Declare Sub disableAutomaticTermination Lib "Foundation" Selector "disableAutomaticTermination:" ( obj As ptr , reason As CFStringRef )
		    
		    disableAutomaticTermination(mObj, reason)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub DisableSuddenTermination()
		  // Disables sudden termination (macOS)
		  #If TargetMacOS
		    // - (void)disableSuddenTermination;
		    Declare Sub disableSuddenTermination Lib "Foundation" Selector "disableSuddenTermination" (obj As ptr)
		    
		    disableSuddenTermination(mObj)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub EnableAutomaticTermination(reason as string)
		  // Enables automatic termination (macOS)
		  #If TargetMacOS
		    // - (void)enableAutomaticTermination:(NSString *)reason;
		    Declare Sub enableAutomaticTermination Lib "Foundation" Selector "enableAutomaticTermination:" ( obj As ptr , reason As CFStringRef )
		    
		    enableAutomaticTermination(mObj, reason)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub EnableSuddenTermination()
		  // Enables sudden termination (macOS)
		  #If TargetMacOS
		    // - (void)enableSuddenTermination;
		    Declare Sub enableSuddenTermination Lib "Foundation" Selector "enableSuddenTermination" (obj As ptr)
		    
		    enableSuddenTermination(mObj)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndActivity(obj as ptr)
		  // Ends an activity which was started with the BeginActivity method
		  #If TargetMacOS Or TargetIOS
		    // - (void)endActivity:(id<NSObject>)activity;
		    Declare Sub endActivity Lib "Foundation" Selector "endActivity:" ( obj As ptr , activity As Ptr )
		    
		    endActivity(mObj, obj)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Environment() As Dictionary
		  // Returns the environment that was passed to the current process
		  #If TargetMacOS Or TargetIOS
		    // @property(readonly, copy) NSDictionary<NSString *,NSString *> *environment;
		    Declare Function getEnvironment Lib "Foundation" Selector "environment" (obj As ptr) As Ptr
		    // @property(readonly, copy) NSArray<KeyType> *allKeys;
		    Declare Function getAllKeys Lib "Foundation" Selector "allKeys" (obj As ptr) As Ptr
		    Declare Function count Lib "Foundation" Selector "count" (obj As ptr) As Integer
		    Declare Function objectAtIndex Lib "Foundation" Selector "objectAtIndex:" (obj As ptr, index As Integer) As CFStringRef
		    // - (ObjectType)valueForKey:(NSString *)key;
		    Declare Function objectForKey Lib "Foundation" Selector "objectForKey:" ( obj As ptr , key As CFStringRef ) As CFStringRef
		    
		    Dim env As ptr = getEnvironment(mObj)
		    
		    Dim keyarray As ptr = getAllKeys(env)
		    Dim c As Integer = count(keyarray)
		    
		    Dim rv As New Dictionary
		    
		    For i As Integer = 0 To c-1
		      Dim key As String = objectAtIndex(keyarray, i)
		      Dim value As String = objectForKey(env, key)
		      rv.Value(key) = value
		    Next
		    
		    Return rv
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function fnAvailable(minMacOSversion as string, minIOSVersion as string) As Boolean
		  Dim v As Integer = -1
		  #If TargetMacOS
		    v = Operator_Compare(minMacOSversion)
		  #ElseIf TargetIOS
		    v = Operator_Compare(minIOSVersion)
		  #EndIf
		  
		  return v >= 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Info() As ProcessInfo
		  If mSharedVersion = Nil Then
		    mSharedVersion = New ProcessInfo
		  End If
		  
		  Return mSharedVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(version as string) As Integer
		  #If TargetMacOS Or TargetIOS
		    Dim v As NSOperatingSystemVersion = Self.SystemVersion
		    
		    Dim parts() As String = Split(version, ".")
		    While UBound(parts) < 2
		      parts.Add "0"
		    Wend
		    
		    Dim s As Integer = Sign(v.MajorVersion - Val(parts(0)))
		    If s <> 0 Then
		      Return s
		    End If
		    
		    s = Sign(v.MinorVersion - Val(parts(1)))
		    If s<>0 Then
		      Return s
		    End If
		    
		    Return Sign(v.PatchVersion - Val(parts(2)))
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PerformActivity(reason as string, method as ActivityMethod, paramarray options as NSActivityOptions)
		  // Performs an activity in a particular method
		  
		  #If TargetMacOS Or TargetIOS
		    // - (void)performActivityWithOptions:(NSActivityOptions)options reason:(NSString *)reason usingBlock:(void (^)(void))block;
		    Declare Sub performActivityWithOptions_reason_usingBlock Lib "Foundation" Selector "performActivityWithOptions:reason:usingBlock:" ( obj As ptr , options As UInt64 , reason As CFStringRef , block As Ptr )
		    
		    Dim opts As UInt64
		    For i As Integer = 0 To UBound(options)
		      opts = Bitwise.BitOr(opts, CType(options(i), UInt64))
		    Next
		    
		    Dim bl As New ObjCBlock(method)
		    
		    performActivityWithOptions_reason_usingBlock(mObj, opts, reason, bl.Handle)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Version() As ProcessInfo
		  If mSharedVersion = Nil Then
		    mSharedVersion = New ProcessInfo
		  End If
		  
		  Return mSharedVersion
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the user's full name (macOS)
			  #If TargetMacOS
			    // @property(readonly, copy) NSString *fullUserName;
			    Declare Function getFullUserName Lib "Foundation" Selector "fullUserName" (obj As ptr) As CFStringRef
			    
			    Return getFullUserName(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		FullUsername As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the globally unique identifier for the current process
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly, copy) NSString *globallyUniqueString;
			    Declare Function getGloballyUniqueString Lib "Foundation" Selector "globallyUniqueString" (obj As ptr) As CFStringRef
			    
			    Return getGloballyUniqueString(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		GUID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns true if the current process is an iOS app running on macOS
			  
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly, getter=isiOSAppOnMac) BOOL iOSAppOnMac;
			    Declare Function isiOSAppOnMac Lib "Foundation" Selector "isiOSAppOnMac" (obj As ptr) As Boolean
			    
			    If fnAvailable("11", "14") Then
			      Return isiOSAppOnMac(mObj)
			    End If
			    
			    Return False
			  #EndIf
			End Get
		#tag EndGetter
		iOSAppOnMac As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mObj As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mSharedVersion As ProcessInfo
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the process identifier for the current process
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) int processIdentifier;
			    Declare Function getProcessIdentifier Lib "Foundation" Selector "processIdentifier" (obj As ptr) As Integer
			    
			    Return getProcessIdentifier(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		ProcessID As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the name of the current process
			  #If TargetMacOS Or TargetIOS
			    // @property(copy) NSString *processName;
			    Declare Function getProcessName Lib "Foundation" Selector "processName" (obj As ptr) As CFStringRef
			    
			    Return getProcessName(mObj)
			  #EndIf
			End Get
		#tag EndGetter
		ProcessName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the number of active processors
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) NSUInteger activeProcessorCount;
			    Declare Function getActiveProcessorCount Lib "Foundation" Selector "activeProcessorCount" (obj As ptr) As Integer
			    
			    Return getActiveProcessorCount(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		SystemActiveProcessorCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the system hostname
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly, copy) NSString *hostName;
			    Declare Function getHostName Lib "Foundation" Selector "hostName" (obj As ptr) As CFStringRef
			    
			    Return getHostName(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		SystemHostname As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns True if the current system is in low power mode (macOS 12, iOS 9)
			  #If TargetMacOS Or TargetIOS
			    
			    // @property(readonly, getter=isLowPowerModeEnabled) BOOL lowPowerModeEnabled;
			    Declare Function isLowPowerModeEnabled Lib "Foundation" Selector "isLowPowerModeEnabled" (obj As ptr) As Boolean
			    
			    If fnAvailable("12", "9") Then
			      Return isLowPowerModeEnabled(mObj)
			    End If
			    
			    Return False
			  #EndIf
			End Get
		#tag EndGetter
		SystemLowPowerModeEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the system's physical memory in bytes
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) unsigned long long physicalMemory;
			    Declare Function getPhysicalMemory Lib "Foundation" Selector "physicalMemory" (obj As ptr) As UInt64
			    
			    Return getPhysicalMemory(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		SystemPhysicalMemory As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the number of processor cores
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) NSUInteger processorCount;
			    Declare Function getProcessorCount Lib "Foundation" Selector "processorCount" (obj As ptr) As Integer
			    
			    Return getProcessorCount(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		SystemProcessorCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the current thermal state of the system
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) NSProcessInfoThermalState thermalState;
			    Declare Function getThermalState Lib "Foundation" Selector "thermalState" (obj As ptr) As Integer
			    
			    If fnAvailable("10.10.3", "11") Then
			      Return CType(getThermalState(mObj), NSProcessInfoThermalState)
			    End If
			    
			    Return NSProcessInfoThermalState.NotSupported
			  #EndIf
			End Get
		#tag EndGetter
		SystemThermalState As NSProcessInfoThermalState
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the amount of time the system has been awake since the last time it was restarted, in seconds
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) NSTimeInterval systemUptime;
			    Declare Function getSystemUptime Lib "Foundation" Selector "systemUptime" (obj As ptr) As Double
			    
			    Return getSystemUptime(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		SystemUptime As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the operating system version as an NSOperatingSystemVersion structure
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly) NSOperatingSystemVersion operatingSystemVersion;
			    Declare Function getOperatingSystemVersion Lib "Foundation" Selector "operatingSystemVersion" (obj As ptr) As NSOperatingSystemVersion
			    
			    Return getOperatingSystemVersion(mObj)
			  #EndIf
			End Get
		#tag EndGetter
		SystemVersion As NSOperatingSystemVersion
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns a string that shows the operating system version and build number
			  #If TargetMacOS Or TargetIOS
			    // @property(readonly, copy) NSString *operatingSystemVersionString;
			    Declare Function getOperatingSystemVersionString Lib "Foundation" Selector "operatingSystemVersionString" (obj As ptr) As CFStringRef
			    
			    Return getOperatingSystemVersionString(mObj)
			  #EndIf
			End Get
		#tag EndGetter
		SystemVersionString As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns the user's username (macOS)
			  #If TargetMacOS
			    // @property(readonly, copy) NSString *userName;
			    Declare Function getUserName Lib "Foundation" Selector "userName" (obj As ptr) As CFStringRef
			    
			    Return getUserName(mObj)
			    
			  #EndIf
			End Get
		#tag EndGetter
		Username As String
	#tag EndComputedProperty


	#tag Structure, Name = NSOperatingSystemVersion, Flags = &h0, Description = 412073747275637475726520666F722073746F72696E6720746865206F7065726174696E672073797374656D2076657273696F6E
		MajorVersion as Integer
		  MinorVersion as Integer
		PatchVersion as Integer
	#tag EndStructure


	#tag Enum, Name = NSActivityOptions, Type = UInt64, Flags = &h0, Description = 526561736F6E7320666F722075736520776974682074686520506572666F726D416374697669747920616E6420426567696E4163746976697479206D6574686F6473
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
	#tag EndEnum

	#tag Enum, Name = NSProcessInfoThermalState, Type = Integer, Flags = &h0, Description = 546865726D616C20737461746573
		NotSupported = -1
		  Nominal
		  Fair
		  Serious
		Critical
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
