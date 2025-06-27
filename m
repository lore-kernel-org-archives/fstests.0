Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B592DFF07
	for <fstests@vger.kernel.org>; Fri, 27 Jun 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033373; cv=fail; b=fJ/gxg+8RghYbeeor8IH2KEouOFviiyM7PptYj+I4ewm+EsS0zwTelEg1DIFIqHN9wSAlGt8VpYxQy3FMU6liAcCT7TbUqVMzSgedKH/iO5ZHOnGdy43xWebOFL5qnFeRiKCld++5EY6eRqsFHvX9GO3VYDBxu5ROjV2nntNctc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033373; c=relaxed/simple;
	bh=YADu+yvebugrOS9O6E2OC0XpUAetpBDdDvIPZ3OZeiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FeT6a/F7wH3IAow0bw8GVmDt3V4B3ngAnW3AuNAh5Yd9gBcqqbS+HFwUOWXg8bsrtLkSDLFhmJGdhrk7/OsbMdLKpaa8bxbUfvKXWkIEo/tXcBoWxp77IGEiijuPv1UhRB2CVtCMa6MnLoK5FQdiBvk5HNpxDMeDoMKi6gqVZIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRtFB8K1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BG/rsvIu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRtFB8K1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BG/rsvIu"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RAbmHu026349;
	Fri, 27 Jun 2025 14:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=980MOSTFJPoNGco7IkjI0rZhEBEyzUYQvNwU3Wf+IAM=; b=
	cRtFB8K19PLhyrM+qjBPUNCQEWpqLDkQN7lWaz/pcXDBN4IaIYaGFKiQQUcHXG3x
	1mADwcHETTKOfANyWXXtHhJD/qapfxAChTsKfZuYLCjnv1zR4eU+tYBXsPLTqQ+b
	XGF8gBAO52F9oXtUm35xxDlw0fFGsuDw3YIHz5gSZMEWrPqdr2g+X76z6MEA8+Nj
	B3ng/1zIlN0c0S5lw3uhQ3Mkyqnrru23kgEKnqdLOax054kxgs0kXMRbm0hrn9h2
	CdD7gCgnWuF0Kl/hT6XP2BeijmIY5tVL51hBMzrIaCRklamJUVPTSUFMvvF2o/UZ
	9f80SLHLvwE5F0l5TQVfVw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7v4484-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 14:09:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55RDRsmH003003;
	Fri, 27 Jun 2025 14:09:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq7vwgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 14:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVu8f3W4dG88PaVrZFcQCC7Ye6nB5dmyfACNNlEAxQDfDcpbPzLLuirV12wdgFHr+kUnpA0aElJBLongDPzWVenDvUOofDHsKvhPGUdj/8bYaGF6i4hwYw9Lxy8g++1px6RyqgQnTLcstV2G4uFV6zBjey9ItmmIv3uJANgkMNFhDLY+k1tBZ/GtbLGFoADgRMzgZRmQTLB0endmuKCnqCX+bIqNFovzdNn8C39uaVZpFNi2/Vm/vFv6cCPvOEWPQAtdwdYViiukKBSr34bi66N0NUQItjOYugpvxXGYv48REKipBftIVLbo1SrA30wg+Y+eR3E5OOie56eDG5iutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=980MOSTFJPoNGco7IkjI0rZhEBEyzUYQvNwU3Wf+IAM=;
 b=Q5hxAZbU4c735kklejHyXpwC1yAZNV7WzZSq0SoXeiJ37EEfA0H2bMQQQ3TG5DldeZU9UkSPuNqzgWGIONZUoiAKFd9hXmL0JySAjuD8tkx8d2SvqZj/jDL/MGA3qXj1fXCw5Xt9v68L3m8pCVSQjlat9+SuNyWJM6VkFMc5YU1rb4XeslAduVQO80KJq7sncYN6u+6VwFPgmuFSs3ayQVrC3TGKWf9P3+hu5V96WleW3cDPKFecCPdivh4QhQbjmwjD+B6ZM/pt067UBubu5PGJ6SOO0+9HtS0XtT+AT/7ovFwNVgRIGdde/ykTvmPVlsO8VPDYIN6P8EtcaORPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=980MOSTFJPoNGco7IkjI0rZhEBEyzUYQvNwU3Wf+IAM=;
 b=BG/rsvIuqNqwsRnwoeOnwa1Pmz25rK71a4k1rhXgWB5FKagBfRq3s8VWBjY+jZ1sL6tn2E2Y4HOEg8kbz9cmIafsrWSP4pWggemTydH+7MrMP/EwBGD6pQTxyvlQjtHA2SI7SyEoPiZDJj3n8XRj3o+xl8ozr9qREXWfWqs63/s=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA1PR10MB7516.namprd10.prod.outlook.com (2603:10b6:208:44f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 14:09:19 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 14:09:19 +0000
Message-ID: <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
Date: Fri, 27 Jun 2025 15:09:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA1PR10MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: c272afd8-d15d-44f5-c490-08ddb584350b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1o2RzZtb1Z3T0VZNWlEQ2swSTNSa2pFdmR6TTFTcUxXNVA5WGpVMHhxUWdW?=
 =?utf-8?B?cTJCdHBVQjRQOVRIUkN2OEJkamFkOGFjSTQxeHkwQkRhYjJtbUk3REtFVlJD?=
 =?utf-8?B?VXJiUUlkV1IrY0s0RW9mTTBhNzZOSzNuUzlXNGFEMVRGdE5mQ0NPd3J6ZnR0?=
 =?utf-8?B?MkJib0ZDaVZidmlxclZTMjl3S2JFdDYrdW0zWXFNWlFHOGdaRjAvWVMvYjh2?=
 =?utf-8?B?REpoUzZGdkh2R3hlZS9GRG1VcmU0VzFWb0NLYld1azhEMHNVbk5FMHN6R29S?=
 =?utf-8?B?aEV5aWgxeERWN0hoU29Jc3V4bGM2Kyt5OGZ4Yk0rZnpxMjg1NTJvMEJrYXJx?=
 =?utf-8?B?SHVrdWdwWEZXUWUwUXh1MmJUWmUyUVJ1QjBwN05JeW83SUgvRjhJYVc2T1ZE?=
 =?utf-8?B?T3VNWFpDT2JQRmZDSklDMFpXV0Vwc1lZZkZNL3NsNmRhOUpuN0ZmZHB4ajFx?=
 =?utf-8?B?Q0hwaUpjNzlHWElnajNLSXZxMVNHVk44MVJ5V1lJVUVLSzd2S2ROa1ZzcHFy?=
 =?utf-8?B?SEJOcmYyYWdFeHVPODJFMjVFbEh1STUxVHBZRmRBbVRCaWZWSlBFa1BxcWVB?=
 =?utf-8?B?V0QvRmhWZW4wMS9Sa21YUVB6MWQyRlRUNVdUNnB2UGdTY29XVzJVLzBnL0px?=
 =?utf-8?B?SkN5Ty85ajlLa04wREJtM3U4cnVSNC9FNUpsRzc1SkVOZGRwS3hrUC9USHYx?=
 =?utf-8?B?REZHRFFOOUlJSVVLQktPV0Zuc2tOendlNWNHR2s4S0svaGtZWFQrOSs2ZjFF?=
 =?utf-8?B?MSthY2xDNmNVcXVTc1h5SmxSSnYvbmh4TTB4V1hmeFlmUjQxeWh2NE5KWFhi?=
 =?utf-8?B?VURWd0UxS0hFaEtZNUYwR2JjQUZrb0l5TFdJV1JZR1dpT0Z5ajBwMHZaLzhI?=
 =?utf-8?B?M2cveHB3OWplVEZ4aDllWENMS1JPSUw4Ykl1SXl6aFJicTlVdjBpT1hFSjJj?=
 =?utf-8?B?aXdvejIrREhIVkhMVlFCU1lqb253Lzk0YzVOWHZHblIzLy82MWdzQmdvMnpy?=
 =?utf-8?B?SlNNaldoOHJIS3RHc1IyR2Y4UWZ1Y0pjd3JSZllRdUUzZmZuUzZ2Zk9vekhE?=
 =?utf-8?B?SFV2QWpMZkt4SUVlN01hVklpVlRvMEMrUzQ3UitvZ3FlVkkrV2pSY21aZEI5?=
 =?utf-8?B?dDdabkl4M05pblg2cXNIczVhcEUwNUxlcnN4S1djQWtiS2JkekRZeFZRRGFJ?=
 =?utf-8?B?ZFVmNVNVTmpFRjZHRkp2aWtydzVWTFY4ZFR4ZktXVmJucnk4ODQza1M1UHhn?=
 =?utf-8?B?Uk5IbVdMY3RWcTdmRjJSSHIzeHQ0ZnhVODRTZTBmMFgvYytmeUpzVWdjbWo5?=
 =?utf-8?B?STNWVjdmS0VWYTg3eGw4R3A3VVJZaEp6OThLTFBtUVpzTmJGa1VJZUFIYjVY?=
 =?utf-8?B?dEdweERVV3JVU3RuMk9HUm5rN0JISlRKbFRkellwN3NoUkN2T29YaUdubmdX?=
 =?utf-8?B?TjI4L24yMCtFalJHUzIrcCs4WndUVXdZNGxpc1NWM0pMZ01LQnZudHdidWhk?=
 =?utf-8?B?dHFDN0tnMVNEUEV4cUN5UW1JaHZkcWxQcHRQS3dlNk5HaGhRK3JGT3o1RUJo?=
 =?utf-8?B?ZCswZWs3T25ZWTVxd2ErOFBPMzc2djkzZ1Bqd3VDZ25QbEcxZUx2Z2RPSWUy?=
 =?utf-8?B?dE11L3JUajg5V0hKcytzZVNmKzdBUk9vZW1kTVNtaFhKYUhXTFRkRmRUN2pU?=
 =?utf-8?B?dEU0SWpJakNKdUY1R2Y0YkxpQkxZK2p0bENLdm1Bcm9XVzcwYnNTQ29TWFFM?=
 =?utf-8?B?a0RpMEtqbE82TEszWHZIbHJiTmFPa3FOSnFOKzhhcGMzQmFZcmNlT2JvcXY1?=
 =?utf-8?B?T2ZCa2J0LzBpdERYRHJqMGxwQXJDdjVseHVUWlNjN1lSVjBDS0lMRkZ4TE8y?=
 =?utf-8?B?N05BSCt5OGVlSnZiSHVIRDV0THhHZHFzcURqQjRveUNqd29NVDM3SFVpMm0x?=
 =?utf-8?Q?WZlEK61fbBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJ5TTNKRjhQT3BFeUwrQWx4Y2ovWkt1MUw2Tk5Nbmg1a28wcFVEeEJvNmVr?=
 =?utf-8?B?bm4rTnduNlBZU0JHdnRyZW5pbzRnQWhVTTdsTXIrcGR5czlRQ2MyZU1nQmYz?=
 =?utf-8?B?SHYwaXlLalp3MGI1bEI2Z2hESTlwTmVrSmJLVVRGeSt3U21TdmFTNzJkOENJ?=
 =?utf-8?B?RW0rWUE3MDRZMkNyK0w5amJQK0lQYWVNZ3h2TE5QbkNWeU0vQ29oMUFWV1Rt?=
 =?utf-8?B?d1NLSDlCYTlCNzdDMTIyWGxkSVMzVE5rS0I5VkE3Uld2Nmh3dS9FeWRLaGNt?=
 =?utf-8?B?S1BwaDdZam1xd2RnMVh0ZS8yM0cyMDFtdkRjdDdFbUt3b0RWek5Ud1Z6T0Ja?=
 =?utf-8?B?MGVLRndsYXpGb292WjlqZ0pvVG9sam5NS0x1b0FRcHR0YTNzWEIxUmloSVhx?=
 =?utf-8?B?bmdIYmdhVDZ1RWFlTER0NU1GemxLcW5ycU5weC9Xd3czaHROOHkzbEdiSEFG?=
 =?utf-8?B?cE9WUUEzYnF3OGNhRjVNbjZieWkwL2JBUkQ4TVg1aDlFNEx3YzM0TDhybGk0?=
 =?utf-8?B?UVhDRWoxdGJOWjNWaEgvU2FyeHFVbUtWK1FYQVJVNGdtbnRvM1dod1JlYTl3?=
 =?utf-8?B?eW5LQng4b1NTbGZEV2NkUjZ5UVNJSUpmSVpjYkx5MW03L2VHOVR6WHA1cjNw?=
 =?utf-8?B?bXJSQW5jMG1hbzAyVUZFZTI2emhNalhWbkw3bkM5aUJUUFo5RFJManhGUExu?=
 =?utf-8?B?R1dpMGhWU1pVTGV1K0dmK2UzMDc3S1h3MWpCcENpRU1nVUR2Mm04VFYrNW1u?=
 =?utf-8?B?ZWlmVWVNVGxlR3VTb0xJZ1AxaDVHcUNVcG81YWJBa3p5Qkh5NlF6Q21vQi83?=
 =?utf-8?B?SlNkUlFrK0p1Y2dLWjg1QXpaV2FPWnNIdElkTUVYMVE5bE1RRGNvaDZKYzdW?=
 =?utf-8?B?akZoNVk5elpxVUpZdUp0bXM2UjdaYysrakpGWVlpOVl6WVlrTi92aUVwcHJX?=
 =?utf-8?B?a05qeEJVd0hOWUt4b0JQT1FuNjVzODBlV2UzaThnbUVxN0drZHZDSlY5MWlI?=
 =?utf-8?B?OTA2SjNJK21CejU2T2l0YTJLTTVIOVZOTU5YSnhNZEw4dzVnR3RKeTV3MDA2?=
 =?utf-8?B?c08rbWpZZHgxTEpwTEJXZUpWaEloQlhyMXMwOHZ0dnR4UzVhb0Z5aTdBYk4y?=
 =?utf-8?B?dU1nUjcvUHpFSitkaDRCM0wzUmU3TzlSZ3Y4a0xURHJHaFpjbFJwMVc2WU9H?=
 =?utf-8?B?ZlBDVVNjczNxaWo1QXhaYS9KNDY3M1NaeUk2UGpRdmZrOG16UUxVK1AyNmpH?=
 =?utf-8?B?TGE3a0ZvaDlCVWQ3bjJabVA1YUZ5NnpzNU12RWdjQnlDU3Vwa0RLY0NMRksr?=
 =?utf-8?B?b1RVSHRzWm1WUUNVTkErdFh1Um5rU0l6Qm1qVlFNN0hUK05tYzlpVGdzVVhn?=
 =?utf-8?B?WmJFeU1MekJidmlXL0w4QnJuWklUQU9ESWZWTm0vWnVHZXJjMnJoRVIyRU1o?=
 =?utf-8?B?NHpqNGg4WVhaMTRPdjA0cFZIYzJFckc3SktYREVKMFZNaTRQcldwV2R5aytS?=
 =?utf-8?B?dXhBeVhrZFJ3QnlPNGlUVFQya3BlbGQxVkxyeG5IZFA5RE5TVUFMc3VYbHhn?=
 =?utf-8?B?cEZacVdBakJNZnk5cjhIeEJjTFcxbkpRVXB2VytxSlh0RHlkYStTdkc4eTZm?=
 =?utf-8?B?dG4zM3h3RmcrczQrSXFGVDdNUklaUUFPYU50eGQ3ZitHWTBjemtUTkNFcEpZ?=
 =?utf-8?B?bVZJbkVsa0pEZVhIQzFXUHJSUjB4UDdYOXFmcGMrMjdtTi91aFpLZ0VlSFRM?=
 =?utf-8?B?OTFiUWVKRW14aGlESVpJenE3ZllCYmgvR2pic1FwdTYyRmNheUxYK0FZRkR1?=
 =?utf-8?B?Q250akNLcXc4THN0dEgrWjNpS05vN0lTRk9nNUhzaEszajhQTmNPU09PME5N?=
 =?utf-8?B?MFhCK0RuR3pHREZ2bU4rcks3WDVzN3BPejVNY2lUV3luU0dLZ3VwUisyZE5B?=
 =?utf-8?B?ZFMvdXRwKzliaVFVeXJaV2FKL1Z1K1R3RkFlTlY5Vys0Uk9kVFh0c2xuSjBV?=
 =?utf-8?B?NUJXa091aEFJajBscHk5U3FURGhkYU1XZkoyQTlTU1ZtUUJQQTcyNGFaemRm?=
 =?utf-8?B?Wk5sRXd6djJNSzZoSkE4TDJhYU9zQXlyU2NUN2hNQnVuU3VrZnEwMzNDcG11?=
 =?utf-8?B?OEU5MXpnd1hrVkRZQ25zNThIVlhZMStxenVtMTFVY20xTTRVUGJCVktaTG9T?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UTAVxcH+BAWg8EqxITNKFFccc0qf2EsGH8bdp0YuctOOPtcdr+VMVkQi4x/w29L5Hf9yxZ9yA27IxF3ygbqnW/7nP1qL43Zonw4/mGoAkDo9pJSFhAxw4ctZ1zy6UUtiaeZJkOCCL0zOboc0HZHo7AdI2+bvLzjgZdst4hIBAyTc5oEdMQYxsHw8rIShn0DWKXBJvzsvFUZmEOxmwLpwIKR4EQXmAHWhtjeZnmUvKm2zWFxt/QfuYiy3ksn4rzuhsfRDNO8xqltTWtrYCjiNsxLalu+aqsUXKkKlnLomRyyB3P11CtzWylh7T+uFtKZDEeZXsuMC1hKmOt0/zhOd7VWxFdDcg8I5O3FQBlte9t6n2PIx+XZe9BeAtKiEAp+qL2izZ9yJ2CEGghhPM3VLOF72E3iBIolM2cJ/qYBHVW9lJ6oD6mqPeVT9KbAiyLkAnWCrMLwi049UTxEqgl+2lv63vH6s+7RIFVKWi7XrO4CJH4z5HxJ40K0xLLqktK8/Vt2DVKvMjhrSms0YZIAT3d9Zow64lkDpgGyYEWIU96NcNQf6K4JA5v/adZvIikCo0eRrDz9zW0vY0tlG8VfQvsFHKW6ZGLFcyT2It8fyE/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c272afd8-d15d-44f5-c490-08ddb584350b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:09:19.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K39+EKJZ2g6COxtk1dYNIDzQTAtYNm34Gzz96Dex1bPJ/jiRYi12sVJucsGY6HN6n19FV9CAEYYcu/OJ+p8puw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270117
X-Proofpoint-GUID: 3uF19DDuAD8YfBd4LQm7LZXXfkXtCED6
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685ea612 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=iPTbjaDHlymigReUiAoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3uF19DDuAD8YfBd4LQm7LZXXfkXtCED6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDExNyBTYWx0ZWRfX4ibtkNWM8Saa v7tVZT7+vs/imW6XmVw54em2DSwx6Rwo0124qiOB58Gszc5zvkAp912A4gYj5g94GgbnLVfoP1x FvZwQY3xX7Mzo4Yf5bdzq39eDLG6FsQpxiNKQPh20g6KWh7vr6WOSnGe7Fz3duiSH7EC+mtk+he
 kaso/b1jGV59rFZCWzOVAQ2pAsnsA3VdtPO+6um7KcTqOdgM0D1RTHfL/WOdUXRQMBnCGTyET4B 8sgeYPXkhtdDicTnYHqogpkX8es5n5mH/yhnQ7fMhb1DgWbvi/Wrgc6geoisIMsnzXa2MBABQgs HUiyVQEziMLwTI/O7g6X3cXuBFUlYXh4XI0s0eRlKUoWjbr0VpFOaHCqzj2oPoPaLSFgFkIrl0y
 NC2zswGIcKsucJzWw7Sl9drheaTyrz5wE7oiMpl/xVjp/CLviK5lNgtjRrnB6HjwTiGcoJBw


> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> +
> +# XFS can have high awu_max_write due to software fallback. Cap it at 64k

This test fails on xfs due for this reason. software fallback -based 
atomic writes have no serialization against reads or other writes.

Can you cap at atomic write unit max opt? That will mean that we get 
serialization from atomic write HW support.

BTW, to repeat what I said before, it can also fail for atomic write 
bios using HW support, as reads may be split.

See this sample output:

generic/1226 68s ... - output mismatch (see 
/home/opc/xfstests-dev/results//generic/1226.out.bad)
     --- tests/generic/1226.out  2025-06-27 11:26:58.411121674 +0000
     +++ /home/opc/xfstests-dev/results//generic/1226.out.bad 
2025-06-27 14:03:08.933811064 +0000
     @@ -1,2 +1,104 @@
      QA output created by 1226
     +crc32c: verify failed at file /home/opc/mnt/scratch/test-file 
offset 16457728, length 8192 (requested block: offset=16457728, 
length=8192, flags=84)
     +       Expected CRC: 712de900
     +       Received CRC: f872a18d
     +crc32c: verify failed at file /home/opc/mnt/scratch/test-file 
offset 88104960, length 8192 (requested block: offset=88104960, 
length=8192, flags=84)
     +       Expected CRC: 4aaaf009
     +       Received CRC: 2a5770cf
     ...
     (Run 'diff -u /home/opc/xfstests-dev/tests/generic/1226.out 
/home/opc/xfstests-dev/results//generic/1226.out.bad'  to see the entire 
diff)
Ran: generic/1226
Failures: generic/1226
Failed 1 of 1 tests

[root@jgarry-ol9new xfstests-dev]# cat /sys/block/sdi/queue/max_sectors_kb
4
[root@jgarry-ol9new xfstests-dev]#

However, nobody should fiddle with max_sectors_kb, so the test still has 
value.


> +blocksize=$(_min "$blocksize" "65536")
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
