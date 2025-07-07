Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD728A3EF
	for <fstests@vger.kernel.org>; Mon,  7 Jul 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875374; cv=fail; b=TTC8niUKhaClHsecTUEZrd2g3annZ2RUhNUA4BsU8uqOWM0fXlGA0SvSeT21UCy4DUBOeWMBFlyst5LUypQ8ZCKe8LD+7FgMU/IsNvclsBuaKcq4RiMB5EdsKrkKgp6h9jAIKMzJfW8vS8lT+Q11xHRERpKcnn490slQD9RxmH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875374; c=relaxed/simple;
	bh=KYN//NyxjBcFcTghzzXI4Fr0Z47GlNVAFjdruE7rRvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdlV+nCcFO6h8MNslDUh1U07EHL+MSQrGMAHWvOGa+cAl5e4EoQfEjRTNlKVqjE4gPG3975wH8l4I5VgPjV/X5Wnf+/8J1Vb3On0QbuV/Nu5IEc85j+wMzTiLMlswcz4n+HhzGMMUfnQzR7Hld6KEC60mXS9AX/ZDM1CoNPxZok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a5PEDtl4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KsDb0Tie; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a5PEDtl4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KsDb0Tie"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LbxLZ032523;
	Mon, 7 Jul 2025 08:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9IY5AEDHIiLZmI7Cva5gPyFe44qaoQYMLGV5X2gS/MU=; b=
	a5PEDtl4jvfpmXBZ/dCY2P7u6LOwM0lulRqiLuc1qnkjjCQk32lMZ6rxRYU43nmL
	d5ELRQ4I8AHiJIJxveVKVGgTuKB7e2DbMXGyWk9E2jo7B7enVxyOYpM9NvUF6vQ7
	SLhWwL4tm7uHDDMoWjQ54g8B36H+egD57jHotqTZGbda8BfRL0/478Qg9DZnfFyN
	ggKyfVej7EDN7fHTt3/7ATHm5klFSwSHuu8eSViGQuINCo6UwInXQXZW3m2T7qrc
	xJCNHrIo6yABqHlxGhZitPf++6pFbJTvhIPUsjLXj/GdvTjTKMooMk+SsRBnHKUZ
	ef3iXMssYSQwsVvRqHzRyg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptu7j87n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 08:02:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56762Q5M040477;
	Mon, 7 Jul 2025 08:02:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg86eqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 08:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4K9B/ig5T/CPnn1z2ivS47h/eR7uSKGcdcV6NqqpRjSik6e/dda1A/wrDwQgRdS+gsqxgguzQRK8/Yfw/4ZSaNR1soc0/cL5bC044UWVoa0WDWdnyb0ZaxQH0fAXpNZGAIxVqeCxVwvJM5GTAj51nwyP/WhFI3YlbHKdzN5KGKsw4jvQLuw7atliNnhUwnIicpcpAjq3RDonvzGw8x5Wj8pjSc/yhbpdabs+JQYD70VGbiUbqcgV5iZ9s+/OsEIXYIVgQhEZVfx17h9P08Fh5yvv5KrC9G510sKUjpIQMsiao6HYdK/Is6T5iqEE6J4KF/6TlcTKsBYUfefhUvYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IY5AEDHIiLZmI7Cva5gPyFe44qaoQYMLGV5X2gS/MU=;
 b=xYsSULXZ/QTIiOcaq3Uz7u+omjc/6KFfCxCbiyUDNM4uqOSdRGt4R1mlfbYb7LmV//cJNKzaAhOPLKg/qivqg7U7icmgtqOtBAjDEtH8PKNTnS5YosbTKQZUwcNbjeoXF9jZhEKyzdOTT3F7gcOML1ugifdoM0kp04XGOTTDHDiC+JzMZRz6kNKvLxqeFHVTg9lk9U+K7Z5/anePmJhPK+b0+BZl4RPBoHIa3wNEsVxVJ1CNSxe6zwEh7HgQzvJH/ZgIIh5qo+ypphzlToYkuq4r2nQY4gSCEAGj/gd6s5vDEL9YKGkhoRYDOQt6zPPZsxhdB78TGERrdj+HtgYChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IY5AEDHIiLZmI7Cva5gPyFe44qaoQYMLGV5X2gS/MU=;
 b=KsDb0TieLoRc5D+lMQSrDi43J4KYf4Am0KJuCYSQQDNcAmtPNSRcYY5HOwyNmQytD8VgMKCzkDLE0STniOaLBJRgYku1awBA9PD/fFevfpcenfpUPVNmBVGMk9jRhtOK7i4w+UlszcHuJJNszC5YpsrV7Yf+h4kGZR7t5Kw3aTA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 08:02:39 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:02:39 +0000
Message-ID: <ea53b415-7f54-4e96-a9a2-43c71e2b722d@oracle.com>
Date: Mon, 7 Jul 2025 09:02:38 +0100
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c6356a-ef1d-4f35-bafc-08ddbd2ca48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05SOW5ITEVvZ1p2dVJoT0hEQjhPWWJTeS9HUWtVTjk5aGpVZjQzT29LaHRY?=
 =?utf-8?B?R3F5WWRMbXFZSEpUQUtTU1NXeDR3V0ZCckE3cVhaTU4xdGZNeDUvNFpRdW5h?=
 =?utf-8?B?VTg3N05PVjZFK2Rmc1UrbHJxSGZobUZJajMvSUIzQ2ZjTnZlUjMxTlhFaUk3?=
 =?utf-8?B?K3NzYWI0bS8rcTlTMnc0c3kxKzJqeXRYS1Z6aFBlRWxXQjZzRkdTVWMrM0RZ?=
 =?utf-8?B?SDlYUzVGNU02OE5peGZmckd1RjFtS2pLSWVzL0xNeC9JNU5EaHN5bGNscWVK?=
 =?utf-8?B?RjZpejNuU1UwMzA2Yy9HcGdpTlltSUFrUFk1aTRadjcvVTBjMXpwWkRPS1dH?=
 =?utf-8?B?N0NIMVhrTjlld0NKbGNwVVYzUGhONFl4MWNBN21IOE41ckpqa2QwRTJwdkJt?=
 =?utf-8?B?TEY0QlRMdUhmNS96S0NRODEwTTc3RlRXOVI2SURtdTJMNTlSckxSckJJY05l?=
 =?utf-8?B?U2p4a0VjRklkRGFObDkvZDNCcDZIVnJMWUlvNTdkSklEcUZYL0s3cVRPS3FM?=
 =?utf-8?B?ODVwL2hsakY3OXYrWXZ1ZEFrZWZHR2NiK0FDeS9ucHNEbDlxRTk4YnNTUDFW?=
 =?utf-8?B?T29UWFJpNUZXTkRWT1NOeFNGNm5rSmJHV3Vkb0lacWdUbCt3OUpNR29aQ2hz?=
 =?utf-8?B?ZGVEd1htVHRiNy9yZWtyeUlYcEMzSWlxOUk4Y1d3NmxnREwwcnQvVDd4Q1A3?=
 =?utf-8?B?QWNEeitVV0dDbjhlRjJ1KzhnNTgrYS9UL0k3TG9PaUtCT3kwRzdHR2p5SFpn?=
 =?utf-8?B?MzF6dmZjcXJmdzk1UXorSTJISmJEbmFLa3hZOU50NnFQRFdXam9zaGNWeXVW?=
 =?utf-8?B?N0VsY3ZtWWxXVGtVeEJzdHBMTTNLRERERFNraVlwRTRmNlUyVjdWcnlQWG0r?=
 =?utf-8?B?eXQ5NU9YbW1mbXo2c3lWdVBVeEFSN2FCRWFmVkZSVWlCdTVlTTVTUXdDdkc0?=
 =?utf-8?B?UnplY3cyWkJoVVZOQjdINGs0Q2JIRWQrcGNTbzlUelB3aDZvd2dIRHBIUGFk?=
 =?utf-8?B?S2NFR2x5eFZlakU2WFkySVAvYkZXdjEvRjBkQnFnYXJkN1BoR05ONGFZRTFv?=
 =?utf-8?B?bldvTjllRTZybnFjbFYrUTBHZFhBL0VHOW40bWw5SlVUdXRPVXA2Q2ZTWVVV?=
 =?utf-8?B?aDU1S2h3djdNVG1GVmI3RmE0Z251bVlXb2JUOEJOUXE1MUt6eS8xdWFGRFVt?=
 =?utf-8?B?dSttSSs3cHJibERLVzIxbWNkbnRpY1NzOS9xL2Q3ZkFkMy9GZ2hYZGNZbmJF?=
 =?utf-8?B?Z3dGUXpSKzhlcy9COFlWWUxTWTBsNTUyb3VJNUY4cDlsb0J6ZUZmR0J5dmpz?=
 =?utf-8?B?N3JzTTBOZFQrM3dqVmRMdHdaZ0cyMnFkUmkrMm1xd3RZcnB5WWo4aUVTTy84?=
 =?utf-8?B?Zkxrbm1ibDBPZlFKNDlhQ0xpWitQR000U2JnQ1RmTXN6eHd6YWZvZmxvNFRl?=
 =?utf-8?B?bUxEd09rakJmVGtnUFpxUURqRVBSL0h6RHZrbWYvTExUWXhDelo3QWwzVllr?=
 =?utf-8?B?cDRCajRNRXZaVDE4TVRCZG1ZNE5ieTRaTFZmQUZ2bEtGWHNWMk1RS2Y2ejZG?=
 =?utf-8?B?M2dCTS9meUlJcmdBaWZUTmsvWklQZ2dLWmpWM0NtZk02eUs2TUZSM3ZRTWRa?=
 =?utf-8?B?UUgrTVRRSEpHNFdGM1djeGk1SkhOaFhjanNGa1ZKSUZSTCtSNTVVcUZyTHpq?=
 =?utf-8?B?eWtZdHlDSWUvSmRPT2dLdlJJYWpGcFVWZTVZNWd0Y0NGcjhRWEU0L3RKNHRK?=
 =?utf-8?B?UGxPOXRlamcwdG1GU0lnRzFweVd6eFZhbEpSL2RtR2VDb3oza0QyY0ZUcDV3?=
 =?utf-8?B?TjNhTHFnbWI2VEdyV1l3d0MxNW9jazNZVnM5Q1hrU09hc0xuamJhSW5ONkpM?=
 =?utf-8?B?TWZQUTFNOHdIcU9zWnM2bW0waTFYOE13OWg5cHMzS1E1N2xlYlB0b2U4Yk5N?=
 =?utf-8?Q?gFhIyonCX9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVUzVWJYWHlhbXNMeWcvZUtmazNsMHBrSE9CVFdjcUdPZDUvdGtGd1V2R04w?=
 =?utf-8?B?VFNqZFZHQXNubWJaNnFWY1dGWGxxYkRvZm9mMEZBZUtibFVFaGlMMkZzT2Jx?=
 =?utf-8?B?bVJ3SE5XZVZlMk9iSE95RmpLZDJobGFGNEM2SVhnZEJTd0RXVkNnTVAwZGx0?=
 =?utf-8?B?SlBMc25idVhQdHNOS0dzSTFQbzc3MGo4WnlRWDMyQ2w5c0NWbHZtbkZ4WGFC?=
 =?utf-8?B?amMrUEVEQjFYYlg3Q056WU41QUxlSVBoVWRVUHRNbjA5c0dPbFRZMWUzZmNQ?=
 =?utf-8?B?dG5jejVDZ1E4VEVNN0p6K1QvYVZYSlhpUVg2RnpmU3ovSFBDRGZ5Y2g5ZkFs?=
 =?utf-8?B?SjZRV29EKzFhTFF4N1FpVytyYk1HL1VDeEdnQ1V5UDR1R2lqSDIvOUZWbTV1?=
 =?utf-8?B?eWNNaENhcVBUQ253MTVRVDVoV1VSaTF0cGRIdXM1QVlkWEdvTU9ZT3FKWFNH?=
 =?utf-8?B?V1hsaWNTOVpCSmtFclg2OHMyQkJjdDRoUXlncUFZcCt0YVJ6SlJLWmREUGg4?=
 =?utf-8?B?czR6NEg2aCs0QlR6WWtrRFNHVk5XeVNKbDlGd2k5NklkSTVQaWRUb0hMVWMx?=
 =?utf-8?B?NWM5VHRybnNnZnZsdlBNUzkvTEh0MHFSRit1bEU3cENkWmQxMHgyN2FoWWVp?=
 =?utf-8?B?ZDFhM3JTVFFyMFgwZVJ3TTR4TkVROWh4cFZuL05wR2VyRGJEc25JanVNNzNz?=
 =?utf-8?B?Zm82TjVxVTJNUmRrb3BVZ0swTjJjYWRGL25VSzFPakJZWTZkOWo3UXpMdEtJ?=
 =?utf-8?B?dW5YODhweGM1V0cyVTY1R1lYdXhPdkwweXV3WkVJcmtpMDl6dWUwZWVuVTkv?=
 =?utf-8?B?dHU5eG9nd0hmNkp2dnpuN1g4TEVUT0c5S1pqZHpWRTR6cml1R3lmekN2ZjVH?=
 =?utf-8?B?dGlUMDRGSTNtbEtzWkw2Q0FZQi84ZHl3OUxoMU9VZ0N5NXJMRjBkK0lPbW1H?=
 =?utf-8?B?aUNLekpqb3hUODNPSUIzNnlMM0FRV3owWHp1M29mYmRFWXpuenBLSmFCaWNo?=
 =?utf-8?B?UFUvODduL0kxL1V5eC96bk0zTDFpRVJFR1VpZnF0bWVoOWxvTVdTVWtDUVNw?=
 =?utf-8?B?TlFEU2FtK2dHY3BKa2tZOVNLNDJXNnRyUUVtVjJ6QkFVdTRYc3d3K2FZK3dT?=
 =?utf-8?B?NytWQmJ0Qm5sdytuK1FCMVlsQTVhdnZzdjl1S3RLejl3SzZ6VG1Tem5wWktk?=
 =?utf-8?B?a0FlS1Q0ZENuMHdMY24zejdSQWVEMm5jOEh1K01lSDZhanh3QmJkMnlsajZV?=
 =?utf-8?B?RmREZlY3MTcrZUZja2RBQ01aKzcvaEswdVRBUEtaMnJGNW5QeldQanl0K0cy?=
 =?utf-8?B?aWpkR1F3WjdtbVQzRWxQK0NGZkZJbjNYV01JdElhdWNiZ2c0eUNIZk1oVDhz?=
 =?utf-8?B?ZnVlR0NJT3VMUytVNlFHV2crLzAwVkZNZFcwYy9tek9IUG1PVDgzc2w4azZp?=
 =?utf-8?B?RXdmS0tTTGd5akFyVGViMTVmY0hidm0rRHh5b01uL1BEUTRKeUgyL2FrRGNI?=
 =?utf-8?B?SVVBZGNadTF2eEdONEdVTm1taEhOTFpOUzhjQ3F4R1pJVmUyUXpZdlRURG5n?=
 =?utf-8?B?RzF4Vk9aa0ZJRktNbzlUdy9FZ3lNZUFsdjloSEl1MEFETDlCc1lRTHBXdmJP?=
 =?utf-8?B?aStyWVpSbzQyVmlwRDhibnRSemk4UTBGK2U0R01jNmpwRnJLWGE3azlGL3dP?=
 =?utf-8?B?cExnY21DTm1pRGhpck1MTTZxT0JXcHlNK3U0bFFRUlpPbXBqOThHdmJGRCtC?=
 =?utf-8?B?S2FTcjVtcTdjU1hjcDdyZkM0SnFzTUcxajhoWkRrS2V6R0RRZHpjRG54Zy9L?=
 =?utf-8?B?YlpxMTlMMmFRWjlLQnVSOGUxTUxQVEFqbTFPNjl5Mit3SUhNeWxEMUIxdGxw?=
 =?utf-8?B?Nzd6TE93cGlvQWZQaEFBVGR0bkpYY0RuRmVpVE04SG9KSG01ckhIWFhBajl3?=
 =?utf-8?B?amZ4UnJFS3Q3MWpXKzNOS0NnRzlKWk4xZitWTWdxbFVFTTdCNXlRcDlheExE?=
 =?utf-8?B?R2hXdjZoeWRyd04rMFkxK0pmMXh6MHh1NnZsclhUV2Fwdnp2MGZERGU3ckJK?=
 =?utf-8?B?TGhVVFQyRms3dmg5QzhTblBFelJFbE14dkg0Kzg4YjllRCtFbFVZcjh2cGxG?=
 =?utf-8?B?Wi84M2ZrRklJa1QvUXZtNHJLS09vekVxTjJ2a3E0aDdMVmRhODFjS04rdGFH?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zsvfhydP4dBs6R31vKWLtHHndj+8PFd4yZoxvoEUcTe9DhtZO3bAuEVwrSpUA/aZHz+sbJl2FqC83ZS7qT0cRBntdkboYP2axfSsryLnE1Sk5tYPUXaO3RWSrrmAUi+LUoUxZ5Tac6LSbYmdaQAyG6nnjkuO9ebROWSK8CNGkTl3C4ETN7WfCGUxHrD9nHx+tl84WMXhmH2MiIzYPTPdc38/CLeujfCRT8bD7yAM7mY6lTMKLEZJe1+vKRY7/Pzr3ujwSni7gtyvEsl6vmNuZswDFGit5j7xIp6fAa46TqhJVBTVYo4KZP/IWmzt0jZCoOqJ6+WoCQZcrhAQ8XAeMwuxOC8abYEspg9s3Kfd5XF/yEaz/fMlNDrTL3NRHW1Mdch1rNd6EQ1bj6xeNRogDtpNR8jB6uUN3OgANYU+CoVUgZWIi+4M3qBO7SYBnttjAaTD7XxjOrmRHLlrwq2px/c2t5BSBzsUGm6AiiE6Q3NaIt5Z7GVZzsN/EM76SZimydwZA0rYE8gJkefxov7KSq3t+4Rcn+4i9c/RbM8qjEmuPb+6dt1w2me/m+9ro/41PT21uySqYbExub+aQ7msRh7Z5u6sp6ZQcIovMf/KYy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c6356a-ef1d-4f35-bafc-08ddbd2ca48a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:02:39.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Im3CbScLSUhKwZDiwsLOvVPwU9E8S0RfHPccF86jEcMhublXw8tqo6J0v9rj8PTdNPiW28GFg5eM4C4hTU/++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070045
X-Proofpoint-ORIG-GUID: Xa07aQ0G9uz2nSqXrhUDAc9vpwsWBDGe
X-Proofpoint-GUID: Xa07aQ0G9uz2nSqXrhUDAc9vpwsWBDGe
X-Authority-Analysis: v=2.4 cv=IMQCChvG c=1 sm=1 tr=0 ts=686b7f23 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NqNPGJmPfv112A-HmbIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA0NSBTYWx0ZWRfX2/aoK3dTwd8v k6nlk+9mMn+nDn4Ep9RLXty9jV6v9QnbR2r4fzU65xYY/ljJpNwuBL77pAY0B9xP2qMe20RYcWO XEmoEZSCdrT67ToogxU9gy7Vti3CK3VXzAHVYyNiBk42e0aH7ZhV9fyLQcIJuu/TK7f3bTP0gG3
 7nh5Q9dQaJU0FET/rqkPp0T2mfr32hyZqq+IDC/zLZWLPq/1DB8YaMTVGrJk5tUH3nJntBZ+2rz 7J3OMqMg3BuQqhzg4qyGLKUUgnkEJEmh1kCS1BxNzXlV9Shy6qfy5aiBcaf3cooL4z8QQZtx7rc +yaaxBzWRRMhzckBLh7/1DlkDTQMw8UZkZzMCS8QvZcun/KD7iYm+YmToQ+dOGk3CArKwPytm7l
 8Dh6S7epGybbtvyfiqXfiJzXnfPsog4jOo0hmrmb9nyVCmrC245XCQNZpldV6qy7CXJovvUV

On 04/07/2025 15:35, Ojaswin Mujoo wrote:
> On Thu, Jul 03, 2025 at 05:26:49PM +0100, John Garry wrote:
>> On 03/07/2025 07:42, Ojaswin Mujoo wrote:
>>>>> Why serialization matters here, because even if device reorders our read
>>>>> before the atomic write, we still fetch an older $blocksize chunk which
>>>>> should have the data and the header.
>>>> Yes, we fetch $blocksize, but it may be as multiple read requests,
>>>> so we can have:
>>>>
>>>> partial read $blocksize request, atomic write request, partial read
>>>> $blocksize request
>>> Ahh now I get the picture. Since software atomic writes might have a
>>> value way higher than the max_sectors that the bio may split at, this
>>> causes the reads to split which is the issue happnes, as you mentioned.
>>
>> This issue also exists for atomic writes based on REQ_ATOMIC.
> 
> Yep got it now, thanks.
> 
> 
>>
>>>
>>>>> The data crc should match the
>>>>> header because it would have gone atomically. What am I missing?
>>>>>
>>>>> (Or do you mean that max_sectors_kb is not big enough to support
>>>>> reads after software atomic writes and thats the issue?)
>>>>>
>>>>>> Can you cap at atomic write unit max opt? That will mean that we get
>>>>>> serialization from atomic write HW support.
>>>>>>
>>>>>> BTW, to repeat what I said before, it can also fail for atomic write bios
>>>>>> using HW support, as reads may be split.
>>>>> This one I can understand, the fio's read is split causing a short read
>>>>> and seems like fio is not requeing short read properly for the verify
>>>>> step(?) so it tries to verify against short read itself.
>>>> this is not an fio problem, as above.
>>> Yep got it, its the block layer splitting the reads.
>>>
>>> So as a solution, do you think it is okay to cap  $blocksize to
>>> max_sectors_kb or would you suggest it would be better to just stick to
>>> awu max opt?
>>
>> I tend to think that it is better to cap at awu max opt. If zero, then don't
>> do the test.
> 
> Hmm yep this makes sense but seems like we don't expose it yet in
> xfs_io. Will need to add that support as well.

Darrick sent a patch for that.

> 
>>
>> What awu max opt is reported for ext4 (for awu max > FS block size)? Is
>> min(bigalloc size, bdev awu max)?
> 
> For awu_max_opt is returned as 0 for ext4, since 0 indicates there
> is no such slow fallback. From commit
> 
>    5d894321c49e fs: add atomic write unit max opt to statx
> 
>    ...
>    When zero, it means that there is no such performance boundary.
> 	...
> 

Sure, but I think that for 1x FS block size atomic write unit max,

you can make atomic write unit max opt == atomic write unit max.

Or just always make atomic write unit max opt == atomic write unit max
always. I don't think that anyone will care.

BTW, you seem to have weird line endings configured in your client.

Thanks,
John

