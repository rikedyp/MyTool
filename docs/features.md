# Features

## Get version
The `Version` function is used to get the current version of MyTool:
```APL
      MyTool.Version
```

## List releases
List information about releases from a repository specified by a URL.

The result is a 3-column matrix where each row consists of three character vectors:

|tag_name|compatible_dyalog_version|asset_url|
|---|---|---|
|The full commit tag for that release|A string in the format described by [the tool versions formats](toolversions.md#what-dyalog-versions-are-compatible-with-this-version-of-mytool)|A URL to the first asset of the release\*|

> \*For draft releases, this is a file which is manually uploaded to the draft release notes via the GitHub interface. A markdown link is then included as the 2nd line of the draft release notes. For example, the release notes for `v0.0.170-1`:

>        Works with Dyalog versions: 17.0-
>        [MyTool.zip](https://github.com/rikedyp/MyTool/files/6090514/MyTool.zip)

**Example usage:**
```APL
      MyTool.ListReleases'https://github.com/rikedyp/MyTool'
┌──────────────────────────────────────────────┬──────┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│0.0.5-5f20d6c051fb725c5a51343638fc2bf6bd7809b0│ 17.0-│https://github.com/rikedyp/MyTool/releases/download/0.0.5-5f20d6c051fb725c5a51343638fc2bf6bd7809b0/MyTool.apln│
├──────────────────────────────────────────────┼──────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│0.0.4-90ffa7e6b203e52468c113c72af75bff9d411f65│ 17.0-│https://github.com/rikedyp/MyTool/releases/download/0.0.4-90ffa7e6b203e52468c113c72af75bff9d411f65/MyTool.apln│
└──────────────────────────────────────────────┴──────┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

### List draft releases
The path to a credentials text file may be supplied as an optional left argument.  
This will enable listing of draft releases if the credentials match a GitHub user with sufficient permissions.

**Example usage:**
```APL
      '\g\MyTool\credentials'MyTool.ListReleases'https://github.com/rikedyp/MyTool'
┌──────────────────────────────────────────────────┬──────┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│0.0.170-1-5a38d4dabc0218d5ffc8f9cd9d39a7b2cda1c97e│ 17.0-│https://github.com/rikedyp/MyTool/files/6090514/MyTool.zip                                                    │
├──────────────────────────────────────────────────┼──────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│0.0.5-5f20d6c051fb725c5a51343638fc2bf6bd7809b0    │ 17.0-│https://github.com/rikedyp/MyTool/releases/download/0.0.5-5f20d6c051fb725c5a51343638fc2bf6bd7809b0/MyTool.apln│
├──────────────────────────────────────────────────┼──────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│0.0.4-90ffa7e6b203e52468c113c72af75bff9d411f65    │ 17.0-│https://github.com/rikedyp/MyTool/releases/download/0.0.4-90ffa7e6b203e52468c113c72af75bff9d411f65/MyTool.apln│
└──────────────────────────────────────────────────┴──────┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

```

## Get tool release asset URL
The `GetURL` function takes a 2-element list argument and returns a character vector of the URL of the first asset specified in the release chosen [according to the tool version selection procedure](../toolversions/#what-version-of-this-tool-is-included-with-this-build-of-dyalog).

```APL
      MyTool.GetURL'rikedyp/MyTool' 17
https://github.com/rikedyp/MyTool/files/6090514/MyTool.zip
```

### JSON WebService API
The tools version selection tool `MyTool/GetURL` can also be run as a web service.

The API can be accessed using a `POST` request with a JSON payload. An example request is given below:
```
POST /GetURL HTTP/1.1         
                              
Host: localhost:8080          
                              
Content-Type: application/json
                              
User-Agent: Dyalog/Conga      
                              
Accept: */*                   
                              
Content-Length: 21            
                              
Accept-Encoding: gzip, deflate
                              
                              
                              
["rikedyp/MyTool",18]    
```

#### Serve on macOS and Linux
```APL
dyalog LOAD=MyTool.apln
```

#### Serve on Microsoft Windows
**Right click** `MyTool.apln` → **Run**.

