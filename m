Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC320103A
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747961951; cv=fail; b=D6UIhVg8EAd+QHqf8937ZT+ZpScvjdn+MWeT2ZJOCtghngdi3N74mLBm6lKAVcWHLiwg6MySlIPrfComxAQgC33YQGiGV+esV55McGmHLS5xtNZ3XMGTqR381CP+VRxPxo9pUen4P5vuLPKO9ppLOBkgM7iD3OPwYego15dwiLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747961951; c=relaxed/simple;
	bh=dWCkLAbkb5X0qAzj2AONk4ZM7wBl2wMKUWDGy9O1USI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b435qI2W6LNrqlYLI24uxk/OUidYC79sB/RxbAQmldc4knzU1w8iFPVPz6FeRludoY3TTPur9yLBCAIljZB99LRAHu+WboRln8N776EbDgvWqEoaqWwUsgaLmjyw4EcHBCskkK7gYN73e9dbfglZMgCzzCwJ1gqFlnjqCJ8q6Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CVygxk5z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aX2q2NXn; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CVygxk5z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aX2q2NXn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747961950; x=1779497950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dWCkLAbkb5X0qAzj2AONk4ZM7wBl2wMKUWDGy9O1USI=;
  b=CVygxk5zW4I6VCC99MjVCOg7etggS768WE4Mdd9G+y+aVfbxMQ9Cw5Uc
   mivZ06NCZuOM14vXS/d52krMta/7bEGNfDlbF8WoqawB6ArtMOqjfWXC8
   k5n3MBzYQlivY0mtY2N2A5oo/tvh3vwcSnz++ihnXyWIM1RRAWIqmw4gy
   wG3wlAShu9ET7PmzSH3ioD8QVUaV2xNU7BGc3paSHE1ycHLJLxf3JEbRT
   IfeRwIsclS6+8JVy9zl5eT5yCr2Ad+ywrOSt3CffF4Wg6VH4BmQ0xjqu1
   /l1hBrc3/eAPJ6brWBXOnOu5csnfD2NuR6kcMNyjeOpFZ5T1TvV/lRWpB
   g==;
X-CSE-ConnectionGUID: V9319euYSaOIoBGRYvab/w==
X-CSE-MsgGUID: dj7oM4g6RnyFeSSnFvuQ0w==
X-IronPort-AV: E=Sophos;i="6.15,307,1739808000"; 
   d="scan'208";a="83619156"
Received: from mail-westusazon11013015.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([52.101.44.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2025 08:59:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYjKdU1Xf4r1bTmoZELl3R8r4oHbl71GFtlYNjJrgbzx+xqboS5lrkqmy4piWOnzFkL0/nBayf72wiIVsU8B3Ur2dzVMIPmUaWpUceMaRBbr/siH5v5meWegQ3N+Mmuyr5mexFsULlFpdgRoETYUi46xxKOTXTpVC/yA7KTjClsY7BpdWp4dCj3YG90AEy5tJyZj5vCa4u0trFvI/AJRqfOUrocj7x9ULOC4crT2iZ7IbA0Q//UbfFeeuJwFNfrcLT5ZBmPyFTSstlwackszVpvIUS3eXpPGruDGap8LDZBHwRIJTaTfSxu5fMggOGSK63cx1IKujPo7dfoZR26U1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOTBEUFRRjMXdyW3Uy1YsuMf8R3w0CD6nSFrU7nD3TE=;
 b=WtsbyEH+R7aIXnSpgdISlLKPJzdvvLkoJ2jlF3bXG6UqmlT55tWoiYIsJMkQvb+W5m/hJg1KnxebRJ1GW5oagn2JlgrK5Z6fC3utqCxpZDrskeiHipaWvSJWzEOjy5FZARAf80UcGXlC1Teonqj6OCWjTn5np1587bitPEirOH0g+H4l9nPuA56jVxsW5sRevNtCvn2TDMEQTgaSoqDBQ29TgkOYdzb/6oJc3fe5YSbwEoZViCFx5zya+Ua2EEBxm0shOn4TuVnMIIVEdV4K/dPrcKTKusnu0x3zYGV1y9VH5Wht6ffzZsTHW/HT5LDGUv6B4QldyYZ0MKOdvQ/MBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOTBEUFRRjMXdyW3Uy1YsuMf8R3w0CD6nSFrU7nD3TE=;
 b=aX2q2NXniLBDi+GxGNtQx8QMaG1eWC7ngyInVWke6Mf/yKIjl27PvBo3Ox7mM5jaJ7DjEe9Wcm3YupCE5nuNzhbWIRDMXqBxjI9vMHBNcT0bB8qchPdJ63K/rMrbRHNpCUlIx3MZxEiNQqKfxPDg4dzwNgDhCqYks7Ll/MUxp+Q=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6558.namprd04.prod.outlook.com (2603:10b6:5:1b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Fri, 23 May
 2025 00:59:01 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8746.035; Fri, 23 May 2025
 00:59:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "hch@infradead.org" <hch@infradead.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
Subject: Re: xfs/566 execution time
Thread-Topic: xfs/566 execution time
Thread-Index: AQHbyZC+Gs7KaBMRrE6eXuouWRW7RrPcaz4AgABpqwCAAN0tgIABtoSA
Date: Fri, 23 May 2025 00:59:00 +0000
Message-ID: <yflmdvih2566sh4db74psbmwyryme5gubn4kap5rsqmb7uatbn@zp5rjfyqwzri>
References: <aCyM-p06c99rJ04g@infradead.org>
 <20250521031940.GF9730@frogsfrogsfrogs>
 <b7vls4sjlx556wax6uagfkey6y5u2t652qu5ne2a6sxpofowdt@3annzxxqdmwq>
 <20250521224929.GA3203850@frogsfrogsfrogs>
In-Reply-To: <20250521224929.GA3203850@frogsfrogsfrogs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6558:EE_
x-ms-office365-filtering-correlation-id: c59e3d61-39ca-41c9-6eb9-08dd9995014e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v05UySNq8ZLEejuuB0aFmt1B+MRtKaDGQZ3ojUEz2dGEGIfKEXjvUHpqIdUL?=
 =?us-ascii?Q?JMiKveLAXSQU36zM2HGnCfSjd1VGfNfsISxwPMh533TCXu2wlxXRyEpbSmTt?=
 =?us-ascii?Q?q9U/P/VTcHJV/g0/rJufyJkWNXuRQrzVnnfcmHXmcoIT1PaYCDzPZ357GwF7?=
 =?us-ascii?Q?IrLYk1J7aUvzQn13SgkM6NAtDG3ZtqZKp5eGO8CBhTWsBTzGNjcPUOf+lDcd?=
 =?us-ascii?Q?1fPR7fnLm+HQGX2rrWwBe9hxqN6pwO6WezcRsD6F5adYdHu2oL6xZSnHzogD?=
 =?us-ascii?Q?TJwNG8xSL5SOcyv42tnOcgYGFwGXSu+WwRwAHSnOhZ0O9r/yCWzKqbLh2JXE?=
 =?us-ascii?Q?tE3BxMYGTytaPt6HMsqUoDwCpGOpjEjnv3UmRbHfRG+FZIUwWUuaIE3KyB78?=
 =?us-ascii?Q?mWQrbdpl5AwbW+Qc1J1ujszT10mr2SRO3C1z9DSO0sSaNnDS7gvB1hQ4Xl8b?=
 =?us-ascii?Q?eFqDEFDXD0UCGVG8NWfOV86BCaWX9BFJLc+z9U/QWkU4G+d2zptR3cNyPEaQ?=
 =?us-ascii?Q?w7dypQkvBabQbD37Z/kym5NwXB8Yrenlf83Rmdsaa5ocyXMoeDeg73ik8qf0?=
 =?us-ascii?Q?i06tgXf4CjUnNA4tpfwmixEioYql9/SkKWP65K/GUCif5bqMUTtlqo5aAiGL?=
 =?us-ascii?Q?3eJ4Pgs+mfLfFBUjcaDd8EV0gb15Zf4KE0YtaCn49kpCCR6f+ticDY3wjUlz?=
 =?us-ascii?Q?HYgzz4r+w4jmeiiD4/dVVMuSfHMLLExcQMidOJ2G8s4tTixOKKGhtY8NuMqe?=
 =?us-ascii?Q?Bj3Xs2zecMdHPn/BHmvMMCLa6AXV9WVeS76WI6FUQpqb5GOnRl5z8uLrE5kF?=
 =?us-ascii?Q?4dl2U41JSaKADR+XWIoMuMIAPDlbXGR29/PwH1cwr5II2HeOc2GrzRzPJyMX?=
 =?us-ascii?Q?SrOeFlNYLuneUxWyN9PiKcH8RzbIHQN7nga3N7aA0/T/vD6Dt3U8bn9zA9EG?=
 =?us-ascii?Q?0z5KXo9+dpHBUm7xuT5V0ivcXlPjXwkoLAsUVmtSIaHY0MUzJ4KBiHLj9jUf?=
 =?us-ascii?Q?a9cXeQxC9u/uDZyP8ghrabaSD11Fb7DayovrFX0bT4S0GZDZ1oLXyUOaBSPI?=
 =?us-ascii?Q?nFy/uEKtVIRu47d01jVZ7zOeEICkgIUuYZO6a1JimSJL6Z7OHVFb/+C6B9Bq?=
 =?us-ascii?Q?gOIk8n0q4KmAjV4J2nOZ+bydyceQqAqLvv9LncrNcQH8OeH1mx4Mc0BOyns2?=
 =?us-ascii?Q?z1WZSJSt+5p1cdsRn92aDqPUsfuf8UwLpnGXDMojZUAgkWrtVstD8rVgVO9L?=
 =?us-ascii?Q?2gsqoMz5dh5M7+g59f5e8gYJQY9fr7ReIEPiMgnNEx4v/T+qxKQAZ7Pvtixk?=
 =?us-ascii?Q?NESeKNDg/feddLd/W5jiuWiX0X9ZQp1IFgdgdEvGIk7C8qQZ8W2BLOxc0fqV?=
 =?us-ascii?Q?9UZggEFlAw5a3pdUi8BKLnV8A96Y1nBqupntxcjDUXGH/80YfZZUYKSCfnIq?=
 =?us-ascii?Q?+kdErxnVr9gBHaYHb08QG88acZSsCx1U/bPRGlojoshpewq3iu+e0A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ghSu+uOQKZC6jnrdDeDTALQ5nTr2Pzvd03VT4gT/Us80xCuv0v7DPOpzrxL?=
 =?us-ascii?Q?PqBlsKME5MkFdhEAfL2IzV7ltJ9sEKgq02z4WD3VindXhR4Z0gvn6PEAGtIc?=
 =?us-ascii?Q?g2BxQPz6pqfoOhCrSKNLZXw/2KlYnFRCSVMqke7wC1PSxjm4MPZtXMVXY/aS?=
 =?us-ascii?Q?y+4bJGp6GqtXWTCALs0IeRl/yJ2S+q0DmbP7tTsTfkIDS3zNNsgp6rD7bOls?=
 =?us-ascii?Q?+dY9COtW6Jga+Fhlj50I0bKANHHqQLcLQXmDZ0usGKD9MDjUNwAk3HPa5/d0?=
 =?us-ascii?Q?dfnA2vWT6hEwvwgQAIhBIZy0C70upAkEzr3OTWt14HSjvZi1OKz69AcTAk2B?=
 =?us-ascii?Q?mQWSS/VG6fp1xGzQblnpNqULI0IIqySsS1LgMWx/tUZTwX9SO5REvLRdLwe9?=
 =?us-ascii?Q?ENpFzcJHx0v5xw4fOBYSQhP5NaVkLSS8vM6Syy1My4T4DnnY3cHn9Pv/2ZrG?=
 =?us-ascii?Q?uJtjek9/VKJ0hIzuOldNZsAwBhFO0y8iHyk5ex3cPkdY1eMnflPFDe+iOzw4?=
 =?us-ascii?Q?h0Zz9NkfrLV9Wylytkq9AG4GZUtOmYGagdJ4eQjbemRhxC8lyo6AD6P12lq5?=
 =?us-ascii?Q?e0ddz87sKqcvWPK1yP1PHB5yQlKRFQ/nomLAINV5fDjl+bcodLoL1Hta6TrQ?=
 =?us-ascii?Q?welbdoM9HNl66pU4Y5x30MUYgG/0NTzrvBX1xLxmwDwIqjeQRA1XUWo69ftd?=
 =?us-ascii?Q?VE+bvFx18iJKYFP367IWe5xxUGz0LkJfZ5FeCKawTGmUIHVEa7/fSEx7zDYw?=
 =?us-ascii?Q?1TATtrQ8u1gV2BSddrIE3XF884e8w5kyvpbPrCAZ/zIle0/T+1OQjmDRayxM?=
 =?us-ascii?Q?3AFaDAcR1lFZQJBPNGvEysFv6XagOzykOMBMIRgaaAsxopX6JgSQFIMiHTx7?=
 =?us-ascii?Q?RU92dB1s7L0AMWXSWa5y9Qmq8eoDYz9ICYpIqx8tIjA4UJUmBIOrOMvhAcN5?=
 =?us-ascii?Q?OjjggQOwoC2WNEE7a1+ELbGldHbPmb93iKPtGQkMQL+/AXY1xMkjdpCCwMoo?=
 =?us-ascii?Q?Ih2tUpkNQi/29vs3yLSIUdSYJq5Ef5ZuBreqDGgam7P48xhRgUAHdtPnzIcK?=
 =?us-ascii?Q?/a5sYXcw5/r5HWtUwx1rtisTBgN5hLGqXljGUFgF4GEsN3jwNimJMkyr7cH0?=
 =?us-ascii?Q?51njlAEjbO3k0LfpsYztTn3SeDxVE7/v0AK/jpCSz9Nfmn8bLQh1Nm0ItYI/?=
 =?us-ascii?Q?7jdUK4khFXvYKuEOCnbW5NCxXByLfYJ9ZVogERumiZ47ZkKt1RuR7YiD8QfK?=
 =?us-ascii?Q?qHt9enqGFx0ajVR7U+e9VKC6TYku0aQ5S7l4wetyVyywPxDNjPKKf3WNDBhL?=
 =?us-ascii?Q?zbDwvb29vDUD8Mjl7Yu79oGYOQlzmUUugdZ0ym2FMO3hm659RDAa9RvfswDM?=
 =?us-ascii?Q?amLUmfM7AXFdEhMvsjHlAyzaGyc1Adspsl/CltO9IzfXjwMvST3DX56bN+j5?=
 =?us-ascii?Q?+NpRo8G/KUFCkRYuTMCoCi2A9iLDngwkg/PkXAqvByZzgzr13PYWFNzzwCAO?=
 =?us-ascii?Q?n9NTCGo2cFZa7qHEBMrCNaamlteW9gr84pRlcro8GSq0QrxeMnXjgi1YxxhA?=
 =?us-ascii?Q?wafoMdrknVd9uJZTN4AdZEDWS4YwQdZG1NQtDkaA3RB/jlBaEq8hRmeAYCIv?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A043F7DDCD76447A1FE2AA5603297CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lA+0KpultTGxNiuSJWNnXoOt3yCRQert0vrvnRkQtgwhxK+V36jgrfSx/80t+zlNtZPIjIKGXTawZJHrJT0sbNydD1R3aiLq4otI15vOkRO6I5tGWpBLKP6LN8xCa4tIYCP8sByIq5yiY6CMoI5rVKYd/V7DpZWYCsJ0jVnkw+ZgDGiLIWpNFOBkA/uZUQeaj3b+/uSsg1oHW3K+NYBq9vq/9cG+yMQmU0oPm+trcnzfetC7nhEQ/PLEPf5ei/O6QCBV79uckHdVALL1oI4gXNm8NvDjrV7wrIcGP3L0KfpLbwqtY4r/Ts8G7zZKMWOaDJorXnIlByKhM6qSWopkVul2vE3lUzpbTaAMXtry5cK2Ru4XInnGQzYEUO/BA58FWSBVPjCy9r87X6jJAMeJg5bwMZ0bI4rAGSt0dmbRlpxrz++8CmI+XNGRz5/2bDIbkhtOsDl33G/zopPO3tG9vae7TqmYbui8tzc9Pu6yMG6ihOfMzqSrMkrGEH+I/gdQSsAbPraV4E91ppTIyfDWbyxb03UjLcBxJoOm9c5LjJcMF82gBLACEjgfCVaVargxJ4myzyJ+GRGRRKAX9x89wWCTZtqJ6V4NXZmsaqIBINMf/sUHXfyHw88/bThuGJIb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e3d61-39ca-41c9-6eb9-08dd9995014e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 00:59:00.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYWQNayuBcHQsvwIj9b+N/SLso8XKxo+F57NTfaCzafB23YMIgaqynZKzjmpQSs1uK+YALmUJZ9zT94AGpZfm1j9sgrabusPjELjxkaM8W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6558

On May 21, 2025 / 15:49, Darrick J. Wong wrote:
> On Wed, May 21, 2025 at 09:37:53AM +0000, Shinichiro Kawasaki wrote:
> > On May 20, 2025 / 20:19, Darrick J. Wong wrote:
> > > On Tue, May 20, 2025 at 07:08:58AM -0700, Christoph Hellwig wrote:
> > > > Hi Darrick,
> > > >=20
> > > > we regularly see execution times of more than half a day for xfs/56=
6
> > > > on a 30ish TB SMR HDD.  Do you think there might be a useful way to
> > > > scale down the load on rotational devices?
> > >=20
> > > Hrmm.  Is that the only one that does that, or do the other scrub tes=
ts
> > > take a while too?
> >=20
> > As to the test with SMR HDDs, I observed very long test run on two test=
 cases:
> > xfs/566 and xfs/732.
> >=20
> > > If it's just that one, and setting SOAK_DURATION=3D2m
> > > results in the test cutting off after 2min, then I'll craft some sort=
 of
> > > fix to constrain the runtime.
> >=20
> > I added,
> >=20
> >  "export SOAK_DURATION=3D2m"
> >=20
> > to local.config and ran xfs/566, but that setting does not look working=
.
> > The test case rusn more than a half an hour...
>=20
> Huh, that's /very/ strange.  In the absence of a SOAK_DURATION, the test
> should only run itself for 30 seconds.  From common/fuzzy,
> _scratch_xfs_stress_scrub does this to set the end-time:
>=20
> 	if [ -n "$SOAK_DURATION" ]; then
> 		end=3D"$((start + SOAK_DURATION))"
> 	else
> 		end=3D"$((start + (30 * TIME_FACTOR) ))"
> 	fi
>=20
> and then __stress_scrub_fsx_loop does:
>=20
> 	while __stress_scrub_running "$end" "$runningfile"; do
> 		# Need to recheck running conditions if we cleared anything
> 		__stress_scrub_clean_scratch && continue
> 		duration=3D$(___stress_scrub_duration "$end" "$remount_period")
> 		___scrub_run_fsx $duration $d_args &
>=20
> which should be sufficient to exit the fsx loop.  Then we go back to
> _scratch_xfs_stress_scrub and:
>=20
> 	# Wait until the designated end time or fsstress dies, then kill all of
> 	# our background processes.
> 	while __stress_scrub_running "$end" "$runningfile"; do
> 		sleep 1
> 	done
> 	_scratch_xfs_stress_scrub_cleanup
>=20
> which just waits for fsx and scrub to exit.  If you start this test and
> wait about 45 seconds or so, can you send me the ps output so I can try
> to figure out which component(s) aren't stopping in time?

Please find the ps output [1]. It shows a xfs_scrub command is taking time.
I did some investigation, and found the xfs_scrub command is started
by the _scratch_scrub() call in _scratch_xfs_stress_scrub(). This xfs_scrub
command starts before the 'end=3D"$((start + SOAK_DURATION))"' calculation.

P.S. I found that "export SOAK_DURATION=3D2m" causes the bash error
     "value too great for base". I think it should be
     "export SOAK_DURATION=3D120", but this does not look important here.


[1]

$ ps axuw | grep xfs
root         625  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfsalloc]
root         626  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs_mru_cache]
root         627  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-buf/sdc3]
root         628  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-conv/sdc3]
root         629  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-reclaim/sdc3]
root         630  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-blockgc/sdc3]
root         631  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-inodegc/sdc3]
root         632  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-log/sdc3]
root         633  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-cil/sdc3]
root         634  0.0  0.0      0     0 ?        S    May19   1:07 [xfsaild=
/sdc3]
root         880  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-buf/sdc2]
root         881  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-conv/sdc2]
root         882  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-reclaim/sdc2]
root         883  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-blockgc/sdc2]
root         885  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-inodegc/sdc2]
root         887  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-log/sdc2]
root         888  0.0  0.0      0     0 ?        I<   May19   0:00 [kworker=
/R-xfs-cil/sdc2]
root         889  0.0  0.0      0     0 ?        S    May19   0:00 [xfsaild=
/sdc2]
root     1143452  0.0  0.0      0     0 ?        I<   May20   0:00 [kworker=
/14:2H-xfs-log/dm-0]
root     1143455  0.0  0.0      0     0 ?        I<   May20   0:03 [kworker=
/1:0H-xfs-log/sdc3]
root     1144000  0.0  0.0      0     0 ?        I<   May20   0:00 [kworker=
/12:2H-xfs-log/dm-0]
root     1147483  0.0  0.0      0     0 ?        I<   May20   0:00 [kworker=
/15:0H-xfs-log/dm-0]
root     1149262  0.0  0.0      0     0 ?        I<   May20   0:00 [kworker=
/0:1H-xfs-log/dm-0]
root     1149405  0.0  0.0      0     0 ?        I<   May20   0:00 [kworker=
/11:2H-xfs-log/dm-0]
root     1150253  0.0  0.0      0     0 ?        I<   May20   0:00 [kworker=
/4:2H-xfs-log/dm-0]
root     1655712  0.0  0.0      0     0 ?        I<   May21   0:01 [kworker=
/5:0H-xfs-log/sdb]
root     1669211  0.0  0.0      0     0 ?        I    05:37   0:00 [kworker=
/1:1-xfs-buf/sdc3]
root     1674988  0.0  0.0  20816  9188 pts/0    S+   09:36   0:00 sudo ./c=
heck xfs/566
root     1674991  0.0  0.0  20816  2940 pts/1    Ss   09:36   0:00 sudo ./c=
heck xfs/566
root     1674992  0.1  0.0  11464  7612 pts/1    S+   09:36   0:00 /bin/bas=
h ./check xfs/566
root     1675518  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-buf/sda]
root     1675519  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-conv/sda]
root     1675520  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-reclaim/sda]
root     1675521  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-blockgc/sda]
root     1675522  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-inodegc/sda]
root     1675523  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-log/sda]
root     1675524  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-cil/sda]
root     1675525  0.0  0.0      0     0 ?        S    09:39   0:00 [xfsaild=
/sda]
root     1675526  0.0  0.0      0     0 ?        S    09:39   0:00 [xfs-zon=
e-gc/sda]
root     1675633  0.1  0.0   9180  8128 pts/1    S+   09:39   0:00 /bin/bas=
h /home/kts/kernel-test-suite/src/xfstests/tests/xfs/566
root     1675876  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-buf/sdb]
root     1675877  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-conv/sdb]
root     1675878  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-reclaim/sdb]
root     1675879  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-blockgc/sdb]
root     1675880  0.0  0.0      0     0 ?        I<   09:39   0:00 [kworker=
/R-xfs-inodegc/sdb]
root     1675888  0.0  0.0      0     0 ?        I<   09:40   0:00 [kworker=
/R-xfs-log/sdb]
root     1675889  0.0  0.0      0     0 ?        I<   09:40   0:00 [kworker=
/R-xfs-cil/sdb]
root     1675890  0.0  0.0      0     0 ?        S    09:40   0:00 [xfsaild=
/sdb]
root     1675891  0.0  0.0      0     0 ?        S    09:40   0:00 [xfs-zon=
e-gc/sdb]
root     1675933  195  0.1 171768 36296 pts/1    Sl+  09:40  16:46 /usr/loc=
al/sbin/xfs_scrub -d -T -v -k /var/kts/scratch
kts      1676000 50.0  0.0   6544  2388 pts/3    S+   09:48   0:00 grep --c=
olor=3Dauto xfs
