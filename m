Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332D625;
	Mon, 18 May 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128882; cv=fail; b=QATsZSG6LssFbAaYNkDPB8RhWNCl4yU/wjjaI0zk0eSqWtErxhxKKW8mJ+nC0raeXaZfKdLtyJW2ORNVTLnFUGy2AVouLu53Pz4vOy1O0NGODeTExvo+6VTAxmhjmuUL5xDapT7RUQazdpJhww0cLEB16Thll5FLWRkVLs0gB6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128882; c=relaxed/simple;
	bh=X6PCUW2DT3esymWPWNEoHGL8rRcpfnWj+iWwZkqA7BU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTsCnxeKZcT3B43pHOxeFKZ/q1kPYFQpLNjhhyONMHjUO8vdgcF4/aNvNB3YLhRhAywWCOlim+c9kKi3MMSDOxsd1FX+W+Jml8fqGx3Fz6N867joy4WknzF/gMNCzY//Y6GWGEJ5Us/e16gWCzQ+jwfZS2VOBxWA4oITWVrhKlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ri78A1fX; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ri78A1fX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I9IcvT3982023;
	Mon, 18 May 2026 18:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=X6PCUW2DT3esymWPWNEoHGL8rRcpfnWj+iWwZkqA7BU=; b=Ri78A1fX
	VaUbuZI3jZGJB8l87cqC+OWeO6a2OFIy2e6VusFeII8EByi1f5XZx8QVKUaOlk41
	YT6o6uLKMBNC9KGM+3X7mfsIZmRu+QRItuLBcEivalfRFcFhgvC2h1SXd/BDGLq5
	f3pHyVRmgPCeUrz3Sa6MKSmgTKBv0NnVTEZaTxJ3Qsl6Cm2X9TN9rNafGP4xHAUo
	eWb0cSBd7wQSfiVyE7nw5xyGdbr/D1P7zwefajug57lupmTa8sy9KRqJxdYw188C
	wHDyFVupy9LjNBYlNqqV3eblRQQOPMID7jvCii/GJm8rDLM2lSPP5ehkDSfSMU92
	9DxOSVdrsPdXYw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74sgsg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 18:27:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIcBaVtfGS8J8CVHg63jf4wghiY4dhroP/c0PhrAUpAkNwaJVpc6N5G93XKa5K9J8sfmPcfU7ZoN9NP9SFMrG2qHLgDtrD3NufSzMVQPKBapZJRzHOf55tl+kZrf5R1Urq8Jv5o6L0RMSE9tF7Z5VQVv/YAjtC+fmNSS+FJLEgrnan2k3Ty9vvR0XOupL9hft9abDOUfCG7B6oDF+2eRKMs6T8oriqvrGBCXdB6PsgHv8rllpNTqroKlR++9hfo3A9DYnLAGeuaZWAYBe00/QePngr42QDYVFcebBoe3Tpx6dupwLvr1UqrFC7nLLTMnG6WFOdZz/L/L6LjactI9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6PCUW2DT3esymWPWNEoHGL8rRcpfnWj+iWwZkqA7BU=;
 b=eJ8yPAuuXmGLdZ8Sov33tzW3uq2ziGwC+xXyQ2vv21v6UlfNTfSZUkw6nBHQxJ/iKxViLiQku9YNqf9+vbfUfe7Oh4uIt+7ML6PEjpMKFLJOM6/ETC0txRXCiR7RP1kEcujuV5H59DRqbk6tqYTRyPKOGw2JeiefuJKw8uWYE56goACGiFALr4EAviuuwojW0xKoUhVVmbgZdLpKzsiArc4MBuKdFCkzx5yGN4ynzlsKiqhXDka35DKrSM13b1sFwhvj8QpygnV9YwV1kkQhoPS2+i7Nq41vHifN5nyOxbUZd03IWYhg0S1fQRy5T+RABx/Z5MlNII8C3MFtCqszmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA5PR15MB6938.namprd15.prod.outlook.com (2603:10b6:806:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:27:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 18:27:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Zirong Lang <zlang@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfstests: disable generic/003 for HFS file system
Thread-Topic: [PATCH] xfstests: disable generic/003 for HFS file system
Thread-Index: AQHc5vQJk55SAS9LUUmwpFu3QJ3bMw==
Date: Mon, 18 May 2026 18:27:52 +0000
Message-ID: <3ed32501c3b9af0370cb749a0a7888c4c68d745a.camel@ibm.com>
References: <20260514200004.354432-2-slava@dubeyko.com>
	 <agmF-PIo1yRu9KHK@zlang-mailbox>
In-Reply-To: <agmF-PIo1yRu9KHK@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA5PR15MB6938:EE_
x-ms-office365-filtering-correlation-id: 4b64207c-621d-4cff-2dbf-08deb50b2c30
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|3023799003|38070700021|4143699003|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 wV/6yY5R2VBEbBImoPcwjVzXbLOpYNw8ul3EVwKLCuiEsVMXkuPTqsVfS5m+uLrbDCyGWxc9d5nv9jAxx+ohw7H32UakR+ssntobsRJ169Y9F9YHnG9Oe8IUpzUx2uSizlb1b+525OWKN0OQMu3Xm+5J4qzWA8DLH9QwZ0J7pfT+AEWS9FoO3FB5105Hjr3eie4JcsSNHTDlltLBp0wxsWJh0gIpf8Jr+NZMYIqtFhiODBQfySAFXa1bUnEC+ceQYoECigkw/jwa1sNqcc2zr4CejB2MQt82cKp6v4bQdJgN1RV68jZe6/wyPcL+ysWgJSawzW8vzpv3LKTT9zaENrVkdeZ5wGyR0UTCJobhXQETAlQHhOND68DRivsU81uBAeIEeN1IDV94NC3di1CsTFOm8E0dSikYV7agKYBeQl3Fx9cluidlKWM6FC6ZgIoky7fsothasXVxrr+3lHlZ4wbalVc8rKRLFRMeTOpLYjWrgGl7U3UkUTRhw4me0so+bcGxqhYrfZ8Ght7QV7RBjd7qXoKdohZH6pq3/oXe9G5xQz4Pgs2vO5FitK6g0Fo0ecwouddcCgv98I/f+5ZOsUDVk3Dm80uPnLeamva7zI6ns2bI4//UoTHEfWGhCeWKJc9yITd44owplotn0EVCksetIDS057ZNM5lqvCasr/FqoIx3zp+xwVDxkCb3scOpNC2t5jfft8fZdpauDisywRyILp3KtMfdyD2Kg1bSX6D8S3UEyV+iTebJpzKOMhQ8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(3023799003)(38070700021)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnhmdnhiVWNZRTMyanQ2S2lNOVdjKytMYUNweWNSN2RJcGhpZk8va2NtZFZM?=
 =?utf-8?B?cm13NUdrMWF1SkpLNUltUnZYY3JDZ3NKNW9Hd2g0NlZmZ0RqZ2QxM2NBOERI?=
 =?utf-8?B?c29UZW1KOEloaEEzSlROSHg1aEpJakxVWGQrL21BdUtid3gxbElrWC9scjQx?=
 =?utf-8?B?aVU0dDZMRkVvSGI4KzdjU0VmQUwxWFRRbGxid3U5ZTdwY3lkdEFwNEw5WmVp?=
 =?utf-8?B?WUlDbTNwNE9hT0FEVUhSQ2hRdit1dkVWKzBLV3drZEc1amljYjh3OThyK1pC?=
 =?utf-8?B?SEFPTUdNeXU4TmNSTkNtTzBIUDZuWHNXSmlvdWpKNGpwdFd1N0puTy92OG0y?=
 =?utf-8?B?Z3BRbW5UU2JHODNwYTQ0dkNEQmszRm9kNXYxNHloY3hKWnEwUWNEWTVwQlRw?=
 =?utf-8?B?R0J2VHV3ZnJ0S1E1QnRadGxwWVNTYXkyZjB5NThUNnNKZkZLUDMweEtnWGFY?=
 =?utf-8?B?RGt6QnJKbHFuMmc0Yk5qMWNMSkN3RklqT2FBZktFRUVPdHNuSTh0TEJBRFFt?=
 =?utf-8?B?bkZkZ0ZlSC9vY1FqSzVvWkZYcVFMMjVCTzhPUnFwVUJGMERNTitqOUlSQTB3?=
 =?utf-8?B?M1VwdHdxUVdUOVIvT21kVDZ6SUJ4UTZWNVNMMXhhT2M4ZXM3V0c1WHdyQlVE?=
 =?utf-8?B?TzJiVCtPWEZuZTNQRkRNT21mWVN3YVdBdlkxVy8rM0QvNWpVYVdPd2hCL0tk?=
 =?utf-8?B?bUtSekxhUW5VQTNpTGJBVDFHVkNkUU8vOC9Qc1BGNEpwdFBmYXV6SlVLNGU2?=
 =?utf-8?B?RjRZK1hHK1NtakZFS3c2eW9EbFNJUFF6YUVHeVhpZ001dUxrRnlNRUNBZjNV?=
 =?utf-8?B?azlEVlRGK1hpS2R4ajhRbU4rd1Rmd0I0OHQ2UEJUM0pNQ1VXeTNkeXkzMEQr?=
 =?utf-8?B?allLQlBRWmJFeWtKRTRXMm04VGJJN2d1TE5YNkNrM1l0MDRyYlZ5NHBFRk5S?=
 =?utf-8?B?anF5a0FpU1Y5bnB0SGpVdzlaMkxidkt3ZTFwR1laZUlteEpzY0xwc3BmbEJx?=
 =?utf-8?B?VmNUcTlwYXlXUFBCLzdzdGd2cTNBZzhKVU1LM0hvSWFiWWp2L1luQlhuVDlC?=
 =?utf-8?B?SGZsSUVzanZqVWZ5emtCSFZJcGw0V2ZITUIwMXNOMFd5QTR0cFVYcFNSMFNP?=
 =?utf-8?B?UU8xWUV0V2hwaU9QemJ5OXNENlZEMllvQTdIMmp5VmE5bi9xTkx6U2lveU5t?=
 =?utf-8?B?NkRkcmZmMjh6MmE2Zjg3MEpNVHRoSGV1ZU1RL0x3R1hLRTBYM3hseFBKTDk3?=
 =?utf-8?B?bC9MVGJGUFBOQWQzTGZYMzl5a1pHbDZkZEx5K20zdVZwTkR2SjhEVUVuTWN5?=
 =?utf-8?B?T0hXdUFYdEhnajJjTnB1aFYxdkNSS2pSSWRraVQzdEw4K2J6Um8wbTJVbVpq?=
 =?utf-8?B?SFFhMnVIR1RiQ2JhaGhVc1U1SWZyeVEvTjR6MFJkdndkY0pQdUFvOVVYNk55?=
 =?utf-8?B?bmlkTG5jL2NuNUVqclpNWjFyZmNXelFxT1R2Mk54QUZMZjBtRU03OCtyWW5G?=
 =?utf-8?B?VU1JeThQRk1HbnpLQVYrQkcxWmFkVXc2Tm43LzJRZjUzYXhnV255U1c4eUFv?=
 =?utf-8?B?ek5rWks0QlJqVXZMUFRLMnltVHZuTFF4VTFRUTZvUmNvUFdha0p5M3EvdWdF?=
 =?utf-8?B?ak53VnNSWjM3eFQ0STJyMS94QnMzVWJuZnAwcmtSUTVyUzBBaG1LZE5YRUZ0?=
 =?utf-8?B?OFRIcHdMQnpMN0QrOVd3U1FhVnpJdU9TZy9ITklPZ0JCTngzL3d0alNRQit4?=
 =?utf-8?B?Q2hoK0NmTXBaSzk1aHRHSythQ0pOTW1VeTVMSXZXWGlIZUFVcGtoWDVPRkta?=
 =?utf-8?B?S0JtQW40Y1ByV1lBTXVVYWt6LzdMbmhJaGJPS0pRWm1mdEtvNHhEb2RFN0lQ?=
 =?utf-8?B?NjY5NG93bFFnc1lNb0FibjFoanpTQlFaQUEwWmEydHRZYzlvcmkwaE1NN2h1?=
 =?utf-8?B?c0hoMmJkck0wRmJYSml3d3lHOW4zMHdLMWVveWJ3Uldxay83ZVphaWt4bmtj?=
 =?utf-8?B?MUYwMis2RmtrNFl2ZXczSGZHaVVWMmR1bUZYaEVwUFBJaE9BVjVGbm41bEFH?=
 =?utf-8?B?NEhBQlp5enNmNDY3UFpVWGh5SmN2ZFNwTHdCSWVKQ0RHRHVKQmtyd1pvcVVQ?=
 =?utf-8?B?OW8vOEhWMEd5a3VjOXZ1MVpaQWNyck9odU1kRU5ncWVlR0RKdWhlZ1k0RUZY?=
 =?utf-8?B?cEZLNjUvL3lsK0VFdHM3NEtGazlRZEVjT29nR0h2VUlReFRBOGdpTDFFMXN0?=
 =?utf-8?B?QnRBV0FPTEhBOVRyM2tpTDF1Z21jbVU0dG1NTW5rMFJoQURUSE8ySjZvakhi?=
 =?utf-8?B?eERtdVR3bzZuTzQwK1gyQzgzQTZFVGs1MkNqVGJYYzJDOTgzTHRKK2szVWVT?=
 =?utf-8?Q?a6d25g1MC4yAAdWcK7tIOHTwQ9WCJi7j8Ny+L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <790F3D3863736141B0735A9119EE0955@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	e2BUYJ3xi/o9lmhqAHzNt9z5bxtTDk4lddotFp8GdTFgJ63Q6HTZRI4j+XfzWCl3yDzIzGRSCfSBcvT+bZkRc6JyIKqTRDWL+D+d2McqLMT8bPnyz6Hzl/DzGXvnorRWmATNdLb2SUBG814IDK8oj8SqzUpd+2w2D9aNi9rI7LqrqJngTbs2li2a1AT6+PTqpck3DKHvYpns2lBQr9AKH6RUCuaPB1xiUYFWqnpM7aeQ/jsW3UJ6PY+INOGaUBVkZg+R3e2TquXrnjVDm4cgFKlfCqXmhjrJled8xJ+uXpl1hrGCC9tQwOHg0bGnzxd/XdA3/nPSYtMFWTk2XBpWvw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b64207c-621d-4cff-2dbf-08deb50b2c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 18:27:52.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztjll6DlmELXoAShGTm6S2rrhPS8hnUftjzQZI7jFF5JKPx7faB8FcWyZbUmp9PX3m2pCwFBUV5GjvjcjOPtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR15MB6938
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0b5a2a cx=c_pps
 a=oVQupeHHWlONJbG3R3cvFA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=wCmvBT1CAAAA:8 a=1WtWmnkvAAAA:8 a=VwQbUJbxAAAA:8
 a=DKIwIll3eWoQa92cSmAA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: WmHg8CoWJtcuHb3ygzzAojz6AaeK6m7t
X-Proofpoint-GUID: WmHg8CoWJtcuHb3ygzzAojz6AaeK6m7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3OSBTYWx0ZWRfXx8T5AP+5Dpc9
 845QEsJkngZEGWdLtWO35N6YV3x4wXwxHMp0M6k81zWdeVH0OXb0yHJamKr+ErNFVJZy6znEgsk
 EPEkFV3NokekX03CAS5tOd/ZFjD3BNF8jK3kUYd9s6Un95FDDv/ZDhXJyRgGEcPgtJEouZYzTiM
 jKMNA2IjtN1Jtcg76M3KiaWNELJ/5TuzQNj/ahlHbXMp2uzJaMdWDM/RHYdG8UPwbiAUfBBxWnC
 8fSxdc817CfLGbR5WPrlDSt3g9Vxe68JQykYnRLEVPwtsrOSI3X2dCB2kSdWuhSj/ZhY3WpbHOr
 3BOUVfLqja5IdB6Gtd7H7j1I3oz5i4+zoQYtyQfCyMuJdsYdIvZpjT3EOmmr7YoXtt8bHtxoPHl
 YGJOrccQyhpur2L7r9mpsyGc0oSrsvmHxU9TagYroIQHoeKD1gNxyaASoOG2/qrQ3QWOie+Tb50
 R+jRwJWpt9+gLgdscaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180179

T24gU3VuLCAyMDI2LTA1LTE3IGF0IDE3OjM4ICswODAwLCBab3JybyBMYW5nIHdyb3RlOg0KPiBP
biBUaHUsIE1heSAxNCwgMjAyNiBhdCAwMTowMDowNVBNIC0wNzAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gSEZTIGhhc24ndCBhbnkgZmllbGQgaW4gb24tZGlzayBsYXlvdXQgdGhh
dCBjYW4ga2VlcA0KPiA+IHRoZSBmaWxlL2ZvbGRlciBhY2Nlc3MgdGltZXMgKGF0aW1lKToNCj4g
PiANCj4gPiAvKiBUaGUgY2F0YWxvZyByZWNvcmQgZm9yIGEgZmlsZSAqLw0KPiA+IHN0cnVjdCBo
ZnNfY2F0X2ZpbGUgew0KPiA+ICAgICAgICAgczggdHlwZTsgICAgICAgICAgICAgICAgICAgICAg
ICAvKiBUaGUgdHlwZSBvZiBlbnRyeSAqLw0KPiA+ICAgICAgICAgdTggcmVzZXJ2ZWQ7DQo+ID4g
ICAgICAgICB1OCBGbGFnczsgICAgICAgICAgICAgICAgICAgICAgIC8qIEZsYWdzIHN1Y2ggYXMg
cmVhZC1vbmx5ICovDQo+ID4gICAgICAgICBzOCBUeXA7ICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIGZpbGUgdmVyc2lvbiBudW1iZXIgPSAwICovDQo+ID4gICAgICAgICBzdHJ1Y3QgaGZzX2Zp
bmZvIFVzcldkczsgICAgICAgIC8qIGRhdGEgdXNlZCBieSB0aGUgRmluZGVyICovDQo+ID4gICAg
ICAgICBfX2JlMzIgRmxOdW07ICAgICAgICAgICAgICAgICAgIC8qIFRoZSBDTklEICovDQo+ID4g
ICAgICAgICBfX2JlMTYgU3RCbGs7ICAgICAgICAgICAgICAgICAgIC8qIG9ic29sZXRlICovDQo+
ID4gICAgICAgICBfX2JlMzIgTGdMZW47ICAgICAgICAgICAgICAgICAgIC8qIFRoZSBsb2dpY2Fs
IEVPRiBvZiB0aGUgZGF0YSBmb3JrKi8NCj4gPiAgICAgICAgIF9fYmUzMiBQeUxlbjsgICAgICAg
ICAgICAgICAgICAgLyogVGhlIHBoeXNpY2FsIEVPRiBvZiB0aGUgZGF0YSBmb3JrICovDQo+ID4g
ICAgICAgICBfX2JlMTYgUlN0QmxrOyAgICAgICAgICAgICAgICAgIC8qIG9ic29sZXRlICovDQo+
ID4gICAgICAgICBfX2JlMzIgUkxnTGVuOyAgICAgICAgICAgICAgICAgIC8qIFRoZSBsb2dpY2Fs
IEVPRiBvZiB0aGUgcnNyYyBmb3JrICovDQo+ID4gICAgICAgICBfX2JlMzIgUlB5TGVuOyAgICAg
ICAgICAgICAgICAgIC8qIFRoZSBwaHlzaWNhbCBFT0Ygb2YgdGhlIHJzcmMgZm9yayAqLw0KPiA+
ICAgICAgICAgX19iZTMyIENyRGF0OyAgICAgICAgICAgICAgICAgICAvKiBUaGUgY3JlYXRpb24g
ZGF0ZSAqLw0KPiA+ICAgICAgICAgX19iZTMyIE1kRGF0OyAgICAgICAgICAgICAgICAgICAvKiBU
aGUgbW9kaWZpZWQgZGF0ZSAqLw0KPiA+ICAgICAgICAgX19iZTMyIEJrRGF0OyAgICAgICAgICAg
ICAgICAgICAvKiBUaGUgbGFzdCBiYWNrdXAgZGF0ZSAqLw0KPiA+ICAgICAgICAgc3RydWN0IGhm
c19meGluZm8gRm5kckluZm87ICAgICAvKiBtb3JlIGRhdGEgZm9yIHRoZSBGaW5kZXIgKi8NCj4g
PiAgICAgICAgIF9fYmUxNiBDbHBTaXplOyAgICAgICAgICAgICAgICAgLyogbnVtYmVyIG9mIGJ5
dGVzIHRvIGFsbG9jYXRlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHdoZW4gZXh0ZW5kaW5nIGZpbGVzICovDQo+ID4gICAgICAgICBoZnNfZXh0ZW50X3Jl
YyBFeHRSZWM7ICAgICAgICAgIC8qIGZpcnN0IGV4dGVudCByZWNvcmQNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yIHRoZSBkYXRhIGZvcmsgKi8NCj4g
PiAgICAgICAgIGhmc19leHRlbnRfcmVjIFJFeHRSZWM7ICAgICAgICAgLyogZmlyc3QgZXh0ZW50
IHJlY29yZA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBm
b3IgdGhlIHJlc291cmNlIGZvcmsgKi8NCj4gPiAgICAgICAgIHUzMiBSZXNydjsgICAgICAgICAg
ICAgICAgICAgICAgLyogcmVzZXJ2ZWQgYnkgQXBwbGUgKi8NCj4gPiB9IF9fcGFja2VkOw0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggZGlzYWJsZSB0aGUgZ2VuZXJpYy8wMDMgdGVzdC1jYXNlIGZvcg0K
PiA+IEhGUyBmaWxlIHN5c3RlbS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWFjaGVzbGF2
IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KPiA+IGNjOiBKb2huIFBhdWwgQWRyaWFuIEds
YXViaXR6IDxnbGF1Yml0ekBwaHlzaWsuZnUtYmVybGluLmRlPg0KPiA+IGNjOiBZYW5ndGFvIExp
IDxmcmFuay5saUB2aXZvLmNvbT4NCj4gPiBjYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiBjYzogZnN0ZXN0c0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiAtLS0NCj4gPiAgY29tbW9u
L3JjIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9jb21tb24vcmMgYi9jb21tb24vcmMNCj4gPiBpbmRleCA1ZmU0NGUy
MS4uYjg5N2VmMGIgMTAwNjQ0DQo+ID4gLS0tIGEvY29tbW9uL3JjDQo+ID4gKysrIGIvY29tbW9u
L3JjDQo+ID4gQEAgLTQ1NTksNiArNDU1OSw5IEBAIF9yZXF1aXJlX2F0aW1lKCkNCj4gPiAgCWNl
cGh8Y2VwaC1mdXNlKQ0KPiA+ICAJCV9ub3RydW4gImF0aW1lIG5vdCBtYWludGFpbmVkIGJ5ICRG
U1RZUCINCj4gPiAgCQk7Ow0KPiA+ICsJaGZzKQ0KPiA+ICsJCV9ub3RydW4gImF0aW1lIG5vdCBt
YWludGFpbmVkIGJ5ICRGU1RZUCINCj4gDQo+IEdvb2QgdG8gbWUsIHRoYW5rcyEgQnV0IGhvdyBh
Ym91dCBncm91cGluZyAiaGZzIiB0b2dldGhlciB3aXRoICJjZXBofGNlcGgtZnVzZSIsDQo+IHNp
bmNlIHlvdSB3YW50IHRoZW0gdG8gc2hhcmUgdGhlIHNhbWUgX25vdHJ1biBvdXRwdXQgbWVzc2Fn
ZS4gSSBjYW4gaGVscCB0bw0KPiBjaGFuZ2UgdGhhdCB3aGVuIEkgbWVyZ2UgaXQgaWYgeW91IGFn
cmVlLiBPciB5b3UgY2FuIHNlbmQgdjIgd2l0aCBteToNCj4gDQo+IFJldmlld2VkLWJ5OiBab3Jy
byBMYW5nIDx6bGFuZ0BrZXJuZWwub3JnPg0KPiANCj4gQ3VycmVudGx5IHdlIGhhdmUgdHdvIGtp
bmRzIG9mICpvdXRwdXQqIGluIF9yZXF1aXJlX2F0aW1lOg0KPiANCj4gICAgICAgICBuZnN8YWZz
fGNpZnN8dmlydGlvZnMpDQo+ICAgICAgICAgICAgICAgICBfbm90cnVuICJhdGltZSByZWxhdGVk
IG1vdW50IG9wdGlvbnMgaGF2ZSBubyBlZmZlY3Qgb24gJEZTVFlQIg0KPiAgICAgICAgICAgICAg
ICAgOzsNCj4gICAgICAgICBjZXBofGNlcGgtZnVzZSkNCj4gICAgICAgICAgICAgICAgIF9ub3Ry
dW4gImF0aW1lIG5vdCBtYWludGFpbmVkIGJ5ICRGU1RZUCINCj4gICAgICAgICAgICAgICAgIDs7
DQo+IA0KPiBCdXQgdGhlIGJvdW5kYXJ5IGJldHdlZW4gdGhlbSBzZWVtcyBhIGJpdCBmdXp6eS4g
SWYgdGhlIHN0cnVjdCBzdXBwb3J0cw0KPiBhdGltZS1yZWxhdGVkIGZpZWxkcywgYnV0IHRoZSBt
b3VudCBvcHRpb25zIGRvbid0IHdvcmsgb3IgYXJlIGhpZ2hseQ0KPiBkaXNjb3VyYWdlZCwgaXQg
c2hvdWxkIGZhbGwgaW50byB0aGUgZmlyc3QgY2F0ZWdvcnkgKGxpa2UgTkZTIGFuZCBDSUZTKS4N
Cj4gSWYgdGhlIHN0cnVjdCBpdHNlbGYgZG9lc24ndCBoYXZlIGF0aW1lLCBpdCBzaG91bGQgYmUg
dGhlIHNlY29uZCBjYXRlZ29yeQ0KPiAobGlrZSBDZXBoIGFuZCBIRlMpLg0KPiANCj4gQnV0IGxv
b2tpbmcgYXQgaXQgdGhpcyB3YXksIEFGUydzIHN0cnVjdCBhZnNfZmlsZV9zdGF0dXMgZG9lc24n
dCBzZWVtIHRvDQo+IGhhdmUgYW55dGhpbmcgcmVsYXRlZCB0byBhdGltZSBlaXRoZXIuIEhhaGEs
IGl0J3MgZ2V0dGluZyBhIGJpdCBtZXNzeSBoZXJlLg0KPiANCg0KSSBjb21wbGV0ZWx5IHRydXN0
IHRvIHlvdXIgd2F5IG9mIGNoYW5naW5nIHRoZSBwYXRjaC4gQnV0IGlmIHlvdSBuZWVkIGEgcmV3
b3JrZWQNCnZlcnNpb24gb2YgdGhlIHBhdGNoLCB0aGVuIEkgYW0gcmVhZHkgdG8gcmV3b3JrIGl0
LiBCdXQsIEkgc2xpZ2h0bHkgbG9zdCB0aGUNCnBvaW50IHdoaWNoIG1vZGlmaWNhdGlvbiBzaG91
bGQgYmUgZG9uZSwgZmluYWxseS4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQo=
