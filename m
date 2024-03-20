Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E963BB36
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928885; cv=fail; b=YB6UD36+RAQ/Pf5EDk55G8Gjg3GSidqcSWBJGx3ggarTmJQDwm5HfEiZYuDUcSVbVoZLETUkyN6JAhpoYMPo4QFxgKD3U4f4Qz3vfwyUkFWcoDqYtMnjmgAdzDt1wccPJoR0yNbI8gXXxmgY9XiOn/qtXPv0B7j7QYfHBpRhg7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928885; c=relaxed/simple;
	bh=PyDk+vyURcakERoioAD+HorEYM49DgV6mUzoVrBiVO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yr/kL1zK2P1NKcvwstOAkNPzKkZZXFvaMQ0L5TdjlsByH9VpBFut/NU4rk3naeVFS7TAFQzduQcPYOI0NfiSGXgZGD+DJjnunQBOFQsVEE2vtTzSIPIgAdRj3Zcfwl1B91ob/zZt8zZtr2x0c7TvYBOT3m678eeDmQH3ew3cxSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCqAknyo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOoWUZ7S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCqAknyo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOoWUZ7S"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K7xACK015558;
	Wed, 20 Mar 2024 10:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1DBCeiAEXxnPErNe5IrtIpGYFSSFQFi6CTaJW8TzMIw=;
 b=BCqAknyoozH+665z/ZHjPrHUs0B5v6jhNWsDxv3ssQxladj5UneXqQAZXS1lB1Uzj2/U
 CXXZjbpkGhI03pKs2w7QrJAlw84isM1pM1a9mLHsmnuiPOb/hFo0DHzGpzDpgJK9Z3FE
 S3PVtrSnRG2cXnvBInL3fyyJnI6/a9HaxXXpiFxp+exLMILzySQnn5KnJdethJRCUjbF
 ZI1mN0iIhqHtnrjfl6JyS7rNnNCTFHYu+JuafjZ2KbZgIjCWfiME8/my8mjZvjlxfsWy
 ud7zkfMK2stSZeQERS4gKs2hxLw4pCoGgM5/dKB1ELlsiBTUvACXV3KYEuYJ5850MXZ/ hQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tqqwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 10:01:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42K9fHSO015776;
	Wed, 20 Mar 2024 10:01:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v832vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 10:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNySoaRgdsoq7Q1lD9NFIsXoTI+2GOEb3wqv9B+rSQRykHNCEM+E69nJyHzuZdCDTuZfupEcMM7PN25VJD057OfAnEMZj1wKBuqBTXSoD0nU/OU08MuHi4FpZrMzcUoZVey67BkdMjs1emQ+qLI6XLsSkZ6vMItBnJ09FLOQrRnyH/H7LennbbBhKjq8wzgXNZbO+od00TZM2lXlNqWw/AG5Z3IvRNz/wKspOA+vwCluimHf9C6c76+PtRbI7Q9r/o4nBXgK3e2Ae+k2HaFsA4VlIPMMWwv/cPqztA23zlrGIunz/jPjsuqixNVgcv+HlwLCH2VDbxNyQ0YbbQyWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DBCeiAEXxnPErNe5IrtIpGYFSSFQFi6CTaJW8TzMIw=;
 b=AHjHi6UPB2ITAnw55xCap4m2INj3FUqbPrbHRBH+8ZiiixBdLYNyQdnLUi/RHhxO4ONf6sDX/9pS/UQ8oX4ZHCSfNeW2fAmmiEIyo3vh+6HBExmYe1lNq1AgQDOy3ODZ30v56yoKqLBhc+23pKSZ9b3NUrzMO0O7OxURi95JpcJ4kTJyKxH5Eua/BQxy0RB/BXska4bCyx0I7VTLDKfEov15TqKNTzJPaHgLw8P4BNtI7+UU09Mst3fzH27ddbymXEc2Q9z9lc1Pjg/eunvO/vFg/uFfdIsY77AORYsh9KD3HCmLcsdHPS8Z/zN8sROU+hlQhKr9KrVn2TrxfVkcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DBCeiAEXxnPErNe5IrtIpGYFSSFQFi6CTaJW8TzMIw=;
 b=bOoWUZ7SmeG2Sm/eZt7VVx5X6VPKpUQmbwahiVY3eDctFaHHRbaSySoB1kxpHd/TTwfWmZf8dAwhxUAbZQajPX/cMICUf3HNlm6dZ9ou4rsDFbBvomNtcEyXoXVyNmaVklaQsLbTHaPPKJpntn1250lg5CSV8dkh5KYjnXDjRNE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 10:01:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 10:01:15 +0000
Message-ID: <e23008ba-830a-4f71-b216-8613af5269e6@oracle.com>
Date: Wed, 20 Mar 2024 15:31:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs/131,btrfs/172,btrfs/206: add check for
 block-group-tree feature in btrfs
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <cover.1710871719.git.dsterba@suse.com>
 <7e5a4dbefa3edb834560891feec6ecf3382bb9e0.1710871719.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7e5a4dbefa3edb834560891feec6ecf3382bb9e0.1710871719.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d68c97c-3c64-4c16-5b4f-08dc48c4ade7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	75NLiZ6BsUtqlIi6AQrF81mMHRSjgzkIVMi/V9trfZjNn6eutg+4kvtKVzCQLyWypDj2xjlQs1gq91xEnOu//uQcg+slqt5OG/GJ9Z9CCgr8fPme1fbjR6zZwJivSVorbwUXOOD0DjfS5hHOxL3FfmP2onNLENjen/TrQbUIHdh5H2ELMFtkk/yxA03qetMwlRsMg/xwG/1/7oErY6nQaJlGkYiLbCcNn1G/PZ7QkPCT8rY5euw6IlgWkPxq4KyV4gH8wgJNcFaWREg/XRkwRnyhSzNZkhGtuiEXYqvvXpfk2FhdocHl0QSlHLaPMdqjrbQaMkdL5fQXRXuSPjs/G51bX5h98gPRF9HDX7jC9Ma0G5pFXItEjlFxaKs/A+exhtPgz8Cl56fJeFVsXdZBLmDVAMkxEQ7cBMo9kSU7J/FlfNfru5kpZq2d1h4DogClYoe6TVOtFJguqLiQj+w42Hf+XyK/Vs5RkyTdpphKFn+je3l0Ox1WpaXYvB9UB2FOpJL8XqyfF7vJJFplGI99hkHxDwHPSmd0IM9ufwqpjMvs85GqJf14I8Smhsf3I3kaGG8Ofuy90npAM9RcZILM+p8ek1EVFWuOP7fxqETi+vJ56s2T4a9xnqHWHWjdn8zc0AX70OD09eyyNUu/YFdCHQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akRKeTN1Unc0b1BQME5QQnJQN0d6L1NxeWFHdkVmbDJtL2RvNjREY3RyQ202?=
 =?utf-8?B?UFJ5emtIbFNoaENySndHSDVaeWNtM1dXRjc0QXA3aWhBcUlIOUNGWkwxSmdF?=
 =?utf-8?B?d2ZEQU44c0xGRWI4Sm9tK0dsY3dIVHJ1bnFsYmZlVlY0aDJsRDQyb3NEelJ4?=
 =?utf-8?B?cmpHOHU1bXpOSnZsNGozZVlEM3Y1RERjWmxBQzlsMkRoZjhpVVJxcDhIRjVQ?=
 =?utf-8?B?Ukg0bUU0TUNqdnRKaStTMTBZZnp4NnpwcmNJNVdaRm94aS9KWDZyVmlNandl?=
 =?utf-8?B?NzRZWk5oYzZmMlJHY2FPeWprU1d6bWlCZlZxVjk5QUF6SHFySGt5MW50WVBP?=
 =?utf-8?B?ekkwb0RvT0NXMW53bHo4NVg1Uk9YUmw5U0xmUTFtb2RpVmdWZ3lVZWxpT1ll?=
 =?utf-8?B?aDBLcDdWMmRqN0p0bm5ITm5LdzRZb095QmlSV1hKU0R1em95WFdtQUhlQ3Nz?=
 =?utf-8?B?UGZTTEZBL3FhWUs3SmhQMHBOcDhiU3ZUeFdjZnI0L1RxMTRXVzBXMU9vN01B?=
 =?utf-8?B?MmhUcmdkdCszZVZvSXRhT0RrWURoSmdYT1dpakhUR0phTUJrY1liUUJ4MWdl?=
 =?utf-8?B?SFpkU28yc01uSTBxSzFuRUl6K2g0dndsNC9XeXJ0VndpRWxsd3lROC9tVWM5?=
 =?utf-8?B?WTdQblZOQldET1VLSUNvZ0YyK0c3NG84Y2lyU1ZpaUxUdGhwdjZFdHJTYnZG?=
 =?utf-8?B?VlgyUlNkY0txZkU1bnNrdk0wWnRXbWVGeTNBcXo1UHVUcEpoWG1tZGJoQVJB?=
 =?utf-8?B?Y243MzU5cGNxby8vN3lkUDIwUnA1OFlUV1EwNUxVSlEvaCsxWjlTT0tGTTIv?=
 =?utf-8?B?Ym8wNkFhYnM5a3Evd1F3KzVJM0VNODJQTEwycHdtOUxTSHVyaUZrSUhNSTZ2?=
 =?utf-8?B?aVBxMEl1TmJKMHRIa3IycHFhN2d0blZZUmt2RElvb2EzTEZBQkF2NVByN1o0?=
 =?utf-8?B?cjhEbTVVYkpUd3F0Zk1kbjZYUmF2OUhPMzdndjZDeU1ubHJnaWtQTjkxd1BB?=
 =?utf-8?B?Y3FMcXV5Y2FWSjkzd3JQcTI3V2o4YWMyT0lLTS9CakE3RkdWQURBTFdHT1ND?=
 =?utf-8?B?ZHF1RGxpQkRudFRyaGpzd0JwOTl4M2pkNlZkME9lVEpwS25ra3J5dWx4eXBH?=
 =?utf-8?B?Nmkvem5QQmJMQmRtcE5ZQkR4MTBBZnpCb0U3SWJqS3hsMitYU3J2M3k0aEE1?=
 =?utf-8?B?eURTM2ljbkZhK0E2Zk9pSWozU252VFVaRE9WTDNqbGR2SS9ETWxqVVZmT0lM?=
 =?utf-8?B?VzFwKzIrR1FjWjhSZCtsck5jb0ROeHJEYmdZYk9UcUppVkRLc0QwZ2xTaDRC?=
 =?utf-8?B?U3VCVmU1a0RGd1ovdlFBTEp0MmsyNFpEQm1sUk0weHo1NEl1Wm45T2dhSDlO?=
 =?utf-8?B?SWt3UU10RmdqWEJ6VVZQYVVOVmRlR3cxTUlLTVlDZkN3VTNZZ2tkaWZydVg4?=
 =?utf-8?B?VmROMEIxWms0TVFxV1FvcnhZejBHdzh4TnU1K1RHenppb3RwVHQyWjRLN1Q2?=
 =?utf-8?B?dzFmZ0xaS3RkamV1eFdraXJUK1hwOE1DWGtwUVdMNVhLTjQ2MldvWmRoU3hI?=
 =?utf-8?B?L0k0VFl0ZFJiRENiS0VrSENBR3V0bXJtU2hYRm00ZnNFWWhYYlBBcWc1QUNU?=
 =?utf-8?B?eE5PWmJrdGYwSk14NVZuOXI1aEpzS1dPNlkvcU9ndysrSzNXVjYrOVVVM2dU?=
 =?utf-8?B?RkFBT2xtdVVZV3NaZW4rdEE1V1hMODRTUkxuMVVTUjcxUTRLaWxOMUU2Vk1o?=
 =?utf-8?B?NzlRaFNrRDVCK09CUEZVNyt6dFRGY1M1S25jK29SeU5sdWUyczlNMkdHZ1Az?=
 =?utf-8?B?OUtVaTlvaVZTa3NVUVlhdXB3dFJjMmtIb25ENXZ3cWVVUC9pOWFLRDR6TmVt?=
 =?utf-8?B?dG5tYWM1M2lNa0lKYWZjcDJBZlY4T09RRHhSeGdUb0tiNVVIdUVNVzhCQ3Zk?=
 =?utf-8?B?Tk1hT0M2b0lKUmtwU01PQzlYc1M3SnZFZSt5SVJ0UjZYNlRmeC9uZHphZFo0?=
 =?utf-8?B?dEd6SUJxR2s1M2c4cmtVYWQ2Mk1LUEVFVzM3NU0wNDRHMkpNejhoaUR6MHNR?=
 =?utf-8?B?RHRmL3RGM2RoNXpma3FhWmt0NHhXQmZoY0k2UEFYQllERFhCT2dwV0drRlhr?=
 =?utf-8?B?TWY3VjFTN3ZJdUltT2ZUdTFNUjgrUTBKTEVncEdGNnBzYnFpV2dxTUlJY2hQ?=
 =?utf-8?Q?08aCJntQpRM00ANTw3MM+aOciSL8ottRaMaWjj7CjhU6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AvA67rKIaj5HnA1AWAR7z8MhQK9ahB8xZWePucbcGFj6nvMaI/dm+0M5Q5sOq5+s64yqzFTMujrEFYDkXKyMqY0voOiNS0zgpurSdhMS5oVSNui60M0U8bC+DnzzVCAVEkzqDvH5nJxDgkE4n7yg5ps0qZT3FChRR1SMlPHp5+c+Ic4+0/tTmUsvjv+pJhLdc19maruyQrnoZEZCe8hoLjF7r57B62/7/EmcrU5LZrAHtHPDT2HEjucB3CLZg95XMcfQqbvSWMTlX3AtWyEhR+wLNoZgYZ94/y8NmRvdvmsamvzhzm0aYZ34w5J1QLB6v6KlGdgtyDWjF7EVAqVARwT8Rducdh2PeXzHR50g4LDzT41X022c9tf7BUzeXp3wOvPVUSfCOlWRE4U6BMvN0rh8cQ6RU8Cer7q/aK/7/yB7joDVdqqctgnuqPKqutpctV1XR7BtlM5BgWWaa+euTjw5IqoDOwCXachDBRu8eASFzigAjdirGPOGt3WX+RrYAFwmmi104GAmbDfNNrEKTXQ2GhVK5uBVnbnGyMqNNFy4/mPSUUhnsemicwNCIGRCGauJd0UAzRAN3fgWmMPzdV0RYrJMjQcVMCdEP1Kzxew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d68c97c-3c64-4c16-5b4f-08dc48c4ade7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:01:15.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNjcJuTYSWnW0JSv5F7jhrNFAkFw8oHSKH2rTgxFdUACHC+StQQv3GCAzMBswebcQ6h2Ph+iQrrAiriE7bSIUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200079
X-Proofpoint-ORIG-GUID: A22X0Lv2l95IjGy45utJVEkl7Js6NApJ
X-Proofpoint-GUID: A22X0Lv2l95IjGy45utJVEkl7Js6NApJ

On 3/19/24 23:42, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A new disk format option will make the no-holes option a requirement, so
> add a helper to make sure that we aren't creating a fs with
> BLOCK_GROUP_TREE by default, and skip the tests that require turning off
> no-holes.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


> ---
>   common/btrfs    | 10 ++++++++++
>   tests/btrfs/131 |  2 ++
>   tests/btrfs/172 |  3 +++
>   tests/btrfs/206 |  3 +++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index aa344706cd5f81..c1c3c4683a6fe6 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -148,6 +148,16 @@ _require_btrfs_free_space_tree()
>   	fi
>   }
>   
> +_require_btrfs_no_block_group_tree()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	if $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
> +		grep -q "BLOCK_GROUP_TREE"
> +	then
> +		_notrun "This test requires no block-group-tree"
> +	fi
> +}
> +
>   _check_btrfs_filesystem()
>   {
>   	device=$1
> diff --git a/tests/btrfs/131 b/tests/btrfs/131
> index 529ee3e80f87eb..d34fc8d53801b3 100755
> --- a/tests/btrfs/131
> +++ b/tests/btrfs/131
> @@ -20,6 +20,8 @@ _require_btrfs_command inspect-internal dump-super
>   _require_btrfs_fs_feature free_space_tree
>   # Zoned btrfs does not support space_cache(v1)
>   _require_non_zoned_device "${SCRATCH_DEV}"
> +# Block group tree does not support space_cache(v1)
> +_require_btrfs_no_block_group_tree
>   
>   _scratch_mkfs >/dev/null 2>&1
>   [ "$(_get_page_size)" -gt "$(_scratch_btrfs_sectorsize)" ] && \
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f2997c047effb0..964251b449de20 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -32,6 +32,9 @@ _require_scratch
>   _require_log_writes
>   _require_xfs_io_command "sync_range"
>   
> +# block-group-tree requires no-holes
> +_require_btrfs_no_block_group_tree
> +
>   _log_writes_init $SCRATCH_DEV
>   _log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
>   
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index 6ac3d27bbde375..02a5082046f4a5 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -33,6 +33,9 @@ _require_log_writes
>   _require_xfs_io_command "falloc" "-k"
>   _require_xfs_io_command "fpunch"
>   
> +# block-group-tree requires no-holes
> +_require_btrfs_no_block_group_tree
> +
>   _log_writes_init $SCRATCH_DEV
>   _log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
>   

