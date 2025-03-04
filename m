Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B011754B
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052333; cv=fail; b=r1Hwqbn0Zt/6wU/7okBMtcVQ976a6Owy2tmNwvXL9C1c05K8MtfRt1xHrvmLXq8uXY3X9HxMZUz6TgBE8pFuQ9AyubxidTm2X6ZdVttEe69hDzM1bz9Ug3S6MUHm3VrzgfBjk5bsbNF27HvOzrJ8v7ZGvgQq6dPkVxz4bYqw300=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052333; c=relaxed/simple;
	bh=IaoDpBXcTAAoECjMNdR44GhKbfmqnEPGN3oolfpmhcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvTm/3k7NP9LiXd9MiHs9xOdD/fcmN0+G/gWZGE8tMO0Ol1Z++hJW2LVcar9v2ntw5JbukQ6TlcrhZ9USb+tY2c9jzVYbuiSplcKTPkKq8mLqoS3BxmQUEoTQhbL2MSddKa3b3Gq1QrDIHSLdq5ZIm2izfPeM02ohz+jQEg9PpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZC50GNjF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fzZZcKNR; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZC50GNjF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fzZZcKNR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741052332; x=1772588332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IaoDpBXcTAAoECjMNdR44GhKbfmqnEPGN3oolfpmhcw=;
  b=ZC50GNjFPEbbPnn2k4hSVtu5Caz3yaBpBW7TJjWM6Cj6ZxDLewKPs1ti
   CS8eila/e5b6fQFmYb085AIozxPlzCoUAweDM4IYj5SqwG1w8q5lG1K2X
   23FgUSEFnIg8z63jeayxmd3l29ToNGZezO8HKvvfE8zntNgYhtyNqoYN8
   xZFDabivoktH1Zptz+e0ydO9lTC8rDJVRWbnr7AJ3OnHIDl13/cA+I27K
   fFzhZdMiXjl/eXCFIsEqdCnBsse1AyWVCCJ1SiM+yVfGAzWafNp6816xw
   FQAcwVTe/3/Tv9845kooczblUGgQDit3JPZO0/H6sFyonGq+vzr4Zz4SS
   A==;
X-CSE-ConnectionGUID: Zwvv0BqrT827ng7U4nd7Qg==
X-CSE-MsgGUID: P+Rf8v/fSqaTUp+HSTsoVw==
X-IronPort-AV: E=Sophos;i="6.13,331,1732550400"; 
   d="scan'208";a="40847897"
Received: from mail-northcentralusazlp17013063.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.63])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2025 09:38:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWTC8hT0kndtHld1NdbsaG1mw0pxIy+HcMu6zVC09JlSlQOLfMRODTh7TjR3eNIYMX+Fynwj5hCfnIwhmS8Fpj8nlkbAvtXrfq6OMAz8EO/qOaASMJ5ZaNZaH6UgplWXdWqVsBivcRWXfPjwJFO5qqk16onaV4ne8vLo+/RhsmZIfDKDn0k5ADJv4t0Xxk1+/FZ+1g0a4HsLb36bIMuhlkO8Xhr62tlyeWbluWLiifDzelahaQWcgI/YBRnInP0a4p4AAm/aOQHABL0eS2Rz5s3Q4bbVf49YcFmWILmXZchCE2ZpzWuOvW09P2FrQ/kB2PZQTKrwOnIw9Htq56LD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaoDpBXcTAAoECjMNdR44GhKbfmqnEPGN3oolfpmhcw=;
 b=iQ2reC6bhe8+qUBiTso3BSvXI+BM+nQlnASBhvkW6zE0oHdkpIGh3LtljKgFlS5wST7keIWZV+utUnFpQgnjHlxz6TaGOZvg7O0NhJXZSTpi6+4YwErgAwcrS/zucAKF4Rz58Xtf+58uyRipUl9OKXpB3birk1NivQLeEP6kKcE6blXrS6hPkiehh8Jv/jugkyTEYXM1pFHMgm4NQFMfsuCuWe4hvcXK8FaOKgI2YNXXLxljg9zEkZzq/n1EkitOd1O89Q2BAN9QkpEWDaSaFoswsNtvrntEDrE1IoHM4mdEhVGuuBDPYn7ljYU46ThY2bZk1B21ClChWPGhqJIVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaoDpBXcTAAoECjMNdR44GhKbfmqnEPGN3oolfpmhcw=;
 b=fzZZcKNRoRMw4U7XvZjBcX4AD0hWrDHuHHN4O1AqVH1msdvEc5RTYAtCzLMQKjd3pbXIdDgckYXhcNcR4e1oJ3d/VrIUBdLMX9tbwiNJnz4oAlqvUX2uOI6Dqjm5Uf4Xi3dg8nuDoLq0syZSevA+WzwUayGgl1cNnAgZqrN5cG8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS1PR04MB9276.namprd04.prod.outlook.com (2603:10b6:8:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 01:38:48 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:38:48 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Zorro Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "djwong@kernel.org"
	<djwong@kernel.org>
Subject: Re: [PATCH] tools/run_privatens: check if it is mount point for
 --make-private
Thread-Topic: [PATCH] tools/run_privatens: check if it is mount point for
 --make-private
Thread-Index: AQHbjAdrkUuRQvdVQ0qX3IxPoi1YNrNhMQGAgAA3gQCAAMvHgA==
Date: Tue, 4 Mar 2025 01:38:48 +0000
Message-ID: <D873JHORR7IB.2VEFHOF3HQMMY@wdc.com>
References: <20250303064209.602577-1-naohiro.aota@wdc.com>
 <20250303101047.qjugaez6c7ythpd6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <D86O11SKYP75.1NJE84UIKCEYD@wdc.com>
In-Reply-To: <D86O11SKYP75.1NJE84UIKCEYD@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS1PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: f1c13804-4352-4143-710b-08dd5abd4f95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXdIUytHVWJrazdrcjhQYVcrbkwwTHBNOUE5RG9lYWhJMElDTE82MCtMTEtC?=
 =?utf-8?B?UDVwU2F2ZzdrSUJ3STQwWnpoVnZkVHRUbW4xZ25RL0daRXFDbDZTaHFyNnV0?=
 =?utf-8?B?MVZpd0xnQldLcXh5dzhreWR5ODdVenJMNzZSeEFJSjN6LzFjV0toVm5rVUx6?=
 =?utf-8?B?VWxKbWNGYkRWbHNJaEpJK1R0MmkveG5DQU9MZkk1T0tEbGVKVGFCREt2bEpm?=
 =?utf-8?B?MlJZQmg2NFFoVVFXL3pRWHFLM3F2bUpnWW5jaXBhL3pwL0puL1IvQWNiREdU?=
 =?utf-8?B?WjdES0drcUxYOGQ5U3lSY01wWll5dXZmZWo3Zm1IdUJRTEpEVHFRYWtNcWhK?=
 =?utf-8?B?dWh5b2UrSWMwVWgrSFprUkd5UDdWT3dqdmJ4NlhZaGxFcllPM0ZabUQ0eFJJ?=
 =?utf-8?B?QVQvUCs5Y2xGUGpDZHdQMnZvUlFMZkt2VDVJdWtOblJxc2V6TnQydDY3VnQw?=
 =?utf-8?B?NG5kTVhrckUxUUNIVjBTU09jRmMrdDVLMGRvOTRGck1CanFFYmYwdDNUQmxF?=
 =?utf-8?B?K20rRWJwVlJNajJ4OVpoUy9PVkR3a3FtL1JtOENMaXBaMGc5Zk1tY20zUlUw?=
 =?utf-8?B?T1VRZ0NadVZ5OWhxTVZMZndaU2FSOVZMQmdlQ0dpVnpxTVNlZUNLVDlOcEYx?=
 =?utf-8?B?aXRlWWJ0ZlN2T1Y1MFNHblBWT29YZUlEeEdubjFhZUJEUlZWUnc5TEVNY1ZT?=
 =?utf-8?B?VGFEdnl6dGt1Wm11dENQZ1JKR0lxL0hYT0FZSGRkemdaWjZpa1JIaWhCUDVP?=
 =?utf-8?B?empwQUFXYS91eDhKTWNKbUh1TUwyelhSS3dpY1BHZm5oVG5XVEIvc1BacEc0?=
 =?utf-8?B?ZHdiYjAySFVzcGZtZFlud0hqWGxGTzc2L3ByMjdkMlQrckRRZ1V3c0EwbVMv?=
 =?utf-8?B?UDBQODdjdjFnM2k0NWltRmI5VS94ZjFKaTNVaTV3U0x5QWtaNE9rSy9FbmlS?=
 =?utf-8?B?cENramZ2aExWNnJJc2dHa0x2eW1RRlo3TnN0blh2RHJBVXlKK21RWjNsdzd3?=
 =?utf-8?B?a2UyY0F6NS9KZGx2WkpoYnpOdTJJWlhYNmNhekxVQnZ2MUhMY3lPcE5SWVFi?=
 =?utf-8?B?aFZRV1BkTlVudEtIc21JV2FRL2Y3OUw1TzJ3ZSthQnRZMmxIVzd6TEY5cGxi?=
 =?utf-8?B?dXlHaElJNWUxcXVQNzNiTjlBUXh3THIyMWFENTBMRittZ1pIcS96bUI1Ukh3?=
 =?utf-8?B?UWxBVTJGWiszN05URm9UTU1VN2c5UzBhOE50YVZsNFowSGJpZWZqVmFiSGRS?=
 =?utf-8?B?V0k2bENmY3NUWW5wMFNrUVNiaDJ5bDBBQzNkc0k1cjdRbmswOVlIeGtoUHdx?=
 =?utf-8?B?SmMxRnpoL1VnWndFbDM1S3VxZVlxT3FHaDYzSTFqUWg0UThtdi9FTE5QTyt3?=
 =?utf-8?B?MDlDdGhMT01GMEpoV0RoUk9CZHMyS0hTa1kzeUFyWUIzSlgwWHBIZ0lmLzVM?=
 =?utf-8?B?c1NLOXAzNjMyN2NrRHplNjRIemdzVk1QYmRsV3Y3a25BQUdqVUtLNlBURm9R?=
 =?utf-8?B?dW5LemtYSjNVWEtmUUdkNGJzb1g5TDl1UEEwTlkrRHJhd3UrTXNUNUVhbU5v?=
 =?utf-8?B?QmJ2WjdLYU9sU2k5ZzFncXcvYXlpQXdxb3YvNUtiVTQxcE53NmlJc0d1OUh4?=
 =?utf-8?B?L2dsUHNLcnVqT3lRNUl3U2NyODZpWGpGbGdTSzZnd0hnTGZFWUJBelUzaWxL?=
 =?utf-8?B?SkJPaCtwUzVVRGdIazE4ai85NTFjZlRlMTgxVkdkaThXKzA5TmxScEJPM1ly?=
 =?utf-8?B?eXlmWjQyQnVaai8wQ09jVlRrU2VXd29SdnlkVnhnUXJYSEloNnMwSlNyOWt2?=
 =?utf-8?B?djFlWC9zLy85bWpySWYyQmhiVEZ3RlE0ZVBnMi9qcERhWWpneUJYVkNhcHhS?=
 =?utf-8?B?ZkZWZHYyUlVPUFVITVNtYUJpTXErY2lEU3h1bmp6YktUVWQ2NkFkaExWN1NU?=
 =?utf-8?Q?Ln/J3WalZoMSZPrGN4w8hLq2nfJL4L+b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWRyQ014Mms5eFpMV21Vd3NNRCtZK2ZlcUwzNHRDczRiMXlBT2F1RllpOStr?=
 =?utf-8?B?NWk0cVFIS0dnNnVPKzF2UFRSS3dwREp1VmhzcEdGQmxZZUJKNjRheFg2aUtz?=
 =?utf-8?B?S1ZuNU5jZUVxdUF1TkpxL3JUYm1IcGZNaURqRDlpMGpMM25ib1VBYmtydlZz?=
 =?utf-8?B?Um42WHdLMnFwM3Z1K05WbnpHWlVleWFZVTZ4b3VwVlZNbitZZzc5ODJOaUg1?=
 =?utf-8?B?ekw5c2Q5citMY1hzT0JWNk9vc09lcldBZTZmTlI3QXN6UFA5VDl2OW9McG90?=
 =?utf-8?B?elhXc2FMUllpdTlZTURza3hjOEttOEs3bVZjMkFNcktmUVhENWpXNVV1NklP?=
 =?utf-8?B?RUpzdnlYY2V6clVXeUsxeHVuSk9DN3RrbExYRk4xOElLMit4Qks2TWsySUwz?=
 =?utf-8?B?UThrTnBLaWVoZkhlc29VeGJsUTNVMlFsL3hDSjhQWmlpKytXZlBScjVEcEdJ?=
 =?utf-8?B?NjJvQTgzTGpmMGt4bHBlTWdISXhncDRZeExzQ1pKdklMVnROT3Y1UnpWak9k?=
 =?utf-8?B?aXl6S3NaaExzbjNyS1R6NnliZGppN2prMjF2TERzbGJTY2k5VFNGUzBvM0tI?=
 =?utf-8?B?b2tKSnErK3AzeElaYk9PZm5KSk9hUEFmM0gvdGdsdHJ3ejlwY1VYeHdCUUd1?=
 =?utf-8?B?UnFDOHhpNG5jUVFIUzBrbFBWZS9LeXdDNFpTS2hRL0QvTHU0RHlnRTVEajdl?=
 =?utf-8?B?MlVPT1JQRC9BL1NydW13SVkwRGkyWUM3TmJXbkZFeDZxNGVRSk1mdG5zQ2k5?=
 =?utf-8?B?UmRFZ3I2cm56Z1p4NVl3ODJ1bUZJZ1RaYldtNk9YalJIZmRnc05FalNFTVI5?=
 =?utf-8?B?bzRUdGZpeWVFeVJObFBOTTBjbEliUGtLL1R0UHZUaTlSdWYxZithU2tUU3A4?=
 =?utf-8?B?Zm9RS1pFV1NvazJDVDd2bDBQNGlPN0RCVUljcUY2S2JoNTdpaENjM3gxTDdq?=
 =?utf-8?B?cVJaZWhZYWlnb0lZci9INng1QWpFUWxpbUthWU83QW55SENZSkJCVjd2MmJF?=
 =?utf-8?B?VlJBOGtyY1hkbUl3ZTJGWkkveVRtbnd2YkJkaEpVTTBzYW5HRXFFcm1XRHQ1?=
 =?utf-8?B?N1ZvQnhRTFZRT1ptdmZRd0FxY3VMdUVWcDhhS2d6TFhIMU8rNmR3Z3V1MEZ4?=
 =?utf-8?B?S0pXK2ZQVlh2azhqeDlHYVliL0JvMUdGdWVFd29ycG9WZWhQeFQxY1kvV2Vh?=
 =?utf-8?B?eVBvTkNudWI0QktPY2orQ1grQzh2dDVVYlFYb3hXZTJ0emd0TXNFcFEwaGR3?=
 =?utf-8?B?SzYxTFl2R0dhMmZCL3VZWDFKNTNaWlRZaDY3Ym93c3RkN2dZMCtxbURkQ2lK?=
 =?utf-8?B?a2FuakFrOFdqcHUvN25nVXJBbk5Hdi8rRzlna1BlQ2hhU3RNd2dNb2V0N2M3?=
 =?utf-8?B?SEI4ZVp6b2FYZldON3BvWS8ybkl4UXRWT2ZGeTZaSlN3d3RPT00rQmdnRTda?=
 =?utf-8?B?OGFkb0JtblM2YmVsTk9ZY1gyM2hQK29QMFZ4dUhvRjdPZXBTaE5KNUgySkFm?=
 =?utf-8?B?dkE5Y0M4bmxrbTIzTGRFSTlFZHVqR2NjUTBXUkpOTEVWUE4vdmc1aWRXOWlD?=
 =?utf-8?B?WjRIZWJRWVpUWG00VW94TlpoSGZnSnpnVkxxd0MxWUlHaTZnRit3YnoyemJP?=
 =?utf-8?B?dEJXWkVnWUREZm1NaHhTckVGSFJFWlpTSGYxclpBQnJUUUZjQVpqaFh0czc4?=
 =?utf-8?B?OFdPbGVIdWpZNmorNDRiQXIyVGNVWjRhNmI3V0U3L1RDdURPMzg3bmV2WEho?=
 =?utf-8?B?dnhJMDRWSWlJMEorSlZLMCs1S1VyTWNMYjhybFpNTHIybktkSHlScTMrVFNl?=
 =?utf-8?B?LzBmMmNQVHJJNEk0UmFVbER4b2EvT0Nxa0lGTzVudzgrSk12SFo1LzBkb3d1?=
 =?utf-8?B?Q2psUU5WUHZoSFQ4QjBQQjljS3hPWFBiRlpRZ3YxNTJWLzI0VmN3YVJzNFVT?=
 =?utf-8?B?eGtVY2NpcW95MjBPazR3UVhGd2ZuTElrNUwyWXVJSFRTVjlzZkVLQk5kUVZC?=
 =?utf-8?B?V0FsUkNsdk5VZW1TaUg0VmwrSFRTYXNxdngvaXRkNnplc00vS2dTWEhlMjZG?=
 =?utf-8?B?R3VKMXF6cE9FQjk0ZWNMU3VlVlNHcTJHakxMS0ZWNmh3YURHeCtMYnB2bFFj?=
 =?utf-8?B?Wko0YlY0U0MwU1JaSWJpbFlvSWw5eVdEcURpWVhTSzhJYUFZZzhhK2lQWmVT?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F5DDB7834DB4C4F8EDDB75E8759F24F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cUCFKs9J4LLc9f8JKVZR2j/VSsDHiff+zb9RXV0TX1FuznP/IPBcPJoHWhpR84dYcdOatUzCsxXtx9+5vXw0vnsZnXi9j6NRNb6gKh3B1NGbxraFFt6JFP6SFYY3vfsKSZqPxVWUzQ2VCgoCygU0gW3do0GWCKYeenocfqog/gN93zJWUaqjaJKr3t4Z8DBtgU6UdN0vdJKNJRIMPqjhAzBItOPuMsS5KcKtrow9lCMwyZf6ieTBTxBBY42WzKRLk7GXF/Pidyngh/kBd2hy49XM3mxK8Xo5DeIQDbS80eeT4uOccgDrGWT+B02E+WaT2FpIfU1FOh/6hgscdPF/8X+1PwISiyJ2oFcW3XqVFAgS/uSXHbCxdMwZM4OqZLyLgR4546TFZ7Dsh7xR53SU0OrHy+SRZ7I+SoXrZHhgzLAsIuq4ZqpE/vbiLhBAyIeBCeFszkMc03B07A0rInYcf2ATGONRMknYv+m33fRuGA1obvFjBNHoOekXKDArfeg6aCwReE2l8VrAoxzr/LRKIqIz05u005FeFXJo5dYfMWW8TM9/jq2Bh/Vl0DnjJPY1DVDn7/T5Y4HCj0IjU6kFBXfwcjTzHjUACIjG+Jq2OWklkYRCScx68fC9A//SlHbI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c13804-4352-4143-710b-08dd5abd4f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 01:38:48.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FM+mVzNdpsknEpmLZWzvaPo55/nIr0VDzCAS4vy+/gi0N/NVRruugFIJUSVilnT7MR/N6G11nwcBXy9/FAIXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9276

T24gTW9uIE1hciAzLCAyMDI1IGF0IDEwOjI5IFBNIEpTVCwgTmFvaGlybyBBb3RhIHdyb3RlOg0K
PiBPbiBNb24gTWFyIDMsIDIwMjUgYXQgNzoxMCBQTSBKU1QsIFpvcnJvIExhbmcgd3JvdGU6DQo+
PiBPbiBNb24sIE1hciAwMywgMjAyNSBhdCAwMzo0MjowOVBNICswOTAwLCBOYW9oaXJvIEFvdGEg
d3JvdGU6DQo+Pj4gV2hpbGUgL3RtcCBpcyBtb3VudGVkIHdpdGggdG1wZnMgaW4gdGhlIG1vc3Qg
c2V0dXAsIGl0IHN0aWxsIGNhbiBiZSBhIG5vbi1tb3VudA0KPj4+IHBvaW50LiBGb3IgZXhhbXBs
ZSwgSSdtIHJ1bm5pbmcgdGhlIGZzdGVzdHMgaW4gYSBjb250YWluZXIsIHdoaWNoIGRvZXMgbm90
DQo+Pj4gbW91bnQgL3RtcCBpbnNpZGUgdGhlIGNvbnRhaW5lci4NCj4+PiANCj4+PiBSdW5uaW5n
IGFueSB0ZXN0IGNhc2Ugb24gc3VjaCBzeXN0ZW0gcmVzdWx0cyBpbiBoYXZpbmcgdGhlIGZvbGxv
d2luZyBlcnJvcg0KPj4+IHByaW50ZWQsIHdoaWNoIGxlYWRzIHRvIGFsbCB0aGUgdGVzdCBjYXNl
cyBmYWlsIGR1ZSB0byB0aGUgb3V0cHV0IGRpZmZlcmVuY2UuDQo+Pj4gDQo+Pj4gICBtb3VudDog
L3RtcDogbm90IG1vdW50IHBvaW50IG9yIGJhZCBvcHRpb24uDQo+Pj4gICAgICAgICAgZG1lc2co
MSkgbWF5IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWlsZWQgbW91bnQgc3lzdGVtIGNh
bGwuDQo+Pj4gDQo+Pj4gVGhlc2UgbGluZXMgYXJlIHByaW50ZWQgYnkgdGhlICJtb3VudCAtLW1h
a2UtcHJpdmF0ZSIgY29tbWFuZC4gU28sIGZpeCB0aGF0IGJ5DQo+Pj4gdXNpbmcgbW91bnRwb2lu
dCBjb21tYW5kIHRvIGNoZWNrIGlmIHRoZSBkaXJlY3RvcnkgaXMgYSBtb3VudCBwb2ludCBvciBu
b3QuDQo+Pj4gDQo+Pj4gRml4ZXM6IDI0N2FiMDFmYTIyNyAoImNoZWNrOiBydW4gdGVzdHMgaW4g
YSBwcml2YXRlIHBpZC9tb3VudCBuYW1lc3BhY2UiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IE5hb2hp
cm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+Pj4gLS0tDQo+Pj4gIHRvb2xzL3J1bl9w
cml2YXRlbnMgfCAyICstDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS90b29scy9ydW5fcHJpdmF0ZW5zIGIv
dG9vbHMvcnVuX3ByaXZhdGVucw0KPj4+IGluZGV4IGRmOTQ5NzRhYjMwYy4uYzUyZTAxMjhiOGY5
IDEwMDc1NQ0KPj4+IC0tLSBhL3Rvb2xzL3J1bl9wcml2YXRlbnMNCj4+PiArKysgYi90b29scy9y
dW5fcHJpdmF0ZW5zDQo+Pj4gQEAgLTgsNyArOCw3IEBADQo+Pj4gIA0KPj4+ICBpZiBbIC1uICIk
e0ZTVEVTVFNfSVNPTH0iIF07IHRoZW4NCj4+PiAgCWZvciBwYXRoIGluIC9wcm9jIC90bXA7IGRv
DQo+Pj4gLQkJbW91bnQgLS1tYWtlLXByaXZhdGUgIiRwYXRoIg0KPj4+ICsJCW1vdW50cG9pbnQg
IiRwYXRoIiA+L2Rldi9udWxsICYmIG1vdW50IC0tbWFrZS1wcml2YXRlICIkcGF0aCINCj4+DQo+
PiBPaCwgaWYgL3RtcCBpc24ndCBhIG1vdW50cG9pbnQgb24geW91ciBzeXN0ZW0sIGRvbid0IHlv
dSBuZWVkIHRvIHRoaW5rIGFib3V0IC4uLg0KPj4NCj4+PiAgCWRvbmUNCj4+PiAgCW1vdW50IC10
IHByb2MgcHJvYyAvcHJvYw0KPj4+ICAJbW91bnQgLXQgdG1wZnMgdG1wZnMgL3RtcA0KPj4gICAg
ICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+Pg0KPj4gLi4uIHRoaXMgc3RlcD8gSSB0
aGluayB0aGUgZmlyc3QgcnVuX3ByaXZhdGVucyBwcm9jZXNzIHdpbGwgcmVtYWluIGEgIm1vdW50
ZWQiDQo+PiAvdG1wIG9uIHlvdXIgc3lzdGVtLg0KPj4NCj4+IEFuZCB0aGVuIGxhdGVyIHRlc3Rz
IHdpbGwgdXNlIHRoaXMgdG1wZnMuIFRoYXQncyBuZWFybHkgZXF1YWwgdG8gIldlIGFsd2F5cw0K
Pj4gbWFrZSBzdXJlIHRoZXJlJ3MgYSB0bXBmcyBtb3VudCBvbiAvdG1wIGF0IHRoZSBiZWdpbm5p
bmcgb2YgZnN0ZXN0cyBydW5uaW5nIi4NCj4NCj4gVGhhdCBkb2VzIG5vdCBoYXBwZW4gYmVjYXVz
ZSB3ZSBhcmUgYWxyZWFkeSBpbiBhIG1vdW50IG5hbWVzcGFjZSBjcmVhdGVkDQo+IGJ5IG5zZXhl
Yy4gVGhlIG1vdW50ZWQgIi90bXAiIGlzIGxvY2FsIHRvIGVhY2ggdGVzdCwgYW5kIGVhY2ggdGVz
dA0KPiBzaG93ZWQgdGhlIGVycm9yIGFib3ZlLg0KPg0KPj4NCj4+IEJ1dCBpZiB3ZSBkb24ndCBy
dW4gdGhhdCAibW91bnQgdG1wZnMiIHN0ZXAsIEkgdGhpbmsgaXQncyBub3Qgd2hhdCB0aGlzIHNj
cmlwdA0KPj4gd2FudHMgKHRvIGlzb2xhdGUgdGhlIGRhdGEgaW4gL3RtcCkuIFJpZ2h0Pw0KPg0K
PiBJIGd1ZXNzIHdlIGNhbiBkbyB0aGVzZSBpbnN0ZWFkPw0KPg0KPiBtb3VudCAtLW1ha2UtcHJp
dmF0ZSAtdCBwcm9jIHByb2MgL3Byb2MNCj4gbW91bnQgLS1tYWtlLXByaXZhdGUgLXQgdG1wZnMg
dG1wZnMgL3RtcA0KPg0KPiBBY3R1YWxseSwgSSdtIG5vdCBxdWl0ZSBjb25maW5kZW50IHRoYXQg
d2UgcmVhbGx5IG5lZWQgIi0tbWFrZS1wcml2YXRlIg0KPiBoZXJlLiBBcyB3ZSBtb3VudCBuZXcg
aW5zdGFuY2Ugb2YgcHJvYyBhbmQgdG1wZnMgYW5kIHdlIGRvbid0IGJpbmQgdGhlbSwNCj4gSSBk
b24ndCBzZWUgbXVjaCBwb2ludCBtYWtpbmcgdGhlbSBwcml2YXRlLg0KDQpObywgSSB3YXMgd3Jv
bmcuIFdlIHN0aWxsIG5lZWQgdG8gbWFrZSB0aGVtIHByaXZhdGUsIG5vdCB0byBwcm9wYWdhdGUN
CiJtb3VudCB0bXBmcyIgb3IgIm1vdW50IHByb2MiIHRvIHRoZSBvdXRzaWRlLiBJZiBub3QsIHdl
IHdpbGwgc2VlIG5ldw0KaW5zdGFuY2Ugb2YgdG1wZnMgbW91bnRlZCBvbiAvdG1wIGluIHRoZSBQ
SUQgMSBlbnZpcm9ubWVudCwgd2hpY2gNCmJyZWFrcyBzZXZlcmFsIGFwcGxpY2F0aW9ucyA6KC4N
Cg0KU28sIGluIHRoZSBlbmQsIEkgdGhpbmsgbXkgcGF0Y2ggZGlkIGl0IGNvcnJlY3RseSwgbm8/
DQoNCj4NCj4+DQo+PiBUaGFua3MsDQo+PiBab3Jybw0KPj4NCj4+DQo+Pg0KPj4+IC0tIA0KPj4+
IDIuNDguMQ0KPj4+IA0KPj4+IA0K
