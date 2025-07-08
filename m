Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5C2DBF49
	for <fstests@vger.kernel.org>; Tue,  8 Jul 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978096; cv=fail; b=u83ticYY0EWJ2c8PVDn0h56gVF2qafdTOYjfvqIp02l3PkNuATbeBG20qixmEEqxmloK7pI+6JNKIJbRuSZAVp6GODDRwv+Ige+hYdyG7viQCtbkwbdA7NxwTOxgUz0dam0IHGaTdQOKGvMKSBft0zn6DfFytVpyxngBOVCedJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978096; c=relaxed/simple;
	bh=szTLq4F86a3AqNVqZ/zb5kLy2CVQP862LHUyPZB6Mr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M08TgTIlhJpBxA4PpuWUzaRv7zAzym3ZmDBKDEd8IQVCpUJR+7KgkJ5W0mbgfcumtzP3MHQ2gN47y2g7BWnjiWMhzPdfXRzxylKjnR6fyD+xaF8T0EoN6sUTE483iPjBUJQTv20oAF4/3LDW3rSd3DAOzEyWCY9mh18AoQuMWa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ppuf7f2A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GSr3Xbvh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ppuf7f2A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GSr3Xbvh"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568CXEGg008433;
	Tue, 8 Jul 2025 12:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6XwCmmWeSyKM+cVpsZja9jTraAAt0JrQdcR5xBLTq98=; b=
	Ppuf7f2AplE58ik86npjVSTF9ZgL5N+KjFsP0clkGhqIewsEQopuqGdgnCDFub5y
	98K5O3MLGNKwNu/df+709BDae7vpr8KnrqnE5xX3mocSo5jKoF9GTooe4fQ2g+hv
	FlhZw+xxHb+hMZS7RoUxiQHCBKIo3/YXiwpcJiUgsG6MSXWUZgK+Nyl/j+nWZwbl
	a5OO6g637pUBJ+xrf+kRT5hm6tZoD+eE9MjXTjUCKobDazdsvQ6JhKSe/oRbARL4
	g0WolZo7QZNZIV77zNJLwGSIZaPTbJqTWH8kIStJbUMEwi+3LVNxutZM5bUEcQ+0
	wQVQ/z9OuHYYOxs1Hh8dAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s3dqr03g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 12:34:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568BDM2l027448;
	Tue, 8 Jul 2025 12:34:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9hw5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 12:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ+HyQuPHjLv+MG/35udy8Z/F3ZPYljN+DpPDNKjzBrdKknhQxyvOl8xdx5PWPmpZu1pIDY8+qJVHe7hEA8wG5flKsi0nN3osNaVNu53Edfm10K0v9hFRO4Qd1nL1i/nHwVERn4yAEnHQb/76TkgYlGt1WOXS2Oqua8eyCEZ3QHl5sOvBfoQRmDFcsXKhZzPtmhlkAdJWwGvCSvjjC7owLeEchYLD5AkENxSK2xw/6N7RMIHP1zj2MXSf0V0Z9KJWQoA+YyjMQqjLZME9sxlT4N9Pn+MvDvC5hUMbe5QlSHbks3cpeHh35EMeI0w2/SQqbUUwn8b44u4UUCtS2Eh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XwCmmWeSyKM+cVpsZja9jTraAAt0JrQdcR5xBLTq98=;
 b=zT2/8vjGyLigu7UvwyOY11yx+RiNFo8wnd79Aa3oLIBZeSwZpZbxh7zoxzHPSyzIp/A1Kd32O/XX10HNeA6gs8eerZGZm8DoYD9DLwQCcLz5F3xfBNWQnx4apVL1gway0fH/wECfcI5dzm3XJOFwBPYE12tPzzx/+UgyjaGpsN4v0X9C/ahW9W5ulCiBqxzmmVB2av/l5R/zolmyTrC5Xd/BGc42V2CRQWvpqL4l9bSbP/dQKs+2by2A92GE0C4sb20RGuNYLg8h1vNCHZbA+5W2bT5kAIVC6Oy7nSQ9P3k+Gl4JSL6FMEpH70st2tzorFBReVlWksjLost413iEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XwCmmWeSyKM+cVpsZja9jTraAAt0JrQdcR5xBLTq98=;
 b=GSr3XbvhuB4kR/9y6w8ep7zvdJVc4NjJTkM/JqthxotNnj33kFBXP2beQbsonhOOpBPSrPejCuXMy/6XlmXzb1jyhz+2iGTNRjPMnfLOuez+i90usnUFEiNe7Hcg5C13CHgI38gLhYolNDX7d5oT0iSidRVqUPcE605FWZh+8XY=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM3PPFCCE340B80.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 12:34:42 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:34:42 +0000
Message-ID: <2678a0c0-e075-41dc-aad5-3191703c7359@oracle.com>
Date: Tue, 8 Jul 2025 13:34:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
References: <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
 <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
 <aG0IsTJ88ia4TWmn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aG0IsTJ88ia4TWmn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::18) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM3PPFCCE340B80:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e24dd6-c958-4a86-8573-08ddbe1bcfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHlCN2tZL2pZODJDNnRkL1lUNnZOWHFLRXIyMEJVbkRRUFdyVVBvWnRTSU14?=
 =?utf-8?B?cENVSlFJV0k1ZmhzZWppMC82aFpyYUhBZGcrNGwreHBJci96YTBnNUYrM3hR?=
 =?utf-8?B?aW9pb1ZZK3NhMnVoWHBVUDFaNFhXKzhRWTk3Q1NzL3NGZXpFVzY2d2U1NGow?=
 =?utf-8?B?eStxcmIrcWZNVUI3Q2pSalErcE91L3J1S3c2UkFNLzRMNDVGL2hib0ZQN0tQ?=
 =?utf-8?B?OWcvaU9heWh2RGFVMHREMGdwb2RZcjZ1NFpqZlF3NFdETXhtcnNWVDUzamo1?=
 =?utf-8?B?emFoRzVNZlF6emFiNUtzL2RkZlNmUlg0Mlg0alhWeWREdjVaa2ExT0VETkJm?=
 =?utf-8?B?cG9QRGE4YldRN2FwcDdQMGJUSlVlWUFVeG9qQ3IvbkpjMTFzT3QvOUNrSmtX?=
 =?utf-8?B?UU1SclZzNStkdUNCN0RON2ZNZEF2KzJOV3U2R1NjQ1R1eGEvTTA3M01IZUQz?=
 =?utf-8?B?SnRrTkVER3ArOUNuKzNTT3JQelpqZ3JBM3ExbDl3VTMwQnlZZkpCN2hrRTVU?=
 =?utf-8?B?L1JZbmNBOHJHc3lYT0Zad05XZkU5czM3V1IxTW94bGN1OG1NamNwMzFZYUdT?=
 =?utf-8?B?MzY3dFlQTlJxWHcycWVsMnc0Zkl2ZUxSZkp2U0FWL0hBUUJBNmE0MzI1T3ZG?=
 =?utf-8?B?UXBjdnd2ZXNMcjdDdXI2V1FlV1Y4Rk5vbmEvd3BIUWJ3cVJyekhxWFZjdkYr?=
 =?utf-8?B?L0F5aE1BTUNhOWsrVzBOU0laOEIxc0NyeWc3UlJLeTM0QzZSazVaVFZUNElR?=
 =?utf-8?B?cjIxQjFWRWYwVHlLeFZxbnNJVkxRM2p3TU1zd2dHRVBMbEhnRWppUzd1anVa?=
 =?utf-8?B?OVpqSFlrRW5INW8xYi81dVZqWEpIclppOVZVSHk0b3QvL2NwNHRJOGxuU3Nj?=
 =?utf-8?B?N0p6dzdJUENvUldOSTZ1NEZ5Wk9zL2xYWVlpdWMxL25WbzBWYithdDZveW8r?=
 =?utf-8?B?dEw3OHRQL1VQY0laTnQzVnJaS2Q0VzRWZGVsNUVGQThsOVlobHk5MU1uOHFF?=
 =?utf-8?B?U0o0NlcySk9ScHQvSVh1b0NrZFpVVWJxZkVYbUFzZU1DVExHeXRpZ2psTlFK?=
 =?utf-8?B?NHc3bXVabU5za0gyWWcrR3Yya09QbnRGZTVDR2d4S25UaitiWEEzdkdFaUV6?=
 =?utf-8?B?dHRPOFdtWGYrWFZ1WlBMR2dWZHplcElWTkVoQ1NPTVpyVFVTSlIwMEk1U2Y1?=
 =?utf-8?B?YmlsL1VYQmtQamY1TS9GVGN1ZXJ0N0ZLaXVIZzNnMU9GTlhGMGE3VU1qZ20x?=
 =?utf-8?B?ZExTOXNOWDkvU2E1Nk5jSWhtSUNVNEIwRmFLT2ZMNWhVU2tpTE43OVV6OXFu?=
 =?utf-8?B?bFh0MmtzMlRpdU1FaTlDdVhXbnovOHI3L2hoVzZ5Qk5BUzNMUmF6REpiRTBt?=
 =?utf-8?B?bXhJd1F6VEtSd1NKZERwVlRldUsxbytObWJHZlR0eVlPd01taVk0UWswYktH?=
 =?utf-8?B?VHVzaExmRjl1T2xnYXBvNXFTUWxBNWw5a0x5eVl6UDZjSFllcTlJVUJFWGh0?=
 =?utf-8?B?Si92UkRScFR4VFJPdDZwRloyYTFvWnA0bEJkM1crUEhPUmZ0azZDelFDbUhL?=
 =?utf-8?B?Yk50eENYck9Yb3lHRDgvUi9LcnV3V2R4bVk3Z3l2a2d6bzFTaFp5REFPVTdh?=
 =?utf-8?B?Z056MXV2NkhKdFFMNS9nQVU4UVgrUVRoMkduVk9EdGRSdkhwWFBIMEVxQ1Z4?=
 =?utf-8?B?aFhpT25oTU9OaUJySllSajRzOVpHNVh6Z0ZGN3ZvWWEwMkZBWjgzT1d6U1Br?=
 =?utf-8?B?TVM3bGVmL0d4OUZ5SnhEMTU2bDR6a21tZXpvKzhlYjhPVit2T05JcktTendQ?=
 =?utf-8?B?UVpqU3RtMU9DdHNqNjdDcXVPbGtraXF0UUViaWRVSlMwdk1Demt5SVBqeXNt?=
 =?utf-8?B?czlRY0xOOTJHOTY0d2NURmx5aCs4T1JZUyt0T0xmeGhFdWk5K0lTbUY0K0FO?=
 =?utf-8?Q?qacsvU3hxhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VitjeGp1bkl2bm42RDdwbngvNVIyeEliRWo1ZlFGSG1pd2hQTDJPc2hzL3M0?=
 =?utf-8?B?dDB4VGltNzNGZUpNcWZrQTBkZVh3M0xnR0hLRmJ5b0VUTC96M2grNEt1dVgr?=
 =?utf-8?B?dU5oZ2NacktzKzl6S1AxWUdyRWs4eW1PcHlmY2xwaXkxZUtHMXFDY2h3bkNH?=
 =?utf-8?B?N05oZzhEZXcyUU1McG1mT0Z2RWF0SnZuUGpvOWdYWXVTSFFDaEhJMExHbHVT?=
 =?utf-8?B?dlVYTzFDeTFuUXJUbTZrYTFrcm84R0Y2cGs0b2llYThhZE9wK1YwTzhJVGtL?=
 =?utf-8?B?Zi8wdGR2MU91eW0vVURnQm5ENTRVQ0kzRTBLUTlUZ1prd3dXL01JMlBxaTlY?=
 =?utf-8?B?akdkVk1iemtUQnRXdU4xZWd3SDc5NnNKT0RZNDg1SVdueE1rSXpaUzRxdlE4?=
 =?utf-8?B?aTFiWEJKZHJsNzhwdnFRa3phRHFQZ3YrQVh5aW5RUnc0TjlET2tIVjBka1k1?=
 =?utf-8?B?RmwxM0ovNWlrUlE1Vkc2Sjlxa3FLVWJQb2txS3l4NExBUHVtOWxEclo1TXhJ?=
 =?utf-8?B?TUoyNzVhSytON1BWb1hlU0d6VFJyRzBhcUFWM0lXS1hQdVRRRXZONXpHWElE?=
 =?utf-8?B?Q1lKNXd4TGNMa1ByVk1PNGdaZkNvU2I4a1ltMzRZUUtQczFlV0kzOGF3ODlZ?=
 =?utf-8?B?ekZ4cVkwVmJoS29ic1hHM3I4cHZwakhLWU96TmJHUGhxSUFHR1p2K2NnN29r?=
 =?utf-8?B?VWVMNnZrei81ZnJ5U0w2MWJ0aStxNEpsV2R2RWsyS3pFc0RPRi9EY3hYNUlV?=
 =?utf-8?B?d09yRzJTY1FmOWxjZVIyKy9SWThPSktCWS96OWpPZVZWMXhhQXpvRTZkSlM4?=
 =?utf-8?B?WHg4VFBEMnF5TmZsYkJtbDFWT290SERpdnpzVDdFWjdpaTVaZGhOMTdlTko0?=
 =?utf-8?B?MDB4YUU0U0JjaGQvR0poSDJQelg2U0NKRDB1MU83Mno0ajZVNS82UFNLQnBR?=
 =?utf-8?B?cGF6RXdvSUFxWXlzQU4vTitpN3EvM1dES2s2NFdXQUxsUnNEUzM5NHJod29R?=
 =?utf-8?B?S0ZqcXZJUHhNN1pML3orNmxFVWJGaHh5SkMwZjVDQThSTWQwUG5VcjY0TG1v?=
 =?utf-8?B?czQ1djdBN21WQnJ5Y2Nza1JsRjlZRFZMTHI1TVRWUXR0czZWRHlwNUJlbFpq?=
 =?utf-8?B?MHM5d01Kb1dibEFQUzRoYlY4OWFBZkdaN0ZjZlVYMWN6QzYrTkpUVjE3K29N?=
 =?utf-8?B?b1dJaTU4N1YwV050aHRJY3BoaVhSQUtQcmhiZWVFK1kyc21FUkYxVlN6bjIw?=
 =?utf-8?B?QmZHOVpUYTNMMzJZdFJqNzFvQTZRUVBMMStteFBmaGU2eXhZcmp3QjEzcm1s?=
 =?utf-8?B?dUVOcmthWXhHR1hjSkE0UjlzR1NBVHdyMDJialJjM0h2ZklnQjJmZzR1ais4?=
 =?utf-8?B?QkhnT0JTZjdPRVJJTGR0bmtSdTBrK0cxcGVwT1JDSlZZUGhJc2txb0l2Z2Nx?=
 =?utf-8?B?MXZxYjFYTWJYOGtQTExtVWUxTFQxYjlHVjVKdnlQV2tWMUNteUx6b2Q1cGhk?=
 =?utf-8?B?ZE5sQUlsVmtRdjlCSE42L2wrMGx1MVg2QzAvLytad0hzSHFlTGZVbXlNelpE?=
 =?utf-8?B?dnRBV3pKNlJsd3JCZjFWZDRLdGJOZjVuOVV5TnlRdmFjTjNDWHdJZ2txUk55?=
 =?utf-8?B?b3Voc1hDR0lUZWVaMmVSOFFHSlYweUlsRGJkY0RiZUZQUTErcnlINDF6WXp2?=
 =?utf-8?B?UytlOVBiWGFYdVBpNEhuOXpyM21Wa2plSDZ5SFRjdTlTbnVuWUhTYVp1U1ha?=
 =?utf-8?B?Y0pwMldHRGFMV1JrT3FTNHZHcHVFS0xNQWpYMU9CU3l4RC9qVzQ3UWJNWlNq?=
 =?utf-8?B?RTdLUkZZQkF1dmpuRWNEbFlrTDUycW8xTUZidFlUaXVGOXRHR2kyYjErT0FH?=
 =?utf-8?B?NVF0R1I1TFE3VGpDYnZ4TUxkaDVJUHkrRDFjU0RmZmd5RHpFWDY5KzJWdDR0?=
 =?utf-8?B?S0xLclNXVlRTMlMrNGRLdkdVc1VlNGliWTNteVYwcVRXc01wTzBtZUcvNXZt?=
 =?utf-8?B?MFpGOGY2K1lCUHR4bE05NTR1VjF5Y0Vqd2dYZk5Nb05RdjdNcXY0bkZGZUZk?=
 =?utf-8?B?Q1JZRkFIWFRRWERWcjBEOEpOVjg4MGVsVFM4bzkvc1ZoNFY2OXAyODg5am8w?=
 =?utf-8?Q?j/gZjKKDmkH41gNFq0nkmlphp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xbo5gdjeNLjfZRI+80i6ok0rvPZ14TaOW9zbNn2jvnl/0lbzVlEjOH98SXndXnPEoEjdcRt6ZJVYYZn6pROcFW1dGkgGLmr//C3LehoWJkU9oagtIC6nRz+a0Focjb5POilWzCpPR00a/Hfus/wufDbik8pgB+XdpBLvib2oi3q6Qjri39hR3Kyx3TwFK565u0YY5sFBBeMKSWexz8bZcfRJXBYVz/wjARrS4EOVbCgNaWJ7C3YzrdvUT8gyhIo9glvmyr6SeYjVALAMzk8hJetG39LcPwA15KZD1zi3U3RSZzvARtkpGppvgKPKxxkEu3os7login3XGX+4o3ZSoIHOk2t+NtrNJp3YXKhyofZhr6WSagiIjY5Z2OrMV0uXCHTNVN4UyHyadTWCupv/3AkwJmSLYYV8MIyKO6408x3oVdx28kggfcxKRFTH4ys8DuIy74n9fDfNgHgYoz/RL0dSriCfcsA47QJY2g2/4g1djzBNN+oiDAB4u/guDUrgk16jiFGSWLDrv06xwUGJS9V1x1vGItYMjiGswdhi8+rBxKoeZ8KaHGcu3+4abM2EOWrnqH1YZCUOlWHZJB62n0D0ug6a3zmf9QrQRHr5q74=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e24dd6-c958-4a86-8573-08ddbe1bcfd7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:34:41.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7NO+wrPBmjkJ3msHhjfQuNl+SbP2AF79+ADpq5vL4+dSFHs9uinyzddq+nwkjpiydUXEWTQXTwnzCfJ4UFPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCCE340B80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwNCBTYWx0ZWRfX+pzIo/0CG+hZ L3pm69GQyz/jdIXNw8Kwc09PIkb7z2Wu6uCpLk8JN7AcQqTg5dn43bWa1lmd+HMWkGZioUJviUX P55552dQ065zdYaViOQfDKSYywJd0zMZVAlfM+DKhGwVZmkDciq2LYkjPwndMY6Rdq4wgpZc9g4
 iNkgEcg9tZ95WnJfoilQcptIhn3ChSDU75qE5kfWEK05CNWkMBBMFjSgm1bJ8EHM8dIjn4A57gK 99ECIsQ688VZOIe+DQjAzcRyrCm6FyEKptqz6+bp8ZHRyFRytZViuhBeeD6vJRNdMVj9UGznvqX sgTSVn50sdBYpYWaNNst0DVR/nCZJEfNZxrAoJlcHZVlIFV+LYHXTa7jM4+HJwo0aMPHrvPAHjX
 8UAL/FNMDK9m8z0SgbfpaUX2Vco0wzYscPJtW4wXlrV6TCv8QNQOQfG8M7gRZfdYHdmxBmyY
X-Authority-Analysis: v=2.4 cv=A8FsP7WG c=1 sm=1 tr=0 ts=686d1065 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yb5uq-zbsnQoPnMaKx8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057
X-Proofpoint-GUID: bjNmA24PM0fgGtPFC0fKI9TaBLV-c4j0
X-Proofpoint-ORIG-GUID: bjNmA24PM0fgGtPFC0fKI9TaBLV-c4j0

On 08/07/2025 13:01, Ojaswin Mujoo wrote:
>> You could do the statx call on the mounted bdev, and see if atomics are
>> supported there. If not, skip the test.
>>
>> But even for xfs when HW support is available, we can still use software
>> fallback when HW support is not possible, i.e. misaligned. So, in that
>> regard, we really should only test this on ext4.
> Hmm, okay so I'm a bit confused now. What is different in ext4 vs xfs.
> Why does the software fallback for xfs matter in this case?

For xfs, software fallback-based atomic writes are not even serialized 
against other software fallback-based atomic writes. They can trample on 
one another. That is a reason I say that this test should only be for 
HW-based atomic writes.

But even if the bs <= HW limit, on xfs may rarely still use atomic write 
software fallback if HW-based atomic write is not possible, e.g. 
misaligned, multiple extents, etc. I will emphasis that this would be 
rare, but it is still possible.

For ext4, since alignment is always guaranteed, and HW-based atomics 
will only ever be used.

> If we limit
> io to 16KB hoping that reads don't break, then either ways the fio
> verify should work. And if reads break then both ext4 and xfs suffer
> irrespective of hardware or software fallback. (We also saw that
> hardware atomic writes also suffer with same issue when max_sectors is
> low)
> 
>>> Im not sure if returning non-zero for ext4 is also correct as per the
>>> documented behavior from 5d894321c49e613.
>>>
>>>      When zero, it means that there is no such performance boundary.
>>>
>>> Anyways, I think there might be a simpler solution...
>>>>> The simplest way seems to be to just limit the $blocksize to
>>>>> something like $(_min 16KB awu_max) and hope that 16KB is small enough
>>>>> to not be split during reads. We anyways have other tests like
>>>>> generic/1230 that can be used to test larger atomic write sizes
>>>>>
>>>>> Thoughts?
>>>> As I said at the start, we never had guarantees of serialization of reads
>>>> and atomic writes.
>>>>
>>>> However I still think that this is a useful test. It's just it is
>>>> theoretically possible to give false positives.
>>>>
>>>> You could get the test to read max_sectors_kb, and check whether it is
>>>> greater than the bs. Again, more complexity.
>>> I think this might work. So i can set the iosize as 16kb which is
>>> already low enought. Incase the max_sectors is < than 16kb then we bail
>>> out. (but then maybe there is a very small chance of read split still)
>> Sure, that seems fine.
>>
>>> OR another approach is to do the verify at the very end when all threads
>>> are done writing so the reads don't race. The tradeoff is that this
>>> will reduce the effictiveness of the test though to some extent.
>> Yeah, right. We would want this test to prove that atomic writes are not
>> getting split by the block stack, so racing reads can help prove that.
> Yeahh, but now i'm leaning towards this approach of keeping verify at
> the very end instead of parallel. 

I don't think that fio supports such a mode. Or does it?

> Yes, it is a bit less effective but
> then having a data integrity test that can theoretically return false
> positives is not good, it'll always keep me guessing about any failure.
> Having verify at end will not have false failures for sure. Even though
> it comes at a cost of less coverage.
> 
> Maybe we can also get some other prespectives on this.
> @Zorro, @Darrick, can you please give your thoughts on this?
> 
> As a sidenote, with this issue of fio's verify read splitting, it seems
> like the parallel verify feature in fio itself is flawed for non-atomic
> writes as well since the read can always split and race with the writes.

fio does warn that multiple read and writers in verify mode is unsafe.

> 
> Not sure what the solution is here, maybe time for non splittable atomic
> writes (:p)

I just think that fio in verify mode for ext4 is ok, as long as 
max_sectors_kb is large.

But fundamentally we are trying to test a feature of RWF_ATOMIC which is 
not guaranteed.

Thanks,
John

