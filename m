Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD73BB47
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928747; cv=fail; b=YuKjNpUBL6qxvPHR4CvdcjsBxGSYQzjm0zAKY7JiDRYhwWJuJaeQERrnMBglJoWdYBiw5RaXYLDPTxNNRU/xRVmK0ZESipoV+MxJ1z3rwzq3BqPmMq4EDWOqGdbnVuCkLk7GdoUUcEEkkXEsHFe54Te3PidtZcAP1JSJY0+1HA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928747; c=relaxed/simple;
	bh=fMI/qJEH7587xXs1EBeO2lDL8+y7XEGWHAnN0ykMp2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nflldr/HpikXyxHDqx+TWoxJQqrcxGGWS3qQgLxoVcEFTEohaHrDNlE/EXwErwm4IuGY5+lfkcR1a8rY9a9yA6L8xuQoYSnzkE3CWMzwmu/DW2raRTgfCb9MX3ztzAqJEnLZsvP4AZVBc2iWlbKiAapvY4H4nQn4qFhV5pRRkq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/RuNUjr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jU0x5kaG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/RuNUjr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jU0x5kaG"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K7xKvV009296;
	Wed, 20 Mar 2024 09:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=G1/259h2IYz5oVwzqVgeJxNU7ibmoC3V8AMXhi29NVc=;
 b=P/RuNUjroQUWVyANAOm5q4Fx6lQkUGw4UM2j4bcbg3m9ZE7VDX7lYp7RD+QzLbFkFf8w
 64fYKtAf0IANJMlIKwsNODm2F+tkbfy6/u2qPzQHR7sCYotGZXgYam971P6s83dq7Lgr
 /qlM29zUMCeWID5mrvfIoQqVHPJrBQ1eiw2anPjEL+MphG5ZvCjehTSz41FkGJU1+x8Y
 T6xuJLX6C97oTKCB1V1SWXzD0VS6BN3tXg8Ru9E6Qau2JNfTID98nbuBs2EvmZ0ygO/9
 RsYSTS8Rcs2rrA8knmaTI3rRs5p1YCU8Ik7FztJ0QFridrYTx22Dkeaz02Z4o4jF60dd pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aafme3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 09:59:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42K8st46007536;
	Wed, 20 Mar 2024 09:59:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v7hd3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 09:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZmWZDQcgazUSBoWG2anJd8fP7PbI0KZqX44/y06NvxblY1lycbLSAcDNKuHmT9z4k78DotDu+vrh409ANTBCSXN5UB1qGncHl3naiRO90kFHFiLAFPVvW/GZbvi4zLlEruJpxVs+C2yXi2zPjQ118oXxGsqqMNk+iiwXh6sPl8ZvwmEDdGnB2im7BW+DYHvyj+e/HpQiYuXPTCyO8m5gMbu/ZmmgFY64R/HmGSDcg5XB75hZg5qGRvPdGGHTmbLM7Qi9mLkM6dqW5fZsRqQypg9iXv3Jfst1MSQIgOuaikp46sloqh2LqotxqFyKMUssB1xAL96/jyaMSXUcOl1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1/259h2IYz5oVwzqVgeJxNU7ibmoC3V8AMXhi29NVc=;
 b=gJaoIO5YfQJITdHBDTIOX52s91QikopmxcvBYrxwive/sOB9mU1T8QkcR7x1nAsUNMp89TWGNXykHYlUs5rVyrnA4jxdoDu2Rso5qKm6Y9dnRPLx21rXSgA4UcnMWITM1GKVeHUpeqLZGafB8I7zUf/sI64UFBAU7wHgVjRNN0wghasdNP/iPeN4gNLBJIyDXFCtzaMNchv0XZ+gwtRCyphVEmdjh/4/few1fy80z+8RJie6VdRpD/Fh+RVosBAOrT9lLpHu5UceCInuKaLlM37E1bMiTY7yrVo4wXruw+ZSuj3WCq4VFlQyUKQLM8DJ4EMjr7lZlL7LkTfFrVpKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1/259h2IYz5oVwzqVgeJxNU7ibmoC3V8AMXhi29NVc=;
 b=jU0x5kaG++mbMftpW3NW6TNelbnyf4dnNIX8iFIGdgbhx1tCVXXI3Wwz/Lh5KCEmflE9f/gR0+9FjbPWQ3sxdIfnpXTEY4abGvDs8iENRgJtPCPljxuMdrpjGYbljXP/YuYmNQh0GHaDsWOyEZVH61K6nP+i6ZT1SsB/kmgk/Gk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 09:59:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:59:00 +0000
Message-ID: <d8e9d153-aff6-4f47-888b-b2ab91f7eb5b@oracle.com>
Date: Wed, 20 Mar 2024 15:28:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] common/verity: use the correct options for
 btrfs-corrupt-block
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <cover.1710871719.git.dsterba@suse.com>
 <0b2ef42d6fb3e3b6ebe91c84b9a5e698af13d80b.1710871719.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0b2ef42d6fb3e3b6ebe91c84b9a5e698af13d80b.1710871719.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c64735-2956-4b96-15e0-08dc48c45d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6Zec+zDNVL/41lsH5cOEIw9WXrBI6WqvsvwYNIZWYiAOryQKv4NRRAI1dkx4Erjgeo4MAMvq+hOYsVG2XqV6tcLbiLLbbHuBq8qkxhmw8DiyqN4E+Q4myGImOdt4kJj3YeqWZqIUDgSZql5vFJr+EW/EDOqFFW79eIw7yj6UVRmd0F28bVarVZhxlYFL/jLUO+YJ7SZO6BhJDTVymmbeKNPBtYSbaTwCdyfRLrlMT8Zo06tTQq9LXRDR/YbstZ5xsmPhlaVq8L/avjxhutwsnC47WM5qVUGv8VrMEdeosGLQPin/vi9OcKp1IO0eQlPFlYBN89Y0j7YpJqgWZKKN6N7aMjiRDN5gmnAkNUvQOZI2e/KqZzyhKXSt9GrAez4dtaVuBC5CAsVODkP9ShWGJDbEDYB3lT0eVuGTEKNElJIXVD9kKc0ZyMfHdy7yZh3QUSoCk0wMFswXl4W60pXss5hDvVthUeJEbFzaHtQIPDO54c42Un+8UTSDdkYmBukal+9xLLXgIpr2LIcQXumEimb3UFRw4Hy1g/XeGm8mvxFyLQGrJ7HVQutlAic1Y570EUX5fELfrPpPvHLwoj7zDschkKGQcBB8M6zMYfUSZrrmL2wJtaOh20D6v74ZylhoaIOB0meVDDV9jftEqCOJwLuTm9DvVZ1V4xxiX8s5xmY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTZJTjZjY2hvcnNXa2Q2akZJaHFYd29nQ09KOEthb3YvZVZyNlA2SU9UYUpI?=
 =?utf-8?B?NTFobHJTY1ZaS3FCQk1BdWJSSG9pSEZheHN0dFBENlMyRW9ySXpqMC90UWUx?=
 =?utf-8?B?MHBxbEZaMFdEVG5xNUNtenRxMmhvdjZXemJVVTZuNExZc0phbldqa3FCSm1k?=
 =?utf-8?B?N2NwZ1pQUU16V2U3VGwzU3ZFN29xb0ZzWUxnS3N2K1E2WHU0a2xoWGY5V0JO?=
 =?utf-8?B?ektNMVYzWDU2UFBsS2lNYjVZelRPaWxJTDhOZ2VoV2pSOWRVcFpIRWZiY1lQ?=
 =?utf-8?B?NTB4WldxalBIY0E5UGtnZDRxUDBROXBsaHBRSHdpSC9VRlRrMnMwVXdUUDRW?=
 =?utf-8?B?RWkwNmJpRzZIbjVCTi9tNExtSFp4VEdNL3A3ZkNuWDRUV0Jsc3N6aERUUVV2?=
 =?utf-8?B?NGJFTmk2Y2NMVStCdTVYZXVKd1lNd3dkREVvU01CeHpPUGtlUy9zZFpNeFFa?=
 =?utf-8?B?Q3FGWDdQNm5RWkhtSXFzTi9wWUZCZEkvb09UY1ZSL1dJWVd6R2YxWlJieXho?=
 =?utf-8?B?Q1RzbU16WVZWQ2Y5cC9iWGFCemkwaWxrY3kxWjE3MlR0WGZ4SnNsRVVCWElU?=
 =?utf-8?B?VWpDY05DS0k4R280dkV4TU11RjRUaVI4MVJGcU4rWnFOQi9saExrdUtSY0NZ?=
 =?utf-8?B?Mlp2ckJiblZOZ2IvMUU5eFRrQU5iUFhBSzl0T2NCYUcwQjhDUU1kMDgvcUhu?=
 =?utf-8?B?WWpuOVB5K0VtVHo5RXRzVjVPOWROUlVXQ1hmaFNxMDBrN3JwMmc5b2JzKzZE?=
 =?utf-8?B?MDlmdWhkdWtWc0RsVkdrd2JKTmVocHJ1RVd2M1I0N2hVVk9CSWRaMmVKZmVR?=
 =?utf-8?B?czdLcDdvc01KZFRVRjRRMU1ZZmpjY0hIeS9pek1Cd1llSVVURnhmak0vR1hw?=
 =?utf-8?B?NXhBNlVvZkdQemtPREdtNDgySUhvL3FGdTlZeDh3VytYM0pVY0x3RzhjdU1k?=
 =?utf-8?B?bDBoTmVXKzFwMER2TDR1UHVRT3E3NTZJTjIyRFV4TjFPZjE2MnZiMTZVSUJL?=
 =?utf-8?B?aU9OVDdtRHNwc05iN3lDYWRrMVBGNS9IV0xWV3BpNTNiSm04MEFoUERWbE5i?=
 =?utf-8?B?NFlHS1BVQXgzWXU2Y1Y4MUZtTVdYQlNjbUdaL29rTjYzMkc2WVVpOGEvYzdi?=
 =?utf-8?B?WUFWVFQ4cnBzYUYvOWZqWTVtb08zeVd1QmhOM1BXY01wVmx5OUUxTkJJWUIz?=
 =?utf-8?B?VnJscm0zTUppc2M1ZWJzcVVqc0czM2cwTmNXdWxnTWxENTRBKzFQKzZWZlJp?=
 =?utf-8?B?VUdsdG5DOEJhSDNFRzB2UUdibVdDQWlnNVJqc2xyaGFiaExIcEN2bHYrb1BJ?=
 =?utf-8?B?OWdzSHhHeVZTZWVBdjlRYmg3NWNVU2NwNSsxV1F0ckhEenJWSDc1SFcrWVpP?=
 =?utf-8?B?aW1ycU5CY2NOMHExWHAwWmxpSisrSVFQYXVQVFZaM3JSSzdhWDd5cldBZWlv?=
 =?utf-8?B?UGFXZUpzUGJXL29PeFhrMVBQamcyVkxodHh3cS9kMXl0c1hDMG9oc0RpNVV2?=
 =?utf-8?B?eC9QaEUxVkZKSkd5T0duSzl2Rk1VQ3JmT0VMbno3NEFwdXB5d3lxSkYwaS90?=
 =?utf-8?B?S20rT214ZHViTUxoRi80VWszYUZCK3AwV05iZGhQZ0U4VStMbGJzNTkrQjYz?=
 =?utf-8?B?QzNlVWpZRXVrZTNBOWxEanhNU1lCQ09waGdEdmtSMlU1ajcweXpYVzI4SEdW?=
 =?utf-8?B?VU5tQlgvWjVRMGZ3cmNmcCtaR2Y3SklTWDBXZVo2NU9zemNvS0h5eUwraUty?=
 =?utf-8?B?cWhhUmtEd1NSSk15ZEs4cXdQRkFtN1JRSTBQQzJmOE1sd080SXJBQmRVOFQy?=
 =?utf-8?B?cS8zNWlFQUxiWURhYU83VnRRKysrUHdLcDF5WC8vYVUvRkpqT3JmTmV3UXFO?=
 =?utf-8?B?TmhMVjJQYitJMzNZMVZoNjJYZ0ZoVEdmZFkxQXR3bkFpY0RWVm1nOFpkV21G?=
 =?utf-8?B?VnR4b2lucVJrUlMyL1RObjNDSVlnTzdNQzVFTDlHdU1SNXpQa1g0cGd2bEIw?=
 =?utf-8?B?ZTJrWndjNG5VUWJSMEdFN2pJRTRHZStJUXM4SDl4dXhxa1lTdE1UWmd2czRI?=
 =?utf-8?B?L1M3bXpZL3NyWk5VMkE0bkhNNWRFUjZmV251bGZ4Y1FDQkJLWm5Edko4aHFK?=
 =?utf-8?B?aXhzSlduQWlWeHFLTUE1TWZrL29hSmIzckNkaUdTYmZkMUtqVzNDVFpkTDFY?=
 =?utf-8?Q?L9BT4zP3qORjURz7ehTsLNRSt3iEG1Cf4+VTdbAZZQ+l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BDMDIbS0EdZQKTuPk6QPpyQjLI9G5w76ruwUdsAGzG+f/OfXCyOMh0WsIvhWhxJErtgS23PxTUhm5Np1aNHb5HmKHGEdE6VR3gt0Q8mMVvPbZI7g/3cQoTtkH0zWMp4GT9BZtMZrUH/p1NSI5RY0Myzfo9BIaQJBZiocSU2SRnYE5V5C9l4eZFlYesJ09qREUz2xKhEn0/mr2fKIOQmvBYfeTVGv0uDsUgTkHJ8lpAhQIlz0/DhHEHlPFKcdYlOFSujv9uU3WOO6a0F5JxR5CKZv9p/4Qbz6sfNkZU4r6pclSpdsaBp1TYfz3V2WjMC9vm/suf8t0H7sSNDTzUfH6Zf5qDR9qJW9YCG3IQ0aB7XsUYncrkGCMC9kzM/6yQSMtRT2dFtz61l3wO72wLGJDoDBMLoXbi02Qg/RroMQYHvHGjewSBdm2D9IXlxLm4uwDIW1kzhbbrAqyxw5b//1ohTOm4XG407EbXojghRozXimwdFFvd/T3UoEXqxTGRkaWnzXvPV5OzMWwqa7euQHtTVRxVOo/+h29ew1L2tF2yvZGh4jtx5W9WSXMmzh5sZNpA586WOGqTnN7vXR+uVVZb3gg2PS8W6qC+VGRsqF3+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c64735-2956-4b96-15e0-08dc48c45d5f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:59:00.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuPKD6REWxCRPXiQA3/hQPj++vG/bFgCkuYWP8IDlO/GEvfUrnfq2lQRf1G59VzQL21Tk0VDrXfAZliU+hvEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200079
X-Proofpoint-ORIG-GUID: ROP_ahqXJ6FPDvdkZ-wfv7JMq09Ellk-
X-Proofpoint-GUID: ROP_ahqXJ6FPDvdkZ-wfv7JMq09Ellk-

On 3/19/24 23:42, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A long time ago we changed the short options to long options in
> btrfs-corrupt-block, so adjust the helper to use the correct options so
> the verity tests pass properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   common/verity | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/verity b/common/verity
> index 03d175ce1b7a18..0e5f0d75e746a8 100644
> --- a/common/verity
> +++ b/common/verity
> @@ -402,7 +402,7 @@ _fsv_scratch_corrupt_merkle_tree()
>   			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
>   			# $offset (-o $offset) with the ascii representation of the byte we read
>   			# (-v $ascii)

> -			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
> +			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 --value $ascii --offset $offset -b 1 $SCRATCH_DEV


Can we still make it work with the older btrfs-corrupt-block?

How about..

corrupt_block_value_opt()
{
	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q -e "--value"
	if [ $? == 0 ]; then
		echo "--value"
	else
		echo "-v"
	fi
}

And to use,

$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 $(corrupt_block_value_opt) 
$ascii --offset $offset -b 1 $SCRATCH_DEV


I will make this change before submitting the PR if no objection.

Thanks, Anand

>   			(( offset += 1 ))
>   		done
>   		_scratch_mount

