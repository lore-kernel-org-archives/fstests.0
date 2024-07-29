Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6915574C
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262936; cv=fail; b=T+N/bPWGRMPjjA3hZTxFvZ32am/+8aOkHbBzRs2S7gSKOArnh0OT24VYjw348hlYXLfHFRQekSZQiPy1A5dhzUs9YaO2UQW67x/8pRgdKL0O2NGcW5V5MiF1+2tB6pbQ0UVB3EnNwgAFsZL0tpf4BCIPY61sKwAgkycWmpEeXuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262936; c=relaxed/simple;
	bh=fuNwq3wPnip7iUOvwv+KKFReLDrOuTFIczIRPqbhug4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VvsERfPBBvA6tKDrU2EEA8Shh6FPBGHgrOeAU2heknQk5AOQfhjd93j/k8q7/a4/lsO+/rRlCujuBHFYfcdQVWrKDSccsuA2hIfgZTcsR1SI2Jf+OkDE8+5lFq5RK90TMNDFpTLrOcA6SPiD5lKIqaRFlfh6ph+AHZJrNKCkMqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Io6n1/rv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QVLRNCvY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Io6n1/rv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QVLRNCvY"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MfiB016462;
	Mon, 29 Jul 2024 14:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=fuNwq3wPnip7iUOvwv+KKFReLDrOuTFIczIRPqbhu
	g4=; b=Io6n1/rvdi0onNCYWxOweeCtwMByXJ5f8wXWoAvQ6Wmn50BYvw4S6ccQu
	s8ogiiFUAL1u4hCo0x7AjqydtnRr4hQYPrcmrQ2kOZtyL4STYeTr/RZGaWar3B2i
	VvlPpsWqAnDQureTR5leDTQLKDg6vwfJrnuEKjXnq2MsTslv+p6hgjJQhKAm6KHx
	FUzaomA0UhgLACMVx7aejmOsvWXZCfUcssFn6xPjKada0GNjhM81UxxGhnQ3GcPR
	7zLiizOo4QKvy+tSB93VjuhSSuz0WDjFzrZbWQmr2YlWgFkuZbR25IoYY8GqfsWJ
	aJMXAg+Etvfj5SzB3GMLFjUmM0tPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyapp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:21:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TDYaZm003851;
	Mon, 29 Jul 2024 14:21:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxsqmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoGbJGR0S7mh3yEHxhr3RZOEoMPP9Pk/Wabew5l2/9fzRrE4YFpAeGDJ8uHi9ScI+tiSv0dWwvfIETpPlDnkTZE+zd089Z7yWcx77aUTueMdqjzqN9lFu9OuTNXGTBYMARa96Ot51yamxunuOX7GGgOLONnoQHmjR3rtcmopyZhtHutumzyYVhbZf+1DWgB500OTwMD2fzIcdwrARylRk4c37ZitT5yKDg52aalIBYQXID4MavYdAyx71Kd0S4rTAyittggmPPhdO0EvtTnu+ljWBHZegsrQd3ddZ1JuQIxtTvedXnKGmMD7hCmnjXinFWyIqU/IDFQv7ye3nKujRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuNwq3wPnip7iUOvwv+KKFReLDrOuTFIczIRPqbhug4=;
 b=wqKCLm2zYI6S97hDHr7dtWMnOa2BP2eZ0Mcjc2nnyzM+mkv3Z+5SUgyf/v1P7E8KXZ+Ssl0vCOBimfCadSvnzTKdPaJP5Turfy4XaJTpctxYLi7Q0TK+ygYBQNyJBimnAjiGuMKt06pPgt1sdExj4rNF3dARB+v+7t+wp/WeZcMQvn6BUtXvUZHYYzWgMlljM6dpC2lBoLU6COJ2WNwUoqIdPz8dszcE3TSWVz78r1WWT6UGa7HxydjNAJMt4gWQhegJF8S5ZkYySSTnYrQZQIab3vpEECYktkqZEk3C/I4bkRNpiw9uPbcXdxECGUN/470NfPtTrhtf4+D3pU/Fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuNwq3wPnip7iUOvwv+KKFReLDrOuTFIczIRPqbhug4=;
 b=QVLRNCvYqYw5RgVDM+4DJrCqgKPtioVmW0RgzwHsseS+518v4fJrXsbcFRu0k2ehAAHTwt/0n1H6laS1rqlhh22btGSTwSFLIgYmE3SlZcMcFxBsu5p94lVIVHeNya23Cb78i4QkvyiQ2qiLWafgKAdasK5U6fLF32IfxDwFkAM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4255.namprd10.prod.outlook.com (2603:10b6:208:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:21:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:21:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Yang Erkun <yangerkun@huawei.com>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Hugh Dickins
	<hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Subject: Re: [PATCH v2 2/2] generic/732: don't run it on tmpfs
Thread-Topic: [PATCH v2 2/2] generic/732: don't run it on tmpfs
Thread-Index: AQHa4ZRp2uVJTyOYz0+HOEmUaMLQXLINwKUAgAABXAA=
Date: Mon, 29 Jul 2024 14:21:31 +0000
Message-ID: <D332E074-6760-4EC1-B3C6-437C1C52229C@oracle.com>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <20240729084715.1736839-2-yangerkun@huawei.com>
 <ZqekPERYzP93HacM@infradead.org>
In-Reply-To: <ZqekPERYzP93HacM@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4255:EE_
x-ms-office365-filtering-correlation-id: 8ddda405-42a1-40bd-a9ab-08dcafd9be44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZktQTDJRZ2h6eEVRQ1VURXlsaEM3YTN3VDJsREErME41MVRPWitaMW5KTldx?=
 =?utf-8?B?bzRVQjRsM1hrckJzQ1N6Y0ZxSmd0dHI5MGwvRk1UazR4SUx5TGVWdVZlOUtQ?=
 =?utf-8?B?RG1SeHpUb2JnOUdNZXRWZlJYV3hDR3VNR0hBakxRWkVGcW5jNjN3WWRSaUFS?=
 =?utf-8?B?QmZURzgyN3poY3Q5cXRNRkhhaHFJWG94alVrOGhWY2xFYXlOWS9YazhEbFFZ?=
 =?utf-8?B?L0FLNEU5UmxNMzZQbFdYN1Brd29Ob0J6VDJMcWU2eFVhbHB1dkZKaGRzeGp1?=
 =?utf-8?B?TFZ0MXpDQnp3MnJoYzhlNEE2VWNiRFdGTHJOc0JwM1JLQkZDMEsxTTRMaG1k?=
 =?utf-8?B?a2lzUzVGK0RkWFZ4UkRYWHByblRnT0FhbjlmZDFOMGpwTS9FVGlPdFY2RnZw?=
 =?utf-8?B?NW1sN2RSL21XVWFvMk5GOGJvRUI0S3FvWnRUd0ZYeUsxNWlJUzRpMmJQK2Vq?=
 =?utf-8?B?Ni9mbXBybk9HaVdYWDhIV3FBb3V6ZzRwT3RncHd3TDJzU0tWNVZVRkR6d1ls?=
 =?utf-8?B?dDBoWFZvNS9oQTY2bUQrTmtKc0p1d3JmdDdvMkN3eHRJdXdIK0VsK2txTTVo?=
 =?utf-8?B?aVE5Y1dOMkdDZUVaU05xelVTcFhJRTZkQnJVRGNNc0tWbmd1ck9yQm9INnd5?=
 =?utf-8?B?N2VLOGNhTDN5Z0szMFZ3OW45TVlzc051TW1DL2gwVkJQTHN3ZE1rQzVidi83?=
 =?utf-8?B?Z09WUkdFMWE2S3hCbGpXNG9vQ0NtTWJvVXR5amN1Y1U5YWN6M3ZUT2ZNQ2Vh?=
 =?utf-8?B?VExkRXRtZ2U1WW81V3RvUEh0dDIxbS9GZnFWM1ZZTWpTRXhFS21mQ0drd251?=
 =?utf-8?B?NDlGdHZ3Z0hwL2o3OW1WL0xUaGRtaFErcStROWVDTWYvcjhoYkhWdWJDSG1T?=
 =?utf-8?B?R2RkczVOSWdlUEJTUWphMncyMnZKZW5MY2FIZW9mbm5xU2ZrOG5OQ3NROGI0?=
 =?utf-8?B?VkU2ZUoxdDk2NnpQbVR1MnE1Q3hSK0dhSmkzL2tab0pldVIwQVU3bFNBZDV2?=
 =?utf-8?B?cnplbjhEMVVpSnNGRWkrampDYVZHZ1NKZjVxRGlvU1FCQ3l4SkE3UUFxYlQ3?=
 =?utf-8?B?aE84aFplQ2UxMTAranB1bmJPTzVCQkR1Y2NwK0Z3R0s0TlRhTjdWZVFad3ZO?=
 =?utf-8?B?SHZSL0FobVkxSHRjYUNnS1MzajIxUHRVRjZ1UmdSdUJJVjZhT0hZTmZmUi80?=
 =?utf-8?B?eUkwSHMzdmVYVkMxa2doRE5BeGNRVGdNLzl4WVYyWU1hcWpZSkJLeitQWXBY?=
 =?utf-8?B?RkJzWWx4ZG9rQVVoRi9pRlB2MjJ0VUNOdXNTUnJUQjV3TVBBdndaekozYjlw?=
 =?utf-8?B?d2JmUGNFdmNvcmxncVZJRFBiajRXaVBGTjZUcWlYekh1dUNLa1JCRUFEUmll?=
 =?utf-8?B?WXh2eElKSXc1cmNlNlZzejc4WnRMVVNzZDR2Q1hiYWRnUmM2TFA2dExLTjdt?=
 =?utf-8?B?OG1VOE1tdlRTQWlkTlp6UDBiWC91NUtTKzBJWk9zeGxIZDBoVkFSYlVxQWlX?=
 =?utf-8?B?cjlyWXFEazNBeXlZd1c3c3owK3d3aDdIRXVqVkxRbXFiZmdHaSsvTnBGL1Jn?=
 =?utf-8?B?Z0czMlJ3Y0FlWDMveUpDYjduSkJER29YL2prZ282MnViTThsTDVkQ2ExbVlk?=
 =?utf-8?B?T1VvTnh2aU1TR2tKVTVGWWorYVdSdFpGWGNRVTJDUzlMbXVESlJZT0t6OWVM?=
 =?utf-8?B?STZudTVUN1ZZODdKZEhaQWYvYXVvdWlPbk5WWHI3UFBaY0RJbUozdFEzUjl4?=
 =?utf-8?B?OW80ekgzYTNPMFRiWWM4WWhadE5jT0pTRGh4a3hzN3ZyMHhOYUU4Zk0wQ0Qr?=
 =?utf-8?B?Q0pEL1ZIOXdCanJ6eXB4Q2plQTJJaCt0RkJQTHJLbTc2bXJ3S0Z0Z01Pc2tv?=
 =?utf-8?B?cHNWc0xqc2dKT2REVWRrUHVYTy9iQU92a0NHUm5YZGMrY3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFVmdjNoK1k3NWVtblVyUHdtS0o3a0xBR0tYUTlUQWxMejdjRlhlRXhBdEZw?=
 =?utf-8?B?VERCcnBGcVR5M2Nidm1OVFBrWEI5aXBnQWNrV3lza0xMVEZXQzJ6ZEZ4cHY5?=
 =?utf-8?B?cW8zbElORXRLOVlkMXFzT1IxOHhjQVRXdGhQa3FyY1V0RDcvMmxYZUkrdDF2?=
 =?utf-8?B?RnEyeE1qM04wbkh5VHJRM0JpeDUxQm9zZG9NNDdJOTBicTlhU2VwdVlGd0tv?=
 =?utf-8?B?RlJieWVSUWE3YU5sZ3N1U0JlZkRDOEN5N2NmbEtRUHdEcXJRLzhtNzJpdnhz?=
 =?utf-8?B?TmpEMEtRT2tyLzhIbFZRS0JNYXlIT0dndnM3aktzRHZoeXh0SkxIU2t2UDdm?=
 =?utf-8?B?RE1mUnpaZ05vdkhCR2xlWEhYaXRaaS84K3UzelZGTHl6a0RtVnNtK1o1T0RM?=
 =?utf-8?B?RWxkdFZrS3I5Q1g3WWpMbURYZERWYlZWSHdLZjFpdEFicmJSNFRLOEJ2ejF1?=
 =?utf-8?B?WGJWRlkzNC8rckhjUTd4dTh2SzhWcklFOG1FMEZwMWZHVDNPUVgyQ2l2aDhK?=
 =?utf-8?B?VHJtM3NlR2g0dnRqUDA5c1hweU9LUHBkZENmZU54QkFqQTdHLytlbXBFVHh1?=
 =?utf-8?B?R0J0TTdZQkw0bis2dy9PcnZudFlWV1VnNnJSZWh1NmE2MTZwNmtBS1FFeStX?=
 =?utf-8?B?a052VEp2WXl6RUE3OFRFR21IdU9lOXYvM0xKN2VzbmZRTnJ0VytVWllMd0lJ?=
 =?utf-8?B?QWZDdXpRcERuNDlXYWw3VkF5QTRvY20xa0JFdks3Q25EMktUTW5YQU9QZDR3?=
 =?utf-8?B?NWgwdWQwY3l3NnZocEdBU0F0MitpS012ejJ4NjBzNUtsclFMelpnK2dxVGxP?=
 =?utf-8?B?Q0tMdmh6U3JoV2Q5dGp3OUY3Z1o4QWVQZUpOYjY3dkZvTkVVYmlnRlJ5UDZv?=
 =?utf-8?B?bUUraWkySlNIL3p5QWdCL2htNEl6d2loQitCT1BUT2dOK0NZVTRzYkZ5SHBr?=
 =?utf-8?B?S0NpdmtaUXFPVU5nRVE5bzZ1UTY5cE1QQnVPdHV1ejVOSHhSRm5tMFZZNzFa?=
 =?utf-8?B?MTF3WExsSXBkNmNUdkZKOWd5L2NBVzE4OVoxaEJmNGdUTzVZQ3lJcUd0SWps?=
 =?utf-8?B?VW5UcTZ3YWd0RmRZTkJWeFNSRjJVS1AzSm5rOGJJWEY5TWNmVDRYd2hKQTFa?=
 =?utf-8?B?NzdYcUE1RG5zTitEdWN4ODNIQUlzOFREaW5GOVkwM3ZpU3VDTktzcSt2TU03?=
 =?utf-8?B?VDY4TzVGSEM3bGJtcXd2MVM1UW9uMlhTbmtvUnNjZlpUajFNQVhSYmx1WFNl?=
 =?utf-8?B?YjhMc25zYnBKVmxkVFArQVEvU2lJeUdOTWRzdlMrbDk4cHV3UkRQdTlCOWZk?=
 =?utf-8?B?dVpXZzczMFZwZmk1cWpENklmeHpYdDQyVnBkN2hnaGlGakNYU2s0NnNUL0w2?=
 =?utf-8?B?SFB3UVFGQmZVYVBtRkhJUWg3cFVKYmVuVm1icHZGd3N1VWlSSHZBZXVOdjlK?=
 =?utf-8?B?WTNEL1A3ZUhDZDRBM2tLVzRWbEN5Z1NyVWZlcGRtUStMWVl4MUhpUVBKTERi?=
 =?utf-8?B?WXI0SFhhU3lxbHgvcmhUWXlnRHhDS2dWczYvRjU4SlhsSk9WTmgzYjhTMmFu?=
 =?utf-8?B?MXo2UWhyczl3NXhCcXdFUFZBRER6S2NveWhtbW41ZkZOSmlLUlVrSDBzWjN4?=
 =?utf-8?B?bTVoeEJhTUdlNExTQitIK21YVnV6NFNwbldFd3BrdHZnTnFhS1VOMHVpY1ZH?=
 =?utf-8?B?QXQ1dFBYR0s4Z0t4dy9nSXYvN0tGQkFCL2t2TWJndjhYZ1ZQbjNyc2QxT004?=
 =?utf-8?B?U1pTM0hKeDVwSjJwWWg5bFo0UWdwVmRxak1aZ0FPQWh0NEo1SDd0MzRyMXRp?=
 =?utf-8?B?ekdUMHFZZ01zbmpWK3dDK25yYmRvcDJjM3dCZmkyNFp1N3drY3lBNjNTSklY?=
 =?utf-8?B?QndCOVQzUW5pQ3lXNWxIVmJnOWpQK2g3Rm5TRk5FaHhVUHBQNHlUUDFkd1Q4?=
 =?utf-8?B?T2lrNmdIa1pSLzVSa3MvanNVMkd1NmM3MjI0MnpudUJQYnlLdHN0bk9oUmRy?=
 =?utf-8?B?WkJySXFTakdPVko5ZmM2NHZlUE1vQXROZlNtMXR4MTBlNmpVVVZmM0xCUkVG?=
 =?utf-8?B?VE1hNW1RZ2s0SHhmNTdmdnNUQUlNZit0VVN5cVRMUWpkUjVQakpvWjljZ0VU?=
 =?utf-8?B?Z1JyTENrQUVrRk92YmNXT0h1Sldqd29VSG56ZG1hN3Y1RVBENmR1YUZSS2FS?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C454CA995AF5944971BDEFAEF6B264A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1MF/DIQh1V1/NBELjZ4h77kVFW0SwY6tUZbjwplzuOftTfzfcnbhd+uy2VeG2WlzXtyxfhOawb2eeMvJ5CgT4mkyA2rTcJnCYAZyGzAa5Rx0DgI411Ij98BFFNR7Ok1z7lDKO32xKYgyEA9D1V7HCziGTvYBPP5icI+UXwlLazBmSuEaBTlPtFNGNCCtgtelrMA0gSTb948Y/wOc4v0cmuMl4+UmDsH7Gqe+WGljM/pfmo14r/ubQ2nqT0Ovdk2OxezYjMxr23IhF1baxg83Kbh/MqMXltYuSCKUAZ7zaYONkOn+mEfqlGlQcO+3qrzZ5KudH/0eGqqrzJn22aY+uxIs+UofzoCrJEzSTprSM1Y0diw3kdpi601dS++57i/RC3T6KqEGDOiTkuRyn1/lfia0LNNJbyCScFWB1GQl9rWvjNMAY4r8KFGKvxBZiMwvXcoTKmPhQ+QXScxDMmoCIHMiYS+NcKcufOBRm7XdNqRwU5IotBEp8SRPHKiJ06UbPEy3Epj6ysFYoNuNZRyUvF+LveZOG8W6UjqIabnGrTDX4pz/woa10uAttg+0XnBN0ilRbZqCi9syLP/vg/qXN2Ol+hv0SkCkIytShRsllaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddda405-42a1-40bd-a9ab-08dcafd9be44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 14:21:31.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8KZbSr4OiFHIoDkACsoERQB5ct8agfPCZlinBwqcUB1gSSgFG6UuzvdsugGY+NQQze95RwIa3eHWA0TJiUyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=915
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290096
X-Proofpoint-GUID: _6fbxgExpSfErsMtjxWOlptd3syoWj7I
X-Proofpoint-ORIG-GUID: _6fbxgExpSfErsMtjxWOlptd3syoWj7I

DQoNCj4gT24gSnVsIDI5LCAyMDI0LCBhdCAxMDoxNuKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gTG9va3MgZ29vZDoNCj4gDQo+IFJldmll
d2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQoNCkkgd291bGQgcHJl
ZmVyIHRoaXMgdGVzdCBjb250aW51ZSB0byBydW4gb24gdG1wZnMuDQoNCnRtcGZzIGlzIGJyb2tl
biwgYW5kIG5lZWRzIHRvIGJlIGZpeGVkLiBJZiB0aGUgZ2VuZXJpYy83MzINCmZhaWx1cmUgaXMg
YW4gaXNzdWUsIHRoZW4gYWRkIGl0IHRvIHRoZSBleHB1bmdlIGxpc3QgLS0NCml0IGZvdW5kIGEg
cmVhbCBidWcsIHRoYXQsIG9uY2UgZml4ZWQsIHdlIGRvbid0IHdhbnQgdG8NCnJlYXBwZWFyLg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
