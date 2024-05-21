Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3DB67E
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716251885; cv=fail; b=IVhzA5NLA61j3kVz15CV9ABz+inKYlyxgImfyuft53FthqO3cP3kRndQjjT5YTjb88H7zvFaYfsVrkVMHqLZKztbdKPcFzUhdD9Euee0xunqQkQ/q9kLAaEhuiXRGWm9UDcU7AzmUYudBoEtMKaI47+OBR7WsC8NZonyv+Xwwg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716251885; c=relaxed/simple;
	bh=R7oWGb7hMe3O/H2rWcHtE7SKIEBDuYhGinBKPbzgR5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=csTC5r5YvbQ+UPg969+tLpMW3rp+h8yWrZTvCKeJuuiAW2McIbYEV+u69dT6J+rmi5CUl7/An9ENPOxXynMoxcFYZ+1KCbGaGRQlTVbSs5AooReL61+mI6WkRTGlvjqHI7xW5uZ1Dmi0RLSmpZ0ZUNyL7MqIeQFvJrpizDyfTHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKV7BA4Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wylqEJKO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKV7BA4Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wylqEJKO"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMwset016874;
	Tue, 21 May 2024 00:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zgc6vyvsLMxAKa0ZlcKCzZUvQRpvkO5kJB+HuUJZvrs=;
 b=lKV7BA4YsJMJ/8Cj1QsAILK7/05I5fNOoRryOvuOHpnCOEIKoQzq8S3lxcNviJKw8agq
 MwaeDxfAS/tk3edErxmGC4xCsRR5SUXuGUDk+KvkSFKHFSSXJf9tgQPyqT4YLu9I7Zsl
 0wloXH+awU1dVZ8FGVJIk40XqUg89OuRdJ3bJ423JDe+VCqYQL5OITPybznV9Q/gvs5t
 eOsUzU18GsndpuXydDwWrCyCrp/iaWxNIGD2tc78HApIhkEmf0O0XLu1gWmr35dQ018S
 T2maXJxFnYfAMzsW3CnCutOgl3+ngtSKXkMckEZQlznz+h3Jf7Zhx2IR2JXz+OFautj/ 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcduwqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:38:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KNiE0F004930;
	Tue, 21 May 2024 00:37:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js75b4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULbvxu7vAUxVRyq983CyfLh8+HpO9xfVWTmJ+GhkU912jZjsKV1eaUq0OPOANbaQ77RzgDIPwMvcREmLPAzhs3jSo8Pfv9DIStpbIhpp8rXSfTEW8uc1BhLPGgUTx0wF5qt1DGtib4qicoAp5EXjl0hG6sDap0yMq+J5Q21Z6yob43PBEGOzOkdMsXO/4qOsytDblxxJw9PMvFYp3ypAE/i5AhHV9UMPrjB7v8neP3BBdYAhDBaERTlJUrFSDznrTRQl23W6H9BuHDF7aaUasEkZtqPJtL9PFLSv+DpHNzZi14QTW0JvE4DJ3C/BWU+dVjBTga4D68uRAoP+bodFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgc6vyvsLMxAKa0ZlcKCzZUvQRpvkO5kJB+HuUJZvrs=;
 b=Q+KkIMZQ735dvEJXaAQpZGuLOov6JdZuOB8WCOcxD+avqYSey+u9H94gdAtySeXrqtczZn+30SVLh7bbWxiuN7ldftJEagVT28mWbt5xvgIvLhbAdEb+f1xaYqAoPpdv7sKEkFmEI7zM5+D62yvwQyZe2DhTqmNIhfYoOFrI7rkbYHL5lsWsj7UTGGdzT3siLgFtVKz3c8EW8rJGPaw4duq0BwZxU8wpTRGVrYnSnyPdSxSY4NO4HSfYdd6WPthjkEAzgHYmgDjCcX/6mrIDBxBZwLi67irlQ7iDlrTWgWatrBlLFqknXfOAcVlRmRMTWUzpGPh2i1Uu9G8gI1N/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgc6vyvsLMxAKa0ZlcKCzZUvQRpvkO5kJB+HuUJZvrs=;
 b=wylqEJKOGu3g8HOmVjMEaG7MLCm2fiM13VqPzBDdK8dUOGod/MJX/uBnX9q+Gk845ZCn+utNNunWXWboHBSf52hXMW9/M6BWd9ho5bL5zPhnkNOWOLEVS9wkEVB6PAUsmcM1oDX6O6ij2DquokguBXkRPFKr9QNjGHBuiHZgHO4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 00:37:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 00:37:56 +0000
Message-ID: <1ac790bb-4afa-417d-8e1e-e8539b48b8dc@oracle.com>
Date: Tue, 21 May 2024 08:37:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] generic/269: require no compression
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: josef@toxicpanda.com
References: <cover.1715896529.git.dsterba@suse.com>
 <ea5a2c054381fccd48bdf5dd987247a0c6bd55fe.1715896529.git.dsterba@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <ea5a2c054381fccd48bdf5dd987247a0c6bd55fe.1715896529.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abf1fd4-e262-49cf-5c9a-08dc792e419f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q204S2loTzZoS3hnVkYvVkxpY1JhMWIvaDF6V2VGWTdJdWcvUVZjaXgxMjVZ?=
 =?utf-8?B?dnhpaHJQdGlPWThUbTJwVTJSQXNtWGlCVWUvSzYyLzlyaVhTQ0N6Q1JuS3JI?=
 =?utf-8?B?bks2VmN3VTBtVFdYUC9qSEdlY0NYQWNSZmhtZmpGMFh4bDlwSHAybnRNL3Nq?=
 =?utf-8?B?dlY2UkZ2anRVeTVFMXU4MHFkNUFnMlNaUmN4aFFGYzRmQUpWZmN5enFRTkRi?=
 =?utf-8?B?TWkxL1kxZDRpc2dmNkhVVWlRUVZzRzBoUG50MGpab2trRVdtbG92b0duV0Y3?=
 =?utf-8?B?aHdtcEl2UVJoN2x2aDhkOXQ5UEVqTmdWT1E2dTdpTTUzdmZGTXJOdFdlYjJp?=
 =?utf-8?B?MCsvTmNpTUZGSlpKRUlPUHVsUmZZbjlpbHh5cmxybXB6dC9MR1VjelQ4M0Zj?=
 =?utf-8?B?SG4zZGJzWms0TmVKV0dHamhtTlVLdDhtOC9mYVNVL0VrS2dLV2pqN0NkQWhD?=
 =?utf-8?B?WjI4WSt3MGhXbWdRY0QrTlBBaXRBREd6K0ZYeVpLQ2JLRlBPR1dMUjh4OHd3?=
 =?utf-8?B?czlkUjgwRE53V1pVTUpmM0lwR2syY1UydlpoWUVJclRNdlpud2Z0a0JTTSsx?=
 =?utf-8?B?emxzR0l1b3dRZ1RtWC9nL0RyS0xGUE5mRXJ4Mi9sRWVRdTBSZmh2eVR5WXFr?=
 =?utf-8?B?TFJYakhiTjBCYlp3ODZnclJSMnZiOURUUnd2ZEM4QkNBTFh4UjFEK3hRU21E?=
 =?utf-8?B?QWd5UVI2b3pBYnBTQ1duY0Z3V3htcWhSbDJBSkpiV2RjUjh6UjBZU21rQ1k4?=
 =?utf-8?B?NkNtekNWN3g2NWFGYmlicVE1UE1aUkV2Q2t1TVRaQTZuZHlVbTBwZGVWUDRl?=
 =?utf-8?B?U0hxMjNoNk4zOGEwZWxzNkI5SCtIeHlmN1JWZnFiR2UrK1ZxRmozSnczQ1dK?=
 =?utf-8?B?MmgyY3ZwK1JBWUhERlRtM25yZzh4Uzc5MEF4OTdLQ0tCU2lWUXQzdDQ4TFhX?=
 =?utf-8?B?T1VlK3pHd1JrdzJ5c2lTTUhxdDJkMXlTbmtzY1d6T3dSVlUwOGJJSWFHSENS?=
 =?utf-8?B?WGNMc21Qb3Zub2ZRZmZsUHZBSGhQK1lHS3J5Qndvc1hlS3JwUnl0QW9IUW9t?=
 =?utf-8?B?VG42aHpVNHBPQ1NMU1ZTbGh2d1ZaUVQrM25FbU50SFZKbXNBT2ZsM2RoRllK?=
 =?utf-8?B?MnJhREJOVU1KS3l4ODdvdWFPcmhMOFRXOW1PZU8wNHdIZkZkVXAwbEVyYThF?=
 =?utf-8?B?N2hraVZEeS9tMHJPWWxVc2M1QUxHaWFhRmFKenErOFhHdkF3NFV2ejA2cG1Z?=
 =?utf-8?B?WnZNT3lsd1d2aFVOZk5HeXlQam1oRWI5YURUNmlBZzg1S3hEZjdXdzhlYjBV?=
 =?utf-8?B?Mml1cGs0RHBZYllENDdPWFlZSVhGT1Vub2RnM2NyRWE4ckExR2RBRkxqNjRD?=
 =?utf-8?B?UHpITThLWDBJZXl3bi9YZVNoWWxGUDBZVldCVndkWXNCS1puaVNTbERqSlM1?=
 =?utf-8?B?OXdkY3VHZGFSMmZjZlhBaE8xR0dtcEVqeWd4YmczYm5DenViczFGQ2xLSkVY?=
 =?utf-8?B?QlIrWUZveEVrM1k3Vi9HYU1jVkc2ak9TRkhqdGh1RE5pSEUzVWdQQlRLOWlY?=
 =?utf-8?B?ckcxZC9JaTJkNDJNdDF2dUozcE04amhVOWd4NUtoblUyaldlNDM2a0toNGJk?=
 =?utf-8?B?cklZNnUwRHN4eGhVaUNsekhhaGdzTlEycmFhSlgrN2d6d0ZtR01zVlpESkNr?=
 =?utf-8?B?Sll4U1k4NGRpT3oyVlNUa05yQkowUGZFTXU3d0VEMnJGTzJmWGVLZDVRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXJVR1FwRVliMnVJU1pZeWxXQU0wYWlvQU5zcC9Qb3Q2VlJqcFFmUjVoeGhV?=
 =?utf-8?B?YTNraHFTbHU1OFpJTmpicW1kbEdnZVRvdGZGeUttNG9EdHU5TTQvdzJ3TDdk?=
 =?utf-8?B?Wml2S0VhS1MyUnp1Vmp5Y252a21xdG9RTzFYbDIrR1Q5Rlp4dXg4K25sVGFz?=
 =?utf-8?B?RjN1eXF0OVVNbU1ieGdyeWhPQ1gwMUdUUGJveUxnTkNGcHo3T1J1SGQ4dkVW?=
 =?utf-8?B?RngxR2dtb1JwWWdoNllGaStwSFo4VCtyTkl1TVNCTW9ucjVlUk5YQ3RISEFZ?=
 =?utf-8?B?QjFRcG1JUkN1UWZiNFZYQ285djBQK3lKYTQ1bFFpUlhzU3UxaU5IRVNidS9J?=
 =?utf-8?B?RUQrTDRncm85eDRCbThlRG84NTA2cHF3TDZIOHZVNWFjb0RFeWU0T0t2RFZi?=
 =?utf-8?B?OXNxc3llT0lTQUdNZkRFdFViTXkrWmdFUllJVDMwQ29IQVV6dk1UUHJLNC9W?=
 =?utf-8?B?WXloVlh5S0pGSDdCSFNaWDExbGdXRStZL3I1aHk4TDZvM0xmckpSOG5ibnJS?=
 =?utf-8?B?ei9UZ2tLL0ZMTC9ad2VDTXg5SWVBU05JK2ZhaStBWk1wN2dBMmRzN0xFTVR4?=
 =?utf-8?B?UTYwS0JVaDdBcGJweFpkR3haWXQ2aVFKc1JSMjBLandSczJ5Qi9zQjVrV0Qx?=
 =?utf-8?B?VVc4WkgxZi84cVdCclZqQjczU0lnMXBtTTlqL05ZeVIwNFNCSy9YMkI5bXMw?=
 =?utf-8?B?VnVieFVHQ1psdWNpYUQ2dkNkT3NkVWtwdzhiZ3FRSkZDenNFbzBnakFhV00v?=
 =?utf-8?B?VDJxNWFpRnpUZ2hMZ3VPYS9nRlZwNll6Zkg4bXBYbllKdjA0cG43SDNnRE0w?=
 =?utf-8?B?Z3ZvRlJPK2Jmd3RoKzZGLzRmWi9hVENhQzQxOWc1dllTYWpMb2xCTFRzT0Z5?=
 =?utf-8?B?M1I0RVZwUnprN1FFb0xIS2swandTOEcvdDdXTnBBZkFNWjFoeWxtZ3FLSk9B?=
 =?utf-8?B?QllpdW91RFRRazBITjhRcFNhdW80b1RxQXRIT2s0VjlJVStaenV6MUVHVi9W?=
 =?utf-8?B?WC9jeUEyS1ZacCtOUUllOVk5dHZPRDdCS0x5SkVEdFlBbFltYU1VZ2ZCRXp1?=
 =?utf-8?B?TWFLV0QvQmNwZkxsbjZqRitYZzBZcTZXald6YXcyVkE2ZDBxeDUrZXRuaWx6?=
 =?utf-8?B?bzFhUGV0WjVOVHlFWXltWmNyYVVuY1JuQzhtLzhkbC93U3RuUnpib2loRVU3?=
 =?utf-8?B?WEQ2YTNSbXdtcXdUVkQzcTlxc3ZLU0U2WUlqenhLaGxOakl3bmJ0UVZkWE0x?=
 =?utf-8?B?b1ptVTlhNCsrMmYzRTRUOFhtYitMN3poZ0Fub3RtQU9jMytzV3M1SzhHaWdW?=
 =?utf-8?B?MWpTb3BRZ3J4VGxzNU9xaXBsRExpWUF3THAzTDBnL2JwTlBKZTlrTWxUbWJq?=
 =?utf-8?B?aUlWczVBZUFzWmw0dFUrcElnWGNTdXZKN2wwWGtWVjMrZE93d2g4NGw0di9y?=
 =?utf-8?B?WkM0Q0h0WHp3NXhKQWkrZFBNV0dib0hHT1JBY3hMWWZpMVAwcnc2UCtBanR2?=
 =?utf-8?B?TVlod2dUbUxxRUg3aDNsTVVuWEdrUXkwMkxEZWRCL2xXcFhCd1hNRW5EOEJF?=
 =?utf-8?B?THNZK1g4alFodVpiYTVBcU5abkIwK1JvcTlabE02SnRBMkJPZ2FqdHovWmox?=
 =?utf-8?B?S1RyNXNJbHpEd2d4ck5FdkVKeSswVE1qSk8vbkxNMURoVlZjdDdhKzJTWUw1?=
 =?utf-8?B?UHFBV3lPUTZhb2lOSHRCdTlRbi9paGpXalI3S2VkT0pBdjN3ZHBzOUYxK0E3?=
 =?utf-8?B?LzVrR0FycUFxdmx0WFkvYkpvQ1JTcmZzbE9iSWNZT3M1TEZqNnFFOTVBeFRR?=
 =?utf-8?B?dmdWSDUxM1lDQVZJSDEyb2c5SFZDcnpPWHJlQ1dyQnhiNTcvcG15cDFFN1Bn?=
 =?utf-8?B?d1RhOHc1dnpoMnVFa09USjNNWFdBMWNlcDZVM3Fib3Nob1daa2JkWWdpeG5X?=
 =?utf-8?B?TEk0Zis4aHMyWHlGSE9lbDQ2VjJ4RURFbjk0RXpBRERZcjhJd01pMVRjdDJR?=
 =?utf-8?B?SVBhQ1YyRDJOQUhtUzdvNzgvNGJIeENOQythU2t5NTE1MGpUV2Z1ZEhydHRO?=
 =?utf-8?B?a285RTBVWm1lUEFiT2VKUFhRZ3M4cE4yTi9jZ1BBS2NML1YwYXFGSkl4Vncw?=
 =?utf-8?B?UEJZTUFNa0R4NWlTN1dMR09Ycko0MzkwbnhTVGNVZFprQmxablZFTkxFKy9o?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LroTtQmP4kghdUf1K3IxMEqMoglDWvVnLbJJzjwwp/I6HZHPp9DnIl6NpBesXFQQBlzF189IazS2h+IJkwN7C/C1yVDqYCjS1FF0L3LxU+heg6ytZKZBpo7CKzXbK/5mPH9hr9VpOd6WaUtOiZx366K+DgoLoDiIPYoQ8U2ji7pTmH2nsS6xuJ2z4kqFRsV9tnkXhKJIchFxNc+zfJ/msi2i3UTL4lyrHaJmEUPWwXmHp47wRf9x6guni7ER5HywQ50xWspBzjGYZFK1qcsu4Jic+zYyn2JGppKEcJua6UGXUZHfbYY98pAmgCjL+mQt+7lHgSakCJw37CC6dM/9j8bAZ7emPOHZR1E6CEG7I4/LIuXuvY4q9SyQUVEqolYH41nGq8OkQH/vbhivXW+A4g9EF3hiyOdZ20G4JHkmUedGuAv0GuDqI/5+IWZWkVFwoxa72iCtS/dp7bao65kCKy+tE8Cxb6W3Qw1HqHrz5i0js2Zyi70wx5XtCd1FjQJCVT0+d3+e7qscJnL5ADfEl3o5HDqbyRhX3aT+ZBuog5R7hcg4fDf2M9S2EfWl5FRGYQwTvsOsBZDC1doinJvJkqvmchVt0KNjzQBbZm+d1WI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abf1fd4-e262-49cf-5c9a-08dc792e419f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 00:37:56.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rPz8TFBcs8CzO1n8uF1ZiHxBiE++2rMKIdIP6eAdS3X+Wg6CM3d1WFpp9HqEiiZYXzHQkWDt6GULuDN8J4d8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210003
X-Proofpoint-ORIG-GUID: SVn3FqKSee_2KiUEya6VxZ-ppzLS3QY7
X-Proofpoint-GUID: SVn3FqKSee_2KiUEya6VxZ-ppzLS3QY7

On 5/17/24 06:12, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> This is meant to test ENOSPC, but we're dd'ing /dev/zero, which won't
> fill up anything with compression on.
> 
> Additionally we're killing dd and then immediately trying to unmount.
> With compression we could have references to the inode being held by the
> async compression workers, so sometimes this will fail with EBUSY on the
> unmount.
> 
> Make it easier on us and just skip this if we have compression enabled.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   tests/generic/269 | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/269 b/tests/generic/269
> index b7cdecd94f219a..6ee0cb04581632 100755
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -11,6 +11,9 @@ _begin_fstest auto rw prealloc ioctl enospc stress
>   
>   # Import common functions.
>   . ./common/filter
> +
> +_require_no_compress
> +
>   # Disable all sync operations to get higher load
>   FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
>   _workout()


Can we use _ddt to fill the file with partially compressible data?
On a laptop, with compression, it takes 63s (otherwise 45s).
If we're ok with this, I'll sort it out here. Git diff below.

Thanks, Anand


------
MOUNT_OPTIONS -- -o compress /dev/sdc1 /mnt/scratch

generic/269 45s ...  63s
Ran: generic/269
Passed all 1 tests
------


diff --git a/tests/generic/269 b/tests/generic/269
index b7cdecd94f21..29f453735fc2 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -29,7 +29,7 @@ _workout()
         for ((i=0; i < num_iterations; i++))
         do
                 # File will be opened with O_TRUNC each time
-               dd if=/dev/zero of=$SCRATCH_MNT/SPACE_CONSUMER bs=1M \
+               _ddt of=$SCRATCH_MNT/SPACE_CONSUMER bs=1M \
                         >> $seqres.full 2>&1
                 sleep $enospc_time
         done



