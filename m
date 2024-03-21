Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB3B657
	for <fstests@vger.kernel.org>; Thu, 21 Mar 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993142; cv=fail; b=LmhxejD9+NquwHv6MIg7PSwfk4i+g1soVdayq19MujXRuPDq/ElsjJTDkvTwHbk/O2tXHmj0HKCT/YrW217eV9UUsF5qGn4Qat7bmCecAHGdl19eyaGGnAlS54bwVrHHNVJVWHGj050GgUF9IwmWgstiEvrV7oUPXIVu+0xCK6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993142; c=relaxed/simple;
	bh=wDOhvECLd44PuM8hEpfmhMotvm9Yzoh6ukgC3VbVsvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PkeeZkVzI7lUC5RgsWRYNxMryv3x2TJfnU8+WRXsi91tJz9fVBSJz+V2jEPsdreB2Vh++IAo4O4BnSzSF8+2gz8GCpEuWQweibdYu6UcwHt6T48Z+ExTrkIswkMNPan28yxTwT7jIm8rpvR5D+yRUDw0fiM0NI85kdjMzR8SYHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZY3px+9+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sheAK7E/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZY3px+9+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sheAK7E/"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L23tiQ030753;
	Thu, 21 Mar 2024 03:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2wqi4WDjULbmdV8hdWD9E6cAflklWiKnh/t7G2WnvSA=;
 b=ZY3px+9+m+UzisdiRfM11fsr4LuCv0wU5tT+yjz1GIjkU4IZ1snWDYzC3hGK+eWnQrvF
 Sy3HsQzkcRCYTcOyE9u/asXlXfTVITjnl3XtsGb2cQi80nn2YqKdN8kIpQdCo7Nnfr5p
 LC5KVvR12iAr0Tkf/TPI6IUlOi2ShRillKelruoMgB+n2diC7bImDn7r5TL6F+AE/B4I
 37djaa9fL6BLq67MMWcIUjkSw8fC9z+U8rDrEYtu3/HJVpS3f7Pq+D8ERKUnh4rgf0yH
 L/2QILHlNimVp83DWBN00oEqje0hVJPpVc7vaKoYPBwXwpRE9MMSy8GnzyVRyO26TIil Kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tskc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 03:52:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42L3gc6r006027;
	Thu, 21 Mar 2024 03:52:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v8p75d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 03:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEZm0wrSu7gl3YxCgTL1HI55h97bTbXxYHxPsB364Zctk6UbgNUzZ4OsvSF3/v89Ny1qe6dU6RQKHiZBdCLg9dgqH2shOKpNtUj6HniyI5odQRwTnZ/IJIqy+4S4KqJms3oQ3ZFtJH716ydaxHDhvp0UIQp99ZhdxhWcWHP9wadRiWTNgK53H19tacVnkhtXgBFmE5aLCn20axOlY1rlg4nw3JxwWXFKrH38TEo8edT9mZBS4t9TNB11mUK3piN+YixUmIRX9U1OAtHTnqgrboLubGyeKogbsiLDm27TXhKzDQo+ZVa+NNP5tC2fFoV+TIjMIs8j1xEDPeB5andwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wqi4WDjULbmdV8hdWD9E6cAflklWiKnh/t7G2WnvSA=;
 b=aAPbVcMoHLg3skG2y7XuJTPUxiM1J4tDAWY7afqRlkmTjMtmegcKxjHND3OXeiGPnMP47gtZbAXsUQR8mUg7ETTfwTG9tpEIc4LCb4Gew3KNTS98owrjr7UqldJk3KKEG4tqEQelQNbBpnH7WeshHck9YimQOnA3w61cs6GDKXNCQ4YwaAPynRgvs36iNCBfmjJvHaag/txAEMOR6hmWtv5JI4DqsGxD4D6TBdbTUcl8xV06h3n1b3u+F2MUPCLt5OQc+RsRExZKhP76V+YCIQ7ufFEHiN0ydOa/1oh6fEnmUcehkMwfOMXPdYsHDKvvb19Y7J93jLQ+wMMdeV8T2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wqi4WDjULbmdV8hdWD9E6cAflklWiKnh/t7G2WnvSA=;
 b=sheAK7E/kqebN18AEfppj06SrXRR21NYz7CBron1bPEvEYkeK5gkxZEow6AzOoPaqdCxrU7gn+FrsDcvF2+eNAP6fNd8qKeJ7Bvc+CD+JabEwrWY/UcPZRKh8ZO2qsADBmaER97IYvB03hD+BeArHhRJYmgv9JWg5JE37qNIW9o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 03:52:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 03:52:01 +0000
Message-ID: <a7c192ba-301d-4872-a6d9-7aa8e4f83bc3@oracle.com>
Date: Thu, 21 Mar 2024 09:21:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] btrfs/330: add test to validate ro/rw subvol mounting
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1710871719.git.dsterba@suse.com>
 <d61b8bd818a8f9403982f532ac21586f6c96269c.1710871719.git.dsterba@suse.com>
 <f9dc2fdf-e468-4525-bb74-47d5bc30dcc0@oracle.com>
 <CAL3q7H7wrATcAKOxy6xSy6USBFULAujfKEkP5Giv23n_5n+zgA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7wrATcAKOxy6xSy6USBFULAujfKEkP5Giv23n_5n+zgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee14491-2511-47a2-5a0e-08dc495a43a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uRmzGpnIudsFKlwlun9ScdhpOVgi/69JkeOiu0JyHxGceDjo14184afN5chMioiC+3S4ukKY0clfKBgJc+wwu0JLRWULSchGEnYFgiynlFGpqKbQx9AKbqvdZMbIWuWTv5rTtpd5YYgt/bB87QwIJ+gZJdQupmkEZMAW+FkpoC4Uy0TkDL0uvLQ+hW7HiiMkCdCOM0zVZ9/6Yf9mV42y9x3WqlLPtNsqNoXlQa+/4T0cIJ6f9keadSOXIjFTRAn78EZRVAqbgjrvGFcJslToBOxRvJUjtcKykRUyj8JiB6JbLGsJzgRT1+QMEWyvYt8zadBUjPDkW18kh2ObmjoZYpKsK7cMZYH/h1/gZHwuD9mrHSUoggpaCpxomDusJtyNTt6+4a1xtKfVUuL0idLhEdT1JtCHJK3EiAG135AmLxTB4MK/366Y1qYgE11lAYHicP41wgqF2k5Zcbry4c4QYM+gJnneTsPKBzdO/rOC39hQE6vDJ8Wqm3egRBw4VSg+yDg1e0jh/fIC3NQ3C+FTe1hq0UKbxWJIm5OJU+4hMsAlg0VZpxow/veaUcq47OOzqNeTV56nnlJ1nFY5oEKoVCkuKXmnbcet7zqbhUbtnLU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aldsUXhXRENXQXVpdEhHdThGSDRnM3lxRitlck8vUjhGZWhrcExjNGNQRmE2?=
 =?utf-8?B?UUJlOE4wN01OZUxzYnBUSWN4L3FINzVDTDlPN3RGYkc4cnNub3k2cjI0MzN3?=
 =?utf-8?B?bGZCTlpGcFZ2MmVXNWVmNGhMUmZEUVpYSm84bTZ6T1kvYVV1UjV1RXkxeDI5?=
 =?utf-8?B?M1N0N0t0M0JyTEJyYUZRYWQyUFduay9xRkhOWGlyeWpTeUhHNDQxMGxJc1hX?=
 =?utf-8?B?Zm1ZWWtJc0FoZVcyNVFacXAwR0ZMY3Fsdi9EeG1OSHJRd0ppRndMZitKbkhq?=
 =?utf-8?B?OTF6V1FxV2MrMUVwRHBOb1oybFdCNzd2dXdDYU5ESXpVTWQ3UzBkUXkyaExM?=
 =?utf-8?B?N2Npd3YwcUREejlGNUdvSk51OGdWRlN2bGc3dkswQTRIdE0zSHBEZk9ZTWVW?=
 =?utf-8?B?UlhXdjNRNWp3REZVNUYwWTQwNExBSUFxZGtQaWhkbFB0MUZZQ2VPQ3pUSTJ6?=
 =?utf-8?B?WjkxNUgvcTZRQVM5V1FDbC9rSDQyWkt5bHhpdlpjYkdLOThSM2hDV0FyUjFi?=
 =?utf-8?B?amdlVUcvWE81b3EzWTVqTHp5R0IwUVlQSkx5OUp0YVl0dVhQWWJFdmVqS2l0?=
 =?utf-8?B?NGN1Ulh5R1k5MFpWZ1JkVkhMdDFuV0xNeXAxME1JMDdJaUlZWndwSTVHMlJ4?=
 =?utf-8?B?MnlHbUV0bWVxaisyeW9jaWxSSnN3R0gvRDNVN3VwRkpBRWFsMXV3ZWUvdk5V?=
 =?utf-8?B?VUFoK01nU1dmUklIL3dGOXlzaEJRbWhrbkpDQVpIKzZLMkVoS2NFb1cyL290?=
 =?utf-8?B?d3h6emlPVkhzUzBOZGwrb3BoajlmOVp1bmNlRWdWWnhQZkx5cTUvWWNNUXVZ?=
 =?utf-8?B?Sk5DMVdqeGZ3SGptb3AxV3dUMmRCTmNwczVKNENSU0FBcHltdjVTbmRxNjQ0?=
 =?utf-8?B?TENidGJkcUprMHVhV1FZZFMxa3FXS0c2ZkZDSi8vQWY0TFJBVXQrZHdjNld6?=
 =?utf-8?B?R3ljNVc1UEg4eDdadTUvTVNYN3VQODJ2TDRuc2s3MmNRa2lESFBsYU9oZlk0?=
 =?utf-8?B?TXVLNGkzc0hzc1htcFlGK1dpTERnQnQxUTVyeS8wWkt6RjhsUVhTcU1PSmJk?=
 =?utf-8?B?Nlo5WUUyNWFhaUd5NTFtWEJoNGpYK2ttOHZIRGlMM1djckVhUUpONTg1aG51?=
 =?utf-8?B?cktHa2p5WTh6N0ZxcUwwYzBGRUh2WnNBaEJiNmdISnpoR2NJWkJ6N2E2YmQz?=
 =?utf-8?B?elgvWnUvcEVMZ3NOb0t1Wk1RK1lGRGdPcHNVS0k0Z0Y4U3Jxdkd1dXpSTHM0?=
 =?utf-8?B?ZktMY3hjbmF1TlRENjBWNXJva1M4RUZyb25tMzBiK0dpK0dMeTNEQk9lMXAz?=
 =?utf-8?B?M2tDMVF6djMzUE9neklsLzdVMFZxYndxNENncy85aGY4S0JEeVc2ZWZCVUJM?=
 =?utf-8?B?TXRTOElCclEzcUVJOEl3eW5BcktNRXB5dEFIYk9TWjZLQ2dPWDZua3k4Rmh3?=
 =?utf-8?B?Q2JWbDBPdlJZN2M2dTJPMVBYYjV0bm5id2xYT21aY3ZIaE9FZHlLVTB2Q2tE?=
 =?utf-8?B?NzJFQ0dNN3daWGZsalY5dDBxWEdjbVZMV0p0dzlCMVhZNjF6d240eEw4a3l4?=
 =?utf-8?B?UW9Rand5eHM4S2xwQ2w2SFlsTmFad0RrRWFNNlNWK0pIUXVyNVFvR0ZCemRr?=
 =?utf-8?B?T3VCbGlJWTQ2YkMzRG10aWYvZmhxU2xPSWt5Ni81WE5ldGNXWCt1dFZmNEtS?=
 =?utf-8?B?eExtUVl2QXR1V3pTVTVuU0NyL0UrZzFYdzFXUVdxQ244dUJxS084NTY1WGlD?=
 =?utf-8?B?b3ZQRUZlbnZubDRkamtkVEdMUDVjd3BNTWlyemFSRHVaWitnZU5NeVJvZHdW?=
 =?utf-8?B?RFVIbVovWlRsOFpKTFNNVW93YXBlc3lmdHYvQnkzLzBuTWx3RFZZSnVUMUM3?=
 =?utf-8?B?b1d1RmQ0SHpDb1d5ODZMcUM4UW8yM2NqSGxnT2tiY1VSeE5YY1o4ZHBkbTVh?=
 =?utf-8?B?MjFkeHZkbDRSWklvMDZvSWQ5dzRCQTJmL0xZQ00raEhDLzRSVXFYdUY4V2lF?=
 =?utf-8?B?UE5tUFVPRUZNN0dXbldPL1ltVS9mVndlaGdVSDlERzJWbDUvNHB2aFZxQ2Nk?=
 =?utf-8?B?c2taVmVsdmU1MWxMMENJQzFFVzQ2ZDZGMXh0MW8xMTlabUVmYXJVVStTSmRo?=
 =?utf-8?Q?1IgJ5SLA1NNqQ66sal5BEpp2h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U/F7llTSbSrHQY+obCWEcD5M9ZVPCkKmOmhC56RBVugjxO5XX5AqAN5THNJ4KmRAEEnQr2HKDdm2SLPkPf5zffszj5MgjKO56/c9WNwBEMPapz0bULWLtzwhS0mMSkAXHL5A8T+no6NiXX451nASfAfEmLgs3PLU/toqrHkUsUaH1/9Py1k1tw/40aEQ+8akBwwdaY3cc0bw2Heiuqxj8VIwH4d1fdE98vqQUFV582CkZRbIo/mh9YGHnA3RcbAlSMdEnU3vgHeob2J9026RA2BsaThqnznNr84CRIjGZpGunu196JN1UQkNP6VTFomlAfb3LIcTCtjlyq97mjH9Mf0QWM/DAIhXKbFWP0lFcoomMc5t684KoslcIok9GO+dBo88LWnOyVKnAjD+KR2lanoYpRw0ls95jb+yhx5PgfNgVyEiKLiVF31Za8co9d6x7DSKaUA79BLsgrffxO1C5SXysm0WICzoIZtH33sZpdwaXFbJMrBgen22qJGTybYtWpFa+2HwAAfFCPqC5AsE/oG14S9zv6GrAo4bBL/6aSXYXp5xVktw/bfT22H/yx+bf3x9WgDBOVCkfXU84rD1507p1Az2OdgJeXIvBqmyRf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee14491-2511-47a2-5a0e-08dc495a43a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 03:52:01.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f7CdfkEgu+J3Fpj3mNc/07xMvcFwPWhKFMSyZoAnkuUgn3zkln4+SRbvgnX2dCS5LliAQb4zq4tOAqVex4ouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_14,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210023
X-Proofpoint-ORIG-GUID: WWEdK-WuERHfKxPAhYJgV6hePO0U-Zhf
X-Proofpoint-GUID: WWEdK-WuERHfKxPAhYJgV6hePO0U-Zhf



On 3/20/24 22:31, Filipe Manana wrote:
> On Wed, Mar 20, 2024 at 11:34 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 3/19/24 23:42, David Sterba wrote:
>>> From: Josef Bacik <josef@toxicpanda.com>
>>>
>>> Btrfs has had the ability for almost a decade to allow ro and rw
>>> mounting of subvols.  This behavior specifically
>>>
>>> mount -o subvol=foo,ro /some/dir
>>> mount -o subvol=bar,rw /some/other/dir
>>>
>>> This seems simple, but because of the limitations of how we did mounting
>>> in ye olde days we would mark the super block as RO and the mount if we
>>> mounted RO first.  In the case above /some/dir would instantiate the
>>> super block as read only and the mount point.  So the second mount
>>> command under the covers would convert the super block to RW, and then
>>> allow the mount to continue.
>>>
>>> The results were still consistent, /some/dir was still read only because
>>> the mount was marked read only, but /some/other/dir could be written to.
>>>
>>> This is a test to make sure we maintain this behavior, as I almost
>>> regressed this behavior while converting us to the new mount API.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>
>> looks good.
>>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>> Nits below.
>>
>>> ---
>>>    tests/btrfs/330     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/btrfs/330.out |  6 +++++
>>>    2 files changed, 60 insertions(+)
>>>    create mode 100755 tests/btrfs/330
>>>    create mode 100644 tests/btrfs/330.out
>>>
>>> diff --git a/tests/btrfs/330 b/tests/btrfs/330
>>> new file mode 100755
>>> index 00000000000000..3ce9840e76d028
>>> --- /dev/null
>>> +++ b/tests/btrfs/330
>>> @@ -0,0 +1,54 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
>>> +#
>>> +# FS QA Test No. btrfs/330
>>> +#
>>> +# Test mounting one subvolume as ro and another as rw
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick subvol
>>> +
>>> +_cleanup()
>>> +{
>>> +     rm -rf $TEST_DIR/$seq
>>> +}
>>> +
>>> +# Import common functions.
>>
>>> +. ./common/filter
>>
>> This can be deleted, as the filter.btrfs also calls the filter.
>>
>>> +. ./common/filter.btrfs
>>
>>
>>> +
>>> +# real QA test starts here
>>> +_supported_fs btrfs
>>> +_require_scratch
>>> +
>>> +$MOUNT_PROG -V | grep -q 'fd-based-mount'
>>> +[ "$?" -eq 0 ] && _notrun "mount uses the new mount api"
>>> +
>>> +_scratch_mkfs > /dev/null 2>&1
>>
>> _scratch_mkfs >> $seqres.full
>>
>> Errors, if any, go to stdout.
> 
> We typically redirect stderr to stdout because in the past mkfs.btrfs
> used to output to stderr a message when it performed trim.
> See this old commit:
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=afadb6e5958c5acf2425d6a8a9372b63afcb4f2a
> 
> And nowadays we're encouraged to do:
> 
> _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> 
> So in case mkfs fails the test doesn't continue and silently passes by
> using the filesystem SCRATCH_MNT belongs to.

Darn it, I keep forgetting about the trimmed message history that went 
to stderr. My bad. And I did search mkfs for what went to stderr, but it 
wasn't an error. Btrfs/303 fixed.

Thanks, Anand
