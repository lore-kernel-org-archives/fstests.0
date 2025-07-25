Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2541F4617
	for <fstests@vger.kernel.org>; Fri, 25 Jul 2025 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421322; cv=fail; b=EaWGL3j8KTB2sOCtNWr9v/nthfZsn5ZZpt//QgSMfLalfKDHvBpkWFVvZKEPYeKHcBBXC6lug545ZsXcQwAiXJ6bBaldxRIpBX36//tg+9HYirCBzmZTSnlrCVAbyQBQAK53sEkJeKbCv8q+ZYtVoPc/BOW8vs00k7zU1gO1FZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421322; c=relaxed/simple;
	bh=zxJ1o9Ly7cY+R7AeSk2KhfZ82D1MdNLoFyZ9z+G+PcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ho0cylQ2OGG0d3OuXzNOs59FzXRlqRE43QVIz2nt19d/Y4MpJ1iXEExsF72mdpxyIwXRfx3eB+pcku3A+5UH4SqCVufwVzIjAjaEJSHkB/jGZ+79lIxnM6xPDDwQjSAY3+ih3ftMy1xgGM36OuFAMR1VYPh0ZwheOatZBDrcdOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kiEfAeI1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I8inMrA/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kiEfAeI1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I8inMrA/"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLjs2G011804;
	Fri, 25 Jul 2025 05:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oywI4DDBJtNWcsTu8A7cMcDpzyN7NZIjFMGYFHftvWw=; b=
	kiEfAeI1fn3u5ggQWFAfvQkOMnUx2NZF0EXS+tA4XslH2ApgyY/9L4Qvbw+BUUBD
	wShTNUbvo1cTxWHS5Hu/cx5Lf09iRCmcNOhiDssdN0Fom84uAoFsx6t7I0H0yFK+
	Q4bToebaud0kcIutXQCXjh/pp12rjYt/YWhpps4I/aI24mYaA3G8EdVvf85XXOFY
	uAw5FhDQYOfwlpTlPhS9BX4PGyE3OAU875wFt+bVv+PLeBFX3X6BDiuHb36t89Qt
	BksCv0swNPWtGicA53Wwz0e6iu24jDD1GuM89m7ZNLWj4ukkBjqf0pUQdBDgUbdQ
	4njKCI0yjLEfmfGX1YX1qw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k8c07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 05:28:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P3d1xt037690;
	Fri, 25 Jul 2025 05:28:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tcqab7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 05:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGZm1SlUNIo25qangZyRc9x/rudxwQKDBEmcW2Mfwtu/muMOcPrpgV3/qlpxyLL+JvPIzBSxR2/URcU9XHqGdP1TqWpNbYjRN+8muAvxOiDSFTqRUYH0rLOeOGFov3j78NTTVALlBUxEIyDcojAYXM9Om+y9iEJP1IcCg9DJCyHKacuOtuafdf00L1NAkBKFVv70IGDwQja7Ku8g2hfi2lCB14LC3R38kGDG6cEnN1V2NP3mdkjwcjCyeMpIZomm/RVaZ0c4bLOGMXRUkaft5AkYvjlojUR5qxzFnu7J3CQPgsOySM2JMKEyeTc9NJAJRuakW3Z8+c/eVG08J8DABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oywI4DDBJtNWcsTu8A7cMcDpzyN7NZIjFMGYFHftvWw=;
 b=wP5HkrXKyJ0UPTPsDjLweAsrZClzNV5qlThWc6kVeXwH9oY2SHJpkgy/0T6KzY/Lk4B6be8ZrDWbLnHnqOi3iU6fcGsFKvl+QrYGJIIeYkcEyRkNeGz9e1RhhH+20kRBLVsppKVdQS9xvoyeefoE5l+YfQ6ZKP6e8b4g2iSv/4lXV1ZXFNpKmpvf2/YEzGpiXA009l/PMUkMqSsHzdTAbZeVhIeYiS7xJe6oou710efvOHrjZiBFekoENmYyDixIMBHq/fLw7YCwvxx++yCjT7KBqDg/WMwPbYTkRF++jUh7eQisYB2DxO6oVfWeRpchvSNziGUUZRuZQL2OeNgy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oywI4DDBJtNWcsTu8A7cMcDpzyN7NZIjFMGYFHftvWw=;
 b=I8inMrA/L9xrUMT6cGYcFWqiC9Cuc6tPL3I4UeXH0jNtH7X+H2NgtGj4Y5hdmZwjSztWS+fzeJRIKE3ZVU1oz0xg1NT8XQmOE9MPJfp4QhCXClS8gjpokATcpbmhlCUSQbsLxG7fAriWe58zaOM0QKhQ35Xnqiabucz3dwgyQCw=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 25 Jul
 2025 05:28:28 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 05:28:28 +0000
Message-ID: <7183ed09-df4e-4a52-b34c-3cfa88be4ab4@oracle.com>
Date: Fri, 25 Jul 2025 13:28:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "generic/730: add _require_scratch_shutdown"
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, zlang@kernel.org
Cc: Yuezhang.Mo@sony.com, fstests@vger.kernel.org
References: <20250724072514.3313006-1-hch@lst.de>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250724072514.3313006-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|MW4PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 8604bb9a-12d6-45d2-3334-08ddcb3c156f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1NET3pRdXNPT01HVGwvMk5aTkM4MXgrcmFQY0NRVllpRW1SVDlOY0FBUmlI?=
 =?utf-8?B?TEF4VUdDbXdHaUxIWTdpQW8zQzNsTEI3MjZCRG5KWmJOUDA3YWFtRFFKTEhm?=
 =?utf-8?B?bUlJdG9xbktadGZ6bE9rUmljUXNSVVFoTGJsR2NYZGVuQXdPTGJwM1RLZlBT?=
 =?utf-8?B?VEFneVRBcWtuLzZNUFZVMW81NkJTZC9ESGlnOGV3bFBTQk5qT1JYbXBXN0Ri?=
 =?utf-8?B?R2YrUkhxdnh5Tlg0TjV1VU1qaXhMMk5qSnI3ZXN0WjFQRzNBNWtZanBWQm9D?=
 =?utf-8?B?cjM5cFVDVGZuNzE0VjI0Q0pObitqR29WOUpvWGlsNGRxU1RoNnREZngxdzcy?=
 =?utf-8?B?aWpQNlBjN1dwS2V4K3hJZXhLa3N3OVFtckJwL1ZSaGd4SEJiMHcyRUlYdHJ2?=
 =?utf-8?B?bU9qazNoM3hwb2V1MndpMktBbTJsWmVmZ1B4SjZ6UDJWREsvTmVVelJ3aUFx?=
 =?utf-8?B?dzZvb2ttc202dC9SYlNQL0RWYWRndWFmTDB5ME5mekhwSDBZdVE2TGdsZWxx?=
 =?utf-8?B?dkM1VjU2NXY2aWFwalp5UjhMUVpvSENnZlNtd1FMQzhsS2VxZ0RBek9XdktB?=
 =?utf-8?B?OUhUQXBCUG84NEI2OUtEdEdycUhLeVBVMDFDMSt6MU11a1RySFpvS1NneDJN?=
 =?utf-8?B?T2JLRFQwZ0Uzamh1UFlsYjB6ajFwdUZpeUZ2T3JXUXlZMnR3ZHpBbkdBRTRi?=
 =?utf-8?B?MmpnUWJDSmxieHdsNVlRK2c2VEd4VEIyMktLb0ErZ1JKeW1NbGRnL2RacllC?=
 =?utf-8?B?d3Y1bmxTZVd4SW1XdWhVK0pxYW1xOGtaUTV0SnFNYVRhamcwejFxLytBdC9o?=
 =?utf-8?B?V0tFUmhnemZPZGRxRXhHcmdMc0NKQXpiSVl5Sll3dFZDMlpEclVmRG4wVlpY?=
 =?utf-8?B?NUdDUzQ4bnpxblhJMnNDOUlLb1o1WEFkTHZlUXIxQXBKMHRheGJZaitpOHda?=
 =?utf-8?B?Vlo1Y2ZMVEszZnNCRXBucXA5RjFKbGlwei9kU2xXMVlLV3ZDSUI5QnVyOVJ4?=
 =?utf-8?B?aUZoZmhyaDlXK01zdG1TN1Z1UjYvV3AyVlNJbXg2MXlKZ1NNM256cWJrMEFm?=
 =?utf-8?B?M0VRTitPL2VEVEdmYzVlQTJkYm9pa0pTbjVmRHJjdDR4N0I0T1JEaGhyUmI5?=
 =?utf-8?B?R0RvWlovOUYzU2hpK0lENHlZc1VWcTdOOVNydkNYdHdCVlJBSXpKanpMZDR6?=
 =?utf-8?B?aWs4VEo3QkNRdmVBRjFuSEFCbmpncWtGM29kWHI2QWJ4SkJRTFhmNWJHN3NE?=
 =?utf-8?B?VU92K3Nva0p6WGFCUjZpK2JtL0UzQVZEajhBVTRVMS9pUGYrY1h2M1Vzckxk?=
 =?utf-8?B?WGpUcUhNalBhaWkyVjA3VHIyeEdTY21xMjNDQlhxcUhTSmswdFV1eHF6N2wr?=
 =?utf-8?B?Tzh3OTZpOS9jdVZpWVBkMWhlYzBJTzdRV1R1bkxRQUN6OFNrOC9yTDk0UlBi?=
 =?utf-8?B?Y0w4VFlkSEhEOXBaMzZYQk1mUmdrZExaWTVaVDk3T1h6aUxUaFNHTDFzVkl2?=
 =?utf-8?B?ODU5NWtIZW1GTFNLT0VTK25qTlYvTTRwMDc1ZGgxS05HbENIQjJ5Uk1zdS9n?=
 =?utf-8?B?YjVvT2RXSGs1K1cwOFVpSnM4cUdwUTJDWERNN1ZKZmw1ZTZsZWdobUlEUzY3?=
 =?utf-8?B?WGNqcG5JaEozM2t5aE1xbGJyQzBJbjNocnhzMEQvcmhsWWg2RzRCeld6cE9u?=
 =?utf-8?B?SU03c1dJRkNIZGx5bmsyUHNRWVcxWXhjb01IMnd5UkpwQWlldFlQTVEwZXM1?=
 =?utf-8?B?bmJ1MGd1dG4zTDhhUGJXR2hIa011NGsreEhQa0hIM3JTTUYxOHdyTm92M1Vj?=
 =?utf-8?B?MTQzekpEY0RBK0s5aUI2V24ybUJFaGErWml4R0ZnWDJydHRxUlJQVUhmbXpY?=
 =?utf-8?B?bE1pNjZrejJzTU05cndqdlJWbW9tMDh1U0dmeGdoWFd2cFRxNkIra2lJMVVE?=
 =?utf-8?Q?l94aLRrEssY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk9hQzk5L3RqWmFlckxBUE02YnNpYkdwZ2R5VERIZlVHcG1mNFJrMWEwdHhI?=
 =?utf-8?B?L2xXQkR6TENCK1dqWHIyM3FJb2lXczdGKzA4aCtBTUhXcGRTTlBSTmc1UzJC?=
 =?utf-8?B?VXQ3ZmhTdU9keTkxdDFIc0t1cjV6cGduN2lkYTI4Uk85ekNBdnYydjdRK0VW?=
 =?utf-8?B?NVdRQlBEN1N2emU1M210cTVoZmYzaFY3cEdUL0ZPbmJpWWdQcWZzUVU3M1Ru?=
 =?utf-8?B?SDNyOWNSQ2o1cXZzdHBrK3FOU2QvMm1YdlhXSjRGYnJRTEtzTnFhWFNQSERY?=
 =?utf-8?B?RGplRERhMXFueWVWclpWR28zdUlrbmo3aFRVZC96Z2xYR0h1N2hpdWlSUVJU?=
 =?utf-8?B?aSt3ZXpsaXNsY09MbTU1L1ZMVEh4ZTZoTUNPOElKdG5wSWZLM1F4bENYL2FZ?=
 =?utf-8?B?WkYxd2Z4dXN6bHo2VWxKYnp2RG41VUlqK0Q5eWJRanNJQTZFSmJ1YU5XQ1Nl?=
 =?utf-8?B?eS9EVzRrMlFPY0xRSGJZUTdMZk10VUVwNFpCL2hTR1AxVVZ3b1RSQXcwMHpJ?=
 =?utf-8?B?V21ZRFcyR2NYNVozdE5TNmUvYUJlVDFHZ3Mwc1VkZzZjYUdMZlEvRy9hb01j?=
 =?utf-8?B?YlRJSHdQQmt4VldmWDEreUIzTEtQZVlUTERORXFMM0hFbnkzUzE1RVFhSGVy?=
 =?utf-8?B?VUprU0hheXg5Qm93WkJHajhzcVAvSFJWM3FiUmZqdEFGN2Z6Y0VydEY3TEh0?=
 =?utf-8?B?QU84cm9xeXJ4RnlGQWRmT0F6aUlQR0VSSS9WY05XVWh2Q0I4RjQ1YjNDNXk0?=
 =?utf-8?B?NzQvYUdlZkt4Q1hsZDR3S3M1dFZBclNXOXlHdkNwNkM4MUZpcEhjSjNtWlZ3?=
 =?utf-8?B?S05iaGIyanp5aS9FZ243aU5uQTgrcm9vQWFmZndlMmZhZ3ZnOEptN0RPSDNy?=
 =?utf-8?B?b2c5RzRyRWxadU9HU0hrK2p4dTFQVHAwMVJCanFibDdMRXdEWlplcTRBU1Bs?=
 =?utf-8?B?ajdEbmRBaHEwSjlmd3lMQmo0UjVYNUl4bWFjZktQV0ZoVENmUUZ5TzNHRmZy?=
 =?utf-8?B?UEVaZUp1UWcrRzNUTzl6OS90am9YMnQ5NGdKR3dNQ0c3ZlR3bENBNk9wRWYv?=
 =?utf-8?B?d2w2Qkt1TVJFWFFMYmR1THRNeXczTmdINWxwVDVuU0lCK2ZFNy9oVlFJZlJZ?=
 =?utf-8?B?Y2VrL3BmWFRSL1BMb3piVDFseHZBVFpUV0R1Q29nNHRFMVhNMFE5ZzBCWm0y?=
 =?utf-8?B?K3htMWtTb29mZjZ6SmxwNEYwdHJxUmp0b1hqQWVXbXhhV1JuY3lNcHVTM2dD?=
 =?utf-8?B?MHJjakttZU0vVzBEeDlSemRPY252VEh0WGxZYmdIc0xtaWl1ZTFkb1hkbUpV?=
 =?utf-8?B?dkszL0NLbkxEMDJBMElva1BDRkFXRzJYU3QwZkphVHRZbnIydWpjKzIwTll1?=
 =?utf-8?B?Q1ArMUtFT0d6VFZGdk9aeUV4L1F5dmpmZTRaL2ZZTjU5SlBPeGZQTzZWTnJ1?=
 =?utf-8?B?N1RDQkxtU1IzelFXV3ZOMUw3b2xrQzFoSFBJc1NaUExDVEdkeTljcjV0bks4?=
 =?utf-8?B?aXNpY3owVzZWdU9udnQyc3IyV05ZazdiTmp4RUdkUitQSGpqejd6NTNUSDd2?=
 =?utf-8?B?N3VBN0I4cjFjbTBTU1ZsenJ3dlFIRjRWcXh6WllGbXN4VEE0K1VOazd6YTZG?=
 =?utf-8?B?M2g3dVRsdHdya0tJZTlKRVExeERvMGNWc2JXdi9EM0QzMVBncUNtTzZ0bjNS?=
 =?utf-8?B?bStiSjJQejZkb2ZvQ0ZKWGY2VkEzbWdVQytLeFFNb2RlZmZHdC9oTStITUJS?=
 =?utf-8?B?RlZnb0gxb1FVTXhvNDlhV0Y3Q0FCNndSRGFYRnQxODhlczA2ZU52TTAwbWRt?=
 =?utf-8?B?T0JCSk9QaVY5dFVBUHdRb0JvMEVwc2hoUkFLZkRlTjZ1UVdKRk5qZ3A5K2Uy?=
 =?utf-8?B?UWF5TUt3djVqNmdVcXlrRHRJc3NnSElNYzh3SEhDYWtjWHFwRk83S0dUNll4?=
 =?utf-8?B?V1NNcjZVZWRQS2FaeStFajJta1ZmU0IyUGJvaHNRaGtVcGsxOVNaZXNPR1E0?=
 =?utf-8?B?VC80TEtibkZOM3ZVdGhHM0V3TC9BeEdySVpXY2RRM1F4ZmdMUXBGM2xvUWlZ?=
 =?utf-8?B?VjhNU3RCdTBpcDZTV3Y0amlOSDZUTld0NmY3anJIQWlhODRzNlhxVDdqL0pz?=
 =?utf-8?B?MXFlVGV6VlhvNXRjUCtOMzNQL1c5dGx1N2dxSytMMzgxa256dWZDNTlhQlNN?=
 =?utf-8?Q?7HPghrewyG40EhqxUK1vey9VhTNZKTcj7iixgmwlfXhI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ikjeSQYNmhvhLcw1m+18OATxmQ1H4CHmF0WXzbD6Bu0EG6y0EwT80aCJIiDPEJuB0cQZULAjr3kvCU4gkyW7jmMJmuRQaR6R8/8AWLf2pOy9IXIAvFDP3X0qTISqqYuLbyMJxP6FPot3jM0q0pric6FJAAKL0JABuFxdl9XNTC80UsTGtgMJIRScpNYgUKjs5pXq0zbMtwoCy7Rt1c1muWZZp9vrK3Mf+gHNDyVzGvM6UYM++B1M79i+QmyKOdVvMBC1HDXEeTynHtutRVdTciZX/mYRV31ftw5kXV1MHum+aAlYTVhi8useZPNSeY4AvBHzJDQldEM2xZRxmAM39ayBZ8ReqJnRkHGYSuYPA1vf9zkuWduUqaHnKqLA8MeQ/HbfAZcEsVt2UfEBRphkxXqL/vZs2ugn7HqOSzZD8rAStchFSd2DrGAe+FRpbh20Zm17OCyMu7mB5EeK87JP35+Er8IK64UhQk42ggfucum2GnmdcomKR3caehblfPwCgmJ9TW+X5XT1ddhKXVWSHLmUWEJbiqiG8Uoxt1pFd6ZsxKY8ZCySgdofA6B+UMypuRTbKTplqNQixOkYmRk82Xmrq7+BGduugqyfu3bqt1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8604bb9a-12d6-45d2-3334-08ddcb3c156f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:28:27.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKAXV6bg9zYqP3AO3HFsO7e9v4FX44Nfnzw4E3ejS1cktH9ewdNYtm2Z1OBPJeeehkBn6mMA9UeH0SGecgiQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250043
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA0MyBTYWx0ZWRfX1OgMP8YXjkhJ
 aGygN3efaNcMdfuIZ0MVxjIDjRXmCBIzcfL7DSXOfjQnRD3KHcV8iKFplWK7iVjLlDJL9fvxleK
 l9jP4wvZNcGz2M7mOILQGQ6zBAwnLOoa9gqJnFk1G/TS7FeXTVjYETh2f3sSdbE9hB3vmQJenhP
 0fPQ0JelTdiYt4vALnURMzHxb61mREWsERDEzlhlE/VGltfofd260Mscnx5K8rbJMyVwCUVmYaI
 Np+MaHuJdI74cTSR4UinIXHgoyWfOgpTsz3AuozDMI7isior6+aXNjjmwpefnC1+BigEK33cXZ/
 xhe2lm16LkTUqM40VtUxWyCDpKF+ElQ+g0wW96oJmhUUi58R73sjxXSM7jpvtfr2fQ7nq9n54Qm
 pcxjhR16OjN+QUHbCJOOo9EYF7KEBq376LeloPbXGG+7zHPzCUKu1lR/c7p1Zo9comfAPGr/
X-Proofpoint-ORIG-GUID: 7OTTtpmc2zV1VoN0hndQaQTGYW0DQT_V
X-Proofpoint-GUID: 7OTTtpmc2zV1VoN0hndQaQTGYW0DQT_V
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=688315ff b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=bpTxw_mEfQCdvJKn9TgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062

On 24/7/25 15:25, Christoph Hellwig wrote:
> This reverts commit 68c9ac2ad74ba31c02275fcbb11d1cf90f0435b1.
> 
> The test does not actually use the xfs_io shutdown functionality,
> and it does not use the scatch device.  Adding this checks causes
> it to fail for setups that do not use SCRATCH_DEV at all.
> 

The test runs on the scsi_debug device but verifies whether the
file system type supports shutdown via the scratch device.

Since mainline Btrfs doesn't support shutdown yet, we see:

---------------------------------
generic/730 3s ... [not run] btrfs does not support shutdown
Ran: generic/730
---------------------------------

With the revert applied, the test case incorrectly runs
and fails on Btrfs.

---------------------------------
generic/730 3s ... - output mismatch (see 
/Volumes/work/ws/fstests/results//generic/730.out.bad)
     --- tests/generic/730.out	2025-07-01 17:41:30.991699629 +0800
     +++ /Volumes/work/ws/fstests/results//generic/730.out.bad 
2025-07-25 13:20:55.690043813 +0800
     @@ -1,2 +1 @@
      QA output created by 730
     -cat: -: Input/output error
     ...
     (Run 'diff -u /Volumes/work/ws/fstests/tests/generic/730.out 
/Volumes/work/ws/fstests/results//generic/730.out.bad'  to see the 
entire diff)
Ran: generic/730
---------------------------------

Thanks.


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/generic/730 | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6b5d319675f7..6251980e33e1 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -29,7 +29,6 @@ _require_scsi_debug
>   size=$(_small_fs_size_mb 256)
>   SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
>   test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> -SCRATCH_DEV=$SCSI_DEBUG_DEV _require_scratch_shutdown
>   echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>   
>   run_check _mkfs_dev $SCSI_DEBUG_DEV

