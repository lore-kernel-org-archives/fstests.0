Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73621C19E
	for <fstests@vger.kernel.org>; Mon,  7 Jul 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876298; cv=fail; b=n+WYQsxh6SlHnSLKwucOAHLvHX8dLrPIMHBn0v6XvFrwFbEPtLmqaBEi1OyHO7oDiWitxTntwL4LiUfb1Xs5dF1FPAKvsBqbhiRpXdExLtEKTZ7U0EgXsIxcdfL4nKG1T7XBOedum8jzbweWB/bxKq2fN9YMWehmFiEPwu0HqLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876298; c=relaxed/simple;
	bh=AJd5o4eXECb1EHFKN/9SysiUMyBv4okK+Cc2DXWqe5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VIssZExQf/zN7EC+hHXHxPe2ibXFRLT7+woANxJ5nnhu78PXWdVifjEyS4FhinHS3g2GgTDA7qkXgEF4EslMdCgTiIG2jwBVL5xHfPvqOipczspYcY/+XTuTiBVPH4lGWHkaO/Zdd6sDr7xPIZRbYxWx2cxjeJzLuyNCF05nA5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBA9OQOu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NhqmTK+K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBA9OQOu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NhqmTK+K"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ2Zb021422;
	Mon, 7 Jul 2025 08:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gbRfcaqJ7PATSeVfSMDq50NtyE+BOoS+x877rA3kkc8=; b=
	FBA9OQOuBUPTOp1yb/bFOI0oqTFFRVdOwPVviPEAy8pB/edmKzzz4T2iPXnobrmB
	RGZhr6z0Wc1EAsFm0nzZrMV8MTPNVPPtISAVSK8JbWLC9UFdOsIZYrHDrAeM1b91
	hitNZ16N96dzaB1unlWmUEYEBGwvSU30I1I89c7aDh/svxuiCXv75SaxAHlYdsZz
	RT+7YtVY2LkbWoxvjGZkmuc7RcMrtg4grytAuW+i3jVOfFEbLRHyhVgBXU0ItRFp
	buZvffTZ+YEmK19zDzmJCHEN5WzjgfkmzTaE1A9D7JfozHrweAomxypGdn7DOLLI
	TDZGQ+UHgIESd4yFgOUyOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptyfj9m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 08:18:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5676O5O0021371;
	Mon, 7 Jul 2025 08:18:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg7xthb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 08:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RStitrpxWPSw4GZle4RR2xKFz5z2bLuPWSCr9Vn7QV+Yx8B7AIYgVdmsmQKmq/kqcQxcm3g5v15whEDCpUfBUDA4XsRyzZaHwXQ5KlE9TVGORp5nvwAHe6x/BOPWUFf10MgAdsH9j4Pm9F3ggV+m7mQWKxme+3L/ixLsNXJxhkdcUX66hNATDkOzgvI6Zy2h+q8SS9wA2/87CSCgb/AeaQAeo8Dz1XUPovR5vP23iy7BgLg8ye8vFe9VztTVDGmFR1oy3APxXiBwz2hl/CPFV1JugFzvZ3HbvGTF0pwm3aFMnfk45/KQdVTUTEuzty7hYJmVp49pjeNI2QUf+6MkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbRfcaqJ7PATSeVfSMDq50NtyE+BOoS+x877rA3kkc8=;
 b=l92UBRvhFKfc3nKGarHNcgodRH2o/fmiaiIwG8g8yV08XDQ1QJQKrfKmIhadvo9WPVGGh4YBk5q8RJjMz3kERqJu0kvX1Cxg+YKL/LXI4ZSgX2KPJ2Z6b9QoXwIFx/OpqpuBXp+LHX+YEwzvTcG8B82h1LGQTb2Cj3gnx+AodxikyYPoXCJrlXmpNOplObMDHBlqN+zRd62lB/peIPcDMIjgwBhL1Vwc1LEsFYRo+3fizupS5Ny3VDBtEKVUGEzT08LboJlC/eE6BVk+mpFcCVf3LHJ2J56tJPbSpT5pgJhkwX0WmLbcAorEv8K1IabenYPot6RuHHT0UtUg2LAVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbRfcaqJ7PATSeVfSMDq50NtyE+BOoS+x877rA3kkc8=;
 b=NhqmTK+KROS0oOz6OQzQzI6nkNMSBB773MJMeg75HmxBvl/O5fFMVDitQGzTsVFMe08O4jPXwONJA7IQYGtoVjiWJYc4d+8dQIPBA9Nn9eTGsHotdPRfbUWgpQjDI3Uv0P2ffkC2y2wdvyz2Nvd4IB68uzNVv5cK5eSvjcCYMTA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS0PR10MB6870.namprd10.prod.outlook.com (2603:10b6:8:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 08:18:06 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:18:05 +0000
Message-ID: <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
Date: Mon, 7 Jul 2025 09:18:04 +0100
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
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS0PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: b9feab59-6bb5-4256-1449-08ddbd2ecc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzdoSG5EbEhBc1JQK1JwYjcxNVhVYkIwNVhrNmh2RytiMXdENDgzU3k0ZjBh?=
 =?utf-8?B?Tks2R21JMHF1V1FveFlJclJ5aE9lQ01kaFhWdDgrbFR0TkN3MzByZXpnb0NX?=
 =?utf-8?B?NVBIQ2x5Y0RkTXZ2alVEL21Ydk5qTGJaV3VtYzJYcGdidjgva09Vc0g2dEJz?=
 =?utf-8?B?Z3NQVHFOQmN2MmljalZZOUFESitMMTdKR2c0QjZVOFZWaVpkemVwbDhmbitC?=
 =?utf-8?B?aEtuSllxQ05lZmVOcVZMNGlvUEFBc1NqbU5KRGhJYXZrb2xtK2F6bFBIQ2lw?=
 =?utf-8?B?NEZWZEY2NWpRaFkrdWVwOGF3bXBuYXU3Z083SWd6TnBmcnQvVEMvazVVV1ox?=
 =?utf-8?B?RVh6dGcrNUdFd2c3TDhrM2JGZEpyUWg0RS9UenBEVjlrOGVWTHpZcDllOXNz?=
 =?utf-8?B?bFNkNk9hVmRlZlB2RE10S3FtQmRTTGw2eHRaV3N6bEl2ZjZ2ZSs4UHVnZmdh?=
 =?utf-8?B?dW5ZK29oclNGOXhQdmJIZzNSRFI4Wk9LaTUzSVk0TlB2b29LL01SaHo3WDlQ?=
 =?utf-8?B?bk9UcjNhVVpsaUI1UVlQK3R4cTFQSHU2dFE1bVFkVkh5eGJBVUFJeDJuRWtK?=
 =?utf-8?B?T1NyeWlxdnhpMUNlNjNsVUo2Ukg1MFpYb0s0WnJSVHZVdTlKZGszTDVkNjVj?=
 =?utf-8?B?eUEySlVIZDZrdDFnSVc2T2VZdTJYN282d1NzVU1LMjA4enVlZ2l1T2pKdzFD?=
 =?utf-8?B?S3RkeGJ2dGUvQkRNVEJWS25iNFg5OTBQN3hRc3pzMGlaczI5QXp2c2ZFS1hE?=
 =?utf-8?B?MlJkY2s4WUw4V1gyTFJpb2lWQVBSTGd6eDFKOXZOK2dDWkhPSjhiYmROYUR6?=
 =?utf-8?B?MzZUMDljUzA1MkNEYWduNnlFSGFUUHMwZlpHSGFmTEIySHNmOEVDd0VZWm9r?=
 =?utf-8?B?Nk5aSmtDb3dNclhaUUZ0WE9lNjYyNUpiZGFmakFHY1UxWEpDd0NHSnFCenhE?=
 =?utf-8?B?UHh5Y3BFRk5tcmFCUUJtWC9WcURHbmxvTFJRVVdqTi9KWWdtQmxaY3ovb2JM?=
 =?utf-8?B?aEI5L2hheVdVT1hac1hjQ1hJRDBMdS9BT3ZTV2JxOHZnQWJ5bFlFTUduQlVs?=
 =?utf-8?B?QXlSMVkrMW1ydm1OcjdicW5rczdvcWVPbjN6RDBPeFhVbm9QdWh3aDVlVHdw?=
 =?utf-8?B?NHRBcHlWOEVPZGtYM2JCQTRKT2ZPWjdtZnlKZzczWFphRTU4NGNsWGs2Y3l1?=
 =?utf-8?B?VTFMMTNkZEc3NXozK1J6aTAwVFRybXhGUlRGbkRKZDRMYkZnN1BpTm1ER3Vv?=
 =?utf-8?B?eHJ3bVNGNHNrVGxqczNxUFpJY3pvWE8zWUJWaTNxanhnaTZ5UDFzSHp5VWxw?=
 =?utf-8?B?L0RKY2pDaWpqdEtoeGY1WmE5SFFMZGN6Y2g3R1pGWTBkYVNsYk1COTZBTnQv?=
 =?utf-8?B?NjNZdU5VcHdZalYzb1NnNkEvZlRrejl2ZWE5bzdqa25UdEhqdFVtVi9odmlo?=
 =?utf-8?B?TEtJRS9saCtvYWRjb21kcVVYSnBTOWt1dW16WXdxQVdka2RhTkVrN0ExZ1hF?=
 =?utf-8?B?NUlSVHpzZU1rMHIvSjhGMlcyQUNkay8xNStKSHFEY1hUclY5OXdtbXdQd2tI?=
 =?utf-8?B?cmhhNXNnc3hSWE13MWVhQ29CUW83d1NERFI5SVVqQ2NNZWdDQ2hrQ2xwR0Z3?=
 =?utf-8?B?QzM4TjUrL1JXYSsrNGxBL2N6R0tsTVJ5dS9sUVNnU3pqMG1OZnVUQWRabkd3?=
 =?utf-8?B?T1l2MzEzbGpDNzBFVG9qR3dMR0kyTkhndDBiZ2pBdkp4VC8vL0VyRVIyZFhS?=
 =?utf-8?B?YlhmbXFHVFVxckpldmJQT3NtR25VV0Q4MmdCWVhSVmJjQnZNMVJUZVRBdVBx?=
 =?utf-8?B?bi9UT3IrMjFDSE1LUVZzeXBNYzlVZHNjR3ZFQ2kxUXBmVmo0a2pUSGFCUGtp?=
 =?utf-8?B?aVdwbWthVisxY0hjeVVkRXl4ZXhyT3pKL09MZXl4Q3RKTVl2RWkzMW1xcmdY?=
 =?utf-8?Q?BkGUnlhIyJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3AzTXRTcnB4Ylgzd251VmFObU90OTE1THE5TkxUN3dFNHFBSG9DVXU5UkZI?=
 =?utf-8?B?MkZYeU82bThtMGRHSFNXMVpLNHNDNUR2V0VWTHJtMk53UUN3Sk5tTGd4Vk9G?=
 =?utf-8?B?dTJxcWxpZEd0cGQxU2x5QUQ1bVBnRU9EcWxtYWhqSlRrU0hSL09FaWdNQ2VL?=
 =?utf-8?B?MEd0cFZ0RnMxRGFacThWZ282dEw5TDVVQjVZbzIyT3prSzZneXZ6Z1A2OG9R?=
 =?utf-8?B?WGkybkJ0ZytyU3UrdTNZRlgwd0gvemhTbFh4Z1owSkJKSitzd01Ha3lKUnBW?=
 =?utf-8?B?bnV3dXlja29OOUl5b2lYZnIxdnNMUitHVVByY21CZmF0VXQ5WmxHeTEyN3Nx?=
 =?utf-8?B?SGR0UVlYSkVINHQwMXF4VnlReUxnSXF2TmRybTByOFdGaVk5VnFqK24wTWY5?=
 =?utf-8?B?UzlrQ1lBQ2wwWVRmZEpNYm55NDhhRnZFaU9uN3p5V2F6WTZZUDZ2cFczaHda?=
 =?utf-8?B?V3ZlV2FKL01sczE2K3JKUXhVSm9ETDcvMUNqTGJnQ0VZSnE2Skd4a0RKdzhH?=
 =?utf-8?B?T1ErSkFjNkZteUFsczRVUTJORXBpSHR3VHc1eUg5UzdESVZBeTR2WFZ6Q2NM?=
 =?utf-8?B?OU02c05DTXZITTZVV0hhSVg5b2F1U01YT3Y2MXE0NkVLVm0rOUpRM2J6Sm9q?=
 =?utf-8?B?a2MxeDFUb2lXdi9MbUZmQ0MwYzFIVmN4NFVmajNFdk8wVENzcFZFUVcxZVh0?=
 =?utf-8?B?WjVRVEFKOFBmWXE3T0Y5YVgyd01ZdWdneDNuYk5MaFpGVzc2ejJZeitleVdn?=
 =?utf-8?B?MlAvSmlQV2NTdjBEYk5wazVORExMaENzd2Z0L3lBL0ZkazFjaFBoK3hXN2tr?=
 =?utf-8?B?V1BOVEJYdzVaZnI2dHNJU2d3akFKTlVKdFZsWXRHcTJKalllTDU2T3pUUjNZ?=
 =?utf-8?B?UzVyV0ZSUFVTTFpZbjZ3RmN4YTd1a2ROUEFMYlQ4bytzdSt4TTMySHlabERm?=
 =?utf-8?B?dXNTbkYwZzVpeGU4b25CUUY2dDEzcEM3MkUrdStoZFN2d0xsQnRIalF4VGdy?=
 =?utf-8?B?RGx0T3dYRXFKY0NMZTFJb3BFSW5PaWk0ZGppN1ZuYkI4Tmt3RmhiSU5vY1Js?=
 =?utf-8?B?UUl4eUpaNEtNSWdGYlk2b1YzTFgwS0JnK0xNMG1EOTBPc2hDRDZOVFhvdmVU?=
 =?utf-8?B?enF0V0JEOE02NXV6aitmNW9qWDcrdEpqeHlpYUlQUnkrSXNpZnFUaUY2M3ZK?=
 =?utf-8?B?cWpCZHMyNUVhaVRrN29lbE9paG4zcHFtNndUakEzS0dsZ0JJTllUWmhIMEZl?=
 =?utf-8?B?Vm1udDB3ZGwxYS9hMHNOaEFOcGlLbk5RbnlNSE1MWkUyZko2UlRjbVljVW90?=
 =?utf-8?B?L1FUSWFOc1Z5Njhzckl3OTYzWVN3Ykd3N2szYXNVMWlRTFgwUjR0dDJMUTBI?=
 =?utf-8?B?WGRyTHZEcUdPS2ZwTkJOODUxZE83UG13QndoQXNwUXIwNzYyVkM2aXB3R1RG?=
 =?utf-8?B?Wm1tRlBYbTlPQUlkWG9VeXdpd3JsWVpWOGxvUkNOSzVZTnlNYXJBM2NKbUl6?=
 =?utf-8?B?TjRNWElqTmNGTWxFRXVIWTc5dmR5U2dnZGlSVVFRZytYTW90bk54dkJPTmVS?=
 =?utf-8?B?Qk8wNDFiak1DZ2hISWVqYmErSnV6c0tERTN6bkFYelpxeUlZL3NkZUNxRW93?=
 =?utf-8?B?K2o0Q0gvR25WUVFCVGcrbENRZVFpenRsa3pmd3Nqek40RUttVjN2aEE0WDdy?=
 =?utf-8?B?L2QyeXF6YWwvbU5Mdll4MmQwMHY0WkpQTDB3ZTVJTWhoVUdVTVQzYkE4ZlFJ?=
 =?utf-8?B?OUt2RXdyZFNSUDRZQWxKSjNZM0VvOE9JaEVQdEZoSkdMa0tjaEcrTmMxY1hq?=
 =?utf-8?B?SEZKQjVCVGFZVjFBaUtEOWwrV1dMcE1nQjRLbmdRdU5HeU54TVFMZGFRUG5Q?=
 =?utf-8?B?L0l0VzlwQVkvSmxVakxUcWVreWJhNEx1N1NLREI2WFl0UFNxU2twL1JIMWVC?=
 =?utf-8?B?bVlYVWxUWWJTdSs4cWdZdG93VW1mV1hNM0tFd3M2NzBpTFMvclQvV1VkZE9N?=
 =?utf-8?B?V3RQcnFDdkJwdHdINEUxVG55bmVRODEzZWNoYlIrL016bG5pNnRiZFEyNEt4?=
 =?utf-8?B?VHpTVVFHb3hoRVpHZkpkTE9HTmpMV3F5Z3FJNkx0UGxOM1hHSUFVNmU4c1cz?=
 =?utf-8?B?R2gwSk0weVBuR3VmRVg4Z1VXNHFPZkxDYkdmb3lkVTIzM3NYMGVBQkRKMXcv?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RFOf4TJnRE5YRT6Xk4ekTrDoX9HviZIpi4vBE2Gz4Vsyrku+GLd2MYxwF+XSIjhCtqDQZhKXCRLcpz1FGulOf/QWb3amWDQT9sPK83JCuNk4koJnS8dRyctsegKpfkGxTzAGP+0dtvQANWDstHbecN9gVWLxvjPW6bZo/rx+FrY2VfZGpgVdyB/djPoTrsAwXlkTpXg0iANB/RLNEz76TMYnY6YBnbIWDe42lY4VSdLTSjPCDeK8umU9AAYcnsNPBJTte6t/qeV9AR9CrvsKCAOv0ChZgRTg5J2++byQzppXvAe7BFKGuCpRy5As5ESR4SnvyLZHIsgRpPh2mS6h5oxKPngqgnDE2MpTud6KxExd6wYu/vs2ComDP8JKP8vAjqsYR2YRz9X/iuGb+aIYoZQXEXH6MGltlxB7CLPiea9cqcdSKJfDNuO6AQCiHlFkVKQl53TT6DObBN9+32OKbphmPFDaHjuJ/K6HbxCz7AHeGSBOOUZ4f68CLnE+MumWJWYJmBeT278ioglmXxqcEdkBzuEca/KaV5rYse96bTWHGxgEs8elimclWTq19K3sb3ENsdIhe5K94xqkN6TJyC+mj7LQBnsx0tVLlG00IGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9feab59-6bb5-4256-1449-08ddbd2ecc6a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:18:05.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO/ROLEHyITsdwXapcsrzXhbdkIRSapQ4piqu7n8lOQeJzLDKaa5PvtV1pnn6uaUW0eyywfw4tkIOx5d3rPT0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070047
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=686b82c0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Cc7NKFOM_BQP7eMaC5cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: msETlAI_puLZ0rTYahlJ_7dPfxi0tVl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA0NyBTYWx0ZWRfXwlsuBM75H/8j 2ag9QC2334TBDjF91SiI432vw6xXWdz3XRqBmitoyyAhNfLyXlmjC7FZxlSaq08OkCErDELNUrI vL/6uJoW6AebL8u5Gl8LAEniUJOCvSKEZ3juhdHHEQRg2OKcdOJCrTST2rC84f1c58vCBQVylk7
 TiP303dho93pRiUGuA/TL8DuaNS5UdMtWXm6POv+414PQ3PH+BWJlg2NdlOkZYRZPBmJ5S6ExIv K7CfEqGNrar4CrkdNHFx/2no2tynlmHHZ4oT3vjYRNe/mqbjax0QuVD4lKVwMoyVEbsYNLNsycV oUvnlqKduJ2TEgyia4pLpKm4VMikH5bDyZmR6JLBEwc4LUCogijcYN+h4hJ638/lXjqZhpp1DFF
 e5sMauvIucBAHkkdL7hsQ+wV+vZGl7fQOB80aCLX7vRlWmOUMUakbo7o05ob49I4Yylbbo2U
X-Proofpoint-ORIG-GUID: msETlAI_puLZ0rTYahlJ_7dPfxi0tVl-

On 04/07/2025 16:23, Ojaswin Mujoo wrote:
>> Hmm yep this makes sense but seems like we don't expose it yet in
>> xfs_io. Will need to add that support as well.
> Okay so thinking about it a bit more, Im not sure if capping to
> awu_max_opt is the right thing to do.
> 
> There is no guarantee in kernel that awu_max_opt or even awu_max would
> be smaller than lim->max_sectors so why to derive our io size based on
> that. 

Absolutely. There is no guarantee. But generally it would not be less 
than lim->max_sectors. But lim->max_sectors kernel default is 1280KB, 
which is quite large. However, there are other reasons why splits could 
be broken. I am just giving the simple example in lim->max_sectors, as 
that is configurable from userspace (so useful for experimenting).

> Further, handling awu_max vs awu_max_opt and their different
> interpretations for XFS vs EXT4 etc are adding uneccessary complexity.

You could assume awu max opt == awu max for ext4, as we no there are no 
software-based atomic writes. That could be simpler than my previous 
suggestion, which involves a kernel change.

> 
> The simplest way seems to be to just limit the $blocksize to
> something like $(_min 16KB awu_max) and hope that 16KB is small enough
> to not be split during reads. We anyways have other tests like
> generic/1230 that can be used to test larger atomic write sizes
> 
> Thoughts?

As I said at the start, we never had guarantees of serialization of 
reads and atomic writes.

However I still think that this is a useful test. It's just it is 
theoretically possible to give false positives.

You could get the test to read max_sectors_kb, and check whether it is 
greater than the bs. Again, more complexity.

As an alternative, maybe it's better to maintain this test out-of-tree. 
I'm not sure.

Thanks,
John

