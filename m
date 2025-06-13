Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71379433D9
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821732; cv=fail; b=pH77kAoPSuNbKgQxgkGMGBGnxmNH1GLrmqVAyCyVzTH7tiXM6pqNY8IKDl1EiT7j7cv1OHGpERMswnl9TCh/tRYog1lrO8ChMCLfGpN21I1jcza+LEUjYVc8ToAc/rhZpsEIpjWKj8o73MJgJGM6jwmNUl2jo4sk+XN6xnt6/D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821732; c=relaxed/simple;
	bh=gtA5cRddCN10ActBgEXrdb2CL/4/lPm/7zr+zPjF2X0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X1vKdAvZnkeuEVshCyzsmu8AfCFllEuwwwaXbLrihEL5urXXsQ9Ku7fPCZ4/rzHykea0chOt9eLnkTszpPO3vnZCgkYb4W38/dW0xoO0wCASKzwsjfWdmcsUBUKJY5LKCc0/b4Gn1DGRmx98pGjhrRKOZf1RoAFqhtJUJbuin/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=XeZzbccN; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="XeZzbccN"
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCeGsZ006451;
	Fri, 13 Jun 2025 13:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=qOErMy7
	8sYD9zpVIxnRpY7zmzyqdtD9qD1XydjlImaQ=; b=XeZzbccNpmTB9h+060x0SJd
	1P5JtY8+IBj4Kj/L8Jas4CkEplRMz1vxCjIup++GKcLDetwYdWIuJZnuc2rpAK5L
	r+kC0OIyZmKlm59jRW+zIROmDbVDbEPl5hYTc5+OpSqFwPdMV1GRO4IBAOB6xSyH
	mN0FYVHc62tk3HSIdY5sMV6pWTOKn2Q7LHuvJSMyN13Ye1llYOaXr55imBVPNkpv
	SkWv+wmvY56pXDfvtc8IwQEG/P+AZckhjMVVMm7Yc4A2RfqEuT73D9fjDupZODVO
	qQGYwmdxNuRl14YVFU47XRQO6f6axPqfHVmEcLdwyrKKmxaNuKQTl403CepRxBw=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 474eknnx3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 13:35:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd8/PXjxySAp+C+72z5flUsIvZI3/B1BGhPy8rCaBu4Cij+z1MlsDA1SNsIizNlH1MOaQD5ahr28/SlCvH+5D8Az9eAx790h352BOsPX//k+NJHIRDM5R0/hnQAj68/NGYXJC58OO4vLKAvyDHuyuEe+LGhHQlyQsAgAs1z2A1KxzfNVC6lUi5dyv1AmKtrxitLlSm6P9P04PMNTuCDF4HSUEYugm7znydkftb3FZTlETjokk/1CoCmBosTsu8fwrJINYv70l3ogFMA2WG23DWJzA8HPYaWoSeVLk6fgkrXMysbXSI8nXAorM9M2spRzY16o6QA6sP9HGLGfDiqS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOErMy78sYD9zpVIxnRpY7zmzyqdtD9qD1XydjlImaQ=;
 b=oNf2rvgCqjFNXzKLwpAyAJW0AcDsOjKlzNHxb56jBE9AzaE/wbG6+mTSuTlJmRBrCITglNqTrAyt/mBQCBNGRLgrsoMX/OlrMMxHFg1g8ZM8Sx1L34Twee44kfRhH/8Uafrp9bZWAQ82Vl0G9wGYheaMPoXAM6dOHavjrPcoDzuYE4wmGbO7sZMYfo/KKAdsJB21TzjCk6RRXuvXR6jJpy6G/iZgY9s1Ore2wIZo4riUgvgsOmt9dNyWd4xCLSEhcNBhIYBHDyeBApOWLjg9LNunyDNbnRXdh843G0XRN8hPOp21LgD+90CKAOtpomLxdhT2nGWmZ0jpC3RrhMPhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7806.apcprd04.prod.outlook.com (2603:1096:405:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 13:34:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 13:34:58 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Zorro Lang <zlang@redhat.com>
CC: Amir Goldstein <amir73il@gmail.com>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 7/7] generic/633: add test requirements
Thread-Topic: [PATCH v1 7/7] generic/633: add test requirements
Thread-Index: AQHbz79IjN15oAYQK0yOsomc0lg+ZLP0qcaAgADF4a+AA9SBgIAH6+vR
Date: Fri, 13 Jun 2025 13:34:58 +0000
Message-ID:
 <PUZPR04MB6316F243EB0ED0EBC891D3098177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
 <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
 <20250605141757.wx45cw2f5ets7hpr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <PUZPR04MB63167B990F5D144392C67EDD816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <20250608123533.zdl4ehn265alpqei@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20250608123533.zdl4ehn265alpqei@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7806:EE_
x-ms-office365-filtering-correlation-id: 0b6c88a3-7bc8-4f72-c640-08ddaa7f1778
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4h7OLChwiPapnSqJR7MfgAyn3eoubqTqYlyoMneU5lOPyhVQBgl87S5vRH?=
 =?iso-8859-1?Q?05ZdCjlcwNqQuooe89GLcAbPBPzW3Qrm/8CXMsfMOhslb/jOafQGTSr2eb?=
 =?iso-8859-1?Q?8Imw2OmhhbD9JAPtPgQRcVdF9ZWVSQKDviRkxTJLwt4z2fF0Kx5Nn5LZ7+?=
 =?iso-8859-1?Q?LVhGNxwfDQya1PA3zLfNx2F53ea7TL2x277PB9yKI8mqjyxYeBR5OxD9T8?=
 =?iso-8859-1?Q?nCPQzWh453J9/zFBSMlHKZULUKZxFGRjtWIpR03WIbu4wrHna3m+VvizWQ?=
 =?iso-8859-1?Q?iw2s7a4IzqbnoRNeW7fnzP82nP3EIhlQ4Wo4JHILN09zM9jI+TE7/LDjAd?=
 =?iso-8859-1?Q?s6w8ptE+PeYr/q7k2OW7rZBWuDhzhAB/hViEp8yC6nSvrAIMX80Ugp3z5S?=
 =?iso-8859-1?Q?L9WCqGPaaHtzP4DPDfPSbQobV0VXWhiaPrWWoq4wjb2bJogaz4QXxNF7fw?=
 =?iso-8859-1?Q?2yu7s7PWY2u6UmvkDu0L01HZ53GqeCectD+p6jE5tAodkjAL3cb4th/vWw?=
 =?iso-8859-1?Q?nIhP0OMI8dIX012qRlroBlqv2qYdaIenCGuY0MKaZv3GekzIUX/hsWiyv5?=
 =?iso-8859-1?Q?9zY/dQczprNxT4RDKufzqT6I4H5ztYX6msNQ8cPDFbeCrJu+jIdaDekM2I?=
 =?iso-8859-1?Q?T3533RDeT3B8p1cj6ByO+wymVRFT4qQFG0BqfdaqggXddi6VGte1gdlfts?=
 =?iso-8859-1?Q?pmF7TJav1+mYNUCyYigJHG8aeK8khJZs3cJnryT2by62NZEHXT4StZBHx6?=
 =?iso-8859-1?Q?RjsmdAXYxJZMJMUSOtmSRwGFA0b5jUI4C+eXZrdt+ddLpCdIXqthgXpZ6l?=
 =?iso-8859-1?Q?R2LCwEsoiOkk7inrqeJqWACiq4FR+x2glTOq1L25c2Hcjhh9ic89VuwPqL?=
 =?iso-8859-1?Q?5uQ3NCuLxRP9ICpFpLv5itsqPeugX1Gh/yQJiUOcfA/rkEPuWJWCwys82k?=
 =?iso-8859-1?Q?G3o9ehbgg216XojdYkXWpjFenq6Cuk9va4kX0gMbmo00MTZymm9+wupAB5?=
 =?iso-8859-1?Q?Xuszv4G/54BBZf6ZWPDuw8ZN9ZV/MaxAeDaNSMeY1DDqEaWPFbpEvAaMj9?=
 =?iso-8859-1?Q?Y0pVbcFRhS1osBPASc6BR3TvrH0IhiKpmbISKNliH8ssmmWxfDOFDZwDSl?=
 =?iso-8859-1?Q?dgNHXas2hCXvTcf8I62L4hvmZztM9iG39Oyxy3S63jgvZ5OR71nfXGj4Cm?=
 =?iso-8859-1?Q?G9b8KPueOs+Oxpm8KOu1Qd28S+KvPTyYOd+NzQ9+F84WlknuskdmfURe+n?=
 =?iso-8859-1?Q?/U7rq/YqwEGCmmvn3D74dKuZhZ5c+5nWrNZ8XIZ34j4R1yZ53nhlYV9WC2?=
 =?iso-8859-1?Q?PIcMcwJD5FCp0QXWU9bsJ0GgBmiqY0LwDZgXpdrTUVPsv6hyHjvpqFftHu?=
 =?iso-8859-1?Q?Cmwi9lDYVDvBIQ/pPqbBOiFG5ypizPJc9btY3KBbeTIg8HW7XXulPEtMmc?=
 =?iso-8859-1?Q?RIcEUs8CFHVdRe3Frsk8aS1p/Cy4RtH8pFyBGanuhVEocWHbt9asLFozcH?=
 =?iso-8859-1?Q?Rv67JGtETW6hEVdaoAl4QoZIpjpmNggXfcDkekiDD4GA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EPOypLRk2LhKwJ4mD8oNIEF2CjPZFvDfL1rLwHPzxPUoqhJ8TZkJ9/ognG?=
 =?iso-8859-1?Q?0V97Z8NPAwth3nmt5Vg8BZIUYeon7qtJItA5nKoAR3jkukANQ5jjE8wM2O?=
 =?iso-8859-1?Q?WIXsB9O+7DaPdz5olZryBfM9J7cWg4PCnZIQFr1+1YaQKaOZIdLpGdAeAV?=
 =?iso-8859-1?Q?cb6vwiDJOQRTDPfaW6tPgYBFx7wkYqhalTZ9ypfyv9p2E8Hem7O7XNAeRP?=
 =?iso-8859-1?Q?zPUqnMdUF5Xl5cN9AaGgGSQ13AXhvPTsbqI+bO4nqTF0srCatzFl1dn2hN?=
 =?iso-8859-1?Q?8+MvObrK6NWR3ISHkg31wi77svA/jL+e05SF9LcjtuQ0CE5MEu2JUxG0F4?=
 =?iso-8859-1?Q?OSX4w/zQZqgIyf689fJPMWHtNjEJ3bG7CqTKV2uRgtVN6lVhrgeuXsiveC?=
 =?iso-8859-1?Q?WSLm3vw65kqnPOduHt/cKfpcgguQmlqr/NxY662o4ODNYZteHTflKM9vG7?=
 =?iso-8859-1?Q?6YT1Ig+VWJuYJujOJ0Msb7S0NA7/DCmXiSIeRCp1Y10nV9oCCRgVatdH7q?=
 =?iso-8859-1?Q?YYrBxDA3srhuTzSTMyso/Yizbu2TDmdksoDuUEZS89Sh5XKHLncihWuhYp?=
 =?iso-8859-1?Q?625Wm1//8XxSy3o1TX3ZPV/f09vzVawB4f7zemWaYP7T06aexD4nFxrmQS?=
 =?iso-8859-1?Q?D8rEeLLlxnWA6evaMy3lQBb7QHkZzG4i8m0424DzRxKO5RayiA4T6t4lOB?=
 =?iso-8859-1?Q?a6wyCOBZnfpJo3KfabBh4Ox5ak65dHQV/pCBRv/4ZpDYKss7PIGqNosoPT?=
 =?iso-8859-1?Q?jAVKYbMEsMqEtcvwVEuwd54Iv8Ol1sVSzqLqldXD7FOoY+t3UAzXBwgZQZ?=
 =?iso-8859-1?Q?7dX2OzHNA7l70B8pKKV/h8bLQ4YJpEOsU+O9PCl2e1Mq6ggy6HmTM19syu?=
 =?iso-8859-1?Q?PK6+TfT+cjpZEn4AKEhlZxZ8DxKPbxRa1j5EjXVmXgraDbbk0GXIx0PWRn?=
 =?iso-8859-1?Q?tVhvsd2neXnlA7AtNjohVHeoKCK4vcuEwZ+xjWDHjWBiPG4LZRUhejXFDL?=
 =?iso-8859-1?Q?6TRKaszI45gnxzkN+J7HaeeeOSFA/BlRgR/Mi2qQW2rFrFIfeiv7xHZ3+T?=
 =?iso-8859-1?Q?eUW7XBIFjtBe+EDF6zpSNnqW045O41Sa9zvGjJhujaZbG83VHmzRaubwgD?=
 =?iso-8859-1?Q?b+fjGnkdn/wjsZgTrrJ/AYTNS3s1iDbNfqiWZpTD9QzHf3MtB2dMwXumRE?=
 =?iso-8859-1?Q?A6Z2ca/hH+2U3ya0s0xRshUWCVGitxe0KVWJ4ciIXmISgZ/Sncik69yiGU?=
 =?iso-8859-1?Q?RvArN9+EbxXRfWYaviQD+IiJYqYQF85hRct2UIuJxu0GlIiIfK3YkL95hS?=
 =?iso-8859-1?Q?+XyHf7yA2aiXvcvEDqB+uT8xeq5EubVxqqQOUxRJgWUDq4jisyrPVaFNUd?=
 =?iso-8859-1?Q?Xmz5SyYTKyGpJnwMAezu76/QwDjPesHc4iZyAIQhaGFpU/K/41D1M2VSmL?=
 =?iso-8859-1?Q?bvLavhqQ5zVIg4OUaUG2glpSQVjpICI77FAhaPnhR04izgjSstVYR69H/a?=
 =?iso-8859-1?Q?s57DkSmJ5CLBBe2xVzuAhX6d4YYCTn4U9crw8uhtPOQ1D6//sj6IURg0I4?=
 =?iso-8859-1?Q?406bhXzDULcx24Sy9mFLD4M9K7qhIOZ/4X2KOSwDoVgf6hIrF8UvCPY7B1?=
 =?iso-8859-1?Q?KuMoZdrrEfmCqtQIAKHIKY1yE40jk9mEZui3VwaSmlWMd3UDupu1EIDEFE?=
 =?iso-8859-1?Q?yio5mHgqHyZOxYm5Vmg=3D?=
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
	WymowoUndpBfylcqOWwblprq3mLF70VzfWrAJrNw60dKSwjW1hJuPELS6IdLAPps7EqsVQHmyeKUhhW+ewtROVR07erSh2Qly7JniVnfF5XeGxm8jR3ReJgjDqWe490jIVROFzDWQ4nmgHl1NAr/7pAQw7mvUYZTyxGQgYLxwOUwQL/cPxFc6WR8Vu5iUAMr1Jo7Pvo0quWCHhI1IO9mDxAe1lMNHofJHnE727oxsU1H5wJTdC9mfIRDmOqy6s73dV00hjR1VMpAsJDInB+hZzsz9ycXrCq27NiAjAll3KYrtCHCIvT4Ku9Bwthr5CZik3YoL9jK6faMz9fghBydADdc3BUxn1y44QGrgXLnpIhPegNaZJcoYMOv/0c7btLM/TQE0m38KZQgXqMwCQroDCVMJltWiEp7rrYc1mNcdHHLkXbuDb38N9/33tw96uVHWn6pGkfdbKr1DDfapDlFAw9AcinBY3V/0zxzXUlLFxNVpnflAz+ZdFDrD6NjpcHiiW9mmUtEE+TnbJke9qIzq3UatUsaXaq2kX1Jh4Z9OIFM5nyrkDWJE2CcxBGOBiUpUyfgPSfJPh9EsyjlDovkSNBbI9ITxDRdHkGQvXKEepR+Tq09wJs/wTz8NgRgeCLY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c88a3-7bc8-4f72-c640-08ddaa7f1778
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 13:34:58.7299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50NdxDtqKc7dfJvVX/Ulcp3GbpufEdoRbpbboF2M3nx2zN/kcEBkZUypMt1D2Fzz6Txhe2IozLthMvaYlYXLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7806
X-Authority-Analysis: v=2.4 cv=RqbFLDmK c=1 sm=1 tr=0 ts=684c290a cx=c_pps a=mXgwq54muOGq2at7RaFGHw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=FSW8YWyIMyRQisVipCEA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: X6YDEtcMfbUbKO0OQ-q0uqsSEh3QL-H9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA5OSBTYWx0ZWRfX1a/HueZ2/6uF DGfmVEyz3Z5oNLIOdsoH+Ep94/Zql7/6OEIjD2Be5g0rp7PQvbCy18yE2fQe7F2boiT4+pD44xq xVCn4KlWDG5ZIH3DANweEEB9Iw7Q8FF290teELI53Z5z0JIV6YzXoW38yCrCXv1hAEjk3f1t1sb
 HuLLEnPukEs2goK43HQFb5s8WgfrovLUhy6RxwUlsRwUIRf+e0XC8yGaQT91y7pcGzoSBW6/Xxo UNqYhf8wt6OJhjHmQCHNwsI1TKquABs5RFCpRK4Vm4Q3cIVmH+O/ibMop+7oCqjHxlM7AZNs8/Q 9PksNlXVr8SRk6DWjLh3ICaGNru5c42ST8UZQ0z8qjv+mF0BNq8MzUXJhB9Ep6noiciLwlAjPEn
 VLu8QfQUaNFprZ+I+BjAy0uAeCWFiLhftB/X3w5+TDFqtYtSNVih4TSBsU2Lzdklcnwxbh0p
X-Proofpoint-GUID: X6YDEtcMfbUbKO0OQ-q0uqsSEh3QL-H9
X-Sony-Outbound-GUID: X6YDEtcMfbUbKO0OQ-q0uqsSEh3QL-H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01

> > > Although we can add as many as possible _require_* checks to a test c=
ase, but=0A=
> > > more _require_* take more time to run. So I think we'd better to add =
"missed"=0A=
> > > _require_* for specific test failure on someone fs, not only "I revie=
wed the=0A=
> > > code, so I feel all of these are needed"=0A=
> >=0A=
> > Do you mean we should check these requirements only for some specific f=
s?=0A=
> > Like this.=0A=
> >=0A=
> > if [ "${FSTYP}" =3D=3D "exfat" ]; then=0A=
> >       _require_hardlinks=0A=
> >       _require_symlinks=0A=
> >       _require_chown=0A=
> >       _require_chmod=0A=
> >      _require_mknod=0A=
> > fi=0A=
> =0A=
> No, of course not :)=0A=
> =0A=
> I mean if one case *can* have 100 _require_ conditions in theory, we don'=
t need to=0A=
> write all 100 _require_ conditions.=0A=
=0A=
The optional _require_ condition is different on different file systems.=0A=
For exfat, this test fails with the following error, adding _require_chown=
=0A=
is enough, the others are optional.=0A=
=0A=
+vfstest.c: 110: hardlink_crossing_mounts - Operation not permitted - failu=
re: chown_r=0A=
+vfstest.c: 2418: run_test - Operation not permitted - failure: cross mount=
 hardlink=0A=
=0A=
I will update this patch to only add _require_chown. If someone in the futu=
re=0A=
finds that one filesystem supports chown but not others, he can create a ne=
w=0A=
patch for it.=
