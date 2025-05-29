Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C525CC46
	for <fstests@vger.kernel.org>; Thu, 29 May 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497483; cv=fail; b=BY1gjOFznvF17KKLONPY2gr/38hNQlR7lMKGCtchGe2OLocEBg/bSs6cGecjxF2HFB9G7hPRK9ayXa47qs7iGJe9nvogiWhbJgfBQkRXxShjELMWW8XgsDqyzhd9/P0dVUPKYctQKl5YuztRtLhkd0Fe01rs04en4m+R+jR6cqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497483; c=relaxed/simple;
	bh=oBLdTZ5eGUOKNMTyuAVb3XPForuyfFO7hrZbH+AN6iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHr/3jz1pOvn6MrCLPRc79NBR51AOi10iUsRBlBlkCRf91nAwsMSRqnl/H1RVdhid99ZFoif2XYySsuxxafTJVXc9FxqOPrnHN9SXkdrlgLkktXyw+ekKA6256A0O+HC6dj0WnSOG4ZQT59D8pxcmgK1JlAXCuWgcz/HOBlC+gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EeT70npO; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EeT70npO"
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T5KdaZ002840;
	Thu, 29 May 2025 05:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=ftbUJ9a
	WGUOirOlDKWRg7q4p9pdGo5YBmod2tqZj86c=; b=EeT70npOe0eu2K6LYkvPzsl
	V6Tu137qutOym/twwla9udz5kOB+W9G/VVhs0jpsxZThIIc504UWeqwnwoZDHK02
	USyEOf3LUSqg+wGBLzsskXGdMuDZRocltpx/DOqiCk4FbUgkPBlfmEJELVwcxrh8
	fP/lR6JYLk3/wxIxb1Cx0DNt4IPIoYoPqNnreJMxce4mlJDg8o/uZ/KGQi9c0tVR
	kArv7unnCTyGIjK8ajC3a+23umfOA5jT/2Qf6PFQFymKy9+ZcK0X/wKBt2jKPPj2
	BOfNTf4oc7GW1dxew3qcKL7MmN0xHCITD2rtoasJQ6oU+OuXb8mOv4bzs8fzUSw=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazlp17012050.outbound.protection.outlook.com [40.93.73.50])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46u3974m1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 05:43:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrWL/8Zxxv3EubACpmyJI+WJ96hT3KR37ZOGSfi5ki6dLZ47hhE8yRxtrjhb/SJqWGCr8muAvKr0+g4YKTj5IdJkKOSYLoVmYyK+E83vzb3szsnff1xDTFJ8tx7ES7xbIuCHkkXCrL2twWliKjTCiXKlZCYmUbI+leGa1ObDdD3XMGhF7TPW7QAtyFJrjDF2VBMrvKUlWYAAHeak2B7Rya5dIsaj+KCCWk+K0KfZe+2CiyCuJ8wS09DOmm9ck2Ny1iJ/EfT4E4GxbF06VqN1A4greG/vzRlpITTmPCvHNs2ssk8zISKDerO89pAEpdtkJ/KRM6pIP8ehMD4TNdUGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftbUJ9aWGUOirOlDKWRg7q4p9pdGo5YBmod2tqZj86c=;
 b=ZQj9udLfkzDsLowrwsOGqnZEaCFt0oaLK/Sun0usKF5iMUigNXUcwh/pBtTbGlBDIrwmt/Zl4fwvnBFn2Yv7a3H6w3SEd2BjuH0VOEZPhiYSm9bpsNHksU//jQcSDU8ZgqhJl/eIs3qx7OpVGQ5yS9pNoWCQzsw6VcUNOMkIJorRKzCDtdgojwivmVQhU5sHlJtTMwqNqnG+TtOi17yy8oAg/+MQYpIEle+dcHX+b+NSlWl6gmUpvlsWxr/JChYLmq6SeXfAhyZgCl/4GxOVc9FIvr6XoE90HCAvMKCamYYPyfTM4NQICROjKovdrUIWPoUQFq/LOeKEnD8UgHuI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY2PPFE4A017553.apcprd04.prod.outlook.com (2603:1096:408::aef) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 05:43:48 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 05:43:48 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 0/7] add test requirements
Thread-Topic: [PATCH v1 0/7] add test requirements
Thread-Index: AQHbz7/bZDNWPayv/UuenYc/K3KYVLPpEgun
Date: Thu, 29 May 2025 05:43:48 +0000
Message-ID:
 <PUZPR04MB63163EFBDDF33FFC83B863008166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <aDbs_Fr-8CVCxdxy@infradead.org>
In-Reply-To: <aDbs_Fr-8CVCxdxy@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY2PPFE4A017553:EE_
x-ms-office365-filtering-correlation-id: 38b31d4e-3dbe-4c0a-97ec-08dd9e73c8d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UDU0uJy/b9o3SUgHoEy1oHYIIm7G2lUMY4E2g2txVOleo8ldNYlLWl0Gsm?=
 =?iso-8859-1?Q?OLuD5r0uWCAZ2ifcmydCrSWIRDQ9kxerPZFsipjjRq5HzirhcgrlZu30lV?=
 =?iso-8859-1?Q?YDHaWVET+2bUHeILnPLbUuvk3/y9vSLWXUSOb8aFJ4E8Y24bbSY8FAzNiG?=
 =?iso-8859-1?Q?+wqHvvfkLT89pFm/kub4djRiExNph0CqnQkj1zIGANtdLB0WGowD2Zs/Cx?=
 =?iso-8859-1?Q?3QTytye1I9G7VBAlwX5FzUUS9aXOqA25nNT/TDoF7wzOPsY5Y4oPDlBYQ8?=
 =?iso-8859-1?Q?fl5DXM71aKswcyHpOio/Xee1itvveh5S7i1C4BVXDpnoIkRmZ1eYVr0tjN?=
 =?iso-8859-1?Q?4iJfXNsbCs7jXumRKCURsakkYf94P6arjocZhM5kyllkvwg94JDJVM+A//?=
 =?iso-8859-1?Q?8k4jFrB67UJkqneNaruq0KJJ7Gd45gosbKvxiIU6UxyVupjlcvoT2tgnay?=
 =?iso-8859-1?Q?Gy4OVrBrQ/RmOBJfkfYt+pkGql4FN/3088ekQPIEQucOaeaa4d+uLEjyST?=
 =?iso-8859-1?Q?Wa0Q7efO2sZiJZFNnoidAhlD0CMPh2rJ/emXcvHaHvnEB2LmtJBnUts9rl?=
 =?iso-8859-1?Q?yyTP/BpVyDVboHl+qEZ+bj0ywQolqojv+3t4lmxFbfyJl1DRWXvOTwS1mg?=
 =?iso-8859-1?Q?zkU+9YaF44b5WQ25+7tZiBIxAXeIjBlmQQBZ46B0yajwryxb1/dMmdAPLf?=
 =?iso-8859-1?Q?SlWpLgfhsQ+19LHP+iQlF5ueA9tpF+U0TjK74JIUUKiAG5Lim93coVChy4?=
 =?iso-8859-1?Q?yASS6V/sa7NxJ8OifRlT0EGxK/viEkLtvacIOnPHQgkMuVa6JYVXNjLTnE?=
 =?iso-8859-1?Q?rtj7aS7Rki6eE/hG4gMLAuQTKcjRxv29bxRCQgZDcw7fcYECuLj48TZK21?=
 =?iso-8859-1?Q?ndWEP7nqbR0FhODQfhTSsEqaQLp9gCzR7ylnnbcmz5XXsqDhUlASLmYY+2?=
 =?iso-8859-1?Q?fyR9eziOQwWZz79WQ0KFOUj711YUlTQRxVW70jkpI0LrHHpfS2M44Jtln7?=
 =?iso-8859-1?Q?2YrPmPasowlxL9oT2+ImjwcrT+XPOgiUyVExrlpRVe9s2LG0znKgAps/gN?=
 =?iso-8859-1?Q?B0rQGQgfNkcSX7L5VCrdD4cgZzMPOpwZiJBnUztIV8UkKEllteBNUpFWSQ?=
 =?iso-8859-1?Q?daNBUrmfH+HhqVqVkxMAFoHqsgY4niLmyHxXAnE1Su3tMyNCD4NIq0qAx9?=
 =?iso-8859-1?Q?lil/smgxSy5YRhbWdF343W5xiyICkmi3hQcDIllYtgxWdNtgj8jeQ5ctDC?=
 =?iso-8859-1?Q?j8wuNt4G7FZfoDcO6yvZGwlfhmkhyFds3m5IchN/S8cJP+YusimWXNvxfB?=
 =?iso-8859-1?Q?DAh99n02TBAAv4+wQyOUrt3+5IrLyWUZP6VDcugib6TF6mE0PsonfmG6dh?=
 =?iso-8859-1?Q?7qCR3zGKXaSDv3aT309OlJ1otslyjimy5HfkiU3osNIYoUwBYYTduHVU/1?=
 =?iso-8859-1?Q?ob1eYo5tYGR8aNCHRoYfOjm9k6JuwKMeg9GCuw421f6koXD7RO2RdB3C41?=
 =?iso-8859-1?Q?vMzwBSr5kcnUUb/bROx+H6GqFZF0ex6P1l+r3M+SJ6TQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YZ+dbuvWOuhMAhXmbSbACdzTglmW8JiXDU/5n/szOxnIpZwSnDtjH3gT5d?=
 =?iso-8859-1?Q?V8qTjBcX67FwAMGS8PRKqvqF43g7IlEXenyXLHgOLqPX8lCHFRFaLmw8BU?=
 =?iso-8859-1?Q?If9+nIesTPVznXGt3ewLKj3gzCvjzOv3Qw6h7Em1Wac04/7B6OGclpH493?=
 =?iso-8859-1?Q?HUd0E9ICwuI+p4j9HIrFOsmMY7Y/lVbAta3tEO8Bog7zE49QkTeUhsw8oy?=
 =?iso-8859-1?Q?oalss+hfy11thHxN0G7hzBEAcvIB2nzEtsSXjvHsdfBaX2ER4+e5ly+hen?=
 =?iso-8859-1?Q?oKYgVbmtEguT1vpe028AUKxrTPAv2fKpQttb2z+RdPfNvVsSPZLPO+U09E?=
 =?iso-8859-1?Q?SM2oMzN/hdlztlZLA6ASldLudg/J369ih/nqTl3ig1P5xotFfWCHfXvdjd?=
 =?iso-8859-1?Q?5H+k1t0hDbyy1rc8iuQra1R27aTJ/x92cnboIMJ07iLgb9LBqPBQKwm4ZL?=
 =?iso-8859-1?Q?ecaqaQcf6mZW651b7eQQur/eZHR93CLsaL1R2i59AKEzNTl/+mLDyA3z1H?=
 =?iso-8859-1?Q?mwHAoEx1eGVw5ERTt0ge6gi5M3mof0BlGkwKw5GMjo5y1P/KZ7+uV58uJx?=
 =?iso-8859-1?Q?zKcaEVC4JbMY45s3dNo+ge0oDwuY3PNfqNvpfQIexWLaRXTnFn3rgkvt/N?=
 =?iso-8859-1?Q?/PI567OElIdZ7h8FOBgcBS9I0nwZEfs/SwG5pf6oudU5iOdMc0VYbwrHoq?=
 =?iso-8859-1?Q?JZ/N5xXI3o12AksWE03kSzxBFOiNc5D3azWYLS1bM37M7e3kfUUIaIFMjp?=
 =?iso-8859-1?Q?PbL/kriX4GEGb7B2TvZBeY/Kgrg/lts0Q9XGMks4FvXKjsjNPYxBRFnfGD?=
 =?iso-8859-1?Q?pGyKqqr840pHB7z5EeWJMocLpattW3nzdPy6gmBEYDhdfz61BkVcQtzR+x?=
 =?iso-8859-1?Q?qK/2xgT3rjg2maXO5+3sa59IKWjSnNxxG/obOZqWyWgkwxmulDfiN4rHrd?=
 =?iso-8859-1?Q?d/nh/I1/fiq5su9F5DL/PidhkTrUBR7suQ1azQ2zR57K5YWLH4KkZXZ65t?=
 =?iso-8859-1?Q?jsK2Nuf1LBvvU6xPhS50yH8cIcq67khZuWIa3XKAO+H3j0pzSl92NbRyf4?=
 =?iso-8859-1?Q?CfG/a/t7WDB89fhUnlseABmlepfMFohjIK6U/vmVDHXZ0Ph4wxc1sFnOGC?=
 =?iso-8859-1?Q?yAXqBCpMrtZmrXfcnSmZp4kfyec0JBq0pGh+NT7tJdKvdXneTfs2VYNfTA?=
 =?iso-8859-1?Q?lvc9FBxZgrL4jzplgCvCOR/POoQcl3bbGXNUZaYpOas4Hqdqm6jnW1hJXc?=
 =?iso-8859-1?Q?jxDXMwfRedbEIgp553lS0K8LXUYw58aQ6mABJTYcjl4cvLWAv7Ff844Cd2?=
 =?iso-8859-1?Q?kf7IGoBHSXtL7707UFkm0/cgEbrCNgUkYFZNkLtMZDNRSGnZzRzWxOmZtw?=
 =?iso-8859-1?Q?NfekGmsuIrqvSb+RJpnKtwT//v3DmPf7EykuOeQqtPxepb0AuKrrVXBps8?=
 =?iso-8859-1?Q?GSXaTISs+zipnkmaDYKHBMmZf5h5cFmwO2/Xdm348JsjX/5dYFHSjV47Df?=
 =?iso-8859-1?Q?zum1WRMZppIbnlQh8iD1MzpC4XG0gb5wjW8upK44x4Gf6RVNwDKsVaj702?=
 =?iso-8859-1?Q?mXJIU3aaeoudw5ONw+pZR7o/9yYW3m+DM5Rad23QnZZbbMnWrguHMIOUb9?=
 =?iso-8859-1?Q?q15M/n8UfCSCRHIXDVsJ5Ut9Y5ZoHrOPsSZ1X04vtGoypoMC2BQSwXacUt?=
 =?iso-8859-1?Q?S3AiY/IF08b8eR9EKoU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mObpjMDAaEsfXNdzItcPFyOZpLfJi/EU0OfNdHLLy7YxmXllk1UcCmu2HBVBPS6MasBRcM5bz+K0KBKvyz+yvXz8lf+IP/Z7WycS4pz/XiHfKm8r2SJWtqrz8YIp+z3x2ZwVpNfLH//07UP816wMVhjEaJCc+cdo0dEesoROzZQdom1HRzwRfjt8cFHWRi/b7J5srg82EW8Z3uOvqkf3BeLdh5oKZrKAuIwa7BuNfW8ja0kA9gmcYaODqudj9hBKVO5HzHe2fPmZYoqm6Frg+AZie38jGOL978mUgfnrPNCdhjaWx4w4d4MrX06hBLA7wbqHlOEJX5WKmJZc8NosZiYj7pZUpp3DdF3+chGfLLuGL29RISzn5e8mR/UtPdjhUVsEIiw850LQWyuQ7IXS41nS4emgBfVS3jZF5XppoALLwTm7a8futQvXmQXVS2qcPujF3Idy46vQYNzJ9A1oaTVYDx08PlqanFpjKbPqEksGk2ZmcrYYmLYURVbNn3/tztjdpNdHRaW/1FSVQ1lgxRmVUZ7zTPcEJekXEhCaOidlvaXpY//boGYSzDz1nDWVnWUUCubKWQWNZ1/fT7dn/W3yrGe1DwRU8vTapahTH99AnR16Q55CJhRC+MF7HY5T
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b31d4e-3dbe-4c0a-97ec-08dd9e73c8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 05:43:48.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5P/82gR02R6FKFVCEh8NTxpXq4wTLpTd6OO4HEWENax5WC3Dsr+F+xawgP9PK7a6r09nYdcujTLU/gkLQXiC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFE4A017553
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA1NSBTYWx0ZWRfX2trDsxJP2fTZ 0WhXpCahZMDBWEHdpTG+sjJ5u4kiJsmiFzMc5TmgW2l3Zp//7lHMQND7vr6ntX7huZk5+Via5aN QIqyu0QOaEJ0fxWBms7H24T3y62FB76lrZasPIgR1kCOFdz2qPnEKI+9KImOMPw9jN0T81eXo3E
 X7bvOWUknQqsAP+x0/qelit3RSarNop6vNLlaTSUR8HSfaUXL+f6NUse9e4vQyJnlDIgXdlCB+n zpUvBtqFy05ZNu+mn9Fysln7bZKTyfHoH3jSE55t639+ggsjmdgqgRrZzC2KnbJIIfD0goQyxno PDbFIUTVuzok5l4iPjoUpfL+SJ17JA9ZrUpvxhWEWhCRs0FlJOO+0dHEH09a6D4qb1onDUD0oLw
 iU0KQNyQMxxa+fSXlIw1yyflci7ct4GjJ7sGRRBYPQ9cozHUhIl26yEzD2rnb9Wr0+KP3Miz
X-Authority-Analysis: v=2.4 cv=LvCSymdc c=1 sm=1 tr=0 ts=6837f41a cx=c_pps a=RYz4mApf4nz84ELWqj4ujg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=eoDJO3QgC3Ef8-5V3CYA:9 a=wPNLvfGTeEIA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: XQUiE1yk9pb1PloUMrEYSIWxxCHWnz7i
X-Proofpoint-GUID: XQUiE1yk9pb1PloUMrEYSIWxxCHWnz7i
X-Sony-Outbound-GUID: XQUiE1yk9pb1PloUMrEYSIWxxCHWnz7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_03,2025-05-27_01,2025-03-28_01

> On Wed, May 28, 2025 at 05:15:23PM +0800, Yuezhang Mo wrote:=0A=
> > These patches add test requirements to the following tests so that=0A=
> > they do not run on filesystems that do not support these requirements,=
=0A=
> > rather than causing the tests to fail.=0A=
>=0A=
> What file system do you want to support?  How are they going to work=0A=
> without wiring them up in common/rc?=0A=
=0A=
For filesystems that do not support the features(symlink, hardlink, access =
=0A=
permissions, etc), such as exfat, these tests will always fail and there is=
 no =0A=
need to run them.=0A=
