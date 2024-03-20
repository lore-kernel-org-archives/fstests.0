Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C23FB95
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934547; cv=fail; b=rdEiqaU/k6+/NssRHlfpFj/tSy3ewnYqKwSYZzs7Pw9r186XZ5AQLf8dKAQ4FXyA939l8AX/9o51S0Nq1ISa7Y7m8VzDekBzD5Y1f3pZsBRqAq22vE3D5tSJon3+qByqrBKq+OoiZlx0tNXuZKvxbE7TtC3B6X3DeuDxC/0WSUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934547; c=relaxed/simple;
	bh=bAs1tg461q3aeMrNWB4tr4tLrrL4zLFp1SPnkRDsSEU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nI7JAZuUJGFXtiEztegy98lW0UKOA2INfQikDlhSq1/oOLWG4UWOjMHo8e9vJaG3FJUMlOh9tGWJhYUFlDb0/JZEybnJleNMbhqb9VOSX3DJ99iqC7w3pfA5KIbps5NkdaXV+AnrNgds9UIx+7ayp+emcLretjfMKHr06le3dQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UY9MOobS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvvqyXSm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UY9MOobS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvvqyXSm"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K7xPtT009494;
	Wed, 20 Mar 2024 11:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lEcDJlNrj2aGJgWa5BhWmMsTrXthZIvJnUCw9qKhTtU=;
 b=UY9MOobSlHqj2idCd8+l3FGj6a0GZxDXciq4l49TBnrUaT1OvU087N9ggVxZYG+e7JZg
 dXFuqFcDq1r72STTx0KwuJtvuq0qh8wPmFT7J89K6o3csYzZ2NXgbHXHJzOsBrBi9zs3
 arH6mWHn71LaxHcCknKn0HHDOpy/EB9uWtUJK9V/WR3HDS43Df4h2lk/ulBiokLnBAPB
 q14PjFk6VpsGUDR2cVrLDSLYLGxzcyRJ4I+ghB+2frp7GYuebuFoPehksVHPGex31Yl6
 VqNAcm5qkhS8rC1XSwNIB9oWOhwFU3ODujY5OdvKfg5Nze9PfhP7CPpkdldqo0uvwKjB +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aafs1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:35:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAcYXl007544;
	Wed, 20 Mar 2024 11:35:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v7mbum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDehZTSWl5p1722CDnz0+9qJpqyWbl+rzFa1ZHQjpVyGFcgVjajlVqFJXUjuk9XRFHHS+jAwZdOc4X9wLxwCJ0PG7608wPh3EXWDklA3jhTxBEMU96MmrOzYUafDQjWn8vwBgaKIKRCzYAVqG8LDTP4McuIqsSnlj/byjF2N0XhaOqY6irGhpO6PpyZbQFG3u/qRTb3ec3UT3Q7giHvwp5l+6RMqfTb7e9xK6pJSd856uIbNtT21v1JJ3F+ibmAimmTE4LKlsw6eMK/4Tm9ez1MtlaVvraSBBnPjd0PQ1m3+E9XTPoPVnvWDCCMDB2hFvzx+FWoFg7V47/tqsc0USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEcDJlNrj2aGJgWa5BhWmMsTrXthZIvJnUCw9qKhTtU=;
 b=gQmyRUq10RImEvZqLkM3Pk4kCmltb4sVwmSsarTCI8Os8IWMPU21A7J0Q+T5emwvoIFOhslHCspZ8oUK1lm6osuWIc+dehsP5YH0bRYBaQnKyw16ORcMYuvBzYQJkChW8yuxcdkeD9OrAGVUgD2Ln8jn5ixaR8v40W98fpLYKrinq76P9XARK50Gv5mAhGRLkSmJmbbg4tUwYccef3n2nN3/rL7ptaKP7VUn4RnBcIVBs4lT5GQsZXfFPbidvH6UhznsKK0r9AwaMIVrzUTaEr4ufQzHcUv3QoC4zFQhBMGbbVer1WQMT/DfcatrjB1e0Mav2LUn7MwyoBw4z92olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEcDJlNrj2aGJgWa5BhWmMsTrXthZIvJnUCw9qKhTtU=;
 b=dvvqyXSmnQ7ZPFn+iLsCEN8nQ7sgNJNqKy2UsKdWZWV21kTWsCV+chwuiyRr7wLc3tfjTFfHyhwJBucLas9GScvcnJZNGfDfAcIYNBupoT2iFezrln3Qs3a+hIcuIf9ldgcREO3gvavU1CrIH2cg2buSuT0dATNRMo7Nhep5fQM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 11:35:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:35:40 +0000
Message-ID: <54982d98-f173-402d-8a8b-132c3563bf09@oracle.com>
Date: Wed, 20 Mar 2024 17:05:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] common/rc: use proper temporary file path in
 _repair_test_fs()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
References: <cover.1710871719.git.dsterba@suse.com>
 <e8d43ad899188461f42f0184075dcaf70526bdbc.1710871719.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e8d43ad899188461f42f0184075dcaf70526bdbc.1710871719.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: ef919315-d5f0-49ec-3dd2-08dc48d1de61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FPeyHcHsYbHVaEO1mAfHcgnATMCJiR9YgVg+g6kT9mMTMDqet6x32MgqaklhTSQCNB/8anPaVEpeKGN3j8Atf9zrz0Fq0331BjTwPrxiqBhm4chWtSvO7Q3qf1fUtbDErs2WqVLJ/ds7uQKp42cQOvqusCfJG8sgdW77Pq5FrWCnQvdT1Z8d7LgGD/sJvhTLyoxJjxpz7fe4himO6s0XtO0ae09pb5t7sRPvIExFyG5G5I3XUZpkX7Pyvtstbz+NDujxVR55u61BuUJCmjhxMG0i+szlpdb68tCFLdSzHetzcQceiV7kcAtyE2pBqW1vlRmpvsnh9gGn6112IIbNPSJ4NEZpbRfbVuIws6mMqnTFASmuZ5yKvHSObQP8g84IzTkpqYisHWC1T6s6mw1MDoLaM6xOuzeTCDpRqUYXhv6A7m+H5WlTYVZt633qEi4h1dfaz7EkylPY9QxlTjOVmXA6PZWo4lyAxum/v8VuAFSsAwnetIVQ9PWIAsI1BqLUbFcCmfaxGtzZo79b79uZf+fcrZ3jW6UZxeRuywteAQEf9FE+ZzKYe8Pf4ughjJOXmj4mEo5l169+etinkLponJlQL4xo0bjRP1k3hj9zl1RuR8smooqEB7R3DsRXhqH/jcqY3G+EauX1lUzS4CG+Er6ygyqDgc00AwpxlHoJgmY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Unh3MmxGa3dTdVZveU5xcTZ0dnFYR0w1TkYrZ25scE9TRFN3ZjMvWVB0T0J5?=
 =?utf-8?B?QkhuNVdwSFhRYzA0dXMvdFpzaUV3bWpLTHJ6Q3ptVktMNytVaWdZN09Uc29v?=
 =?utf-8?B?VzFmSk9tQ3luNlphOTNXUGMxcDBJMXR6RE5vekxGNFozQnNpdzZSTm5Zak9J?=
 =?utf-8?B?WXZRRUNXakh6ditWSDhuYkh3dmhaQUcyQk9CZDZCMWNobHlkNDhJaExPNjJB?=
 =?utf-8?B?TkJva2htZVlTVVhIQ1VPMTVSZHRqYXJMVVVZcDA3SFpJVVpQMnIyWGtIcE96?=
 =?utf-8?B?d1NJWUNnMU1vRmhxZ2xxQ0hmWnFha2tiUjNWMmpSK0FNdE91cnpGTnV1U3cw?=
 =?utf-8?B?WXhQajk4QjNIbC8rU1lhckw1cEQ0blF2S3NhTnZrWnMyRldDWjBqVWY4Rzda?=
 =?utf-8?B?RmFHcDFXTElwNHJ2V1hPdHJic29RYzhSbzBIS2dldC9XY1BjMUoyRkFuS2pH?=
 =?utf-8?B?cU84VCtZTk1VaTFoREZjSEMxSHpUZ0JJSWtrelVvWnZHODkxSmEzR2x2Sk1L?=
 =?utf-8?B?cWIyM1JXODJOWmRCck55OUhFeE9ka01mWVdyT21EanVCcm9BVW14M005K09Q?=
 =?utf-8?B?eW5EYVJ1alZoOURoRDhTNCtseGQ5Y1NTM2trcitwOGluZmllSE9rYktaVDhF?=
 =?utf-8?B?L2hDK2xkaEc5SWo1akNBRWZEZ2Vjang2K01xQjZkTzNEZnk2M0NsTHRaYzE2?=
 =?utf-8?B?ZmJVUS9EMEwyTkpkejI4Ym44bVpnRlQ4SGdMSW14SXdsakxYQnlrSHRZU1or?=
 =?utf-8?B?RHhPei90ZzFnd0JaUkZjMjQyMFdVSWdUN1owUS9jY245S3pBRWNmTC9uUGpS?=
 =?utf-8?B?ZnJFZy8vdW5yb1FRcVozL0lxdnVWTkhlVzBUQ3NrTTZCVndFWUcvcExmMlpZ?=
 =?utf-8?B?VWw2L0JQdHlDZEk0Z01mbTNxenlxRk03aTRxRk9KQVFOVi8xdE1IVkFPTGdx?=
 =?utf-8?B?Nk03eVgxa0h4VFdRbzkzTUJTL3FVVkIrVlVQT1Y2ZXlISnByNUNNL1BpczdZ?=
 =?utf-8?B?MFhGOHAvcnVRSi8wNDhuUnFOWXdGSXU4QjBZT2F4SFpaSXpMc0c4R0tCM2No?=
 =?utf-8?B?ejVROElFYXF6OVRjRCtYeVlwVE5DRkxYMjUzNjIvQzVNNThROFVRR3hNc0tE?=
 =?utf-8?B?YUFVZllZYWo4clRIbE9FNE92QXdrK1R1RVAvQUF1Mk53UDZ6M3UreE0wQmR0?=
 =?utf-8?B?TFFXMkdwdnBoRUZiV3g1S3R6MVRSYkxUaDNCbVp4d1ZrclpMZm5FdFVNSkhD?=
 =?utf-8?B?blNZSExxM1NTSnBBS0hFVkFudDdjK1JsV2RLRllFSnZsUGFxQ3dsQUlyV211?=
 =?utf-8?B?bnRtQzBEdjg0L0hlcDE3eGY5Vm5QdUhEdnF3eThTd2NrbnMydnNKUDNNWTcx?=
 =?utf-8?B?TVBqUm1JdEVnWjIrR1JvN1VsR1FHcm4rSzlWN0xOaFFNUERYZ3AvTThXMUk0?=
 =?utf-8?B?cytLYUpWTC83QXpQTWQrWVNZQ0RVd2pkZm5OUXUvUTh5Zk95b0l6b0VOdjEy?=
 =?utf-8?B?WWRDSzFkYjdsN29DU001ZW9DTGlUUnlaZG9WL2hNYVNKWGtWSDQ3QmNMWWdt?=
 =?utf-8?B?ZkwvbXFPVUUycGZZZXVHZUVxVFV1aGdOVktvN1JtS3Z6R3dLNEFYTEI3QVlQ?=
 =?utf-8?B?d0pKLytmVVpoTGthYXYzVkViQmFIaUpvWjEvZVBvUEdVNWkzTW1nK3UrYmRI?=
 =?utf-8?B?RnNWbUxQSVR5WUgzSVlRQWxVaXRHZHYyZW0rNXJIZ1I2NDZuRzg4azE0RjNs?=
 =?utf-8?B?clVtc3h3K1NJR0F2RHhKZW5XQVFjNnRUenlxQldtR3J4aFV1S01zRk5weU11?=
 =?utf-8?B?UGZtZit5cW00N1JsMmRvelo0WWt5REd2MzBxZlVGekRRRmpYTDd4WlA4bDF5?=
 =?utf-8?B?Q1d2d0JRQUZXYUc1YkNHTXF3VzlYank0U0RyKzBVWTdhZlZ2cFJDb0l6YkNx?=
 =?utf-8?B?ajRTbkFBaEtldTFMaXljdzhOa1dBamlpV2NQd0I3anBoS2lpcVJYZXAra0hy?=
 =?utf-8?B?em9ubWt3Lzlra09tUUJGUnBWbUQxVW1CK2VTMjNXaUk1MWZlL0c2L3k4WHR1?=
 =?utf-8?B?enZIQkNBU2lNbWMrS0RYZnN1VTR1RUcrWHFqQnAzR2UrS0pLRVVmOVFpNEJt?=
 =?utf-8?B?S1o2TEE5UzlwYzdkV0N4K1YzR0wyRm5EU1lzaE8xOE5iZE4waWk2cHIxbFdv?=
 =?utf-8?B?VUZiTFRJWGMzb0tKbGdkRGRrZSsxTXNFb3FJVEhjWGVLejJnK3J0Y3JFZzgw?=
 =?utf-8?B?eG1Nc0I5SE5zWTFiTWQvSXplWmFRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NUsy241BRBbbL1HwBaeSZnZ65ok1FVQRRX0zpDKmSvawLxaLiKkCNTUY9Px/Go/QKXUyCsBUzrxXY7JY0B+0bBLyB5RSc9a4oEWgvRHn9cJwiKREl2So0Z7aFuiyMcGEZozzd/uygu7MwgeuoUPaflL9bksW57T/hXw5i1gAaUrAtA+Q1kdU9fMIw6GaxuraPWo1yHl3HUpDiprSNl9RtaQs7c/k4QcabHNVieVyS1jxHqbgjdZ+SO4B23HpaoHGxWSV9cE0SPCcATFSrHDHoPgPRtQKiO/odd4gniew1gOGE34rieyjESs485rH3R5uMbAvQ4sLPhT0D8WVe87RaDo2RxJSjCDp5EzEmMziMdF6tfAUOpzVRxGJFN1u5c6HHIrMx2uTWfVivPedkmEkVbBRzP5EXw5pAORnkh0mcm3LC1oZafZt2EzdC92MCT3mykmVxZIUoC7F/1kBQn/tVonztXQkgDi1s4l/YpCAmShKXex/fLFMCzNJ/OBytUpASt0RA+eKhdtt8h5bMAtz8gv/fvwj+YwRTi7JmTcCEklF6sPZ7qABEQHAAndEVNKnqDlVGSe32h4NtmEzaA2arXwWekXtpbqms2zVdNIqjuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef919315-d5f0-49ec-3dd2-08dc48d1de61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:35:39.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHfJj2nDHQx/PS/bOV30qkUjR6YqfTzDByHd10zxnpMy4DX8PSzE6zd+DtYvrSS7SlGWlvA2Jnt6ecYW6co7Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200092
X-Proofpoint-ORIG-GUID: Dq2xQ-ULog6JMNYamZS8HDo105m0aoZL
X-Proofpoint-GUID: Dq2xQ-ULog6JMNYamZS8HDo105m0aoZL

On 3/19/24 23:42, David Sterba wrote:
> The path /tmp.repair would be on the system root that could not be
> writable, the temporary files are available at $tmp .
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks,
Anand

> ---
>   common/rc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 37d26bf21b7c5f..ff2949bd05353d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1301,9 +1301,9 @@ _repair_test_fs()
>   		;;
>   	btrfs)
>   	echo 'yes|$BTRFS_UTIL_PROG check --repair --force "$TEST_DEV"' > \
> -								/tmp.repair 2>&1
> +								$tmp.repair 2>&1
>   	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
> -								/tmp.repair 2>&1
> +								$tmp.repair 2>&1
>   		res=$?
>   		;;
>   	*)

