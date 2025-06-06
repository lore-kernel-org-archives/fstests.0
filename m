Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F207FD
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177680; cv=fail; b=VvzDKc++2NTtiiRckXzUECjfiep6hzNz/CFPxCSl3R8pDoPqd1T8XlQNRN0/VqWJolYf3Z++9b+ubf5T4UOzQLJ/ok+tAuCiXvUWaVuuDL2g42BQFltXF5o1B3gTtx3pO5T5v3EgpDS2UoiepPRTOnnXbcAfL5UyZEd3HE+wdDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177680; c=relaxed/simple;
	bh=JvUNSpHNNpg0loPPvrnZQBRfnekmQP4fD1LiStZPSKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K18BQuHec8e5EwMyha1H8lRe8iCQOGgM2Aq11MPOLtlsIGCAarTgbGtoABaRt4WsIwU0rOAlB1JbCcpu0dYI3t1QKUntJwqsFhhitoj3nj41xI0Ic0IEteMBCNiL+IVuq5hGm2/bhYBSkQbE2/14YV1JTA0VeAZh3QgfI21/HuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=jMTC9kqS; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="jMTC9kqS"
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555NO4UZ026436;
	Fri, 6 Jun 2025 02:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=MCz33dU
	GdoseRB5GfekOHtKZ8pybZZ06dMjr82FxzWA=; b=jMTC9kqSmczqZVoWlYWzeO1
	+v8IVsCsXKIHU8Y2EiRakWOo3BiwUxlGNOzmatXZMgwFj8ohL9UAIdPhjEY9DoQq
	cS8Oc3Ud6X4ddxu/gXC6xUVEvQzccZQc0xwqgH6p5FEszfIy45JwUTO9RuSMJKix
	qEAEmz22FkKEQzq9PWIzOhU32oBuCKdjI4EA49VH0849n+SDPsBbfQ9CUG8obcUB
	FpI4VyrRSzT7s7qF2NlabVaPofg+aLFipiEbq/lPZ6ZmeOf2a/PovQYx+aGdp4UA
	91dxdIh/Wy3KAlzhbLrlEitCzJJfDbiLsivqFBC87vOAn8zCqlYH9a3MehqcsHA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012017.outbound.protection.outlook.com [52.101.126.17])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 471g8cunrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 02:41:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYtsjTx5QUutuf+hgKeSrALGE5Wcp6RvQH2wELrvMz10yq9+QHh2Hp5khg6KV/MCBGxHMVHV1UA2sRFnG2HlsNoLAnxmg2Z0p9RgVEp57iZow79gAwIdry+rDxcmI5qw/QVd8qUgrxhQSpI+Fe8hjd0vJ8jxATSz0aRn7wpsadVX+eYz+JTodvY2k8BZ/xYCbjwGrdDkunnV//7XlVxsBrGHl9vBMwbPH1De/+2poBkJ/JhCKG0cG3tZ+2qPxI7dg0nvyIOfKM/6gwBd8EyXF8NuRRMRydwfPa1pt5xfLzFxeNgUfEYXN87O9/whQJl+NuyE/GowyNm7bBXKwnhGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCz33dUGdoseRB5GfekOHtKZ8pybZZ06dMjr82FxzWA=;
 b=ApyQubi5gvvPKjHywMprx2vFnhS0wZlcEeWEKWa34L23Aghjkfo91C+uaLGaPblxu05pnIDmTvRs3XOp3KsHXEzvk9ZwY9riBTVixJxTjRrrTyrgL7uI6rNw8ABBHLczZx493Ot2JxmyNHl7d1mbuLY80w+NjVSB3rkLILxcFwN8Z8Sj0FsQsTYJ+1FVmy3JsBr3CfmnnjhX5cW98XXVcbrYnz5kXTMiDNOedp+6sASXfItbUNgcyQR0AXYDUiMmvo4M1z8tBsc8m897HRGVdVjxtMCn5yY4j6R5UHsYNxng+eQZRN+CAsJ7RuaieEwPHuTfjn2suHLvBzwoP5kUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SE2PPF97D601ABA.apcprd04.prod.outlook.com (2603:1096:108:1::620) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 02:40:57 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 02:40:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Zorro Lang <zlang@redhat.com>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
Thread-Topic: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
Thread-Index: AQHb1imSBfFwW9W2+0eg4U8nmBjKLbP1allL
Date: Fri, 6 Jun 2025 02:40:57 +0000
Message-ID:
 <PUZPR04MB6316F2B7B8CCE7386E6E7BE9816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
 <20250605145317.4gnj3phueo4bfxpq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20250605145317.4gnj3phueo4bfxpq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SE2PPF97D601ABA:EE_
x-ms-office365-filtering-correlation-id: cc1b6b37-9c50-4d7b-bb8f-08dda4a390e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LbcO8LG/0wMkFCRfUvls3UTEivWiPw/QMcztpW6AbFve6ZebJ+9SAa2ipD?=
 =?iso-8859-1?Q?yZPVJY66jnfvBGHbIHccaeI1bGt4a44E8DgHuU7YlXJWCWy9//S6ftgwzH?=
 =?iso-8859-1?Q?KhNXYWLK8XwX4At9IAbXpT2ZKo4wgZWM3o260xrPp/9DLm63FQFL+zgKpD?=
 =?iso-8859-1?Q?+kCeOxaIrGi6T+jI332BbWckxW/bJYOuCXASxwOocka9UIvq7tJHfz6WTM?=
 =?iso-8859-1?Q?rPGLjq5wluip/asbg8H0atTqNBrSVWC+Wwy0fqXtPMzEVN6zB4T8sbzYj8?=
 =?iso-8859-1?Q?WWTmTty9f/GxU5Fcw8LRnsInczDOHSz62K4nEQrOSGTh2wWGgQzN+re18z?=
 =?iso-8859-1?Q?oP5oAPi25usWWsMCTNrjDQ1nBG/gHU+pxD+R5OeH/mbDRKGihYTNE5WcdC?=
 =?iso-8859-1?Q?24phZbKXCREOE9TsLQcHgRdWyouFjovvXo4CWf581TzBP7+XXuNvoRY/du?=
 =?iso-8859-1?Q?6Zq3i1jA8fdXNOUM7uV1lPpLjTjBvDu2lqe/5+qb970cE3Kmcz/8o2Ac5i?=
 =?iso-8859-1?Q?9SJFaifDn+8c4lleKBXgVfkyaLS1yV+rXEijfluJ3gc+Hi97yYgwi8I8dC?=
 =?iso-8859-1?Q?4u6wKqmrL86bd80U2SMLxjUqHOUJbra4hVk2A9Y5DJMap3kWFqp9AK7gk0?=
 =?iso-8859-1?Q?Z6IfbC2lvRmqKLiKalOv27WzPgLMhkR0kALRkMnSegRujMjTy7bOeUgxSY?=
 =?iso-8859-1?Q?JmFMlpGcDfaQHA6xDqzn6PNPHV8KsPdeK8ftPxafrcAC8hUq6ywlEC3Ct+?=
 =?iso-8859-1?Q?2UeKfgIBD3ZN84c2EPadPkwy6592lEbc68z8YQ8NGNOFHSenoAs6O3U9DO?=
 =?iso-8859-1?Q?n6SwiePBZ4Oj5wkPYXtTnBBVutK3BLxuLMUnBcd+PR3zNzdQB0q9BBw9v+?=
 =?iso-8859-1?Q?44gRXINmgiIKwmuz4SENIe1hqQU9zVshc+SimqDi5NsKtCLcbdSyqnlYJa?=
 =?iso-8859-1?Q?izOmqhmZazHkaGHwzGSJRVpnEVHEkcg+BqA6qPiDLJcykzaTm/0t+yIn4e?=
 =?iso-8859-1?Q?1jr6Ss/HSyQHnTzyFZaT0fJaVnQ2kKOImKJYUk4/fJmihXw09SbfuEgfsa?=
 =?iso-8859-1?Q?0XFQ3pT0UpV6sETwOQSycj2TmaiIrarTMHL3MLg2SjMIEI3pm4aovL7QX5?=
 =?iso-8859-1?Q?8JNXi2wAXzQlaBUgEsGTEmUvWLNVlmFteekiToYcqlsj7b1OwRauLYcfie?=
 =?iso-8859-1?Q?ue0h+MOkaYxS9c4ghCa4SgWwlbLYQihC/MaTBFUtZb6M8J/GSk+99MMqs5?=
 =?iso-8859-1?Q?FU118jSYeVtvPQ5rY7dJgMieivpGmCOB4w4/KAzPTlSoG1pLxAQ4fb9ANe?=
 =?iso-8859-1?Q?Crj6CnMbsMlTQ90mLLnRfxZaqxEgEtfaW+xMYtu8zF8qgWcJNpFLl3DZTw?=
 =?iso-8859-1?Q?u37DjZxR/ApscYnz3nX+iili4HhC4g6d3T1Gnsq/JngBjRpAI1pNmZlasV?=
 =?iso-8859-1?Q?Sx/4jSyrCoTs+pjlHxeZm11oI6y0jlrLMzDkoxnEUS+7qaVDZ+fHS/T25y?=
 =?iso-8859-1?Q?XQjvxqz2V69A0lCB4aveWCcPRDsVBah9kEjpfyuy4KB0dIwCxK2cdyGVaD?=
 =?iso-8859-1?Q?EwoJC4A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hgB8XOYX3C8pKSzFaXsGSq/iqQu/tfh853HmBI/1ekOkgpHvQM9lrDm9t4?=
 =?iso-8859-1?Q?9fSc9PEOx4YARhVmpYSvhYfyaq6uYAawdC6gSXpfoee08CFn6KjtzaL9ou?=
 =?iso-8859-1?Q?YsQ0h+T7UYtrhlszJQIFpEQpL83srnRqUVrW35E5REhOqgFJ/Ky4bL0NHo?=
 =?iso-8859-1?Q?KpF+EHq8qgPy4wKiVMdhOrmIoe7oZdVe11lAGibHmRcbTiucqz8iFX4FUs?=
 =?iso-8859-1?Q?Bg1ZnKXNn3lsXgJyz5RsJ5/rEXBB+j0zJ5HcocpkanHV7GgqJs3xVfkE/Y?=
 =?iso-8859-1?Q?Nv8jg+H+izt+6uRooj/FEEySQSa9dujCrcFm9sBcFddpEmw4VbeKjzmtMH?=
 =?iso-8859-1?Q?6eBuOPG3lX+mqmaoFxD6d0xwXUTG4q0EGKSz6UpyKwoAVtlJTpjtA3GR+2?=
 =?iso-8859-1?Q?V8qTTVAWU47x/8dwCCcmhCeFOYfkqhrpLqnY2P1HXlot9PeiPwtwGv1vdl?=
 =?iso-8859-1?Q?iwblbMp2bHPRdGVUEdmd22hLvnaTkH2dUsokhnGa2U6XTgAI1wOmUqCw9O?=
 =?iso-8859-1?Q?EFi9/gvaXikMvX+QNV95HdZb9Ztl5oeyYPfDsayaH27pp8Ue5xiz16/q04?=
 =?iso-8859-1?Q?3W/1kqrGIEfKhsRDnYDMC5viyEY240+k4IS+FmrZ3+Zb2CxZby8P1DsuQt?=
 =?iso-8859-1?Q?7UqSuvUMjHXTXkcd5s9WU4QVOAqf68EZapkgqfjQsFpJPDDSsDM5RYBR/O?=
 =?iso-8859-1?Q?5Q1lm0/ONd7O5IIO852FrTRx3fn7NXMnvyXPVHTCXGxlSH0fpZVWEXan+f?=
 =?iso-8859-1?Q?ctL68rjERsGB08C+ZPKR1Pl4cDinrK5Sit++tkuycjCH7Z8rzpPNfRoUjs?=
 =?iso-8859-1?Q?lmwvV0Xsbo8yioba9xwX9IaKRaZg7DRN6E77l09UhBces2ZPBEd/y2k2na?=
 =?iso-8859-1?Q?qHU3Zztj4I1ugffroU/Eor+VWmej10EZbZoDh9yKtoD3jzau+C6hbhPxYO?=
 =?iso-8859-1?Q?/5oI5CWDXovFWxDor+/JzZ+HqfbRLMuEOA7nsfTGEQyEiZvzFge1WhlRCi?=
 =?iso-8859-1?Q?vGuFTwZDuHCfAUQeMBBXybVZOu/I/V3vuR9W0wOyf0OqIiUhRzoQXeLMF1?=
 =?iso-8859-1?Q?gKfBGwnQrMCRy7qNoFBNNeTm06QhpYrL3TaDXTkRG6uPSAwFDlNgRygl9m?=
 =?iso-8859-1?Q?i/EKMrVChe1N07rHkq/+GfkXQVC/VWLBXtFBAn9b4dlvKcng+uKmOD5MEi?=
 =?iso-8859-1?Q?thqvMI6XXnCcmr4kIfWN77HeAh0Qf9PvKrARTbx+eX30x2+1sytux5g18M?=
 =?iso-8859-1?Q?c7vdUgZy3ZzN8dj+qh8PFWWFax0NfGR10rNHP326iruEDlzdvRyqFySinK?=
 =?iso-8859-1?Q?0D8FT50OAqIJe2/CD39jvQT6Qx8l4XUJqAq6YeE9JcJqGV3vVW/HLSQWcs?=
 =?iso-8859-1?Q?/1M+Y4Y/U9NYWJzYOe8gsuFk0cx2b9rzPyPT3Voq662xVXCMY3dCla9NPu?=
 =?iso-8859-1?Q?RXmclE2jqS6vvPWGhXn/cdNFwT37Oo4afZVFRVst8YBSBWUCgqVWB9dbQY?=
 =?iso-8859-1?Q?OakVQM4St1dW0xCToG87ZPqFAhax0U3aj8zUr2zLdD1VMtzJZ7GVzQUelx?=
 =?iso-8859-1?Q?vUlp5tXMPVQ4I1dx8F3WTKlCRzkU7gn4Kjhgd/PEzO+owL+a0ZpdRhKaUh?=
 =?iso-8859-1?Q?hEeVPNAgi3Py+NHl16sMksHuKy6RsK9G87UYDE2gTjm/D+Xq5HO0KPHX9H?=
 =?iso-8859-1?Q?tKdcFerN/8ykljO3WFE=3D?=
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
	qX6yU3dJ9AKCb03f+SEce1UKA6W5reGDmj3HY9++IVKcauiiM5m9Vg0kSqNmZUnn8fx6MdoEdGGr/zne07AB0Z23gRtCaj7CV2bzXbFVR19XTT03NTeUF/RZFxrsnoihwpvw3ZgoJ1iq75r1wJwDy0bpjoaWZFJWHYNfsDesa6LhFgX9iR2OKvPmPnPvnCjSsZVsqa5PbLjKvXdAzj3RBQ7LLaH+yFuDEgC6E9n8i5KkR+M/1JTy15+fRQZscykWVOHCtJkV58aqGmf3FD05NJ1PsFb8MfTNkjo1ke3sokNS/GN1NRyeegPg94TQSDy+Zc/7ho/MtGPZ96FuVcIdAqHg6T9RbZG+4YxnY+Z82BCH58922NV3UhWIB/Y+BlSLS0nfW1X7K5vMwNS4RxOTG3869VyL2lT/8tLxMvLphoHM78BfyGpnjorr3wNZejAR63Pey5IcLsL++BsDjRRLEzHybKPEV7xGoTaIb9rp+0eBGvE6COXqGOkIMobMvtQCMYas8+5dPHyKldCeW8I4yqafe+RaMw0OTndoUihgxlA8kdMy1Syuxre2G/qiUXqovt+j2AfUPe2SYTkmC9eYmGLy7d2mjoke57Uauz3pZzXr87Z9B0Mp17OXeMYYEznj
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1b6b37-9c50-4d7b-bb8f-08dda4a390e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 02:40:57.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pqh62mkqbOYywLYDxymp4yhkXgk/XUXKQzVbDUd/M9vA30iYOq0ziCeHSsE23H8uf7v9vsZnd1qDgf7GtPSaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF97D601ABA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAyNCBTYWx0ZWRfXxy4EQKDBKXD4 DFjic2W9qLharaFNJpCxsDUVKR0XR/C6G1QRGZylSio5pJbkdJI8msgJ210ZZmm1pTzANgi0a7D eKi9/aKZRUOurXyi3RiD52a51y4omvjO1BP0yjq9BxSvNM29jcEwpL+9XkwuKzNyXWmCIiLD2li
 cD8sWCNG+E4nl2bz53WUuerzLdFidbY5uZStZaVZapgO0ObAikbTQ2W86rNINTMwKlyKpv28g+8 BQW8Vp/rMB0//4CG6Pl5AZtbPhIFl1PjbyKbX36u7ejBBzH49Mvfjjs8R/4KDDuJ1NzMUsTEvOS PieNesOqt3ITftJ8NaL6dcl5hgf/NGAhdlQp0G5cm55e//Ox+kviunn8Tq0831yVh2QzpgpaXGT
 M7A+JDHyJCSmOJ6OPD8utyesd2h0yhuHpHG1R3ThyDJqM+7tVp1FtEL40g7Fzviw+aSI//ZR
X-Proofpoint-ORIG-GUID: R0L-V0M9f7XYUGU9Xwfz4CXfSUsqyU7I
X-Proofpoint-GUID: R0L-V0M9f7XYUGU9Xwfz4CXfSUsqyU7I
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68425544 cx=c_pps a=oW/Zecbc9WC3j1qKqTZ4qw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=xBDvjNUknFaGNFD1uekA:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: R0L-V0M9f7XYUGU9Xwfz4CXfSUsqyU7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01

> >  _require_block_device $TEST_DEV=0A=
> >  _require_scsi_debug=0A=
> > +_require_scratch_shutdown=0A=
> =0A=
> Hmm... although this test case really does "shutdown", but this _require_=
scratch_shutdown=0A=
> looks weird, due to the g/730 doesn't has _require_scratch, that means th=
ere might be not=0A=
> SCRATCH_DEV. So...(see below)=0A=
> =0A=
> >=0A=
> >  size=3D$(_small_fs_size_mb 256)=0A=
> >  SCSI_DEBUG_DEV=3D`_get_scsi_debug_dev 512 512 0 $size`=0A=
> =0A=
> ... how about=0A=
> =0A=
> diff --git a/tests/generic/730 b/tests/generic/730=0A=
> index 6251980e..6b5d3196 100755=0A=
> --- a/tests/generic/730=0A=
> +++ b/tests/generic/730=0A=
> @@ -29,6 +29,7 @@ _require_scsi_debug=0A=
>  size=3D$(_small_fs_size_mb 256)=0A=
>  SCSI_DEBUG_DEV=3D`_get_scsi_debug_dev 512 512 0 $size`=0A=
>  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug de=
vice"=0A=
> +SCRATCH_DEV=3D$SCSI_DEBUG_DEV _require_scratch_shutdown=0A=
>  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full=0A=
=0A=
I agree, I will update this patch.=
