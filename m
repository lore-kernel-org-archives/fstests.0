Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0124C076
	for <fstests@vger.kernel.org>; Thu,  3 Jul 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560029; cv=fail; b=UuDDl7JW1PPgLdj6Wmazec0BESKRbNcOxYOcaDQQV2Py8ZMzrqCSplIkM5/4V9PqSM063JTBYlgl3hsPQT3UVr8ZjJjYCZaLKChOdzjMqINkaPXe28NTE4WA/YBlNj0BMALsrlwyHL7wolHtUrTUQzPWhXGdTa8pBYk4RLXAqDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560029; c=relaxed/simple;
	bh=F6G9ZkdnIL7TFrDVDvvnq6858d89ncANburlAUKyC9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kx78m/vSfwYfzW9VG7rHXWKS9oH9k7YC9rOE1/zFzZ9xZdxlOaU7miRJr8yi7MkCR8g1zaSMiejPYUvFw9TqKf9PaOiY7YlZq5uzucnxKCPg9CZRi6I7Glp1L23zjwvKaBzs5FwJNzDDYv7TWs38NlCedBjI5RF5Vb7fH/ImSmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YhHVUJV1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rxIMjTyB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YhHVUJV1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rxIMjTyB"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563DZ4Wu009613;
	Thu, 3 Jul 2025 16:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ldnkZi/sbhttxazkkzPxg0fAFJY9NGgoIo+7eEx+PBw=; b=
	YhHVUJV1pSKKgI+oWXTZbTxSPGyBUWB8Aor74LgR/jnPfcbTWvnp29yydky+BQPH
	sO4VoBoW+3DQilraWaCHpYxpoFagZ99Uxznei/6YjqbHGgiWqeQCWL+Uutio/R2j
	SlkjPU9r+pt3uqbObBZADYyof8wt/6M6A6IisPK2Sqnhs2ShEVIlLHwLuxD5YhN7
	KcoNuSV+Na8lgbSx+l41F8kxTabM3fwgyalAX4xnYkzfgCUONmRUEAGPWCYBXobj
	+DvKyvknrnG8F+dgbkjzuqXBu2G0hzqn16sTRDMDTvRtdbKZnxGj2nJ6+iENNQ8r
	ROKTsMHJjiPk5rMqhNOl0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766heam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 16:26:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563FLBJd018774;
	Thu, 3 Jul 2025 16:26:55 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ucu6q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 16:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAo84sV8RpBFcIqtbFmkn+cznoKsQ1UAWmzka9gjWHRrmYY4wSOzxBJZb00Ru7k0jp3GMQBG31E+mtVlSPEGROMhixPClpz/lWNBOE5mFPa7CEvQmQ88dnVC0K5M8MBvVHk5+TSABqnOQqPCDGh//AVCnw9ZLDH24fmqXUDMXxeEfiKdpNuiaPNkz0TWXfxmDm4D/2OCNna6WLpoAjzZRdzoTC8O9tK8+VUZUqbTBCybOnn0i9tG8Lc8r5Ba7inNEOD0x2KvmMkAx5fenRiGTKm/jp+skPIrt4RfqXtUBQZ2OutHNIxzizVZVPYa/c2B82b1hkLXTLBQ/v+hhAizeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldnkZi/sbhttxazkkzPxg0fAFJY9NGgoIo+7eEx+PBw=;
 b=VHYkm4qYWFxwW1hjkPFpx4mmCwGtOCz+YZRd5Zr52oNHKxi2LOPTpl98384ljrEQH6ev5jeuilJxerWG70zTGzzoeXNDZ/IffWJsR4GuBGENOT5fHLxM27Bz52heKbStRfTgXERkIs4DzY9cUCi+hGpN9NU1OMuEqh5ZdzU3ZQr6Bq9iLAoeALaSqf9yJb7MuabXnpK+Zbnyk2CXpfwPdMgA0NzNXQan13nshOAS7/be2GKt+L1m/R35Eaprsi11i5wO7dxlmkWnyTcRR/O5OP/UBLu6arHKk5WrSGxDLHSZiRHKCgRijVWAHZEA56OLIex35C6ZZQ9TiE+9FXRdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldnkZi/sbhttxazkkzPxg0fAFJY9NGgoIo+7eEx+PBw=;
 b=rxIMjTyBiqZhA7ag5/N/CUyaRPTDJwBdqSpIm0bCeaZQq2BSCpv7RfHYfg5pKThGCBEatuWhgXgcX0ONbWS4Vd4vlLQ0ciDjEBXGzO8t37JlZdgSmzWBYHVcGojuv/5Oli6+C7h1/bC5DpXgVP6+VVOv8OpJbO+aJaCIxGb4rRc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 3 Jul
 2025 16:26:51 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8880.027; Thu, 3 Jul 2025
 16:26:51 +0000
Message-ID: <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
Date: Thu, 3 Jul 2025 17:26:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
 <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0127.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::44) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 75590e81-eaa4-4e12-bba0-08ddba4e6aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE8rNmo4WmY4cjZpK1Z3OXpPcWVRak90a0YvSjBpSURnY2V0dVRwUlJ3bmlk?=
 =?utf-8?B?VHhpNDAvWVZIam81SkhPTFVsbm5BUlNzV1RIV3lIcFcrR0dFUklBbWVjMThS?=
 =?utf-8?B?M2FMRTBNbVZTNXd1MFZDVGowUllGdkhLS3VIeDUwTUFCVW9jMmNaWWMwM09y?=
 =?utf-8?B?N1hpa2VERXNnT2FSblVBZ0lLVEp0RXZNZzhlS2U5VXltUkxqejU4ZDVWVGpW?=
 =?utf-8?B?NlBqOVZVVVdoNnl0NCtDR2Jhdi9JQVY2L2tJYTV1Ui8yR1Nhckp3cStwWGdI?=
 =?utf-8?B?bVZCSm9XTFYzZndZdW5EcnFnNnZHSy94cGRNdmFQTlB0dDBuZC9LZklVK25L?=
 =?utf-8?B?c1g5NnYxZy9SdGVzbEZLd2Jibm9BdmtEWVUxd1ZDVDUwa045cm1SdGwxR0Vr?=
 =?utf-8?B?U0RrSG5yQmxQRkE2bUlqZUxHS2FFaUdNbzZibVVtSUFtQkZiYWd0b1o4SGkr?=
 =?utf-8?B?bzFKcVhhamtsWmkxa2xWYkhoNUNLMEVTZzUrYXBCdit6MGY1ZzF2clFMQTJK?=
 =?utf-8?B?QUpVbktFb21pVmlMT0xKM2t4d0Z1bjREVUoycTR6eFZ4bXdIVnY0MGh6ZGlt?=
 =?utf-8?B?ZGJIejBzRWpMTTJybXpYYXJveXdhNlZXblBjQ1FrTXZVRGNianFPc21zRmtu?=
 =?utf-8?B?RE5sK3lnS0FnOEtPRk8xc1VCRWdzaUpNZHE2QmNwK1RJdGZKRFArQnUxdUFp?=
 =?utf-8?B?dVJ6akZuYUE5WkdnVnRYOXoyVVBXL0NoTFB0MnNKMWFEcXB2OGZxNDd5elhm?=
 =?utf-8?B?dzBNRG1yb1EzZkRtSENIb2RZL2Vyb3ZwbVdCZWJteUZldlk1TXl0NnVlemxu?=
 =?utf-8?B?ZnN3Qk9TUk1PcHNVOE84c3B3OGd0RnFrTjZMUnRJbUtqMmxxUExNNEFXMmZY?=
 =?utf-8?B?ZWljWngydk5yZDJBQXBrUThXVmJienBkckpvOWR0NXBlVlIyUk9DclkrK05o?=
 =?utf-8?B?cXhtQ0FBazJ4K0JaVDRvREFvaTNtSVVaUzBNQ3J0cFdla1ZrQWRKakVPSW1H?=
 =?utf-8?B?QzBTQ2NmOHNITmVmdmIwRjdiKzN6NlA2MTZMS3FubmhmaEJiRVdvbVNnVFRH?=
 =?utf-8?B?bEp5VFhVSjBsTWhTQnVxazVlc1VVZ0dPSTdvWmdvR0tEbEVlbEdqRDhRbVll?=
 =?utf-8?B?ME03UlF5RW9kd29mNXVYdkVDOTVSSXdvaWRtbEt3Rml1UnJOb1I3ZWhsdmFV?=
 =?utf-8?B?OW5NOEh3ajIvVlh4QlpaYnhEQUY4bXRoYUpFZHNoeW1ybHN0bHoxZnhPSk5l?=
 =?utf-8?B?emRiV1daeWZ6YjZoNDJqcHVqa01aN2FIVDVlVjNpRWdxSDNiZkRvR0p6N1I5?=
 =?utf-8?B?a0lPam5LS1FRZGV3dzMyRk85K3VaZWpLWjE2alVNZmlqM09CcGxjMVhLVkpG?=
 =?utf-8?B?dm1iUFp0ZUtrTXpBeXZmNkFYaVhjWUFieEhEOTB6a1ZhWHJhVXVqOWpYcGE4?=
 =?utf-8?B?VjdyOGc1OUJtcXZvb0JPazh3cHQyYndYSkhoS09jZWdoSnV3M0VQM1pvVEVI?=
 =?utf-8?B?Mml2a0NSa1hNSGduME5NT0QrSDBaeGd0Q2NHY29hSmE3TmVZZGlSQkNBUml5?=
 =?utf-8?B?WVBwRHNmTjl6VTN3M3VmSG5TbG5nZUVTRW94VUdVV3B3YlBpVkdQTjhEV0Jq?=
 =?utf-8?B?Q3p5eDlIa0owd003UXRETGZhYWFUL3c1L3h4SXU3cDEyaDl4YXEvRi9WZWti?=
 =?utf-8?B?RUNpMU5ySmplYmJYU01pV2xLazdCS1RzaHhEUEw1OGlNaXBTU0J3NVdoeFg2?=
 =?utf-8?B?WjBEMklWUmQzNFlOWEJCT1laM1dUeDV4MEg1c3BiNWpFUW5kWHNjNWY4VHFM?=
 =?utf-8?B?MXI5bkpUWU5pS0NFMlNCZFF2cXJIeDFlWUlsTlFtempFS3N4azE3cU1kbVU1?=
 =?utf-8?B?ZU1VczZXdzdScW9tV3NTcjM2eDB6TzNmanB4aW80bkREODdodDVJWGxQUEhN?=
 =?utf-8?Q?GoI4VoDSLzI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFVhS3JjdXROZmV1U2NIVGNIOGd3K3RYRk5JcDIzcjVVeTlmOE13YjQya29H?=
 =?utf-8?B?d2lYUUczSWhCY252NXRKV1BVaVhDT2hudGE3dVBnRC9oRUJjVnVkczNaYndB?=
 =?utf-8?B?MTFhUEVvOXNkQmYvcGZVYmpqRFZCS04zdEtmRVdYeWUrTGV0VmY0by9IL2Q0?=
 =?utf-8?B?QzJscUpMZkdzTDdxQ201eWJLOGVKeit2b2dud0NLbEJLL2pLaEZmMWR2MGZN?=
 =?utf-8?B?cnJGcWwrR0lVSWtKTVVwVmo5U3FyNHV0cXZnZzFuY0NBQ1ZzWkpBZGRESHZV?=
 =?utf-8?B?bC9YTUdwUENwT3p4K2NUVjFiT1RDQXMyMHNsNUVxM1J3Z2l4ODg5Z25VaWtU?=
 =?utf-8?B?ZVo3eHpoeFl3T0xaam5OVTZyQjBNb24xMEZYS3Zlb0xUMjhBUCtKNjZ6NDVV?=
 =?utf-8?B?aHFsRzRzZkxLZVhvQm95cUQ1c0ZPRWVyMlh1SmtWNkZtVWptV3F3ZFR6eVI4?=
 =?utf-8?B?d0wzcnplVTNrcmoyNVBrR0xISVJSS29HNEJwR1JvNitZRGswWm5PcUlrSmdl?=
 =?utf-8?B?STlXVzRJNHZMb3NWVXJMc1ZNK0k4T2ozaDJKR1BIN0lwbzh2ZHNHOXJRUGJZ?=
 =?utf-8?B?SVBCSkhXU2NUS04wcUQ0dm9zQUpsT21JKzF4UkVPSG5HVUZrVWtiWWtKOTho?=
 =?utf-8?B?YWxmaE9Jb0c2UEJBVWU1ZWJVR1JwdVN2K1hQUHBoVnQ2ajFVZTBoWU1vSi9t?=
 =?utf-8?B?blZtQzgrWVg3V2Q3VmpKcUN1VTFVcEVDYjNWTmNORnVNTEtMSktEVXBRZ3U0?=
 =?utf-8?B?SjFacU12T2NEZzdXdmRYTXgrRjY3cFRjaHdKNjFnZFJMb3pVUzdQbGhLMVZJ?=
 =?utf-8?B?SDgxNVVHc2NtOXAyZWs5by9jQmNvRkhLU1loeElOR2ppamhzYTFKS2hIV1Zp?=
 =?utf-8?B?U0lFTjJYZUVYMmp3Rlp6VVprN3JmTzRQVG9ON0tFWk1JdTBwK3h4bmwvZFpE?=
 =?utf-8?B?U1VGenI5UFllcW5YZ0h3V091L1pYT1l2NGZUMEhjUkFtdHFtQXVPay9zWnht?=
 =?utf-8?B?VjIveldrczdtdHNsSSs1ZGpwZDBZajA1bWJiR0ZJVzdCbFhKT1cyc1dMeVVZ?=
 =?utf-8?B?RHoyVXFFTkpRVm9NWUtOS3V0c3E2NHpBYkpsUXlmNjhOUUJGRVZXcHFGNzh5?=
 =?utf-8?B?alo3QkhMa3ErTTlHNE5acTlsWlBMUmo4UG9PVTNma1c1aGNxSDZjMG9MOEFw?=
 =?utf-8?B?QlYwRDl6TkVvck1IVVJrVjJHNjVJejRvU2hQbmhkWGh3M1UvUEFHQ04xQUZU?=
 =?utf-8?B?cDluaklGVmpYTWtLZldWRTJmT1V3R2pxTWd0b1hyMmh3TDRpdnRrVSt3USs2?=
 =?utf-8?B?VHFxWUJoUnVDZFJhWlFZbzRJQ2VxaTBWTCtQWkRzUXFRVmdQSXFNbDRIaGFn?=
 =?utf-8?B?S1BJZlhacFhveFV4QXczTDNuQjFWUkw4QlVoTitoUXRuTFdiQk91Ukp1N0ZB?=
 =?utf-8?B?L0NZU3VNd1d3em1pUTliaTU2bFc5bExPTFFjN1NtajY4bk43R1RjTVBlQTYw?=
 =?utf-8?B?dHl4dTc3T1pkUC83RDBBQjBwVE5PVUpaazJSMWhJcENySlZ0SkdHcHFhYS9T?=
 =?utf-8?B?NDdoYmJFUTlZUGJYUlR4WDR6ZU5pSmdTSWZ0SG1haGZSWVV0eFJVcGxVOXo2?=
 =?utf-8?B?VGVpdEFSaUFTa1AvNVlMWDlLallxTkFNSTZKZmxjb1ZyVEQ1ZFBXWitjdlhj?=
 =?utf-8?B?eEI4V3Joekcwb0lnQXA1VnFJWDE5Umo0cWswRGxTd1pidExuWEpkUkcrcW9F?=
 =?utf-8?B?RjVmcnJIajJZZDdITW1nd05iS2ZQTDc1YUlRcjlzZHRmaVdoR3JERVI0K3lJ?=
 =?utf-8?B?ZmJMTkwwczk4MWIvTGt2REhqcjZ6UnpDemVIOTVyYVQ4bkFJQk91aU90ODNz?=
 =?utf-8?B?UVVVWDB1aGFybVFBd3lPd0V4WXVLSzdoNVVmRi8wc3ZPbnFRM2RHSHNnMjk0?=
 =?utf-8?B?Nks1QUFDWkZwWUc5d09xWFU1WUtablFWT0dUOE43bklMYkpwK05rN1MxUzdw?=
 =?utf-8?B?ZmVWNCtzQmpRdVBSdlVzdTYvQlVPWVZjVkZlZnFyNDNtOEpIdGo0c3J2T09w?=
 =?utf-8?B?MTVPZzdEUXpkYzZvUEJZckdjSWo2eFM1UjI0MmV6T2FTcDZyN3NUTjdVMkxk?=
 =?utf-8?B?VTdyWTR2R2xvMTdZcWpwS0RHTG95ekpzclFOaUNhRmF1eW5CUngxemJmdmRh?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LgXd8MkZIavs18jsoo5mxTcK8ncPmmxOjYLRGRxrdzy5K/NzI7mKCTIJQbOnXAm9sL5LiMDBDWOQ7BHlkMVw7IoiBWXsRNLGXylxPWyPdeFWEHtwX7/OROmTUdYY7penDtxypp2FZlxE4CNvYuHw9R3eyh0QisbBQ/L8PmBG8V+KKUHh5NmI5EZmvuIipdbLcUPk55WgDKgjeL2Rc7qHVQvs7M0x/n998AnjSpBU5I8wt9ggWLlut1t4X83yHccOCPolyyULAVkFxk4TX/CS07zoiLydr9nwbRAvLnTicX4dyWmRWij5Q+xlGlrHBvZOmWOQ965Eet0laqwhukhoRcFDMrOXzwajgOOH0xeSLPfWOr5F1RP2CLetOXT4m5jnub4Vc7U381S56e3WOuADcF+4NQATKVsXxdwn3KcwTCrTdjE+as2eZbiWDcT/V+7KMbeLryPyUKXhAUOak+4Bw40H3zh950Ac8i893wDWa57Y/o55Q/toOlMXmaMboHT/j4QXGRMomMgbhTuvtaq4gaP3VwE1P/ck58KU6K0MoXyvR5lHp6glpHlDP0qC6qX5uvNqAHbpUlJ6d2B6uIuzLCxPu7weyhISmGD0I2h42Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75590e81-eaa4-4e12-bba0-08ddba4e6aa6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 16:26:51.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX1PlqMKejb1xt0fVfdWbSOHEYTwqZUWKwqTEv4/g+ubFqLAgY497OG9Rza94jYo2L/Gkd1/xb0BRk1NAoS83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507030135
X-Proofpoint-GUID: nMdkG5WSmocQycGz_ngIAT1_Lct3kztq
X-Proofpoint-ORIG-GUID: nMdkG5WSmocQycGz_ngIAT1_Lct3kztq
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6866af50 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=0Atx5DsBMiAjsvVotT0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEzNiBTYWx0ZWRfX5rMcj4m9uSpS knDukH/bTDmoWYjY16p4uM9xE+DPqEoF6y2epfiBacXz1KhupnhLZ+9HoUFwxkK6NMG0f/wGXFP X1wirEtSIIl9J60bd0y4s0ImJSu1JADS9Hn+Q5LEgkiuyGvaNhqonglAwocDhjcS8+PI0muOGoT
 /4gHe80B4KW9hGZmd1cVIiyEzoUeeh98XeuZ3sv25PARvcmLZlaymiM9d0SzWOACk+tOGjHQQ0X imUbMtzUzd/Nkix1zqqObPWjFdTWkPSuVYQbnNQErjUo2XjSYX971LyPjb/QDC+Ojh4T33h0+/M lKjOgjsmaBiJYD39yAKKvg9ZCW2qWUr1CvVbCyc1I/ot0f0C/zI0eeszBExE7tMer6qK64i80JD
 q/BtzVlGhrOlhvvr4u6x1Mun5Xr703DTMD8voXHibiP193D6j9zr2QS5RxRqH3F1bdD2iYbS

On 03/07/2025 07:42, Ojaswin Mujoo wrote:
>>> Why serialization matters here, because even if device reorders our read
>>> before the atomic write, we still fetch an older $blocksize chunk which
>>> should have the data and the header.
>> Yes, we fetch $blocksize, but it may be as multiple read requests,
>> so we can have:
>>
>> partial read $blocksize request, atomic write request, partial read
>> $blocksize request
> Ahh now I get the picture. Since software atomic writes might have a
> value way higher than the max_sectors that the bio may split at, this
> causes the reads to split which is the issue happnes, as you mentioned.

This issue also exists for atomic writes based on REQ_ATOMIC.

> 
>>> The data crc should match the
>>> header because it would have gone atomically. What am I missing?
>>>
>>> (Or do you mean that max_sectors_kb is not big enough to support
>>> reads after software atomic writes and thats the issue?)
>>>
>>>> Can you cap at atomic write unit max opt? That will mean that we get
>>>> serialization from atomic write HW support.
>>>>
>>>> BTW, to repeat what I said before, it can also fail for atomic write bios
>>>> using HW support, as reads may be split.
>>> This one I can understand, the fio's read is split causing a short read
>>> and seems like fio is not requeing short read properly for the verify
>>> step(?) so it tries to verify against short read itself.
>> this is not an fio problem, as above.
> Yep got it, its the block layer splitting the reads.
> 
> So as a solution, do you think it is okay to cap  $blocksize to
> max_sectors_kb or would you suggest it would be better to just stick to
> awu max opt?

I tend to think that it is better to cap at awu max opt. If zero, then 
don't do the test.

What awu max opt is reported for ext4 (for awu max > FS block size)? Is 
min(bigalloc size, bdev awu max)?

Thanks,
John

