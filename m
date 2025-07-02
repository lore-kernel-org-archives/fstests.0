Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77863223DEA
	for <fstests@vger.kernel.org>; Wed,  2 Jul 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442422; cv=fail; b=DVPVJiwnTnaTqMiSE3To9cQg1gRU062ht605FBoaXK1aKaBT4lvncuEeppEil6hRv+0AmRQD3yfhc0lKq93vVYM/ZLOmyRXew9s0nFR0BEvYNZcEXQ1QUULeZy4lsb4x8YeOXtv7DuQlPukeAnQ9xZgV3KOkltRf2pCL+XVIIkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442422; c=relaxed/simple;
	bh=uNCSPRiUakDxBsuG71HcGTbs9FcWZoDnhvuSvQXLu8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9krstpi4hpeH8eYkhVD1UKEarfdZTZJK1F4i6hPIcnBWfzGxLkKlzhTAgv9YhsVg8UbrY+Vu0RgklfHKH/6+XMbePSfGhHNSd8lijkzObtlAU/hUifm1EC1uUjQ3PNk90qC5ygmDZDCu1hCmGOsFydRPKCqjwRqpVw2GGl2Qig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E5ncX6u9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mlnJYRxc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5ncX6u9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mlnJYRxc"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MdES005806;
	Wed, 2 Jul 2025 07:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xQdLcLKseIx+FMpUsUA7E4ke2KLue1f1h/V4IgQlrG8=; b=
	E5ncX6u9sVbkSmkBHvYo8zEinQNeKWaOYVnx33Q0qZ745UJN4BvrJm/7hMYdull8
	brJhg44Vn2whhUPr9N2tlX0KA2H2l4bJu20tDxvyi29UwGR//lj8VFF70v3GHhBC
	mdqH8ybctZui6Z+Iw5YqSVEDEFLHfiJginYPRZEFsONPjefJWQWmVYpIwBg6rd/+
	uJuDDhvyXC+gyvrGwDxk4fWKtGGDaGfob97PAIgzEL8zu6H+TobQNvZQodkPwekH
	15UfTorYwvrDEhAG8NjhvxPNc8BNjH02USQSZHmgtrrMEobF+uloF2U92aMPsFGS
	J8To2LuyiuwojnfoC33f0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6b5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 07:46:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5626Pbm1024963;
	Wed, 2 Jul 2025 07:46:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uj4bp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 07:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8wdGZ5YZ75C1X++MKwZ4NZd0ghi5Cw6fFld/4eo1Uie3TNAPTTTxF+xgMA7+yruI+/HpFFMFx0JzJgGBqKuuWByBLzkFnpoh0JDavlJKoyyFVtwn057l6vNJBCQfb2AJI2cOnXU4LOpX4T30g+RchMygwjKJaKN74ZrSDgU2A+woNYyYKfB7B+7hQVygOzOUsncGDLzabgvNP4BcEttVPct0oeCu9j8zooJhuYet6iEP/NMSFNcSbtdraxzxZ1Pjrqt5jnaFe2vNKuVaN2+LXuMIlO0xyc/QYfbZ5LH+UoE0jU9oWQvtr8DtFMwdjI5ErOk/PJcwxQe5Qgn518T7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQdLcLKseIx+FMpUsUA7E4ke2KLue1f1h/V4IgQlrG8=;
 b=RdANRQ0G+ZDNI98Ubolx0oErZyYorU0GF2tIcJa5DUQmCJ2Xes5QWzAqj0PqCLW9EQxitDfS0xCcJe6LbjfWRWZHUlahVbESathOUhLa/zCZo/6iHg5V7xArcQhrtC+gjufFWwGQJNekSkPsco7nqxYVEDz7gI+iW/A0Y+IB/mu4imee6Mzqu2GMf5mfNRbpEFc9foiBiGORxrU+qpZXG0PU7s4fJHO4qK6fLoV9+5yYNCcx97XypM/KS++OJIO8P1hzXigDrgk+HHgIvNuhmbo6f9frz7bt62yJ56OWxfpHWqpUTsFnXwR7HBd6eFhIRFAWZYUW6kAZVEdhyX3ENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQdLcLKseIx+FMpUsUA7E4ke2KLue1f1h/V4IgQlrG8=;
 b=mlnJYRxcCMg7M9eT/aR/Go36Gkaplb8KjWBwFUM9/3WRWeDr083hEJqIz1omUQr9K8pqMpXJ2nmv3YsOny1AIgYld/fCapuOX2LWHfCqqlKYQ1chM16XOh50JtqGaDnR7fVbKYPSrJVrd+sNXMpepMWlOJUQR7RZnWFdcL/T5NM=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 07:46:43 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 07:46:42 +0000
Message-ID: <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
Date: Wed, 2 Jul 2025 08:46:39 +0100
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: e43a5735-7041-402e-a1ba-08ddb93c95ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UklGTkRDMllBOFJTUWpyOXBxejlhcGpMVytyRzZob1o1anJrRnpMQ1BFWmlj?=
 =?utf-8?B?L3lWODl6UTNtN2g4RExUMTRwSDZzaDBPaHVFQ08zamhMUGVtc2pXS0hCZXhk?=
 =?utf-8?B?SEtoNVlMYXk2MWphWVhVWm9mMDVITE8zWmwvOEd3bXRuS1REVVpsTi9GekdN?=
 =?utf-8?B?ciszVWxYcGxBWW9HbzdDcjVwVXAxOVFZV1ZPT3c1UG1UV2FvekV4eEwrdEc4?=
 =?utf-8?B?anJsdTBYVTZQVVdJZTY2TXVJR1M1UkVYdGNrNG1xWEE1VGQwczFmdnhLcmds?=
 =?utf-8?B?Vzd4UU9aT2ZnTEE2MEdZSk9PaTFqekpDak9GY3BmcmpLQnNJb0J2VWJidDFQ?=
 =?utf-8?B?SmM3ZUNPTGJYdHlkQkphUkJ3WU5uMEVIbEwzSmxPM3N2K1poOVJWaVhrOXFB?=
 =?utf-8?B?K25TeTVjQUZaQmlGVDlVTjU0OThFVVE1aUo2N2NtS1A2aERDRFZvTWJqM2Nn?=
 =?utf-8?B?eXBDRGpiTW5IUmdPY2p0cmhEbG1haUlJRlh6S3d3a1g2R01TS1Y2N1RHRDhx?=
 =?utf-8?B?RlVmdTBudkR5Q1FBNFNpQVNqMmJMelJ5NHdyeFRCand1YU9uSXFCYkpSbW5I?=
 =?utf-8?B?dUlFZEdqNmZVcEk2NG9ZOGd2KzYrZisxRXArU3loSVpIVmR5bG5zaDNYK0V6?=
 =?utf-8?B?dmVyanJmc1dYQVU5Z3IwZWNtMElzK0ljYitrbW0vazFnTmJFdzRPcE5xMFI1?=
 =?utf-8?B?ckM2R1F6QSs0bDdDay8zb05PMFhsL0NIUTlkSVhNTlRvWEFURFE3UXVxOEYv?=
 =?utf-8?B?VFo3MEZNZEZtc1ZBQnR4NmlGSXc2VnFjWnNSbFhmdEl3cklTcXBSTEQwa01Y?=
 =?utf-8?B?NWgvSTBMRS9Hem9YZDZnVG5wa2ZGeHkrR3dVNVkrbEpqS2FleXZCL01wZGdS?=
 =?utf-8?B?cUlROVByZjg0OXJPZHBPNmlBWVJzTnF5dEFLN1NOYXRsQU9ycHREMGRrc3Fw?=
 =?utf-8?B?dTN4WUdua09HeGczK21TbkNudlR6Y09QVWhpNkFaWCsxUXhoc2RWWWZ4K3lQ?=
 =?utf-8?B?blNsZURzUUdxOHF6Y1hQMlZSTFJJTlVsd1FGK01pZklRcG1ML0p2anp3cyt5?=
 =?utf-8?B?bjQrbzl3bXkyYXI0MjJ3RVR0RGcwcFd1SnlhZS9wQUJIYlA1cW4yNjdUcmRY?=
 =?utf-8?B?V1ZkUU5ya3lVRjhuK3FWL2F0MG9taWJGZStBYjN1VEtQRG11akJzQkNQY0Vl?=
 =?utf-8?B?dXY4cjJYd0IzblZQck1KemM0WkxsZGJrT1BsSWNLWEdxV0hIM0RxcjJETDFm?=
 =?utf-8?B?YXlPMTNMUWFZa2pXMTk3RXhiWkt6WExrUGpMQzZlenhjTFpIYmdHaVJ5NDNT?=
 =?utf-8?B?TFJSeGhmcDJhRVovK29IYUJST0lRbFRZdVBYRVZtM0tnL2ppNlMwSVQyWHpQ?=
 =?utf-8?B?RTd4RWVLbTIzdm12bkdXS0tnblBwRXZDSTZMT2dVbER1dUVEdFNLbUVVVGJL?=
 =?utf-8?B?ZkdaWnhqdTAvd1ZncDdSMDMvS0VUTkdWVFJ6ZHk0NDl3c2d4anB4NlZGOFJi?=
 =?utf-8?B?RkowZ01VMk11ajZoMkNNV3hCMzlLTnFzMVF4cmprUGVPU1h3VVdxRXhDWVpN?=
 =?utf-8?B?WndwUVRWaEdSV1hsWkJremNKOURETE8rdVNSWmRZMkpNUGtOd0F0UmIxL2Zz?=
 =?utf-8?B?eXJZS3lsakphWTRxK243ajRKWkFMdkJielFQMUZqekV2dzBqOXliejU1dWZs?=
 =?utf-8?B?bTVhUytnVWRYVForYmRUN1dZb1BTT1B4YkpaelpPNnpLUlVlQ1BLd1dTVlFs?=
 =?utf-8?B?aE9uRXd0eU5zYzN0Rzd6U2c0dWk0TitxQ0ZDUzZHY2hwNFhZQitWRXdoKytr?=
 =?utf-8?B?bGpMakVCbEhMeDNndEZSZmd3aW1sSzVOK2M1bFI5MXJmeFp3UHlmejFWa2FZ?=
 =?utf-8?B?UnVlTUpRaEZDSGozTFh3ZjhXYVFvY0dnOE9ydTNFRmVEbFIxbmM4Q0JHWkQ1?=
 =?utf-8?Q?UXDTPswwjRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGhOaHVXNXdnVjd0aTR1VDAybStjSjgwK1NPa2pnM1RTT2U2ZGJ4Nmd3K0hy?=
 =?utf-8?B?YllCMTNjZVdZNDROTmhlQmZPUCtwN3hHNEJDSFdCTFEzZDE0Wk5waGFWUEJv?=
 =?utf-8?B?cFVlelRoWEEzMTMrU2tRUklNSHNremlycWxSaUpNcUdNVFBSVStid3cvNXRq?=
 =?utf-8?B?TWdFZXQ5WlRlc3NaeWhaamVmM1JlbnJvQ1NsNmtvdEliVWRYaVkwMFJ1WVl3?=
 =?utf-8?B?VU5UM3ZXQjNwUXZQYXQzYk0xS2RxWlJSQ2tmc2FtUHhITk04eGRxZGJ4QnhR?=
 =?utf-8?B?UzhaQjZrdllGTVM4WEVGYWNreSt4dUR1SUFCRUpNdmJEbVFMcW9FMWR5K2ds?=
 =?utf-8?B?MTRKTHo4d24zcGNScThNeFJjTjFuVG5JZk1iOVcxQ25ZZlBhTE12d243MDRX?=
 =?utf-8?B?K2xtRjh2bFZqWGZQRDdJVEN4dzA0eXFwT0t6a1Z6azlGekVESmp2all2aTJN?=
 =?utf-8?B?TVpTSkNrZ2svU3BvaVJBcUtVZXNxd21mVnlVOHgvR2o0MndjVGRyYkZNMGRy?=
 =?utf-8?B?RjhJdVJlNTl3d09VYnY5TmN0dldoSnp3M2dXbG1LRWphb05TYm1NMHR6K0hz?=
 =?utf-8?B?aUFQbjExRDhHb014OUg1WjEwZjZKUXhxTGdaTTZaYUVZNloxMjFqMkpOa0Fn?=
 =?utf-8?B?ZjQrcUVxR1lrbDZpbGtkdHNjcnR6M3pGcnF4VGVrWVIwZXAzcktWeVJOajBy?=
 =?utf-8?B?K3Y0NGhnYnRka1p5clQ5UW5XOGFjb1dqVUNQZm11dmhHa3VJOTQzRHd0d3RZ?=
 =?utf-8?B?WlQ4c2NXK3F3OVRmTmIydWRPZHJIYjVzWmlIbGd2YlVsWGN3NVFhQm12ZC9R?=
 =?utf-8?B?ZmpqTDFHek5oZUQzT296Mlh5alJ0Z2tYWUJ6dytCQTg0T3BzTVhKZUNLUitV?=
 =?utf-8?B?TnJNU09uWldqaDRFZW9YU0FzQm9hM1hGR0hsWTNVRE1zOFRITVM5ZG0yLzdh?=
 =?utf-8?B?TnVZc0ZmUy9RSnhpaUprVWJoc0dRWGw0ZjVoUFVMREFncXAydjVCMjNQSFFN?=
 =?utf-8?B?cEhhUXhrUmpUNG5TRVhlMjF0WUwrUlMzZjZKOW01bytiVGU4SlBtVTNlc2dm?=
 =?utf-8?B?SlBGbnRXV1Nkc0lDZHRtRVMvNzVwaC9PbGdGOGVBcUlwWURQeEhUeVd6bDZh?=
 =?utf-8?B?MEMwUWo5VC9Ic1kvclh1Tlh0UlkrZHhqcmhkVUtjVndFTTRqR09kZ1dYT2NE?=
 =?utf-8?B?NlhFZ3Q4c1VEcXRydk9SUVk4c1NBS09HVUViOHFwanJhek1PQ216Q1JWNkhD?=
 =?utf-8?B?MVJVSUFua0hTWlJzUW5UaWEzZjJzSVNPSFZISUFjNkJVcGNBR01ZU3RiTzd4?=
 =?utf-8?B?UGlVbjJzejdqRGVURi9EekNndDNZdWFsNExDUEhONGwzVmhLLzZyNkpub3Bo?=
 =?utf-8?B?U1hCbHQ5YVJydG9OaTlPMHdZTlczTU1hcHo5dXNZczdCaFhVV25SREFoZG4w?=
 =?utf-8?B?VndrQ0NIMXhkRTBnR3paV1I1OFMzYjNESEVpa2ZDek0zaTQxZVRYVVBQekV3?=
 =?utf-8?B?L0NUSm1uaEttM0lDa3hnckxmY2szc3VTU2xlalYyOUtNNVRxVEJveE9PU3E5?=
 =?utf-8?B?ZXM1ck0wS2E0Rk1Ldkd4RGNWVlFoSzZua3ZTdUdHWXo4VUNEQS9tM2dSamNU?=
 =?utf-8?B?YkxpOXNGOG1oWHNKTGVnRXcyRUQ0L0x5clVzYXBCWHA5VDBBZWpPaHRTYkJm?=
 =?utf-8?B?YUJES3d1c3RZYlc0T3l6SDRxYzZDOWFSSlhCb29kVDkwSm00ckhiTEZXanFL?=
 =?utf-8?B?MnZIa2J5MWJwUGJ5WHQ3cUgyYzU3VXZnUU1kaDRYWlExY1dpSHU4S05neG1G?=
 =?utf-8?B?U0ZzS2E1NThSMmdURjBHVFRnR2lTUnhYMkZMWWRvWXJ1MDRBREUvckkrait3?=
 =?utf-8?B?cGpRY2dlS0hna2sxKzlGK01xRy82TVBwQjRwbFMzR2xMOFA5ZXJ1eXYvTjRz?=
 =?utf-8?B?YlVlRkl4ZEQwakw2V2VmbnNxc3YwQUdPajBDeTlPL2hRdGU4L200a1R6RWJw?=
 =?utf-8?B?Y2tUUEVHai9CUHJzMDFISVJScDYvdnhHbnZNOE5vSFpuL2MyelVCYmxhLzVU?=
 =?utf-8?B?eTJHeTIzZkJ4dk45MjlmbWpPaitvQi9OSnpkRFM3TmcxblQ1Ri9kREFZUkFI?=
 =?utf-8?Q?9ZnIoE7LFYoH/xsmxk497mPKQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IOHdDFGvpHDCv6SM08ZTKUj0VwmeVoap+5XquiR/CJU2dZPgYcEeNIV3mTiOD/RkVRNl2+dTb67/VKRlnFofMw4Es7u2ECqOynBpBVXnwGZfy8mEkbIQ1LnReEgSi6ZczIMWpik5X25jjeO+ozMMgGyxdZt0W5FTF0ikWRbTX2er0Yl0c4EMlPZ0kkERAYpmG6uBjXWm25L7yhpTyjMwW9RB6WmJar14mwieEh2Z6T8Y7GCVSHKZt6igACQ45dhC7ayDJAINicjw8wbJRKtiGnpp1vX5oq3uDZKjtqk2OuYTH1YRZrtSvC4jG2aHB+NfznKES/SjFoPDIX0w7lvIhyyf79qkA2R0Psk6ZVDXqyAyncWmAiWx37vSOw5DoUfGBEbuV2DDlbbpwnEQ5xlxMZh96oS5szkE9bx/vxHjQ79Fxy+z8t83ChvohbRC4epo2nsBt/J0dB4w8ykCOVHp4CTf/B8wSlps4RfBF4nNqpTI64wYj/Cmp6K5bP8Q+bNQm7qJXd+4KVJL2v03v4BdzNijsBT9dxhZvuwguexVD5rHrkN4QILZs/O+or2s4iGcf4QAX+bhryd80wOGlGtuyC7gusokKcXhtcWAEr/4diU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a5735-7041-402e-a1ba-08ddb93c95ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:46:42.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6IPDgnKY7FAP/sWxuuZrllIKnYeDWVIQ3TZBw7s6jWduin/od7GNxLsQYor0JrqnUQOHAutbalfBj81jlMI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020061
X-Proofpoint-ORIG-GUID: 7Dyz5Pz-YvL93HqYTN6g2_d4NjPgzR7P
X-Proofpoint-GUID: 7Dyz5Pz-YvL93HqYTN6g2_d4NjPgzR7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA2MiBTYWx0ZWRfX2gcI/M0o+JO7 gJB3dtVIeOD34SNZccApmWKMSBLPtbL6XaktyH2cuhYKbKcDQ8wQAH3fxSgI3Dx4MYxdS9gciM8 0GrjCTrPLps2rBQT5aOq5A1dUDGgVK1A1fEbcPvFuWUyFvCaRqqit7i6cIWQy80PFhpOuCz6g+4
 PQZ2stxEd2P34N4rfw+Sgc98BzKTIdpSaC1YR3nyFcGaU8+WYaCBJ1kEccoz0O3imueyR/TKLj9 53DMr2g+UJHVnXeRy+XPN69Wyp40WrXYNCtm8XZKy6OM+PV9b78+5NhOrcuonIv6pQMrewgl2jB ByDWped1lMYnGH/p23tCtogN2s9uq/fdqQTzJFPAU2OBtSU5fXmtcJ1msb5E28Pq7KHyG4NybWL
 eggjJH6BOU6ZW+2OyvIzo27Jlb9oMigmaPFUk9/3uYXCQi36v2/RlJaQX9dM4w+bigt1r0n3
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6864e3e7 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=GMsDJUt7RcaeFGc8DZ4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215

On 01/07/2025 17:18, Ojaswin Mujoo wrote:
> On Fri, Jun 27, 2025 at 03:09:09PM +0100, John Garry wrote:
>>
>>> +touch "$SCRATCH_MNT/f1"
>>> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
>>> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
>>> +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
>>> +
>>> +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
>>
>> This test fails on xfs due for this reason. software fallback -based atomic
>> writes have no serialization against reads or other writes.
> 
> Okay so Im still not understanding why serialization is affecting
> anything here? Lets assume the IO never breaks,

That's a false assumption.

An atomic write should never be split into multiple requests for 
REQ_ATOMIC set. However, regular reads and writes may be split in the 
block stack for any reason. We can easily force a split in regular reads 
and writes by setting max_sectors_kb to a value less than the read/write 
size.

Check blk_mq_submit_bio() -> __bio_split_to_limits() -> bio_split_rw()

> from what I understand
> in fio code, we do the write and then once it is complete we try to read
> it back and verify it.
> 
> Why serialization matters here, because even if device reorders our read
> before the atomic write, we still fetch an older $blocksize chunk which
> should have the data and the header.

Yes, we fetch $blocksize, but it may be as multiple read requests,
so we can have:

partial read $blocksize request, atomic write request, partial read 
$blocksize request

> The data crc should match the
> header because it would have gone atomically. What am I missing?
> 
> (Or do you mean that max_sectors_kb is not big enough to support
> reads after software atomic writes and thats the issue?)
> 
>>
>> Can you cap at atomic write unit max opt? That will mean that we get
>> serialization from atomic write HW support.
>>
>> BTW, to repeat what I said before, it can also fail for atomic write bios
>> using HW support, as reads may be split.
> 
> This one I can understand, the fio's read is split causing a short read
> and seems like fio is not requeing short read properly for the verify
> step(?) so it tries to verify against short read itself.

this is not an fio problem, as above.

I would like to repeat that the test should be ok to use, as long as we 
don't try to use an atomic write size > HW support (and we also have 
max_sectors_kb > $blocksize, which it would normally be).

Thanks,
John
