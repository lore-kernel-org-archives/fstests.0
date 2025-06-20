Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78540849
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428122; cv=fail; b=Qe4PIezo7YJvnzahy/2C+wCDlYtR23CokVU2+R4CaafzFKyk+hxxL+M6nOViTMH9hQPXankNhd00EXeAqzLts5toaA8ZQfJh5PbAhsb6F5cqYL4UASlqj97Qb4lBFS8kfYjiasKWFVjm8EijwTWaN40/2X6TTxhd1S3MjoIn4Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428122; c=relaxed/simple;
	bh=yT1VMBy3gDCwa9j9VU+7KuDj04Q7WZykJapB8kIpkac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtrVc3Nmw1mZLB/W1t5loOGn6euMhMXrQdhyTgGkrpSmtr2KsVUpWqBPPyqO3hgBwzyKfophefnSdXdsVrVafDLh7t0cKJ5fFbfLa0bZUAPCl0l0yW/LS4OHDDHP9B9ddWChULHZQomG6m73//05O4Q4FWjpOz1sO9Nxg5OrkzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UqOdeTm8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=swnuzeTA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UqOdeTm8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="swnuzeTA"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDW2Qm027020;
	Fri, 20 Jun 2025 14:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AR+OqyOr3rIk2WNaUUPEU5mX8ZwDvhfIBhHoaPVIheU=; b=
	UqOdeTm8oCCEeh6RTNKaTBqDNgGlxAVilcKpaUjqG8meQ0JpqYuN9ABx1GOGB6ew
	0PahdocFBJxwE1uUDnTJFlg5H83bceAKMXgBofjZMpeMamV7XHe5PysiytGr9FOR
	f4m55odGdgAnyZVhaRNT6y/s9QoZ2odkkZdQyru5WmyCFehap1ncZEnXXm8KN2KW
	VBwqSCoQ/XC0VwNmqlOKJOYA9LNxg65YS9/F1QR7BMHqafqx9aC0i7F1sww3I91Y
	U/9lJU9/Za3vTonqW36DE5fazggMwDhjaH4Vd2kz22ndDNAeZDn7duICqrUXHk2h
	hFI2250i0NEjBBAIRaZMzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv5bn9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:01:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCPjhS037561;
	Fri, 20 Jun 2025 14:01:51 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012058.outbound.protection.outlook.com [40.93.200.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhcqd1n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deHoLQ0BhCLRSy2cHQ6zn1foiHuqHHocTKxjz7jjwQS7iygTL7PJqpw1NmgMb9poUaIZ3hdRpI8ZMSZ/FztDrHPzQH+R1QaKSnXLeTjBJHVb1bNTrbuh6C72NpX1Beu3Bzx4xFmbsLAipu/6fSq9ATRDypd5AVO7Kv/vK7Uq8WaH9Si59sQZjMT6x/cCYysXPC5Rs3xx5N2HyUKpbfq30FutBP9q8OnEUFH6XbKw+k63hSEVapAUwdIsbT5WT2Cm1gbyoMcpOMkUF1xDZnv8O4ZmxJanog8dyxvZrps6L7+MxLzN9whfy+ahHK+XPAOBeJhnIFbmgVUhlgfyyD+JBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR+OqyOr3rIk2WNaUUPEU5mX8ZwDvhfIBhHoaPVIheU=;
 b=LWMqtxBO9z027FdDhx3XqunC2nG5DILjl5/17sSFc8I3EuftLGnXJb99y7z/vI4HIsxsVgWOe/oxP2z7L64kILdCL9aqAtLLo5nWyz1yvOCtFMgPha/NP6fi0TEWc1pZqmKQTJ4faN4fbnRA74d/Ps8EKq8T6siytC5yCaG87zOeAotig5RZiCExUlm5tQL+Zu8H0wUwDhZpyRfSzAB66bUHxjV8qIEb98aVEG04ARZR4eOTIIwacH3cVdIG/vD5DV1t9sIVhLITUS5vk3WCjHPk8rXQlOz+/Q4K5ahAwMtLmTzSYpqcwbt4vo82kaA+NTdS/zozn1SY3s14+LtVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR+OqyOr3rIk2WNaUUPEU5mX8ZwDvhfIBhHoaPVIheU=;
 b=swnuzeTA/TeGtbmaw3UsgIJLJzKjsRUbINIlORhfVe1bswFjMaZ7cltELL/jV62LrD2lqINR0MS7JyoFQT5nl2GV90fk1nlMIlBn4yXv542MFTrHYU6JbLD/TIqsZOTLEe6HOtfC6UsEgyUjRiMbcvX3Qn8b391VTNIrtkIc2LM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7809.namprd10.prod.outlook.com (2603:10b6:a03:56f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 14:01:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 14:01:43 +0000
Message-ID: <87a683a7-9e81-4495-94e7-675627397c16@oracle.com>
Date: Fri, 20 Jun 2025 15:01:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 10/12] ext4/062: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
 <05005921-517b-4286-be24-eeef625e488f@oracle.com>
 <aEu5KcCAkOrjiLDb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aEu5KcCAkOrjiLDb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: b35f6b81-770c-4350-f05c-08ddb002fcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGJ1RDRnUUlwWS80SHlobTJZcW9kczZaVURJWUJZMUx2T2lmT2U1bEl0Ykhy?=
 =?utf-8?B?b0cvRkhQNklGbHVKUkJtUk5DajczeE5HUFVMWEtYcUZSVTlOR2tOdUk2WUJQ?=
 =?utf-8?B?amdmNFVnNk12cHluMXgvQ3hEVnJwcHVsTXZtVWhUMEkxUXlLc3M4a3Jjc2FG?=
 =?utf-8?B?UDlsbnRCek9WTjBHWlF5dW1YU09RSEpkTE4rUmdrWE16WGpHN3huNmRjMU8w?=
 =?utf-8?B?djNMZThqYm9yL1VZSVRuNDRzK0x4dVlRaGVBVEJUME9abG93amxmY3JTakIx?=
 =?utf-8?B?UzUvZmk5RVJWOWxab0p1VytZWG1VcGgwMUQ5UVpRUDdmendlTWpFRzVTaGp6?=
 =?utf-8?B?OHBUTXpKNXcrT1FncWUvOTlMVFVUcWdSZ1huNXRVeGVzV0NKdS9wMFhOVDVW?=
 =?utf-8?B?ejZ3S0FlS0FhZ3FncVFTSWxhWVdibHJ1a1pDRnZKaGZZempPZ1dlMVFjZWVx?=
 =?utf-8?B?YWFqaFpBWlFZSFJsa0hOY1pUenF6dktLZGh6TURCVFV0M3NDQ0JpeE16Y1lu?=
 =?utf-8?B?MDlZRXBxcWZWTGdUYndLWXJOYnZYeEQwdTFKVGVpY1FkVzdwLzk1MTJLUktW?=
 =?utf-8?B?bEl3QzZoREFzYW9Ya2NoZkFCNGt6TlNJK2JsM2RiSjVmS0hIc3lWbE1kL3Vu?=
 =?utf-8?B?a1JvZGxJVndjOC85dkZHM1VmVHBMMGdmN2l4WC9LVHNHRFAvVno4UlFOdTBj?=
 =?utf-8?B?NHpxMzZEY2xXaFdNV1JIc3VRSGhNL1RPREFyaUh5UWozVkdoemQzZ2VuczNQ?=
 =?utf-8?B?engzRS9iSDZDYk9mRVQ0cE0zdXNLdkhDRzR2cFBndGFLNW00RjIxdXRNRXFU?=
 =?utf-8?B?OXE5cmtnKyszQ0VRSTh6ckZJT3dRcU4xRll1cFdqU2YxUmNZcTl2cTkzODZH?=
 =?utf-8?B?cUF1OUJJRnIybklFai8wMERLRGxZSWRSaStRZ0VVNkpVaEpkVVUwa0pLNlpv?=
 =?utf-8?B?dzJIOGlWcGZuZTUvamtIV1BCeFNieE0vdldTUkpMY1poUGhtWENhenE0UW8y?=
 =?utf-8?B?cjRjMjF1SlJDcVJ6U0d4MzNaUWtGZ2JSS0VHMG1tZEhBNGQ0M0xlZU1OMXQ2?=
 =?utf-8?B?ZHJaU2FGdlN2VmpQckk5dDNGTFpxSWR0NGpRU1JXTmNlSVllbTc2aGNnWS9X?=
 =?utf-8?B?U3hIMWo2cnVQTDVJM0JBK0c1aFB5MExQRmtnWEtkMndQdzhDdGhzZUZvQysw?=
 =?utf-8?B?UFJ1VW5RLzRUekdHbHkzMFlEZVFiKzRQb0tteEFKdS9KRTFhQXV1dUIrNHdq?=
 =?utf-8?B?OFlBbDIzQ0Z5TVF4cXBBR1lFSnMzaTBOY3BJTFJ2WTlsUHczOGIyek1FQTB5?=
 =?utf-8?B?UklKUjFQbXViN3ZKNUFIM0VjM29zaks4UHhEQVFvUnhzR2pOY2xiQm1ZbjFI?=
 =?utf-8?B?OTFFSXpCbzdaUTRPcDUyRkgzZUVHOEhqdGZJZmJrYllzQnN1b0dQYmEvMmh3?=
 =?utf-8?B?dWdKcVZsZzJFVURrT2g1SHhucDRNVGM0VVViZjQxWEtBQjFsQnYzUGcxUXVC?=
 =?utf-8?B?aGV5RURCOFFJRmt6cWR1WjJGeXpzaG44YnpiVmhCUTl5RDExaHp1Z3JhVnp5?=
 =?utf-8?B?YVFlM2VsNFZmazUzNGUvd0Joc1VqSHdoaDg4UnlnTnIzUXYwVkxtYi9BSFE0?=
 =?utf-8?B?aHRGK1RDTE5zQlZLZ2tkZjgrRGwyMktpcE9Ycm9YZWFVL3JRZDFWQ01FbGpm?=
 =?utf-8?B?QkhtM0VMU3RFbjkydDdNeXdscnlsUXlCSUEyckdLQitaYkhXZVNyM09TQUQz?=
 =?utf-8?B?ZURkUmtpTG9ZVjJ6MnBVUzZOZWJqWFk0VjZsOTNxeE5sNDZCa2NZcWJFeXdt?=
 =?utf-8?B?S2U3dFNaWmxwckdKUW1pT1hqMlBzcVpiU09FaFI1R2d6ZEhPUUxXbWpYb2Fv?=
 =?utf-8?B?T2lVbTJNSWd0Zlh2em42anZqdVJxZEo1MnZUNnl5LzdNOVQxcmcvS0pNcHpz?=
 =?utf-8?Q?EeDG0dNf544=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEk0WkJwS3c4V3BvVi92TFZ3cFpzckhFL042eCtwbnBEamRucVZZUVVySzVs?=
 =?utf-8?B?b3J0VTRHNGxBRlhMaitvdUNzNzVHcmhmVWkxYlovRURVVWczbmFXdzVOVVlI?=
 =?utf-8?B?VFNoTW14NjgzRXhDMVdmVHEranFqbjVteFBFeGM1b2s4MzYveGJnUExyWDM4?=
 =?utf-8?B?SXljaWhmSTJlRzgxeHZTdkFObXBhRHRWc3p0NEJkdVB2ZWtYSEw5SGhwN0Fx?=
 =?utf-8?B?VXFWdHpSOGhGVmVVOEpxWmNyR0tuYllxYXFGSW5RM2FhRENtUUQ3eTVmVE9N?=
 =?utf-8?B?NVNHSkdldWg4N0FLWEJkVzd4VFpiQmNnYUwxRzF2c2l5ZTNOdG9GNXlXUER2?=
 =?utf-8?B?SU9pREtFWFh2bVoweksvcXVTWk9PTUp2M3crczhuTklzMU80aWU2QUlOWVpn?=
 =?utf-8?B?MXhvME4zTlZHYThTaXhvUjZ6ZkxTc2ptSnlzWUwwQlhDNk43OXNHL0lGQ3JM?=
 =?utf-8?B?SndHc1A5Ym1kS09FSTFhVk9PcFExbXN2R2l4QXRocktwNStnRThMaFlURjV2?=
 =?utf-8?B?amQ3N2NSd3lhT3IrOVo4cG03b0lFT2wwSEdUYzA2dWxGQ015WU1ocS9WeWlN?=
 =?utf-8?B?R3hpNlVPV2dudEVtT080ZGIyK09VVkd6bnMwaTJkZWZvUlp4MVVzcDBaUzl5?=
 =?utf-8?B?MlZLcDA2ZCs1by9FTEtKT21nb3pzZmZkdHJzWFRqZWUwbThxL1htTnFHV2VM?=
 =?utf-8?B?QTUzUEZjYlVpMEhqRzNHOVV6c0RLd2U3RkdYMWFFYWRscEszMmJNK2Z2ZFk1?=
 =?utf-8?B?ZG8zbUVrL2NCamFidUJHQ2FvS294eDFUYVpTKzBTNytDVWlnemZpZWZ0OWpO?=
 =?utf-8?B?WFpwNlNzNitMYUtWNURtM1RGSUwrTjN1MytDMVR6SHQyc3VCL0lWeHdmMWNm?=
 =?utf-8?B?bmJQQThMODB6Q3dGY3dqYVVWcFlTTEk3Ky9BZjNlMGNWOGliZmNhVUlmUlRj?=
 =?utf-8?B?NEJPcXZHMkY2Y3U3eHhZVDk0WjdVWEo3b2M4cE9KSEd2QWlaOWc0enJhMmh4?=
 =?utf-8?B?WDlYcDJvTzE5QzBwVEU2bUNhclVXMUdHTFVxTzZ5TDBuYW51Q0pCbHRpeGNM?=
 =?utf-8?B?eGJDVTlxRXI4NGFrM2F6eHphV3VraGFDaE1lc3hHazBCNmo2SWdKSVFFWGN5?=
 =?utf-8?B?K2x1Z0FpUXhTQnBmVEpDbndLdUlEUVFYOVV5VHNxQjlxamQzS1Bndk52SWc2?=
 =?utf-8?B?NTkyTE1rSXJPZC9TTmNteGFmUXpYNXlCS3hjekw1SnU1MHUrd2lQTE82bUow?=
 =?utf-8?B?dlQ5cFJPNmYvQm5ZV3pUTGptU3BuVEt6dUluNXdRS09TckEzck9lbTluV3Qv?=
 =?utf-8?B?SDVYc0Q2QU4vYU1WT2MzV3lYeTJsY0t1UnNTRStjVE9TTFBGZWhXNTV4UnhM?=
 =?utf-8?B?LzlzRkZtNGYyZDRRQm1NRGdOT0VUcVh0MnQ4bzBLbEFUelp1N0ZWS1Vvd2Q5?=
 =?utf-8?B?K2phNjQraWJpRHQycitvVmdqd1o1aHN1VVE2TytvYTg5bXI1dHg5ZlI5Njkx?=
 =?utf-8?B?U3pyZEtRckUwU29aV2JHTUxVdGlwQ1pad0VaWjdWMmNVV3Q1WlZlRlRLQmhO?=
 =?utf-8?B?aHRXYWExMmRRMlQ2SmxsL2E4NHZsb2VUdmJBeXpKY3l5Q0s2Z3dzR3lRcXlU?=
 =?utf-8?B?b2RJcGI3bEcxMWVCQlo2OUxPUnRDT1E0YzJWbWNXeC9nSG1xQUhjVHlCOWVw?=
 =?utf-8?B?VUlHNGJBeGo0UGQxK1BueCs2a3BhalpxYUxlTEhBZXRaa1lEVUZKN2d2b3Fy?=
 =?utf-8?B?S0JhenpyVHJRYm5QNk9aK2NLZEF0bFVyOTRFNjdWRXFsMkxYU3A1L2VxQVFP?=
 =?utf-8?B?UzZqNElOQS9ISlFkSkp3cUJEM1FyOERrOFpvcW5qRk9ZRjhmejFvaGllVFlp?=
 =?utf-8?B?djdlWFZZajRmaW5sckRhVG8zUldOODN3OW0xZ3RDRVBQeGQwTzhMVCtuVGFz?=
 =?utf-8?B?Mitpcm4xUlorNFhPNzZELzlDUUFua09RQzdOSXR3dzJxdDgwRk1VZXJmRWxY?=
 =?utf-8?B?OU5wVGhHWWtWdVdmQWgvOXJ2VDU3MHI5L3ZBSGF2cTVSOXRSWG9SSVJ5R0s0?=
 =?utf-8?B?bFpRL1VQU1BWUFhxYUJsMGNmRVgvRHN4a0tuWSt1SUpva0tVZ1IyelBGZ05k?=
 =?utf-8?B?bm1aOStJelFDemVTSytSc0FMdFhWVkoyT0Q3dFZKdlYwOEhxZmhxcm5OV2Jj?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OaalVySRvRNJyPzNsse4vDZLqXpcEaFnpXSMJV2LAOelZEewibKEtXP0ZJJ7U4d/xJ/HkvX1/+lGzAV/yWMNonEKZpw5f0FrhjmS596COIurqqTOSriIfsYMgnUIQKHggti9rQt5D6FJEmwBUhs4aMHayXy5x1KbC+Ad4P24PZdbqP6Qxh4qXaZ9zUQP2Cj4pEQSwxp0e14DsXZd5eGLMPd4XmYidBtkj4Y9/4yB0LyTjaLpbh3pJsyOeULtxjUPKEHucX5e9+36FzytrpQyddxwGIxANO4Qv6nUSetouj/4KeAMDhb+M3KBOnOPFLHR97Tlxr2ESKqXpskIBW7uDKHYRh/6GXA8JGAkKCcTUngRzec2LKZp9X9UollbHfssyS2v0K+2tJmFpbmmvdPQGnkDdDmq8HfG/duTgAaYD53yDmSNjR4OIwi3n++uUZeXN08XPQMoM+EzLbUq8xZ9YOnf2binKhQZSN+3Y86Be9UQ0Lzd2HmJEzYankMu3QocXC1s4iblUNaUBBQHxH0HF/E1NX+0kGtkdioEXRS/klQPVRsyMdRt0D7dpT8wQC9LxqJn4A8Jqc1EaGjW6OSkYFCtfYHvQOL5H7ylNO6dkD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35f6b81-770c-4350-f05c-08ddb002fcd7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:01:43.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rLTqCMnS7PPXT0/26EexKVKytwJW523GtrBFlL/zZMBXD6EnX5b/9fCWL9lg1eLhRzNbKPID0xYw9u0Z/4/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA5OSBTYWx0ZWRfX1BNqdSDjbp1X CBkaW+bDxZzEb8BCFRRUg04yrJG6ywm22ZxXzV/C0Wz5KZI/KKmcjtqJZoK6cvheB8Yai37PC6X RN8rEtJxCQQiyyJjfVhvmiIlDS/8pGWfyVBD3p33w8m+Dr8bG08jCfXW8C1J1peaWd1GoYFnjb8
 FeFw+PKG8dBOnG+CbJ5YErKSoHCNwxVOQladw1xeOnBGLLR42XjcHiGFl2JreVqImokZG5aToUb V9M6YFiQ9PUY56RnAAcRnPtaybY5sGcVuymnt3JpEv02xy/TpgymTo6J4mtUK7fylVxHgNt7fLo cMSxNIOpCaV6r5Ae/Ns0NSRVOPPD/ky8ybMMZck6Hjh19NKiz/uy/c5d51kjdL5oYepjeNsWLo/
 0KrL1Y/w14tVxEAH5GX6FvWcGMPS8vgOmQZ36RgzqdTFjdKWUajaK3EhO3K3NFki1L0QG3tK
X-Proofpoint-GUID: -Hn3MPgLOyiUMC9EVMJQbhDRCLPK4JXK
X-Proofpoint-ORIG-GUID: -Hn3MPgLOyiUMC9EVMJQbhDRCLPK4JXK
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=685569d0 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=8MPOSyiBK8c-pv_oC2AA:9 a=QEXdDO2ut3YA:10

On 13/06/2025 06:37, Ojaswin Mujoo wrote:
> On Thu, Jun 12, 2025 at 11:26:17AM +0100, John Garry wrote:
>> On 11/06/2025 10:34, Ojaswin Mujoo wrote:
>>> From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
>>>
>>> Brute force all possible blocksize clustersize combination on a bigalloc
>>> filesystem for stressing atomic write using fio data crc verifier. We run
>>> multiple threads in parallel with each job writing to its own file. The
>>> parallel jobs running on a constrained filesystem size ensure that we stress
>>> the ext4 allocator to allocate contiguous extents.
>>>
>>> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
>>> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
>>
>> RWF_ATOMIC does not guarantee that racing atomic writes and reads are
>> serialised. That is what you are testing here, right?
>>
>> NVMe and SCSI do guarantee this (serialisation). However, reads in the block
>> layer may be split into multiple requests, even though unlikely.
> 
> Hey John,
> 
> We are not really testing the serialization here
> (verify_write_sequence=0) but rather that multiple threads atomically
> writing to the same file should never tear the write.
> 
> In the test, for each job, multiple threads are doing the write on the
> same file with the same iosize so they should always overwrite each
> other completely.  The verifier then ensures that the whole iosize chunk
> written matches the checksum, which will only happen if the write is not
> torn. That way we are able to ensure that even with multiple threads
> writing the same ranges, we don't break the writes (the sequence doesn't
> matter as long as it is not breaking)

So the threads are overwriting the same data range, right?

If so, as an experiment, try setting /sys/block/DEV/queue/max_sectors_kb 
lower than the bsize and see what happens...

Thanks,
John
