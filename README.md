# xojo_processinfo
 ProcessInfo class for use in macOS &amp; iOSXojo projects



## Usage

1. Copy the ProcessInfo class into your project.
2. You can call any of the methods on this class by simply prefixing with `ProcessInfo.Info` or `ProcessInfo.Version`

```Xojo
If ProcessInfo.Version >= "13.2" Then
    // Do something specific to OS version 13.2 or higher
End If
```

Check the API.md file for compatibility as some methods are macOS only.