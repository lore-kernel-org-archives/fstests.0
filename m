Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EB288524
	for <fstests@vger.kernel.org>; Fri, 11 Jul 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231104; cv=fail; b=OnMpJSajtpRtFw2zma+9qt2MBY3eTHcrzPnUz2V1GEQexN09GxeukCeQxHBCse9oDOuOZ96z1T8w8vORjaOE6iNhqWiYyWiaoa3HeQ04FFjYGjKbEsIslflSuLhpOycx3SMcwbbcwfFQqsQqhvkNW1T9u7FN+d6MXFtykAjZeZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231104; c=relaxed/simple;
	bh=msMTrXgifrxA1o83dRTdZhJweTFDgK7mmzdZSEwz8lQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CyvKEcmL4Np+v309fTT/vwpMqdxqQXQ0cTziGItiQkXTAjham9IdbVozY5lTD4fluLL0ABo8B552GtrcEHNdiK22OyfoP8KN6QZepGLwx/FZb4PDEJ9PN8nqLoC+gnLEYq5psE6KGif53kpWK1vonCRsvTG67R4ArzAYx3rHKVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=erwjuYOR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yyVuY2az; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="erwjuYOR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yyVuY2az"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAM3k0009228;
	Fri, 11 Jul 2025 10:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vwSvFkcrYZIuaYz8mOMT78CYBtJpBCrfFwL1ZP4JviA=; b=
	erwjuYORNV2nBfaNPLxB/Qhnv3HP69K6xSQ4DsqDCf8DmISlvmZ7oTfcUhX3Ah9B
	BSTOp5jnr8AJlr8xe6EWCHaZrDi/0Xc1qXCSIrdLaiXUIIXvAfaKwX3fSCLPn5WV
	4yLreUPl+ya4HMN/f9IaDAK8nzp9P02hK2J/rk/BxfHK8TR6SUFtwLMo+GUjQTDC
	4KAGPz8hGRKgMl1oelN1wy+fGXJlbg1x4SLBb2oFTXFpXTfcDBihQWBuuqSY88s1
	RVco9BebhrYW3ZJ3OHV0LHoCCTyW/sfpxJYooDMWpdAYeIiQIepnWPhhBMKmiXD9
	hmju52AzSQp4qQ6Ml68ffg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u0svr1jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 10:51:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAAZ9D027434;
	Fri, 11 Jul 2025 10:51:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgddrux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 10:51:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxaOsi2uEKbmGmGL1kL4t33J8T9kBIUC7ALtsEb1/tQ4hVsDxy3J+VhMQtSStDj6gaZwt61o19rH6KC+e+23oHeNTroZCfqCZ9cNSGWSqtgFnCjf9SJ4szX3CSMmUAkxlJ/A207nM5SFlJtNINzP2ZQOu7VvWAve4nf1QUD+0+PoZv8NZN6T2hdDw2Iyv9azco6qAUlCppPiBe/WNnuhKrKlLMG6oe6FyIoydMSlcqFjuSlyPys3veYEvy7JLjXPfaU2lUTriTbWAJoy+pUrMaSnU3hJ/MQWVMRhUG94R+kZ68MepNG8D8ah1a5hX4+Paxf4ExtBlM+PD9nQQlSPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwSvFkcrYZIuaYz8mOMT78CYBtJpBCrfFwL1ZP4JviA=;
 b=xgp7sAOzTJ/fAL+a8isqd/RxHph2I/oyfD3ApIIqnAjze2cjIIhf62KrgdPcZ/ZJVCkIiqo9KyWqwOB6kezOo8UFjPcsJmyAImD8oVMhEh9nc8ozftuudxzn+CZv5jy/ueNJd/5lMnMTi/LccR4DAdT52nJpq3uEds+uZ9Ho7hFB2dA1eOO4le0/rHqfcTeTFZg5mHQpAETrVbo244mHKEv/LQVCiks4ALmUkGGMF40b6jrCn+iaUDlRafXbRFqK67EzlE7GrpEt4/Ilu1QQfrQa/ztdrRnzf2zFy3gGuEN8KZ28r39y5D5r9BRLaUQYCVVDWClk8u2j7jT/eWqgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwSvFkcrYZIuaYz8mOMT78CYBtJpBCrfFwL1ZP4JviA=;
 b=yyVuY2azb81M/R6tKv/WDIplkMRObojHP5fEWp9tzwCB/6fKKAQyZKVAGyYD4dMZLgSJTr2GHh0AGSlaCRv4n6johyH7cpnChNq3HAchDaGw579tQ4h9n5PmFDVar5AuuN+nn+CI2353QocxL4Cy3mURA2nYd6tfyDJ2wquMhCM=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ1PR10MB5956.namprd10.prod.outlook.com (2603:10b6:a03:489::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 10:51:30 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 10:51:30 +0000
Message-ID: <fe11712b-fff7-4d3e-af37-7f5f2a96cb40@oracle.com>
Date: Fri, 11 Jul 2025 11:51:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
References: <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
 <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
 <aG0IsTJ88ia4TWmn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2678a0c0-e075-41dc-aad5-3191703c7359@oracle.com>
 <aHDaoiuxxTuI_9uS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aHDaoiuxxTuI_9uS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::23) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ1PR10MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: a600cb34-a8d8-4795-b040-08ddc068e485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVR0RE1peXlqd0RvYmtFMGdQczlQNTRZN0Z6aFl1eDU3V1MvbmVnYS9LazRr?=
 =?utf-8?B?U0o1a09Ka0RvLzAxZ3ZzOVBSZm50Zm5PMzltS1orSTZyYjlNQlk4bm5JSWh2?=
 =?utf-8?B?TGhYaTZkZWtJdWl3TFJ3N3RmMDJqa1FVdUNKT3RtNDRXTmw1cmc5VnNoWmp2?=
 =?utf-8?B?cGg1VHlOdEtLQmRJTHFnNGpSQitFdDhUeEs3WDNGRjhiTE1QOWl2L0JRV3dp?=
 =?utf-8?B?cFZVbHFLZFFkQmluUVAxdXY2ZHpxcXlMUXp6RnhSSXptSEd2anZ6YmUwaTI5?=
 =?utf-8?B?U014WWZ4djNTeDVGUjdLYVkzRE5rd1cvYm81ZGlRbTY0WUpobnQ1SENac0hY?=
 =?utf-8?B?U21EY2hMUU5maUYyWFNSWDJFUEJUZzNMUEtleTV2UDhlZEJOMXpyeEpZS1I0?=
 =?utf-8?B?WS8wSDYxYTlRbXM0MEJYWW9iaWpWdmF3YUVUbHEwRDBHbm44cmxYZW85aXVt?=
 =?utf-8?B?dHFiWU5tLzJrNW9iTDB3aDQ5eWh3eEQrSDJDZExwcmpYSWFMcUdaWFlOdHBH?=
 =?utf-8?B?SC92YTQ4SUxNU2xJRjdhRTR0N2V0VU9sZTBzc1dxZkFnditqMXlWS1JCS1Ar?=
 =?utf-8?B?aE1vaTFWQmNNM214b0xBRE9iN1I3VHJweW5lYm1GbzNwODMyRjAvSlN3RnhJ?=
 =?utf-8?B?aWZIS3hVTXREZnBRc0F4eDZXZHdEa3lBSGZJSi8xQ3JHd1JocTNGQVFwOC83?=
 =?utf-8?B?TWdHTFJlYktDUis3ZFo3aC9xa211V05Nb2ZPSDFmNUhJY1h6VlBtV0lTSWc0?=
 =?utf-8?B?WXZxbzdHZ0NPSlZlVjdXNmQvSGljbGtlY0NQOFlCb1BEYkpseXFLcDlhZjBT?=
 =?utf-8?B?ODV1dy8zWVNDZTlDZEU5c1YzM0ZXMHJ6NSs2Rm1kY0t3cWFCTThDbGloL3dr?=
 =?utf-8?B?dFQ4WVpqZG4yRjU5VktaRGtvQnZ1bXpsNnRvb2dNSTUrczNidnAyWVpGWFYw?=
 =?utf-8?B?VFYzb2ZWZVF1ZmdzZ01FMlBuME5JM2o0QXJ1L2VMTXNJYko4cWN4aGIrV080?=
 =?utf-8?B?Wi9wYVhHRGxpU2JRaTdxTUJHMGRtOFNtclNOZVg3TXBWT2pmcjlrRjRPYkIv?=
 =?utf-8?B?TTUxZmpwMWtGcUhLYndmUC9UM3YwcktOS1FDTUxid292SGF3U2tOYnFFVi85?=
 =?utf-8?B?SUQvcGkrTmtWK0IzWWlOVXY5cHdLOFJBeVBMUG1OaVJyYU1sL3Y4QzNyam9h?=
 =?utf-8?B?ZFVzUEtISUFIaldTUW9XcXpCRFdRN2trUmMwWTBySk4rSHJQNVBibkVPSnNj?=
 =?utf-8?B?UlV5MG1USUVuTUlRelBlQnQ0TU5vK2dRK0oyU0I3Ulg3R1Q0NFg2cnhpMVdZ?=
 =?utf-8?B?ZDIzdVVOd1B1cldKbDVGbTVjbEJkYzM0ZEEzN0loWmQ3VFZrRXA0cWpyQzBF?=
 =?utf-8?B?d1Z5amNSY3F1cEJidTNBT1Y0c3Noc3laTnpoMTQ1eUwvWlkxRXZCeWc5Vit5?=
 =?utf-8?B?S0kydlErZUZyRVFrL1F6MmlYNE9PVjNvcjFFa2lFUXVzWFRBSlFBWTRsU2pT?=
 =?utf-8?B?MXV0d0FpVDI5ZGdJUDlhc0tIY2hBcWM4MGwzdmVRemRoNmcrV3ZvY0lSSnlw?=
 =?utf-8?B?QkVrbUxucmllWTNFbUkxamVpQ0hXLy8wV0R4WEt3dkEra0xyTkc4Q2U3V2dl?=
 =?utf-8?B?NGNxRWRZRDA3L2g2UGJLK3ExN0tML3lJUkYyM0d6clBDejBURlc2dEwxUGxL?=
 =?utf-8?B?VkkvTjZDWVRiOTBTZFpOWW1RZE8yT25TK1Zpblh1Y0xCOHdjUklWdk9RelpK?=
 =?utf-8?B?Z3RoRzk1eHVNamZrbVlqSll0ckJSUTdlcXpaV2FkVmloL2Y1MFZHZTdiL1Nm?=
 =?utf-8?B?bjUrMUdUV0M4VlNaY3ZJR3Z3TCtOWkpleEdWZ3Z5cDdicWRTOVhJWE9mWi81?=
 =?utf-8?B?c3U3bTNFTloxS3VYcUpHQTZsU3Y3REFWdEFNdTVBRVF5YUFNc2dDMXZWaWxY?=
 =?utf-8?Q?otjGyKqXFao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlI5cVdXRExyRTU1aUxlR0dyK3pybnpwK21hYkdiMlI1eWhmQ2VUYmU5WkVE?=
 =?utf-8?B?OGFHOCtaZHNHNlJNUHRDUU9qMkpUYVk0eGZmK1NTcTdueWV6b09QMXdJTVFp?=
 =?utf-8?B?SGx4YWhtMnZneVVqVnNZY0FWS3pQaVRaNE5BdlgraXFrZFNtRFpUY1E3NHpj?=
 =?utf-8?B?cUpoMEJwdEFhaEtMamNaV1U2MytZN3NXZlhTZE5CSFk1QW9HTzhkNTMxdWZs?=
 =?utf-8?B?YzQ4NTNlN0xQSDIvRzFNZFBVd0xVdDlZdnQzbzZTdGoxdGlpZ05qcWk4SXNY?=
 =?utf-8?B?dGtiT1I5R1RwK3k3R2lOVHBqaHZVcENDbU9KK1FsZnd4ckFaNklWSFN5Zksy?=
 =?utf-8?B?T05IQlB1NzdFUnNXZWp4MGZ2ZDdQMDUvTXpIM2pFZVhjL1JqZUVVVlAvbUJE?=
 =?utf-8?B?T2tHWmpKNW9IdUxpa3lwNlBpUUxVQ01IZE5Zd2pXZjlQSmIrRTF3dmc4c1E5?=
 =?utf-8?B?SVlZTG9ZajRObm1Fb1NXUUZ5ZEZRTXJiQ2JHZ2k1TTl3bEFwU0t1SjFJM2JW?=
 =?utf-8?B?TnZ1dTNxT0p1c1J6N3QrSGdlZ3dVR2cyNHJDVjNNQm9zeE1LcHFqeHREMmVh?=
 =?utf-8?B?UDExQUdLajduQmVJV2xxTEN1R2NWNWtHM01HbExzeDJ5SjRrNjVNbnFZSSsw?=
 =?utf-8?B?bFUzSXFlTmJHL1g4azRhNVpuZmdCS0V6MU5FalU2ZFB4aGxreVF6SlhueFRQ?=
 =?utf-8?B?K1E2TmVEQVhNZ2haTWJkbWRKakM1MGJHc0xzcWZNTU5UNldGMlQ2YjRlbXJy?=
 =?utf-8?B?MXl1b2Fibk01TW5iNUxYbCtKT09jSktub3VFdkVROCtkN1lDWDdOK1pFb0gr?=
 =?utf-8?B?QWdDRGtkZ2h0TFZtVFQydkhxZlY4bTNHQUF1MDB1ZGVqaU1sdXU0WTNQZU1F?=
 =?utf-8?B?R040ZTI4Z1VoN1Y5czlIYVo2VE9JQ1o4U01VckNvZFNzYmZjODA5SGkvdElv?=
 =?utf-8?B?eUdMakp5YWNaMGxRK0VZaEhKVG1xRDAvck53ODNiUEtWMVV1ZGszNlFqYVIx?=
 =?utf-8?B?RUkzMmU5WkJINXpPalhLWWZuOXNoSnkyVCtkOVJrVWFSOXlHcnpEYVo3d0Zx?=
 =?utf-8?B?U2JnOTRrcVBVQlB2WDFuSUdiN3QxWU5BUSsybTEzNjJYcnp3dTZFN1ZsK3hM?=
 =?utf-8?B?NlFKVmM0NXpIcE94UHQ4bWtHVjM4VGhrSjhUYk93QVM4aW9yS21IY3d2SSs3?=
 =?utf-8?B?Ni9BczF6RkY0SHhUaCsyUXJDMDlpeHJpN3lQSFhOUTh3TVlzblpvNmp0bUlx?=
 =?utf-8?B?MC9mamJJbVE4c3FjM1NNVDY5dHR6akpjVnlKV29ON0I3aTN3MkZZTnRaOC9H?=
 =?utf-8?B?a3AxUk05aWljTHhmblBMY0UxeHZnWFpHc3NCUXlqck1sK21HS0VlT2tBMlk3?=
 =?utf-8?B?NzBIVXBURjcxTDQrd1lnMDVCRUhQdnpSNmQ5cEtyS29uOVFPM2FCWjY1NTFx?=
 =?utf-8?B?NkU2U2FYdUJ6VkFoY0hCS1hKdEdSMHhGTWtocUE2NjVoV2xkQ1hWTlVVcGFI?=
 =?utf-8?B?NEdkcnhzODJTcFlyeVR6RjFzNVpRZUhwSGFMY0czWktzaHlueVJtbkxRY3Ri?=
 =?utf-8?B?NTFUMDl0ZG1UQnJNR2JSSFBkMi92N05LVmZ6aHNER2hmRXJOdmZjQlhsd2ZZ?=
 =?utf-8?B?cDdZcmQrSHFENjZXMWlkb3RUL2lJTGxDU1hBZmJCVEFIMzZZNURYTnhEUEIv?=
 =?utf-8?B?NjFwc2cyYTVTb0dhYno0ZWNhakhRMzdCMlhVYXVVZ3psV3BKYVJMVXFpcjRp?=
 =?utf-8?B?N3hSb2NhSG5IMWN2bjhyUGltNTFBN1JrM3ZmTW54QW4vWG52Z3ExYytOSGxE?=
 =?utf-8?B?NVlnc1A4OUZ3OWZNcm1FNDNCRGNRalFld0R6VGlEeWxCVGZaVTVYdzRaL1JF?=
 =?utf-8?B?d2UxU3dEL29ORW1HMW9IYUdZSDdOeDhEd3A5amtmSVlrcWZtNzltTU5ld2pH?=
 =?utf-8?B?SkRRR1RaNVptV0ZZWVdlbW1XWmpzdU5rY21nT1JwdGdvV1lLckdRQThmUGVZ?=
 =?utf-8?B?VXlCWXVuN1F4a2NzUURxaE00b01BcGZEaCt6eitmN2dOUHNXZnB1eUpUa0xi?=
 =?utf-8?B?OVBRMmFYL1piWUxodlgrMXJUNW1NSkVDZ1czL0hqeTlIc05YQ2pORzl2djNP?=
 =?utf-8?B?MkJXZ053Q1EybGd4WkFaUWlIQ3hyd2UrN3VKaFpTS0oxcVhSdjdWckRQd09R?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9j+peZnHQZCtjlzkPoznBfR2W7F7aEgn0LHIOPTqEDP3akatky5s1jWGX081+YbJWDbKh2YkcmmAxmhyZm8exnAGTA/mKA/3fFcOSEXbGJNPfN4uf0RGe9s+1hQ7KAfhupySn1Vuskv3vjOiBoQ+RQq/cswRcKyCXKH3SS4XeH5p3FkBP0sPXZTVtWdRmNotQntxrIUyhs2+YLt2YF0zir4BD2Ua2fPadNcF5ltvUTFUJpDwLDD1G2D6y3vTPmKg4owvGmvYzZU75Q7Hj5xjWEU/rZedx/v/4im9JjdAChlYX1kBE4d0n9j4+e0wUri+YnsAojL5AKwn4bOsnKLPqv/j7Vpn2vM+Pq+BfL92sqfyo5u0Qugc23nCYtOQqGaj5Awuyhb377ipucWkugP2MjHHfErfQebZZZ0eYJ3E/8TbauSA9owZ3gG/+JV0vSiDWT59PSOw9qscDgIUfm3UbF8THzFnOJAurlyOhg5w3fjG1DQFPKbnQg86bLWK2b6paTTUbWibUkPDI4o1V55y+Hfusdu2HJXxzURmEg8S40IgoHS2w8xMsGZt9OeAfotSga30+pWLSDQVbkS89/XtTtDlopVIVOmHVIMLJ4hTsDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a600cb34-a8d8-4795-b040-08ddc068e485
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 10:51:30.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkNfwtne5PKmgXS5v+jCNuzjfXQOZx809NXZh+M/V09chuSV6j29o2eOPRLPXNoWAUMTARzKFdwmcxrJbbC4VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3NiBTYWx0ZWRfXz4/nveSGG2L+ WZRZPbRuIjkqiNhpowC75HMD6hZdqSmCTGdhqsRwRKUPi7fZ6iiVpByIH1eHxKn3Y6UhHiqRLcT RHS7ogO01sTjRybnTiMzfvi9uMA53BoEH5INPUXXGWQ2yk3CMbrWP8H+zd8V/XWDap9KXJqKUPj
 t/fNh2wMJwVm6AVlgVHSnK0W44IifCKkCOT86RXURTF03siCMq/X/fslbOmING6YvzxV2zmGh7G whVmHPiO0tjb7RP7r0xcQEuG3zikHMLVRCjkUynWxyC26SFtcUEyEPxBTzZMrSmN+b2mDMFszXi lBvywJv7mTwujW3alnGUhcmP4u2x+qu5mKmLRUm/pXqo0sKbJLlI5XDHt4CiF4S/AtzNWt4M5S1
 up/wnT4M6xws4R9GxgvyiNfQj8/CwtKar+QO7DG5afn5NU2F7coUT5Knm3a/kGogPjoEgEy9
X-Proofpoint-GUID: 4hn47lQsz_y1n_yNC0kUqTCWXdHEZzOs
X-Proofpoint-ORIG-GUID: 4hn47lQsz_y1n_yNC0kUqTCWXdHEZzOs
X-Authority-Analysis: v=2.4 cv=PpyTbxM3 c=1 sm=1 tr=0 ts=6870ecb6 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=6kuCsMNkdTEAItufr2MA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061

On 11/07/2025 11:39, Ojaswin Mujoo wrote:
>> I don't think that fio supports such a mode. Or does it?
> Yes we can achieve it via combination of write job with verify=crc,do_verify=0 followed by
> verify job with verify=crc,verify_only=1. 

So does verify=crc,do_verify=0 really omit the verify and only do write? 
If so, seems good.

> I'm testing this right now to
> see if it can survive max_sectors_kb = 4 (which i think it should since
> there are no races now). If everything is fine I'll use this approach
> for the fio tests in the next revision.

understood

>>> Yes, it is a bit less effective but
>>> then having a data integrity test that can theoretically return false
>>> positives is not good, it'll always keep me guessing about any failure.
>>> Having verify at end will not have false failures for sure. Even though
>>> it comes at a cost of less coverage.
>>>
>>> Maybe we can also get some other prespectives on this.
>>> @Zorro, @Darrick, can you please give your thoughts on this?
>>>
>>> As a sidenote, with this issue of fio's verify read splitting, it seems
>>> like the parallel verify feature in fio itself is flawed for non-atomic
>>> writes as well since the read can always split and race with the writes.
>> fio does warn that multiple read and writers in verify mode is unsafe.
> Right.
> 
>>> Not sure what the solution is here, maybe time for non splittable atomic
>>> writes (:p)
>> I just think that fio in verify mode for ext4 is ok, as long as
>> max_sectors_kb is large.
> Yes but i'd rather have the write followed by verify version to avoid
> false positives in case the read bio does end up splitting for whatever
> reason.
> 
> Thanks for catching this issue in the test!

So, if you want to test this way then you need to omit xfs or ensure 
that the bs <= awu max opt for xfs and hope for no problems.

Thanks,
John

