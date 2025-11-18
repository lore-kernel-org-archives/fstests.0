Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E430AAB6
	for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.26.1.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479422; cv=fail; b=QJBp5Ieg01l0ck0Tc7GQRsOlDhty5V6v0NWQcmowW0ZjlVqDGOISaMEjegvUUqC0njvSf59weddKB0ptgkqk7uEO+DUjwZSbO4TTfpCvCQ8LqsUnawVOkcTMQ6qqhhRPkoARXNjq4o0yhjhKQjAAY0w/A9MMUhzci8YvvkzhEr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479422; c=relaxed/simple;
	bh=UbXEyOtc9uO6BLgl5Lh5kuO7uD8RXrtSnlZmDoPwYGc=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1ebbI4t35MuYC9NblY9Dyoe+vyfrZY7lJFsZXAo7r9Gau5yGte0ndl25skcRonfB2KhkJUccwZ2wUhTMwHk0Td62X7AgDYDukdWHkWTan00slolg6PjR7Sqy5ntEggxFTIAAk3sA1mz44GYJmfiTiVkI/58E/8vX+kaBN+WVYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TgBAr6QI; arc=fail smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TgBAr6QI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1763479421; x=1795015421;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=UbXEyOtc9uO6BLgl5Lh5kuO7uD8RXrtSnlZmDoPwYGc=;
  b=TgBAr6QIl4drn+PGCryE6+rMPn9EeMSLcTbMJnly+V/J42XY0sHw0wve
   PMFnpR6RRdc1FUutAxRvpK3y0pA5O6cQPcYE2RWRATw32L0bJHjdOA5lh
   VghqfR22MKwXUCahO+N3EDu8bNSywJqZQMUzsOb1TxDmEUwfAmYCk9Qp9
   d24Fa2c4lQ13JKy51MPeAkWloKg0F9ca09YL0ptgHnfTz4m9UHuL5xPoi
   CWPBD9yXh+QHxB5zvGK7G3+lonnklF0AVz5CL4hWuhNt2JSwgC5Kcu/T1
   yHkxPf9DxeHSyf0YVPI9ILMnH6HBGSUThO/m2Ec7DHg5dHJqHZQiAaVBj
   g==;
X-CSE-ConnectionGUID: TzzcpP9yTGWP/OQX6tjRFg==
X-CSE-MsgGUID: IYURn/qXRAOQJNgSP+6inQ==
X-IronPort-AV: E=Sophos;i="6.19,314,1754956800"; 
   d="scan'208";a="7317826"
Subject: Re: [PATCH] fstests: Add lustre support
Thread-Topic: [PATCH] fstests: Add lustre support
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:23:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25232]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.241:2525] with esmtp (Farcaster)
 id 132ef574-06b6-479d-a923-1adec5b5e1d6; Tue, 18 Nov 2025 15:23:40 +0000 (UTC)
X-Farcaster-Flow-ID: 132ef574-06b6-479d-a923-1adec5b5e1d6
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 18 Nov 2025 15:23:40 +0000
Received: from EX19EXOUWA002.ant.amazon.com (10.250.64.216) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 18 Nov 2025 15:23:35 +0000
Received: from CY3PR08CU001.outbound.protection.outlook.com (10.250.64.238) by
 EX19EXOUWA002.ant.amazon.com (10.250.64.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29
 via Frontend Transport; Tue, 18 Nov 2025 15:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtCwxwy4PsbjV6sfPJCA2LT3WYpu1mxa8VlJ0I7FRyhU/O6HU5iMWb3eeqjTdqxugwXlwgz9SsHv2BsnBZ4Ek6pnHGjP0rCVuJ0GxcOmy2aUbQ/+E9vsEf3X/fmbosVY7eHKXELbMiQ3n5LvATiUs3w1pAl2xnJQ1zF2aN7gOA+g4cseEKv4kMPTo6N+JLDpmLiwoPHn7s1jtc+Mto9vacueqJJJ6kN8Xsg9dI3qY5sztX8E+JINaViPa918+tyjppHn0Jd1tNfNmWUGKZ/5rrdgKAtpTG698z1FCffQuJB3RelGEhONBQ69abjyQHKoOzDm++X6Xx/pmynQNpjGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbXEyOtc9uO6BLgl5Lh5kuO7uD8RXrtSnlZmDoPwYGc=;
 b=H2UnKbYhdgenHWvrh16Plr6ZIFSTN/NAOqtl3hdQllBhBHijk1pfnSYzSZm0U5nWD3DpWFIXvJC6Vt7DYZtyxJ/l4yM3bv2x3/04C/RpKk/n5XzkR1zJR/BJQY9Ab0Kjc1vjMG3PSryfPNzqo7Fgx+LXJxjplrjM4KqEzJJgsxvo4+H3FyWOZ7GoBiWPkMHTHjIlIVAiD4g52pSEa9/r95wKnr2E6GtogZtFca0Hz0w51GHzB0SmuG5T1LW8MqrnnaHVG/ROmeAKpSAXesq43gmXmxjDfJ5Ol+U3Rlbxiewjwy4pP541Xot1+RP/i1UBUNnHZynDD3FyERM/QT+YCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MW3PR18MB3673.namprd18.prod.outlook.com (2603:10b6:303:57::17)
 by BL1PPF4D94AC0DC.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d96) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 18 Nov
 2025 15:23:33 +0000
Received: from MW3PR18MB3673.namprd18.prod.outlook.com
 ([fe80::6fdf:14ef:c694:58d9]) by MW3PR18MB3673.namprd18.prod.outlook.com
 ([fe80::6fdf:14ef:c694:58d9%5]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 15:23:33 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Christoph Hellwig <hch@infradead.org>, Xiao Yang <iceyangxiao@gmail.com>
CC: "zlang@kernel.org" <zlang@kernel.org>, "zlang@redhat.com"
	<zlang@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"sihara@ddn.com" <sihara@ddn.com>
Thread-Index: AQHcWF31EuLzfjw+XECoSspG2rIdgLT4YwKA///XCQA=
Date: Tue, 18 Nov 2025 15:23:33 +0000
Message-ID: <E35FD5CE-23C0-4A3D-B563-93E19F929291@amazon.com>
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
 <aRxrgesZ948FOWTt@infradead.org>
In-Reply-To: <aRxrgesZ948FOWTt@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-11-18T14:52:52Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=96ba6088-26e8-4c3e-952f-778b60ad3163;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR18MB3673:EE_|BL1PPF4D94AC0DC:EE_
x-ms-office365-filtering-correlation-id: b22e8248-eec4-4ae5-809e-08de26b66fa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q1BrU2FaQUpDRnFXNGxkY1VoWVB4Q2NqRGRMNk9WaEgrOW53MFRPZWZQM3Fv?=
 =?utf-8?B?eG9Cdm82M1RkejcyM1NzZU1xRHorQ0NXWlFSRUFLR2U5UzVzMmpwZ3FNdGV1?=
 =?utf-8?B?SzJmVVhzYjlOdGxOaXlxRm9ZYU1iMjQzdVVUWU9kTzNUaGt1aEY1VnFsZ2Fq?=
 =?utf-8?B?cVRBUmlNTUNXY0xQQzcwK2RwZ2RjeXRUMm8rUnZFT240WlJ4UHBwWGwwckdP?=
 =?utf-8?B?aGh6MlV6L2NtaHVWenlyd3FhZkxsNVpyaUd3VjlaU2VIYWU2MlhodWp2ZFRR?=
 =?utf-8?B?MmhJbTJKODRkVFliZWFGVkgvMllrbjh6ay9zWXdBQjhqVVdXU1dVMDU0dndx?=
 =?utf-8?B?ck54Nm5tbGczc2QwaWJZYWpTaFJTdmIvYXVuckVhU1o3Ujhaek8vZGtXdHp0?=
 =?utf-8?B?TUwxd2dNK2VXNnRGQmtLb2tQaWo3STNwUlBIWm9zcHBLVE9sdFlQQ1lYc0ZC?=
 =?utf-8?B?K2s4Q2tFcmhuZGlQT2JMcTFLd2hzLzJ4S3dETXl2QUFCU2VueU9qQTRUcEdv?=
 =?utf-8?B?R2ZMbnI4b01NRllYenkvNjJVOEpQL0dER2toTUZjSVNTeDYzb0lybTJzYXNx?=
 =?utf-8?B?MFRqa0liclJ6YnFtYzlySk5CN1FmMDUvSzlsM0psRk9Da0tSZVJzMDFTVGUz?=
 =?utf-8?B?YjZlVFZ3eFk3Mnl0bWlQSmpqUlFkMGlpYkhxMDNSM0RyVE9sajg0VWRrQndw?=
 =?utf-8?B?YUJNRHltMGtuWEJEYVJVSU90ajV0d1pKR2o4dXZyY1hOd2NPWXZrTWtYK1BD?=
 =?utf-8?B?dDk1UG5NeHM3MEdvVmQ1eDB6NFg4LzNuT0hxSUR6RDJYTjhNa2d0d1pFZkZl?=
 =?utf-8?B?R0FLM3dTRDBpOVlWejJPcWxyQ0x6YnFqZllTZnZPQ2gxbEQ4R2FEeWh2MHRL?=
 =?utf-8?B?cWNZZWNxOXZxL214aEVib2NGWC9ZdS9RMHI2Z0NIN2NqMHBtdVJ2amlSZFZa?=
 =?utf-8?B?enJJMHh1NVRjbWd0MkZMYVdWTDc1VnFGbnZ4ZkxqQkJ3bnRGckxqKzFlUDFv?=
 =?utf-8?B?WnVEL3BoU3pwN3dORFRzYm5ab2kvYlk5bG1sbElxSWJ2bmo3MlJhWDY5UVYz?=
 =?utf-8?B?OFlvdTBiY2V6Rm9PMVp2YUdweGtaWkdOTFB1aE9FaElFcTZuNDRoK3dBOTVR?=
 =?utf-8?B?bUNIYm12TVhOVHRNVDhIek1JMFNWd0NhYS91RFRTUTl2NzQrVGg3c2pHWEgx?=
 =?utf-8?B?UlJtMkRZZ0NHTnNYWUl6eVJMdWxWcGlRNlVQcUZOMG8wbVhwd05PUVpKU1Fv?=
 =?utf-8?B?a2VmTnFXd0VlWnVJcGhJK29UMm9iSW1kVDhOWEpyVXRQcXpqQU13YmZoWkZH?=
 =?utf-8?B?N0xQRjhDWFZSQWdtdHNLejNWWjRpbkJDQ1ltR29GSlpXc0dsRWQrM0ZNNTdB?=
 =?utf-8?B?NFc1UHRGU3Y3WGYwN3AvRnVlZEEySExnTzVWNkNSTlhnT0xQRjBUa1MrcVFS?=
 =?utf-8?B?UnZ2dW82dHR5dmU2cVpiRzVWaENJZUJ4NkRJVHBFYVVSSUtMWEx6UnR4ZVNI?=
 =?utf-8?B?eERabTZhVXNIQ2RrN09ZSy9kUmdVKzQ4OHNJL2xWUGxRSFVKdTZVdGExbExS?=
 =?utf-8?B?Nk13UURhcmZBTUlMWlpHWGluRiswUjg5cmxjUXpVM3ZPbytxcWwybnVtTDFB?=
 =?utf-8?B?K040blhqdWhiSTJYKzd4STZvWVJNY2dMM2l4d0J0Y3RPNzVTWGZSQ214R01B?=
 =?utf-8?B?a2dGUUx0WFRkY1NiWDkxREhkUTEveXF0STZITGw0SHU1dURiaDFscXhCNkFD?=
 =?utf-8?B?Yit5ZzJ0R0FFVVJmTmp1blVhc0k5djR2OXlxOXEyM1U1ZnNuc1kyT2RPZlJR?=
 =?utf-8?B?TlhYY0lhL2M4Ymt4QndCU3pCemU2WDJobDhiN2ZsR3VDZVlVbVllcHhUZk5k?=
 =?utf-8?B?TklKOTJaN0h2b1pWWkJUQWtQNWZ2dXdrNEtLMkx6bW9mbzUvRjlUTDd1Y0Np?=
 =?utf-8?B?K01OLzZ0UFBkZTQrMDdFUlFhcUNHdTBIQzNncnBQanhqMHV0L25xM3IyRW9k?=
 =?utf-8?B?cldKcU9vMHdLdHVWcm45SmlZRHMwNUJLL25tWjVsTWFaVFVyL0xTMTVZd1ZH?=
 =?utf-8?Q?TkR1+6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR18MB3673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJRcnVBOVc3c0pYczBSUytBWHk1STRPandEVmtEMUVkc04xQWxPMHRhMzJM?=
 =?utf-8?B?SkJYNmwvSkVZY2IxQXlpVUNPNFpHNlM2MDdiZitmb0Zjb3huM214SDh5TUUr?=
 =?utf-8?B?NTBhNy9USmVKV2VlM21BdGo5dHlqQ0dQMlRmVFZkaUZmQkE1M1d3aC9DblV3?=
 =?utf-8?B?SWx0aDIxTWV6SHp6L2RONTZrcXhyMXA3TExhdFl6VmZXMXE2THpuZjZZbUlW?=
 =?utf-8?B?VDBwd01YSXpUUEpCU2padG5zVks2bTN1aFdUamRqdEdCUU16TSt6UTlRRzFJ?=
 =?utf-8?B?MFJFdTV3ZzlMQnMwTi84dlQrTE55clBkU0dkc0MzeW1GeHVzRkE0ZUZYTlNo?=
 =?utf-8?B?ZkZlWTVPOU5kWVU5cG5maVV1Rkg1WHZGOFRpMzZHOTBNYVQwWlo0NmxOYkJI?=
 =?utf-8?B?cm1WeDcwd1pKb3B3aEVlVUxudlVyU3JDUGNPaE9oMk9mcWhTNHdwd1BYNWpQ?=
 =?utf-8?B?aGFzMU5WQ0h5UzRiSStjbWpwZ2hRQndGTDFnT1FzcUVsOUpWaUJHdWFQQlA4?=
 =?utf-8?B?L1dIM01NWDRqcE1PMm5xdGM1MGJDZTFvMzd0S3BaNFlrZ3R6Um9kY25IOHdi?=
 =?utf-8?B?djQ1ODdiV2lCQzczTE5ZU2daOUZOc0diMDByeHRwb2QvbTU0UmtKVUNNdm8w?=
 =?utf-8?B?dG0xczdTZ3Bzd2VsTkFlUWhiK1hLTTRVd1V2ZTg3bitIRm13OExTRmxsWldu?=
 =?utf-8?B?OE9vR1RJRjAvdG5nTGwvZmJlTC9CczIrenZmTjNFYzU0aG8vdHFrNzM1VVFL?=
 =?utf-8?B?SWtlVXpNVG9hMjdHN1FzYXJLaktSMzdzWEE4MmpkV2ZKb0IwRjJHRFJ2b2hM?=
 =?utf-8?B?MWtSR0EzZEpOV3VRZDBJS3FOZUx4bGhuY2FabStUcnZicXdFa1hkaFdGWG5m?=
 =?utf-8?B?ZlByRlE2bEk0VmhkVFRJazdmR3pFZHE1MXc5c2pVM3k0NGxwbHg1Q2prL1JL?=
 =?utf-8?B?SkdaYm4wbTgxNEJaK2dYM0N5U2ZvSm9vby8vTmxHNGw5bWlKL2hoSDdJenly?=
 =?utf-8?B?SytTeHR5SFZ5OGprdUt1TUhlWldCUFVhOHVyRTZ0ZXJOU3RyOG5YaUJ6MFNt?=
 =?utf-8?B?a3l2WWdEaG1qZVNhMHNOdURNV1o2VS94cFpWLy9tOW1ZV2ZVVHg2bzRqZGNV?=
 =?utf-8?B?M0hNNzdYTWVINERYWGtCQVpteEJpT25paVp5RHgvZlYrNXNBdWVCVGRkdHFB?=
 =?utf-8?B?czByNXRWejl0Ti9OMkxtWTRuMWlMbXVmZ2ZjY2NrSVl4VWdxRFlUcUVYSVhp?=
 =?utf-8?B?S2cyUzk2S0JtMVJ2WERZM1hBM3MyQUZXQy9JZncxOW0zblRDWWkwaXBxMDJ2?=
 =?utf-8?B?eVJwYlNua3Bkb1c5Y1JCazVHZmZEeS92VkR3c3AyMDZGcWlDM3BDTURTU3Ur?=
 =?utf-8?B?NmRUbUhhc29UMFJmL3JFMmJub2V5OUVMZ2hFR3dGY3EvTnhvZncxUXV4aTNT?=
 =?utf-8?B?TkxmQlFBQ1ZLUGNTSVp1UDUrcVBoS3FuMHVCOHBmdXlpalYxYnNhVDNJTldE?=
 =?utf-8?B?cEQ3THR3TWpiN3VSd2RRenhudHZIditPdFhZY3NIZnM2SS9la1JBdDJDQ3Qr?=
 =?utf-8?B?SjVKMmtCdEZoTVEyOGl6RVNFbEZySUdOSGd0cDdUR2IrT0FPVWtWSyt6ODhH?=
 =?utf-8?B?US9Xa3pZVzY0cGZYQWJyajFkY2lGb3ppS2FMRHN5QlNGS0VKdWp4SVRZc2pZ?=
 =?utf-8?B?UWFsdU8wYjQrVUtBWVNpeEp3TDhVbEhDSmphYVBYSDZOZ0xadTVyNDJhUEY0?=
 =?utf-8?B?elIreDFMVlYvdEZMQkx0V3VlZWN4SVpaY1Y5dUNPN2FmRCs0cXBuRnVZcFBS?=
 =?utf-8?B?TWlEOHQvQnlMVWZyYUdKWWkvaDF4SzZDZFpJUVVTZzdReFo2UmFtVlZNTW9E?=
 =?utf-8?B?QlpJbjAyUjRBTWdXekkrTEsrcEd5cWhvVVpPZFpvN25MZVNkNW01OGVKQXFW?=
 =?utf-8?B?UGVSYW9WN2VTT2lud3FUMDBheGVCR0JObm1CZHExT3d4NDRyZ1FidVMycXBa?=
 =?utf-8?B?Ynp4R203QUFFNFY5QkZZV0s3eWNDWWUrUDZSSDVxNnVTRlFPQUswNHNic1Ir?=
 =?utf-8?B?a3JHcTFDZnUrNnlBQ29zZ2FxK2hKZXFvakdvdjdMZUZyZXhuYzJtMHZhZVFT?=
 =?utf-8?Q?xlDoz+sDybzHabUstRj6BjA0f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC755E63FE7AA40AB53B257F4F0D629@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR18MB3673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22e8248-eec4-4ae5-809e-08de26b66fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 15:23:33.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +leYscJjhL5O8/gAEosqd39pSIAsMYdFfYoa0HHMrTcVfRrMeOdxRRa6ZDVYuQlAjj8bBP+GPdBCF9mKHvJhbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF4D94AC0DC
X-OriginatorOrg: amazon.com

Pj4gQWRkIGJhc2ljIGx1c3RyZSBzdXBwb3J0IHNvIHRoYXQgd2UgY2FuIGNvbnRpbnVvdXNseQ0K
Pj4gaW1wcm92ZSBsdXN0cmUgYnkgZnN0ZXN0cy4NCj4NCj4geGZzdGVzdHMgaXMgb25seSBzdXBw
b3NlZCB0byB0ZXN0IHVwc3RyZWFtIGZpbGUgc3lzdGVtcyBhbmQgbm90DQo+IHBlcnBldHVhbCBv
dXQgb2YgdHJlZSB0aGluZ3MgbGlrZSBMdXN0cmUuIENvbW11bml0eSBpcyBhIGdpdmluZw0KPiBh
bmQgdGFraW5nLg0KDQpGb3IgYmV0dGVyIG9yIHdvcnNlLCB4ZnN0ZXN0cyBkb2VzIHN1cHBvcnQg
c29tZSBvdXQtb2YtdHJlZQ0KZmlsZXN5c3RlbXMgbGlrZSBnbHVzdGVyIGFuZCBiY2FjaGVmcyAo
Ym90aCBsaXN0ZWQgaW4gdGhlIHN1cHBvcnQNCm1hdHJpeCBpbiB0aGUgUkVBRE1FLCB3aGljaCBh
bHNvIHN1Z2dlc3RzIHRoYXQgIiBGaXJzdGx5LA0KdGhlcmUncyBub3QgaGFyZCByZXN0cmljdGlv
biBhYm91dCB3aGljaCBmaWxlc3lzdGVtIGNhbiB1c2UgZnN0ZXN0cy4NCkFueSBmaWxlc3lzdGVt
IGNhbiBnaXZlIGZzdGVzdHMgYSB0cnkiKS4gTHVzdHJlIHN1cHBvcnQgd291bGRuJ3QNCnNlZW0g
dGhhdCBvdXQgb2YgcGxhY2UsIGV2ZW4gaWYgaXQgdGFrZXMgYSB3aGlsZSBmb3IgTHVzdHJlIHRv
DQptYWtlIGl0cyB3YXkgaW4tdHJlZS4NCg0KVGltIERheQ0KDQoNCg==
