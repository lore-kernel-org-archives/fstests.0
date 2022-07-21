Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C294C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 02:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGUCtX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUCtW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 22:49:22 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCCE4D4EC
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658371759; x=1689907759;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5GK7ksL7Kq/9Zo8Uui4+6Qrb5I0AlB+tF8tEtzn9lzQ=;
  b=cLEvoPAYYjMlf3cgW/f9FOnODPfPzN58IN7I7oGlHt1EfTkClB18+euf
   HGvJdsd6OKmEhDvwC2M0XR2gNjE5LiQp4S1a5Z292XHWnFf+ZeTNdArI/
   L0RsUeswpexvCyXT9CsicGEhmD+FaNK4LQoqWoKmD7ouVnZYGMHHvMXa9
   L6c7Nb+Ra1fUIvKYmiWOrPmFPfXZTiMao1nfFjlZ7xU7gD9nOMke1usIl
   qagZoqQEW4GxZhkb7+6jiOmUKU8FPxIUXkEGtXRNfrnhl0Dvh0Wyzn5DE
   TGhLQo7mDN5vg4vdWfXwUcnlTrmn0z+FWMmHQmB29x6sQ5hhnJyt1Ctn3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="69151692"
X-IronPort-AV: E=Sophos;i="5.92,288,1650898800"; 
   d="scan'208";a="69151692"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 11:49:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiMaJYRFPUKnEzg08qNFU3qowtoZlx5H9S38jFX25R38IlwA8lPsqjNJrA7/rKzQCYsKNW6xUOJQ850z+HAEGYlVyXwAE07HxO6Muop4NM41tz0aMcunzjAcoGsoZ+j/pf4Eje6+eKfMoZX7AGVpgI8U3dPaYxTC037v7SvJMI3MmAbU24oRMbXIxNAuAcRZrOt2svndrxJsG7veD1xliUTr3mStyowc1JT/lJEsf5YFtQ+X4GvuH9usvB8/G0w95KP7BbLjIPYLm8ZvO+BAKSg97ZHU5a6+p9wxeHLPgPmnDc34sRs7ChJjumLxoB3MEtyFCvnBpi3KRqenQytG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GK7ksL7Kq/9Zo8Uui4+6Qrb5I0AlB+tF8tEtzn9lzQ=;
 b=ZY9p1ZELaIYlES6LVZThcRY3/pJ50yNcADGN8fjsn+ybm3Zx7ouOVXk7OPLIHchV4DH1ZhRObG8SEJAZXAUpMaTgNoxpNu5yE4Vtm3C9dVk0Wgo5B/ink6Q9GQz1aPsCeSJncwHwLM6dnUON1dtUnM4tcgznDnq7GTo83qp6s6G2xdzrXcXjeiaYt/oXQBLA2D/JJwPRS0vTZxkwd81vSpk92GQKs8GvsSGVwDMNLvZi2LgnvO86mt2rLMHOlvP5FTvnKjDL9lS/AejiyWuXIqGyNb7+/fCMNujvsOy/E/LMD+biR6NSXuHUo1zXVGhDTfn44ZcmBi8fjHOXQat3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10282.jpnprd01.prod.outlook.com (2603:1096:604:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 21 Jul
 2022 02:49:14 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 02:49:14 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "bxue@redhat.com" <bxue@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Topic: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Index: AQHYnKnfr0zCnUjjs06UItQh9NLwO62IMIqA
Date:   Thu, 21 Jul 2022 02:49:13 +0000
Message-ID: <bfa31081-2bd8-59df-6645-a5f707159f4e@fujitsu.com>
References: <20220721022959.4189726-1-bxue@redhat.com>
In-Reply-To: <20220721022959.4189726-1-bxue@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d448bed0-e6a8-4a4c-0690-08da6ac398d0
x-ms-traffictypediagnostic: OS3PR01MB10282:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FpboI5NsYpDmV//tC21DtyuJc/VzGPL0/Z3PtkeIRWCopdD+FzSm/wARLnrvKcuMxgi4o+gmBuMUVHDOKtYns7LcYiJW8bhP2tGyglXIK0RaI5twCu4Zij8xoZSZNJNQO8ppUGl0iD+G1GrfTEIe2Db1fXEnsvOENEBCjTN/ihAuMtCLbxtNArAjFHO/k2OROYVsRGyAAyxn29Tavb1QyiA4U8XwD23v51p8WzAC8DB8P/K0wSd/FJh9dAsjODPpk8tTysrwllZDv3Ca7C4fMNHk3vRYrK0nkzM9lRGLazJJSHh1G7DhxvN/nmn+ECX65rrem7xYgN9wxCIB9SW4hxGcrkd/Mc79HeNbe+Ua82snz6nbXWniww0UuXJBGhH5JorIDS9lEB/y/cVDcExpCo+kkKraLar0qjWZPanT1JH+5hyB4cY+umlTPZnRYQImZMuF5b+kiiUeN3XLWf8EQK7TA7vFyrkTa6vzjd2tvOY5BCuQSwHotVPw1JpJ10g4m2kAlikWR1Bl55ThIT7HK0nCvlW5UsUH4OgWC5uiRfUSUXnCelxeJJI4jfnhlVrWAYYADGWU9TOUu2kWXjIHtUt9AThMLs1YRkpnL+G+97liO30773I4Bu2LlDVu4LxJvk5zfEJ0vxnP08p1IsGNGH/UHW0p3wSewqEZ7Rz1/i32fFIjhExYCbTrHjeOln7WKMDvr25VwiUWwp84gNiV+V+0Nzwa/DsA9L+3pvd2HllP5EtsSQDAO7BuEhLr7EUsqsVeWFOmJk6cpOnP5ilIXNq8BCTbTCcjufG8PLH98F12s+SWA/7CbfB5JsZudVjPBos3GsVbYtIbZ4BSLI4UfFMmowOA35CLUK0kyaHZo1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(36756003)(186003)(41300700001)(6486002)(71200400001)(82960400001)(122000001)(38100700002)(31696002)(6506007)(26005)(478600001)(6512007)(38070700005)(64756008)(8936002)(85182001)(110136005)(5660300002)(86362001)(2616005)(91956017)(66556008)(8676002)(316002)(66946007)(66446008)(76116006)(31686004)(66476007)(2906002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2s1b3Z1WVR3VUw4aWRkeHdVRDRHYStycXpuTElJcFkrOFV5QWNWR2JQZVk2?=
 =?utf-8?B?Qk43M3VQQXV1cEVVMnd3MTM0dVpMeHIrM1BPWnYwak90SHdWdWJMVFdocHJJ?=
 =?utf-8?B?bnF6bHhmT0kvNmIwUFJ3RU51ZEwrVi9lT0dhRnV1NjdTNUZzZjJ3bDFIYjQ5?=
 =?utf-8?B?S0xxQ3dtTEhoUGhhMTZzeHJFZC9aRThyZ3hOYWVzYUsrMmFZRE9HN1dGNVZu?=
 =?utf-8?B?SE5IN3l5cTBhNU9aMDNHRWdSZmNKWlBpc3FZM0xxdEFUekloR0YzQU1yODY3?=
 =?utf-8?B?OUl3TzJ5NUVMSUMwL0tsZWZoNWpHQlV0ZXdPRVVHZ2pMbzNIb2h4Vkh4bll5?=
 =?utf-8?B?UmJMOHF2Y2dsNFQvMHZEZi9CTk5TM0NSS0JNaFFWWXdDS3grMGlDRjU3eVdV?=
 =?utf-8?B?UHBkSnVDWEJRQ3dzN2YrOG9NR3lDVFVRdDQ0RFJGckYvUldYcmt6cUxRSXhH?=
 =?utf-8?B?UUVRZGV2NU8xbkM2bWRqeEZHanVBUXZ1ZFo5TjlUYms5ZHVGYUZZUUVXWmVq?=
 =?utf-8?B?Tjc5ZnN5L0J0b3hWV09kN0xFL2NrTWEvWUowYlJ1bEdUWWJ2SFBiSWxkWERV?=
 =?utf-8?B?ejF1RGs0WWJHWVhUU2JuWjcrZE5McU9tU2liNWFObFl3Nkw2bFlNd0QxKzdj?=
 =?utf-8?B?ckh3NG83V2RCL0xFMm1uVitOcTV0SHF5S3N2dS9qQ2Z2Um5UV1VGZE54K0Nz?=
 =?utf-8?B?QXJ6YTJwZDhjSUJ2MWpSQy9uS1pjNEgxNjRMZG0xNnJsQmRRYzZLcHlKTy9p?=
 =?utf-8?B?S1ZabEoxVndIOE9henFWdC9DQlR6L252ODlYVUdCVFkrWDVNR1U0eDlQdmxk?=
 =?utf-8?B?UVVvaWpkK1FyVGRuRnRVSHNFTU9SWDJaVVJzNUFDRldzb3RGZmxKbFlGYTRm?=
 =?utf-8?B?R0RiU21GZjZvbHQwT2drdlczaktKcDZHR1FHSG4rL0pEQVdzR1JCang3cEZi?=
 =?utf-8?B?WGhwTW1rZVhkV0NoLzJiZzZrUWxFM0g1M3RwMTVYR2dLUUNHWjVlNXFvRHd1?=
 =?utf-8?B?TWp2eUs3NnVEQWNBR2tXRXZSR3cyNG4yVzdwaGp2NlFOcy83dFpNVXZ5aUx2?=
 =?utf-8?B?c0MzaGF3Z0hEbENHRmdnaXA0NzlrRGtHYko3bE1WMW1XYnd6a1BtWEZpRjM2?=
 =?utf-8?B?NEllNE1qQ1hGMFZOZTlieWlRTUxvRkkzVjl3dHVQckpGczFSV0VRTVFNakVx?=
 =?utf-8?B?cVcvTGl5a3p5KzhPTDRjeENMR0JxZWpLZFJLeFFzaUt5MjVzbUI0NThBRDJu?=
 =?utf-8?B?S1BILzV1RWU5NUhXVDhQQ0lTOTNnc3lHaGRQaFlOQjlpKzY0a0hESDhnWXJl?=
 =?utf-8?B?M1hLaGZCU3Fna3VEZ0JQTFBkdDJXb21weldlRG54L2lnWkpxR0lTQnlUZGxP?=
 =?utf-8?B?cWZMNzFNTmZXRjMwd0tTejI5S211L1B6ejBxalBFOUpVOG9lb0s0b2l0V3Qr?=
 =?utf-8?B?ekNUTURTQWdZUXNncmFvVFJqWFhKRXJDWE5vbXFFckIxMGtpbCtHU0xXNUNx?=
 =?utf-8?B?Q2RnRlJxQktieDU3TlR4eG5XR3FlaGRyRnhrSVBVTlpyVk1wWStoUDFHeVBu?=
 =?utf-8?B?STIvMWoxaTE5VndXd0RMaDhsOUJIS3U5RTd3UnNySFhxTUZtUzYrditRNFZX?=
 =?utf-8?B?ZVlBclVIaDkvNUFSbkRhdUxLWXV3eW8xbXlhNXlPZ3F6WFh2WGRqVDFsSkxS?=
 =?utf-8?B?bTdVQUwzLzZNZWdzY0x2ZXBWaDhEL0NCSVlmNjFDbWdyMW52bmEyVUJBci93?=
 =?utf-8?B?Q2xpVkZzYUJCbUcyOFN6UkpXSWxQbHFQMFBvRmdnR0NlWGpjc2lrRTl6K213?=
 =?utf-8?B?V3RVcUxrTEl3OTRsSE5JaWpsaXF0eS9QQkNJNVYyVUl0NHBQcm5UZFZCNStZ?=
 =?utf-8?B?dVFEU1JZaThTdW8rcUxXMFVQaWdlaWg2U0pkRVl2MFl2bnRxNzR6eVdqeW5W?=
 =?utf-8?B?a3JlQUdNQzY2V0J1UVZocU95Y1JCMXd4b0FCQldvTHBoOENhajNreENGdXdj?=
 =?utf-8?B?SjdjdU56dnA5NGp1RzdSVzdCRHFZaDVlTWY2RWgyVnluRjQ2eFpTM25TS3g1?=
 =?utf-8?B?S2RSYmRDbEdhOWhQYklJNExXY3E2VXNqTTVhcm95WUVFY25UVkR5OXZXMVho?=
 =?utf-8?B?L0RPREtBZXZtNWp1bENNZzZzV0ZUSUdyZ1Zkd1VRYlE2c1lveEVhWU1Qd0tU?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03F9FBB510E8D8478F9FAD16CBC20668@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d448bed0-e6a8-4a4c-0690-08da6ac398d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 02:49:14.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp/MQ/KTFSH2Eg7OC8F2a2ITrNW5aNTM6/2fOofElFU4KDbVyf4pHHvtYD01R2udwhAWQwJYqwa/Y4Dmx0gzFpTbnltb6JPfkrpvC13PrlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10282
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8wNy8yMSAxMDoyOSwgYnh1ZUByZWRoYXQuY29tIHdyb3RlOg0KPiBGcm9tOiBCb3lh
bmcgWHVlIDxieHVlQHJlZGhhdC5jb20+DQo+IA0KPiBUaGUgdGVzdCByZXF1aXJlcyBsYXJnZXIg
c2NyYXRjaCBkZXYgc2l6ZSB3aGVuIHJ1bm5pbmcgb24gdG9wIG9mIE5GUyBvdGhlcg0KPiB0aGFu
IGV4dDQgYW5kIHhmcy4gSXQgcmVxdWlyZXMgYXQgbGVhc3QgMjdHQiBpbiBteSB0ZXN0LiBXaXRo
b3V0IHRoaXMNCj4gcmVxdWlyZW1lbnQsIHRoZSB0ZXN0IHJ1biBuZXZlciBmaW5pc2hlcyBvbiBO
RlMsIGxlYXZpbmcgMTAwJSBzY3JhdGNoIGRpc2sNCj4gc3BhY2UgdXNlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQm95YW5nIFh1ZSA8Ynh1ZUByZWRoYXQuY29tPg0KPiAtLS0NCj4gSGksDQo+IA0K
PiBJIGZpbmQgZ2VuZXJpYy80NzYgZWFzaWx5IGdvZXMgaW50byBhbiBpbmZpbml0ZSBydW4gb24g
dG9wIG9mIE5GUy4gV2hlbiBpdA0KPiBoYXBwZW5zLCB0aGUgY29tbW9uIHBhdHRlcm4gaXMgMTAw
JSBkaXNrIHNwYWNlIHVzZSBvZiBTQ1JBVENIX01OVCwgYW5kDQo+IGBuZnNpb3N0YXRgIHNob3dz
IDUwJSB3cml0ZSBlcnJvciBvbiBTQ1JBVENIX01OVC4gV2hlbiBJIHJ1biBpdCB3aXRoIGEgbGFy
Z2UNCj4gZW5vdWdoIFNDUkFUQ0hfTU5ULCB0aGUgcHJvYmxlbSBkaXNhcHBlYXJzLiBTbyBJIHBv
c3QgdGhpcyBwYXRjaCB0byBhZGQgdGhlIHNpemUNCj4gcmVxdWlyZW1lbnQuDQo+IA0KPiBQbGVh
c2UgaGVscCByZXZpZXcgdGhpcyBwYXRjaC4gVGhhbmtzIQ0KPiANCj4gLUJveWFuZw0KPiANCj4g
ICB0ZXN0cy9nZW5lcmljLzQ3NiB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNDc2IGIvdGVzdHMvZ2VuZXJp
Yy80NzYNCj4gaW5kZXggMjEyMzczZDEuLmRjYzdjM2RhIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9n
ZW5lcmljLzQ3Ng0KPiArKysgYi90ZXN0cy9nZW5lcmljLzQ3Ng0KPiBAQCAtMjQsNiArMjQsNyBA
QCBfY2xlYW51cCgpDQo+ICAgX3N1cHBvcnRlZF9mcyBnZW5lcmljDQo+ICAgDQo+ICAgX3JlcXVp
cmVfc2NyYXRjaA0KPiArX3JlcXVpcmVfc2NyYXRjaF9zaXplICQoKDI3ICogMTAyNCAqIDEwMjQp
KSAjIDI3R0INCg0KSWYgTkZTIG5lZWRzIHRoaXMgcmVxdWlyZW1lbnQsIHdoeSBkbyB5b3UgcmVx
dWlyZSBhbGwgZmlsZXN5c3RlbSBtZWV0IHRoaXM/DQoNCkl0IHdpbGwgYnJlYWsgdGVzdCB3aGVu
IHVzaW5nIGxvY2FsIGZpbGVzeXN0ZW0gaWUgeGZzLGV4dDQoYXMgUkVBRE1FIA0Kc2F5cyB0aGUg
bWluaW11bSByZXF1aXJlbW91bnQgaXMgMTBHKS4gSSBvZnRlbiB1c2UgMjBHIGFzIHRlc3QgZGV2
aWNlIA0KYW5kIHNjcmF0Y2ggZGV2aWNlLg0KDQpBbHNvLCBJIHRoaW5rIHlvdSBzaG91bGQgZmln
dXJlIG91dCB3aHkgTkZTIDEwMCUgdXNlIHNwYWNlLiBVc2UgYSBsYXJnZQ0KZGV2aWNlIHNpemUg
b25seSBoaWRlcyBhIGJ1Zy4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+ICAgX3JlcXVpcmVf
Y29tbWFuZCAiJEtJTExBTExfUFJPRyIgImtpbGxhbGwiDQo+ICAgDQo+ICAgZWNobyAiU2lsZW5j
ZSBpcyBnb2xkZW4uIg==
