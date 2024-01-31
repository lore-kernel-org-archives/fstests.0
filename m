Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D096995B
	for <fstests@vger.kernel.org>; Wed, 31 Jan 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695117; cv=fail; b=L2XzOQwZhKoRPXP0bhlYGqUCXqczd1QV3z09NE/AxdVagsAI/C0foglsXecNnIvkK+Uz/Mgl6Gir25TY8Vj2Y7r+zWIx0KbVXtbhYycG1UbUhYT0mFJ3t6Vn0EmBve3hAIjZ3v1qJboQ2fQhYs5hTTfMDnkwVAV2NXHJHm7XRlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695117; c=relaxed/simple;
	bh=qYG5QnnNogL9MXL6fcuUXkYlNPQnp1cG+gjhXxs7DRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMUa8QqxTrZrAvEWokh8YLYaxnztEsSJGvIz6d0Cht41V/0nASDKiYQMACKndIweETDzQaHlY267WlY328ekTQAdulZ3dT4rwnyEKuA2Ui6nAg/EZRGe9aGZG9C5iva/HwrP8bfm7aZIRN6nzgRtf05qB2qOoQlffxRa3CcS2fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Wpem6WeS; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Wpem6WeS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706695113; x=1738231113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qYG5QnnNogL9MXL6fcuUXkYlNPQnp1cG+gjhXxs7DRo=;
  b=Wpem6WeSuATUsv6a2WLgvh/UjjCdwof3Q/Or0/rVlfRQTuL4xQ94maTN
   YOHt7RdergNlPiBEdIg0wnDh7/pjVEB+aEunrtx2KY3Ibq3gfr8s3qBre
   ufpdsfAJW/yVu3oLF3p8kK/VpJgsmEGv6mAu/rDAtETv5s/TFUNbQz/jK
   2+gZQeE8g7lZum0iMdvMi2VsXOtCnRk/4tz6Me1YgRS+Q0RV+ak4senNJ
   YCwDDVXsPKq9feJ6Kl5/Ubz4rZzWVBIQzhJ2fRh56KuCO4CubL39ADcO1
   8ytFbqr7iSHjzzlhU6GTs6+1yORj5ImUo/r5YDD74xY6RAugG9qtr0ODn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="109897315"
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="109897315"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 18:58:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il1OeeUjMRQUHGaz6sKsrfsFKB7ETmOs2kAuxl8dfgL7iBNTBdUn7mKVslr1vysLBlIkUPFNHZmenYyzHftiiA3K29fMN7aYKk0Eq97hHWDN4IvXG3qNBIaYcgi3yFMJKvAGewz80iv5IBbGoBuIRZxZgQY4PptB63noYnLcFXROFN+9P+3rzn6qaKxcXezZdVywKWROYXNm4FVKBbaq4aSOeV/V0JhB4uwUbBii3V1L8pAzmb82J2HCbiQn8tww+jPM90XX9G6mZyQWMtDzt0lquI90CCtXvZ+QqqZwAp/9jLOYy1GPIFT5D2wQuR6ARYJB4ERnpg4enpHHozq7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYG5QnnNogL9MXL6fcuUXkYlNPQnp1cG+gjhXxs7DRo=;
 b=jHOC28a4o9Ygt9lPlVCbLCtrVcglFuHLPggfYxITw7VLhjAp0l2HXgmbhw1Xzgp6agMMYMhUpDnQyL8e3ylePpftfmjjrIfeCqVhWXCZkXMB6jXnM8dCPkAIi7qauBATsXIjgbjI8zPh6bc1SEnAtFxW61S078JYLD7DXm4zSfUcedsCvYWyc30IViL/dczixwmC64Liv1YHeA0WltT6h18DStQrS1U4nmHf7le4vFcOTjffNDT08hp4FxXeiWD0OyiKACrcFXDxfCnKdOL2pn9/pGwq9QrPp9r1dhmrbAVnPA3AQ8Ekb0H3kDpkIX9OqxmYlGN8SFMmjOb2izS5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TYWPR01MB9295.jpnprd01.prod.outlook.com (2603:1096:400:1a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 09:58:22 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::dc0a:de11:7b66:6a34]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::dc0a:de11:7b66:6a34%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 09:58:21 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] t_snapshot_deleted_subvolume: change the position of
 macro definition
Thread-Topic: [PATCH] t_snapshot_deleted_subvolume: change the position of
 macro definition
Thread-Index: AQHaUC5KWwSER1UL00+BBQRPxo8JpbDzh4GAgAAwLAA=
Date: Wed, 31 Jan 2024 09:58:21 +0000
Message-ID: <a5d536e1-9234-47c4-96fe-038a6218e675@fujitsu.com>
References: <20240126080423.138713-1-xuyang2018.jy@fujitsu.com>
 <20240131070555.GG31555@twin.jikos.cz>
In-Reply-To: <20240131070555.GG31555@twin.jikos.cz>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|TYWPR01MB9295:EE_
x-ms-office365-filtering-correlation-id: 4bcd41b0-c260-41b2-916e-08dc224328a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5rGaDYFa+pv6rAEOr4XCTsqE1tWBxOzZKYDydx+NIM6KZ0ryQuTBe8ByNDy4eu2EodDv9xK6WA1FNV2ba0ClC8gt3LIOB9Yejyt/BBN0+jhbOZfRg7fq1ZX2stTlRw+4IlAwJT1BVueVS0VSwnImPG15rWWTKIRvJTIDa6Q8R1neLBjrx323ONiqg9Wcih+x+V+xwPnCFWdMhCtp4ur/X+O9LeRPGeQNACFTCIguYre5FmXajCxf2RQM3Ud9VARQUkYHGlMNe6PgpeuQwhsFHYIFHNIJwsuNZPaTS7EXHL9UYI3Ks52dIcWD4WcAHozj5C2PJ+fN283y9TlINfOqGk+ATY5T1pDOoWduI5/gD/z3RVEHfkO67SyKv6sISx6L2ABUEJsWmOwm5RKwX+5xlnVI35wf5B1G6xCF+2Sk9gQoVICc0/6sfxg7LSzW3sPooD/hBaD2KY22pBH5KvmXpFJ3yJiKx+2tpejwqEJrKrQvd9tO1vkc54bG8kZcgDcUZMk0PSYkiR3iQiwUJ62mHAdEA8gIXx1iBZhLpL+EZwNwYDpuF4L//OoU7klVCKQwPF4wxjSrr/GjjaCmhuLDOnc+L6sBcxwUmMBMcPcOGUwukuvQjaFY2ZcHj5kcJ2ExDNAcmX01torQjs7YVcv1bXJmvoB92IAcAJoswOLkA/V066B5Zby0YDXe+WRyXFE3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1590799021)(64100799003)(451199024)(186009)(1800799012)(6512007)(6916009)(64756008)(66446008)(66476007)(66946007)(83380400001)(8936002)(8676002)(4326008)(2906002)(316002)(76116006)(66556008)(5660300002)(122000001)(38100700002)(6486002)(31686004)(26005)(478600001)(2616005)(71200400001)(6506007)(82960400001)(31696002)(1580799018)(86362001)(38070700009)(41300700001)(36756003)(85182001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmRacTloMTRMUC9oT0VoanhucVM5US9jcjczS0haQytwUlhtMGh0OWtkdkx1?=
 =?utf-8?B?QXRqZ2hscUMxY1VLS2xpZGVHZ2Z0Q1hoRHVVc3BKNDl6cmNyS1hsNzBidk1y?=
 =?utf-8?B?RTc2ZU5tdzhISEw4cTFBQjU4Qmw4T1VYcVVsNTVMMzdWYkM3V2RRWVkveEYx?=
 =?utf-8?B?cXVjck1jbWRtRm01SncyMmorZWpzTkh3eDhMeTNWcE5rTlZya2dGZkdYZExv?=
 =?utf-8?B?NmxFM1VLYkpkOENPZzJpcDFKc2dCMlhydWRWWUFGck1LNzQ4eE0vMTRNUFBs?=
 =?utf-8?B?YTZvR3d2eHAxZGpNQytrUUxkVFh3NUtoTWdWZERzTTRlVFNMR2daSlNsVDRC?=
 =?utf-8?B?UVRJcXRwcmQvRGpEQ0dzWm84aG5KejlEZ1VTYm1Nem80WDN4SFJkZDZ5K2I5?=
 =?utf-8?B?cVkzRnN4MHl4ZWJrWXRtTkVZVzBZcjVaNmRnVTh3S1F0WTQ5ZVlyc0E2Qmpv?=
 =?utf-8?B?MXJRbTYrL3NGaGpDRGd1TWFSNzRWUTBUbWhIQnlGdEc0OFZXRUIrdlJ3SUFZ?=
 =?utf-8?B?Y2Q2ejFFTHYwQlFnd0ZSeTVFV2JTTDhWcjdzS09TMzNaWSsxak9yeE5BSXZn?=
 =?utf-8?B?aDBwQzcyUE9qc0ovc1JBUEUyQjhORnBvMnNnZWExUGdNZTcrdEhDTFJaQVhC?=
 =?utf-8?B?TmxrYzRNSituY3RST0Y5SndkN1AyOG9kSUJWRDBRMkx4dmQzUjlLS01iZmV6?=
 =?utf-8?B?Q3VYcFVxT0kwQVgzZjVaTHZuUjJ6YmY4TXJ0UjFSSlJmeUFONUZrTjNRS1I5?=
 =?utf-8?B?V3cwMDJGNjU5OVpiVkgrTmRNNWJuZFBSMTQvSEVlYVIwZXJrc1ZkaElNSUw2?=
 =?utf-8?B?YU9OLys1ZzErSW5Jb1p6U1RYMWZHM3YwVDB1cmFCV2Jtb2dya09PUlpKS3hj?=
 =?utf-8?B?UlpDK3dSWHBEdTNObmxiL2NZczRRQ2FMVlg2MWEzdko2SktkRGxMekF4WUhL?=
 =?utf-8?B?aDBVam5jY1BvTG5oZGFobkRLWEdPT1pVR2tsWUhhc3p4eHREVzhjNW11bnJU?=
 =?utf-8?B?aUszaVdRMFg1b2lMZTRGcFREcWlLdElQU1Q1WXdOamFvRk9CaXcwOE51dXk4?=
 =?utf-8?B?dXhRK2FtcE5VY0l3Q096SnorQmpBS1l4bWFzY1Y4MExLd0RFOUllM3R4Q3h3?=
 =?utf-8?B?YmNVYlV4U0toaVJ6K1ZvbmhTeUFvV01aOGVEZWxHa3pyRlN6dDJ5UTgybDZG?=
 =?utf-8?B?SlI2aFJyY3RwOVlTa0lZQ2ZCdUJhQjJMMUxlVVlzOWpsRjFzUFlRUlIxS3J0?=
 =?utf-8?B?enBjN1g5WXpmQ2tCT3lLSldTM2FrMG1aL1dwTjRWNjlnNy9GTmwvemt3TGZr?=
 =?utf-8?B?ZWk1djVteFN2OXJjdlgxejN4STB2NlpsQ09YTEp6TDluNTQxNTBaeXk3YjdL?=
 =?utf-8?B?cGJrb0ZjYVl5OW1JTThaOVhFQ1RKNGd1Y1gwUlQ1ODU2bGdHcm11Q1o0dlds?=
 =?utf-8?B?SUVHeXdZbENTUUFDY2VvNFMvTDAwM3ZtbmtKaWhzaEJWYlFxbjVwVWx4MWFq?=
 =?utf-8?B?Q1puQ29NRElmaU56cHdDdWladWhjN1A5Wmlralg5aTBBRGNvVHFWS2JvUXdJ?=
 =?utf-8?B?dXQ5OUN4MFZkSWdmYURLZmkvaG9qd1BONnNUQ3RLb05WYmxiTTE3dHk0MnRl?=
 =?utf-8?B?S3UyalVRQjFLTmJFZ3RYZ3VHWUJPTkl0eS9UWnFIVDg2UzhxUGg1WGVTOGdI?=
 =?utf-8?B?M0hwZXFkdVZQNTY4a0lYNEQwb0pITGF3VmFCeTVhZVdBRy8yRXBVRjg5aVpi?=
 =?utf-8?B?R0ZJRmgydEt1R0RMV3Z5VG1XY1cvZzhRN2dkUW9PT1pCY0VtSGtnZzRiYXlv?=
 =?utf-8?B?Vk5TUGlHYlI3QkJDYVBIMGJoakZTWER0R1JhTjBBV0MzcDFWNzg4bmdPNlh0?=
 =?utf-8?B?KytpZ0dyOGxJTDZYTTJtUFlGVUxMRzAxTkRISC9ZVFZpbkZtb2ZBVjZIM1pH?=
 =?utf-8?B?azkyc3oxelpWMkpxeFZHd0NkMXVDeGdIUno2d0ZvemZ0UXlBbk5WbEhEZm1v?=
 =?utf-8?B?MERITlkvbEVPSU1xbG82MlhsRDZ1NUwyejZPUExuWTlBU0tWU29VaFpMdUR2?=
 =?utf-8?B?RHBjYUJJb0xtM1dOeE5NL0Y4U01VTVlsVkp5K0dWTHAySVhtSFd2WmlydmE0?=
 =?utf-8?B?bjdTMjhuNVhxWS9sTWpGcWpjbW50MXVVRFNkMkQ0WWhRVGZKNG1tbXVDZnV4?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17D527116F24DE469F05F60B307B3778@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SkKuXNj52M4fXYLdLxVhlJMPkCe12dmwz/Y0Qbg1ntwey/mFCIN25DF5IK4Ncy9beG5+QEis+R45A3/s4UJXpmow8OFenzPSb19eqx2J1V1rPlua12y3z4nfd8tMRdN7gRHEBcSwdgrQxTL97FBUuD1tf5zPFer9FAj1u918Q3ej5WBn6wNF5aj0qwZ9PUSnhXjmPz2zsiWNJykDkKZFckWarWrTj7gN8yYy49XYzg84yAsy7ToNgddLP2aAZjDmdBAcCfBRIewgdtHrzhKODdK63R/c3QkoGMOkZW9A1CXihQmZfm2m6IP8xYJM+A07DXU5OKawGNmvs/FiSeJkPxagdYsKvzps2foZGOJgCbJwfGU98cu9Dnuepe5C2NQCjMzavv70gqQ5N5yt7bZ2RqwCMDMFt4H+o5d24H3/w8D5kynt0Oa+c2E+ygDmQn8CSjmqTU2ZzMKoomdsJq5HPxVtl/oQLA5jos9rYaqLPsolKxsyPbZePWgWTaBMkkJs+BahwH4izPvKuCZIBtW2uE9pdl1bu6KJBOgoQHFAZUUMSsXqkeiyleWMSEH1rqHHTdSbHOD/oEXS43hDXs5btAir9gWAaQzOgGf81QbafkOza9RbAewydSZGGIBNsFZA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcd41b0-c260-41b2-916e-08dc224328a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 09:58:21.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vEYHIuXmjMp4t649SvTx0nlcR3iLyhdpVhrQg3Aei1ocbOUuqUOb0Uvhh4mO/8aipKUyD4ro75Y2w+hJCgPTklOZttL0c8FQJCX5Rsikxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9295

SGkhDQoNCj4gT24gRnJpLCBKYW4gMjYsIDIwMjQgYXQgMDM6MDQ6MjNBTSAtMDUwMCwgWWFuZyBY
dSB3cm90ZToNCj4+IE9uIHNvbWUgcGxhdGZvcm0sIHN0cnVjdCBidHJmc19pb2N0bF92b2xfYXJn
c192MiBpcyBkZWZpbmVkLCBidXQgdGhlDQo+PiBtYWNyb3MgQlRSRlNfSU9DX1NOQVBfREVTVFJP
WV9WMiwgQlRSRlNfSU9DX1NOQVBfQ1JFQVRFX1YyIGFuZA0KPj4gQlRSRlNfSU9DX1NVQlZPTF9D
UkVBVEVfVjIgYXJlIG5vdCBkZWZpbmVkLiBUaGlzIHdpbGwgY2F1c2UgY29tcGlsZQ0KPj4gZXJy
b3IuIFdlIHNob3VsZCBhbHdheXMgY2hlY2sgdGhlc2UgbWFjcm9zIGFuZCBtYW51YWxseSBkZWZp
bmUgdGhlbQ0KPj4gaWYgbmVjZXNzYXJ5Lg0KPiANCj4gVGhlIEJUUkZTX0lPQ19TTkFQX0RFU1RS
T1lfVjIgd2FzIGJlZW4gYWRkZWQgaW4gNS43IGJ1dCB0aGUgb3RoZXIgdHdvDQo+IGhhdmUgYmVl
biBhcm91bmQgc2luY2UgYWdlcy4gVGhpcyBsb29rcyBsaWtlIHRoZXJlIGFyZSBtaXNzaW5nDQo+
IGNvbmZpZ3VyZS10aW1lIGNoZWNrcyBmb3IgdGhlIG1hY3Jvcy4NCj4gDQoNCkFncmVlLCB3aWxs
IGNoZWNrIEJUUkZTX0lPQ19TTkFQX0RFU1RST1lfVjIgaW4gY29uZmlndXJlLmFjLg0KDQpCZXN0
IFJlZ2FyZHMNCllhbmcgWHUNCg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFu
ZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgc3JjL3Rfc25hcHNob3RfZGVsZXRl
ZF9zdWJ2b2x1bWUuYyB8IDMwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL3NyYy90X3NuYXBzaG90X2RlbGV0ZWRfc3Vidm9sdW1lLmMgYi9zcmMvdF9z
bmFwc2hvdF9kZWxldGVkX3N1YnZvbHVtZS5jDQo+PiBpbmRleCBjM2FkYjFjNC4uZDg0YmEzNWEg
MTAwNjQ0DQo+PiAtLS0gYS9zcmMvdF9zbmFwc2hvdF9kZWxldGVkX3N1YnZvbHVtZS5jDQo+PiAr
KysgYi9zcmMvdF9zbmFwc2hvdF9kZWxldGVkX3N1YnZvbHVtZS5jDQo+PiBAQCAtMjAsMjEgKzIw
LDYgQEANCj4+ICAgI2RlZmluZSBCVFJGU19JT0NUTF9NQUdJQyAweDk0DQo+PiAgICNlbmRpZg0K
Pj4gICANCj4+IC0jaWZuZGVmIEJUUkZTX0lPQ19TTkFQX0RFU1RST1lfVjINCj4+IC0jZGVmaW5l
IEJUUkZTX0lPQ19TTkFQX0RFU1RST1lfVjIgXA0KPj4gLQlfSU9XKEJUUkZTX0lPQ1RMX01BR0lD
LCA2Mywgc3RydWN0IGJ0cmZzX2lvY3RsX3ZvbF9hcmdzX3YyKQ0KPj4gLSNlbmRpZg0KPj4gLQ0K
Pj4gLSNpZm5kZWYgQlRSRlNfSU9DX1NOQVBfQ1JFQVRFX1YyDQo+PiAtI2RlZmluZSBCVFJGU19J
T0NfU05BUF9DUkVBVEVfVjIgXA0KPj4gLQlfSU9XKEJUUkZTX0lPQ1RMX01BR0lDLCAyMywgc3Ry
dWN0IGJ0cmZzX2lvY3RsX3ZvbF9hcmdzX3YyKQ0KPj4gLSNlbmRpZg0KPj4gLQ0KPj4gLSNpZm5k
ZWYgQlRSRlNfSU9DX1NVQlZPTF9DUkVBVEVfVjINCj4+IC0jZGVmaW5lIEJUUkZTX0lPQ19TVUJW
T0xfQ1JFQVRFX1YyIFwNCj4+IC0JX0lPVyhCVFJGU19JT0NUTF9NQUdJQywgMjQsIHN0cnVjdCBi
dHJmc19pb2N0bF92b2xfYXJnc192MikNCj4+IC0jZW5kaWYNCj4+IC0NCj4+ICAgI2lmbmRlZiBC
VFJGU19TVUJWT0xfTkFNRV9NQVgNCj4+ICAgI2RlZmluZSBCVFJGU19TVUJWT0xfTkFNRV9NQVgg
NDAzOQ0KPj4gICAjZW5kaWYNCj4+IEBAIC01OCw2ICs0MywyMSBAQCBzdHJ1Y3QgYnRyZnNfaW9j
dGxfdm9sX2FyZ3NfdjIgew0KPj4gICB9Ow0KPj4gICAjZW5kaWYNCj4+ICAgDQo+PiArI2lmbmRl
ZiBCVFJGU19JT0NfU05BUF9ERVNUUk9ZX1YyDQo+PiArI2RlZmluZSBCVFJGU19JT0NfU05BUF9E
RVNUUk9ZX1YyIFwNCj4+ICsJX0lPVyhCVFJGU19JT0NUTF9NQUdJQywgNjMsIHN0cnVjdCBidHJm
c19pb2N0bF92b2xfYXJnc192MikNCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICsjaWZuZGVmIEJUUkZT
X0lPQ19TTkFQX0NSRUFURV9WMg0KPj4gKyNkZWZpbmUgQlRSRlNfSU9DX1NOQVBfQ1JFQVRFX1Yy
IFwNCj4+ICsJX0lPVyhCVFJGU19JT0NUTF9NQUdJQywgMjMsIHN0cnVjdCBidHJmc19pb2N0bF92
b2xfYXJnc192MikNCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICsjaWZuZGVmIEJUUkZTX0lPQ19TVUJW
T0xfQ1JFQVRFX1YyDQo+PiArI2RlZmluZSBCVFJGU19JT0NfU1VCVk9MX0NSRUFURV9WMiBcDQo+
PiArCV9JT1coQlRSRlNfSU9DVExfTUFHSUMsIDI0LCBzdHJ1Y3QgYnRyZnNfaW9jdGxfdm9sX2Fy
Z3NfdjIpDQo+PiArI2VuZGlmDQo+IA0KPiBTbyB5b3UncmUgbW92aW5nIHRoZSBjb25kaXRpb25h
bCBkZWZpbml0aW9ucyBvdXQgb2YgdGhlIGlmZGVmIHRoYXQNCj4gaW5jbHVkZXMgdGhlIGhlYWRl
ciB3aGVyZSB0aGV5J3JlIHN1cHBvc2VkbHkgZGVmaW5lZCwgdGhpcyBzaG91bGQgYmUNCj4gcmVh
bGx5IGRvbmUgaW4gY29uZmlndXJlIGFuZCBpZmRlZiBvbmx5IEJUUkZTX0lPQ19TTkFQX0RFU1RS
T1lfVjIgYXMNCj4gaXQncyB0aGUgbmV3ZXN0IG9uZS4=
