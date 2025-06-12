Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E60235364
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723988; cv=fail; b=u34B4VTUd4CNg1K03Eae72xRUluPAfXo/Bk7PN6yB9ELWKiGjMuFWBGMJ1DY2tXHN9SNeoElaq8/TJpIPR7b6oAr2KrXTre3ff/6RqBNpoGHVVaG5TGwWTDS4xUzS0t9Rz/hehZjR364w4xrvSpySZWnd3Hv4fow8Y5F7dR67mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723988; c=relaxed/simple;
	bh=CSXEM+3chL+SAgBtCnY3xnzEJuIjdWfM0PtMF4bBXn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QrP6zQxavIq7h/dPyeILRYSjBSsA6StjpWsUsMVgEUv+PC5k08vSHRmr7q/ZZMkjVrnmCNJZ70s759lRfZ6od5s4NOd02e1L/1kq56CfX1LVES7/VyXjsDiD24Vco9mnAO8mhUC2gjtSs9PS3yONzz5hA7EaSyc8rfMY33+x8vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I8Xv4qJD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vw03Pk/M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I8Xv4qJD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vw03Pk/M"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7ffnv005742;
	Thu, 12 Jun 2025 10:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jeU68WO4Or78ZxxKb1zeQnbQBGQLM3M/pbmmXrMEPLg=; b=
	I8Xv4qJDlFvDqtJFc+Ay7r8BQ7oQmxifOub4vce5ErXbFtCrS9KzZA4aY4mZgxR8
	if/E8PXIrIYtMPNl1eVQ/lRhEzxLtrOVbVUj+Frv4grd+UCzhKmSqf6e1OVJLY7g
	myWopYN74PO6fKmk+OzB/x1JgRRni2WIsE1hKd2eu27Wt2joh6oIYWggZHD0QyC7
	UPtIeZ+HnY1zBmss5aQew+KbnN0lSw0jKNMdCtXlj0XKEgNXns/2Y+uYHoAw8scr
	YMsPJ0XG0dQ3ia3ZWz1sxjWgV4/5h7xUEhBaujmGNhrc4hUIj1nV4cYz06c0K+RY
	p9LB6tR7itb62pjFlQzvww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v9dkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 10:26:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAFCk8009189;
	Thu, 12 Jun 2025 10:26:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvc48d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 10:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/ODxnnaKiXzlHnMD9o/s9zqbUu7HGcYa8rK2Q/k2SwFxvGOo/1mhTqiahjMeMS5Qf8QxGyXiTg5PtjYSiVGdf4IXXjRgo246Vr9vAiYJ2kxLpnymm0sRNzR7UFMa3vGOF22Y4gYhwWLJf1VOSKU99ILoie2i+eJSWHUVRAah+CNJ3+Q8fMEOWXvjhQLvH2TtPGk2Eb4fVE6Eeex7K6belPkrcKaAwmlnI7gYsyi24Z/HWOU88F1OcfduOoAea24P8uwTeYb9rn9SIahCVNqogc0Pe+ZGvwKME+Rl9HRBLr176gdSr2doe05cKlNpGgf+2rloRMv8Gg6h/5qA9JvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeU68WO4Or78ZxxKb1zeQnbQBGQLM3M/pbmmXrMEPLg=;
 b=NmgnVlQBh+S+AjLRL/0RTfC1Tv2OUQJ/q0YJtp0gBru4j+kzCFANWrhStMgZ0Sq7gypN4VN5kKhddI0YUqv4rpg/UNnhBgOz/QYQijlr52af2Pndpu++JSTv+7HOHswoUMVi1oV2FciMEyaGyUC1O6DSIn+zYofHhme279u3eBrR12u1KgwYLqlGWwdg745HkxO76tUuoQ5iFL35eoBR8IbRjiXIIuljGSuyoP+tAqtyg5ckZdJJMuM9K0TOvN375PsHgJ8ZeV0/nt+gRdWrf4afhMDUqund2EAaivG8ZbvR9O9UZKF+BhJ4AnTS2SsGzyGRHT1fj/IfEoZpJVUybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeU68WO4Or78ZxxKb1zeQnbQBGQLM3M/pbmmXrMEPLg=;
 b=Vw03Pk/My+mKExxCf/a4A6hhgOWbY1n4phsF0FRcAkVAhDVuoYQXfcLCO9umGxqnfOMXAvo6gJGew2hBekMCGUUOrxb2f5Lih5DaATKh9qGgBrf0PnMNkAhkqhxDS441LINfHLZgHh3xjMM/U2580lGZPuR3HeJNzwz6IUT787A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 10:26:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 10:26:20 +0000
Message-ID: <05005921-517b-4286-be24-eeef625e488f@oracle.com>
Date: Thu, 12 Jun 2025 11:26:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 10/12] ext4/062: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 35092c11-c7f8-43a8-cc33-08dda99b925c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVByZ3JHSjJqbE5LZXlvUG9nYVo4RU9Jd1VIb0R2TUxLUTJZU3dOTXJoeHhV?=
 =?utf-8?B?MkdiRXpDMXgxdTM4ZTFPRm1yMWNDM29Rc1BiVVVQV01XL1FIbWFucGYyTEFY?=
 =?utf-8?B?dlpQWnlMMUpodHk0WWNWYlZXQ1g5Wkwybm5GVWdGZit2UURid1hUbjRiMjc0?=
 =?utf-8?B?dEgwc0g2OXllUVFoVlZQcEVsTFJjNVpMMkN2UGYrRXRxSDVTNEZOUk5aQnE3?=
 =?utf-8?B?cEFFTnBJVVBPcURMY0ZtRkVwMUlhNE5wVEZzQ01maDRXZGxnRkpkWGFKR1dC?=
 =?utf-8?B?UGllUHFtbzBCdFVyVHAzcWVtRjVxbmVEQ3Q3enJqcEVyeTZTRHFjanNIK0FC?=
 =?utf-8?B?MDR4alBpUjlpNjVjM2Mrc3ZUdFlVZnhUZzdRK1VaajM0Vkh0a2ZDK0xtVGhn?=
 =?utf-8?B?bVJ5ajhWaWxKT29JUzZZN1ExSmJQMkEreTJ3eUVHRkcxbkdKWXR1bGNvYlJl?=
 =?utf-8?B?UUFBaXdNYUNkdDg2TXhoZmZhRGxvcjl5YUsxVG4xem5uWHluVWY5Z1Y0N09L?=
 =?utf-8?B?REFxa09ZR3QxQ1kzRlZTb3ZPVWZzQVowVHJETGZ5Y1c2dzBkMXVyUFo5Q0xo?=
 =?utf-8?B?YWxnZVpZYXEyQkVEcnB2d3NkWDJQL1ZFVmplV2gwWGIxUmYxY0FFSFNadUVY?=
 =?utf-8?B?Z2NSeHZta0h2bUw0alZrMk1PbjFPdnpNdGxzZnM2YzV3QkVrQjRNUWZCTkNM?=
 =?utf-8?B?MWhuNFBVb2x0cUZ5Q1Bla1JOM0J1MmE1VGF5bVZmMFpvalhzV0pNREtqTTRN?=
 =?utf-8?B?ZWJCTVZCc0tRaGxhVHUyTlROUVFWaGl1T0NjR2lPdVlHa1M2Yk9vdXdmcHR5?=
 =?utf-8?B?WWxlNkd3dlRjaSszTzNnMXFJUWl4L1pwRGJxeHlmdFNCMXlkdEZCeThueE1S?=
 =?utf-8?B?Ynd3ZUl6ZDF5WXQ2b294d3JzT0FjZzZqK2dVS0lrZk9adFNCdjlaTmtrQXhR?=
 =?utf-8?B?Z2l1UXNPazYzZWlWVEIxR2RGaEgwR1BQRTYxV2ZvbDdWeFN0V3RRbVZJRUow?=
 =?utf-8?B?bWthRW51cUFhek1jaHR5WDFhVDc0NVZlbHJVU2RWNDI4blRwUDlCOERPNzBu?=
 =?utf-8?B?S0tqYTFQc2dIUVBvR1V5TUFNcitkTjNDSFg1akp5R3ZvQ0R4QU0xVFVzUWp4?=
 =?utf-8?B?Mnc0VGl4YjZtOXZXTUlYTWVhMGhxeU9nblRxZXJJd0R6bGMzQjBtOUxINDhs?=
 =?utf-8?B?WDNVOS9KblBNeVhvc3RQM2hBalVtMnIzdm0wYWYrTEh4WEtxa1hFVmlPVDcz?=
 =?utf-8?B?MklWZFdlMnR1R1ZuK1pscnV5K3ZnZmVxWjVzNk1yNGQ5Y3BQTFlIZEgySGJx?=
 =?utf-8?B?MDhrY3gxQitDNmxZSkJDMmlJUHpVMGx4UHFoVVAyY1JPam1hbDJwYmdpcXR6?=
 =?utf-8?B?c1RqblpPY3dSTU83SnpsUmxKUkRYT1ZEejNZTUM0WWFJUC9qWHBpREFzbXpN?=
 =?utf-8?B?Z2p0c1JlQXhmenlmb29Qa2FBK3AyOEV2VkU2UDdSQkV4c2RWZ3hibEtDcThG?=
 =?utf-8?B?TGNxRVRhUzNWT0VkZmFZYzB3aU81c2Q1WTNMWklTZFlMdnpodlkvejRxaDl6?=
 =?utf-8?B?SWxoMGYxZ3lVMm00Unk2TkR1dWJRVlVweVJsNnMySUpkTnJtUFc3WVZFbG1N?=
 =?utf-8?B?UWVQOGNjWDVzdndSaCtNRFJBVXpkL3VjczllWlBiN0NSdHMvWmpnNHM5Q0dl?=
 =?utf-8?B?SUxoNU5nYTFRcnhLQjhXWnBtQlJhVVFJSk1abk11MERTclRIWnY4TGxWM3d6?=
 =?utf-8?B?STkvQU9YcytJckorL09LNk1jejZ2UEJZbjQvZEFRSVVzNW1TRjN3ZzhLeXhr?=
 =?utf-8?B?YWRVNlJPakxBaEFxQVI1bGU5VzBwUyt0dm42OWJkSlAxbGl1blBOd1lNZlJ6?=
 =?utf-8?B?UVd4blB3SHhKY2N4Nm5NUWVYYVZVZFpyOEtNVUdVL2RVWEpnaXZRYk1mc3pT?=
 =?utf-8?Q?d4sfC+icd0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dXNjBMc2FYMDFidnRXa3MzQ2xhbWZWYVl5bHNCRWt4eVpENm0wNk1XRVBO?=
 =?utf-8?B?b1RrczR0d1pIRHBXbHpjdDRvYUxNZGhJaFl6RHo0MU8xS2JHUFlUSEROMm9v?=
 =?utf-8?B?Y3lrVEQxVkQ2Um1FMkRQSUZFWnV4NjhzMVJTRXYwNmdwTEtEc1lHaE9SNUl1?=
 =?utf-8?B?OUpreFFrT3dhejNVT0JCV0laenF1cEVzKzRLSDJtUHN2ZGFiMWptYjlaNkhX?=
 =?utf-8?B?TE9OQVNtNk5ydk9nWnlDSDhTOE1acUlUdmRsMWQrS2JFaVR6c0FZOVF4ZlU2?=
 =?utf-8?B?dklsUFBwM0V2TGxTQXZuNEcrWmZ5enNyTFRjcnBpSTdJYkljK3d4dmVnOWlq?=
 =?utf-8?B?eC9ESngrNWdydW52OCtiOEpjdUh1SE9OTkorVUNySlJhQVdmK3dJcGNTWWJT?=
 =?utf-8?B?QzdSZGNJMGhGSnIwZ1lwam9mQUFTeG9ZVTdwUnBXSTFNVGUyMVNReXovU2ha?=
 =?utf-8?B?RWZiWVlWZ0sxS2V1eXlNcTZHWXE3Z3JKNHFjd2RzYUdrOHdya083YzNaTUQ4?=
 =?utf-8?B?K3Fqb2pEMld6T0U4QW5NSHh0ZlB5SHVCZURXamdOMDZOOGRiYXdqMWV0Vnd4?=
 =?utf-8?B?ZlhvcXgvWTczWTQzR2lzQnpVV3ErVXlXRG1zejV5OTFjeUIzRnAvWFM5bEJZ?=
 =?utf-8?B?N3grNWxEQUtsK0d6aTBUbnlPbW5SRjA2MjY3OGtjQWZpYTllUjFZWWdLSlRT?=
 =?utf-8?B?azY3ejYrODc3QzdSZXNMd0VZYmcwdXZ2a0ErQTU2OGxvZzR2NDEzOWE2SkZG?=
 =?utf-8?B?dFh6QVRJSEFmUXJrd1BvMi81Q0p3ZVNwV2Fwb1RRRFN4c0xpZGZnalhPWTRh?=
 =?utf-8?B?bHA0WnpFYXhrdm9FcHlTVUhIbk8rVW8xeGk4dXp3b2pmY0NmSUVIc3BaSkly?=
 =?utf-8?B?RktjQnBhQitmOGVISlQ2YUlocy9TVm5FaEpQZGlXMHhQdjBkY2NodHRHYnE0?=
 =?utf-8?B?eS9LREJER1NNTzBOSkRIWTMxNXE4d2cvMkRQVDlWeGhDS0JQQWZORmdBTEVs?=
 =?utf-8?B?UGttMkFZOU9QOUFaUDFrdmlpQW91Sm4xdWZuc0pXSVg4Vk1MY2RaTXlsUmFw?=
 =?utf-8?B?RXg4TlFZWm1TWkp5azR3aFEwZVRaU2JSWVJXaWdKNWQvZ1FBbENDY2EwODZV?=
 =?utf-8?B?WG1iN2RDSXU1RktaaW1IdE5GYVJFazlLUG5zaCtlSnFhM2tFNy9WbW1PUkpm?=
 =?utf-8?B?dkRHcFpyUHNwUWlma2tLUXMzeG84NWVKaEJDeHNoQklTei81OEpqT1p6ZVFo?=
 =?utf-8?B?ajB0Y2pGaFVFWE91NU1ZOW45Z251eWdyZGlBcWtCQTU2QjZBQU50MTJzSXlG?=
 =?utf-8?B?ek9nd09nM2l3MVBVa1BjS1Z6dVJJUmQ4ZVJtcTFqS1pURGYvRkZBMG9JQ1ln?=
 =?utf-8?B?ZVZEV2Njd2s4UmpsdmY1eTIzc2lSek5aY3JVcXRETVVrSC96bnJRdzJUWnN5?=
 =?utf-8?B?M29KUGVqdCtGR2cya3N4d0JTSGppR3VyNEdqUVhtNEhvUmFiSkphSUg4eU83?=
 =?utf-8?B?V1ZBQTQwNUU3eGtqeEE0bzR6UmFwK1o2Mkc1SUFUc3E1VnBHUldudVJUR2l0?=
 =?utf-8?B?NXE2ZnE1QWg5N2ZOZXZld2todHRWdW9wdm14dG5JTDJSTEFHVWdnK3gwbHpz?=
 =?utf-8?B?aE9sWWd0NE1xNnJmTXVhaWlQckdkb3lFa0NCSU9YOFc4TWxYUHlqa2VEKzJO?=
 =?utf-8?B?eWRUVkVJODFLRVFNcEJpeTNNVS96dGpsbm5yVE5qeUszWGxxbEVaWllZazVI?=
 =?utf-8?B?K25jV1RJTjRaamtLMTRoNFRQWmtiZ3pSanZsVnZ3OU94c1NsbGV5L24yV0tH?=
 =?utf-8?B?b0JBQUsxRDhsbnZITjNvQ1FvYWpPTUdzMmw2RExGcVVPa25qcmIvbG50S0JW?=
 =?utf-8?B?RHIxUHppVmlnMU9iaFZjWDFNYkJNWUJwSkU3eHJIM1VHUDZvWjRTTW82S25a?=
 =?utf-8?B?ZnlxTVdpVUMvZnA0bjJ6cFRjbWNacEkwSWc2U0lVVVFldTAyM3lUNjNmanhB?=
 =?utf-8?B?MXVDZVhMblJIbGsva0JFNjhXcjV3ZExDV2RzaVpkVTgzLzBtZm1ubjlkcVRa?=
 =?utf-8?B?SkRMWlUvcW4xSkhCdFBod1M3MzNMK2ZpbzRiV2R0ekFtQzMzcUxZcnRXVTJy?=
 =?utf-8?Q?4J/Iuk4CSA8u9YjM/aEZMcbRY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c/MjDhicjM+Oq1q2BQxVw+2xmA+8ta+avMNvZ1gA784Lu55fl3fOV/HyAzrAgV+9V2BH7VPACOIhWNzOPOY9zn9Si/0L2WUBVIhKx3h7TTBE90M3T+/imJo96iGS3lAOJDcP4R6Or3OI4jJF7v2pxR7pEBqMWACu71L054ek8TGrRcLJFUA8W+if5ey9S/uacN4tH0onMR9iuDG158KvV6nNiOHzNxoPnY3vJ6qVRgSFEuWcS1mujS9Ievi87CG49wgeNtH45JG1+0E+GL6j53uHrw8cIYlRLYpG5TO7NSkmIwjh1EJaruuYilQOi+VhZLlAN5STKgkH2G6hVXfz7wFn2Yxr0AG34ATgotLj+Ajf5S7Ybjkvioe18+riV5ph3F5Iz73zaPAguk8j1W6PcxkdCGoYhP/3RYHZ2JqJz8B/Uq5bwSAgalJrcKUMQOIQcGI3BEOn2mq2EEc7C9w2QY+qTnuIpQMn8wmKsdNtDrHPNYo0LnybPJbtwxTZH8cuCEK2XnRszU32sksrTGMvq3muJdc8qCJnBiJToCZLuBthk7oRW2V2sN1gj5KoIGLp683+rKFOlDR9iLS9D1tEs/lZeAh6jkXqKdLnbgXrbdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35092c11-c7f8-43a8-cc33-08dda99b925c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 10:26:20.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65EesxiU9+fRh+olyYBYlbY22l/daKLcr+BlYdMW3gYDrIrf1Hz5Z/K9Q+oXwPJMFZOOVcOvave+i/Nw13j1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120080
X-Proofpoint-GUID: ZFfVQNVrNF_THe3aFr9PoZ6gP_wN4lSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4MCBTYWx0ZWRfXzB7xlRNn9/R7 4pq59ykw/xtSUHAyTIdZtt6OXErhZl5+5edfgPuQgZOkhryJ9DIugvhvYvnkXG7TrQPsFe8OdNP JcOZjMJuWkIv8mFnYa7oxPG8vFNXB80Pb53hhiuC8LEiDyn4Ie/ePvF1XV0cg0m5ZIyKYpymWsX
 Ilfl7fnud+ZrBlSuy91QmRnnQia8555i8Dj5PXzQkmTkbprnCsUxbhvg5QliqW9LSTBod9EycyK wYMm8DB3emxyR8oAS/wHGhPN9ZC9TAaZU99Zc0s5Wdd2mqfiXZ4NDxadhbDYxPc4LnqMwkJwduW +bSLZTQeB4aSoEgiVOKPv6jNUGvYdUiaIa9m9ms8QWRHYWLFuOTNuok/QL0F3mWvevj/JETngoz
 qUI0Hj4eodEQMzv0BlnDJxJV7lE2IQinmNR9gKd4MhgkWvXDgjigZ3N50elEbsfVH4bBirCu
X-Proofpoint-ORIG-GUID: ZFfVQNVrNF_THe3aFr9PoZ6gP_wN4lSE
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684aab4e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=TbEIRdRl60qcAvBagXwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

On 11/06/2025 10:34, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> 
> Brute force all possible blocksize clustersize combination on a bigalloc
> filesystem for stressing atomic write using fio data crc verifier. We run
> multiple threads in parallel with each job writing to its own file. The
> parallel jobs running on a constrained filesystem size ensure that we stress
> the ext4 allocator to allocate contiguous extents.
> 
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>

RWF_ATOMIC does not guarantee that racing atomic writes and reads are 
serialised. That is what you are testing here, right?

NVMe and SCSI do guarantee this (serialisation). However, reads in the 
block layer may be split into multiple requests, even though unlikely.
