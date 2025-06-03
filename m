Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D5A944
	for <fstests@vger.kernel.org>; Tue,  3 Jun 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918135; cv=fail; b=twQFjX9Tu/1Gz3DlthgUk5mWqsjI9qC7MfIh5v/yB/Zlhm1OQTPiUcNyAT1SoLRQcuAD7gQNZrTXWccQskYkaO8WL0Mnhc4i7XaqGlMnYHCQHEK0ZIJEScS0QSO9rhnzJM56ATFdumaQ548YzDkNtZp574HpiUYzX0EV0O2uYeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918135; c=relaxed/simple;
	bh=wo+P/sTsRhnbui4608EJvmD7azfL05KvnJyhLtveFVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oM4Qq/Inu4buYMo6oIxeknjUbQQPnipO1oxxqxvoiaEVtGHIqvU/l0ekYIZtCDr+3ooizei32vUAVBR0gbCZP5Vz4e/oQBrKwKcisFqF95PYLS5vc28YoafWS4sKJzjwzLeZy1Io6tnIAdba+pyfF8LoQ1SpZvX4vA8G+qRq4lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CRgZq2Nj; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CRgZq2Nj"
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5532W5uN004515;
	Tue, 3 Jun 2025 02:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=5eOgL8f
	lCcZs5hNyqqMNFRT2MEBpWQfMv09BQcsCo3o=; b=CRgZq2NjBv9v3Wxl7dAbWkY
	XfES/vVMlTt9wXUIqMQWJKBTMxYsKTTIZsxm8Ax/JWwcYXhq93c1w+gcZHiNHahH
	QAg230d6t5roRIXUsc7LWQrAPwJR5rs6X+YE/W0tdrj+RBzGdF73/b2vmCKRuAOF
	ObroijIqaZOqA3BoCy9P0m5T+MZEoqXf6KWBWuSeHGn0GZHMSBlAyrlGOa6x+f3O
	QNl3EJWOVI35tH9/7YssW0NXeA3zjVH39koVXpZYvnkxjc0zWBF84m4zIrQ7UrNl
	ZQ77c/ynutM55opVkUfNl8drMqeWXBjBph6OTp5EkLtiOTROgiCfThXwyq/nfig=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013066.outbound.protection.outlook.com [52.101.127.66])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 471g8mgc2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 02:35:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqCniP06RnqMD1dMQkb0uHtSjjUI1Wrh37v3XSykuZJIsHYV/ILTqblYiB9BN7NBvl7tEfaxLfyGfT6IJqhDzkB98mMa9ajUctyCQjyfiVNdNEO6HxnVb+zPpEBnGMKsXwHl61fe2Nms1El/mTQfU55gWJWNYYaphmrHZYH2kPyJbxYQzUnKv1583uRQLBOY3g7pGGwYNDUXR4l3iqrtHVWa3qJ6UqA/M+M84HhGMGGhDLrGx883hcLgHVP+cAcNy6O9Ph12TvhXBUs+Be7zSbkjWZZYlow4CNRBCrbRah4gw/rWHkRfNL3C9BbjyXbIHJ8AUZXf8WG9O/1qNHIPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eOgL8flCcZs5hNyqqMNFRT2MEBpWQfMv09BQcsCo3o=;
 b=Tas52RWbZZQtCYoZx8HoWAGG8uIlG7VD5+DplOxaTZk/kX1xahOJBwg4HYFGpdzOibxd1G8dhiOWfcNDuqthuZ3wvSg+igY93RPnP+TrzNzlP7JFJGTsDwkYvOS6s9rGVbxS3SDsop0iaZkAZZG4DzdImF0UvWJKzyUq553fRi/MRtc6N0ODl0sQvWmpbOjWa01mvR6bUs52OLrNgUz8yDIkDSuchIIy2p51kKn6aIT1W81y3pUdWK+bDAxT0mCMFD41No1LsAiELOErpdolMhyafoq1hBgfN9ek+69tyZUzX8FFS/4EwO4FY5Ycaz3t9vkzJpyHApkBtJe6QVPsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OSQPR04MB8906.apcprd04.prod.outlook.com (2603:1096:604:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 02:35:05 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 02:35:04 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 0/7] add test requirements
Thread-Topic: [PATCH v1 0/7] add test requirements
Thread-Index: AQHbz7/bZDNWPayv/UuenYc/K3KYVLPpEgungAZQzICAAVqQxw==
Date: Tue, 3 Jun 2025 02:35:04 +0000
Message-ID:
 <PUZPR04MB631648D55D06ADFEF408ABA9816DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <aDbs_Fr-8CVCxdxy@infradead.org>
 <PUZPR04MB63163EFBDDF33FFC83B863008166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aD0514qLBX-MSazZ@infradead.org>
In-Reply-To: <aD0514qLBX-MSazZ@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OSQPR04MB8906:EE_
x-ms-office365-filtering-correlation-id: 6def1a3f-9c0c-4ccc-ef7a-08dda2473f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?T3NAvl4cOGqv1NkmZcy5WW2OChzDvhSvIOWBS+mZBWn6NmnSF2x23Kh98w?=
 =?iso-8859-1?Q?4DkiQt7diXPL99Yc9fZQtkH1y1p2miie3FgmzzSHkKnUfaUgH3q9oxO8PA?=
 =?iso-8859-1?Q?9PL1m/sBR0hDShKWlm0rGs8GoZXWLxxw6J3zE4bILopEosQvcqZk7FPWS4?=
 =?iso-8859-1?Q?pvqSd+l0cB8UOlUv62S1zfYlkXNzegGtyWAHWKAYfcH5G03v+i5rxtzNuE?=
 =?iso-8859-1?Q?MoAGYgBRHWHO6vorTdlnmYbdFnKV20AFp90h4nB3HpnHZSxWbzm+LfquaA?=
 =?iso-8859-1?Q?F32T09bT5cJkTA+ciG2TGIMESB6e1FQfinqvyFRgdO928HmLxbK2F0Lh/I?=
 =?iso-8859-1?Q?bD3yFvryDC6QtLBWOcUI+0y7tI0t5hqKpRs89SBcb7S7LMwwVpBu7wXio3?=
 =?iso-8859-1?Q?HHXWH5Drj7HYG1AgRN6vGyOVWzU9FRU6yAnm07LXgiAke5jzGUn8lPnrNY?=
 =?iso-8859-1?Q?8uINPKBBinhRX7V6Thlc5SvrMZsmN10tF+8Eu44j0xoiAlfoVIBmRqLBit?=
 =?iso-8859-1?Q?O8UpDjzureAbBeMJZNU3xhsXM16Q/Aks3Lk7Q87L3UM3ze0LJ2H4hHiUhp?=
 =?iso-8859-1?Q?jo9uGxEDlOD+TVqgoaYTAWEwOpRelmR5r+sdDwg6AJ8sVMcB+/SVDXdb78?=
 =?iso-8859-1?Q?c+QrvPqHf9XBr8ds1kc0AJMqYQ8qQTK0NihKZszyP3s99AUR7znfPXzAjv?=
 =?iso-8859-1?Q?gV/Mcvyc0vmbNwR9pvxwxwoqQIhqtIDoTJRuUpUgI1kadqYKqe9M4umLFR?=
 =?iso-8859-1?Q?dcQXOi6gatVLuykDZmLrqTfoRfXzweVYnW9KBBIR1L3F6H4q7x+VmUGN7+?=
 =?iso-8859-1?Q?dkdJO0qSZJXNDva3Laut3LqecAc6IRLEWPuJq+64EPFv7ODS74tEEi+zfQ?=
 =?iso-8859-1?Q?clzIeb0UplECf7ad5VgdDBFgvQOQYoxfjQTtbWbMlpdV+/3I6qxa0rHucO?=
 =?iso-8859-1?Q?mE9FNtPvE4X/8+MFimSSgT7agC3VYwH6k3iH2up+DBg7SG+fXLl+gthewi?=
 =?iso-8859-1?Q?z5e8oNCj7HQJ4WNhTfsfPlNgHTiGHmNEttA1nK5yAbisk4ujQ+dwmGjAZt?=
 =?iso-8859-1?Q?HlZHmYWnwoAK75l17E7awD5hiHcw+mrwLGwBPPaCGZrsbwOPyY+WIsIWxX?=
 =?iso-8859-1?Q?2n7KoJ1C+FRAtISGb63tO8NdoLHaIZ6lIpoBl7jN3b0A7WVpsFB9ghmSrx?=
 =?iso-8859-1?Q?TOyby9xehg9J2lmR2HdNtJMB5k74PEuAeJxN9Kb4vgXgEWYN95vm+/y3y+?=
 =?iso-8859-1?Q?no8/pkdT8EMTArEjwhrB+qlnwNDjw5AS0vDtcTOs/4xrIHHNXp5+KeUQca?=
 =?iso-8859-1?Q?58pN3l6qIwmG30BDmUGQXm9Zt9AhJvcW+MdVX1pxImpTiMp7Y7cWcfmoAl?=
 =?iso-8859-1?Q?CtkMhV61GyG0keud+HbXRRchaWtk57E8FX3CvvKDVHklXU9KJ3z7jOGivp?=
 =?iso-8859-1?Q?BfmRziyuL40dz1lT+d6dlYh3aVcSwFSSDdzO6pwnEfFgKU/ZTGtNwc6zRM?=
 =?iso-8859-1?Q?kJB9QDv7QbnDVBsOH9/eHM/BM2wCRudDlKyChtuNLUM+kIl2EO0sOXS7vV?=
 =?iso-8859-1?Q?Fz67HZk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZsKjqmf9sSeSuplV8C9WeU/w68/xpI3LwaHSJUFt06XeH7/l9KnNetYLUV?=
 =?iso-8859-1?Q?Pyt5uFIHxs92n5KiVGT2HJ/0Kbss1rJZ0Nu5os3RdKuEd4fmZMh4ycWpuq?=
 =?iso-8859-1?Q?jwxHLnImO4rVKM2jc+ECl52wQ2Eq3f0UXX7y9As2OeYq8Pk7USYmdYKUDT?=
 =?iso-8859-1?Q?ZZB93F8B0KW//kK9x11kMk/HXbqEV8KNHnN56bNiWNBnB/Pw+guy0hw4Ta?=
 =?iso-8859-1?Q?hBYlG3hd5c70riq7OVxBQxYl1qhIWb0IyJIhN8rDgynjU+QPMBkf6uuOxQ?=
 =?iso-8859-1?Q?Eb6wnh/tWziu5zssT29bX5anQe1cvX8zHZXEupnhmf0p7aDXIZ2lQsybXg?=
 =?iso-8859-1?Q?pCffLzMFtiKNH2/WLllx83M5g5fCp+FEx64p+FDXKx9jsWAA45BfBKLMmk?=
 =?iso-8859-1?Q?ZYYS2aqmPjkfVtu3/E+83AsFA9692wtYLoGZL5hvdtWLvZ09xQ4r6TETTp?=
 =?iso-8859-1?Q?yHq1Jm1lS1+724JAkuVpz9VsvCMQS/LrTq0ry1J0Nsa7p1kfgpqBYaC5qa?=
 =?iso-8859-1?Q?BYZSffEUCGGmDJQ+NfCCJLM/U940Cp2zNkXirKRWC9wucae+3BWOj5oCbv?=
 =?iso-8859-1?Q?VpUV6QNzKzKrNA/H89Q0NYTDXNoaISHgQK631vC6wpCY2r/9+Wf9z/o65o?=
 =?iso-8859-1?Q?X70GiL26S4shG1WCOKiE1m8TGH7pIsHuZSdevhko/cJFPz/Vqry1GZPq5R?=
 =?iso-8859-1?Q?z9q1Fnxbw6bEJTXk7VkKxii8XZU0fCCSQZV0CSMLRiIjGiIGdHXZgorQAw?=
 =?iso-8859-1?Q?AlKkqqUHp0zdGx0jXDgP90LZRyQgM1H4h4ISpZG8Th/dZxGD3zOgKiL1XK?=
 =?iso-8859-1?Q?32WOJa57fL0f6xLJMVRkDc78BpLBp9/6a3heQqLA27c8RRrHPIPBieIq9F?=
 =?iso-8859-1?Q?jDgunoaGuiCX1FBOPEW8kMX9gOmxWmcIW2rV1RC+wxSq0w29z+7Vi4SJfB?=
 =?iso-8859-1?Q?HFZCjBXbgTzKPG+jPTkVzKGJH6tPKGkrJxNnsn7howcmVdnI2URZE915oN?=
 =?iso-8859-1?Q?ZcNBVZX2zcPP04FCMGE59d0rwu3JlcMlE1gRV62L89qln3SoILmKrCjSUK?=
 =?iso-8859-1?Q?sT4OxqtIw/8NJVsblLG9GDJEiNKpDu6S8zf6b1ZnC6/oUA/BmIL6CUNjBz?=
 =?iso-8859-1?Q?jAfooDdlUj6kAXZEk9hdclGjM9pufFZLjTb/sInaPkOH/gmTs12yHkf9Un?=
 =?iso-8859-1?Q?UmYX3r1xWueeXYVfzY/L7BPFoBiZzHG4bDMslsKZYuDfG1dsUdNhCXKiTu?=
 =?iso-8859-1?Q?EtHj+Lj5PMbXkxPooj94/4LeffrxqjiU7kgSpi4zBoYANQrLvH+0YFRADB?=
 =?iso-8859-1?Q?NOknrCy3xa8gbToi756F10jGlfEh6Nmnu+uIciOgfk38nqZ6X3FXJtKanl?=
 =?iso-8859-1?Q?lVWr7C/MixAS6s/OTDuTlH3eNCadP3feTzuViZCqQIMAJwbOnpQkJLfOet?=
 =?iso-8859-1?Q?w5VUxSu2aM07R7cFcAMWYFVuV9/772bUQXHDqsJoiT/+QYRovAv8RGHdpS?=
 =?iso-8859-1?Q?PflKWvwFa8y4haS6KMecHoqExCa9vKkwxF94NrL6RGqnUuKwMc0Kt24Zec?=
 =?iso-8859-1?Q?ksuqXttrMabzJoS6rHyGMhkRiV6zlGoc3HK6cLtVc4DOuuU6ZgmYTdg5KS?=
 =?iso-8859-1?Q?u+G2ceiYD3d5HlUoWEr6cDklRQ/sv0qWoNgU4y3OaSPvAdX601eIgRJE5V?=
 =?iso-8859-1?Q?RWzYhMFDAhNaNDhUPbo=3D?=
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
	Hb8gO6YaLN674J8Be2DJuqnzWwSd8VNbRjJqtlsF4o9+0iCy8Xhfa1SGhdvCs5lAIogLpvE1SwalcFaADuJxVKz4u/5Qa6FRuVogC7FGIHq+L9ANxizbgft/T2v4bDov8jlnfOZORNbvMztGfarAmv9MQPoS2Lxb+kvPbhg7X6l0VDUsCuHKoliBgSR95bCJX6sHYY7DXCvPE9gba4IEHU18T1jkQb833bAXNEBrNULBNG1mVNezRlZvBeujE0YHQQU3D9GjEQdzSHf5C59wlHJxImwSSBxZYrQbgsJVziHBvaYglvpzXKjJRCHCHnBvFOVRaL3jLg4C++cYapLrF0hBV9cbCpNwMSmz86rHoNVddeVVRFuXi7I+4gnhjNKW7kraCdFkI9z4ZzXOpSimIrDuVKuextBnHjKaF/IMFjkRGNAh8RiJel0budnc3opa+p0nQPHqwWW8cFwrJlT2EOYLbhvM8r6o1eaVDVjWXcIouEhozc5rkka7Lu57W6SU2hm7ZqiUSW+vFOi8d8lLojcKQ0fTDeSV5AB/56IniW+21PMSlbQAclFpMI8Ii8tJD0cWfTLVoS9164/8URNplU8ZpHol+i6NQw+DlMiRL8awNM0du2YVAltDxEDrcvmk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6def1a3f-9c0c-4ccc-ef7a-08dda2473f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 02:35:04.2184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbiNcVLfdm9qA/kxuhH8uK6z5GERLDmUwnYdw3Ra3S2YY3IyPaZ4SwQtqTJnkmFYrihvVfwZyM9tZ2R0twyfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8906
X-Proofpoint-GUID: P6HGZzfRgm8k0dcOymatidMa73KNIUUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAyMSBTYWx0ZWRfX+Bc0iRyFf/JZ hPh1IVP85ffe/RLkCEosyLXXQehUNiXUYndP1K4nU2jNr5XMwNvRGl3hiUOwiUnKyRdhq90gkoJ 8BQeZJwpibBJOKaAIMgnaMHHpbMaNXUZ9J2J5j8pCsjqqlx645KqsRyNe4vTTUdrhiw/v+fVKgN
 E5lR4/XCFVZzKchESbbOQVQgbsjFPBCCFucb6d5jIoCj+XCuF+gMM7HrBXFWpLzlZ3wqISDz8ES VOFrDB7cvPi9qyWXQRJVEdetn8TEiuO81Bt+zbsiRZV/psV+xy/e1twflrhZMfXc/d3gks8+L43 zoqsPJkOjGrOToR4E0k2nQMuMjqmTXSRimRHtrMEkOouscP+H08wpvn4hPzKBU/2LSgchcmvgrz
 gyjR3mTkVfszmgQakhyBgKoWnx6IqHKVbnVDL0kxEIQ6Tq1WzCw3hPXx77a9qISS57wc8nLj
X-Authority-Analysis: v=2.4 cv=HqR2G1TS c=1 sm=1 tr=0 ts=683e5f61 cx=c_pps a=lMSCfu5fxLXSfn69tsELkA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=kitxSwxZE8H2P15wUQIA:9 a=wPNLvfGTeEIA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: P6HGZzfRgm8k0dcOymatidMa73KNIUUv
X-Sony-Outbound-GUID: P6HGZzfRgm8k0dcOymatidMa73KNIUUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_08,2025-06-02_01,2025-03-28_01

> On Thu, May 29, 2025 at 05:43:48AM +0000, Yuezhang.Mo@sony.com wrote:=0A=
> > For filesystems that do not support the features(symlink, hardlink, acc=
ess=0A=
> > permissions, etc), such as exfat, these tests will always fail and ther=
e is no=0A=
> > need to run them.=0A=
> =0A=
> So this is for exfat?  What do the results look like with this patchset?=
=0A=
=0A=
Yes, this patch set also for other file systems like exfat which do not sup=
port the=0A=
above features.=0A=
=0A=
With this patch set, these test cases will be skipped as "Not Run".=
