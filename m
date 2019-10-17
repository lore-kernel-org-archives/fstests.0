Return-Path: <SRS0=KSdQ=YK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BB4FA3728
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 03:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645CA21928
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 03:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="fYidyHLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406823AbfJQDBb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:01:31 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:30415 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406807AbfJQDBa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Oct 2019 23:01:30 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 23:01:29 EDT
IronPort-SDR: 7MuJHzv20R1dD+QGk/QDMbdnRjqF/B9S3HZWe79A9GIshsXIuP9KSpkiW+rhIqdsXB+7eNQURA
 vKPs1Uk3gFRB3drpz/uVk75abjiWBg9dOxewM8PGOkmoonAN8UqnTNu7ZnwRQedcUOm3BDAZea
 PzIMXGXuLcV6fGLdoeIk8Vg9Qgos+mZmR0qC3vV3PHl82m5H73u61JoGHgtHeMZb7Mr1J/etAz
 1zT8ZlqwU2FSTZTuH0JU6tj9q2jwFQtujywmZiP5QeB/S9gLtaecUN4PBkLpkoCOwK3LsRTfqf
 5wU=
X-IronPort-AV: E=McAfee;i="6000,8403,9412"; a="6932313"
X-IronPort-AV: E=Sophos;i="5.67,306,1566831600"; 
   d="scan'208";a="6932313"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 17 Oct 2019 11:54:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfKD7OrRFdCbws4nrld4Cn0x67JptShzoU42OMyLn4zZJ0LC6Unvc2S4oIOMO+irL0lygCeW7wTFkVuRC4s/QqslyVl6F/Qc/FVE5QebOAW5wGAr8JZ/oT4/YwgD5dYpcMrKe15GlQPx5z1b8gLvyqtO6RQ89dmvI50r/QGJi3b5PUc9BUNJ6Gd9xc0BdZH8Z36RgSjWh174CnFk2kZZ1c0LLWWBpU8HiQezWFzRMMr78Rm4hM7nusq65xnXWZvEqxD63vwMUJRp24LvW92Yw38ktg3+Vdd1OyBjtfv0camF+5fGHuMIXISar8HFEzzkcNIztmsVA9WOJUc9olxvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lI8e02iwmVeWUzt+1JoPcD9AxTMpgDOmyO6A9XwRG4=;
 b=Z2D/ujkiXBGo9z+7e+qW4YQDGGRl7owN5gIaYfqKdXm813QKrLgrMUf639t3VVIHraW8IUrRtT7OEv7GkiSEgwwsJkhxkDDwFeUePlHqGxsjGH6FD1lXHIWI7rFzL1hCilrjxGOXL8JJXUu/F3wMm1eAngBHbl0HMd++sbwxfd3lF8UvRzqPkdkW/QJpANVdRAh2+ADQkYYEIjoCZrN3uITa9vNWuzOz3wj4WKYe1Z6HZjgHtpBjLRfFo+HNew2YUXobcOgKJt9fmLoWLea/mbHjYuv6trIhCFcfrngf7mCOQDWux7187/KCEw40NHI0lKKoOtA3dWTojWDqq4NVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lI8e02iwmVeWUzt+1JoPcD9AxTMpgDOmyO6A9XwRG4=;
 b=fYidyHLvt6ZsZeT9rJOK8d8vQ/Tnc+32W+mJGFCpysFeug4gcnrjto3zx6RJRYBHxBR9dMONTkVW1dZRMPA+Fe61wwiJwGnJQMm3fH7SpmCJgKV/1KRFlPNt5Ay5mJY3BjxBKOfPmQhKFrh4v0H6p0VqdMUweIWHoqxTjSawYwI=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB4040.jpnprd01.prod.outlook.com (20.178.96.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 02:54:15 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 02:54:15 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     "xuyang2018.jy@cn.fujitsu.com" <xuyang2018.jy@cn.fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Topic: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Index: AQHVhBCG71vpUjQhc0Csd4LFrwSd2qdeINYAgAAAjmA=
Date:   Thu, 17 Oct 2019 02:52:51 +0000
Deferred-Delivery: Thu, 17 Oct 2019 02:53:50 +0000
Message-ID: <OSBPR01MB3783782B18D809ACD84EF562E56D0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
 <7501d010-0a3f-f9e6-f705-48cce651c614@cn.fujitsu.com>
In-Reply-To: <7501d010-0a3f-f9e6-f705-48cce651c614@cn.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 5acc2a15160744dd95ae666da5a2ab7a
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [210.162.184.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 979a802f-d780-40b2-7702-08d752ad4c10
x-ms-traffictypediagnostic: OSBPR01MB4040:|OSBPR01MB4040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4040E38A548C5E5BD067B4AAE56D0@OSBPR01MB4040.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(76116006)(256004)(5660300002)(25786009)(229853002)(66946007)(66476007)(66556008)(64756008)(66446008)(99286004)(6116002)(3846002)(6436002)(9686003)(102836004)(7736002)(6246003)(55016002)(476003)(14454004)(2906002)(316002)(26005)(446003)(74316002)(85182001)(81156014)(6506007)(8936002)(86362001)(2501003)(52536014)(6666004)(305945005)(486006)(33656002)(76176011)(11346002)(81166006)(71190400001)(4744005)(71200400001)(66066001)(186003)(8676002)(110136005)(7696005)(478600001)(41533002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB4040;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7n7HGL9z8tGsCE2sFkPHU77KEHIbvMKqf8aviJh/udRyFkojC20BN/8HCI5a5YgWR0YXSqvAWck45P6xps4t2zhSz47Xg+ZeiI6TyocEPlujgBGfVyAs9XVUTJw9iqu5wXR/gyxrCQI3EHnndkyuTLEWNFEL/eKmlbFuAP9t1IBEGJFKPUiv/iKjWyK7hprIANxQfkoL295bBN6E1zPNVjd7NBw3+ENdF0L8d19ErexzFtnOp/jDZ4Bn8+G3c5voy5czqu6c7SwP54E3zxMGOz2IRBLmzNU751qPom7secKfVrWBwt1fGBBdzH7DnFgqQZl4io+SfmPZHdKphJE+Q00zwS4QAwX6UO9tM/a/PmRVMWVuHVj/JRYeDkIwVdpjIONsZk2ZkCtFlUMc3mJ55swv4Gj1Fy5HIpxM6hZSigg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979a802f-d780-40b2-7702-08d752ad4c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 02:54:15.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW+VFhDJc/X98YXhdqpmQiC4zOKAJvd/q13TyRWdyBCftxnUmGOnKpvPLbVuWvVN9WCBu8UmjyRyWy99FKtWtkUF8+d/ixc73e+lhiJLROs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4040
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

PiA+IFRoaXMgdGVzdCByZXF1aXJlcyBmYWxsb2NhdGUga2VlcF9zaXplLiBTbywgc2tpcCB0aGUg
dGVzdCBpZiBhIHRhcmdldA0KPiA+IEZTIGRvZXMgbm90IHN1cHBvcnQgdGhlIGZ1bmN0aW9uIHRv
IGF2b2lkIGZhbHNlIG5lZ2F0aXZlLg0KPiANCj4gQ2FuIHlvdSB0ZWxsIG1lIHlvdXIga2VybmVs
IHZlcnNpb24gYW5kIGZpbGVzeXN0ZW0uIElNTyB0aGlzIGZhbGxvY2F0ZSBrZWVwX3NpemUgZmVh
dHVyZSBoYXMgYmVlbiBzdXBwb3J0ZWQgc2luY2UgbG9uZyB0aW1lcyBhZ28oeGZzDQo+IGltcGxl
bWVudGVkIGl0IGluIDIwMDggYW5kIGV4dDQgaW4gMjAwNykuDQoNCkhpLA0KDQpJJ20gbm93IHRl
c3RpbmcgdmlydGlvZnMgYW5kIHdhbnQgdG8gYXZvaWQgbm9pc2UuIEkgdGhpbmsgTkZTIDQgZG9l
cyBub3Qgc3VwcG9ydCBmYWxsb2NhdGUga2VlcF9zaXplIG5laXRoZXIuDQoNClRoYW5rcy4NCg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlzb25vIFRvbW9oaXJvIDxtaXNvbm8udG9tb2hpcm9A
anAuZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gICB0ZXN0cy9nZW5lcmljLzQ2OSB8IDEgKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvZ2VuZXJpYy80NjkgYi90ZXN0cy9nZW5lcmljLzQ2OSBpbmRleA0KPiA+IDQ3ZmRm
MGNmLi4wYzZmOGFlNSAxMDA3NTUNCj4gPiAtLS0gYS90ZXN0cy9nZW5lcmljLzQ2OQ0KPiA+ICsr
KyBiL3Rlc3RzL2dlbmVyaWMvNDY5DQo+ID4gQEAgLTQwLDYgKzQwLDcgQEAgcm0gLWYgJHNlcXJl
cy5mdWxsDQo+ID4gICBfc3VwcG9ydGVkX2ZzIGdlbmVyaWMNCj4gPiAgIF9zdXBwb3J0ZWRfb3Mg
TGludXgNCj4gPiAgIF9yZXF1aXJlX3Rlc3QNCj4gPiArX3JlcXVpcmVfeGZzX2lvX2NvbW1hbmQg
ImZhbGxvYyIgIi1rIg0KPiA+DQo+ID4gICBydW5fZnN4KCkNCj4gPiAgIHsNCj4gPg0K
