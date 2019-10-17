Return-Path: <SRS0=KSdQ=YK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2470BC4CECE
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 07:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F1620640
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 07:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="Xj9XxAS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407918AbfJQHKV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:10:21 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:56957 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390955AbfJQHKV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Oct 2019 03:10:21 -0400
IronPort-SDR: EBWsi6uHcobBP05fZRCRadQ0CKJrLk1BM+7JEXvGZYytBf49Yk55IZuOjmkGsNWnGbevX1Kkws
 sRNYNGrkcRRVQ8A+b8mrlw+JtKm064yy+YPNY0RCHhX6M553UNfcGpdKNAMk0bcEAlJltsSYG9
 gwY+xO8z+i9QFa2BinePgS0oW03MMV6HvDXx3aZewl4YQQRL83jSpQ7zlAge+fMjfa2DotsdH8
 JU/EQotoHs02vxxMTFlmQ4bzvvsUx1B4VUq/ek7QEU1Tzw5pOuQMj/F4KRLcvEVEp14GSyr9vc
 8FI=
X-IronPort-AV: E=McAfee;i="6000,8403,9412"; a="7017092"
X-IronPort-AV: E=Sophos;i="5.67,306,1566831600"; 
   d="scan'208";a="7017092"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 16:10:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPafLawaX6tvOV7yI5Kgtxjegy8/lupwlzLRL8nJCTYv1Gv3J9T+ava5vmTItVAvCumyTUPSBSbWMTkcwdNEnzMOjMjxBSaSEwHc+Mx5X9MII2/e85KICSTNEUC1PWxu0mUnVr9nzyhD0r3mxn8QNKVjkR+DrQIumzvPl0D5EXo7FshbSHWuRdVr1BB7ohEar4qqFCxfkevp7NJWdZyxeO9ntZ9ijlEYJ73AFA6LgcHkZl4vQqfwVGvAg/zZxK/bsgI6tMUX1JwvhEwb5NEcW5+Knrs7ram/6RkxyRRpO9vD8djxhQ85MAQ7/SC/3fTJytS6JXLkIMJvSlglQsErug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riYsSgWUEQAdKwmE53zOukKZBU0q9tdsUjkdiMd/GDk=;
 b=BAHHYNPVYRKhMBcm/1Na0YFOLzB7udeHPVfdf8iWtrNzgVXpWKGp0dmrizbkOYC5N9G31u0jGEfZnw5lR81C8YnhcaSFWaiF/ZhkGI8rb0Us0TpYoFBqgkthgA35snxceQQCVz5ec0KXclE1ViuP1o7+NDarbymal0VXTjDIcRFbO301kwuJJySRV4VQtaZ+Q9xTd3DAtk25OgRHYjRscbFILSuYdjc/PrX0Cd6n1ADUBnk0uDZDc5NY4nwwHlr6fmaUteEEaTG5qbgyCJPKFzMdIaH6qSc0wHYcVmtenX0tscKSWU/QWqDNqxK2DluDFenoczzsGRC13JELvH3EMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riYsSgWUEQAdKwmE53zOukKZBU0q9tdsUjkdiMd/GDk=;
 b=Xj9XxAS/grRQQ98F921+ukzH1Qty0pCtVkPUkzbHg3BTTNGp4mWci94E6+GvRzpS5efNjSCGVytZ7MeHGi9lYYycnCHxvrflC4Uv65BMQ5jKIng5KpGQ9j6tyDSaQswnjgaHPo+NkdZ+5BsPtnA2+LygnFR+fpTB6HglkDA14TQ=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB3749.jpnprd01.prod.outlook.com (20.178.5.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 07:10:15 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 07:10:15 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     "xuyang2018.jy@cn.fujitsu.com" <xuyang2018.jy@cn.fujitsu.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Topic: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Index: AQHVhBCG71vpUjQhc0Csd4LFrwSd2qdeINYAgAAAjmCAABPGAIAANelg
Date:   Thu, 17 Oct 2019 07:08:59 +0000
Deferred-Delivery: Thu, 17 Oct 2019 07:09:59 +0000
Message-ID: <OSBPR01MB3783D1FE3AFE534252843F91E56D0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
 <7501d010-0a3f-f9e6-f705-48cce651c614@cn.fujitsu.com>
 <OSBPR01MB3783782B18D809ACD84EF562E56D0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <d2a0c4a1-61bb-5f4e-7338-1ccff10935d1@cn.fujitsu.com>
In-Reply-To: <d2a0c4a1-61bb-5f4e-7338-1ccff10935d1@cn.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 9bfe5857db2e429bb04dcfe3c5b066ff
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [210.162.184.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bb6f689-6113-42fc-8eb1-08d752d10f67
x-ms-traffictypediagnostic: OSBPR01MB3749:|OSBPR01MB3749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB3749C3272BA15FEAE0C4B9E1E56D0@OSBPR01MB3749.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(66476007)(446003)(305945005)(86362001)(81156014)(99286004)(256004)(6116002)(66556008)(6436002)(66446008)(7696005)(7736002)(476003)(486006)(6862004)(4326008)(25786009)(3846002)(76176011)(8676002)(11346002)(81166006)(9686003)(66946007)(76116006)(71200400001)(229853002)(186003)(4744005)(64756008)(8936002)(316002)(52536014)(14454004)(26005)(85182001)(2906002)(478600001)(71190400001)(33656002)(5660300002)(74316002)(6246003)(6666004)(102836004)(55016002)(6506007)(66066001)(41533002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB3749;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ci4aHbJVx+Pn7M6cQvBBGxOPDPT6zpWvNwqUhbGGFNiFTfxCXHLN/g1gUqsVR43nbhVmS28hxgCM8fm4L8G2GKiPC2L1ODkeqbowOL4E6cvFjN35+p5esBQdR9foqyLw/1RVAObQJ91GR6bmkNBSNNr2glwP8VPXeJcMSCgEU/qerkdGaVDB3JuRyOjIR+9cV3FBEdEsXDV7DtRMkf/J7UitGqGXdj1NasDUKFnnLtSXzxkfOKsVQAUhw05/gXunOJ6V2pIAtz4QagXgUS2ntckzS+fKH93nP+txcr1Q3aNZ8D8pwRCRuRxaIqcemsyJW6f/NoedOg4AtMj1natzj4w0j0MJeMUtbf5AjJYGLr40Ugy71oPTwQaJMqcF2UjTKtsfDdqULxob+eChY1qssleaWTxKDR7pQG7ihbNZV7Y=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb6f689-6113-42fc-8eb1-08d752d10f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 07:10:15.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9y3s09Ggv+oKvq6A2t3mMnRmg3kk1E7PdIX/GgOTktZ3u/S1gOmx7v/4kQp/MRBAtIz5TShuLhxvifkxDOJhWaWnVMnqYB8xZWck88DoAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3749
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

PiA+Pj4gVGhpcyB0ZXN0IHJlcXVpcmVzIGZhbGxvY2F0ZSBrZWVwX3NpemUuIFNvLCBza2lwIHRo
ZSB0ZXN0IGlmIGENCj4gPj4+IHRhcmdldCBGUyBkb2VzIG5vdCBzdXBwb3J0IHRoZSBmdW5jdGlv
biB0byBhdm9pZCBmYWxzZSBuZWdhdGl2ZS4NCj4gPj4NCj4gPj4gQ2FuIHlvdSB0ZWxsIG1lIHlv
dXIga2VybmVsIHZlcnNpb24gYW5kIGZpbGVzeXN0ZW0uIElNTyB0aGlzDQo+ID4+IGZhbGxvY2F0
ZSBrZWVwX3NpemUgZmVhdHVyZSBoYXMgYmVlbiBzdXBwb3J0ZWQgc2luY2UgbG9uZyB0aW1lcyBh
Z28oeGZzIGltcGxlbWVudGVkIGl0IGluIDIwMDggYW5kIGV4dDQgaW4gMjAwNykuDQo+ID4NCj4g
PiBIaSwNCj4gPg0KPiA+IEknbSBub3cgdGVzdGluZyB2aXJ0aW9mcyBhbmQgd2FudCB0byBhdm9p
ZCBub2lzZS4gSSB0aGluayBORlMgNCBkb2VzIG5vdCBzdXBwb3J0IGZhbGxvY2F0ZSBrZWVwX3Np
emUgbmVpdGhlci4NCj4gPg0KPiBIaQ0KPiANCj4gSSBzZWUuICBCdXQgaW4gZ2VuZXJpYy80OTks
IGl0IGFsc28gdXNlcyBmYWxsb2NhdGUga2VlcCBzaXplLCBzbyBJIHRoaW5rIHlvdSBjYW4gYWxz
byBhZGQgX3JlcXVpcmVfeGZzX2lvX2NvbW1hbmQgImZhbGxvYyIgIi1rIg0KPiBpbiB0aGF0IGNh
c2UoSSBndWVzcyBnZW5lcmljLzQ5OSBkb2Vzbid0IHJ1biBvbiB5b3VyIHN5c3RlbSkuDQo+IA0K
PiBwczogSW4gZ2VuZXJpYy80NjksIGl0IGNhbiBhbHNvIGFkZCBmemVybyBjaGVjay4NCg0KVGhh
bmtzLCBJIGhhdmUgc2VudCB2Mi4NCg==
