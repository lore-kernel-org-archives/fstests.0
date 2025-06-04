Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FE21D591
	for <fstests@vger.kernel.org>; Wed,  4 Jun 2025 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026785; cv=fail; b=eVortAHbM0gxhOMvsCr5JEXIaArYw9l0tKEtQiPGk7qDD9skzNnfXdNxIQa4VV9cz30fLtZysd1KhZyQAIZEOquiTcPFii244YEGSIEvnES/mujc8sOFsAKql7AH77hDL+upMiQo0gRQMH+6x5ff1qIHcq29Q3v6aYeBegWa8nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026785; c=relaxed/simple;
	bh=ZA1YiLWL+stGWT8k16GKmLVH87xEHgwOFHHQNd6MA2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=InsL7I1c697QGEKgBlbNBDPtopBN8bnmq+Db8t85RGPm4e8g/5iKu4vzonk6qqc+mUQEvh6pUo//uOoc4Y7OXLhsAHpG/hcK23ow6XaeOxVUmrDZsuUAqR/YbLH9gLPpDBA9S6VXVwWN4MHp6DBCLro4BpzhsnAv1SDDVkwI6Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qD/ooHkG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iObmaRHi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qD/ooHkG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iObmaRHi"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548g4IH014924;
	Wed, 4 Jun 2025 08:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aL6B7GQb0fPuC0stjEtZbbVG7/Pv4w6QHte//BJt/hg=; b=
	qD/ooHkG0IWSDJj3L6IlV87pb0W/GfAqtQrVOhFbRTUVfqHO+hDZYA9mwRzhcAGm
	5o+sl6emOwTdt5l5dwRC3sOR/ngD0AEBzAX7hR7rbG1mIywVqzTHRUFVxa4JRxXK
	gDHFsK6z43+Y9OAqHMn3lG/rRfOESt93sY40Cadsvs7F83EfBCJQCZdQIYyrCwbj
	gEZM0RDyqr+rK3jFAOgLULjY3KyGLtAgl4I4/xIbxhfcMkne9F/1t4OT3+sYdAz0
	Qyt/jMjzAmgv9NjBfWI2Cnp1TcTNNJey8aQH+w1npMn400RSJWNtN991Ho9DFBXn
	6jYCBPfnRFdCMhF+zCycxA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8kbh9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 08:46:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55476bJW040593;
	Wed, 4 Jun 2025 08:46:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7ar519-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 08:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPBbPz2o4sFuJfwk/MjOqvuemdhCMNxn7Dz4iRi0u5YoFzPbu83QzkSfxdIQM+8QxcFQzmA/JCiG2ZIMgMPLTin6q2Dh/b9nIHeXLwU4GIKLpmvDHfLHFlJoGCZAz08ESL1ShbHGKZP0ZBUt+Uj5JCd4nIhFORwNqqnp3GdNihB3iHEeIWLplqu8bZnUAOG9bWqAJ/WIfZBYOGNwFxzU1HoYHdVwdM62yLg+ul8B1xjlU0LTGBMsXbHAKNhsp3V047QIZvTGf3PwMwfsUtYzFGW1HtZL60ICoO15DNMGnsFpiYbd7/aRleze9WYP74DufJ5aDO88DtkOw6w7bOMZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL6B7GQb0fPuC0stjEtZbbVG7/Pv4w6QHte//BJt/hg=;
 b=J91aLCsAInkBF4X0lKnn4mz2Bfx90T8B866j1SfcH2GwfnqwQjkvhOm1hBuTF0fwHzOtpsM54kfF0ElMUqiC9DsHwWzyyIbeKMFrAqs+0b8kEPinNGDkj3pSnzBdiK6x+beQ4c6txQrpKCRcWVHpJPynYErKhbyGKAgjD2CtKix45seO+asJtYvvqDRhsdN6auZFslTlNT7tacoEcKH4pt8Py7QtuFRHeoPbi5t7w98vi1qR81cSGxoWil2MKiWPadgdvXJwP2NXH9fd2G3Rl8+RTx/GHVFpy/s6Enxc1KCzcNzoSFlzmJCOZmpM3RPBAaf0xXH1+ipmB5TnH3sTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL6B7GQb0fPuC0stjEtZbbVG7/Pv4w6QHte//BJt/hg=;
 b=iObmaRHiiuhTz4oAtb15saZbL7YavCFh4JsvgTzCAFsnR0UE5ZfAhzmK0TIpuqPxaG9k0+d6RvfUYbDxTPatSszwMHbQvTjdYBVsFHq2g5AhAM0PnTXovLNm2PUnzVxtnJj2jjwytvNiECZ/r2Sa5x2IriagwwmkBH+jjolxqew=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Wed, 4 Jun
 2025 08:46:06 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 4 Jun 2025
 08:46:06 +0000
Message-ID: <f8969c39-6fef-4c02-8b08-9d40024a0423@oracle.com>
Date: Wed, 4 Jun 2025 16:46:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, zlang@kernel.org
Cc: fstests@vger.kernel.org, friendy.su@sony.com
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH0PR10MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb52504-2648-4c60-1f7f-08dda3443e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEczS0xBK2w0aXJiTTFjaWo2anFYcUFOYWFTMVdyWEdrdVVjQWtIR0FLVlhD?=
 =?utf-8?B?dkhnQ1BnTkdzRkg2blpLcGtoaWxKNnA5c0x3RDlDblB6Rk8wUExnaEd4cUs3?=
 =?utf-8?B?dkZOUjFOR2lhUE0xNWtGWlZ6ZS9KMmRCOWkrTndRZHVFcUxLWVRJYkdIcFl6?=
 =?utf-8?B?bWphSjhqbTIvRE1BT0FqdUtlQklQYlJGRUs5NWw4eW5FS3V2U3RNcVRodFcy?=
 =?utf-8?B?S1JzemM1TUQwUGx4Qm5jWWpaZGtJNVlxQjBmQVE1dzRKSkJUREhna3hma3dz?=
 =?utf-8?B?blZqQVNkem5WOGxySVZwenR0dllkcUtWQlNoYWx4MXZvU2ZkclNRNzJHZWh6?=
 =?utf-8?B?TnF5aFBrbjlNK3lnZktRWHNnWUdIdkVRM3JHdkRleUZyZFh6K3VUaVJvVVUw?=
 =?utf-8?B?UmhIKzU0RFBubUtYdjNhdXYxNG9CZ1F6VGtTRG5KL3RtT1h5am5wWVdHOWtQ?=
 =?utf-8?B?V2NoUVQ5U1ZJbTFOMVhjeGJlVlR5M29DVlQybjFLQ0tYWHpwL0FVYlU4enR4?=
 =?utf-8?B?QS9RbGZaNW5MZ1VQVW0xSk1qVUd1bzEyN0xwQTVVRURqRzZiNjg3aUUrNzk1?=
 =?utf-8?B?ZktjVlNtRUV1VnN5NkE2SXRCWHZLZzhPYmRpbUF5dE9Rd2ZpWUx5bzM0MHpK?=
 =?utf-8?B?dmZVV0F4VkovRGQ4S1ZVbTJaemFkMXZPNlJZU29hK1FIUnpWeWptcmlwMmZQ?=
 =?utf-8?B?enpCOFk0Y243VTZaNkVJN1FTQlhVcVoxd1JNQU5nODViZWRlS2Y4dGw0em5j?=
 =?utf-8?B?MU1Zb0FYay96QzBEc1Y2NUxYTEk5U3VvUENyN0FtdUxrMVZpVGdoQzNMVU4v?=
 =?utf-8?B?MmdVZUNTaEJSbFZuR25ybDBNOW9RZVlGNW16NEhXdWFBeEdsak5XQVA1ak9L?=
 =?utf-8?B?Qk9WbkxjTWZVQlhzYXl4R3BiWTVHbm9USzBnbGM5STMvaXIxN1E4WmhDQmZm?=
 =?utf-8?B?bHRqNGVTM2xvS1Bqamp6YW10Q05iZGJMS1Ira1JZa3VFZUF2MlI3bkYzZEt1?=
 =?utf-8?B?RVpYM3Z0Z0FVK2ZSeDVTZlVJSTBTNUlFTW43YSt3YS9ZNWZxdmVvekYyUVlo?=
 =?utf-8?B?Z1FrNjMycGpLNFdLUXdYS0pWazhtYUlON2ExOXk1TFFkaGpoeHliMkhyNWk4?=
 =?utf-8?B?K0xWZnVsWEQrbEltRXBvQjdGQjhqakdFM3Y3ZWJDSHd2UGlwTnpPSzNzdTlU?=
 =?utf-8?B?NldjNkYyS3R2TUhSTE5jMEREVWVHWGJVMEJQVndxMmFtajBWMktDVWxELzZI?=
 =?utf-8?B?QitwdHB6OHRWdXFFbGNQOUdRdVFoUVBDREE0QThySndUTHpyaGllUm9PMkNN?=
 =?utf-8?B?MnlaNHprdDd5WFRHRXZ2emF4Q3N5Tk90N0ViUjZMSytKNzlxRWNvekRZUGpI?=
 =?utf-8?B?eTB5OGNDYUNWVzJRTHM1bjJmVUlhNHRqSHZ3b3hKY0tYY0UxV2VVLzVVV0JX?=
 =?utf-8?B?UFNrSjJ3T3l2a2daOTFiK2ZyVkx3RnBuTHpVbm1FQlBPMlQvM0I2c3hibkVK?=
 =?utf-8?B?dkJOcUxibjBhQklUVktMMnkyWGxXdklRUjV3dlpodGlxUVh2dnI0TGo1ZUNs?=
 =?utf-8?B?NUt1LzVaZmRYbnpiTlM0bU56ZHB6ejJCRmNhK2ovdGR1eTlYUUlWcTNmamhy?=
 =?utf-8?B?RnVGeVlkT1RvVEhaeThHUTBySmRKc2E5eUV6VkhjWGxrQ0hxRXVTUG50M041?=
 =?utf-8?B?V2lrNm5tMGM3TFU1d1E0RzNUaU0wTTk2TVV5dnFGZWxkcVNhdWsyOWRrdW1Y?=
 =?utf-8?B?M2Rpa3R4eExtOVVvekJBbzRVa2xXUnlaWXJCZ3NKK3A2cTBNdU5QcGNtTDFr?=
 =?utf-8?B?ZmF3ZDBQVzhnREM5cnA5L0ZvVHBrbkxjOG9VOEpaQW9JMFR3TGxETG9RWGg2?=
 =?utf-8?B?K2F4TmtiMXlVYnFJMFVrUFJNUm5oUnBVbU1iZEl3WFhPS0lieHJiYkJaOThB?=
 =?utf-8?Q?aZ7c/gtgDjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG5lNEx0Z3NPYVkwN3puWEgxMS9ZSGtyVjZodk5aS2dTMU9maWpwQUtjL3lr?=
 =?utf-8?B?NEJuNHQ4bUFXazVGZys3VWdIVkZyZmRONnlyQTJnQWo0Z2txdHBwTjFyRGc2?=
 =?utf-8?B?ck9hbzZBaENpSURPcVFFRUJoUUMwMHQ1Wm9PSDhxbEhQNFhpL1RQMVdmZTVC?=
 =?utf-8?B?citUcnlFNitaSWRERDdOYUM3dTNpaTVTeFIxNTZuVTdTTEIwRGRDWkZ2eGFn?=
 =?utf-8?B?NTc1WWtxZ1ViazFSZ3VOb2ZseXNVeWd0VS9FM1I4S0VyRlk3NFdzSWtvOXVU?=
 =?utf-8?B?cUYxbGRLOFlVRXdWN1YxMmNNKzZvUE5xdFlCdHp5dHRlaGo4ejVFZFVQVWhE?=
 =?utf-8?B?WUp4MXBUQ091NWJWUmdMQ2ZQNmNJV0ZVSEZtWTFDbDhKTHlNTzhhejA3eXRR?=
 =?utf-8?B?Z2Y5QmQrU1JHVmcyZnU4akVtMy8xbnh0d3VldkRkVmZjU2pIb3VhS1Nyelpn?=
 =?utf-8?B?Z2N2MG9WbXplUkVNb0I0ZFVoRzJBRDhJVnpubjlwWnYrajgzZjlYVVh6Y0RG?=
 =?utf-8?B?NFUvZ0pZUjY5aDNFSjYxZ0pNTzR5aDhJRVJEUEEyT3dtNlJ3Q09SUGpDTks0?=
 =?utf-8?B?V0R2Wm1mNldsd0lZdHRXaEZ0WE1SRmQ5RnR1OWlScEMrbVkrcXJnKzR1U2VJ?=
 =?utf-8?B?eC9Wb1g0TlVwQzJnQThaT1BXS2RlT2tjam4vdXhMVlk5Slc1bERmQnlzRWxC?=
 =?utf-8?B?VTJtcllURGw2RUdyWlA5ZjFJR3BkMU1zNEJ2akt2SnVhZjA5SkhkNnphZTRB?=
 =?utf-8?B?am81cTFKMS9OSFR3Z3JiMGlick9kOW5FWTk5c3gyc0NabUF5aXYwbW9JZnJS?=
 =?utf-8?B?aHR5MUZMb0NMTzF3SWRJMnl3Z2FlRTlYUlNzK2d2SXNCekxhelVyL2gzbkdp?=
 =?utf-8?B?Q1lWcFVtc1JoNDN6R25vd1dkR1NCeHc0QlpNa3l5ZDB6ZzhweEEzWG9OVThh?=
 =?utf-8?B?ZS82N00vN1liY0dSK0JsNXFjZ0dFU3B4MytsdVU3ZTBiL1M5UkVBYWhEUnVZ?=
 =?utf-8?B?K0FvNjB0SFNJRFBPbFZVZnVWTDQ1Y0ljUFMvSkRYd2FraGVxbUx2bmltSkJ5?=
 =?utf-8?B?NE9ncDhzYnJnMEFJUjJmN3pEMGpHZzFMVUJVcXk2T2xtaG11Mm1aTkg1QUE4?=
 =?utf-8?B?Y1lpNzV4RzdJYUNZMnZjeTFNY1d4c0JQS2N3bGxtZlJTZEZLWmxmaXRVcXdM?=
 =?utf-8?B?SjRXZXA1dEJwS3Q5OWh4ZCtFMEVqT3dhaGQrbCs4Sk40MzRxMFNBUWQvZ1Fj?=
 =?utf-8?B?NURINUdrLzNkNEQ1UEF5SmxoUzBxMWg5OW42WjZmeHBJb1BLODU3R1pKQng1?=
 =?utf-8?B?MFJTWVd6NlRDUkxSTkdwSE5TM3grVnJ4OU00TExwMHdiRnZlbi80dW9aY2dX?=
 =?utf-8?B?dk43WE1lM0s3L0dzSkQzQjVLWXMvSDA3NUgvMmZXSWY5TkxUVS80Z09vY3Vz?=
 =?utf-8?B?YnR0TG5pRVYzejBZcmFtVGNPV0hmamhEek9GMGR6d0xIa3RGZHZjcXYyejdV?=
 =?utf-8?B?REFxTFVhM1pkbVlibmhXVGJqbldDVUd2bFdVenhzVmhRaGk3UXFyaGcyMDY4?=
 =?utf-8?B?YnN0YzVjeUUzYkpIUCtmQWdQcTNNVS9KckI1dXhnMnV1Vm5wMlRnZk5Va24r?=
 =?utf-8?B?SE1VZ1B1TVg1Ky9mQlpQYmMybE5WcXBZcGhhVzNucU5QbUFLanBzc0p1b0J6?=
 =?utf-8?B?dTNnanhWcFBZdW4vb0w2a3NueExrTWFNR05oYkxBcFQyNm9wWThRdzhkTWZr?=
 =?utf-8?B?cU1QQTdCdThPZW1mdWdCbGtzNG9rUW5OSVVzalMrTmVNUGFNOTRjZTVmL240?=
 =?utf-8?B?N0I0d3lQd0FIcmgrOCtZTkdTcDU1ZStqWFlJRjdnUXJ5YXRPTHdscXoySDZi?=
 =?utf-8?B?WE8yVndFN092Z0hGeHFKYnVHcXhwYTMyTVdTdm1IRXBidStqQWlhMjdKV3Rh?=
 =?utf-8?B?TDhjekdQVVdJcTVJbm1lak9SUXpPLy96ZGo5cFhjM2kzTzQwOHZhemFHalBC?=
 =?utf-8?B?WG1WbGxOTU5wY05mN0hZcmdkUDJPOUFYMitCWnZJL01ndWUxZXJjZnExa0Nx?=
 =?utf-8?B?aThneGtuRmpOdUx5UHlLUnpVVUdXTzVkM0FJWmtneGdGVkNXTm0zWWJDWTJW?=
 =?utf-8?Q?Ibuli45TPXNmCl1iRHctG1N8f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UZafXrX9mKuzkesqyQA5YTqQ/YTDDC1faWdE2rrV+TvxJCfr8f9MqJN9fr/I76aqVirzP74AiEbpg6HQfg7nvBoXnHZHGVQWOAqjcD8dcJGoqRApk/CzBWgPilM92jNMb8Avjg+kKfJStxqS1FBlQMSojbreIihOJ/jiEp4nJWUW1iLFI4MI0xpsxe6wySSFBPa9K1ubyUhd9A9po3yba2MjtSrSKyy+cBrciPoa7VmVVvdbY2H2b8GsxyM9WNW4xE4c/8Qp22TR7ZULV2dqcuo3hmnG7dliJicCWpn4MRE/QEToknFhuFVGg3VFBytcokAWHz56cYeuUmgrguYS04z5Zej4t49rs3VPq7/90oj/na4HZiDzXGZ96W7k2OovRfMg+ko3A6iRAYwD+5+kGFLY2SpAKB6qS0WCWLoSnuEpYXJ5Z95pBCe4T23403qgbsLzhv/GzVkYh1gbBbXfmk89x0IJNNYnvmTZOeNwh/UNMNGNJk+kZk84RCuFwXUnLEpDSd41j2eI6z8SDF5Bn1pdk6rOkztkK+2DyuA6sGOgDHi5JvdOg1oJKWKE5QWsCvF0Nt0dXAEa8811R9lAFaQ2nBQ1tLxWBgosaeCXDxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb52504-2648-4c60-1f7f-08dda3443e81
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 08:46:06.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qJds+oDFSwALsLO37LEqO1DSFd3w3ZQx6k2eZnpogL7eSe12jpe1fn1xlfShCQAWL7Q5E/KMROGVRRIdlAvTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040066
X-Proofpoint-GUID: xjzAFDQg9OaMEJ8A9Il4JYK1SmSOyoWI
X-Proofpoint-ORIG-GUID: xjzAFDQg9OaMEJ8A9Il4JYK1SmSOyoWI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2NiBTYWx0ZWRfXxRfM5VUYUF+6 DotVSNg4BTaPKlXuH9G6tG5pissxMgoT1K970nxIW666Ynrq+HUff9meSMau/vHjDQaeI4mdC9B dd/3ogYqhzUF9booksqhs/s/l+N/VsCFxQGY7/LwhUTJ7VvQxxOuPyO4Ruiw5zoNB1vYT51jJrF
 TEJDGnSSnZtMdehN78Xyo24q6ynuCAILhQvqyeeLCHZGInPrseXyfHeSwawXDrDw4GcdmwXkf6I txhxrWgIGlMsTOkUGkhwTR9yRweJebZyir4AhC+v2sF4RFS+8dofzZPBr8uZMXj9E2+Nasv8qO4 0Fh7KPa++8yBN8InE8lXyFCn3xdyWUt1iPDXenFTtddpB5XpdWs6ZE8iOxK4JYamrERwoIujs40
 nMvjVhLLiHuytWl8INWy4Yk6i9Iy0EevfPXJS62dGWO8a+H8nzy4HrNOdwWyjcLsxOwNvJa+
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=684007d7 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=z6gsHLkEAAAA:8 a=yPCof4ZbAAAA:8 a=98RFvY3V_YbXUMZMLYYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

On 5/28/2025 5:15 PM, Yuezhang Mo wrote:
> Before testing for shutdown, check whether the file system
> supports it with _require_scratch_shutdown.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>   tests/generic/730 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6251980e..1dce547f 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730

Zorro,

While here, you could also add this test case to the shutdown group.
Nevertheless,

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.


> @@ -25,6 +25,7 @@ _cleanup()
>   _require_test
>   _require_block_device $TEST_DEV
>   _require_scsi_debug
> +_require_scratch_shutdown
>   
>   size=$(_small_fs_size_mb 256)
>   SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`

