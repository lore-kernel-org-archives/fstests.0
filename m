Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482AC2B9F4
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 02:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177F96112D
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 02:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWCvw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:51:52 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:59132 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229786AbhFWCvv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jun 2021 22:51:51 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2021 22:51:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624416575; x=1655952575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=etl3bW8lw28WOs5HCWeYIG27QCuTz0vZuzYqG9IY8KY=;
  b=Qa12nPgp7YbSxE0vHi1GXXf8BDI8J0RpEUqJOERsvcuYcM0429o7DxRh
   Pez7wjzutL9bS4jaB8Z+vbRZZ0ZQ1D6VGeY5/icvF9kUJTy7uMTmQ2POz
   XYln5N9J6pneF4N1pyuYf1HR18pX7s6eDp+/3lCjFdQfe9wM5L9qLyVJ4
   iMHtrAJR59uXJdya6huuLjNbNrBD4TdowDo1u5xSuF0knj/r4lb7oncTy
   YfdbNd63PeddxAjanAf3P6J5mkl8aK21MhFTyy37l9U3xG/ojHzUk/3bn
   G2atZRTnwIUW11hHT4XeGiDGlAB2hXm4ZX6pQsuHKyiC1Cq+23D9Mwxku
   A==;
IronPort-SDR: yY+OmnYaBNgI5UeGetsBJbgTlExclTlQz1Fc/YiO2P7ri6CqBDoYUY77r7ZmAbUJd+Xk0yPESC
 M5ZuLd86x9NEihgsdbOB3nsicgZCiMszsfQJriuToaVdfLF1negHlseQWQTO37QNELpCYqH4OY
 SftczQibybZrMXZdwJr+QE4FuFiVMfUic7AUXPnno9vDZIVxH4n52ovFeEQcR0SdRWlD0YTU9H
 2q8YXWAmKC+vWOCeSiro+ZBHwXAIbPMRnKkXn4iJdQWsG94HKrIeq8hn4mUNmc5YfnpNRh8O1l
 jhE=
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="33654595"
X-IronPort-AV: E=Sophos;i="5.83,293,1616425200"; 
   d="scan'208";a="33654595"
Received: from mail-pu1apc01lp2056.outbound.protection.outlook.com (HELO APC01-PU1-obe.outbound.protection.outlook.com) ([104.47.126.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 11:42:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CduajE60fMmmRSzPqfayr2fuKHY91iOipwuSO4z7k5t1iblLQVNI1pK4i+kDHfYrrf5Kt4z9OoXMKiCZlhOOi4t+Z2wRW7ivR0oJNqZJB8U4makTRz2tyDFbbb/n2SuLXqWy6qQcBdAKWt8ZOPjJOLq4nLafMMxdGijmtHWk1s2O34+kHKUcvanIn/93/75PXzs81BFSIV7SWj8sGnioo3zd0Z4BCcr2lKrl08HGmc7jOkXQ8np7JexLqViIwPHWvTBjdZz5jUl/TE/AclsmWOzAu48aaRg/vZ8s6Ri+QorCli4FZtOsY+/QyTYXP5rCjWXwJt8AwtFgXwM1M58UeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etl3bW8lw28WOs5HCWeYIG27QCuTz0vZuzYqG9IY8KY=;
 b=VsgyVn7MqW/M1TCEJgLrHNPqtB4HhThmQkXQTtUmG75iX0b0ln5JZaUbjZbzcBPBNE3FS/4a5xz3sSIfN30X9+xh0U2l2g38BAC+YEFC6BgU9nvH67Z/mTS5SPeDT98Zu+Xew41GCpZlJ9CSuTxeIyMDOq1+M4YnuTXiGgokp77URDgloYp0PqkegcbZtDMxNeZ/GXri7CFW7UqJm2GY14qqj1wEon+iEtfD/nzhhpnJdSMoO36MajGrz7hjnuueZDrl/ZM5tkipSJE7MFNSYqflLoN0t/GaQwAmpO1gYJhRkB5DXGJmY/SprHa3SldKWW2PYUZ8KwktIIgEx0zjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etl3bW8lw28WOs5HCWeYIG27QCuTz0vZuzYqG9IY8KY=;
 b=Yg9q9QbEaVK+LllNzShHe8aXAH3yzJkNY3PjVRqrKJx0Re/07sWIB6f4i+5QxeeO24eo4MM6Kd1pp0Y/CSFkmeoUL9AO1O2qhrJOd7zAd/3BqaUH4OtZuXyNzf9U+BH8ga6fKY1InzpQW2Gl7ZOe2YOynU55ybvV8gBGXV78hOg=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2332.jpnprd01.prod.outlook.com (2603:1096:404:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 02:42:22 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::f84c:9ac2:ee90:c6d4]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::f84c:9ac2:ee90:c6d4%9]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 02:42:22 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Thread-Topic: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Thread-Index: AQHXZsImHcLnKPExrkqddjkUR+DyD6sfRtKAgAGemgA=
Date:   Wed, 23 Jun 2021 02:42:22 +0000
Message-ID: <60D29FB0.5040701@fujitsu.com>
References: <20210621164851.1808923-1-tytso@mit.edu>
 <60D143E5.9040204@fujitsu.com>
In-Reply-To: <60D143E5.9040204@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb269064-46ec-4b24-4b3f-08d935f0870e
x-ms-traffictypediagnostic: TY2PR01MB2332:
x-microsoft-antispam-prvs: <TY2PR01MB2332BAC0588C6706F267774CFD089@TY2PR01MB2332.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mT6bSoUw/GEHTMP946dzQiPZMPxxzy5Y4HzqML2REhRi1U7KQqkUWqMqaq6OVyta19q5Oakql7CbD7AVQQPai1bFi+f+mM87ES/TWmCvX16bzE5QWHaLpylFlSwpMS90y5jcXMeOp1dPaHU6861JNVnCoXb8+L44cfjyziywp1o3xCiidE9XKooCbyE7l+T7Lvt4dpJ7W5r6NNrX2qPtHA6ZdjP3CIUT99RJtZFjPVfceEyO2EROMWwVfhRDZXghN4tSJKpzBaiXfJlkNMnoB0zK5S/UicYum/beP7f5GEgf+Ag32aZtNbJlyiwQKQsztZfAKh9UBkbBH/UgPhlZjlyK0lcdhzJl7PrX5KJmJ2iKs3g1KrQSYTvwyA1Q/i4FhT/IeuKmzQyncfIhgE82fYtE2BzoA3RP9i4gvh6jfuUvVcw/a+T5PKcGrV9KI0EWuesU1LGjLpjQssIq8hbmzI0zXrBmv2URqzoEyhxxUxSujuHc6fNu9pbMyWgInStpTOVNXAgiZQSVlCzpN46x872z0Mv/3a45VkQlJ8eqTkH7aprF1ze0VQj7Z3Pab9uTGN1Yvh7KV4twGX8+VINMHn0r9s32JRLjJuR7GwA5P46v9TFo8a724gyC8N03aBmspQjD+VlFKqKNqr0UGoeJFMhWeCbWchvN8zBVP85OECOWBnXuD1cpzd4eSZW7omAmOz6jUxCc6XI7RiM4M5l3ZCH8qIe5bKdgcr+imm7YlUeYdPGT9l2nmDr76A9a/39b1b7Je2Uf1qyWpCHko6DYOxHyhmDpi/rsldOR+VrfmoCNChx7S6emxMz+QJ+YT/jH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(66446008)(64756008)(122000001)(38100700002)(76116006)(66556008)(66946007)(91956017)(6486002)(66476007)(6506007)(2616005)(6916009)(5660300002)(86362001)(87266011)(4326008)(36756003)(54906003)(478600001)(71200400001)(8676002)(2906002)(26005)(316002)(33656002)(6512007)(186003)(83380400001)(8936002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OThoekh4Vi9Jc3d6ZUU5Y2VnOWJzcWsxUCtuY1E1TUh2c0dFTTdIbGxPTzZS?=
 =?gb2312?B?UkZiMHUxRFdmZGFoQVYzbjdCUUpQcG9jblFydTVSKzI4eFpHSFlVbmQxRTR3?=
 =?gb2312?B?RGVsTmkwSWpUaS8zRStaSVRBVlRoT3lCQ0FLR1RRN0VHcjdTT2xxUVREWGll?=
 =?gb2312?B?U0UvM1g4anFaYlQvcElsRERVc2xMRytzZ1hmZXhSM1I0dHBOcU9GZ2hGb3da?=
 =?gb2312?B?M3h4VHZWTmpHZWFLc3BkdDlNaWx5d3dVV3JMQmlmdUFydzVRaTh5eWZhT0kr?=
 =?gb2312?B?SlNCbDlnWVZKV2txVEhNL1laVnRuV0doZEJiS2tLUml4SCs3MHBBRUlyS1RN?=
 =?gb2312?B?ZWRpUVJaK3dTemRYMEU5RDl3VUxmU2RVV2VnWWFjcjgza0c2bDZOTjJXVUVD?=
 =?gb2312?B?bEdmSDExV3lFdkxsZUxWNW9yaHUxTnhlQ1RZdU5janA2SitNdGdhR1FYUUlV?=
 =?gb2312?B?NHd1Q29BbDNsUmxsZUNtRHN5MmFaMjJnZEZkTTRDT2hWczNaRWJOVU0xY1pk?=
 =?gb2312?B?R1VMQnFNeW5tSGJ0K2pQYm1nOTBBZkJ3bFI2S29rbzU3UzVjQmgzOHYrcU85?=
 =?gb2312?B?WWN5bnAvZ3BuNnN4UGZXTU00eTJJUFZNak1oZ1NnbEZzWVY0SDAxVzYxYkdK?=
 =?gb2312?B?RWNvbEh6c3NVL1RvVitsOHRtNmNnQlpUQzVYTjBkNU0zWWorNGZOdEk2blI5?=
 =?gb2312?B?SnY3SXY0TE1wbVRYUER5bERKVFl2dFYrRE1nUngxY0REenQvc29QWkdmV3Jn?=
 =?gb2312?B?ejduMkFwa1hOazNqR2tGT1Z5T0xTak9MY2t0a2oyaTVjbXJqMlZaUFVnMnU5?=
 =?gb2312?B?bEU0bytNcE5HOXM5M0NkcHBPb21XaVNnZUwreWsrWHRrR1prakIwdWNaL0Zs?=
 =?gb2312?B?aU13RjZGdWJvV0x5NVNNTjBJNFpkb1JTa0d2WklEMEJMM09aOUlkN1BwMWND?=
 =?gb2312?B?cmtuNGYrY1k0d3RjV2xBK2ZuVTNSL0JVZ3hSL0Y1U1A4RExyS1Eza2Iwek1y?=
 =?gb2312?B?S3V4UDIvbFhCOEorZE1HWlNkSlpZNmU5anA2UldoaThjUXRyVUxtQ2RBZkJK?=
 =?gb2312?B?S1BRVU5mdUdRZDFOWXhqNHBzQUhLRVNndDBNVTM3MDJrY3NRUVdwUUdTMm1a?=
 =?gb2312?B?citZRlRZTVFYR3ZCVzExRG1CRU5ZcFY3S0ZLQnRKeWZQT3FNcXlrVlJhaTZz?=
 =?gb2312?B?ZTdEaVRDNkVBS1l1bVZJTERLRFUrYnFvUmN6OHFzSitGWmJZSG1KUzVNMmp4?=
 =?gb2312?B?S29KR09WYm9KTHVxK3o3T3VPVmV2K0pjdFhrSHlkbVNMc1o1SGMzLzQwZEJG?=
 =?gb2312?B?RS9lMzJxc2kyeVVacS9scW9ONFBoV0J3V1pQLzN6SkkxTGR6b3ZMcXNHaWtV?=
 =?gb2312?B?MHZKa0NkT0l6L3dGVFlCcUlJdFVMNjZwSG55V3Zod25nakUreUVHUmlsRW8v?=
 =?gb2312?B?OFFLYytqLzNMaTRYYkE0RjVCNW5FZkxxQldRUkJyN0cxSGVpaVk2c1NLR3BF?=
 =?gb2312?B?U1pVcC95dmxTc2xpcDA1N2ViQncySXpSRXpxMml0WFlkTUpBdk5TUlVYc1JU?=
 =?gb2312?B?VlFFc0lNYmZoQitjQXArZjFRc0NjdHhVTlFEZHVOdm5YU2I3WGgzUFBIbGtX?=
 =?gb2312?B?OWZIUFhwQmQ4Vk0wM3NJdFNrZXdFcjVSNWZvMFlKdlhBaGJWNm5rK1BaQmZW?=
 =?gb2312?B?MlV4b3Jkb0RNM25mNHFjSUlkRTNKTWlMWDZscGIvZFJkenJpMHJCa29SVy8w?=
 =?gb2312?Q?3dDAEWdeOiXyKs84rdz2w2L70gEuflCMuLk7bVz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <D582F03476E7944CABC750ED6AC3B92E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb269064-46ec-4b24-4b3f-08d935f0870e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 02:42:22.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCjEu3Pl2CU0ilgMd6FI2ZaEVE1xHy8yFLiQgN5pJ8BSA8VjN2txkxIkIdg7ybjZF25qBQY0MXKvGHUN+ZAeEYSPdEmZKkV2GR0NYzK3rl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2332
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMS82LzIyIDk6NTgsIHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+IG9u
IDIwMjEvNi8yMiAwOjQ4LCBUaGVvZG9yZSBUcydvIHdyb3RlOg0KPj4gZXh0NC8wNDggd2lsbCBm
YWlsIHdoZW4gcnVubmluZyBvbiBvbGRlciBrZXJuZWxzIHRoYXQgZG9uJ3Qgc3VwcG9ydA0KPj4g
dGhlIGZpbGVuYW1lIHdpcGUgZmVhdHVyZS4gIFRoZSBqb3VybmFsIGNoZWNrcG9pbnQgaW9jdGwg
aXMgYSByZWxhdGVkDQo+PiBmZWF0dXJlLCBhbmQgbGFuZGVkIGp1c3QgYSBsaXR0bGUgYml0IGFm
dGVyIGZpbGVuYW1lIHdpcGUgZmVhdHVyZSwgc28NCj4+IHVzZSBzdXBwb3J0IGZvciB0aGUgam91
cm5hbCBjaGVja3BvaW50IGlvY3RsIGFzIGEgcHJveHkgZm9yIHN1cHBvcnQNCj4+IGZvciB0aGUg
ZmlsZW5hbWUgd2lwZSBmZWF0dXJlLg0KPj4NCj4+IFdpdGhvdXQgdGhpcyBjaGFuZ2UsIHRoaXMg
dGVzdCB3aWxsIGZhaWwgd2hlbiB0ZXNpbmcgNS4xMCwgNS40LCBhbmQNCj4+IG90aGVyIExUUyBr
ZXJuZWxzLg0KPiBUaGFua3MuIFdpdGggdGhpcyBwYXRjaCwgaXQgZml4IGZhaWx1cmUgb24gY2Vu
dG9zNy45IGFuZCBjZW50b3M4LjQuIEJ1dA0KPiBJIGNhbid0IGZpbmQga2VybmVsIGNvbW1pdCBm
b3IgZmlsZW5hbWUgd2lwZSBmZWF0dXJlIGFuZCBqb3VybmFsDQo+IGNoZWNrcG9pbnQgaW9jdGwu
IENhbiB5b3UgcHJvdmlkZSB0aGVtIGluIGNvbW1pdCBtZXNzYWdlPw0KDQpJIGd1ZXNzIGZpbGVu
YW1lIHdpcGUgZmVhdHVyZSBjb21taXQgaXMNCg0KWzFdaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdHl0c28vZXh0NC5naXQvY29tbWl0Lz9oPWRldiZpZD02
YzA5MTI3Mzk2OTlkOGU0YjZhODcwODY0MDFiZjNhZDNjNTk1MDJkDQoNCmFuZCBqb3VybmFsIGNo
ZWNrcG9pbnQgaW9jbCBjb21taXQgaXMNClsyXWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3R5dHNvL2V4dDQuZ2l0L2NvbW1pdC8/aD1kZXYmaWQ9MzM5MTgz
ZGZiODdjZTk0ZjhlMTRhMGRiNDhjYWUwOTM1MTZlMTk0Yw0KDQpTaW5jZSB0aGUgY29tbWl0WzFd
IGlzIGEgZmVhdHVyZSBhbmQgdGhpcyBjYXNlIGlzIGRlc2luZ2VkIHRvIHRlc3QgdGhpcw0KZmVh
dHVyZSwgc28gc2tpcHBpbmcgdGhpcyB0ZXN0IGxvb2tzIG9rIG9uIG5vbi1zdXBwb3J0ZWQga2Vy
bmVsLg0KDQpUZXN0ZWQtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQoN
Cj4gDQo+IEJlc3QgUmVnYXJkcw0KPiBZYW5nIFh1DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGhl
b2RvcmUgVHMnbzx0eXRzb0BtaXQuZWR1Pg0KPj4gQ2M6IExlYWggUnVtYW5jaWs8bGVhaC5ydW1h
bmNpa0BnbWFpbC5jb20+DQo+PiAtLS0NCj4+ICAgIHRlc3RzL2V4dDQvMDQ4IHwgOCArKysrKysr
Kw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS90ZXN0cy9leHQ0LzA0OCBiL3Rlc3RzL2V4dDQvMDQ4DQo+PiBpbmRleCA1MTE4OTYxOC4u
MzVlNmFhN2YgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9leHQ0LzA0OA0KPj4gKysrIGIvdGVzdHMv
ZXh0NC8wNDgNCj4+IEBAIC05Myw2ICs5MywxNCBAQCBfc2NyYXRjaF9ta2ZzX3NpemVkICQoKDEy
OCAqIDEwMjQgKiAxMDI0KSk+PiAgICRzZXFyZXMuZnVsbCAyPiYxDQo+PiAgICAjIGNyZWF0ZSBz
Y3JhdGNoIGRpciBmb3IgdGVzdGluZw0KPj4gICAgIyBjcmVhdGUgc29tZSBmaWxlcyB3aXRoIG5v
IG5hbWUgYSBzdWJzdHIgb2YgYW5vdGhlciBuYW1lIHNvIHdlIGNhbiBncmVwIGxhdGVyDQo+PiAg
ICBfc2NyYXRjaF9tb3VudD4+ICAgJHNlcXJlcy5mdWxsIDI+JjENCj4+ICsNCj4+ICsjIFVzZSB0
aGUgcHJlc2VuY2Ugb2YgdGhlIGpvdXJuYWwgY2hlY2twb2ludCBpb2N0bCBhcyBhIHByb3h5IG9m
IGZpbGVuYW1lDQo+PiArIyB3aXBlIGJlaW5nIHN1cHBvcnRlZA0KPj4gK2lmIHRlc3QgLXggJGhl
cmUvc3JjL2NoZWNrcG9pbnRfam91cm5hbCYmICAgXA0KPj4gKwkhICRoZXJlL3NyYy9jaGVja3Bv
aW50X2pvdXJuYWwgJFNDUkFUQ0hfTU5UIC0tZHJ5LXJ1biA7IHRoZW4NCj4+ICsgICAgX25vdHJ1
biAiZmlsZW5hbWUgd2lwZSBub3Qgc3VwcG9ydGVkIg0KPj4gK2ZpDQo+PiArDQo+PiAgICBibG9j
a3NpemU9IiQoX2dldF9ibG9ja19zaXplICRTQ1JBVENIX01OVCkiDQo+PiAgICBta2RpciAkdGVz
dGRpcg0KPj4gICAgZmlsZV9udW09MQ0KPiANCj4gDQo=
