Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A127F
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249894; cv=fail; b=an7Le4qbIx/xlFMxSu8JtLJTc8WRj94y9Jh8LxeA8xflUSyjfGH5jVli1IBsbGusxxCLBpQKvITbtRlXUujY6GPYe9Igwti70TTf7oUUpEYd7cVK8DXM75TiItMHkr2VcZRNdCrxhz+JJTRXlp7pw4/AHr7R40orzhjfrSsdHrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249894; c=relaxed/simple;
	bh=1BWDcST/j2sW6xvlxMMzQ5JfS+4VhC48wEORJNwQHaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDbhbQwj0iP9CxHy31b67SOaKJMx6AxvuKVuIMNFe9OdUj6cXEabdr+Z3V7TsoOIeePxASBdxVzi3prgInwTt0tKRRR7+qpG+o4UfbKYAe9zf1WV5/+XSqx+OB1aqeOg3Gbjn49qFvs/7Y+uqpzQNL9koKPTyxyz7fzGTmTM0B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iv+hdhVF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLZwzUHr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iv+hdhVF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLZwzUHr"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMx2YC023478;
	Tue, 21 May 2024 00:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bYNV++4ALYVVnVZ8ktAsvw35wezbzRSLfYtbEIJHNnE=;
 b=iv+hdhVFgWMBE0f0pX42z/VYXpA3qhkkDbTdpTdx+dnSEEZBWN5KT3XX3c/yF2pAyP8C
 TOVD32EXVruSneB68elfHBKHy49ddkKCUj3NnrvSocP3C8xVEogkQsHDuuDf6cRJazxQ
 JgSJ1jeKtUSoqIedtGXXE9IsZK+xWecx2DK4HERa4CRAKjZAqr0v0pMOulyUji5kmHxP
 UYZdpeQT5fcdxnTPeMWljd/AdxsBq7PWb7QUFwOrc2y6rWNV/FMn1vT2MyqWGePvwVxt
 VnCIswPO5oTwNrSrJP98TMUPimauUpgB/1XtREkYFLmukLk3T1PtjuNhqe+d8jOPuu7u mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv3xn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:04:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMmBSG002666;
	Tue, 21 May 2024 00:04:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6y1j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avKG/3GSUMrS4wJBFznJp9cAyCvDHstmUzBapJZl8qPfHj7G8iVjEdhZI860e1Grv1tJPQN1zubSuLphLR8kevZYD1cpWOvU15SwylsAsILFEry4lxubsMtOVSo4kN5h/3u7uEk1rinusO8Lx2SHRl6u3ykguinJwrV4h+BX3cHbQ1koTxS5M+hxj/0OZn1Xaoyz69C0vMB4Tu96qZlXEsJzi5F354tX0Y+rYs7payhkt8FCrlWPunjqfN79OiB61YpuTAlSAbhMrCMz58uKFPZNHcnDGyLQ8+LezJQUxN38Yxtnyq8zZoy5ywtLKJLY5FxRQLGy98zZ4IboOWz/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYNV++4ALYVVnVZ8ktAsvw35wezbzRSLfYtbEIJHNnE=;
 b=QSZ3uBzqnpPeVfqLFZwr011mMYZPUzGcpBd8NxfvPfwYZ4jFZiVE+dRqi6vu1OG99T6aO3ulQt9ewTiBD4TkuqVQZPlew2sequYMquUr4ux+EQCohLSv0aREmZXaOfBCcNmhZ9+j7lwMVvkF2f/YGxhwK7p6EPmgEcwZzhOo91+/Z8r/CXNabIodNaj9pWFNxWuMA/qWmgO90kMugZeywIITj6PpYvxqgzkAOvad5gJkwJlhlIRIw3v+cpYOia67CFQ5+zzZFFmfXXsHEhbl9VkfX3ou9j4VJgpGCMe7aBOqwd6YmcL3qRM87YgGSp3NeUqNe5JTua76RvxrPEXKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYNV++4ALYVVnVZ8ktAsvw35wezbzRSLfYtbEIJHNnE=;
 b=JLZwzUHrRdj2KOY/uNr69x39hWmQrUJkUXgTvilpneWywJOVtjSArgxaBG5o7IOq+3dy+kAG1U1UBKPsecEma6unYTXixKgOu998A8TX0FOdj5NwKmUrA9MFnd1BwJDKpTRL03vZXR1FO6g+OptnFegl2XfwCI19b+ac+atAFwU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 00:04:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 00:04:45 +0000
Message-ID: <47c223a3-0dd5-4e10-8697-54245f26ccb6@oracle.com>
Date: Tue, 21 May 2024 08:04:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] generic/352: require no compression
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: josef@toxicpanda.com
References: <cover.1715896529.git.dsterba@suse.com>
 <d3e67b7d53f21d3e290384760ffbfda02c43cc8c.1715896529.git.dsterba@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <d3e67b7d53f21d3e290384760ffbfda02c43cc8c.1715896529.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d881dec-267e-4719-fdcd-08dc79299f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cTZMYzRMOWlISVVHRVlOYzk0WVl5WWNKOEo3andFTFR2UmV1YVoxZ3FXaDZ2?=
 =?utf-8?B?SGN2aU9TZzZhajgzazhna2Q4aGVsaThpTTRuVHNseVZ4d01TSkU4VFBITDBH?=
 =?utf-8?B?M1JSY29JelhqMlhMb0hrWFZmdUpCK0VlUndtSmR1ZlVzY3VJMVdCMjJ3d0RS?=
 =?utf-8?B?eTZHaytmUEtGNFRhSmxDYzFZS0UzcGg3dXRwUjkrMlFHbVpSY1NJYzNrWjJp?=
 =?utf-8?B?SmI5YXgyeFlRVWlWV0E4Rnk3cnRWaGV4S3pEOHJ5cTZYQWljSlZYM0lhQW9S?=
 =?utf-8?B?elVKczBVdFVpWmQ2bkRFSzUwQnA5UUkvZm5TeHhwQkdjSWtHamwvcUU1WnEz?=
 =?utf-8?B?QWVqTFFwN3h3cXhsNUtaT1loU3V2cDFLeTl2elIwTWJJcU1vbFczcytlUDNF?=
 =?utf-8?B?dENvWUU0NmhlWjFvNjVsakNrVFJlUm9EZkdmTG95WWNqMEFRY3c5SlNkc1Rq?=
 =?utf-8?B?WE9neHJqS0J4eElETDBiM3hyd3J4c09TQmZ5TmpacURjR045aUFLMkNDQk1Y?=
 =?utf-8?B?ZFV6d2J6ZytMTkx6KzA5RzRHcFJDVDFxYVU0SFRTbVE5ZFFNOEZpOEhRTmEz?=
 =?utf-8?B?NWZPdU5FOUJlS09ZOEV1U1VkK0ZCL0RtL3N3R2JVd3licTA0b3B2KzRUb043?=
 =?utf-8?B?cEhsV0Nna0c4aTAxTG1NQnM3VVpUSUZ2L1haSXRsZGVkQUIwSTBYMnRSWWh4?=
 =?utf-8?B?WENlVGtqU0NzVEZJaDBhUTh3MmxtNGhkM084Rjc0R3h0UFJEajdURXZ4VEpo?=
 =?utf-8?B?ZG1Rc2RMN0owYXh1REY0Ny83RWFFMmhNc0tBWlAxVUJScmxtak9ZbFRMZGsz?=
 =?utf-8?B?T21xdFgxQ1Yxa2RWRUU4RWNkZzZOM2FxUVV5TTV2RWZkNDdzdUxFU1dIY3B0?=
 =?utf-8?B?RVJXaDQ2Sk82S05lRXZVM1U2N1pCQWxLakFGb2w3M3l4YWZlM1RCVEtMN09h?=
 =?utf-8?B?M1gvNExaVit0WnRwUzhxYW84cExDZDJuWVVqNWZCTWJsa2NBVGxkZHFKdWpv?=
 =?utf-8?B?YWNOaEVSejVWdXd6dG96WkRTTXBDRVo1TWwzR0FnQ2RMRklqdzVRdzFrU2Jt?=
 =?utf-8?B?dkI5Mkdkd1I0dTdhNHh5OG1OcGIyZmxmd2R0SnVHR2hRQ1kwMktwdUxvN1Jx?=
 =?utf-8?B?cC84bmlySlRqMjY0SHNYOUZ4bW90cnc5TEt5VUc0KzRLSkw1dlZZT3lubFkr?=
 =?utf-8?B?Q215bkdEZk1GNEpWaGhnc2plNjdoVmJ5cmNZcEdaSWNWVTdtTXY3aHVvNWt0?=
 =?utf-8?B?MFpCMVNDWWJSSEdyL01yRTEwNVowWmp1bklSWVEwNGJqaGJhOFR3NEZHQWcw?=
 =?utf-8?B?alpreE9FZjlZY1FEaHZGL1BCYXFGQ3pkV2pMYkJlalNId0lCelJvcDdXWXp3?=
 =?utf-8?B?WXd4VFljaTU3eTJMSkVvbUZNWE5jL3Nta2ZHRzRDR3hoSEpmS1k0cThDaFN5?=
 =?utf-8?B?TDFCbTNNMEdLUEJhc3pmSlFRMVZuQmU2Z2dHWGROaTVRLytROTNtU1ZMQXRi?=
 =?utf-8?B?dVBsWDhiNzdqQTJNeko4cko5ZUkwSEthSlJNdTJPZmxnQkpibWdsaUdpRXgv?=
 =?utf-8?B?ZEN1TFg5NVNORmY4dGVRL0VDamdtWmhmRXAxVkd2aFRkd1lXZkxpT1BHbkpa?=
 =?utf-8?B?WlZXODNuRmRPdnI4TFZ6SjlVUnlWWkI1SU9rWFArc2s3QnlGaTVYeTZCMVhK?=
 =?utf-8?B?bUlzMWZ3N0kzS2hqaGcrUE9qQ2ZCK2dZeG5SMjZSaFJ3MWdNNVNqVnNnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0k2U3FDNHBNKzBJRmFDMDY4V3pXRG5nMDVZLzFsT2NKbVIza2tzSFgrV0xx?=
 =?utf-8?B?Y2plTVNRQ3owMnl0cGNvN1pHMkVwRGhCTlZ3UndiMFdpTXdITFpvYzlxV3Jq?=
 =?utf-8?B?WjlrdEN1dS8vbjNrdFl3TFc5cmYzK1d1cFNaSm9ZSjQ3OFJVTVZJZEoxeE1U?=
 =?utf-8?B?RU5ablZUd0l4YXoxQkg2QkVwTXhkQWQ0bXd4L1JtZ0E3bXlCUkI3VE5JeVBU?=
 =?utf-8?B?dWloRVFVV1NhZnZIczVqamNEcjFvZktGTVBKRXRFSFZRdjhYaW9xNXFQV3VP?=
 =?utf-8?B?eVlINDJZRkFOUnE2MUxnMkphcUgzSUZ5a1BOa2p1TnlSZ3RmUzFDYzdpSUVs?=
 =?utf-8?B?eFMvWlovcEhZRCt3SGo0VERSUkFBajExWThoMEU5ZjVGc1QrWVA4RitCSGQr?=
 =?utf-8?B?b1I5SDI4R0NKOUJ5bHl0YTZCTGRCdGh6elVyQ003NUpyb0V0Y0xJZFBYbDFK?=
 =?utf-8?B?MDJJZ2tCVGVxQ0dlTVdpR3ZWSUFSUVowM2d6RU0rYVBzMjZVUXpTTHQ4NW42?=
 =?utf-8?B?ZkZWL1FweFlFVXdCSi8zcGlIN2dySGd6ZzVoMm5UTVhSYWtIUENzSDNTRFg1?=
 =?utf-8?B?a25uTlllT3NsMTlQVE1UZzIraUM4dnJqREVnYkxva011R1JGVEFIM3orbkxy?=
 =?utf-8?B?M1RVVDhVS2NKWWVRWXVIMXFhVFRyNFZNYVAwNHRxbVZZU1BQY3NsbitYTWQz?=
 =?utf-8?B?dlVKQWNlNGZyUFRqZHJQK2U3ZFV0blJmS2pQc0FhS2Fwdldzd09IWW9FQThZ?=
 =?utf-8?B?ZENYMDNHVTFVY2pjdlhEa1JpRk5vcXRoeE15U1VVRk0zTk1yWWJNbVU3T0lz?=
 =?utf-8?B?cnFCR2pmR3VlaEU4SXRZOENuT1B0Nm43NWpOYUYwMWU3OXRXTFZ5dHF0TzQv?=
 =?utf-8?B?VnVtTnQ3MEtzb29qRkcwMGVSbUQ5UlhpdFR5cnN3bURMVzZCVi9lYjB5dVJn?=
 =?utf-8?B?U3pleUliTHpzSnR3MTc5VHlTVHVYYTFpMFptalROU0o4WVp3cGdpSlE2NE12?=
 =?utf-8?B?TVZyKzlyaEFxVHR2UkxtY3NCWEZhcGJzbStySWZlbGJzaHVEUFZRejN6Y05D?=
 =?utf-8?B?SWFjNGZJMmluVWt2ZTBQMUljekkra0NRRXZCbFNHRnlMb05SYWUvb1VxN3VD?=
 =?utf-8?B?dkNaTExQMzNIdnV2enVwMDZpdzBiRW8xZ2F0SUZCTllmWVQ1Tkhwb3VpYjY4?=
 =?utf-8?B?dXRiRUZOdGVpdkMvZUNmcWRaRjBXdndHR3FzWkNwTEpMRitoa2FveVdNNWZO?=
 =?utf-8?B?MG5tNXViQUJWT0R5eU44OUZYbVBoWXhOdU1HZzlST2o0cUUxU0Z6aFRUM1py?=
 =?utf-8?B?elE1eGpKZ3FPd2NVd0tKaHhrNU9MZ21QYnJZK2pDWWlUREFLTFBxTzlrTVVj?=
 =?utf-8?B?WlFsK3BpTjBaT0lXcmZJTUNPYWJNcm43UUFVQzFLMU5PZnZ4QytlRDNLT0d4?=
 =?utf-8?B?QklaVGovN0ozMDc4QlJLWldlSHlmWkp6SkJuMVMzMm9NYWxjZDd2NEJNS3J6?=
 =?utf-8?B?M1hvc3NvQXRDV1VRQktzcEFlemZMVnNlL1FiWXdhVTI5cVRtaFE4NXNJRXpm?=
 =?utf-8?B?NVd3M3I5S1FZRU9PQ1A3dzM4L045TXlVblc3eXBNMnN0TXk3YkM1WENZalRi?=
 =?utf-8?B?RmpHTTJoYk5lSnhPQm5GZ0hIWTVzaEt6SmZlZyt2OTJrT3NEWXUwOEw1R1NO?=
 =?utf-8?B?bFBoU1AxRXRTVXFWQTFRUHFzQXkvTVlKdHlQNUlmOGE0emE3TG5SYWppRjdE?=
 =?utf-8?B?dzZna0ptY3VIMUdDdU9rWk9uV215R3VWQmdEc2ZnM05HdlJocmJtQklJc1Zp?=
 =?utf-8?B?MHV1UG53NERXS1VUNDFHUXJVNkdZVUVicW9xUEptQWJEVmVXUElXNmlxallR?=
 =?utf-8?B?T1dycVdKSmMrTnhKWVpqMEFoaGpkYVl3blR1SHBVeHd6dTZBZmtzVFFPVkhs?=
 =?utf-8?B?T0JKS1o1VFIwVXNaYUFrS2QyaGxmdXpvUEVRazdtdC9SMnlyT1RFNFk0N1Y1?=
 =?utf-8?B?S0l4WEpGK2hUd2QxamYzSWcrTFE5MDNqZFU3MERqUzNrZkJQbHVvTGx1eFlJ?=
 =?utf-8?B?U2xUSSt3bUg0QW5LSzl4YjU4UWpQL3dYWmU4empTcFBUWkxYVVpPK01ZeGQx?=
 =?utf-8?B?SVRZY2Vrb3ZEbGUwejZTaWdqM1kxSUZWYU90Ym85dDYvUzN3NXY3N1pSWENX?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GJfL0+58yjmb7lGQXjVywk4230P8EWy7NqGdMVBJrz2RxZXbVH1fCN+UTMbwn6Ae90xFVO2Kx7XbVP/8oEsVDS3lSdDnxUGg7l2/QqCsNC9oegIF/4op843q+B+JS3NvYNGEq7waAbph/pTy3VGwRv0Od44O9XxS5ALxddhVtJ9E10ZHhvEEu65rNOnfBpmFXRY0xbgIPwqhEnI+ruFGrFLpQLWmfJHyeIiL6QnYenjRlYCVhVg2oVd+WIFkj9DGZq2bJd2Up0RZXebVpsWRaGZWxGc3MZ8KqX6x4PMm21xYle8HwOJESo3QqwBy9/ss1NSsViwnjVP9qkNjEtcjSrT62phE4fvJKyuNSZ2ZDXP478eGUaDJp1/cwc7g2WFrlCa8nmhjSJ9yF0WQcgWXKBlqG0saMeMb+wyoGN0udn22BDEk3qk9wS1WtEQGrD47L5QfPQU9MGrdzi0t8pNHmeK+SJellNzwxHBXvaiVo9oizH6Jr3M1ICwqrINqZbyBeHfJaXBuMv7ZC4dbS5R3/IDW8U7vVIMgYlXfb+dMed7v8ts7kK5Fvxrl9rx1z0eIN0jB4iyMakoUpv6/ZsUOnYuZM1UK0ihUwwD7RhYvv70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d881dec-267e-4719-fdcd-08dc79299f55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 00:04:45.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYJkeWizgal4cYYm/1DyQg062n+9IPobWtA7cbLX4ewyz0llE7iTT8XHZL2WY7jtRzL9h45/kvIsnjw5jevpsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200192
X-Proofpoint-GUID: odWNQ8zNKSdu9lp5Ib3fT4dQDRCcw2za
X-Proofpoint-ORIG-GUID: odWNQ8zNKSdu9lp5Ib3fT4dQDRCcw2za

On 5/17/24 06:12, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Our CI has been failing on this test for compression since 0fc226e7
> ("fstests: generic/352 should accomodate other pwrite behaviors").  This
> is because we changed the size of the initial write down to 4k, and we
> write a repeatable pattern.  With compression on btrfs this results in
> an inline extent, and when you reflink an inline extent this just turns
> it into full on copies instead of a reflink.
> 
> As this isn't a bug with compression, it's just not well aligned with
> how compression interacts with the allocation of space, simply exclude
> this test from running when you have compression enabled.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---




>   tests/generic/352 | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/352 b/tests/generic/352
> index acc17dac38d061..3a18f07601de96 100755
> --- a/tests/generic/352
> +++ b/tests/generic/352
> @@ -25,6 +25,10 @@ _supported_fs generic
>   _require_scratch_reflink
>   _require_xfs_io_command "fiemap"
>   
> +# The size is too small, this will result in an inline extent and then reflink
> +# will simply be a copy on btrfs, so exclude compression.
> + _require_no_compress
> +


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
>   _scratch_mkfs > /dev/null 2>&1
>   _scratch_mount
>   

