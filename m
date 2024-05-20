Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA21847
	for <fstests@vger.kernel.org>; Mon, 20 May 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248909; cv=fail; b=uiB/xHEiwKA8WXHFCx3IuXUKOBy5VV4zeqowjHG8PXjTRrjMdgNqSnkftNtp8esqXAtt+eInzaG4j1Dr1kPfwa3x+FEJRedbNmnHoFudmJh5SldTbrLf2oIIZXeZ6jVbswWZ5+C08Zzrb4AKeoTo1GQho+tWXTpo4IPUF0HLiPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248909; c=relaxed/simple;
	bh=rwpSYkeIUJ1oxsQ/xeHtJhWh5mRKcVO2uCVZByFMPiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e4o6Te715Xz3GoaatjmxITpDrgLkovJKk3h6sJHdlCe71I02nJcNF5cgT4aiKzVMYLY4OprjxayS/Y2ZOEF4g3Li83JihoxTHv3fjAVGzpsTz8MEneJeky7s/Cw9c1AhCmElyWyrZz9aVlZveRW7rR78kpuiOzW9QTXFMvyQCSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkiOQsm0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V33hMOEt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkiOQsm0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V33hMOEt"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMwxnx013974;
	Mon, 20 May 2024 23:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+Vv6nhIJlNX7XjEQPwflxzWoBZvleK24NoYusYLnRZA=;
 b=XkiOQsm0YBCCWURB6LnYZgZPlIFQSgEAm7mnito+hoZL0dJmh1+YfSWBSPP+QAY1l9Oh
 3UpVDz3A7PYel5anucUG8Z259gpc/v0lqX7zseTcEy+/4uQ2ciCvbF4GVjyExs7Xx1wX
 9m2EiHrRoyFNeMOKuy6wscIqjYWjDsxBA8B3whhlOIpkZDKZnCrH+l9PYSyzxhJbeVK4
 Q9n7H3cFQNn9f6VHd1OhXecKElSWcKMz9D9qr3dPCXfJS9dCKkVH+UVBZe0leiO9sbD/
 vri4HgAH7SEdK08XV3OUVdLyYqbgIm2HAnp9PSGkKjXlBcYKg0E08vsY+i0JdDT6Z7qd SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrekupv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 23:48:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KLHjYn005029;
	Mon, 20 May 2024 23:48:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7432w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 23:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULngfLBAe0xKiyoKy6/jgmrrA1DwGLX6hVWVXJqvnlv4LUaowzkoDvRFYITH10yGOyn+jNZrflNa07hUrHAbO+fs37Rsrrswx3hNZRLZ4l4Ecuk8BeXDw4c2th8dhflK7Gf6Fe9f+9Qhfie5vxlmlNrgUpeoE0AluOAmCFLGWrx5CCfr71tnIJ1jl+4LEQPsarNRHhgN1yIHgT9MV9QZs0GJyIL2lbOX+BCqd/FSAutWClMkUWbTMMs+dd/sbxos1O4QTDEzACPJHxf73aIfGW3JBZDkNByxbLs6FJbNL69Hr6exi2gyR0v8fbOC1n7oIavxwMzS+hSci3UDxLibJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vv6nhIJlNX7XjEQPwflxzWoBZvleK24NoYusYLnRZA=;
 b=WKz4LEewezf8H1nM3ldUv79uxAb5rStuwgex98QIKTNjfkrft7fnQXMfDKmZYMnxr2nlwxhiLGn9J9Z6shWrN9jXy/pXG6F94NQr74+viFZsOeWZPhnRNi/eC6zYL/LBz243shUUq2joAHH4hHsoCT1axtKoO+MHL+yzDGotElvJVB7RWWBH+cImrY9FdPKDtQSJ3KZZPTU/tF6HwCQleWFwF0G3+/Gl7227YNZHYqNviFujqRf5j+C0BquULawB/d1SzCw1C+G6e1GiG/Of6X6XXfRq4t3vK6lELKQ9UmSWMXheFF94U/8ZZ3qB2x9D3dRvAtbrUokOgt2i84SprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vv6nhIJlNX7XjEQPwflxzWoBZvleK24NoYusYLnRZA=;
 b=V33hMOEtk0ehxBSz6F5073i3lEf/hSpyUD2vPryXaoB+2OGlplRp6VKL+3MatW2rakMt/kLhrdr2+LL6yLU/t79/klGYf3RypTGDdk6na0CpiDJbFh6DhVV2YdTokevuoQRM2RS4LCLkeCUPkQGLZ30oY7/Nt/UuFusouP68F+Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7750.namprd10.prod.outlook.com (2603:10b6:408:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 23:48:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Mon, 20 May 2024
 23:48:09 +0000
Message-ID: <768bed38-10ac-4ab7-9ec7-358792e166b6@oracle.com>
Date: Tue, 21 May 2024 07:48:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] common: udev settle before _scratch_pool_mkfs
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
        josef@toxicpanda.com
References: <cover.1715896529.git.dsterba@suse.com>
 <b8e39744f98bde6484d222c6e90240f074df1eaf.1715896529.git.dsterba@suse.com>
 <30c274a6-adc1-42a7-91cf-8a386884106f@oracle.com>
 <20240520192110.GH17126@twin.jikos.cz>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240520192110.GH17126@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: f897ae11-333d-45e8-af88-08dc79274d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a09hY1EzWFcwT2orTHZpT3FYSWZESTEwUXR5TGFCd3BQeHQ0M0lBVVJJbmEv?=
 =?utf-8?B?dW9ocU5xbGVVSVQ4b004UzBtZ2lIWkxoYXJBcE5NekQ3dTZZRFJIS0Zwekhq?=
 =?utf-8?B?eXdGUUFTdFlmSVRDSjhpV09YN0FRd0pzRnduZU9WMUJsSEtKN0FpclRCVXI0?=
 =?utf-8?B?ZmhBVk1MVDhlS2R4TFJ2eTJaWnhRb0RCSjRBNS9LL1lHdG5Cc1VHcFl2YlV0?=
 =?utf-8?B?RWZhYW5QVG5uT1FHRE1Nd1dpQXVxWjRFaVAzNllPWVNDYVdZRlErSTEvL3JR?=
 =?utf-8?B?N0FMaURFSFkxNmRVUlFvK0FMdHBiYjJiaHAwcG85S0grbW5OREJJMTJCVEhS?=
 =?utf-8?B?UjcxQjJreXZiNXVKZVJuR1dreW9aL3c4b1FHVWFrWmpyYnplbWVNOUg1TFB4?=
 =?utf-8?B?YmY4WnpvTGczajBFYm9JaG8vc0grNlcxZG9rVjZCYmswckREbm5kaUZ6SlA5?=
 =?utf-8?B?NUorbWdBM0lFR2F2RjBQc3daVm04ckdVQjlxYnpydWZUT3B6ekwySTQ5cFM5?=
 =?utf-8?B?cWZabHZpRGFscVVxS2pjYTRUMGpJYXRVMG5nL09XYlNqY0NmUDhGSjBUOTl1?=
 =?utf-8?B?SnM5MXZobDhmVENiRVhCSkxQUDRUZ1VaVThNeUdsd1daVm8vaGVKTnljNWZu?=
 =?utf-8?B?REJMcGkzc3BkVlNTQWtocUVLYzBKSmo1RjFLWEQvT3BPREd0V3Z4UFpWY3h5?=
 =?utf-8?B?SDJnWTBxYXIvUFk4VktJaWUzVU5jazlnR1UrMVpJK0hrZXIwdXZZVmRPVVBO?=
 =?utf-8?B?Z0o3Mm1jMUFETmt4OWQ4bWpua2VpS08rWS9tSnM3bHZ0cm9uSS9BNXJTanMx?=
 =?utf-8?B?TGhyYTVGcnJhQ2ErT0o0Wm5qSkZVWmovUnM3M0VhQll0eTdwSlJDa0FNdWFx?=
 =?utf-8?B?VisxSkVwTUlRN1RuNDRMd2laWStCUDgyM2VkMkx1dWY2VEVyTHpTMHdsZ1A5?=
 =?utf-8?B?cTd4QXppaTd3SFp3SVJkRzFjU0Z3c3FaZVI1OXZIOFZWTWVTUWQzRHRLa3BU?=
 =?utf-8?B?K1djSmVlV0J3ZzVTTlhaNDNkQUNMVVUwT0hFK2RreVJ6cFpUSHZpcDVaZlkw?=
 =?utf-8?B?Slg2d0xMejJXcWZIcVRpdjMzb1VqSnljWlE3cmsySWdGcmdGck5WdTMweGRG?=
 =?utf-8?B?cy84NVU0ZTNSb3FFTHFuMWVJdWFNZnRYaDU0SXl3OWlXd2NOS055K3d5OHpV?=
 =?utf-8?B?M2hzRVdWUVg3YmlQYkdYSjRXamMrdGNyTDMwaEVIQURYckFGRGtHazBFR1lo?=
 =?utf-8?B?ZitOT29yMUpobEtDQS81NlppR1VITktPd1pLVGcrY1h2QmJMZzRCbGMzT2Zm?=
 =?utf-8?B?UlB3Yy9Lb015dEZIRzZnYnJCRk5CSDNoRDNKQ1NDeTA4bjZEZkZKcUhCejRE?=
 =?utf-8?B?bkdSeGs4bk92T1dWYTA2S3R6T0VURGVyTWJlcjBzbGVrMzZyUjNoWktnVXlB?=
 =?utf-8?B?QXJvckkxUVgySGhOM1pzajZoK05CQndKVmxMY3FlMHhoazFtMW1SNGpYSlEv?=
 =?utf-8?B?Wmxhcnk3M3ZCVGdkeis0RTRuQXhweGJONmthYTRNbGYvT0I1akxvWk50STdx?=
 =?utf-8?B?ejgrR2ZjbE1vSDRaNWlaa1VJajJJRHl4MjNhUVJUWHErYkd6STEyc3pCdFgw?=
 =?utf-8?B?ZkxzT1V4M2Y3RHpUQURxY3BrY21qTXNMQkY1N0E5cmVpM1YxK1YzT1hlVWQv?=
 =?utf-8?B?bGk4YzVkVmVvbHlEZHRXRzAvSXpaaE52R3FSek9FTnB0emtNUnN3RlVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aW5DaFdGRDNITVNWSUdFd1pwNWduazhPazBwRFZpMkl0QXBqUmhRKzc5NmRD?=
 =?utf-8?B?SlFmc0ZwdGFBeVM2aE1qTnpDdk9xOTU2SlMxd0tMUDYvSmU1V2RRZ0RuQisr?=
 =?utf-8?B?bkk0NksrQTVCb2J0dkdpL3kwcjk3ZmhtWEZ5dlVnVGdBSFJ5dWVZZkZqL01j?=
 =?utf-8?B?eXA4Wi9nb2NQdWxiWG9ab2FLalY4Ry85Smg4ZE0zYmM2T2g4TDZ3UUV5TUUv?=
 =?utf-8?B?a0J1YjZqWVVYZE44bFVpdXphQlZyVkhhM0lyVU1oNkRld2xvTVdhdUdBcnc1?=
 =?utf-8?B?VE5WVU1DRzhzbVBxLzJTamVhUWdpRkk2RGhudmplKzltUDJmOFc2UnorYzV5?=
 =?utf-8?B?bjJNMkdyM1pLK25GUkdZSUMwNXozdHNobDVCZ1lGcUt6UmpQK3dNWFlmV1lP?=
 =?utf-8?B?eU1DTlNUNFk2T1ZKUW9VSFduck9KOEFpZGVCWjAxZk9LdDNGT0xZTUxaMnVj?=
 =?utf-8?B?SkpTUlhNWCtUSXlzazFaZ1B2bzhqTVFwYWdiTjdiYnBRMnFpYUZvRHNUYVRU?=
 =?utf-8?B?VDB4cDVBZWRlVkR4Z3hJa0RjbG53aWE0ZlVnWTBSWlEydjdOSTJYS3poZ2cy?=
 =?utf-8?B?VFlIc0c4TkFiV2FUeXQ5YTVBVEFUSk5COTQrZ2hyaVcvZjRXV1dTaGRMVzEv?=
 =?utf-8?B?ZWJaTnM4UEM1VGdoSnllc2Nydi9kNWdDTmNJWG5VZVhQdVJuT2hDZ3lYYXFE?=
 =?utf-8?B?ZHJpbFhWcjJmQktyTG9CZDR4VHdUNUZOc1hvL2JqQnVvWW1JZW1uTzJkdkd4?=
 =?utf-8?B?L1VwWEFoZU9BSWEwZlU5LzJNdERqNHhadjdwbVhZbERyVWNLNFFoMmEwa2xG?=
 =?utf-8?B?UHN1VkhLUWFaYkt0Y3gwTmVxQjRpR29KaGVYM1ZoSko4SW95YTk3QmMwSitr?=
 =?utf-8?B?eXVvaW5tQVZaNDhkd1l3Y2d1UTBzbFA1dTdKU05iR01BUWs1UkZadTJyQU5Y?=
 =?utf-8?B?UEVWT2ZvQVRjVjJwbGgyUTlUUjN1bGR5QVVuRStHSVZXMGJneUM3TmJXUlRN?=
 =?utf-8?B?MkNkRloxdjlNK1h0SDczZllRRCt2TGhSeTBDdzdoSDdvaG03Y3V6dEhWS01P?=
 =?utf-8?B?aHN6TTF1WTlqbEEyMUxBRTRzRVhsVnFsSlZuNEhuNTBLZi9zeEZ6a2NrVmxq?=
 =?utf-8?B?OVNTdXdBWDVPMFkyVjNLOFJsUnJSN1NMaWpPRzYyUGs0SUpzRE5MaDdLWDRo?=
 =?utf-8?B?RzhDMEFxbzBoYWp4QVJkUFAzdFZwdzRKWmtVY09JMm92d0xhOVlwL3ZVYiti?=
 =?utf-8?B?ZnpvOEgweWZtTm1LQ2RaZC9wYmtWWFh5a0FzMGtjR1ZLNk5pekFUWEVGUXhU?=
 =?utf-8?B?NEJnWDF1QVhaZlYwSlRDOUpDNk5nejVnaUN6dGdDbTI2MmVMSFNUeW4xeFV5?=
 =?utf-8?B?cUwzcFRGbUREKzNMMitCdGNjQUhCSlFjcXY0bmFXbGJUeDFYMWRTY3lod0Rw?=
 =?utf-8?B?NGlIcmU5UnpsakJua1AybjhHeWFoeFIxbjVEVmRoanhsZkNmS1ZiMTFIRTUr?=
 =?utf-8?B?Q1lUVE5zQkJIWVZuK2xNbnI5TUdZSFpzVmp4T3Z3OFV2amN6UktwejRLRmdV?=
 =?utf-8?B?TlVONWJsejF1eXJCMVAyRDAyRTRRNHBOdVRZa0ZscmUvc2MyYmwrWjNZK3ZW?=
 =?utf-8?B?bVVXN0ZxZVRySGNwZXZ3M3JqR1l3WHo4cE1Rby92bUp1MU0zMHpxd2FMVkxS?=
 =?utf-8?B?ZG1wRjVGMGZKM0c0allpOXpSNzgxRmt2UHJkODMrZkwwa2o1azRuemRiUno4?=
 =?utf-8?B?R1hlUVlFTjFDU1NBR2UzK0RhYTFzTklLbW01V0JoSnJIS05UKzlwK0lhOG0v?=
 =?utf-8?B?TnZDM0NkZld5VUIvckZHQmxKZ1dtYlF3MjV2VlFiUFV3TkdVbkdxMG1mSTVI?=
 =?utf-8?B?bW9vdWhmVzdpODRQOGZrVEt4MGRicCtyOFdPNkUxdjMrS1g0eWJoNDZVVHNP?=
 =?utf-8?B?K2EvaU8wVDJvTEpjRERUcUx0bzJ3M3Y3QTREWm1aQmh6Y1FDUmo5SlJKT3Av?=
 =?utf-8?B?cERaeldJNjM3ckM4Zi9XaXN1d2s0eGhZRkc1eFFKR2hKTlE4b29oeThyNHlu?=
 =?utf-8?B?V3N6Z0ZBRSt3OGM0WFpsc1dhYnJnb1hSTkhxUGhKWlJramVQSjNPWHBsL1lD?=
 =?utf-8?B?WUJibHErOGduMFJjRDgwVmVjQWp1MCtjTER5RmQwK2kza1d6RDdpVUhLRmZl?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	owouh+zznXfDSQ2fOAXWfYlI1WtUkqkBpUkpHxltDn5A/0L8S7c8bsxmnFz65WYfpSvLHHjKPk5EMzOeja6iAFhV8nZ7mYBPdNHrZO0YHuhbJaVbK4YOgNACJ0Q5PeXA5wGRg0pSLxIhS3K3hZf1Rtp6nxtvOWJlalLTSfhjHWmabg2gQXKWZwi+7f0y5WlexbgWANBxWJbBs63bKL/3iznyZo9YyFts5bBPdtIXwWqdNCwJUVTBxJxPGC2F176aB/q0dI8R9mnrQnhoK4Wnr6WZtuet5+SyRpZ/zqu/j2USWRiQ5N2yoz6eQh/6SXUtoQVveJJoaLpI8wqAXc5Vgx2RedotKfGLhmbGVRla6pvOO/mtN9XXGs5M/F1l1HAX5F584DFxBsm+zFH/AV5ccvaJVbcchvkVfdeUf5C6HF2vnxtihUEv+qajpiOjPPi0az6PcobPYgm9QcLlKIjZslTt+g5nYObXpHFcf96DL8ndSG7rObU3dZCvgnGlCkaFFUHCptevZ4TBQZdsUPvvZZeoK/FvNra6AP1pBmORq30BNRpciKtm/j3ejgO48DBPkZxV5NxyIYyo+tM/zhW+COcWbIKJWR6qfzz/3tBDsOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f897ae11-333d-45e8-af88-08dc79274d60
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 23:48:09.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q/C2N6mJrPIZ0Y2z3KEHnzYfY+Mu9lICS+RXYkaCJUZaE4XZ91yvOkV2EkID54y/aF0Oj08sRp069BNeAjb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200190
X-Proofpoint-GUID: GSvIUAVt47zpXuAMV-sxRyo3nRAt0PU-
X-Proofpoint-ORIG-GUID: GSvIUAVt47zpXuAMV-sxRyo3nRAt0PU-



On 5/21/24 03:21, David Sterba wrote:
> On Sat, May 18, 2024 at 05:57:12AM +0800, Anand Jain wrote:
>> On 5/17/24 06:12, David Sterba wrote:
>>> From: Josef Bacik <josef@toxicpanda.com>
>>>
>>> There are some btrfs tests that do _scratch_pool_mkfs in a loop.
>>> Sometimes this fails with EBUSY.  Tracing revealed that udevd will
>>> sometimes write to /sys/block/device/uevent to make sure an event
>>> triggers to rules get written.  However these events will not get sent
>>> to user space until after an O_EXCL open as been closed.  The general
>>> flow is something like
>>>
>>> mkfs.btrfs /dev/sda /dev/sdb /dev/sdc /dev/sdd
>>> mount /dev/sda /mnt/test
>>> <things>
>>> umount /mnt/test
>>>
>>> in a loop.  The problem is udevd will add uevents for the devices and
>>> they won't get delivered until after the umount.  If we're doing the
>>> above sequence in a loop the next mkfs.btrfs will fail because udev is
>>> touching the devices to consume the KOBJ_CHANGE event.
>>>
>>> Fix this by doing a udev settle before _scratch_pool_mkfs.
>>>
>>
>>
>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>    common/rc | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index 0fe56382a6a497..5d38571ffe87eb 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -903,6 +903,12 @@ _scratch_pool_mkfs()
>>>    {
>>>        case $FSTYP in
>>>        btrfs)
>>> +	# For multi-disk file systems udev can queue up events on the device
>>> +	# when we mkfs the device, and thus tie up the device after we've
>>> +	# unmounted.  Tests that _scratch_pool_mkfs() in a loop can sometimes
>>> +	# trip over udev trying to do the updates after the umount, so make sure
>>> +	# we settle before we try mkfs'ing so we don't get an EBUSY
>>> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
>>>            $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
>>>            ;;
>>
>>
>> Just curious: have we seen this issue even after the btrfs-progs commit
>> below?
>>
>>     e54514aaeab6 btrfs-progs: fix stray fd close in open_ctree_fs_info()
> 
> That's a good question, I don't know but I can revert the change and see
> if things break. This may take time as triggering the udev/mkfs race is
> not reliable.

Agreed. The udev/mkfs race is tricky and will take a while to report,
but it's good to experiment. IMO.

Thanks! Anand
