Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B320299B
	for <fstests@vger.kernel.org>; Thu, 29 May 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511653; cv=fail; b=Euyci6t56SQrL/3HgBNKVkqQ4wqvXfUuNMuVAMz564Zs52jQ3auj2FB3CyPdKoBU1+Kgv5jt4qrB3LOQC5erI7ZcrsBgh8w/9tSIqb1DD/Rj5huF55jBApZ/2YdKJFGaQ2Eyh35nlsoanBKnzGXg35EymewsaVwvT4yrG3ayLss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511653; c=relaxed/simple;
	bh=YtR6kaD8mmXH+CS8rSKx/VctwSa2YssgVXhByrAOCsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsqtF3MNmPVpI+mCQmxD/YtNo4mdoLbamuO+PQgypZosHPA1NH85NlimfIO8AtYpoD2SrgTnQmPOH62VvUxEOtxMa9iV3hL6AVQ1EzhSwTkLvHZGDoWL/2bNTedLKob6YnHjyB3pRTH4uaP1/k8tof5YhC7jI5JjPVow6IqvP/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=HB4rYlUv; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="HB4rYlUv"
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T5Zmwi012702;
	Thu, 29 May 2025 09:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=GjIdyZQ
	Z4+byHPLP8LrsTk3czdUBm+LiN+AvWgf289g=; b=HB4rYlUvgFkaPDRh6HyAtEr
	hrfyWDNBGtnTNyInA2QNWP0VqiHXIr5LrcBZchHC9GpsDiKSuFLGBwJ2AEuD0o9o
	CLlUL8Uh/j9HbOYa9yQaXYAfNT8lfmHMjpnGV8qPJrJpgH3DwNyQg/PIcjIw6rkb
	vdKUlg28BVhpwK4l4Wo+iVWzkDs4lV0bFAMC+NHmgaQ85qWBeotp7kykm1yZ14Kx
	42o5DIwgECEhv0K919/fPjUz0hnSycWoAhevzNJELn19OkScMZ8mBfpZN2XOGFxe
	kdweGEgcLHM8Y84FDe0Yu8+giEnBM7Ja6F3m9ok4ecYCCFVvPYMWUfUNopzJOIA=
	=
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011029.outbound.protection.outlook.com [40.93.128.29])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46u3c0vtjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 09:40:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH48AryGj5dtZ4oL01NSnv9NWSr03MYVMk9CHpKO2RpNdTUQoWwny7P/ArRf12jgfaliLKczwrFfAGVidZRxg1PBAmPcgnTuqUQ4cxEbBwQ7EJ9FcqPyNOlnfaXnHZ0CdQb+fWUwms0LtmbvVhUA7jDaXWEXbiiHVBRVK80On+lsfmMYI+lufjZ4kJFt6o1gg5vl3d/DQlUW7l/U4LRxP8n3VMiEbEjn4/iqNV/oA9mOea5kd6538+Cj32kk7UepJRedXgogwGkBv5A5jhp9CQ5BIwRdilaNgVNmK55XItjstWEcm+5CMer0fN7pwxUZNFsBh6eIrwTibbnbwSC/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjIdyZQZ4+byHPLP8LrsTk3czdUBm+LiN+AvWgf289g=;
 b=ZXpkdff6z9+FF4+s0uo1Xlvj8WuKHH3Wwp5Hgm5LjOJHAXyVaaqca9FoW5d4rvsDGUSZUvRrgB+8Y3uNE8H094J1Y+c+0zIUYqnQ5OiGO7OUVxfObW8+HeNaDGOAM9Lt8gNpBaOXXyGItiQTg3iUmds/DKmWoLaLpgoNvVlrba4ZSJ/6d1pfa0BpXG0IWpTAkIOMCv9azz8UPVlmYIJRoFjAEYG7jRgfCh2agpPu6aFLiaoAai3obpr0Dn7AX+YR7yitumAqnkEICr5pMvDvCEvGEfBkwk1HAhW/dEgcG2wIU5mYkgnwrcLSwR5HfvJmwkdKpRg9UIaEkEFaqSkkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY2PPF68F16DEE6.apcprd04.prod.outlook.com (2603:1096:408::ad7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 09:40:36 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 09:40:36 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 7/7] generic/633: add test requirements
Thread-Topic: [PATCH v1 7/7] generic/633: add test requirements
Thread-Index: AQHbz79IjN15oAYQK0yOsomc0lg+ZLPpGsuv
Date: Thu, 29 May 2025 09:40:35 +0000
Message-ID:
 <PUZPR04MB63164E55E22B1A4F97A40DD48166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
 <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY2PPF68F16DEE6:EE_
x-ms-office365-filtering-correlation-id: 5102c3e6-ade6-4b36-d003-08dd9e94dd3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LkFdur/LCBTtHURtboUyDMQtldqLjufdimm3OIItONrogxWLdZDHYrTWCT?=
 =?iso-8859-1?Q?Ia5TrbF4oPQexGNyusHxHIrm7gDVRLPVz/r0r1zCo22biykyGfGg5YfNgZ?=
 =?iso-8859-1?Q?49mrNYVVDTWVJVv36Jphz34e9LjJ9w56ICGVUDA5f47LQCOpCIvH4+pSFd?=
 =?iso-8859-1?Q?UmbGw1K8PD0CxMZrUlk3jPuOURq2Db+8JDIRqsNjra9pPis872fX5Tf4LS?=
 =?iso-8859-1?Q?7xWsJD2QxGIPyQo3qzY422a5qPZl1Y7FooRxbdAPfPelNTzzY5M2989S8Z?=
 =?iso-8859-1?Q?yuLwPZkcmP9MhB0kL89XwMA59v4ctAzdfjF4ejO5QO/NBoKo7pLEMAOZnm?=
 =?iso-8859-1?Q?2yAxJca+jl7h35glnCx8fTNTd4ZSJMPrfa2z2xlmR078vOT72yfaIUmf3v?=
 =?iso-8859-1?Q?ptnLwO2UINzG4Jd2bcWYQhcoSVf8s6SguLjr0C3IEFQTPARJwXg/nvHjV2?=
 =?iso-8859-1?Q?/YtGKjawYZxzvqBMrcSSISdyeBRcnsXh/XRBWnClBKu60intJtsg7zty08?=
 =?iso-8859-1?Q?5aQGZh6TPeCbE3klDkA5rYVeDvV7Pw/D1byiMx6BE9JsKKF9WgA0nPg6Oz?=
 =?iso-8859-1?Q?N9QLIDnyCyv1H+fEeyfQKryoVlNJ+N76IESDq+3AA3BX0FZRDOS7kt7flG?=
 =?iso-8859-1?Q?sbBewBaZvooy7RXplaLDtUYcYOfSzfeXTcXFYW8VmyIOSIMMjarPm2ZRUD?=
 =?iso-8859-1?Q?sMIsgywMH2m/YEWPzM2xPLK+A5n6iSYyvR0mxsMNyX50xVJRbETsFNLrJ8?=
 =?iso-8859-1?Q?B5iYv0xXGQ7++By+1ZqWXNjRR1oee2QcgxEQRMSHiMq0iy4t0x7a9pLMfP?=
 =?iso-8859-1?Q?d9O2cFfj7A0Zosv4fmXPHqPnS/HEUg30jxYRB3muyXy2NK85R3aXIijXPY?=
 =?iso-8859-1?Q?FuEdOslAwuojHltta7kLtWbq8P+IVxk8WBiHmFuE9fW6LFgdwV0T0k7wsk?=
 =?iso-8859-1?Q?pFrIUzKxd2aGLz/nKKk5Lz85m0Bcku5vIZ104pVHkpNa/EZ6aiMUz+fPYA?=
 =?iso-8859-1?Q?LTrEEwK2jeyZ/ixnfBkKwfs6gTeQr1vGLPJPO08WKqe2kwmyVKW3wpvpKR?=
 =?iso-8859-1?Q?HaPexHDAANgD6LD1AzDJnGJwtuhohmA0Q7tweaF5nC5wEuMbREoHOodDsJ?=
 =?iso-8859-1?Q?al0v2lqU030CQJsy31KUdYUMV9nC+G+CW8Ne2W0dooZqi7wZQ5fHbOmmvX?=
 =?iso-8859-1?Q?Mct+VbCK8AR83uGT7sYYeItTu33G3hkEG5iLXMc9m44trLUrA61KdyIqdf?=
 =?iso-8859-1?Q?UUWP/Ip13oE9CxKYyXrXVA/Y8ufhAjpqCEiaeLl0tvl4oA94kcFD/L0KLT?=
 =?iso-8859-1?Q?4jeQfDzP1HhwFdo1BQjfLoJ1adOxAB+4CxzssENeRtXcfszWnKEEzIbIoE?=
 =?iso-8859-1?Q?V84oA//IKphMJzQXmqPyauPgu5HiocTrX0H9VhLustbEuKJa8z4RE+uUPo?=
 =?iso-8859-1?Q?3T7yS8SbKccNHYjpj0h+Uhlf/XqzO2ZPs1VSvl4A90dYrV1aFGk/JJ5BB0?=
 =?iso-8859-1?Q?FDOZRCOZT3HIsgGEeyT65RD3lrR3hK+52h+d8R+VL1XoeNm8lTH+B9l54P?=
 =?iso-8859-1?Q?8v9JJUI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fj8leur1BgXzKG4YzFud4JgSKMOrvI7K4nfjnfuAC0CxrUmgY2HGYdyner?=
 =?iso-8859-1?Q?Yabxi7UBSdiljx6C4vDKyrdeYzqgED/rpJY7isx2EbxibEPzKNX1FqeDmt?=
 =?iso-8859-1?Q?86aQfzkagUnwehV0xZE4ErPJ3ktqE2SR7hwo+yCjdC0Gg2PBwERiP5tdZz?=
 =?iso-8859-1?Q?B+XJuCIHny/7Ub9AKMgGBN4vr68VTvRD5YtBlahwQUzBhm96lnQ/wWSkIU?=
 =?iso-8859-1?Q?tHuBQrbu8Zw22Dzh9+eYj7YFy7VF3Hv9Hi0cj1G9fCG7oyRl3cCbFXFFhl?=
 =?iso-8859-1?Q?p9eQT5xVKmer7EVVWy7og3N/WzidaDLT/vxh2S2u2JOy5sxJDTuhJ40YUo?=
 =?iso-8859-1?Q?bRjfLWBHuTi1f9klC3c5SsWwDNS8LrfgOnMOA4rtMdiwsrsRN/PMSAGNGz?=
 =?iso-8859-1?Q?oIClVB9Xwne4BVN5L2tpHeX3xPEhyvW7St33QoI0eZLZQDmUCtY1QU307g?=
 =?iso-8859-1?Q?9qTrOwCyic2ZbKs5V8/GoiSFDx+yDpKGLP1NwAYt5cob0LmDli8PzgReda?=
 =?iso-8859-1?Q?IuVGuzduT590O5vivc+jKc7e5OhN4xAsciogF+wWbCsQyhJ4fhMynwWaLz?=
 =?iso-8859-1?Q?/UB53XBHlIyc7Jz7kwqjQnvbZwSELB+4/Eg0KB5/8qWLKitsFbcnb6sJyw?=
 =?iso-8859-1?Q?SRnvZzrawEwHCwqcOKrwyeVNrA0cewFgcsN7V6yNgOZiGv+04hmKXExr46?=
 =?iso-8859-1?Q?qRCjjY/opeKd+Lsxo3zDEzasaeeSE0BtNhDg3rzjito4bBXTKrnXU7kDvl?=
 =?iso-8859-1?Q?0gkoAKnIxO+GTzGlXSxWI+67brXLykxCt+8oWZDg4K7EDJy/iR0nyE5nku?=
 =?iso-8859-1?Q?QF+uk77XOFU0NUaSBGdx1Xw7v7iY3Zsl51X9uGHWHtOqKGSGR8SO89ALNu?=
 =?iso-8859-1?Q?FKnpXSrHPtWtGBLs/baweBvWeT3yZAOL8FFMaTTLkwbAA8Hc7YLY73yO1H?=
 =?iso-8859-1?Q?BK6j1sSks/wfYsGwdsNgY5CwlpaEPc3O5ubHRrmCVgnQfT7aoBoIEluKCY?=
 =?iso-8859-1?Q?BM9L6oCi0GRzSr38SKUNvJDpuNI+S6ZyFROxQ+YS9whSeiwlsAOu6YsJDG?=
 =?iso-8859-1?Q?r3vfYWFXxZulMxZNOZeEFdxmq/1+K5a8/W5eBT8RxSexg1pdmbTPBJJ7KJ?=
 =?iso-8859-1?Q?DOa+2/MUtNC6EapqXc2hl8EDdE2xBSFgh1nHOF2RcOJF2Gc37qkK1K47Op?=
 =?iso-8859-1?Q?8MeMbyMgS/ZlIVvSyIFWojp5sZDN2jr/6gFUbxdVOWGgPY6fUJSJDxZa4e?=
 =?iso-8859-1?Q?aIqtZeSWK1feEhewSS9YIM4ivRh/cAcipC7H8Cnfhb5Zs3THdoz/Yt2w4g?=
 =?iso-8859-1?Q?Ii6jkRQJj8pQL0pCF+thrXlejd91mV3aKAMu9zOmlxbTbzEdlwwNAE/FLF?=
 =?iso-8859-1?Q?qqDbLr06wEvR48YUroBsDk3axE+jW02b6VoRrye2ujP3YPVhwhROV+nQqF?=
 =?iso-8859-1?Q?1443ezQCUtWmu1RTBARBbMZvZ7NaLVYMeAOylXEuhrMCjpHS+pB+mRqiLv?=
 =?iso-8859-1?Q?MGw04fjZ2tDrQmTWmIKheCGPD2a3xV28VBWwAjFmqZ6MidLCwSun6kod1/?=
 =?iso-8859-1?Q?B3D4WsZi0cmlQVqxQ28tJKym+j/zyIvIuWjg8A2kXQXvTojqjNXFS1JIXe?=
 =?iso-8859-1?Q?LeK5IMdNsO65ocy4BFL0YxkxyWj5qp/C7tkFNp7+vPjyQB5q8iFp54fBDw?=
 =?iso-8859-1?Q?hkCRJDtmdZlXacOpqPE=3D?=
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
	wFgnZJVL8YZUHBSWhv2e88lTUcil/j4myiPAdBLeQZOxy6ooASTkX+mpGw7t6xbeRyfLcuFPRnlInOpIh6cSX6FCMyuGm3ZMOX23x6F+RrHztpw8F6U79ZLjJTcx0TEXfLIxlYxn1NJxBDAO6K7WbpA2orT05VNy3L/TDekqcvVN/HU3Oen0Kmj0LmtvHygWxJKQSgk5bGUGvjIP8//fCnzoLMTVtcECL0YhsQ0JPqbiA7NtB/O96IIBpfLqaV8d+1tKAlnJp1uoOTrF/2h6hAY3ZjyNuxEfrkGCU58jLDJhJsZoL4VA9NbIHwzl5levQjir/35NKi0S+C8cggb6SMGVaw5wNFU79SxinOwOCHrSFAL3roL1OhZE0B9ZM+Ey1M/um6xGdD8FGhmNPErvdrmHYZsUn2Qp69DU2A0/MPYqN5TNBRN2pa83zr+qvKHNnEPUnYC0TIykdMHqWTg5NUp31ipwNxJWG4jlk/A8tH25S/vnaPhe9jwuGADTMc6Jv2CHnJVXVqDOyIKohUIUAwyv+Ix6nmEUVNXzp1xkbPe5pdDf/V+Lrrsxuk5Ca1YLqlV6o5dgLlhC/2qPqLXVAK0v6rvE6ggDuMHciGPJS8uS5JaK8M6tA6nyqNYY5gkV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5102c3e6-ade6-4b36-d003-08dd9e94dd3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 09:40:36.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jy3BOOuUir7L7FJWRy2HV58q6gXThyaoCbTivscOKznk0ZpspaphjlG8dTuDnFAALa+LMB+YoLLrE/buBD7kKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF68F16DEE6
X-Proofpoint-GUID: b6nP5LeHvJOxEMLXN6dsMebsFQvzxf14
X-Authority-Analysis: v=2.4 cv=eJETjGp1 c=1 sm=1 tr=0 ts=68382b9b cx=c_pps a=UYJq0S2ojVR2j0v74YSC/g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Lj4fwyweFGXWD7yVjBQA:9 a=wPNLvfGTeEIA:10 a=AUO9t7OMDSkA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA5MyBTYWx0ZWRfX/S5pD9hlBQ1q OntIyJ8QaFppsC54/2SDD/vF5PQuMOD3VSQwMI6llzsWcLVpnavEuiI7bRPyU2U23eTdOD4mSz/ 7aJFYClR84O4B5AxFAee3eYQ2OIV3RXvcreDJdARbwk4sPtW2VR+wL44LeB57OtUgGhxT5fCdKL
 qulUM38Dw5WNYYAyVY3DCBrUmjij+ZHbERAziVdU4imMPkMDFrifA67k0RSNS+IIGCZOsecOtZh 5FpD6ExKn6i22E/WEo4xz/f9qz3ObFbN5kQ2FpIRZHeWogfF1rYNomR6D6gLHawo8jIxR/wr+Z9 3zq5cpDkBm1cnBWXvQ68ZbSSfHOAvCRgbFbU2Lf+dLfWj6dXp+AjaQrlZhGRRWaroOLBAkBxB9A
 OZNigo7HQ+qjXlkUbfX2d/QeOw8nVkPSFO0sEbjJEVzsGXMKcfIlfNv31HSW1seatA3/G5yf
X-Proofpoint-ORIG-GUID: b6nP5LeHvJOxEMLXN6dsMebsFQvzxf14
X-Sony-Outbound-GUID: b6nP5LeHvJOxEMLXN6dsMebsFQvzxf14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_04,2025-05-29_01,2025-03-28_01

> >  _require_idmapped_mounts=0A=
>=0A=
> Please note that the requirement above is wrong:=0A=
> =0A=
> https://lore.kernel.org/fstests/20250526175437.1528310-1-amir73il@gmail.c=
om/=0A=
=0A=
Thanks for the info, if so this patch will need to be rebased.=0A=
