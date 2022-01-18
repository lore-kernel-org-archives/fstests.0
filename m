Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA04C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 05:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiARF1Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 00:27:16 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:9892 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbiARF1P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 00:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642483635; x=1674019635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PQAf+dITBPlqRxmPtMYFG4bYVMhnaitdpLFpCVhpfMg=;
  b=N5MbLTOx7Dh4xMLhZL44GSZR6Vux1zd97tw3gah5FrCOxhDEhwrlP524
   BaiLxpAzyoQFFr2JSIQfaBgw3VoNIkLuWT7agkwxD5RJxtGnWMqBUoVOf
   E549hoh40Eboyly4VznZ36cXbmyGcCzWB/Bq8g+XbQPinVaq0jRD6nDzm
   lE2EMWBr/ZCxutD0BV5+gHrorCVcbNq5o70bgGOesqnrWm8WadIFCSTfF
   FsBulaU6ocWk6mbkWA/H/iYUuSVsZUBPnPNfTZzBJtv4lLiuWdiGHCSE7
   F2TNIEoWfi5ympOvV+rRnwKIyV5R/KC2CxOd4y/rH+GnHf4sn8Yhr8whQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="48122251"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="48122251"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 14:27:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPJRfH/NWkVrBXOuAl8kivItyoa2rso4xvPqKElgEE4ZBKROwbEnqnb/r7Y1Ic4nbz1kUpR6ovU33R1c3lNaT49lt9rR9/TUQgUW026hoSeDX4I6vzDbVqwA7fHw2Sk8k9zsteOQA7IQCSQ2MpL81C7JvbhSqLt92dw6bJDh1jFaf8DW+3vX7h47Y2J0qBNp9EjzyBBTbAmltrhNJU5sk6YEftPpLaVpRT2HVV03Ah17PrheVsNAk8mvMK1SUqOrpogey47bPXllAJuzhbbe/x3lhQ9lqPjQuPlG5HdKm9TUYPXuGIp+mLqBzH8EsEl7B4HBsA76/UJr2DRZanZgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQAf+dITBPlqRxmPtMYFG4bYVMhnaitdpLFpCVhpfMg=;
 b=UYN01COqQDZ+VxEQvIw0slAWDXoNPD8gBW7bH5hLuoU7WxIss2rrSj7iU3XMJ/s1Rph36QfvcCnfMa02alX+x7cozqbvVePeXZi/+pGFovFLj66LPBysr/z7WWDfaCDED9f6ybd+FxnkYKjDLASlXYf8fgQzPGqmDLY+LJYWUWkzmzwebtfJjJkT6BncdyrBBvahTGYlDdBY7JJ49ASv1Rd+MerKzCizmvFG4vgRQb92knT08bTDAnWNAtNnr/93fN981FHL5wvvFkPBN+HOIA95SrvTrBEQ5hIL1bttA8FdHxba4SZtw21q9rGBviayBEWTuUDmFksu9hYc4KXikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQAf+dITBPlqRxmPtMYFG4bYVMhnaitdpLFpCVhpfMg=;
 b=NBUwwHAjBmXf6XpTI+Vw+6TJc3XjSpuvJ4nKUbW6lEk+hqkMVSAkpLeieR9b7/+KpjKIEgXEpdr3FKbyxdkUgPn4esDD/iAO76N0bB0Hh30m6Lt0krvol3h1VaZ5lc/R2qieJAGRLr8mTtbA+fm+swl0DJkYlZ1VNvHPr8uL1KU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB7892.jpnprd01.prod.outlook.com (2603:1096:604:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 05:27:10 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 05:27:10 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Topic: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Index: AQHYC3T1GUs88bXDK0iuG+0P5NW4eaxoEG4AgAADSICAABP+AIAAGcGA
Date:   Tue, 18 Jan 2022 05:27:10 +0000
Message-ID: <61E64FED.2010906@fujitsu.com>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
 <YeY6Uh8I7RlsCicw@mit.edu>
In-Reply-To: <YeY6Uh8I7RlsCicw@mit.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 959e703d-ee9c-49be-8e7e-08d9da432d15
x-ms-traffictypediagnostic: OSZPR01MB7892:EE_
x-microsoft-antispam-prvs: <OSZPR01MB7892AB2EB9169BFE6EB3597EFD589@OSZPR01MB7892.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIqcqwnCMbfdBv95BS+w//8JvFbq0SVPQCv+YMBzSqvPnJ3uKADHxJI2VMTYqNSKdPS0S7yykEda1PdojTl4sijR6xvv6paApgZYbZdGsdzsDD4yJPB3QKAVqt1db99blVKY9vpJiVZoGZLMcYi66lYJH40vLKl7eot4dOpbMLeiHFsR1cNcqdL5l1bOOs5xnTSFUMXRSZXGpUSPtXfEMRM5+K7Sj3lnRJMlrvb301P6KHBimF2D0l5FX3hZvLNENtzGF5vDGkSugDgxp44HB/K/jJr824BTymw+KR56iVOMGBLlOBGjKVXBbF2OKLp7+WFnKwmz2qPBmfogrMXZQ08wEX9fScdRCu/CRSICM5qMlycmknB6OGmgx5hwRKmVrpX568zHNhOeQ8sRji3rS3MraRLmkCGQxzjApZJmxKSsbuc5mOHY2Qfy3Etbc/MZ+Bhac1gIRv6RIMeg/E/waUaI3iJR10D/CVmU3IH1tmV2JrbtAAfKi/SCeMTIJ9DkB7HAQeS1chcFdgVjR9DYKLi0r30dFBQaCdaCr0xdlLGs0AuS2V93VHmsXcg6eruMoN9Ad/E3XsG6Uj+bvFVXhzN8E7T2OkkPRCYNZMlfbkjo+6XXFI9ieg4AQos6VJEXD7u5pulMoRceEbuWdXZEss1e56PskL0fDVsTIoBmekH5m4NkxkMJLPXGAzDp21oWfnk79gu4ukeLz0b08w7wNDAF/Tw0w5/obmdLDAnBwQzGO4cSLCQV8BCQOqV5AuUcip53t7D9T4h9UlUh5E/tAMEbo9+jeT1nNZUhQ9kyo/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(4326008)(6506007)(2906002)(4744005)(186003)(8676002)(54906003)(5660300002)(110136005)(26005)(2616005)(91956017)(86362001)(316002)(8936002)(66946007)(122000001)(66556008)(33656002)(6512007)(82960400001)(66446008)(64756008)(66476007)(38100700002)(36756003)(85182001)(87266011)(71200400001)(508600001)(6486002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZkRMT3dwUENjSFdTczh0NVFVWWcvc21VcWV3WVptckhsUGZkalNkcVVETjNN?=
 =?gb2312?B?V05rc3RkT0tHWlU1N00rRWZoZXRzU3FUNzZ6bWxWU3NOQlJoWnVFK2JNMSs2?=
 =?gb2312?B?ZTk2enlqTDN2VkpFUTFZU0RlRXExQy9qWlY2U2tWM245alJiWG5JOU15THBq?=
 =?gb2312?B?TldUY1pINklzMXBtRlZVeVN4WVRiTG5QREFGcG9OcCtvNXhzSGZXd1NONWRv?=
 =?gb2312?B?ekFKUmpOWTMycTVLaXBLbTh0U2Z2RUpNcld4VHE2SFVKUnlpQmVvQnkzbW54?=
 =?gb2312?B?ZVA3bXhsbHhYK0FoSDJlS1NsMStBaG9qZ1plRU9RMGhoTHdZZHdGMUFsS3Qv?=
 =?gb2312?B?R09FOXZHSlp4TkNGa3U0K3lCaEcvTjYycXBQRHErbXI4aEtqVUhIWDg0dXQ4?=
 =?gb2312?B?MnNUcXZhOE9xbzhSVVpsdUpGc0QwcktQQXBzb3lwOFZUeFd4UkYwTE11ZVhF?=
 =?gb2312?B?d2VFck55azNtR0lCQXA3Y05sMDNuK0xlSXpJWGhqZWFJTEFBbkhpZ2Y5K2dl?=
 =?gb2312?B?KzA4cko5ZWNZb2RQUjFmQkk4OFBSWmZ4WmdmR1grQk92MVFkUkpEaXBPQmdE?=
 =?gb2312?B?ZHZGVXJOL094Ykh6Y3czZzdxaWlFK3VNYUdPWGt6NjBSOE4rNmw3elVGZ2dV?=
 =?gb2312?B?MzR4NmZVSnJvcXF4SVExdDM3cU91dFVRTm1kVkRQM3NLSFJ6SldjNzRNdTFS?=
 =?gb2312?B?YWlGUVdISFhUUEYwOUQzYXZpT1BkRFZrSi9WcklxSkJ4VWdKbi9xUlhHUjQ3?=
 =?gb2312?B?SW80ZkM1bUxlRlowNXpvQ1dSWGpzbDBzbWUrMWlaWEw2UkhrQUUzQW9YRGEw?=
 =?gb2312?B?UFZNYWQzWXJjcFFuckhISXFpSmk0TEJXUWtVNXUvNExEWjkyQTUwVVp3ajYx?=
 =?gb2312?B?UGY4dDI5ck1yOGtPMGcvZkZxTXBaUnVGN0dyZ3Jzck1jbUtPcUxmM3hUUmZu?=
 =?gb2312?B?Z1FNNlZFUm5Pa3RCaGVQamxScnBjdmwxUGYyeW1ETk1SZVh1OGlTSVpRWWE2?=
 =?gb2312?B?Mm5VQlNVUGlYZG1JaVVLcmROQUhubWgvVEZZVFJPK3dvRnU0UzlNTEZpU0F4?=
 =?gb2312?B?dDVsallnNG90TGJKbk9qU2xmN0tWbDM1U0UxUEMxcTBsa2hteUk4MlBFQ2NK?=
 =?gb2312?B?WWhhcEs0Tk1TaENESjVFckh6ajM4bUVndVdnU28wWVZNUzlWV21EVXZjYmht?=
 =?gb2312?B?T2N5emRvY2p4ZDZmNG5mSmNGTVNCWXhRcUdiN3d5UnMrNWpTKzBvZUMxcnUz?=
 =?gb2312?B?TnRwd2VIMCtEd20rUTBYaEkxUUo5VUxFaGZBL25OY3NpS3Y5UzMySzJaU3Vy?=
 =?gb2312?B?dVBkMmplL0JkRy9GZFpVcHBiOVUwUXFvRjlqT0Rvc000TGl0clhndGwzWmIy?=
 =?gb2312?B?L3BOcTNLTWR0NGhMZnFoamdEVEVCN0twenlkcjRJL2dZSFJWcHVXOG9EbVNF?=
 =?gb2312?B?aUtYVjhKNlZYUjN3NEVyYXZMd1FBTnRiQi9HbnVwZEpZckxwZGJxK2R0ZlJN?=
 =?gb2312?B?ak9zTWRNaW5pUllXQWdTZ0UyQmVIUmVJMndDcU1lNE5WV256emJCUVJZRzJ3?=
 =?gb2312?B?UFBnRjlIYmNhd0Fpd1VyUDVMWnlxakg4b2ZFRjNBRlE3QWR1Z2YyZU8xdkdm?=
 =?gb2312?B?THhjcmo3SysxbnAxbTNGQXNnS0dINEQxT29jL2M3QWx5VnJRMFBKRDgvTzZW?=
 =?gb2312?B?SmNXN05PZTE2YkpMeFNVc3RhdG1SUE5TeHowbzFhZ01xNTk3YUZkYU8vbHMw?=
 =?gb2312?B?NHAzM1NFWEVQczVrNFhkTmN3dVZzV3JxYmFFTG1YQm4zaEtSb3NnbW91eWxh?=
 =?gb2312?B?TXVaZkE1QzlwYXFFTm52QzVoY25uUTNLblNlUUF5SlQvd3hjdVNGZFFVQzJ1?=
 =?gb2312?B?eGg0a0tFa1phb3hiUmlCc2FtVTFUQ252Zmx3VkxteFdobk00TG1yRkc5TE10?=
 =?gb2312?B?bWtRTXdLK2xHd1pHaXdyVlRvM1FaYWJyMU54bzVsd0FCZ2xZR1EySUlETjFv?=
 =?gb2312?B?dlVseHVUcWoxd3BoZWJlZlh3ak1UaS9DQWxCNG16QTkyQ0YxWjMzQXFCaXZs?=
 =?gb2312?B?bmpydncvQWhuZVVYeEdWQ2F4WTVpeURRRHdDamRPV21IUW11eThVa3YvVldS?=
 =?gb2312?B?bzlRdnN2NHNFdHJLMjNXZUIxNHlHTG1xOEs4a1FXTXdMUXZ5dWZsTFUzUk5i?=
 =?gb2312?B?em5Ibi9qUW0yUmFtZ2VsdWxjMC9TbU0wcTlpenBoYXpFNlhsM3JPbmgzcnM1?=
 =?gb2312?Q?Kj4ka0cAqToKehJaLy6L/cqGz58SV4tIMeDbNzUwRQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <FF9358396A0FE845AA651CDCF22AE6E3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959e703d-ee9c-49be-8e7e-08d9da432d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 05:27:10.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRvZX3w6Ez0WhdRFVjgMeGzG7nvfiafPx7yaoyXB9I8dq1tmtZR7KPm8/3I+2nwNrU0kZDPcUBbYRYfTWM5B/U8hZfT5KtfJlvui3HOnilc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7892
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8xLzE4IDExOjU2LCBUaGVvZG9yZSBUcydvIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAx
OCwgMjAyMiBhdCAwMjo0MzoyNkFNICswMDAwLCB4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tIHdy
b3RlOg0KPj4+IFlvdSdyZSByaWdodCBvZiBjb3Vyc2UsIGJ1dCBvdXQgb2YgY3VyaW9zaXR5LCB3
aGljaCBDIGxpYnJhcnkgYXJlIHlvdQ0KPj4+IHVzaW5nPw0KPj4gSSB1c2UgZ2xpYmMtMi4zNC4N
Cj4NCj4gSG1tLCBvay4gIEknbSB1c2luZyBnbGliYyAyLjMxLCBhbmQgaW4gdGhpcyBwYXJ0aWN1
bGFyIHByb2dyYW0sIGVycm5vDQo+IHNob3VsZG4ndCBoYXZlIGJlZW4gc2V0IGJ5IGFueSBwcmlv
ciBzeXN0ZW0gY2FsbC4gIEknbSBndWVzc2luZyBtYXliZQ0KPiBpdCB3YXMgc29tZXRoaW5nIGlu
IGNydDAgd2hpY2ggZW5kZWQgdXAgc2V0dGluZyBlcnJubz8NCkl0IG1heWJlIGEgZ2xpYmMgYnVn
Lg0KSSBjYyBnbGliYyBtYWlsaW5nIGxpc3QgYW5kIHNlZSB3aGV0aGVyIHRoZXkgaGF2ZSBtZXQg
dGhpcyBwcm9ibGVtLg0KDQpARmxvcmlhbg0KDQpOb3csIEkgdXNlIGdsaWJjLTIuMzQgYW5kIHJ1
biB0aGUgZm9sbG93aW5nIHByb2dyYW1bMV0gYnV0IHRoZSBlcnJubyBpcyANCm5vdCAwIGluIHRo
ZSBiZWdpbm5pbmcuIFNvIGlzIHRoaXMgYSBrbm93biBidWcgb24gZ2xpYmMtMi4zNChUaGVvZG9y
ZSANCmRvZXNuJ3QgbWVldCB0aGlzIHByb2JsZW0gb24gZ2xpY2ItMi4zMSk/DQoNClsxXWh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9mcy94ZnMveGZzdGVzdHMtZGV2LmdpdC90cmVlL3Ny
Yy9leHQ0X3Jlc2l6ZS5jDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPg0KPiAJCQkJCQktIFRl
ZA0K
