Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB832155A25
	for <fstests@vger.kernel.org>; Fri, 27 Jun 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035724; cv=fail; b=kBg6ez/C+B0s//coeYaGl/FLbEgVFqChncOJJ1BQ/l4H8+ReF28HT5eCtKUhjWXkgD4YiLEVrygJJgHcwdj4Gg7SabrUFePHeBsSFRz4BJxZZUBlJeXbVHEkWF5UGGelMkQFlUkXlKIvEgkp2yyQzAwFWc78TKGcNwgYra8oiJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035724; c=relaxed/simple;
	bh=m+gLo2ij1FhU9QxTd9a94hwT4Eskq+RtMXLIcFtsov0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8QHsH+9c2oD+8+ju+Ldz47B+SYLBj7G2/rBOpNcNBC/NjXHkRiAaX77qg27CzK7k5Sy/Ka9bRB7ucmC/VFbP6ZTDBHj09DNiENnCN1agK5z+MDWRCVfBfkeoOqrP6ysEKk07v+QMEGrCGy1dLi4uPBaUPPHSqBXhpA5bhEqWzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zwj+o8Eh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HouHbogi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zwj+o8Eh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HouHbogi"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55REMlfa006513;
	Fri, 27 Jun 2025 14:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SrtHgzUoF8Ns10NMwwHTWAD2hV8PVXM8CWk1a6XvyqM=; b=
	Zwj+o8EhmFdGVXB48vNDr8Xstb3BoUmpwRwHgVm1UvZSvGuueYkFnH12bsn97W+e
	1H3XrFOzdrGuNlhXJS5fxJwAMdQGFr840OWTXwsBgZpNPLGJvJSKA3y8vJiqDctM
	zlM0iDWUFMF+D+HviwHH/LwlkDCPl1PpnTOCOiwXriSW/1dTZ8XCfs/t8/seZRsQ
	vLgad7eFNVKBnchssaIJtF6bwVeR7zuJhFAFlYUTtbNn+AtCqfXXc143UOMbTMzS
	cF88QzbQrPxfkAYtpEr9cF1Voo9pWHF2sfe/MQWtSt/DOJ/tCqKDRT6nt+84dGQt
	E/WYT9pHZfIgHXaSz1HXCw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8yc37c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 14:48:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55REkpm5003244;
	Fri, 27 Jun 2025 14:48:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq7xf62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 14:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXNjk39O59iYfnql9fQD8bB9t9EhkN6E0BSmIiMrMZGinn8L91aHKvBtXKZCFA03dCB43fbYGHKjsw9kCzrYTemSlfNwzHokNGSlmcXTDerrxKhhLzglfMjcB50/aJ9Dd6sPje2bNMMQPt5Inkluo4zkF6USFPeQdm+O9CrKdAmeB4PnlHaQ/sfjc1y6DRtLvFo6Gxczu7g4Evswkc3OZY3J1LHO1so+eoM0YxxvwZIytzgq7AFtpRLBxyqb82ZHAOhbd+ggly8MkZYiq2NUGmih+cyFcCGe5miQ/DqLkobgZ37CqQ/BZXm/kmJ002alyk2kjbaJAyf2lUKq80t6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrtHgzUoF8Ns10NMwwHTWAD2hV8PVXM8CWk1a6XvyqM=;
 b=iLVQAuRkAr+GJSC9jxSiS6hbm48GzjlA8SPlf++Y3HcOFOFRJCOq0LQcWXdoYxfw0vpqZK+AMr95T3PwkitAoCv1rNsVu9EBSgzU64Crq7UUhW344uAIjiuB31v3OyGT409fghLzZj8qwIVeDKVhMKTNqKi4GgAe9XoVNcgj5LknNeVKVipIfLj6K9W72Aw+votQ5DBWUDlBImK9RV/84LWhL/dvZYI+ZXe47SO7+TUVCNvEb5NPkskNszeD6UsV/2nTZJbkeIuEc8PTLNKOHzfJu4KpgZWMZHctq8ibF4m7v+CiEfrCprJtxqg1lKEzvN7yM/gzzK+c0pMaFyZxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrtHgzUoF8Ns10NMwwHTWAD2hV8PVXM8CWk1a6XvyqM=;
 b=HouHbogijKf84rtIG9xcZkAhCEyulFX9npWsUKa0vkTM2mMxa+7ccn2Pd10zMz3PO+wRSppIR2ra0WzGUj+MkAYtGb3DaeWQpukISTBOtE/zOLt7S11Hgh5nAfWTCDKNtjmcjvqkJfHPAXPnWzxw2D7Wg8K3S26rSFUbmLkikDA=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MN6PR10MB8045.namprd10.prod.outlook.com (2603:10b6:208:4fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 14:48:29 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 14:48:29 +0000
Message-ID: <d765ac05-98f2-4f30-b80e-2b61346f98b6@oracle.com>
Date: Fri, 27 Jun 2025 15:48:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] generic/1227: Add atomic write test using fio
 verify on file mixed mappings
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <7aa00f0480eef14f269ad28e5e3003e7c32590ee.1750924903.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7aa00f0480eef14f269ad28e5e3003e7c32590ee.1750924903.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::14) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MN6PR10MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1120a207-307a-4557-3079-08ddb589adbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGJJS2IrVGgwK3VKcitVbSswQzFFQjNITGVNRFFyVm9YU0dQbHVmUTk3bVpq?=
 =?utf-8?B?YzBDN0NONFBWd09raFZBVFFmek5NVmdjM280RUQ2MTdZYzdPN0lJL0s0OHk3?=
 =?utf-8?B?UjRXWTNUSTVSMkVMdXkrcTVGN1ZFajIwckczSCtyL2RZZFBDY1NwVDJuVnp6?=
 =?utf-8?B?a2IzNTN4d1I0SkVNMXdkRTF0MTd1aFZsa25BdHZ3LzNyQ0hLZEU1UnY4TmN1?=
 =?utf-8?B?cUpFaHlMWllvdlFFN2ErZnNzc1dCMzF0b3l4MzQxTnB4OEIwb0dDQTg1NzND?=
 =?utf-8?B?RmtKNW9IU2xLODVDWlZVamRVaGhEcVdIZ2lQVkZaSUF4R0JCdnhjU2l6TEs5?=
 =?utf-8?B?S3BDUjdXMTJ5M2wxMnhMTldqL1hKZE4wZXBXbzh1Mjd6S0NXODA2bno5aDFE?=
 =?utf-8?B?WUhHKzZrVHd5MWIvQlhYa0gwak9sMm9sdHVsQ3ZwbGtrZVg2ck1udDFlZ0xQ?=
 =?utf-8?B?SDE3eHo1UFV0UFlHTHBoWFUxbjlsUEMrVnZDZDMwN2ZvNENISkRDTCt4U0hH?=
 =?utf-8?B?L0R5Q3dnV0l1Ty9GaC85emUrMndwRjN0dUNBbzh0ZnpPbnNwUklUbitKdFpC?=
 =?utf-8?B?ZWlQa1BzMVk2bUh2RGVOY1FuMkJSMWR4YjJWZU9ZRy9scStGdWV3N0dPQU9z?=
 =?utf-8?B?SGtyQ0VBQXJoY0wwbmM1Y3VLVFRaYnpxUHdpRnV3QldaYlFreGM5aGdZQmZC?=
 =?utf-8?B?bVhMRHozL2NITjZhT2hQdkFnRjVDRk9oeFNLVVFRNmNDVGVXZzRpakdSSWpl?=
 =?utf-8?B?TElwSk9iNWdmMXVvN2s2Um9iUHEzcjRvekdJcjZkaU1IdlJ2MGorWEM3YkFY?=
 =?utf-8?B?N0U2d2ZYQ0w1RWlocUgzSDRCMkxncHVYVFdrYkdrTE9XZkNXS1BVRHZSS241?=
 =?utf-8?B?RkxPZCtXWDlzcEVURHVTb0VacStVd1k0VDJ2eThhSkhtWExSYVdQaXY3WWxN?=
 =?utf-8?B?cmRtc0xwdUkyMmJuTm12Tk9IZjhlQ1QzalFzZldFZ2hjK0tyNllNTXJyS1hy?=
 =?utf-8?B?bktjbGUzRmp0dlJIcDRVMVJWbkk4QWdvU0dacGc1RlhNU0ZpNENRL0JENHRa?=
 =?utf-8?B?R1phUUkwODBMRjIvVTFtYW9OUVdTSEdXUGlSdG4yRUdCdE40YjhpSnNVcUNh?=
 =?utf-8?B?Wjh5dnpPejlHWHM2ektyR01CZTdSVEE4RDVETDF2RHk2MlVVaWplMEp6cndW?=
 =?utf-8?B?YXo2d3R4bk5NS09lK3BBcFF5YnJqNVVHVUJKcS9LM25yc29lZFhSaHk2Wkdp?=
 =?utf-8?B?S3RvMGU5aldxRXQ0djV5U1Bhdkc2bW5ZWWpEcWlyRnhQREE3anI2ZXhDRmJY?=
 =?utf-8?B?VWJ5alo4K3JmMzFEbkpaRy9OSjJiYkNiYW1kWmphRllMVUVXYU51WFYzaXRh?=
 =?utf-8?B?QllFUlR6QlFFbmltOU14aGM1VHhuSnRPamhSNFFNRDdadzlaNEtzWmdPYy9w?=
 =?utf-8?B?MTFKRGk2K0c2TFphdDVHOXc3V1RWeFJXOEhEY29OcFVmaS9rbml2SHkzMUFh?=
 =?utf-8?B?TTF1Z3d5dXUvWW9YVDludjlBNGJzZjYvVU9JY29NNExqcGZzOUFqdklBQUNX?=
 =?utf-8?B?d3B2OWNMd1NpM3djTkh6Tm9OaXFLd3pCbytneXZzZEp6ZnBpZ1NTRVVxZmxt?=
 =?utf-8?B?d1RRMWVRK2hzdmRwUmY1dms4MngxVVhic2lEOHR3S0xkWUJwQjdvMUF6MFlr?=
 =?utf-8?B?VUIyWUxPREVYSWlab1FtTUN6NWlSVTNDVmp6aDRjQVoxQyswaGFQSUljTGFu?=
 =?utf-8?B?Z0pWcFJxRU8wcG5FUmRMNlJzcVF6MUJzWVpKVkRBWXR4NU9mOCsrRXhyakVE?=
 =?utf-8?B?RlVEczZRN2o2bnJjaWplZ1FxbDlQMFFzamszT1ZjUUhSVENqVW00NlFMMTBn?=
 =?utf-8?B?a0wxNXFXNjJNQ3FSOUFkQzl3bWdnZDRWQmp4MnQxZU9oRHBvNnBBb0llaGFq?=
 =?utf-8?Q?SkPtW/Ox1gA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0g5MTllTGRianJzTXk1Y1V6VVZtT2YzQ1NEWDc5VHg3bXc5ZStZUFo3NzVG?=
 =?utf-8?B?OTA1REN5V3h3ZW9XYWpPK2tuZXRqMjBqSXp6c1NvL0N4czFXWlNlYkVYcitl?=
 =?utf-8?B?Y2lSbHJCd2xCMS9EbWdQMktUeXMxUjRCNVdKSkRPcndHRGNVTWhqTUxtc3I4?=
 =?utf-8?B?LzV2VUJIVEtvNlV6TDJDY25BcUpIMk10UTViaEpiTE9rL0NzM01UVUZTNnk3?=
 =?utf-8?B?UmdRWG5aSy9jaW8yVlFjQWVXanlCVFR1R3I5SCtOMUYzd29iS0tRRGgyUnhM?=
 =?utf-8?B?WjVGOVYzZU9Sek81VEwvTnB1bVFIdnVZa3Vwb1BPVnRqRC8ranludi9ENEU2?=
 =?utf-8?B?bGFUc3EvWkJYR2h5cmpxdHNmdzNKbW8zN2JDTW1hZmJLVndyR2E5aWx6b21j?=
 =?utf-8?B?V2NXMyt1MmRtdzExekxCUTR3L2lRZU1qMEtVSUpTaFZZOFZoRHlrRC9GWlFw?=
 =?utf-8?B?YU5OSVhqU2drTGhGYVdUK3QyNW9IZHZGNm5YdXU3U01ib1Q4bnlwRzVuQjMr?=
 =?utf-8?B?Z1d5WGF2RFRQazZ5UDJZdjhyZ0xYcmRFdWVQVFl0NFEzL0k5YkpadDIrRFR6?=
 =?utf-8?B?TlNtOUN0aGdTeEd2am1wZ2N2L1V1Y1dPMENYSGNwUjQzYm1rM3VaOVdWMUJn?=
 =?utf-8?B?MWdyR1ZtNURvNXhWMktWMjB6U0FpcVByVXhtU1JYdlhmTHRRVmFuSUxCTGJS?=
 =?utf-8?B?R041cisrNnJ1TWVMZ0hHRlJjNUhxb1RVSXBqVXBWU29ydm1NdnNqK1VqenAw?=
 =?utf-8?B?UTU4aEVlTWVCMUZjVXNQOElFMks3SEdkS3d0N1RrQ2NINWhjSldNWFkybGtH?=
 =?utf-8?B?b2lBRXE0TUVlZnozRmJNclJoeG5nbEkwOFVtM05SdXl1c2c2QUtwVHhUMWVK?=
 =?utf-8?B?aUdRQzJucit3azhmbW5FU0RRV2QxY2xhc241T1V6OS9oVHM1b2tkQ1RIT3Vm?=
 =?utf-8?B?TTBoZTdjYm9HMHp3clFEL0JxMk1PRmhVQjFRcHY2RkhnOEJUQmVZNm9wVDJn?=
 =?utf-8?B?R0o0dzY5SE1iZlY1Rlh2d0ZaRWtJZlNxdlcvSHZXaUV4WWhWSGtJL2tvRGZU?=
 =?utf-8?B?dmtXeHR3Z3huNDJrOFN4ZHVXT2RtYU9SWVYwd3loVFRzSGtSd1BUQVU4Mitq?=
 =?utf-8?B?M2o3U3BKaHFTaGlhWUIwN0lMZ3hnNXJQZHBsSzhwMEJkMnhDeHU5clUvMUdB?=
 =?utf-8?B?UmZJUG5lTGdWYUJaMFN2d1BMWDN2UXh5T0FTYVY1aWxlMkswK1JJaWl3dVp3?=
 =?utf-8?B?ampmRGl6NUNYYmdnTDdoUU5ZMzk5VmdLWDZrY0VSc0R0dnJtcFFrU0IzWEV3?=
 =?utf-8?B?SVZiODMxYS9lR3Jia1pPTHcySmxGOFQ2b3AwUVJzdm1rdXZvVFlreXdhb0VW?=
 =?utf-8?B?MGhFTUxmcjBwL1NtZEhEcEJMR3BJQXJOV29iNUdyblhZVVdHZHU2ZFdkK0lr?=
 =?utf-8?B?bHRxUmFiTXBNcmVUVkdqOGwzWWV1WFM3TFB4YmtEZTF2emhrS1luYnZFL01u?=
 =?utf-8?B?NVRLNkYxcDljUEg2RHVVU0tscjI4SlVJQk1ERE1WSU5Ta3EvYWtJTk41aTk2?=
 =?utf-8?B?b3pOdEVjaHBhRmFoRnB6bnRObWdOd1dHTkFXSXMxaWFMMWR5K2c5eGxycytC?=
 =?utf-8?B?R0llemNHaC8yZTY1WVFPQ2g5QXpWVXhrVjY1K3RHTTQxOFdZUEE1cWhWRW9B?=
 =?utf-8?B?ZTZ5Zm1XdnF5ZHIrRlQvR0t4WUdRNEc0ODRvRi9RemdWOGFRRnh0K1pQbGps?=
 =?utf-8?B?RVZudXpvK1FoZHcwZ3o0TTNvMlBVVUpzK012bTQ0MWlrU0hpR0tsOTZEL3Zh?=
 =?utf-8?B?YjdlSlFDeFdJcEEwTVpGNUZucnEvYWRyYUVtbHJSSkI0Ulp3dFlNOFB1cytq?=
 =?utf-8?B?L2JLenlaekZrczcrNVFnQVliZUdmS1ZqYjRmMlg0cmM3SktIaDAwMWtPYVB1?=
 =?utf-8?B?MlI1a0NsbHJvTG9BKzNWRzR5RThDRkhCNmtiQlgwY3hrNHhHK3N4RExzbGYw?=
 =?utf-8?B?WHRLNnhiOCtBeElCWXJsYk1XTkRhZTJHRkk0blgvbk5kNWNkc1cvTGlXVUhO?=
 =?utf-8?B?dEYrNnQyYXZtRUNVNURRU0xOMlJkdXdSREsxMnNDVWwwc0VCZ1daRklRSUgz?=
 =?utf-8?Q?Lsda9kX60WQu2F+stRjryRLKR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lO/GAmvLXI3vKUNM7Ev99avzaLHIpODmrvc/n+TI+4gVIswA8qzeCMsOfytdie8m9Inoc8XAKMNmQpHBRZBMP/NnhzROu7V1a27dOqd48Sr9g62DesD7WYKA5irSFQrR7J0faXDGyz8UY9Y4JABS97aBQRYDxT16yRmnLcxcYAiPfJL2sfANH8z7bl1g8cQT8tlc4/l6BR2AakFaSoUoX+nfRCSG9/ZOwDsKLvhJEaYgwVsbPj7FB1ctq1zJuFJm0gFOaUrbcgkmK23lhD2H56uAhEi4665TMbhncoKyI9vMi9iVK7yBDd8DE1uuDKPvBj/2xzAOZJcgLyCEaJnwG96DiUE3VvJtD8mEKbz0z6QvdeN23ktkV+43aajG9vFDSbqUovqOLwgDWTu++0Au/ze/2fyn1TQZn92HWoiFMVNKOsB1dXc5vwrdQjUqtVo7D6TPtHC/90BzCvUszbMAbuzi1xqf9x3KG6v2mz/0hB6rNa5HtMbi7tgcVueAINQRAI2c3/M72n/1XC8v4X/HPsPTkF/Zb0iHzhW2bfhsveRMYxXpVdNjEGmwNmB1qTsWN6RvMCsA3jZn6YFrON/l8403rshXlYDgEHKJ1rufoF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1120a207-307a-4557-3079-08ddb589adbd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:48:29.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+TIex3Zh2pMaUQGiwtuOg6jiDfiyDHF0Zhpzb7yNC0Q0JkLaSHfl5aIxebDk4LltcMa4nPoTP0Lti86Nfrw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270121
X-Proofpoint-ORIG-GUID: uyYxtT2y4KuIdRFiY2x8gi1JqHbAU3PS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfX6EXs+ttrbdkY Q3c38TzFDzwm7RbMGGgUKOyLSAJ4VFDx4oxUcXVjeQqLEjbAF+a5InKWYBQk57jm3T7SHK+84iS AorOpoYEPNN3BVQFRYCVCZ4+RbjB32wL4QFP+PZ0hW+05Ln6aK68tAYCCS1WriqML2lqgVpg+F0
 KIdRYjdald5YRkCsJo3VLQDq0gMgqCbW4wJwCpGU7jW06/vfsvXwCpzqFfTSOJGAlIY+OuOUrCT EMm0zj93fd2xGVQwshxqRBEHSirNi9Ry2Zpw6hBj8TI2XfDQLBN6E0CusNLy2mFb7YNWB/mDD/D 9AphjNQ0tMdAfKUWhtz2qoSg0mwYh9mFKlz245WpJOK+lZaw1lufJtFmAEIFUT7HUZvXZ4fYV7L
 skF1xxE5nF0tGiebIOTtryVC88svAKuIKZpl2zRRP4DknO0uxI6lGJ/qTpvEJn/k8CNDI2zm
X-Proofpoint-GUID: uyYxtT2y4KuIdRFiY2x8gi1JqHbAU3PS
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=685eaf40 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=-Fdvg-oBZ4mtiJ2j1YoA:9 a=QEXdDO2ut3YA:10

On 26/06/2025 12:58, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> 
> This tests uses fio to first create a file with mixed mappings. Then it
> does atomic writes using aio dio with parallel jobs to the same file
> with mixed mappings. This forces the filesystem allocator to allocate
> extents over mixed mapping regions to stress FS block allocators.
> 
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>

The think that the same comments I had for 1226 apply here, but I also 
get this error on xfs:

[root@jgarry-ol9new xfstests-dev]# diff -u 
/home/opc/xfstests-dev/tests/generic/1227.out 
/home/opc/xfstests-dev/results//generic/1227.out.bad
--- /home/opc/xfstests-dev/tests/generic/1227.out       2025-06-27 
11:26:58.411121674 +0000
+++ /home/opc/xfstests-dev/results//generic/1227.out.bad 
2025-06-27 14:46:24.931649292 +0000
@@ -1,2 +1,3 @@
  QA output created by 1227
+/home/opc/xfstests-dev/tests/generic/1227: line 15: 
_require_scratch_write_atomic_multi_fsblock: command not found
  Silence is golden

