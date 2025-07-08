Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2A2D323D
	for <fstests@vger.kernel.org>; Tue,  8 Jul 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973088; cv=fail; b=nEXQvfJmpX9GGlNDDn3x3/QMlZ5m41BscmVTo3u+fZgOk6KqG9aGJlHOZt5c+jyj9Tsq0SYYbWCk+iXa4UUTPn7IDDkcd+4BFJtZ1X50XC1GgKxkE8zWV1g29bekRiq4phrbRSfvtq9dHQiY8+O8rTU6+3B/do0o+IsTSfi06rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973088; c=relaxed/simple;
	bh=d7LmFW/oeEkniN6wYs+5/5TJZrrfsLo9oRctB8d6/PU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRrpuUJadQEJtYh8wx4PTZdTtFUhWuYJV9XceHcq/xlb5LCjFJJZxsGMTere+4DnOKh3/UFOxJ6uWQXE396nfiuidOXXZDpkSCYcg0UHmgERRqZZl5ZqXCs4LOGzPmiCWGZs1kBm6Z/Y//DVZ5FCCYcC88alQplROFhPDo45dCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r/5Vmu6A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rSr0tNGe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r/5Vmu6A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rSr0tNGe"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AvT5m025310;
	Tue, 8 Jul 2025 11:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nJQrzIthm3+zxudtBQy8tZkDtGzLIbT8dI1Ogm/q/yw=; b=
	r/5Vmu6AuDtgFPWj0Gg5UKuv/iErDZfZdiM54vncySREktbZIMzGmq1Xx9xpsEi4
	CdGnJXoqolvsg/8xHJFeCuHql7wjROgzFkjs+kI45hXaa9Y3gb93DJkZZmcHk9+e
	2QHHqHDQLphnqUS9CRUT5SVBCs5PUbj0ZXlJO+DQRSpDrCuZIc6rS5mnAP1/uj2Z
	a5PeVXdgSyx2LsRibf/RR1lAc8nDc6JaawavqEk4Mko2+z23BidPy8I74kLNkIni
	SGW+Ga710rBa+DtyDaekdwdo0RNxniQ98vIajCp8nfPO4t0zIc6/fmQs8TO9ucjB
	99dERw4yUyVtrR4Q/hz4Uw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s218r0tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 11:11:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ai8Fk014184;
	Tue, 8 Jul 2025 11:11:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9fjxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 11:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbgDCiiigmPAXZ67E7pmaR6bkn9ZTie+ZVQP4lwWijiGZc0Jx81k6KAN/fPmHJKyEV80ATmB5aNBdwuSpohBIRoHSAFQ9m1CgeYU3AmhSWT6IP1bcMYbXSFjQuns/6iBdoJD1DAjxFaro0v3oenp4oBFL5gqErx6A6NpraivIR0F2GLU1Qc9gVAEkKFin/Qt25o3UiY7on48rgjrQCDRBVRdsVBbKN7DEbun5be8zLHLeUqPqd7YGMhODeviDEEGvbK3EcWWI6n4bm1lkQGzZl0OtzglO6cwRsS4rOv8NRDOt2v611ey+YMDJQowraQXmtI66Rygis8qUlmYz2ltqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJQrzIthm3+zxudtBQy8tZkDtGzLIbT8dI1Ogm/q/yw=;
 b=yB9QkwCElQ3hUo/0559wnTvzNowN6LLlTmEX6vJwg1SL8oBP38EzpWOujHHgvI2WmrQEogFKKyBk7iXLHN1mhbwfIreJiqcVLOLbgypfVeGPklBVXUH6Eo5e/r65VR4wN/rCMsBuFgq2eoDTlZmaX3BZvgh2fxub559WJZqX4nZNRqwqWwanDTnPAQS8iINuWHyCWj/szhX+m0V2GoRRmDGratsq9ns0aTjJpxT9wWfYUT6QZHJ38/JO41YbvJo0mpjQnArIoUhKVTO/fHWSC5f/BPmMPQ6VC/21SzaCWqhK2rCHFhAkUWrcZbTX+zeqxdgZtifV4ToORi+EncOCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJQrzIthm3+zxudtBQy8tZkDtGzLIbT8dI1Ogm/q/yw=;
 b=rSr0tNGeCtIX56FnOcXPhHOWjZpIaqlvZB6gOgT8qytOtAOonZiB9vwpf2JTUnaSd7O3lnw/Y4x9+G4QX3lgEj1YJRy3Zufu1TZceJAF0wTrZqjvuHjfb52ntrIFmQmXzbiC4Ht09poR6hQlqhafUr29d143omrT1We9OmLuEUU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 11:11:14 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 11:11:14 +0000
Message-ID: <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
Date: Tue, 8 Jul 2025 12:11:06 +0100
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
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
 <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY8PR10MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab44916-9241-4f53-e10d-08ddbe1026f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHVTU3IxU290d0R6YlJZVEtPSHlESndjL01Yb1lZWHZDeHFCdDByczlraXFZ?=
 =?utf-8?B?QWNDaXg1WncwdFV5dktyYUlZVGo4eGZ0SU42dmRuNTh2eWZmTmZkbXU0SkVr?=
 =?utf-8?B?YjNRWHlyamc3VTJmNzFGVUJqYmRQVXlzUEJnQzdiQmVxSkFDYlBGNkk5bGp2?=
 =?utf-8?B?ZC9rUXpPU0orQllyL3RvbUNuS3BIK0MzV3c5NlhWd3EwNnFyYzUzYkg1SnNZ?=
 =?utf-8?B?TXRsQm5aTm1kWHQxS3RtN2xzL0tnTmkwYzBKcHdyVmVXT3p4c1Y4U0swUlVY?=
 =?utf-8?B?NXFwdXp0RHQ4R2pKT05pa0lhcnpUQzR4eXBvRllVTVpFblBVMTd3M01VSjZk?=
 =?utf-8?B?UGprdEg0aFR3azRXMjEwbkFKaUpaaGdiSlJXblJMd3huWm0yU0NiQ2todmNG?=
 =?utf-8?B?TjRva0R3ZU5QWE1zVnhqcEpRb2hwbzFHWGNYV1FPYjJmRUNzazBTQndlOElK?=
 =?utf-8?B?azlETG9nRFhoODY3UWNES1ZZRDJrQzlBQUk5UXlhUi9SZUtKa0RrOTd5OE9t?=
 =?utf-8?B?Unl6TFFYa3c4VlFQUTU4TVhWbW9ZZDEvU2JaYTBRYnI2K1k3Qy82dlVsdTBF?=
 =?utf-8?B?a1UzWUhvbEp1bHkvWXJQbVRaSHB2WkNxbnFkU0VZaFQ3WDZQTGNzeDVJaUNo?=
 =?utf-8?B?REtxdzRuVjFENis5aE55YTNMSnZna0YzSkUwa0d3V1hRSEFGd1kza2NBaVdC?=
 =?utf-8?B?SkJpR0ZqQm01dTFDZ3RoWUl0eHRPMitCQkNoREt2d0JNNE9MQWZaTjczZlJO?=
 =?utf-8?B?N2djcFNlaVRlYmZab2NxY056bVZxeXhYazd5Yjl6NHZ4Vk55Zlp5b2gwNzhm?=
 =?utf-8?B?amI5OG1hTHp3V0I1eUNIdG1FVXR3ZjJoUUlBV2gzc3FRNGsva0QxVllTZzM2?=
 =?utf-8?B?OXJnblNDVGtDQitaR3BaOGZKNzdkWGZyWEV5ajVaWDBoTHBGMTJNN2d0ZEJ6?=
 =?utf-8?B?QWtvM0ZkS1FrS1piSDZ1RHpBaXQvQjFidEZsK3V0VDdHQnJIaEptaEh5ZVJP?=
 =?utf-8?B?dXQ4dWNqdzZQZHQ0MldPeEFVODdTL0hudFpoNWk0bnZwRzl3eTVCVWdSY3hO?=
 =?utf-8?B?eXF3a3R1cW9jSG9YS2RUdFpxQjg1TU1DYjBrbG51SkRmRHR0RGVSNll2bWtw?=
 =?utf-8?B?WldjSVVEUXcrQTJYcERnRmhvanM4WUFtYm1mMERya2lZSDlXaHowTEVxbS9I?=
 =?utf-8?B?RXpnMzB5Y09LMDA1TkYwOG8rNk5pVHJERW5yazAvZTl2TFlqc2xSbzdiWHNx?=
 =?utf-8?B?NnV6ZXc5UXJ1d0lmdk9WclpBdlN4cHRPZjFtQ2M1VWJ3MkorNktrZTB3VWhJ?=
 =?utf-8?B?OWdRUS9CM1VDUDZzUWhGQ1ppQ3E1MzYvWi84V3dXcVhnaklkaFJuY2xkWkFq?=
 =?utf-8?B?a3ZGanlJc1hzN2ZTb1hZMUN3VjhnYUVYTnJ3R2UyamJMUHBMZ1VqL2tsRlBS?=
 =?utf-8?B?RU9ocHRaVmVyQitzWnlia1d4M2RWTU9VaGpMTWZWb1E1NmxOVVhCL0Ruamd0?=
 =?utf-8?B?cUs1T1YwWHhqaUNxWE5nVTlsbE1QWmRXWGpPY0pTZERTaVlkSU92WjFQQW5Q?=
 =?utf-8?B?M0dlTWFHdSs2ZWdZRWJMUnJhOEhNSmFZNGxtbTE0OEdUVXI3Tnh2Y0hXSlI0?=
 =?utf-8?B?T3hva0IwK1ZTdnhMWG1vOEU5VG9WUlZHQ2orYlB0MkhkWlBsMWk1emphLzlE?=
 =?utf-8?B?bVEvZXZCV3crQVlLdkR5eExoNDNscjRTc1RsTUxBTFNxOExWTHhwSEpjSVBl?=
 =?utf-8?B?Z05BeVc2VWhwMG5Kc0dOSzBMQzVORFlNZVVDcGdDb2lDUDRZdmhjWmVvQ2Jj?=
 =?utf-8?B?c2E3WkJEN3p2bjdoWFV3ZTdKcS8wTjlWVEwzcFQ5dlgzKzZNclM4ck96cnAr?=
 =?utf-8?B?R3p5SkJNSDhnL1ZYUnUxa3dTRlpraUxRUElhSkt2NW5jNXBGQTlqaVlzemEr?=
 =?utf-8?Q?whcfqr05k/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3dWMkVOV05hWUFsVktLV3BnZ2pVbmZUK0tmZUVFalZkd1U2TnkzQitxUzlw?=
 =?utf-8?B?dUxLYWhLV1JsQkp4NWRlZFpOUndCZTF4cmxobExwN045SmFVcHlNOU1lY1VC?=
 =?utf-8?B?QXZScERUWEE4bTdmZ2p0aXhFa2F2dmpBUlA3ZU1zbXdrc2Qxb2dEcjdsV2pO?=
 =?utf-8?B?NThxSkN1VE1jVGZpbVNhMExWdjQ1NGd2eWxGWFJzZU1jME5kQVNQcWxJQm51?=
 =?utf-8?B?VmZKQnNFS1RnZGt1RG81UytZY250bjdpczhjWnBrRWVCL0xwem9iQkI5QXdG?=
 =?utf-8?B?VWd4ejJ0U1VERWdHcnJUVFk2OWZYUGp6ajJwKzRLazBsOFU5eVBIUSsrMTNk?=
 =?utf-8?B?am5OR21TTks4SElWZEdGMm9leWM2ZGVSd1ZPajBpekpBcXR6N1c4Y0J3NHhW?=
 =?utf-8?B?eHhnUFRpNGxReUp2MkVXckwrRWNDSHdlUGZ3SUNYN0RYZHAwOXQxK2haQ3NW?=
 =?utf-8?B?UWlVTEx4c005RUpHSndITmpWdHRJSUtSSUdvUnlGck1jOG54L2pxNVRYRkNY?=
 =?utf-8?B?a0dMQjZtbXVTYkxQQVd4MzdTOFZ3WThUVkd3NXdYMnBxUW14MjJpbm9LdVZj?=
 =?utf-8?B?S0ZSdnJqUXo2NERUSlJ1TVhUUUNGR3N0Mm5senV2aTMzZExMQndZb0Zoa1Az?=
 =?utf-8?B?YlBpRHo1M0VLQ25tN3lBTlowSkhJQjFzdlRNeDBsb2lsaHhWVFFPbDhrMjFH?=
 =?utf-8?B?RWgyV0M1WlZ4MVBlbXBlR3BCYWU4YnFvb2NxSTkrTlIwL01LLzRlNmlKY1dC?=
 =?utf-8?B?S2daZktyN0FGMGpEY2VVaWJiSVpxcVJBbGJEbDZXa3M0SUNKMXVpVm9KenEr?=
 =?utf-8?B?ajFnR3U3YjkvcFhqVExrSS9SSTJIRExMVFUwcEtsM3FZN3p3NzFJL1ZBUG51?=
 =?utf-8?B?VlY5bW10ZmlVTmhua1VucitxaHpjdFlzV2IrbHVENjFuY0xMWDZzTGdQdDd0?=
 =?utf-8?B?SzVpS2FvQ0xlUHZvNTczMHBzc1l4OGUwcjd4VG5DYVdIcDhBMlFYY3F0ZU9m?=
 =?utf-8?B?RGM0SWtpRmtNREp0UTZHNEJ4RVNHNllHWWJ5WlBGalJ3Y0RkN2FrVmQwZUN2?=
 =?utf-8?B?d3BHMUVuYTYxeE92MisrOU44dEtncmMvUmdRZGhBR09qSGVzQXU0UjF2enJV?=
 =?utf-8?B?bFZ0Y1hmZXlQOUM3SEZiTUpqekd0RnBJZ1pJMmliOHBoQVdWL1RLV1pERkl4?=
 =?utf-8?B?Y2lKaURsbzFpZCt0eUZRZy9sdkxjNnJvVXlVbmRTT0c2THdyUTRGRmt4QXhv?=
 =?utf-8?B?aEEvamlZRDg2VXdqMEwxQ1g0c2o1R3hBdld2a3JQMytxcW9ZT2tjQksvdXlQ?=
 =?utf-8?B?cFVjb05yeEdsUUNvazhrbSs0MVZwamF6SG1EUGNNL21yU0xzSGZ0L2YyR0t6?=
 =?utf-8?B?RTAydnpVWHV1Q1orKzN4eW0yYWNLVlhuQmI3aWd6eXlyaVhsWHhSSHVMR1px?=
 =?utf-8?B?YUdnbENJak5WbldaRTBuZXJZVXZEbEYxWVN0cU9PeHRsemhvekJIYlFXcFIy?=
 =?utf-8?B?NjVVV3l3U2RBQ2ZLZmFzTXA2Mzg3dGdDdVdGRnVmVURrYUhDMGpWeUZPS0tC?=
 =?utf-8?B?QWxlbTByMGN4Y0pMK2pCQWE5d2hVdU5NdzlhcHpOUVJPc3FsdHRCSGFBQ1dr?=
 =?utf-8?B?THQyRyt3cHZlaHAyRDZKOHgrWitFNm55ekpmWHV0dTBTVDVPSkh1cFgwcnlS?=
 =?utf-8?B?dGVRTUlmN2RjTGNUdmdWTEZEczF2SDVPUnpNRGFvRkZqVVh3Tm81THg4UUY3?=
 =?utf-8?B?dTZFbkpEOTFmZ3lUazV1ZG1DYWtnbVpCZitXOHNQbFNJaWZ5TU5ROHdSWjhR?=
 =?utf-8?B?cUkxYitNK29OMW9WZEp2bCtyT2R4RjRiN2h6a0JyeURUOVo4bnhWSWZ5UXBE?=
 =?utf-8?B?RU41c2pmSW8wU0ZUdVdjU0J0UmR0UlRpRkdrdUxzT2duRk83b2QzSnp4anNs?=
 =?utf-8?B?NzkrS1VFUHpBRFpnK3ppeXo5bkpkN2VRQ2E4LzF4K3BBeFlCMkVnQ0dEZXJD?=
 =?utf-8?B?RGdqSWJOdnl0dUlOK1NSV3BPN0IxRUNmTG9UYTdpSkFsSHlqeG9WQ2lGaXRo?=
 =?utf-8?B?N1ErVHk2eGk4U0ZKaUlqUGNwWGNyU2luWnZveDQvLytNaXNwR2JIdHBxYTJy?=
 =?utf-8?Q?1QDb8fdVX8GVun6z2L7j/BYAy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	28kNi77VRZ8WHVwgwnfc2gJx+m1PlSNBVdkG49bwV49GqERjIOnCJbF1ZOXGvof19KQMoNV1DxhB8Bk38dDdvyyLGPP7/BhDTqmhlO1T71gtQX1/V0nqse3ji81ZJDCPQa6QVyL11RtAaw07iF9vipw6+gkEVlzivEcLZ/IFOIBRx04kGCBfbs/ScnldFWyorrQOGKuB4ZXUmXurObkUxvbHIyeRr1NX5VJBtRqpvPYgm7qKR0cdHAXGFfPPImmiWGJr+EVoNeppcJ9GnLSjYwhx1WmP8VxoJ2eKPCGcHq1bsxnbATkJY/ztT1LCNrFAg8A8Sgr0cnL53GmbS4+4qAzJZCj1SPuWQr1yCVYqwjdWqQ7IIOZsd1R5Hq1YiM8lilQCPmFntSlwaXNU47TMXi2mIfN8NJH6nO7R5kD1YL5Y2GbEaZv0jmVlc9wRwBZ9i9NGyuuzF1s66tlSsgMBO3dG3xeTmcYSMgKYtKYtH3Cei99UpXBoGGYou6W/SC7QYL3zJIwYNK6UM51pZ/tV8uLTVhoA7fDZwXwI2KsbkipkmWixau5pgUMzJToc7KV8rmwgSuPONISzEkAsgDhOEp2PmajfAFAWY4L0kds1LiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab44916-9241-4f53-e10d-08ddbe1026f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 11:11:14.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fu19/qzjv1pH0UZvzPuQR/F4GiJTSs2ZDb0U4924uljn3yTC1lHd37NZUcRlzpPkbRN+BsIHVoMmGDPpt1Ul0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080092
X-Proofpoint-GUID: B467RTWiZZZItd9HeOdTB419fSI3EJh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5MiBTYWx0ZWRfXx01x8XGOmeqp sJEBgCI/XaYFVm/fCL0e8VVHiKauexo7TBgGOZ/HfpasARW8RiSBY29G5w/QIhoMb1hp7R0hMbn fbwHNykYAaNcwyK8c8j1LoqDtN9OSWH1D1kbyGMK/dWgMiXPpr7gGVD1TP9EEYvR6OfjMRdnZym
 Xm2NuEhchcK7UQbzmOYZ+grETx+H1yA4FdjmrLTtJ0SmdpZhCodGUUudY0KAzZ4fUeFvxwUY19x awvzAjSDxYvD7q/uaum1eVVj17jGMLJhcYs6ttz2dqfZti2624Uaj+h9bgLv1gnpjwnpiU72AJt SutO3fkhBOQsTC84BwRxhrlCNKRu/lYX7KJAk1q15oxmn+nBSEZLQ81YcgNtM9b+PHcrDsDZZ2w
 xYFY16cXTIL3VZcjT9PyfQZricvZy7hQ7wFbIvYcTH4SpTAxrCa0Ar7QVWO9i1GpGPRtOSIv
X-Authority-Analysis: v=2.4 cv=HaMUTjE8 c=1 sm=1 tr=0 ts=686cfcd7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=50ebgDkiaJg8-XRw6ZAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058
X-Proofpoint-ORIG-GUID: B467RTWiZZZItd9HeOdTB419fSI3EJh2

On 08/07/2025 07:50, Ojaswin Mujoo wrote:
>>> Further, handling awu_max vs awu_max_opt and their different
>>> interpretations for XFS vs EXT4 etc are adding uneccessary complexity.
>> You could assume awu max opt == awu max for ext4, as we no there are no
>> software-based atomic writes. That could be simpler than my previous
>> suggestion, which involves a kernel change.
> I want to avoid adding something like
> 
> iosize = FSTYP == "ext4" ? awu_max : awu_max_opt
> 
> in the test iteslf, because it is a bit difficult to remember changing
> this in case things change in the kernel later, eg if ext4 gets a
> fallback.

You could do the statx call on the mounted bdev, and see if atomics are 
supported there. If not, skip the test.

But even for xfs when HW support is available, we can still use software 
fallback when HW support is not possible, i.e. misaligned. So, in that 
regard, we really should only test this on ext4.

> 
> Im not sure if returning non-zero for ext4 is also correct as per the
> documented behavior from 5d894321c49e613.
> 
>     When zero, it means that there is no such performance boundary.
> 
> Anyways, I think there might be a simpler solution...
>>> The simplest way seems to be to just limit the $blocksize to
>>> something like $(_min 16KB awu_max) and hope that 16KB is small enough
>>> to not be split during reads. We anyways have other tests like
>>> generic/1230 that can be used to test larger atomic write sizes
>>>
>>> Thoughts?
>> As I said at the start, we never had guarantees of serialization of reads
>> and atomic writes.
>>
>> However I still think that this is a useful test. It's just it is
>> theoretically possible to give false positives.
>>
>> You could get the test to read max_sectors_kb, and check whether it is
>> greater than the bs. Again, more complexity.
> I think this might work. So i can set the iosize as 16kb which is
> already low enought. Incase the max_sectors is < than 16kb then we bail
> out. (but then maybe there is a very small chance of read split still)

Sure, that seems fine.

> 
> OR another approach is to do the verify at the very end when all threads
> are done writing so the reads don't race. The tradeoff is that this
> will reduce the effictiveness of the test though to some extent.

Yeah, right. We would want this test to prove that atomic writes are not 
getting split by the block stack, so racing reads can help prove that.

> 
>> As an alternative, maybe it's better to maintain this test out-of-tree. I'm
>> not sure.
> That'll be a hassle for everyone :p Does any of the above 2 approaches
> seem acceptable for upstreaming this test?

Sure, I think ether are fine, but I am still a bit hesitant to even have 
this test for xfs (and not just ext4).

Thanks,
John


