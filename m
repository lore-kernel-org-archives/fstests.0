Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F66FC433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 02:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BBF61425
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 02:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhDYCRz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 24 Apr 2021 22:17:55 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:58881 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhDYCRz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 24 Apr 2021 22:17:55 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2021 22:17:54 EDT
IronPort-SDR: jPnqcMDLDEQug2aj0SfQL8wJgkYiEj/KOLhJwA73NkuJLWW3TYj0HAa+lGbTpti+nxVL0PJe+u
 rqUUp/jQFMdgyTmYk2qT4SPvCk0IMolF9tjIrfRm/aU5xRuQmO8C8jSkltT57ug+CQMH8qS/l7
 WYhuUZSxbCAGsS7IlwCHJ6sLD7AX1zLZbr/uehbiSdTzs5hk+88wmpwDZ3ZfwWY8MOjl6k9xdY
 oXfFkOQs+pyp5TN50BLuEhuCyB0LwjtKeXkCBNH9C1nh9/NQBRoLRaoTuXa90+Kep0YYbvFYxZ
 ISk=
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="38414393"
X-IronPort-AV: E=Sophos;i="5.82,249,1613401200"; 
   d="scan'208";a="38414393"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 11:10:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFcJjLXyS3ka0qDO9uvbfuSI5bdKHJWFEc1IRrDPTr0PAyKRI2qkk2ji89H/MG1UNF+sDU7LvFHN72Gr+L0wHJBqKrZRjTdH5IMvr2LAlpedAwZBbQSzHsHb3iGQ74k5OBlcdbedCYte0OjHq2uG4jRSn+hEw3bMb584RTnJphybeWt16TcGtsQTN5BtX0BovbheWFYQjuvP3Lhvek8ZxINvKyb1Ao4ynFr5uUlyY0O0RQXOkPaUQQ8ry7IKmwZni839G/Qs7B9NTFbvCMkliuNZzMfJfQZB/nGt1QXBbRwiz70wNwXrkFopeHLaOYLDVqe6J5KJH4wcOkLrUzu5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZUojegQ4+3ylug+xBcrmz8TrGoOsGJ6RsKPG/QiZ60=;
 b=HigjQkuDg5ZPz6oewevXECSqLuoO3klZQ6gdQXtlH5trAlpXb6ojDk71lbowe/qHtD8nHzkNGShMI/jA8Bn57+IZ1CHAAO56iETcWAAJJFZ1KXGCI1/V1VzUXBZTozJEtZfwmFCaJ7p9LSr/8f4Q1ppCaa1KX0jkPE3tlYz4KRKU+zgCTWZVYetBcRQAZqWX9Latme3PbUZcWg5YDjhtPKmXx8N3lfsf8TxqN6FDbLqk/4c6EOxzm6ujuu2qiLHa0YJRHXqRxBvledEMV1ReVTTzjIO5bYwkXzERwsVlFwxaCxtFTWpFzWkI8HhwVjb0p/w8Mwgpoqjxc3wnVNKlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZUojegQ4+3ylug+xBcrmz8TrGoOsGJ6RsKPG/QiZ60=;
 b=mlcDCKAD0N67PWwXVDSQ8VrPcpSqlWx6HwtipVVac8TwNUL5McyqCyF+Yn7He0pTQxhJSEDpRffvESElYgFEsJSwk3xgLzeu75acJCU0DiYjSDRbK+KTVISB0yAdWFj+fD44s9HAWaEmS67tzuFPWOBDyuFNas/ablF3Y5CdCdU=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB3680.jpnprd01.prod.outlook.com (2603:1096:404:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 02:10:02 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9095:8cd8:6e30:3052]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9095:8cd8:6e30:3052%5]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 02:10:02 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Brian Foster <bfoster@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "huangjh.jy@fujitsu.com" <huangjh.jy@fujitsu.com>
Subject: Re: [PATCH] xfs/145: Remove useless -f option for xfs_quota command
Thread-Topic: [PATCH] xfs/145: Remove useless -f option for xfs_quota command
Thread-Index: AQHXNyzQNA8PcXCyvEyeTOcSjyvD+6rB9RKAgAKdswA=
Date:   Sun, 25 Apr 2021 02:10:02 +0000
Message-ID: <6084DDAC.8090201@fujitsu.com>
References: <1619067943-3859-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YIKr47vkI1PsjJeY@bfoster>
In-Reply-To: <YIKr47vkI1PsjJeY@bfoster>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed896eeb-7aeb-4169-a5cf-08d9078f3c5a
x-ms-traffictypediagnostic: TYAPR01MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB368028C1316C0D5A380443AAFD439@TYAPR01MB3680.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VcuHrRPqSBZ5RuqwF8fBR7c6C6ar9wLXqeYaJNaLa8zx8zVRt8qMVBom9lP7E4iTs7H5crGC01bZ4oID4tv7aQiV4xAFFxqOX7fm552IbrMEGruv45weMNKhAPtKxUPfXAn8Elu7wJ2n2YAPD5EPsRsnIYUjsbJfzzFtnGGHgmFjCY3Knu3Zb0d5tozJiV2PcHNWI72BheYGYLYL1pWonsAxMtKARIuBsNC8j1+ulyoAVJmZ1ZrQ3qfbTuaq5bjHvDgFEipvHOOh+n8m1Dgpzu50HLs43CXWsSl9S1LUt407S/M9do25nlZ09M1hDmsGPYaaSQuVdTXAiwqjZJy9SPftELgD4+zu/d9JZ6071UPZXp6sO/9ss6qUYCsIFQPOSh86B8knrJnRPXVLH7ZEwqBqofmaxYumYs2eTga0TnX6Cx8CCC0w2RguTvGc06AKLTs1DzREkYXaAtR9EWNkva/V+SQK4uBder6KdjqgWeLMe9h3gro0Tq8Bdi2H2B2HeJYHbu8H8+xRkExDrvDIc2vS3a57qPDB3+SEzo1tbqXD6ccnEG3ef+mrdeZ5skhDOIsv+DqMHlvmIDgBycolFx8G3PEHsLESs5j1V0R/sP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(186003)(26005)(85182001)(2906002)(478600001)(36756003)(87266011)(5660300002)(86362001)(6506007)(6916009)(316002)(107886003)(4326008)(91956017)(8936002)(76116006)(66446008)(66556008)(64756008)(71200400001)(66476007)(54906003)(33656002)(66946007)(2616005)(122000001)(83380400001)(38100700002)(6486002)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?V1lsdjJSL2F3WGlSOEpCeEpXRDFDUjhuNFRuaUJBanJ2b3htU0w0OFUvVE5a?=
 =?gb2312?B?Mk43SktLRnpEeWJmMHlzdjFOWHpLZVJLcU9TUXNKZG1teXNVOVd3b2JuOHZs?=
 =?gb2312?B?emdYVEJ6a0VveHNzVXFqb3BwZ3hKSXBSa1FodHBjb3lyYlRnbDlrMU9hdlJw?=
 =?gb2312?B?K25qcnM3NE1UTndsZzBMVEIya1JWYmNkNjFjT0xaaW5BL0wzb3JsZ1p3ZWt6?=
 =?gb2312?B?djVKQjQyNkQ4TzFNOXZ1Uld0cWEvOHpOSXNtYnd1K1ZwMThWbnkzVDIxZG50?=
 =?gb2312?B?eU5rRWFyN3c4aVRwZ3JlSzZ5eXdpS2FNWTdyVm5YTko1M25iWFU1ckgwSmhG?=
 =?gb2312?B?TUFDU05ibTdZV1RPelpKYXp2RWhFV0Vkdkl1cU8vMy9FWDVVd2RWdFoxRktw?=
 =?gb2312?B?eVpmWXdkWElOWldXbG1JeDJqbGhrcXFiclRjYUYybUlpdkduRG9pUEFHYXFr?=
 =?gb2312?B?WHpDanlnWEZLTGtmUm5pWEZQeENUOWhwRzByemQvSVJXZkJLdkthZmw3UVZW?=
 =?gb2312?B?bHVaVlNUNFUwZXdSV3FZbUpzanRnTm9UZGtBTlZ0ZmVya3ZnVmdkS3RwWExB?=
 =?gb2312?B?TURQa2hHM2xjVlNiTXdsNjM0cDhxaEJyZGRxRUJXR09ORVdXVWF2VzUveUdV?=
 =?gb2312?B?MU9iRkxEbUk0R3FHcGdBa0M4QUViZzYyclNSQUVBM2lDdzhHT0lLYkZMOTZp?=
 =?gb2312?B?b2dGSElJS3FGcHEwWHRKRUYrRk1GWkhJeHBibTFFMjBYb2VDNzN6M1l1UnRU?=
 =?gb2312?B?aXhHU0lRSVVla3I2eUtxVjdEVlcwZlFtU0hkd2FjdlB1eGVkVVJ2VUVGdmpu?=
 =?gb2312?B?Y1E1bVMwQzhsL1lmZW4wWENwNExDblFLSjdNSXZHZ2lmanMwb3AvZ0RwRDlw?=
 =?gb2312?B?blFuMW9QeVA1NGVvUmUxbVFLbGp5YUppN0ZWTElUZjQxeHY0TU83dDg5UXVO?=
 =?gb2312?B?VDhTZkV1UzNQZm9XOHVoSy9PTTVjeis0bXBOdmRlUmJZMWR6Z0psczJVcWpR?=
 =?gb2312?B?WjNNSWdyOWtleFIyWHpVRE9UWjJzQTJuTmsyRmR5OGNEZkhURGgwVXk4RHVn?=
 =?gb2312?B?eUU0RlZMTmtscW9LaGxXejE2TmFOSWxQOTRNSEMxdkF0OVdiaDJKRkRNYXJx?=
 =?gb2312?B?MDdWTXNJY3VJNHkyNHJ3a3VyL29DeXJaWlIzTmJ0a1lrK1J4VkViNm5wWHpZ?=
 =?gb2312?B?blpqRTBHS3UwQm1YU1QrSHROM0JZSHh6Vkd6MFhZZHFxTVA1Q2lZTGJSbFE4?=
 =?gb2312?B?VHBzYy9ITzNYRGVpMFA0YTdXcXhvWXREUEtqalpscmorZ2thcFgvOWswR3hF?=
 =?gb2312?B?Q2kzQzdiQ1I1TVJ2aXV0TjNGSUNIbUsxNEVjVCsvaGNVZTRETHhaalB6Q2RB?=
 =?gb2312?B?WXpJeG4wVHBTVGFCQktvaEV4ZVBBejNmNXYxb2FMOWxCMlFpZTRtdWlwbkh5?=
 =?gb2312?B?TnBsYWZtRHV4WDY5aEhOcS9MQjBhOWtESnlwTjd4UTdmejdTUWlPdy9uTmJC?=
 =?gb2312?B?eGx0MVp6bTJ5SnBJalJvWjBsVGZ3Z2tHcG14UitmZk5FMzQwbyswQTRDZ1B5?=
 =?gb2312?B?cFVzVHVyODRQckZOcUwvbURFMDdEQzVReDlsWTFQNVlvUm9zWWM2SUVaa28w?=
 =?gb2312?B?QjJaT2l4SGNzYzR1T3I1ZnNIMTl4VVVCVzVzVEJzZWlzZHVKQ2NodDl5NDMy?=
 =?gb2312?B?bWtXd3FnT0p0UE9yS1VCOTdVazRoclpVK1FnOUh0MS9SdDFmYjFzMDFCZ1R2?=
 =?gb2312?B?dU5adHZrNUhOM0NreXlUWnZ0T3czMVBtTEc4czJPakJrU3kvdmllaXhuaUM0?=
 =?gb2312?B?M0ZNTDFoRUN4ZGhhRzVaQT09?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <A070417CBA441546A9DA6FE5ED55EBDC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed896eeb-7aeb-4169-a5cf-08d9078f3c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 02:10:02.2822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpeYTvPNFHrbfIfJsmCM5HvNt1n+jS6EHFe0lGGWWJMhVJKwYPwfURb4CE6DX8fFjNAv0AnXVnVwj9Qlupd16JX3UYb89bWk1JNDfZZ8yxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3680
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMS80LzIzIDE5OjEzLCBCcmlhbiBGb3N0ZXIgd3JvdGU6DQo+IE9uIFRodSwgQXByIDIy
LCAyMDIxIGF0IDAxOjA1OjQzUE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBTaW5jZSBpdCBp
cyBhIHhmcyBzcGVjaWZhbCBjYXNlLCB3ZSBkb24ndCBuZWVkIHRvIHVzZSBmb3JlaWduIGZpbGVz
eXN0ZW0gbW9kZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaW5odWkgSHVhbmc8aHVhbmdqaC5qeUBm
dWppdHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBTZWVtcyByZWFzb25hYmxlLiBBbnkgcGFydGljdWxh
ciByZWFzb24gZm9yIHRoaXMgY2hhbmdlLCBvciBqdXN0IGFuDQo+IG9ic2VydmF0aW9uPw0KSSB0
ZXN0ZWQgdGhpcyBjYXNlIG9uIENlbnRvczcuOSBhbmQgdGhlbiBJIGdvdCB0aGlzIGZhaWx1cmUN
Ci91c3Ivc2Jpbi94ZnNfcXVvdGE6IGludmFsaWQgb3B0aW9uIC0tICdmJw0KDQpzbyBJIHNlbnQg
dGhpcyBwYXRjaC4NCg0KV2hlbiBJIHRlc3RlZCB0aGlzIGNhc2Ugb24gdW5wYXRjaGVkIHVwc3Ry
ZWFtIGtlcm5lbCwgaXQgc3RpbGwgcGFzcy4gU28gDQp0aGlzIGNhc2UgZG9lcyBuZWVkIHNvbWUg
c3BlY2lhbCByZXF1aXJlbWVudHMobGlrZSB4ZnNwcm9ncyB2ZXJzaW9uLCBvciANCm90aGVyIGtl
cm5lbCBjb25maWcpPw0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4NCj4gUmV2aWV3ZWQtYnk6
IEJyaWFuIEZvc3RlcjxiZm9zdGVyQHJlZGhhdC5jb20+DQo+DQo+PiAgIHRlc3RzL3hmcy8xNDUg
fCA0ICsrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMveGZzLzE0NSBiL3Rlc3RzL3hmcy8xNDUN
Cj4+IGluZGV4IDNiM2MzNzVkLi4zY2NiYjkyMyAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3hmcy8x
NDUNCj4+ICsrKyBiL3Rlc3RzL3hmcy8xNDUNCj4+IEBAIC01MSw3ICs1MSw3IEBAICRGSUxFRlJB
R19QUk9HIC12ICRTQ1JBVENIX01OVC90ZXN0eSAyPiYxIHwgZ3JlcCAtcSBkZWxhbGxvYyB8fCBc
DQo+PiAgIHJtIC1mICRTQ1JBVENIX01OVC90ZXN0eQ0KPj4NCj4+ICAgZWNobyAiUnVuIHRlc3Qg
cHJvZ3JhbSINCj4+IC0kWEZTX1FVT1RBX1BST0cgLWYgLXggLWMgJ3JlcG9ydCAtYXAnICRTQ1JB
VENIX01OVD4+ICAkc2VxcmVzLmZ1bGwNCj4+ICskWEZTX1FVT1RBX1BST0cgLXggLWMgJ3JlcG9y
dCAtYXAnICRTQ1JBVENIX01OVD4+ICAkc2VxcmVzLmZ1bGwNCj4+ICAgJGhlcmUvc3JjL2NocHJv
amlkX2ZhaWwgJFNDUkFUQ0hfTU5UL2JsYWgNCj4+DQo+PiAgICMgVGhlIHJlZ3Jlc3Npb24gd2Un
cmUgdGVzdGluZyBmb3IgaXMgYW4gYWNjb3VudGluZyBidWcgaW52b2x2aW5nIGRlbGFsbG9jDQo+
PiBAQCAtNjQsNyArNjQsNyBAQCAkRklMRUZSQUdfUFJPRyAtdiAkU0NSQVRDSF9NTlQvYmxhaCAy
PiYxIHwgZ3JlcCAtcSBkZWxhbGxvYyB8fCBcDQo+PiAgIAllY2hvICJmaWxlIGRpZG4ndCBnZXQg
ZGVsYWxsb2MgZXh0ZW50cywgdGVzdCBpbnZhbGlkPyINCj4+DQo+PiAgICMgTWFrZSBhIG5vdGUg
b2YgY3VycmVudCBxdW90YSBzdGF0dXMgZm9yIGRpYWdub3N0aWMgcHVycG9zZXMNCj4+IC0kWEZT
X1FVT1RBX1BST0cgLWYgLXggLWMgJ3JlcG9ydCAtYXAnICRTQ1JBVENIX01OVD4+ICAkc2VxcmVz
LmZ1bGwNCj4+ICskWEZTX1FVT1RBX1BST0cgLXggLWMgJ3JlcG9ydCAtYXAnICRTQ1JBVENIX01O
VD4+ICAkc2VxcmVzLmZ1bGwNCj4+DQo+PiAgICMgc3VjY2VzcywgYWxsIGRvbmUNCj4+ICAgc3Rh
dHVzPTANCj4+IC0tDQo+PiAyLjIzLjANCj4+DQo+DQo=
