Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA48460
	for <fstests@vger.kernel.org>; Fri, 27 Jun 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032634; cv=fail; b=cf7/dnc/QiDhrnT0eH9pcSzpgzxS0MATbyP/5FW2z0NF0kyK7lm/ntY4STMJDQNvaIDEvW8o606sqFG9tK7cGq7i+Fw165KoJgzm6u3Ob8oZJrc1AGC8rgkv6bcU9EV9d7uJzIqEuq1cef342qhrJiI+QrG1CSv8nxM232d0/Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032634; c=relaxed/simple;
	bh=WfW8p8gxA53JSfU6oppvxSjYsNeJ9EXx/xk1gXJoJQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAd5fC1wwp/s6uUQW7PBMGCTenso4mwskngBLl79eC50QCrF8LjNhR2SmMwA2Gv5iasNW2ke3aPJL+BEQvPOBpTYNy1NT9Iq2TG3YfkiOoIQybpTUCIHh/m66pBmieKqCgb6ncTChsA0DfO4N0sieIhsMXON27TGW7011Yeo9i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lyFLWfMS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gq92qCfO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lyFLWfMS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gq92qCfO"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RAcfcm015255;
	Fri, 27 Jun 2025 13:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HD3J0vv3GcalEcBHe+bJhtzvTy8Yu1BNX93BPWh+W90=; b=
	lyFLWfMSY78jOzryhbXnXvqgLJWDZiH40aPHLjtrj2so9m/jNvj0hOkbyVfBCHW5
	c0pBJhbsU2d+MZxYJF0u4mJNnAY5/0gX8ZJGizfpzOahTqqNeeR3SCLbR+EYoE0j
	per4bCEJm5wLbbZ31PouQ9nwEo4en4pMcfafHl+n/675v8kkT7dmjTQpJFvcl2Bz
	2WPo9gGjz0fCPwR/s90Ll3Zr0s8/dXklNv8LCj6YF71dR6n01dOmZ5h6AlT+rBNZ
	ZtgIXNTMovi3PQp8K7ZkSinPXN8iOkhlfCM1Da9blsMmhWsBHCveo0eMcRbgvTzJ
	eQqOEC3G44QiLe5K36K2vQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5twse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 13:56:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCSw8l013330;
	Fri, 27 Jun 2025 13:56:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr8uvwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 13:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mktQvLdBpwiahewWOBylywbpu6Kn5/rQdscuqRajEvX4K5vmw9f845aIqIr4bfB5bf0f9r3bMhi8Y+YHlf3L/nX5NeP8acAVe8W69yOCUD30+hNvdy9vGezn/kmtzlUN+Ea49IkXnnXoV/l55dMli+/gCIduXiPkX9yeWtB2/u2xZG1PSnJP6TzL3TkIjqIigPmvsFLRuwgb+zVjuvdPNug1YXo2hlDL93gDAGlLuXHiq824SOgHTxn/305xwWj3JpUcnoBBPfzIlAfVeOSvV4odCYUpKAHwzsUwiFpHPdVIjYCBngpOog42/Ra1N4tGDzjYsFbf8JzygKzVeFVObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD3J0vv3GcalEcBHe+bJhtzvTy8Yu1BNX93BPWh+W90=;
 b=kPaBbHMblkx9fuuMMoW95rUMMzXcELhfReK7Ujg3g5RifmPzStOs1Prpy9/5mlqson0fE0s1v8qt1Y4E5uJhHkdmoP7mYdkohIPZtcT3TXyRYeBr2LtnZyJIaiSysATCBVvpKNSqIWHu2i/o0DSV5NQrUqcGPa3dwNVxPZkcNhu1caW0u0mMWp7mF8Ejeb/0HrsoeaPecdEni6DOK/Z4+JRrPfiFV+poI00vV/tF1bVbHhu5Jl7hKwFfJzCanlpDpUJU14JDF38nuYSNCoY8vRgC4d9ZDV+L2a7QxrWexQEhCi1uvx6tYYY9FjMZIxPgcMtbajq80qu3wI6r/Eg98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD3J0vv3GcalEcBHe+bJhtzvTy8Yu1BNX93BPWh+W90=;
 b=Gq92qCfOtyB2lOvgH6/YYT4C9x3ZH4wZdZSQDFvoeHXBxNNWWs+4BlLYjCEPjxxRazx3g9mchCwyVmoweEz3dhBiicUOH2LRYDzf9nAM50NuziIL8Ylp3K07V57VvzaLjJshZC4Mjw//gL0t5g+Btq3Cn11k+vN0VWGPtzL7+I8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CYYPR10MB7608.namprd10.prod.outlook.com (2603:10b6:930:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 13:56:48 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 13:56:48 +0000
Message-ID: <b02d0e4a-000c-4bc4-8cb3-0fb9a0ebfd4c@oracle.com>
Date: Fri, 27 Jun 2025 14:56:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Add more tests for multi fs block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1750924903.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::16) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CYYPR10MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aefaf77-d005-42f0-9b62-08ddb5827595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVJCWjI4QSsyYWlGYkdqK0k5dHBYdnQwN1lkcVlidStoTGNxaFdRbjNNb2xX?=
 =?utf-8?B?THJwUWJHdDdaa0hPVkIrQzd0d0VhaDdQb0lONktjVUVmYmdzTmM5Tm1iTFB3?=
 =?utf-8?B?Y0tvMERCUGVyODI0VXRXMzF2WVRTdHlLcVR4ZUZEbURaMElXVFlJeWdYdmdu?=
 =?utf-8?B?eEs3aS8rSk9HdDFaVGlIdTdyT2lJQmZMK01meHgyYUxHVzJnM2xJemdZY09W?=
 =?utf-8?B?ZS95cVlSVDREQURDaTdvVXZodGxOVlhjVkdRbkt1eW9tUDQ0b2l1Tzg4UFhZ?=
 =?utf-8?B?NlcwcU40OEFrK1M4WXM5bkZWdmJqVjNUOFczQm8xeUdlemVJcFYyMkw2Y2dK?=
 =?utf-8?B?TWxZVG42YlZmdGMzQmJvZm1MUkN5M2ZYUVB0SEQ1dXVHc0hxc3dnQ3RhMGNJ?=
 =?utf-8?B?TmZRSjZsbjd4Szg3bURnY2lXRlk5cmoxY1ZySFQ4RTZ5RytIODltZ0lXb1Yr?=
 =?utf-8?B?MldMYUpDbWY3QXExZDBLTGx0V1M4d1IyTTNKWG9SVkNNdDE0QWhpYkwzWmpt?=
 =?utf-8?B?NlFxOUwrb1ZIeXlxdTVvaHdYVitXRWhEeVhBbUlpbnF4TDZ5M3kzUWR3dzZr?=
 =?utf-8?B?RUx6akZjdmR2VmNQcTh4NnQ5VFNhOTZsNm9ydlZFL2oxY2ZqdS82YkNEclRS?=
 =?utf-8?B?YlVxOGFXUmF2ZWJaa3NWNUJBZUtwbEJxZ3UyZi9ubDRDK05QODhvTU05a2Rx?=
 =?utf-8?B?MFhjOURqL2ZZZUk3ZlVrRWNMdzNLOVpFTXM2dHVZbFd5UHc4RU85cGVwVEVW?=
 =?utf-8?B?UlhYYWI2QzhHZnVrbjczZVIya1NpRU52U08xMk9DbXV3VkdaR2dDbjIvdHhV?=
 =?utf-8?B?ei9Zcm9LVkRSWjVzNkpJMUpWYnhNV2JRUnNDaXBlR3JIVjdSTktrV1ZPL1Rj?=
 =?utf-8?B?dDBidXVRUk9wc0YvL1dJQThwUUNENHhkeXdTYWVVNVNoQUVlVlFSNWoxVGt1?=
 =?utf-8?B?cjBneGRORzU1Y1dmazM2ZDhReFRPbFVCcHM5WVdwOWhmOHlXaHRFUVNVSkZE?=
 =?utf-8?B?YUNRYk1TZ0V2dVptMHN4OWhaT1NtWHdpL2V4S3NQWW5TVmxYTUI1OENHQmNG?=
 =?utf-8?B?cnE0ZjFCRVJtSU1FWmYwZ0ZNQkk4SnF4RjdrRVFEaEtDNjFoZzJyQlg5RktE?=
 =?utf-8?B?YTRIbWorYldxVEQxU3JPUGYwLzdMbVVtTFdNZ2QyS3NGVnRPbFVaZDE4dldD?=
 =?utf-8?B?bnY0aE5Od0dvUWpEbWM1b2Fac3c5aXk1WDhDRDhZNEx2Nm5rbW00eEdCTTJG?=
 =?utf-8?B?TDg5Q1lJazlZWHNIQk5hRWphN3lxVGdvb1BTU1VuOERIb280Wmh3aTlKaURY?=
 =?utf-8?B?dlIxcmVFODlGK1d0QTRoeVFxVHJ1R0Zuakdua1JvM3V3NklSQ3BxZHM0WDl6?=
 =?utf-8?B?Q2VnRWVMVlZWVTRiSmhJS1cwVDRKUTdZYlNhbWdUenFvcSs5cHlLNEx1QWQ4?=
 =?utf-8?B?akIwOTMzVEk0WGNXMmkzdDdXcjBVZDBqRHhCS2hFZWsvTWs3elJEa2Qwb25L?=
 =?utf-8?B?SHhKNENWalBwT3BiRzFyL2ZFMmd1RVhiSnFpekVIVm95Njgyc0ZpQm5EeHFr?=
 =?utf-8?B?a3JaK0pUb1kyNUZ4UXZmbWN4YVJCWUU5Y1Q5ZnFKU2I3NW1MU2EveUQxQVVT?=
 =?utf-8?B?WWd5UHFWOHlNbHNRT3MwbWVyNTRlaXlZakkrUnBEQy9nU3hhM2pXYmhpYXZI?=
 =?utf-8?B?K2N5M2xYbzhJbmpVKzAxN0ZxVDNUT0NxTGhqbm9pdXc3VFFyOHZDdXlJN21o?=
 =?utf-8?B?R1p3RFQ5K1kyOGtLNjlETlFKZWZ2YitHMWxqOHRETWlRTkgrZDd6cThPSWRU?=
 =?utf-8?Q?hesZOzxCEMzTyYBRoyxkztgONjhP89TzzGMEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2g2UmFGMUMrNmNiMmlEZDR3aEhQNCtIUTFlUzNnVjFySTU0WUJ6UlB4QzhW?=
 =?utf-8?B?YXR5YWJwaEl3SjFkd3hYNCtralZYdFJ6djNSdkM3eW53MVdBM0hyelhsZ1dI?=
 =?utf-8?B?eE9pT3hQSVhHVkwxbno3Nk9YLzRqeWlZSEk1bVM0dE5Ea3ZwWmlFTU5jQmVH?=
 =?utf-8?B?U1A3TnFHTXNwZGMyK0lBZ2d0bjN0ckpnRmMxNC82Y3JVamVOUWFIcVBFcnNB?=
 =?utf-8?B?cnlBeEhDQ2xtMkYxNkxmVlFMQ3ByTEN6RytOczY4MXgyS01oS3BZeGxpc1o4?=
 =?utf-8?B?cjR6WjdSOHkxZ3lreURqdHo3WnRSeHRTbFdxUWJqa1k2MlIzbXlTV0FZU3l1?=
 =?utf-8?B?SzZiUWNUcEZtUkk4UzhUWXlEMG9KVmNyUnRrc1o1S3djbzJSMXYzY2Z4L0l4?=
 =?utf-8?B?dDJFTmxRek8vYTlGVDJXeGN2WVl2dUJ0WlJWVmc2MEJPYlFsVGwwR0szYjRJ?=
 =?utf-8?B?M2RjMnBWWkNZZlNVSjNaU3Rvdit4OXkyTjBPbXg4aFZyUk9heXduWjNmWDVB?=
 =?utf-8?B?aHJKRWJieFEzTEFlNllNNGUxN21IREhvd1J3MUc0RDdHd0FadW5VWUtCbGpa?=
 =?utf-8?B?cktqQ1lXbTlLM1Fac2pmL1NSOUU1dDNsZG9aL0FyeG13ZGdYdFRUTWt4MC92?=
 =?utf-8?B?ek4zT2dmU3RZZmNKclFmMEtxbWRwN2ZCa0VuY3NGbXBocjlURGpnN2l5QU0x?=
 =?utf-8?B?Y0pPQ2tXUXdmQUZjTkNQYkl6QlBaYUt0UlhqNFo2d2tQNkZNcjBaZGZBbUhB?=
 =?utf-8?B?Tm9PWDdsaW5kc2Y3RkIxeXZBS0VLUjh3ajNmalpkUHFGSWZiaTlrVW5LcDFz?=
 =?utf-8?B?RkFvVUxhMmZBcDA4R2tuZUNDZ3VXZ1h3M3pETW1DcWoya1crd2dVRC9mYjVw?=
 =?utf-8?B?UFJaVm1uemtiRHhTQnBUb3Y0S2dBaEt2YzVlaE44cnVKbzUvWXFUbUN6dkhr?=
 =?utf-8?B?UDNpajgzT3I2NWN0cGhBTlYreGtsNFVMMXZQRnlhWWxvY1RTcWtraWxuS1BX?=
 =?utf-8?B?QnZzNTlRVkZtRnlvVHNzNXRQaFU3Z1NHaWdEWlh5VTJqbUtma0RXbUQ5Sk9X?=
 =?utf-8?B?NG9FcTNQa2piN1ovL3lzQ0dPNm1OV1ZBUGFtRnhHejc4RlhlWDhEU29BaXkw?=
 =?utf-8?B?YkMwdEtEM2FIMjFmYXNMeDV1Y2UwTGxnZlJTQnVQWWcxV1E2V2FXa1F3aUE4?=
 =?utf-8?B?Z0tXeVNsTjZyUWd4bXJRSHBtUVZ2VG16Y3hQYXhnME5OaUhnY3NpWG5mZ29B?=
 =?utf-8?B?Rkd4TmR1Q1FLOENwRTRrVVNWbXcvdFY2Z0NhQXJVQWp3dFBWUXdLQ29aWEVW?=
 =?utf-8?B?ODF4TmRkYVd4Q2hJbmMwd3kwUkhPODAxNlkzQnA0WnlvVmtqRlU1cWVUODhV?=
 =?utf-8?B?Y2diVmhZaDdyYWhRblgrcjRGNjczWi9sTitoS0hHeThZNnN3UzVqdGE1cno0?=
 =?utf-8?B?bW9EcVo1QmV1K2tQdkp1OWVNNjcycyt6TTdrMGxRdGx6Ty9BTjZNMVRLNFQ0?=
 =?utf-8?B?WkVMa01FaXE0clFrSTJCTkE5VlhGRStYRW9HVWZkS2ZMR0VkTk94dTE4Uks4?=
 =?utf-8?B?Y0gvWE0xNlpHMXp1WG5SaFREMitweEVYTk41bTdOOEplSnJIY29qTG00MERZ?=
 =?utf-8?B?OGZJNFpVSEhrdWhSZDg5UkZVbFNRaVRvVjJucGFRL0JFSi9ja25OZjlpUCtV?=
 =?utf-8?B?ak1WeEE1bzVuMWg5YWpRYWZJNVBxeTlET0h4ckhpTk1pRDFWQnBKMmZyTWd2?=
 =?utf-8?B?VVJLNi9xU2JDYkpJVVBMcmdsa3ZyUk1mSlQzbGo2UjJRQU4xZzd1TG5JUFZN?=
 =?utf-8?B?U0doYmQ3WkJTREtIOHBIQjljTnpXWS9uY0Q2NUtxMmF5NEZaZ0kwK3hUdTBU?=
 =?utf-8?B?RGhpS1RndzVSOXNLSUpsV3Zhd2JiaXNFc29zTlMxRzY2RlFGOC9RcFdwRFQ4?=
 =?utf-8?B?bGJFeHgyUVJDZzZoTkhRQ1ZBVVg4dDBVMUc1b0krcGJwYnZxU3NiSFphNC9V?=
 =?utf-8?B?UWlQNElyN3dBT1RnKzUxTXMxQkdZQ1FSdlYwUDFObzMwbWd1R2VGL1draU9v?=
 =?utf-8?B?c1ZmVHVsTHZnbklnK1J1THpjRUxCbElLTUVJQlQ2ZEtQcFFxcXJ5V1M3bVJp?=
 =?utf-8?Q?Z5bn7oRhZhqgCcIYHGhvk8hY4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XP9QZ6o4qAB8M+Is12LbplqPDdp7z/LCIQSEWMVef2NmHRBwOefVpBdl9YE3pGhKCZMAwd3/tdBzq5eVD3SeB1tlku0LO8P1g91SRhMgA9ReOoPkTtu+OiIF8xza3FWdF7OA+mh3MiKrst6Kasx+RkTjhRRAXKuUEpDV2Jhiyh9VWuFBHknU7E7CiwqPvPKCt2cGLCU0Oxnr9JKSlMoBgOydOtyVKy2B/p1llbkxCLaHdQTSWR+iQ5cyELB+RxjYmfsZWPCsS5jSRG17x1H4bAjv4Zv/i1cNE41X1DdlrlNtjd/uWMvT1TZIcimn2XNmgjgjikf8l86UrIy9Tx6qjpN2CUxiNpaXx9+gwKWdZ46Dgbtr6AvU2tD//svktrrqFtpkYRpHOWHFT5DcCfj6Y6fguQvFpb0mFeWQuwSHkNks7qpdwz0EUYAFjs/vFTBs6CoGhr7YlL5T6F6KGlgsOyGhV68c5N00gqioCrEipt+O/X4YJvwUZ0MX/qyeju/JsJr0err3Rtk2mKIfUyYLf7WJxnGH2HrjnQTIqG/sedrdTw5kr4k2kF18Zy0EkPIVUwujPicZ3p2KboHVo7O8/h53d6ny5qkeEGukcETwbmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aefaf77-d005-42f0-9b62-08ddb5827595
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:56:48.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk6WGj1zWaYpzeOelqqV0xJ8GO+oRSuVKYcwf/C3cjMEmzqcuvECpGi1iEjYJARofubUxm0aTfuOop7tw21LsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270114
X-Proofpoint-GUID: K3kb2hMiw__W2IVvnQWfVfgG4fcyi7u7
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685ea322 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QMmSU9bJqqoXqnJKtpAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDExNSBTYWx0ZWRfXx5+aPK23mUXo xSV2QWSEUb6tFqxghuQ6N95lrTrpd2EDIj5ijeHLTxI20MWvmX4ezdRYHFwbn9MqUQLB1Q3Tft0 0dcZwCzNIdNIlDcfxtUbN5WEMWVCZnG2wW8FfW8lq38TO2qpsPuiA2VfFa0032/sI2SRA/xZ3ub
 fDir8vfKEpRLnMQV+eH6BkK35aaNT99PZoiDPMmU4Wgp/SEeGDjGCUxnyxedLJHVvRBXZ4d2J0S KoIt/KAKB1y6Mgcz2BT0oBTheDQcLyLMB04YEEyAWxPWtgxSBdiozbqiZiKmCyzHpjlga25B+fv V9YT6rB+gkyVuKirdaq4FFhA8tjQO5MHejw8znMfkP9Jf8xRblEsfvvg9wIGtkCFuQg+OK2v06U
 MOTFgXXvs8YaqPqMg+Ap5mijg84UqYp/ut3WsmXra33Hxxh0R6o+sInzxAosEwUiliEzrTFu
X-Proofpoint-ORIG-GUID: K3kb2hMiw__W2IVvnQWfVfgG4fcyi7u7

On 26/06/2025 12:58, Ojaswin Mujoo wrote:
> Changes:

A small request:

please cc linux-xfs and linux-ext4 lists for these patches in future

thanks

> 
> - (1/13) new patch with _min and _max helpers
> - (2/13) remove setup_fs_options and add fsx specifc helper
> - (4/13) skip atomic write instead of falling back to normal write (fsx)
> - (4/13) make atomic write default on instead of default off (fsx)
> - (5,6/13) refactor and cleanup fio tests
> - (7/13) refactored common code
> - (8/13) dont ignore mmap writes for fsx with atomic writes
> - (9/13) use od instead of xxd. handle cleanup of bg threads in _cleanup()
> - (10-13/13) minor refactors
> - change all tests use _fail for better consistency
> - use higher tests numbers for easier merging
> 
> Link to rfc:https://urldefense.com/v3/__https://lore.kernel.org/fstests/ 
> cover.1749629233.git.ojaswin@linux.ibm.com/__;!!ACWV5N9M2RV99hQ! 
> J14tJ2AlGzQmxs408RVEDMmyt2ePPukro0IrPiuxMGEaq1wFgSfj91M8FQypI- 
> MM18b01NTxCQl8GLPSKwWNBQ$ 
> 
> PS: I'm on vacation till next week so there might be a delay in response
> 
> Ojaswin Mujoo (9):
>    common/rc: Add _min() and _max() helpers
>    common/rc: Fix fsx for ext4 with bigalloc
>    common/rc: Add a helper to run fsx on a given file
>    ltp/fsx.c: Add atomic writes support to fsx
>    generic/1228: Add atomic write multi-fsblock O_[D]SYNC tests
>    generic/1229: Stress fsx with atomic writes enabled
>    generic/1230: Add sudden shutdown tests for multi block atomic writes
>    ext4/063: Atomic write test for extent split across leaf nodes
>    ext4/064: Add atomic write tests for journal credit calculation

