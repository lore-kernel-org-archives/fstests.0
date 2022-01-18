Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CD1C35263
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 03:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiARDGn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jan 2022 22:06:43 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:50450 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349912AbiARCuo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jan 2022 21:50:44 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 21:50:44 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642474245; x=1674010245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aDuyeRvGi676jAEW4djYl8mPTO35xOT7jCDXs2njqpg=;
  b=s0I2IQuRpi0lY3V2i7sP+aq0xXQDf1eY4iyg/5sxOrfqht2jf0R1xjWw
   ngNk80O/khGCA/ul35RBgbNGYJ19FR0HEFo9afmDqsbf4YVAEMBDIIF7e
   UqGrUdCTrxRr9eyYX17TF7E8HdWzTH4hlNOIqASRkk/Pxw/XMCpLGrlaw
   lLWEDtkgh1oCbFDfv1swWfQC1lszZYkh6Fhpa0TIjmXHCj/+iRPIHvolZ
   2PYyK0QqNOySMDl1YsfiISWP7JdrYbaoUp5+UpP1xvsGw5AYKIltB9goL
   y8kzqxbVZF62KzyOauJoErq1kh8USebNfjjc9qhpxfJWQgBynyoz62yY2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="48778688"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="48778688"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 11:43:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpD30U8TMWGlE8mXYzhBtD8WGwVhnybPCgICFqs/ZVAjgUYDrIODqEgODWrDtKJTUJCmaHgdCph4PPPQbBePErDKqt1zZk66fIeyX6dkK8VwD5OrHDhuMjX8By9QnYo/dNOu6ylrfJtDbeoXM1K7nTYvkm5xl5sUqFxMQECREKCOa/4LXC4LQHjqy2VH0NBWz1NBbe/oWJFetaOOghbvQ6C+DS9YeSLNt5HH5xDz1HwQKvgx36/R3GPJ/FWbW9Rb4sUY+DKKjExBPIzN0XLhtVjv8zgb/9rz3EL951UgUPEAYuh2ldG2A74Yx+7bHz+kdD+zaGqxD0uQyDstD2baOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDuyeRvGi676jAEW4djYl8mPTO35xOT7jCDXs2njqpg=;
 b=gPBkr8Ct5rxxdXtJLWAwZ7CI7EiXyQA7IQie7ggkuKj4sjqxx6c7BM2xNCrJZIPzNnlsSeTnsny79DtzHQikr8Ry0czCdvRStco9XyuVwqo6fyo+ZB7+iGgGvXUwWp9EHlAa7E9q+LyvoalUvoZTSCbf74MJv4DD9jcwMrhRDZ1653LUViiVDKv8Wa6PE+mubU/5A1nwJrCLCGln8zp5FaimZS7TOX4qfpHFwBNOqjpGFy+GzXiF7PJOA/drixRaVWBSYdKE3XMNlphtZ3lAE7sy0aXe2sEvvrXpzoiVfmRsIyC+oEbQUx1YUZoAGc1G5UtczfGPeSEmxbr9clQhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDuyeRvGi676jAEW4djYl8mPTO35xOT7jCDXs2njqpg=;
 b=HXRQ6LyroB/chv74HJwuXM7geg7ajQAYMhW0og7apMzkVKqQz/oFic1wRNNAUzyzj8mRBpPil2cPtL+Pq2/Tim179jK0vVnAPmYr0BZto7Rq6bL2sOm3/SExs3fyszWSA85akXb/dsXPBWmev+o3AuQoZundhzZebpiHBp5VdWA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4031.jpnprd01.prod.outlook.com (2603:1096:404:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 02:43:26 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:43:26 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Topic: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Index: AQHYC3T1GUs88bXDK0iuG+0P5NW4eaxoEG4AgAADSIA=
Date:   Tue, 18 Jan 2022 02:43:26 +0000
Message-ID: <61E6298D.80006@fujitsu.com>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu>
In-Reply-To: <YeYmzJG5M0y9BcMc@mit.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d21a6a4b-f796-4b1b-a935-08d9da2c4d58
x-ms-traffictypediagnostic: TYAPR01MB4031:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4031D2D8683EEA311FA3C4BCFD589@TYAPR01MB4031.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKXIHqVBZPoQWDRFYVb1ELTobb/xLhxvzG2VPeUQjTWMGKaoYyvhDdFMxnuOYbZRShXGJJju4HyjHczTdZLPteEhpVrCURCM7gO+fdncc1n4ouOILYkDyq+MyyG3RbDZ7p+DdBPQzvid867+S3gqF4oSVfend7TNK9ZvbF2akGkOUUHwItBrMH+vPTTgJVLmXwJ1/A5HYKu44qPl3e7c0Lqx3gj4yd0ucGsjwZZA9V4fqu6rEKOxdhbMbiz9RQlz16Lm39m/PI1J16MlskzU33dytZvlBLX1IL/vLh6GmTSR69dIMwFXUbtqH+vi0KRqODxIekZpkJ9ZchAvT06MRWGuA7n9Zd9RFCjHPpYPEXy126ua3I5QO1CcEOhsY+gDL3vrvaD0HZh6yr1OU0ilcFZINR3RUMkU0q4CcBifwHEYsUtZ8clU0DJOkx7cPkZ84uss+qLQCFqlE/rtSvtwit0xbbbcyIqUPJ5EDbxJCVM4OewoMF5P6Tzqa7OkPznY6KutsqAjUPw+URM3oDYCQS8ZocWH511O81OjnP4AYigs/W+sw9w+g714G7QRVMIMXSvTE85ZHClSqdJbTgetPxoUr5AG9cVAL92IN+6sSFxmQsuIF9jZc18SJGsjOtir/A0YX2SDrifacwm/9Lp5PadmOCLe5OjjDbbK+umN69FlYPSNuCmE2FY1QdL/wA/7frNI+Eo/arOaeI+fUhoQww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(508600001)(8936002)(6506007)(4744005)(86362001)(26005)(91956017)(76116006)(66556008)(2616005)(66446008)(5660300002)(66946007)(64756008)(85182001)(186003)(316002)(6486002)(66476007)(6916009)(4326008)(6512007)(122000001)(71200400001)(83380400001)(33656002)(38070700005)(38100700002)(36756003)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WGxzRmcvbUUyMzZtdjNTMzA4WEQrZEw2MWEwZkQvV2NFcEVaNmFwa3FpYkE3?=
 =?gb2312?B?RWJJOGpqOTd2UWRLZldJakJXSGtzbmNOTjA3T3daUUNwcjhZSTc4RnJaMzQ1?=
 =?gb2312?B?dlBMeHdOMTVJUTRnWnF6OFVteSsxa2JjYVUxT2pqT3VEMytTcUJRNUFHQjVJ?=
 =?gb2312?B?SWxHWXBqNjZtelNzaVZlTlAyMklkQmsyL2MzVUgrbVc3TmVGaTJOamhra2RR?=
 =?gb2312?B?dmNHRmxVMHg0QVplL1U1aVhyY3B0YUhIOWRrWjRpaTI1eVA2bzlzdkdqUXZD?=
 =?gb2312?B?dUpSK1ZIV2krdlJOY2l2OWZHTTYyeWhkRUxEakV6NlNtcTh4NURnNXlUVG8r?=
 =?gb2312?B?Z0VIb3lvaFgzZVovV3B5aW1BUjFzc3FFRVpXZFZOZml1WFo2V3hPK21ISXEv?=
 =?gb2312?B?QUpNNHA2SlgrOHdyQ2p5WDJxcGw3dlFSNGw5N2VwZ0dCUUlLbFJCeThmSnBE?=
 =?gb2312?B?ZW1NdXFld1dWN0xsNXl5OE9rSC9rYW1mSEVNZlh0enl1MGZzZ0VZTkZ1aVRp?=
 =?gb2312?B?cDhtb2hlY2JBVm83WFRYa2VVNTdGS3RUUnB3SDFib2JEZG9hd0JsQmFHUGlQ?=
 =?gb2312?B?eFRaenkwK2k0bjg3MTdJd0RTS051L2J1QitGV1V5eE5TcXJsTU10K2w4Nk9U?=
 =?gb2312?B?dFhVNW1iUXpzK0JhblBpd1RaSko5dHdKL2tNSGdzeXdOQnF5a0dBbmcxMFkv?=
 =?gb2312?B?eVdNZFMyUDNCb3lqU2dNdlkyMjlVMWx0TVFpWEloZUhWaE4wSUZ1SjVOKzJS?=
 =?gb2312?B?TGVhY29kYU9LaU5lbGZ1WlFXMGt6VmE5QlFTWjhadWVmS2VsTWxvd041WFBH?=
 =?gb2312?B?K2xkTUM3OXcxaXh4ZEhMcXRVUU5MUS91d3RLSGFuMW13Q0Ryb28wZDFMWUsz?=
 =?gb2312?B?M3ZpMUVVZDNmTXNPZVNKTmx5NHRtOWFKWUxMdnJFcWdsdG9RTVJZMis5bkhv?=
 =?gb2312?B?Zi8ySUFNSTRNekpNRnROL3VpazlmR3FEVjNKb2xZN09vdlpIQmtwZTVXTDJu?=
 =?gb2312?B?K214ZDVDUzB5d0pWSmtDV0dJR0JmVEUxK3d0WEJiaHNnOXR1bmNBRC9Fb3h0?=
 =?gb2312?B?WFlLN3gwYVFJMlJ0QlZTM2pHYnErMnRwaEZ3VWNLdm5YS1FuUUhiMEFybzBI?=
 =?gb2312?B?RUpkK3F6dU1sRFhuSGkrWExFRnNwell3VXZ3bHBuVUYyTlA3dWRERjVKaTZ4?=
 =?gb2312?B?UXRXNjhWSUIyQkZPK3dkWUlyNXV3RVJpN3NHcGRpWklJM2IvM1VBYldVTmNy?=
 =?gb2312?B?V0ZYZ25tVkZ1Z3RGb09HWjcrQWREUmlZT3ZxQnNUREc3WDZLWnZoaVhvVkIx?=
 =?gb2312?B?bmVFOGk3VE8yY1RDV1UzUGVDcEhBSzRkKytnSlRuVGRaSk50ZHE5RVU5cW1T?=
 =?gb2312?B?dkNNdERiaXJCRU1UZUJsanNwMlZMc0NLQk5UM2h4NEdERDRqcXZoOENYdHhP?=
 =?gb2312?B?a2tLL0RoMHNxTlFEcGxPTHpBS0crQjZqNlhYc3hGWHFjWE0zREZieDJLVGo5?=
 =?gb2312?B?WDYrTW4wYnVMMXhiSXBJR1VQeG5Ra0RoWGQ2OEcrbSttRWJrRVMwbXdKMTQ0?=
 =?gb2312?B?enhaWVByVUdpdFJaYTRJS3c3K2tIek5Gdi9rVjRZM0pGdXFibXNIVkFLSkNn?=
 =?gb2312?B?K0RKY3poM2JHWXJVYlJJUVZCRUp6Rlp6NGdLSlZZS0Z6aVM4Qk5Bc2VNMXJZ?=
 =?gb2312?B?ZXVPZ3NzaUVxQjRZYUttLzZDT0xORnMrNXR2WExHTzFtQU5KR0d5SUZQRnBn?=
 =?gb2312?B?eDdiblNVTWtnRzA3ZDlkUHpaRUZtdE92bzJlY0wyMmsvWjBpK2hEVjhpZ1dN?=
 =?gb2312?B?V2hpcXVOTGFwNnhBR1YrbFFPVGJKaFlYWnhYUE9ZUG95eGxwY01mUFRJZjlu?=
 =?gb2312?B?MWRjT2VxZW9adTFqQ0NNSUNxeVAybXo5L3lEL3BvNlo2RXVOMWJTQTNFTENE?=
 =?gb2312?B?RCtlaVdZdklZZG1xeWVucDlaV0J6TEhtV0V1TmFqdWFwdC9aVEVKOW9MSlp2?=
 =?gb2312?B?MTVHcmZ0eG1wTVRGUmgya2ZzdHFPVklEaFZ2dUhMbGxDVXpJK2x6TEVjY2VZ?=
 =?gb2312?B?OE15eGN5QVFSelRMTnRxb2dOZHg1Y054M0lWTENQcWN3OXdMUkpNWUJabENa?=
 =?gb2312?B?RDRzWEcxQVNkMlBaV1NNUEhNMy92ZjZBRmpBR3JIdE9vbnR2OC9ZMFNjdHpZ?=
 =?gb2312?B?em12a1lYTTVFdTNCRFlTajRKYkpjK01SYnBpVUJCSXNrbE5jRndKdDRLMU9y?=
 =?gb2312?Q?khYm7ATwUJlyep1+QIC98FVodKJlGgsrhSRHby/U9Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <AA8199EA90CD4E439B5FC71F531A89E7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21a6a4b-f796-4b1b-a935-08d9da2c4d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 02:43:26.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grVujkX82icR8I2b2gxLRXuZcKyTSpnBkhKWorygLZIV8nOvcGY6PdLwpr79PQpaLO8UUE8LgcfDpJXzWStHOHILiiSfILBWngHSAMotKIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4031
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8xLzE4IDEwOjMyLCBUaGVvZG9yZSBUcydvIHdyb3RlOg0KPiBPbiBNb24sIEphbiAx
NywgMjAyMiBhdCAwMzozNjo1NFBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gT24gbXkgdGVz
dCBtYWNoaW5lLCBleHQ0LzAzMyBmYWlscyBldmVuIHVzZSB0aGUgbm9uLW92ZXJmbG93IHNpemUu
DQo+PiBJdCByZXBvcnRzIGludmFsaWQgbmV3IHNpemUgd2hlbiB1c2luZyBzdHJ0b3VsbCBiZWNh
dXNlIGVycm5vIGlzIDEuDQo+Pg0KPj4gQXMgbWFuLXBhZ2VzIHNhaWQgIlNpbmNlICBzdHJ0b3Vs
KCkgIGNhbiBsZWdpdGltYXRlbHkgcmV0dXJuIDAgb3IgVUxPTkdfTUFYDQo+PiAoVUxMT05HX01B
WCBmb3Igc3RydG91bGwoKSkgb24gYm90aCBzdWNjZXNzIGFuZCBmYWlsdXJlLCB0aGUgY2FsbGlu
ZyBwcm9ncmFtDQo+PiBzaG91bGQgc2V0IGVycm5vIHRvIDAgYmVmb3JlIHRoZSBjYWxsLCBhbmQg
dGhlbiBkZXRlcm1pbmUgaWYgYW4gZXJyb3Igb2NjdXJyZWQNCj4+IGJ5IGNoZWNraW5nIHdoZXRo
ZXIgZXJybm8gaGFzIGEgbm9uemVybyB2YWx1ZSBhZnRlciB0aGUgY2FsbCIuDQo+Pg0KPj4gU28g
YWRkIGEgc3RlcCB0byBzZXQgZXJybm8gdG8gMCBiZWZvcmUgc3RydG91bGwgY2FsbC4NCj4+DQo+
PiBGaXhlczogOTJiOWMwZGVkYWNlICgiZXh0NC8wMzM6IHRlc3QgRVhUNF9JT0NfUkVTSVpFX0ZT
IGJ5IGNhbGxpbmcgdGhlIGlvY3RsIGRpcmVjdGx5IikNCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcg
WHU8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4NCj4gUmV2aWV3ZWQtYnk6IFRoZW9kb3Jl
IFRzJ288dHl0c29AbWl0LmVkdT4NCj4NCj4gWW91J3JlIHJpZ2h0IG9mIGNvdXJzZSwgYnV0IG91
dCBvZiBjdXJpb3NpdHksIHdoaWNoIEMgbGlicmFyeSBhcmUgeW91DQo+IHVzaW5nPw0KSSB1c2Ug
Z2xpYmMtMi4zNC4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+DQo+IAkJCQkJCS0gVGVkDQo=
