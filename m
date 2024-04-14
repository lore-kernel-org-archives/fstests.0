Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB810949
	for <fstests@vger.kernel.org>; Sun, 14 Apr 2024 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713056543; cv=fail; b=ds87QGYh6HsihDUek39R+zIs7Ztg9sTCO+qOLGBKVA40MVCZxZbAO8y5dNFLmXGTPjYggeiIjgdoVVF5bDoSV1uu4nkIdmhmYejRpM+zUSqMHve0yeZwGUoP12ApSdmP+Dg5aWmgkVlkLb/A8BJ0JBZ56w9N+qKTq85WaQxxPF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713056543; c=relaxed/simple;
	bh=k3GYyFQcGA9u6cJOkyYBSdLcTaMMtDJJDYH/olPm+58=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMf/q3fnOOfA9Arvmojj9QUBcZZKM/uuKqrnFxAmIBXeMKyas2TZ2eiACSevnjrT+a4AigH75Hej4O6DujaeIy75RoHy8uwnOMHhnA0yIzN2gKzA/Aj2x69/D/jjJTqUIltHV8yuqnSasnTf8MG7+o6IV47+uL/eQ/Gj3cG5vzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OSDvzhey; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JKWTGQtK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSDvzhey";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JKWTGQtK"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43E101f6007709;
	Sun, 14 Apr 2024 01:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=k3GYyFQcGA9u6cJOkyYBSdLcTaMMtDJJDYH/olPm+58=;
 b=OSDvzheydCv6g0WnmuJJpZikNfMy1vI7d2YQotAHDiJXIEEyokld/Tv+awhNWnI0gkaS
 3F3hc0Ywul9mxtxtoJDFVMIcecmjRlDuh34oE0I2Oq7Hw8nJPG91Alh34bQM/2kGo8qM
 8Tsp+XjTlL9O+mVOfb/fGE+cIDgxR8nFeImB6uwCnVOtrpLSk/WbhbndRw9jHE9gaAgs
 WR2eifH1Fwao249Mpqn6tlT53TFfbgRod3Sc18g/9cvHxTBefbBON6hWkwUDBhZmm6hX
 Hs4i5YnknlYl4iPEXITWBlCwYw8IOtl0H5RuBJsxABBNxtrhafE1qCbeVJCR3YwHPWAj aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv0tsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 01:02:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43DMqGxH029278;
	Sun, 14 Apr 2024 01:02:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg4f0d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 01:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOAmszBIPQ1ozXlp4HGxLfyPOFRqkXIb9snAeXsuA7k6RXhAodGEaSJEJiQsdp35s5TASSU1YHsY1vmzki0MnVcEoa9/ao29tParvgVFo7PB78Y0EfK4P5h0ljKrBbhM3nLqh1JGsk9RqcsJVI77BT7NpsBM4JujynpNRzljBbAsmaiJqkMIFFytLjzM55PxGEj5JRB5xc3zAEyNNIBCHBbBYiuc/uQq6TsPddQtTSre0P19VMFEBernACO6+UlkHtQwoRd0wCCzAaSaYE2Z3mEOSXeAcs2n2U1ezRtGynE0rYkJMqyrhhW6/fWTfHCMapOKAe3ZbHb6ywBFZA6v3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3GYyFQcGA9u6cJOkyYBSdLcTaMMtDJJDYH/olPm+58=;
 b=HOcQAzSsVw6qCf5IdghT2DU5gBIuUISSNkuMch7G40SDifoT7MW1MzMhBbOIHuPRj+hkOr5VrFQw0nfELJsGOLJXoWIgW1xlJYF1XwfINv5F3ltZNuenLTjOOMSZbPgeleroCBWwSw/wo8U36nbT5hKMdfVFHSnK0pLl7fddHd5W4HVfbyjn8ZS9hbyg5tdVrdhueK2W6Iq9bf+RCApsnJkfrTzGP7gnhhVkyTed0UucHnV5cFZBrDutXKur3HIqlQmkYgyxeZ8pfjxtPuOESonW1KnVimXQDJ6gztGrnLH0IghKdbnPoTOuktdC2Og9gILOiAiYptLFF4cBq4Wz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3GYyFQcGA9u6cJOkyYBSdLcTaMMtDJJDYH/olPm+58=;
 b=JKWTGQtKOp+8g/5elmmYW8WRmwzGTcyHsLEaK/lQxauURAg8pKSiMu5A84k4FTP/1/w7uQ0X6e7nq8RTuliMAKq4BSPbc5RVTi8h0tqTZfkYcd0wTsK3KPU86cwKw+BOTsyP0Jwv/lnTwXcjoudhxW+om3WEv6NkxUF56l9sbxY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6899.namprd10.prod.outlook.com (2603:10b6:208:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 14 Apr
 2024 01:02:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Sun, 14 Apr 2024
 01:02:17 +0000
Message-ID: <9750380b-b893-4a0a-8494-e6d9ffad7961@oracle.com>
Date: Sun, 14 Apr 2024 09:02:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove useless comments
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
References: <20240409133234.3374-1-dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240409133234.3374-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 631c09ac-9c21-446b-73aa-08dc5c1e8713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YzljNCtxT2I3V2tpWmY4SXJhaGF2Rmw5K21kTzNReGFVcWxkeDUzOW5WV0Ri?=
 =?utf-8?B?d3k0RHF0QmVxUC9DK290ZGFndkE3VmZpc0RseG5SWHdHd1U1TFVuUVFHb2pt?=
 =?utf-8?B?YmlzbXVubmVHQUpIaHdnKzkyMWtIcks2YnYveVNkbU5iVkZZNzRVcndFb3ZR?=
 =?utf-8?B?NU8vNzVaajFMdjRSRE1TemdWUDFuT0dZQkxsL3g1azVBRW10dGlTMGpENUVo?=
 =?utf-8?B?UFRIOFpHWXNoaWIrekhtVmZ4WXhLS0tsRFpxdVBEK25vMnMvL3A2cXYydEZE?=
 =?utf-8?B?YXJvQXpyTTFPTEtLUmVzUUxibjE5U1FsYU5jMVpxOGpIelBiVnhGSmZDbE1M?=
 =?utf-8?B?dC9NRlJ5MmI0L1pCNUJ5MkFrdHJLcDBpNVM0OXlMYS9lTDZxRFNWYWxKb0hV?=
 =?utf-8?B?TE5oNk50aXRWOHhxc0psRmR5L2JqRnE5Ly9uK3pULzg1Rzl5YlUrUDdzWmQz?=
 =?utf-8?B?cVdoM0ZrT290aWNqSTZ6eTg3NFdnc0paUlU2V3NncjUycEoya0x3dkJLR0do?=
 =?utf-8?B?MEhQYkpSb0l6U2JkR0NSZXhpbFJ1THJQK2Uxd3gwTkd6MzVQL2hpN0IyMHUz?=
 =?utf-8?B?YlZTeStLSjVHYkJMdnNwY2VjQ1J4NXVhc1JtTGdhNkl2VlFWemhCZG05TlJ2?=
 =?utf-8?B?OUc1S01sejNjZlp6dFV5MzBwZmV0R3FkRjZjdGRWOFhyVXFXZTM1TVdLZGVU?=
 =?utf-8?B?RkFxSzMwbFZOSjFCOWdaRy9ubW4zQWN1Q0JlMVRxZTZxdEtlZENmUW9qM3Zy?=
 =?utf-8?B?aU5DOUNjMjRWZ2NJWUtaeXZQOWhMK1UzYml2WjJOS2J5bXpnYUlmdzBSQUVw?=
 =?utf-8?B?ZVZZVUVqN3pieWxhUENhdFBURDQwNFAwdVBvb1E4MjZIbm5ESkFoWmVndzhh?=
 =?utf-8?B?RXdTSDdxMDdOSHJ0WGgyZXd6UEtxUlBsUHZXeW1nZGRVdnk0NnhPOEtQNm4r?=
 =?utf-8?B?eE1GWEpoMDdkdWJIeVJKckt5ZXFGbjFTWjM2VjFTZU5SSkRZcGswaFhQZUY0?=
 =?utf-8?B?Tk9UY200akN0K016d2c5aXZXM1FWTTkzdmREZ0Vpc3NwbjFqVlk3WE5wTm9F?=
 =?utf-8?B?SEJ6aklBSURheGhWQVgzRUZyOUFzN1RaV2V1b3lta0RxWmo5VTFHWnRZZzhu?=
 =?utf-8?B?eHpmZFhicmM1TThNS3hoUDFTRC9UNUhVTlFLeFZTRFBiS0dMUEdHbXNTMWVa?=
 =?utf-8?B?Y0pyaUxISXBBRHpycjRTOG9vaGJuL05Jc0xDVThXK2F1YkVEUFNnUnhwcGNw?=
 =?utf-8?B?bVNSejlqbGtLTE5oU1ZRT0hOaWxublM5QkpnRDl3MzFmeTVPSVNyak9nMUVF?=
 =?utf-8?B?cm5vQi8ybDc3NU12clhjUGxGK2xBdVRSNVU3bFNpaXRoRjY4ZXJ5NTJVbCt5?=
 =?utf-8?B?VXR4UlR5S3AzbWFYa01lbXk5Y2RXeEJSdFhjWHBsN0xnTjdIalhDaDJaTGVm?=
 =?utf-8?B?SEFBWXUvQ00rSU1QL0FsYXdFMlNrckljR09QYWJNV3dlWmdXZEorYVFJRnNs?=
 =?utf-8?B?L0E4SXpSblc1aXJJNmVRdm1Vd2o3dFdpZm1Rb3FqZW90bVRQRjB5My9TUjF2?=
 =?utf-8?B?L3gyVU9hbUg3bFl1MTQxUEtJV240MmRQYUJGZ1FPWW9ieEY1aVlaQTV4VTNL?=
 =?utf-8?B?TVVyOStRNVlCNjlhRVE3VWFTaDlRbGp1RHNjZFkxcjZsSEptYjVrYkZBTWRY?=
 =?utf-8?B?aXYxbE41WFlCUE4xZjhsWWoxWVNYdnhPQTk4UU5Ma1YyNks2aTNRRWlBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHhzMnU4Q3Nac1F4dzNwWDJ5WU53ek5DZDNvaUNmbzkrcEZ5Q3phMllHc0Vt?=
 =?utf-8?B?dDErSU55ckhTaU1ZZHV6aEJTNXZBZzV6THdicUpNS2Q0VG5XZ3V5dHF1aXRG?=
 =?utf-8?B?MjZHTHRkQ3A3VW1lZkwrYjRUaGdDdFdZL2NTa1pnSGltU253UGdCREJ6YnJE?=
 =?utf-8?B?U1NwakRDY0ZHVzFtck4vM2VLZ2dtT3VTMEJqNFZzaERlV045YUVEOWUwLzlj?=
 =?utf-8?B?LzhqRzVvMStoMjl5OFN4Z1ZHVjF2ZXdyNmdQQXBYWFJPNlF2SlpJYTcwTkZ3?=
 =?utf-8?B?RmtiVWNhUzlZeTlKYXJZcGZlSmROV2NKVytGSzhUd2gzNU9wTEozajVkbnM2?=
 =?utf-8?B?QWlZYVhVa25zSS8ycTJRd3hoL2NRMHFWS2h5RGJ1RHgzbkJzbmtQUmQ3SDlp?=
 =?utf-8?B?N1BDWVc2ZGtHMXN1clE0UE01K0VGWlh4NmFrQkNPa2tQZlpRSXRtMVpnMXIw?=
 =?utf-8?B?MXFJUkQyL3FySU9IbkwyYjBoLzJXOVBseHVUcU9ESWNHOVlJU0xwWnVWV21n?=
 =?utf-8?B?RFVNdGRtdS9WSmVsOWVFMm8vYXlVZHl1bWFIdWNJSUNQWFNyOThWTno0RGdY?=
 =?utf-8?B?dzJFMklyZnc0Y0JnekNZbS9PRmtsZGZzQm1YN3dFcjBTNlpMeWh1QUZLZDYw?=
 =?utf-8?B?N2JFNW1hclJ6M3lwQTlRUGRKMUM1RkZxMFFqYWNSdjdEZFoybFdNQUg4dWdB?=
 =?utf-8?B?Y3l2MnJOcEZnZHZHWWREeVYwYzI2YzlqRXRxcFZrUHp1LzgyeTB0TkdZNnBx?=
 =?utf-8?B?MXdRYzRIQXBSU0FVbmUwSkVOYjNZQlFLaVdVNWcvV3cvM09iR1dQcEFQWUNt?=
 =?utf-8?B?Z2NxcWROTTJjY0JzWWVJdFZMcjZ6QzNlclNrdDlNRkpFRmp1VkxjSWJHczBr?=
 =?utf-8?B?b1hLWWF3MmFCNk9BaDZLT0xhQ3VJem55Y2VPckdNVGcxRERjcVlqYklrK25E?=
 =?utf-8?B?UnJRUHE4VWM2eUlHcy93YkFjNVhWd1NlbzdoTTNpQkc1aExpdHNhVUV0TVFs?=
 =?utf-8?B?ODRGWEJra280SkJmbFZYWStESWJOeDhVRDl0Wjh3RkNvMzUzNkFZaisxTUhT?=
 =?utf-8?B?SG5oSE9wUC9leDAxSjl6SklMbXk2a2NxN2pNaG81ZWRLN3lzOTk0NW1xSTlG?=
 =?utf-8?B?WXRuRy9QTzF1djdjSENaVFRKRUw3YTRYdDU2WDNPWFo4bHR0ankvaXJnWS9F?=
 =?utf-8?B?UTZHVHlaWjdSZ1F1OGtlbDhnd2hWT1JOQjRBZE5JYXQwQk8vc0RWR0lhdkY2?=
 =?utf-8?B?TDZkVTdoRW9NNWtSUTJuWUR3VjV5N1hhUVYvUTdFSlo3aXpza0hBYk9IRnl0?=
 =?utf-8?B?c1AreVR5UDBkdCszMmllNmZpYVpVeGxvQkJnOVBnckhxcWRqVjN1NDlCbHVU?=
 =?utf-8?B?SnF1ZjQ5TGhCU3kzNmxLSGVSWmJ2dHJyWWg4Z21JSzVKU2NRMWFQd3Qvb2R1?=
 =?utf-8?B?ejd0Ylp3ZGtMOHlidDdDOFBZSjFEc0xld29MV1JGQ2lMTElJLzhQMk1EQ042?=
 =?utf-8?B?bTcwblNxSFlHL3UyZmRZTU44cDF1SGlJVDJEbElWUE5NV0RsZzh5aDNNOGlp?=
 =?utf-8?B?UE9VaWpCd2F3Mk02YnpYbjdSWHQ4WTFRS3RDRGtYaUtHWlcvNElNQ050bXNs?=
 =?utf-8?B?VXN4a2hyTWFOUVRGempYNWhMQ3M5bk1mZFRpSWxPekk4N3c3TzNWYVhNMDNu?=
 =?utf-8?B?V05PcHlnWGlNN0MrNi80Mm1hQ0hGV2ZzemZSU0FxVElZbVdlcTM2QUE1Z1Jr?=
 =?utf-8?B?TlVZVk1Kb3QwcW9peWl6dElBck5EUU5FZG5Ed2JoQmRGSHp2MWJLbVF3SThr?=
 =?utf-8?B?Q3RqemlLVU9hWlJIeU5wV3Rxa0JSb3c3WkFNeE9kV29jRDF2VVdwWGZoaHRm?=
 =?utf-8?B?VytvVnd5YnNrRG9tQk0wNFU2NllTSWtzUE9ZMW1KQktPbkQ3eDZhQjBvdExW?=
 =?utf-8?B?SzN1TEE1SWNBa2g4SmtNeVNXOFhQN2NXaWVJRnV0cER1RWkwdWMrZ2NiS1hU?=
 =?utf-8?B?RlFObVNrQU12cFhJZWZFREpYbWFaYUJpeTlIYmNwRi8wcnF1THlkTTJqYW1i?=
 =?utf-8?B?ZkFHRGo0VTl0d1JhdVdWZlg2TlRhc1AzN3l4cmQ1TW1QYituQ2x3Kzk1QmhW?=
 =?utf-8?B?YmRsLzFuMXFMY1lsTnkvK3JiV0NzT3Y0dmVCU053KysxUzVRMjA1cE9zSm9m?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9oG3vvXfdWOmydvn63RgBpI9Aj6V+zD+wl5jiv5Ql35OmpOYEMVG5WFDLwQi1TWgDXYE8EG+yiPWP/r4GVbfAr2bwWJzRtFD2wIWN5D50xuo7ls4bJO3ozlibnzC/XPOOn7soIV3JUbCgSIP1WSLqOZPc/37EuZEn2cCiTJGPS8FW1gzBq05O7NGxpYBHfDokfCCF+fECPCV+0zOoCvxZg2G/E/BS54EC0OcmfC9n71YYxDSmieyCX8jncZtvRWB5ip5Sj8nV3x9m4KeQOTvR9h0LatBgcbNCO3Cci7cCTKMjp8xal7p0w1KKONfOQH9cLfOz8o/Cu4du6fMDEYRbwptr11qD88Tq6vyq3lCq77/6mhFNQsmPwawjINF1c5SO2rWyI35F264Qy8mNJ2JkJ6tF+BBKwhsN39vuI1ilrzWHYMuZqShtjtTH1t1ZaZGNh7jDeXB6NfNgXa44yrJ9WZE3YybX/sbC16El3eJuioR/HpK1WAedpkVFzkeJFEt5PIohNwRWkmlelfoSgn3XAr74cyv6QPX+fxoj9lz/W13ThwUqKejU1sJBNvwLZsctyIMjZzxnnyru3vk4/MGm8Syr3+wsb8gS6PufS0kZEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631c09ac-9c21-446b-73aa-08dc5c1e8713
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 01:02:17.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9j3in+TDbEmHV1FDbnTOUtoeSnIx9UwigW/R9iWu+zQu6X7yK2Af5mQeoWgFku5zpAY7jq2Bu17y/cvT0zUVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404140005
X-Proofpoint-ORIG-GUID: djfk--mbnexh94of2gXpIpWyqCLKJ95w
X-Proofpoint-GUID: djfk--mbnexh94of2gXpIpWyqCLKJ95w

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.
