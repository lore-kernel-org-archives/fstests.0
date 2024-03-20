Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94003B7AC
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928166; cv=fail; b=BgShuE4sonOLYMFv2ta8jtbQMU86hpY2ZrpYMzVWPdFviT6dP1sb4N8AUTBtzhxLZ3nmZoqAdDp6FgZABYV7ZdJHK+rTqMBtBsRnO9Q+xp2tvWaOTqIiQJXm5mBhS6CBtwrtTUkHTDss9wz0VnIX4aHGzQ9ePOzuFGaZpCdgcI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928166; c=relaxed/simple;
	bh=MozYHAbzWOC0x84H0+oK3F4nN+rjZ7cuKzy1zlu/DFE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WC9Qj3lHYy/R8/4X6k45U+8/VglmdWGMqNRfmnX6/7gYLwaIgw21uyEkef1JrXwICLhztpW7pJpYTtyMoIUnBWhxj2rVlUPI751ydCQwMryPVHewxdBex1DE1SosHtM2LUvQ/bKbnJrgM33Vde3aBCeDvS2+RluH1yLhaxKQuYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jsuevBKw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q2cbprca; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jsuevBKw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2cbprca"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K7wxHa017392;
	Wed, 20 Mar 2024 09:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=btT2a0pyeuYWNtVR0E3jRopMoWIsK7dcD1S6tCDDZAQ=;
 b=jsuevBKwueTXAe8H/vvF8KMtR/c7I0G+k1mdiwLUrWrCTiKoUjirUca1C8dfTrHbgCZc
 hFENIKHyBgObov6eBFvp702sAmQ6bi7SEMRGBG7geaHo5Vxv32aCyl40kRoHT2U8LE0p
 czYxV1Cmh7S0DLUeQzUf6d+nyDIWC24suNT6vX9qa4WsmfqqvK7okSZXEQJBa0SSmdFp
 gC/zSVQunidGosLHEx/hN/L5yboVW73WG4/WHpjpilwjjxE/z/1HF3eY0oHVFnqIYdSY
 6jZbhNvs/NfYbE+8ls3eNJ1Cb3eutq88lYPZizQGRdeDBAG+kL75Lv9DEuOYtewxRCYA EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272ys0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 09:49:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42K9No8d003703;
	Wed, 20 Mar 2024 09:49:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v7h5yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 09:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drb5+rmgPjQo4jJPX5af4a4tGNb80fQ52H3/XP/OCuxUe92K8nJvYF+iidiAJmWlnGR1qEPu+/ZSKwwsPsfKpkSM4lWKJwjraOIjWwawcXULpEIeRf5jcjzPQPt7SqOBIfVZZT9NWfCQduCEu9Nt4xbmvxJBLzEtDvO/sCVg1PqWDY5whlXvpcbdgarBbV333jyCIxi8Lhh1W8VEm2dDpz/A8mtVdF3oK8/rCbSD1u9iFizAvIZPoVIa0XDM6pVYu/8zlVUYPx7lOo0QWBoOPtxUM1uQKLpd8QJtam5cC/atLVzzZBxcUqEqV/9WoStQzk391341ndBKgedzuisMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btT2a0pyeuYWNtVR0E3jRopMoWIsK7dcD1S6tCDDZAQ=;
 b=H22DWA9oEvcINd+fBpbOmm3skr4LO5le51v+YNepfsbUcMLJaubIJ2Auyb8jwf8xAB9qcBrCtrLCschoegKV6uNMaTWRL72k3yTdV6Pu6Eqb0dtXTi/mKirHEp9QpVGbEn4iqnMDNGXRx7iOIlWcwTzdPaXWePNonw8REyjdpseKZIfSG3aQaff/1DzYUp8oheCnzgFfcW2tFbkK+/rH6whISsrHWdskXqy1uWaYSzRE3RzBMI2sHqLZ8XAIRbQWsgC/7Cd40Wptqx/9fjFaE3Xc5mLOlnJngf1bt4pPuoFSwF8XRuiPN9+Q1XzSswqmicIILzLOd3o/MZjR/oOPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btT2a0pyeuYWNtVR0E3jRopMoWIsK7dcD1S6tCDDZAQ=;
 b=q2cbprcaH0YbiBcPbg7H/Ych3Pq/3FqNyDoFb3kCJhKxA5zfRLCCI22RNT0wUtFLQ+i41qGUWhe7v14GY5hFItMTI4xsht1Ah3CHNOYjyULG6wjDLGThMVqYSXXZ6z/bDtWiVQ+bVh9u8mqymTV4pQ2vmLtv3P3oEuP7bb3bqDQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6472.namprd10.prod.outlook.com (2603:10b6:806:29e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Wed, 20 Mar
 2024 09:49:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:49:20 +0000
Message-ID: <1ff88b4e-1bef-47ef-9384-5a1708ebbfae@oracle.com>
Date: Wed, 20 Mar 2024 15:19:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Btrfs fstests fixups and updates
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
References: <cover.1710871719.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1710871719.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: f4cda44e-0f17-4900-e872-08dc48c3039b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vqTsRO4PHtOYcN0sgsGTnxP8iUSBjHTK2vM41ZGmlDNMQ9Ov2BL6Qxo9NB5GJVKs8rzXT1rcu33qJGO+/mVeGx2wYzHe5TbvPv1XVXrOItj2oy2X6mj/PMd1vx2YJsQ6sdITO1eFuphyToQIWabDV6f5wnUNYOCWjUa0l/pGoarQWHmHxu7O9+YqfR8NTh0t1oWvMALISFTlVjf+npZwCiUFm1ALpjxTTopiCcwYLrjp8MQKMggpHZL2lHd6Hm3EZO+EJ/rCTWPB+Ow8TmxIdDKLL5C3AOQNOo77WPbtgHDnCeKMxKvHULrF59SfMhje6uIjy/2BwktKEPwGW+cvlb5q5qAbMmYgx5986HWvrhjFSRQx9ZDDYWr/GTOxsXa8pDgPn+C9U6TrOAzgd8LSld9LOH26GEqVJKOw5YEn3pMNV2bNyqpVR112DdnW5b1+xJqE78e+aXZCp+UtQvcL6/qLcB7WKOGQ6oyC8rs99IGEUPUG97w1bEqNG6RFDdi1kIA0dg/mQCaLpgSwiwHaTgkp/v8yfpZVmwyr4Uq+0Z1z+Y/tP0WuHG/MyxpPD0mMkuL19bmumtQQfQFwcloF0TTQkt4L+b3xLDWSLj+eLmCrRBikWLWyS3t2kLllkoEh52ONXf//g+BkiwFJrWBWI5IWvdbONd7WDqTAn9RvQ1I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjFxTERObkdiNGpiYmRjSjNCOTlRcEdSMnNReTJHWnU2ZXQ0bmpVRWkxM3FT?=
 =?utf-8?B?MjQwN1QxTFYyWks5OXVmWEpCcXdxOHZCcEtUemRxbnBaOEQ3WklOeGkwQTBy?=
 =?utf-8?B?RjBEa3U5TWFzcDRXc1lINEJ2QS8wSXMwTXBmVU10eWFQYlJnOHhBb3pCUFZU?=
 =?utf-8?B?UDhmbVh6SHN4dXVUZ0Ird0xzd2lrMkphTTZIRmE0MTBYbHdub3l5QUJwV0t3?=
 =?utf-8?B?SWt0aVZCMlcxSmx5R253MmlmWnEvNEx3Ym5mWFhCQ3pwM1NpUEN6R3V1TGZH?=
 =?utf-8?B?Lzg0M2FJcW5NUHpyeE5sWXVtT21ndm9rbGw0YWIvajQxdFJ1cFJwaVhhNjd1?=
 =?utf-8?B?WmROMEdYVzk1eXQ1SFREWjJOSTFldHhLNDVPY3R5aXZzdHpjK2prL0lYQ0cw?=
 =?utf-8?B?UEZWSy9UVHN6R01qYjdzeVJaWlFJcTFqVjRYY3QreUhGaDB2TWUzSHZxZmth?=
 =?utf-8?B?T3NacStzN2MwOEdoZU9oR0dIYlZUNjNRUWJYRXBRb2kwU2NiL2pEcWUxbUpM?=
 =?utf-8?B?UHZ1V0laY3Y2VG9yOGdHcEE4VnNOVmRaRlNybVJJZDhRQWhaaWxjSGNPaEtB?=
 =?utf-8?B?TE1WV2ZDaFc3MTZReDdxNFljS0thOVRVVFMwYm50dkt6R3RQVEhHcXdwY2hH?=
 =?utf-8?B?enRCY3R2emgzSGR0Tk5kTnBCQVIxZ1JIYXhWaTcwa2doVTFXcDlKaVJ4UFo1?=
 =?utf-8?B?aE1tTUQwSmN5dlB4Y1dpNEdnanhiTW9wc2I2UWd1Qk9obGxSYUdWQjNEOExy?=
 =?utf-8?B?dFY2WUx2RlpPd0tHeTU2SXRueXB4dEUvYUd2a3M3NVM1SzNqU080c3ZFdEtp?=
 =?utf-8?B?TE1idWhHQlQxdkQvYXVKVXl3ekd4QzdzN3ovZlExalZWSElMQ2lXTmxuZWIy?=
 =?utf-8?B?RmhXNFNPNjlzUHVmY2MwdUY0cVpmL0Izb2E1eXRzNlNrYWNxYmdQT3lwUWxx?=
 =?utf-8?B?ZE91Um4vZXN6QW93clZxMzZLcmVncmZrTE5jSGVUZmdzK1VYMG9rMC9pY1Nk?=
 =?utf-8?B?TndKNXdvOElHMWpsQnZ4TEJEOWV1UHlXNFVzRXFrWlZxUzRRTmpGRUZMWk5G?=
 =?utf-8?B?QW1rV2VMQUdhZ01zb1RCcGhKcGVETnNCM0g2enpBa0tVZ2UyMGN5RXNKbmRF?=
 =?utf-8?B?dnIyUFhaZ2pyc0ZuVHkxTDRlTG8xSGRDQWI4MVExOGtjeGt2bkNPNnZjbHZT?=
 =?utf-8?B?RU8rbHhDZkJBMW95YkphdzZFMXdjOTRCQ0Y2Ry8wdDRMVmxSc1Bnenc2a0FG?=
 =?utf-8?B?SDRPcEpkODUvZFJhQk1iV1FMMUNORzZMNXVYVEZXTGlneWFSTFA1ZXV1cHV5?=
 =?utf-8?B?VDJ3TnN1SytndTFwT25IMGNTdG84aEsrYjZwbnJDMllWeXJVSlVpMkZTQXUy?=
 =?utf-8?B?SEJpVWp5YUFuZmxzWDZTcHRpeXZBd1BkWkJHNzJGeG1GTXZnNG5PWU04SnAx?=
 =?utf-8?B?Y0QzWW9TbWw5VVYrc3RYQnIyd2hzVFo4NSt5MjRzd0hXMzQ3M1B0WlJIUjBX?=
 =?utf-8?B?bzlpakt6Y2Q1OVcya1ZZRTUrUlpYQVczOTZ2T0tTN25ScnFwYURBSndkVlBB?=
 =?utf-8?B?QjAxemc0bWk3MFkvdWRPcTd4RGhQTjNTUkFrMjdFdnRsdnBtUnZBcXRiQXk0?=
 =?utf-8?B?QTJWUFpzTHZuVmtsOUhidi9MUjczM3BSOW1SUzRnWjUxaHU2WThZWnM5QWZJ?=
 =?utf-8?B?S0RKR1REYVU2S0drQldTRHVncFBiOW5DUkNSU3JCQnBkNitPb1JHdnkwR21M?=
 =?utf-8?B?dnNPbWUyZGdRb2RlaVpJRWtEaDNFYjM1elZ3c0lsQytDVSt5S2VIZm8yMnUw?=
 =?utf-8?B?N2hSY0FpazZrUDVYTnBvNk1jQXViV0RQdmFES3NQdDJmdjhkUS9JbVJpMGt2?=
 =?utf-8?B?QUxnSEIzTXVtc1dvWFJrNk5qckdiVzgrdWlKVWRYTkFsMHVzZmpjaWx3OVBl?=
 =?utf-8?B?cHRvN3RYa1FGbnlUUUkrb2ZWaUREWXE4M1dYckZMR1F2WSt6REZyTFYwRGVN?=
 =?utf-8?B?UU5STEE3NUcrK0tNdTAxNnlwMGdvZU01OEEwbDZrYUs0ZlZoUnNML2JnMVI3?=
 =?utf-8?B?TWtrSnhVUENlNS9WNDgyVmpJK0xNUkUxNmN6ZjZiUXRkRk0vb0Z3dUJOdklv?=
 =?utf-8?B?cnZPcTRlc3I5czY2cUlYYTF4cXNTbG1HR1RQNnNLbEMvci82cTRxRkpGY1lK?=
 =?utf-8?Q?7Nf8Tmx1qo65w7veE1cnGXSrepMyEf8a55Tr92HpzhCX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9Z5yKtPjUu29Bnm3+3bSkA2Xo+LULfSbxIENdjEWnde/uOTruJSD0QhOarfAzyWY9qQVunR8WrDXzW2GEwr47WTPyRxEIGk/Mux4AMP3jagk5QsOGuhZNcmNhJwKs5N9tVeCItB+RhwTeqoUS4I4sYO8OzYiYsMI8D3PvzK/RIhJZGk3ND9e0Pmus/AxDsGMeNoG9A3SBhfgjIY+UogL8Bq1hriDGmIi3y8x3D8VEOgVEQk8oXl60s5tPKqUexyW3tPxqn0oyvRMY3VphoSHjXN8RZaDcmEkyZxvYvNUe1uUTcYK4Ac4A6HCepidU09jRq40JGUxN7toBYt1oOg8SVRAYkOCHRaOkhtk+SxlD40holCgHxg0+JdXvBEx9hZpLyxBJiNpw1cI9DvJgzHXfV9xW+Pg9KEk85eEKqsSVqcuMRm9Qy8+sLswJ9Nk2x7QgnMOtcxjXINVhpaaB793ZJxaPf1ko0+wHBZ1wc5WxZ2pgp6dVa2YmS44ZEgqPZGmg1gWWUtsfZqlcytyFoetD/TVT5KAJPc56GoG+sWf/f4cvuMjVC2idrG66SSz2205CZHXAJpxrpqRW+4WAdqh7XUIxKGXkM4YW9MXbcwyIjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cda44e-0f17-4900-e872-08dc48c3039b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:49:20.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1Mf2DqIMkIk4G8dcZ4DuTUiCzvnfGaN11pmbCCwCYzBcYqI+atIizYdqUapj4EmDZ0gPeXotdpCsA/FPqGU0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200078
X-Proofpoint-GUID: tKq31Ava3ZxehGSv7jW-qmWbTLEmLuBl
X-Proofpoint-ORIG-GUID: tKq31Ava3ZxehGSv7jW-qmWbTLEmLuBl

On 3/19/24 23:41, David Sterba wrote:
> Hi,
> 
> a few more fixup from our repository.  They have been in our CI branch
> and consider them tested and working for our needs. All of them are
> btrfs-specific and will not affect other filesystems.
> 
> Please apply, thanks.
> 
> David Sterba (2):
>    common/rc: use proper temporary file path in _repair_test_fs()
>    generic/733: disable for btrfs
> 
> Josef Bacik (3):
>    common/verity: use the correct options for btrfs-corrupt-block
>    btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature
>      in btrfs
>    btrfs/330: add test to validate ro/rw subvol mounting
> 

Which repo base is this from? Fails to apply without conflicts.

Thanks, Anand


>   common/btrfs        | 10 +++++++++
>   common/rc           |  4 ++--
>   common/verity       |  2 +-
>   tests/btrfs/131     |  2 ++
>   tests/btrfs/172     |  3 +++
>   tests/btrfs/206     |  3 +++
>   tests/btrfs/330     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/330.out |  6 +++++
>   tests/generic/733   |  2 +-
>   9 files changed, 82 insertions(+), 4 deletions(-)
>   create mode 100755 tests/btrfs/330
>   create mode 100644 tests/btrfs/330.out
> 

