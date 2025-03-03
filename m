Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83921148C
	for <fstests@vger.kernel.org>; Mon,  3 Mar 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008595; cv=fail; b=cfoQIQQZnZ566+gfBbp9Gn/vwqzgSuvQionYVCtnSjr0E9dJUd8oXjDYhNCw2thkekxShosYOTuUJP/ojqQe8O5waolnJUqfw4rlOJiON2PesbfJMp+yC9BXzu5EBo/sl0QnADmH2rOStv1BLD+3rhwMhxE0ezd/TxKr9JWm8SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008595; c=relaxed/simple;
	bh=EVK2J2lE4CiLmQwnO8zvKjweHQSQ7YgAHfPmy+OvuFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rKOuOBFMOliECFXUNiD+hM8KA24WBmrkgzFQs7LYjf0T454YHM9gwOI6l0u85qn/SKemG0btg8O1BLMrI7b6Ze+CsfJrzF9/v8jkpBDWiX+NVuEoaIaKEAalTyonFXbLiY9NKNRchSmHLruWwyl701TjVDMWys4K3a5b0zhkLmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N2xDMsGW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mdRYa5DU; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N2xDMsGW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mdRYa5DU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741008593; x=1772544593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EVK2J2lE4CiLmQwnO8zvKjweHQSQ7YgAHfPmy+OvuFw=;
  b=N2xDMsGWFhtlCrK3Dav+fESsb9ZeVnxmS12edJWDY6BBQcSC17H012Ki
   Gf/jgjMBeH2YvJhuS4zO85MBYg9BGucMvPmQ5eJApaaZMzq3/MSOtT1gN
   tnSR6LCfsESsHU1xQO6jW7Xlzb0dOwIgGeb6VfQSn1EwuGh3GVshgc52b
   t3B9IAUbB/+nTK9kUsw/ZNYyZkpG8Ti/EchAuClxk151v0e8CShS1yMiY
   duB/qxabYITClqio3j595l/9gmuG8w43FNUEKohBUyzFiCvmOAnAN3Yn7
   DHL/i/OUwdumG+r92WyR+JeniCYHYc0BlUvRqzmiMxHbDkiUS8izNPjaD
   g==;
X-CSE-ConnectionGUID: CPjYwQ8VSHGvEfWeogkgtg==
X-CSE-MsgGUID: lWfYyhRGTg2z71aJCBKrWw==
X-IronPort-AV: E=Sophos;i="6.13,329,1732550400"; 
   d="scan'208";a="41221336"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2025 21:29:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+htf65C5BDKoveZKD5Qj+TNILYjxWjzh0yhojsLIIlCIC6TEJOThbVdyec/jqnYJK1dvijgPzKGMHlWPzgdVGjcGF6JHlm3Ow/kMjGCSD8MrDJtUz3zzC8Nf47rXhkCvIiVfAs49BQik5B6lqN+VcAMsMx+I4/26Qh4GkJ+khsOD1G1wQcTdJiqHMLeGRWIqNy8TIgWpcgIcM/jqMykDWiOJ+k8/w+73REyQNp8nnemu15FZIMPOkGsQzGqaecDPLUigwOmCfZ/Q1YLSl7y+qKXVEPLjc/skUJxCT91NXnNJ/sNpeKh4d6GpCkUXnuqd3FOhO7vwq0NxuPsu0uCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVK2J2lE4CiLmQwnO8zvKjweHQSQ7YgAHfPmy+OvuFw=;
 b=M/qnRrlINSUpXNeie/Wc/EBAeW+Br4cA3RTNcjdvxMhSuA4OqMYpe9/KNJ/lnFpeK7eD6VatgIsGfLmgthlOlPuyPO0ydvA5aT6/BNg0yTbXHmgGlxZ8K5doQE1erYR5s0zbsA4ZkOqz81e+9HT43iy6EhFdoyFyEO3nqsPIz9oFMP68bXwXDOyUvidX1pS1WZypdKhtF1Q/1CznMrWi8NwCyIUusS53cW9FEhxYrfJx7b1vhqbM9wHaO3WQBrEAcaFrWGweoqLHwqBH4yo9hyDl8SZXbMuCUNhRzMBm9zFevmjR26NpD82oa/7kk9emDnxwaNKTxK3uigz5gQA3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVK2J2lE4CiLmQwnO8zvKjweHQSQ7YgAHfPmy+OvuFw=;
 b=mdRYa5DURYH53Q6D9vcSsMxBqq0Z4oMTkZums1f8HK0ic8kamdmNY69j+WtJpSxBNtmJgVyUcLUnmwYeFr0D0DuJfXy/Gx47xLjWeLAL9tHCwy3k4VpT9/bRIYpLszCBLSWktLpoK3lmLNb9dqwjqe5NuAenImIlv/DWpfMpO40=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA6PR04MB9616.namprd04.prod.outlook.com (2603:10b6:806:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 13:29:44 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:29:44 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "djwong@kernel.org"
	<djwong@kernel.org>
Subject: Re: [PATCH] tools/run_privatens: check if it is mount point for
 --make-private
Thread-Topic: [PATCH] tools/run_privatens: check if it is mount point for
 --make-private
Thread-Index: AQHbjAdrkUuRQvdVQ0qX3IxPoi1YNrNhMQGAgAA3gQA=
Date: Mon, 3 Mar 2025 13:29:43 +0000
Message-ID: <D86O11SKYP75.1NJE84UIKCEYD@wdc.com>
References: <20250303064209.602577-1-naohiro.aota@wdc.com>
 <20250303101047.qjugaez6c7ythpd6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20250303101047.qjugaez6c7ythpd6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA6PR04MB9616:EE_
x-ms-office365-filtering-correlation-id: 6df08552-0da2-414d-6ef4-08dd5a5775c0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWxXd0tla0xISkFURStoWEkzWVF3TGE1RWYwMkYvbmVzZitXMkVqNHhTNUgr?=
 =?utf-8?B?QUtOQ3B2c2hNYWpEM1dzYzJSMzJEamdsNFRLblNrblU3R2YxN1RxNUFZNDlX?=
 =?utf-8?B?TWhQWDc1QmdRQTlwYmsrRk1abWZPVnJlSzkyUkswTDdrUVBEZGRGekIycDR4?=
 =?utf-8?B?UTJmcUJyWitlWVpoQzNrM2JjNy81aTJuN0I2d0hiSVBUOG5hcWdySDV5VHdZ?=
 =?utf-8?B?TTIvR0lJU21IRVphbm5yMjNLVHpGSXNtT3Q5eFRqQnhRVUxYc25JQms2dU9s?=
 =?utf-8?B?NDdLMWV6T0JGT2RUMi9MSEYzd2k2SXYvUzdxUXFwR3FQUWk4NlMwZTl3WjRN?=
 =?utf-8?B?bGQ4YTZSVHF5aThBakhTNFdpVHFqdnhQK0hNd1Yva1RuMHplK3h3ZVRzQlpR?=
 =?utf-8?B?dWVER3FyY1cvdG5tV0lBUndFdVNIMFNLdTM5UStjOEdzNnJvb2tQSmtab3FG?=
 =?utf-8?B?ZVNNUUNDVWtQS2NPd0xyazNMTlhTRENGUVFNMVhCN0tDaVZxYlBDYjlQcE4w?=
 =?utf-8?B?VWR0MG1yTXFtTWJnQVhPdXFLbTJhQ0pEVHlBd3FNSG53d09FRGxFbVRQWm1D?=
 =?utf-8?B?N2d3QjNCOG5ZeHZsMDFRSlZDNnlHMzBpcFkyeDE1N1F4dTZVVDRRZkdjUmc5?=
 =?utf-8?B?VU5zYlhXRFVWSzBlWUpGUXdvbWVZTzN5ZmtOOThhS0pnaW5DWXFJOStDVzh2?=
 =?utf-8?B?OUNkbEpIK09mUmhuQ003RVgvZXFxbE1NZkdURWMzUWV3Qk81TmdmakpwSHNU?=
 =?utf-8?B?aU9vb3lhbGVMbUwvWGpEbWpzU0FDUG5xaTNrWnBtTkthQXRuZkxaL2FhREZC?=
 =?utf-8?B?NEg1VDBoWkpHK1c5bzAzTlpNQ3JSRTkvclIyVURNNmhNMTRLS29LU01ocHk4?=
 =?utf-8?B?b0tCVXZBbkp6RmNRalhQTm5iRVpxK2tVWDdzR2QwZjBPbmUvd2haTi9oMDJL?=
 =?utf-8?B?K3QxNEtjSVptb0h1Tmc0bzhHRkt4RHdsR2loU1FNeVExWTlEdmUyOGJiT0JT?=
 =?utf-8?B?Y3V1Q2poaEREbGk2K05uZEJlbzRMZjlIWktDaFZoZmczS3ZSeEt1YXY3T3Q3?=
 =?utf-8?B?S242YWZQSzB1T2FoU0ZtUUhQK3kyT0t3RlIxb2RGSmNJYjJzSjBPanNHSjNv?=
 =?utf-8?B?QXBrNGgyRkM0QzVmQTRlcUZBWm1UV2dKdGF6NFJqaEdMOXRrcHc5Tm9XcXlO?=
 =?utf-8?B?RCtUWkdqdkFzRFNFVVRmaHVBTU1VUEQrYlZCL292cXpGbjRGS0ZkWXdWTFho?=
 =?utf-8?B?U2tKSkQ0V3VtOGZqZ0N1U2pZVmxJTFhDVXNVd2taRU1OSDFIVytPVDJjZHNF?=
 =?utf-8?B?VERLSXEwQ3J3SXhzbnBsV1RpZ3pIVEJXUEMyTEVjd09LWDlCUWVjc2tOT1hZ?=
 =?utf-8?B?TFZZQW5pN3V0ekQzODFLWEVCRTZhbHpITEt3L1U3MGNrenpTSFhSWFpFSnZL?=
 =?utf-8?B?MllORG9PN3ozK0liY09QdU1mRUZBazVNM2h2cnppU1c1QnJBd2JPZkVlUW9P?=
 =?utf-8?B?MkF2cTA5NWtEZ3NXQ2dyTms2dStKSDNoejRQRWIvZFZua3BFQk04TTRSNVoz?=
 =?utf-8?B?dWVHYVFvcVRQVWpIZkZiZnphYWFSbWYyZnMrOEN4T0RGZmVVZlYrNXo3ZDZY?=
 =?utf-8?B?VllFY3FtT1ZvZ0pBVkk1dkh6MGpXd1c1Tk00ay9lZXp4NWRQOG9YNVhrS1Nj?=
 =?utf-8?B?QmZHeThDcWVXVjE0ZGd2djFuMkI3TFNnbUg2TGczYkVFR2pNblVaMVZ2MnBL?=
 =?utf-8?B?dGZTZXNIaXoreXRVNnRuVGRUOVZPM2tiaUFkSm1XOS8reXRkVHVKMEgzTHE1?=
 =?utf-8?B?bm4vcEZpL0wrSUE2SHczdncwTXF1Ni9YSTV0RGtTWm5EblprNjVQaExjWi9W?=
 =?utf-8?B?NjlZdjhQOVFIQWV5MGxYR0hKRndNVUd5RkxFQWVQK1hBYldJdE4vSk41TzNw?=
 =?utf-8?Q?64yZB6q/NV3yAR9PY3Y/+cHLxot6BsZM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTNqeWJxVmlHSTJ2U2lPdDFTQWUvRHlPMm9vaXlZR05vN3gveW05bkowK3Bx?=
 =?utf-8?B?N0w4RzRyNFBmZ1pmc3ZESnNLSmlxcVhod1VqcElzdWRpWGJaVVVCZ242QXhi?=
 =?utf-8?B?a2d2K1VyNXBlQnZDWE5kZ1ZyODVTaTRidG95dUVwNVJ1ZFhSS0IrRWFQOENa?=
 =?utf-8?B?T1hGaHplK01uSU15S3FrZHAzTk03U2ZzMXg4VHVnamNBNEptRDhtTWRYNmQ2?=
 =?utf-8?B?ZWpuQWdNL0ordWQzSlBUYzQyK0ROT0wvREozUk5Sa01rMWI2bEt0bU9YSTlx?=
 =?utf-8?B?UTlQVENXQ1Z5OUtpSFRNcmFZWEZBNlk5WEJZc2RFTkt5VVVqeEtBb2FGaEhP?=
 =?utf-8?B?aVl1QXFHZFZRbEJ6YjY0QnNOVElvZ0tBQ0lnU2NmOW5Bc204TVBLaER1cUZy?=
 =?utf-8?B?OFlCVnFrRjE5N2swWU9NUkh6VDZQOEp4VWdIWlVqMDBXUXdhalREU0tTSVRO?=
 =?utf-8?B?V20rYXBaQXc4Q01wQTZHZWxrZXBZVTV2V1hXbTkzakxZdldWWHdpbEVqVlNa?=
 =?utf-8?B?RjlhV2JXTm8zcHo5RHZySjQyU0tYSzFOYUNrYm9ieHlIWHZuaExXZ01pZVFu?=
 =?utf-8?B?SHVHVDhjdXZVR3lRSmpUekRzZVFFd29PT0Vway9TcUdrOEdKTU8xRHRCNFBu?=
 =?utf-8?B?N0J1c2JJNUg5clB1Sm9RNDQwVXdPZ0IxYnFpRHNPU3pSa2xwTmR3Uk5tcWFJ?=
 =?utf-8?B?NmhURGpId3N5UW5WVGJac0ViZ0FTblJxRHo5aXFORXpiTWx0QWhrTE5nYklN?=
 =?utf-8?B?NlJacW1XNVBvemVaUnk2azU0YXVrVFRheEZwc0RnNllBODVDNGFDUnRWZDAx?=
 =?utf-8?B?VEhIVkhRSWxxU3dFakNWREx4Z3JOckFuTGowL2pGMG0xdDZhME8vdHViMGtu?=
 =?utf-8?B?UlJvM1dxbXMySHErcjlrQVNDdDM0bDNFNXVwOW9TOUlWWlloRHNreU95Zm84?=
 =?utf-8?B?bHNSSFVOZnlNcVIrMkIxMEdIbVBRMlpqN1RoM0RuczVZV1BXRW1VOGgxV2N5?=
 =?utf-8?B?QjIvMGpSVldBNHVFVjBmVWtTeThLeVVpSEhpQUtwRmxFbmdkY1R3Z0hzNDV2?=
 =?utf-8?B?elIvZHBUMUJpNEhEcWplMEoxTkVrNWtJVG5DUkNQQlBDKzlneS9IQ2Vsb3hN?=
 =?utf-8?B?dmU0Sm1RM3F3Nkd4dFQ4QitBYURTc2l2ZnIrcVh6WHNaWncwTVg3ODNCNlp2?=
 =?utf-8?B?bUZNWDV0WW9SMWtDYjdJRzBleHhHdXVPQWRzaWdmQzcyYW1qVGoyRjg2Y0dE?=
 =?utf-8?B?S3orZFEzcTMrQTJ1UUFUbnZUY2Q0SUwyL2J5b3lFeTN5bnowZk4wOFZ2R1Ru?=
 =?utf-8?B?VWMyMi9Bd1RyanhDbExEUFp2eFVwNXNBN1daZFJ0c0R5UzNWckJ4QXdubUJ0?=
 =?utf-8?B?dy9rVkkrYXpLMjJMWG9GVXJWMEdHYVpLU2U2N1JoOHpTUjJVeThyRGJuSGo3?=
 =?utf-8?B?RDMrMGRNSVVkSVNJdkFjNDVOWHcvcGFnNE8wMXFSUmFuWlVlSjdlblJYZHY0?=
 =?utf-8?B?TVJzYWplcG1GZDVLMWhEaDZ3cWFXd290cGNXYzlTSHFYWUJMc2puL2x1ZWt1?=
 =?utf-8?B?WHY0TzRmRUhkc09ETGxZcmRtQkVoMWZuV3hGMWtOZjBDL25zbTdnZXBra3ZP?=
 =?utf-8?B?MmFjZVB4Y21GWkpwOFFBZURXUmhzSDJseGxkYmwxMlkxVHdFMFJGaUZGZVJ2?=
 =?utf-8?B?dzY5SEhRVWtDeG9jL1hYZTRHcW54MFRPUEtLWkVSYkxsd2RzaVJYdjJlVXZh?=
 =?utf-8?B?TWdJYVZicVVxUlBlRzQvUWZWN3RkY0oyWTI0cGUxMy8vMWh6WUJWY25UK2F6?=
 =?utf-8?B?aDlyTGxjK2pSckhJTlNVZEFQV3l6RlU1QWRoRlR2T1JvZ0JRZHhoZ2hsVVhv?=
 =?utf-8?B?aU9acCtLTjlJcHYvVFhTYUR4aERLcmRrNE85am4rK1hTREgvWXNzN2RVYUNF?=
 =?utf-8?B?V1FnZjk5d0xmcWlrVkRCT3kxODk4L0tGRlhQQTEvZHByMFlzTkM4YXpIV1FQ?=
 =?utf-8?B?YmVXZkkrNWwzSCtPLytTSzJiYU91V1NTaElQL0tlUXBFeTBtZTFkbmhTYi9z?=
 =?utf-8?B?UnRJZUJzL3AvWU9GYXJyamdkUkxkZ1lGYVNTV0JKcmp5azBzUW9IVkx0QktY?=
 =?utf-8?B?RTBHZnFRd0FVdy9TOWs3eGg1bHFybVpSYU1YdlIzS2VZYTIrUHNJRWF0V2p4?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AEC9E6341F6FA41BDDF3483AAC6D4D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1I84S38L901RytyOXPxcYNUo8pXuBRNP67PrjCcMMcaejB0bifI9Bi3vBwfBmjx/MJdgmzyOyB+BH7/PgQ+uORVq4zEVBhR/YDf0wJS08F9OQ55f0yu+vIwV5P0K88OJsUuTHbseNyWK2veqXAkckWFat7U9gh7XVEAoTdYPbMk4X5lNmMcjub12okMZOMdBu0gFFUBJl/jkZBgzlRP+1pV06+s32jcRlRCtcP4n0b/tiH2AyvQv1ATHfdjtS/qu+GSM2TSWmM9v5tes/b4GTJU3fTgMoxR6xNWYVrDKTL2zMy1xhowu5ufRujWG2Q7gNy/BXWs7ORawUF2joapczLXtEl1iI36ETT1pg7VZ6VsGfUqgFBbooYo5OPIPIjBpafC4tGQnXhZN0JfVMeJDtVt47pBD4OUwVr1nyeosAZzeKViM+35/D8ZR+FnbX+1UA10Foelfl9HpKi6N4RGY8iQ2YSoih2EhIpNRj3ogbk/m9l+i7jUXA8pNUxS1XaDeQPR5KtcRhftZLgPFAkC/B3cOA3FwDLOFE5aemP7B/1hXIStxQYINEM0IpGrxNduanSGQgHClRZOcJZNmNgZEcca5UidApp1pv8cgKM5Lc33L8JA5LEFUvLaIPCeCt7Pk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df08552-0da2-414d-6ef4-08dd5a5775c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 13:29:44.0484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3c3zYOl1UL9HaglAOZ9yUBXtBkoh5eAdFt0bdwJQH3KoqZyR1Uc5osKus0xhCDqg1wM4mFAcY5uGpw4FW+hkiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9616

T24gTW9uIE1hciAzLCAyMDI1IGF0IDc6MTAgUE0gSlNULCBab3JybyBMYW5nIHdyb3RlOg0KPiBP
biBNb24sIE1hciAwMywgMjAyNSBhdCAwMzo0MjowOVBNICswOTAwLCBOYW9oaXJvIEFvdGEgd3Jv
dGU6DQo+PiBXaGlsZSAvdG1wIGlzIG1vdW50ZWQgd2l0aCB0bXBmcyBpbiB0aGUgbW9zdCBzZXR1
cCwgaXQgc3RpbGwgY2FuIGJlIGEgbm9uLW1vdW50DQo+PiBwb2ludC4gRm9yIGV4YW1wbGUsIEkn
bSBydW5uaW5nIHRoZSBmc3Rlc3RzIGluIGEgY29udGFpbmVyLCB3aGljaCBkb2VzIG5vdA0KPj4g
bW91bnQgL3RtcCBpbnNpZGUgdGhlIGNvbnRhaW5lci4NCj4+IA0KPj4gUnVubmluZyBhbnkgdGVz
dCBjYXNlIG9uIHN1Y2ggc3lzdGVtIHJlc3VsdHMgaW4gaGF2aW5nIHRoZSBmb2xsb3dpbmcgZXJy
b3INCj4+IHByaW50ZWQsIHdoaWNoIGxlYWRzIHRvIGFsbCB0aGUgdGVzdCBjYXNlcyBmYWlsIGR1
ZSB0byB0aGUgb3V0cHV0IGRpZmZlcmVuY2UuDQo+PiANCj4+ICAgbW91bnQ6IC90bXA6IG5vdCBt
b3VudCBwb2ludCBvciBiYWQgb3B0aW9uLg0KPj4gICAgICAgICAgZG1lc2coMSkgbWF5IGhhdmUg
bW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWlsZWQgbW91bnQgc3lzdGVtIGNhbGwuDQo+PiANCj4+
IFRoZXNlIGxpbmVzIGFyZSBwcmludGVkIGJ5IHRoZSAibW91bnQgLS1tYWtlLXByaXZhdGUiIGNv
bW1hbmQuIFNvLCBmaXggdGhhdCBieQ0KPj4gdXNpbmcgbW91bnRwb2ludCBjb21tYW5kIHRvIGNo
ZWNrIGlmIHRoZSBkaXJlY3RvcnkgaXMgYSBtb3VudCBwb2ludCBvciBub3QuDQo+PiANCj4+IEZp
eGVzOiAyNDdhYjAxZmEyMjcgKCJjaGVjazogcnVuIHRlc3RzIGluIGEgcHJpdmF0ZSBwaWQvbW91
bnQgbmFtZXNwYWNlIikNCj4+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5h
b3RhQHdkYy5jb20+DQo+PiAtLS0NCj4+ICB0b29scy9ydW5fcHJpdmF0ZW5zIHwgMiArLQ0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBk
aWZmIC0tZ2l0IGEvdG9vbHMvcnVuX3ByaXZhdGVucyBiL3Rvb2xzL3J1bl9wcml2YXRlbnMNCj4+
IGluZGV4IGRmOTQ5NzRhYjMwYy4uYzUyZTAxMjhiOGY5IDEwMDc1NQ0KPj4gLS0tIGEvdG9vbHMv
cnVuX3ByaXZhdGVucw0KPj4gKysrIGIvdG9vbHMvcnVuX3ByaXZhdGVucw0KPj4gQEAgLTgsNyAr
OCw3IEBADQo+PiAgDQo+PiAgaWYgWyAtbiAiJHtGU1RFU1RTX0lTT0x9IiBdOyB0aGVuDQo+PiAg
CWZvciBwYXRoIGluIC9wcm9jIC90bXA7IGRvDQo+PiAtCQltb3VudCAtLW1ha2UtcHJpdmF0ZSAi
JHBhdGgiDQo+PiArCQltb3VudHBvaW50ICIkcGF0aCIgPi9kZXYvbnVsbCAmJiBtb3VudCAtLW1h
a2UtcHJpdmF0ZSAiJHBhdGgiDQo+DQo+IE9oLCBpZiAvdG1wIGlzbid0IGEgbW91bnRwb2ludCBv
biB5b3VyIHN5c3RlbSwgZG9uJ3QgeW91IG5lZWQgdG8gdGhpbmsgYWJvdXQgLi4uDQo+DQo+PiAg
CWRvbmUNCj4+ICAJbW91bnQgLXQgcHJvYyBwcm9jIC9wcm9jDQo+PiAgCW1vdW50IC10IHRtcGZz
IHRtcGZzIC90bXANCj4gICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+DQo+IC4u
LiB0aGlzIHN0ZXA/IEkgdGhpbmsgdGhlIGZpcnN0IHJ1bl9wcml2YXRlbnMgcHJvY2VzcyB3aWxs
IHJlbWFpbiBhICJtb3VudGVkIg0KPiAvdG1wIG9uIHlvdXIgc3lzdGVtLg0KPg0KPiBBbmQgdGhl
biBsYXRlciB0ZXN0cyB3aWxsIHVzZSB0aGlzIHRtcGZzLiBUaGF0J3MgbmVhcmx5IGVxdWFsIHRv
ICJXZSBhbHdheXMNCj4gbWFrZSBzdXJlIHRoZXJlJ3MgYSB0bXBmcyBtb3VudCBvbiAvdG1wIGF0
IHRoZSBiZWdpbm5pbmcgb2YgZnN0ZXN0cyBydW5uaW5nIi4NCg0KVGhhdCBkb2VzIG5vdCBoYXBw
ZW4gYmVjYXVzZSB3ZSBhcmUgYWxyZWFkeSBpbiBhIG1vdW50IG5hbWVzcGFjZSBjcmVhdGVkDQpi
eSBuc2V4ZWMuIFRoZSBtb3VudGVkICIvdG1wIiBpcyBsb2NhbCB0byBlYWNoIHRlc3QsIGFuZCBl
YWNoIHRlc3QNCnNob3dlZCB0aGUgZXJyb3IgYWJvdmUuDQoNCj4NCj4gQnV0IGlmIHdlIGRvbid0
IHJ1biB0aGF0ICJtb3VudCB0bXBmcyIgc3RlcCwgSSB0aGluayBpdCdzIG5vdCB3aGF0IHRoaXMg
c2NyaXB0DQo+IHdhbnRzICh0byBpc29sYXRlIHRoZSBkYXRhIGluIC90bXApLiBSaWdodD8NCg0K
SSBndWVzcyB3ZSBjYW4gZG8gdGhlc2UgaW5zdGVhZD8NCg0KbW91bnQgLS1tYWtlLXByaXZhdGUg
LXQgcHJvYyBwcm9jIC9wcm9jDQptb3VudCAtLW1ha2UtcHJpdmF0ZSAtdCB0bXBmcyB0bXBmcyAv
dG1wDQoNCkFjdHVhbGx5LCBJJ20gbm90IHF1aXRlIGNvbmZpbmRlbnQgdGhhdCB3ZSByZWFsbHkg
bmVlZCAiLS1tYWtlLXByaXZhdGUiDQpoZXJlLiBBcyB3ZSBtb3VudCBuZXcgaW5zdGFuY2Ugb2Yg
cHJvYyBhbmQgdG1wZnMgYW5kIHdlIGRvbid0IGJpbmQgdGhlbSwNCkkgZG9uJ3Qgc2VlIG11Y2gg
cG9pbnQgbWFraW5nIHRoZW0gcHJpdmF0ZS4NCg0KPg0KPiBUaGFua3MsDQo+IFpvcnJvDQo+DQo+
DQo+DQo+PiAtLSANCj4+IDIuNDguMQ0KPj4gDQo+PiANCg==
