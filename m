Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72398C43334
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jul 2022 09:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiGDJou (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Jul 2022 05:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiGDJot (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jul 2022 05:44:49 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 02:44:47 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED1A2
        for <fstests@vger.kernel.org>; Mon,  4 Jul 2022 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656927887; x=1688463887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8y7fUbRyS+KA4bKkfpytqA66nnlN8XBJ+2GN/JQOIl4=;
  b=JbrANqL4Dwl34kMDZdWd6KzRuYsn17jdnZn1o+6xE+2QN+T0OlMTsQRd
   j/asLz1I49Izh6/eGOOsPe/6kJ5C81gyLRWvcsEn3xISYfNB0O0+MLPW6
   H6wAOwk8VbGokG8p645qoE1LGFAqfxi7zRbK3vhUsG0bBjHMtWNmlyefG
   dbBCofMIav7SJoB1yC6hXZrkS54JKWn7A3yo5DSFAhOGnwpHQLSgYVOPF
   DzHca1X/RV1kBU2drAEZX2kl+6DibKEzEdgtwdlgjOTRvwpsEerETC3dP
   g8IQw1yLThCqbsT+nYNAAEMpKrwRmTkbbQ1ojLau04CjF9N/Qt/vlmp7U
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="59715920"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="59715920"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 18:43:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1ZQkLeqzAWp3jmBJr0z5EEoKeyO4oR8AKzV5mIqFbQqKUwSCY984ZxRwfLVSOYWAx7z7dJz6UKX/Bp92F/BzjF+VFtawtlSxMus++DSmAVHfmbJqS+og88JnTPtvQJ9Tv2iM33VaN6zSv60wIVT5RHZJYXmD59IR7SJENOyo3HYGRuT4LQCl+fAFXNq+kHwvBh5NI5vXDaU0jACQSDK8WAYEPR6b0uv+McM1/INct5BUnnpNLOP0yVUfjcIcoOOP4SmtTpu4VX8BLJix9FXz7uiVX3+XeQ/63D29UdlsPE6sltFPB0F6jaF90wFhwjtXzI/yWYg40rcKt3jyjmepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y7fUbRyS+KA4bKkfpytqA66nnlN8XBJ+2GN/JQOIl4=;
 b=UkkFIE/bX5EhJmYTR2CrWQTsdyK8jes6wYOQnceQ70xbQcHM40Ky1OrypyVckiBjvi/GqWK+uEWIbB16jEbR0nRFro6/+N/IwvxdpXz5ljdFRgnQ0VkEsStWDdt74j94ynruAx9BKPAoiiagxDYcOxZvlEqESRdCXDsE4I4741YdJD+9rZZLdJ+Zr4vs9z4UzrZexJsqY6LBbgqV34uly3FxHNERgYGuIsraeK555FENV1QIHDv3kPMltDGw3OafVXYMbAQsaptcIeCalWNTyS5OxEQRfhd3RtZ3T0UNk600lVJ3DdRDTzxtSlLCBFqTju3yptQn+TBhql/3oqR7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y7fUbRyS+KA4bKkfpytqA66nnlN8XBJ+2GN/JQOIl4=;
 b=LEHxdMMGcyeY4GZ14auHD3zelVtTK3nkJWj9NoDPlhFgRrgVBrjDo7jr+9fwmm0VxO3raSprGGwmqoiptUhMHzTPaHD+LXG7zVI2bN4Vbxpw98VFRAPwGVpNhppt3gu8xaHkqwYIp7FQpvUqcYoZ0JYYf6rOleluGWl3HIQwzBc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB7185.jpnprd01.prod.outlook.com (2603:1096:400:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 09:43:37 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 09:43:37 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/2] xfs/270: only check new_ro_compat value when mkfs.xfs
 supports nrext64 feature
Thread-Topic: [PATCH 1/2] xfs/270: only check new_ro_compat value when
 mkfs.xfs supports nrext64 feature
Thread-Index: AQHYiin5NB1CMHYLW0CyC1PmVpHMQK1uEb+A
Date:   Mon, 4 Jul 2022 09:43:37 +0000
Message-ID: <62C2C48D.6090109@fujitsu.com>
References: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7945459f-40b1-42fe-941a-08da5da1abb3
x-ms-traffictypediagnostic: TYWPR01MB7185:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aLKczt+ViUYeouoX7GmHHRjWuR8xBeBR3X284a64WAbWss64cKuNqmK6xPM7cgf21Yl/3eAxLRdmVozm5RrjqjmA3RglmwaKlN8x3aZOsiPQXTAQll32FexjsEJsnWN9HZQPQAEVzfDRlPMuDfQgBwF1uPf1aO5U+v/6X/FK9OVqV3YpssPktSFzms8jTnf5kT69KbrzqhAUvXQeBrGcWORqOKI0oJrbfQ68qUxCIyQRUfuAZ2HyIDI8dp81BIGikDVeyCnfxBv1B9aK7BJsIuoBeE5V0IdYFx9dH6r61xLx7y9l6bBiga8brTTQK0A07WfnfWMjWUkkLmVQbA4LAaBxB/rPA1D3DWylAHH8CtuSMo3V7wDhVKUIIRxwDTKxaBAdtuce2l3hw+XFeODuhH86X7nfN2Cjp3vKLMrbbk5WkUAPGm2/s98LqgoomjkwI4wy4YY5PXQd9JvvLVna6i2cO7ExvWOw0LAFr2XY1QK8q6gMz/WKRRUJbhVkxhp7uv2HAzHa3xOhsZFifliD/LspEM5T0ICTqyf7k4fG3jp0Q/HGh8GaM+6ewufwPGJBsKHvFzzo9AgIONL3Oy/4nL7p5qXFn9bpLKn3Oim58CB7nn8QvEch0IUtil0PSNuz9eqSI7UorvIRzfs9tQLwSUTJ6tHcs1Cob02xdOXytOxBV/zzCuhcEn0fBn6lQdXJ3lDhIIGDPq+I8wasgQ5j3WslZNYlrCFgEViMgsOhYMt04pRfXplJP+wFF+vlzFt5388nwmEWPU4W0yedVtNkjSJpx5GQtrNWB9KfqbrqSHTD2gn1Uc47FdeYIMxBBWNA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(478600001)(33656002)(86362001)(6486002)(5660300002)(6506007)(6512007)(87266011)(41300700001)(8936002)(26005)(82960400001)(2906002)(38100700002)(122000001)(186003)(85182001)(2616005)(38070700005)(83380400001)(71200400001)(36756003)(66476007)(64756008)(66946007)(6916009)(91956017)(4326008)(8676002)(66446008)(66556008)(316002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?enRTOGtDK014SGx0SElySlo5WWRlVGMvc045OXZNMXVxK2oxemt6aG9lNUp5?=
 =?gb2312?B?MnQrQUxLbFRpWk9VTzRSbnB2QnhEd0ZmQmZ0eWZPNlJHeW1VQVQrWmh0SDFV?=
 =?gb2312?B?V3BGR0pvKzhHb1pGU1hXWENsWjg0eWlvL1pxRHYxUDNiTUQ2azh4bkpxMEpu?=
 =?gb2312?B?cVdFVHNIYnFQWWNYZGxZNnN3ZGVySGNsUE4yUWorT05WUFB5eWhtV0pMc0pI?=
 =?gb2312?B?RS9WU1lPTjVaV04veGg5VEdiQW83V1hHeXdCQWYwYkNzVmVFYlVUeEh2R2RZ?=
 =?gb2312?B?OTI0K0tycDhERkFFQzFSNmduUU50U1Rab3pJQmJIUDRqVzJpT1duNUNobU5i?=
 =?gb2312?B?YVV5Nm45OFhsdEVMME9yeW1wcFcwNmZKSVB3ZE9BNVZKMDJQUkR6NmJra2xF?=
 =?gb2312?B?TWE5dlhxVU9OTE53elRobnZhYjBWMDEvTXNxQjAwSjZCbG1Wc3VOWXg4Vy83?=
 =?gb2312?B?dDc1UTVaK2JEKy92eGRvQkhDV0V2OWRubHJmb3JXV0N6MUxhaUhwbXZ0ZXpK?=
 =?gb2312?B?THlkZVIwU0g5YUpoQUh3SHQzMDJLdzYycGRDSEV1RGNJREJlTENPTHZiWnRC?=
 =?gb2312?B?bFE4ZTVGQVQ1YUJNZ2hycE40VW9DUlE3V2llcmpUZGhGUDM4RGNVcnJ1K2o0?=
 =?gb2312?B?ZUw3RUxPN1RxN3kvZURyMHIyRjlyWmtsNHhxdzBEblpCS3J0Y2YrUmJ2TTZl?=
 =?gb2312?B?NldhaG5VQ3Q2cXZpWEcrSS80VEpsREM0VVlSem5TR29jdFBuUTVDeWZNZFR2?=
 =?gb2312?B?b0VoNjlyTk5Rb2JXU0loN3AydmNpTTdvSnZ5RlM5WTh1b0NvZXpXYmpVcUV6?=
 =?gb2312?B?V1NtdXptOTRCTFJqM1I1bUlaY2lWZEQwb0Z3aUtBaTRvTkVIYk5QNmdqNUlw?=
 =?gb2312?B?TCswdys0MU5mYVlDbmdDQ1pVMHRRTWY2S1JFN0I3R1RLSHFjRThnM24waGtI?=
 =?gb2312?B?MU1vMXhpdklHSkZwaFd1b0s4Y0s1SERkdTNXbDA5b1ZDQTlQbi9lbHFmWk96?=
 =?gb2312?B?V2NHdUpHMlEwUnhoSnBqb01IcXhNMzNvRFJ1T0FENGtsM1Q3ZFd5SVZkZFB5?=
 =?gb2312?B?OFlOLzB4Y1pNVFR1SksvSE53M2czT0NEby95YVovck83Q2d2YTdNVEVFU01h?=
 =?gb2312?B?MmZiblFLTEc2VG0zQmx2MjNxU2pBQURHQld6bWpOR1RDOGI0UWdhY3oveHor?=
 =?gb2312?B?VlFXaHVGVlRKcmI1NC9uQWJ2YTc1WFZhVmdTUmR6ekk2SFVmOTVkbHJXWGFD?=
 =?gb2312?B?YzR6SGo5L09FaDdqUnB1aTFTV2UvVUlDZFEvdDVPbTljU3RrQ08xRmFsaUx6?=
 =?gb2312?B?ZitJNDZmTDVHYzlOczdybG53eTd5b00zVXAyRTdtMTJZejB2MHlOMU1OQ0wx?=
 =?gb2312?B?aGM1b0UzcWhZMjgzQmR6S0Z1MmhkemQzN3pNMzJ5MUl3Tkpkc0xsaDM0SHMx?=
 =?gb2312?B?aDhtL1F3ZjdIYTFpTlNPR01qdlMzN1gwVTZnYjN4cDJsUm5qOWFyVDJXSE9n?=
 =?gb2312?B?SkpKQ3QxQWdrdjZlOGRSYTh1VVNUTEpRUXNZcDl4WjJDdmJ6cmNQZmpwS2Jz?=
 =?gb2312?B?Y052cGJpMXhvQzFCVWhNWGpHTHN3Z2Y0ZUtmRFJvZlVRUUtrOEJxQ0xra2tv?=
 =?gb2312?B?Q1BzdXlyWlpMc2NRMjRBc0Y4RTlPTk1BYlEyY2VBWVlJVHVTMWNWMGJubTht?=
 =?gb2312?B?VVlJcENxNEUzV3FEM0FoVWVmUU5zaXAxeVBzTEI4ZWRjSndMdDYyamFXMUpx?=
 =?gb2312?B?SW1tN0NBM0U5Ym5Za2EvaVVUK3RZenN6LzlvL1RHQXVXR0dBZHBGSEJBVXUx?=
 =?gb2312?B?V2YwWFRWcForWFJSMTBYSVBGZ0hwRS83TWJHVU1vVmYxT1NtSDVvWjRxeUZm?=
 =?gb2312?B?bklmRmYrRElvRDUwZnppVTJxREtYNTVFZExtVk9jcDR0S1Ntb3EzUDFuRUVX?=
 =?gb2312?B?bU5odmpHSGM2cXpLT0RXRng3dmx0aU1UdS83Q1dYZmtUb2s3MzlHaXRTTXlB?=
 =?gb2312?B?SjM4L1dnTHRDZDdvYkdFdkM0WHNnU2pJV0Q3MzhNSWxqWXRFU3FaQTFyU0RK?=
 =?gb2312?B?OVpQcXJObHJFYXdyZUNDVjBMV1g4R3VEeGs2MWttelVlYWl3Y3BsS0UxOGp3?=
 =?gb2312?B?NGFSajI1N2ZDMWpaeDBRcVN1ZWUzd01qd3ViOHJuSXQ1a0xsbkZYcmc1WlhS?=
 =?gb2312?B?QWc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <F26DFF43ABEDCD4C8C254F55EE31E2A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7945459f-40b1-42fe-941a-08da5da1abb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 09:43:37.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +T3xGtXgfHsJd6DHqPEkQvYVhrXKrmOnpwQCdaHeYY+ZryJzrNgCbjkOGP9ixw92grfC29LsbzAvpehkMiWI7Lzk/NGf5zdzJx2ew8MXOBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7185
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgWm9ycm8NCg0KV2hhdCBkbyB5b3UgdGhpbmsgdGhpcyBwYXRjaCBvciBzaG91bGQgSSBqdXN0
IGFkZCBhICd4JyBzdHJpbmcgd2hlbg0KY29tcGFyaW5nIGdldF92YWx1ZS9uZXdfdmFsdWUsIHRo
ZW4ganVzdCByZW1pbmQgdXNlciB0aGV5IG1heSBoaXQgYSBvbGQNCnhmc3Byb2dzIGJ1Zw0KDQpm
NGFmZGNiMGEgKCJ4ZnNfZGI6IGNsZWFuIHVwIHRoZSBzYWx2YWdlIHJlYWQgY2FsbHNpdGVzIGlu
IHNldF9jdXIoKSIpLg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCg0KPiBDdXJyZW50bHksIHRo
aXMgY2FzZSBmYWlscyBvbiBvbGQgeGZzcHJvZ3MgYXMgYmVsb3c6DQo+ICsvdmFyL2xpYi94ZnN0
ZXN0cy90ZXN0cy94ZnMvMjcwOiBsaW5lIDUxOiBbOiAhPTogdW5hcnkgb3BlcmF0b3IgZXhwZWN0
ZWQNCj4gDQo+IEdldHRpbmcgcm9fY29tcGF0IHZhbHVlIHdpbGwgcmVwb3J0IHRoZSBmb2xsb3dp
bmcgZXJyb3IgYWZ0ZXIgc2V0dGluZyBuZXcgcm9fY29tcGF0DQo+IHZhbHVlOg0KPiArY2FjaGVf
cHVyZ2U6IHNoYWtlIG9uIGNhY2hlIDB4NTYwMzNmZGU0OTIwIGxlZnQgMSBub2RlcyE/DQo+ICtj
YWNoZV9wdXJnZTogc2hha2Ugb24gY2FjaGUgMHg1NjAzM2ZkZTQ5MjAgbGVmdCAxIG5vZGVzIT8N
Cj4gK2NhY2hlX3plcm9fY2hlY2s6IHJlZmNvdW50IGlzIDEsIG5vdCB6ZXJvIChub2RlPTB4NTYw
MzNmZGY5MTEwDQo+IA0KPiBPbGQgeGZzcHJvZ3MgbWlzcyBhIGJ1Z2ZpeA0KPiBmNGFmZGNiMGFk
ICgieGZzX2RiOiBjbGVhbiB1cCB0aGUgc2FsdmFnZSByZWFkIGNhbGxzaXRlcyBpbiBzZXRfY3Vy
KCkiKS4NCj4gDQo+IEhlcmUgd2Ugc2tpcCB0aGUgZ2V0IHN0ZXAgb2YgbmV3IHJvX2NvbWFwIHZh
bHVlIHdoZW4gbnJleHQ2NCBmZWF0dXJlIGlzIHN1cHBvcnRlZC4NCj4gQWxzbyB3aWxsIGFkZCBh
IG5ldyB0ZXN0IHRvIGNvdmVyIHRoaXMgeGZzcHJvZyBidWcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL3hm
cy8yNzAgfCAyMyArKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3hmcy8yNzAgYi90ZXN0cy94ZnMvMjcwDQo+IGluZGV4IGI3NDBjMzc5Li41ZmY4M2VhZCAxMDA3
NTUNCj4gLS0tIGEvdGVzdHMveGZzLzI3MA0KPiArKysgYi90ZXN0cy94ZnMvMjcwDQo+IEBAIC0y
Miw2ICsyMiwxMCBAQCBfcmVxdWlyZV9zY3JhdGNoX25vY2hlY2sNCj4gICAjIE9ubHkgVjUgWEZT
IGRpc2FsbG93IHJ3IG1vdW50L3JlbW91bnQgd2l0aCB1bmtub3duIHJvLWNvbXBhdCBmZWF0dXJl
cw0KPiAgIF9yZXF1aXJlX3NjcmF0Y2hfeGZzX2NyYw0KPiANCj4gK25yZXh0NjRfc3VwcG9ydGVk
PTANCj4gK19zY3JhdGNoX21rZnNfeGZzX3N1cHBvcnRlZCAtbSBjcmM9MSAtaSBucmV4dDY0PiAg
L2Rldi9udWxsIDI+JjEmJiAgXA0KPiArCW5yZXh0NjRfc3VwcG9ydGVkPTENCj4gKw0KPiAgIF9z
Y3JhdGNoX21rZnNfeGZzPj4kc2VxcmVzLmZ1bGwgMj4mMQ0KPiANCj4gICAjIHNldCB0aGUgaGln
aGVzdCBiaXQgb2YgZmVhdHVyZXNfcm9fY29tcGF0LCB1c2UgaXQgYXMgYW4gdW5rbm93bg0KPiBA
QCAtNDMsMTMgKzQ3LDE4IEBAIHJvX2NvbXBhdD0kKGVjaG8gJHJvX2NvbXBhdCB8IFwNCj4gICBf
c2NyYXRjaF94ZnNfc2V0X21ldGFkYXRhX2ZpZWxkICJmZWF0dXJlc19yb19jb21wYXQiICIkcm9f
Y29tcGF0IiAic2IgMCIgXA0KPiAgIAkJCQk+ICAkc2VxcmVzLmZ1bGwgMj4mMQ0KPiANCj4gLSMg
cmVhZCB0aGUgbmV3bHkgc2V0IHJvIGNvbXBhdCBmaWxlZCBmb3IgdmVyaWZpY2F0aW9uDQo+IC1u
ZXdfcm9fY29tcGF0PSQoX3NjcmF0Y2hfeGZzX2dldF9tZXRhZGF0YV9maWVsZCAiZmVhdHVyZXNf
cm9fY29tcGF0IiAic2IgMCIgXA0KPiAtCQkJCQkJMj4vZGV2L251bGwpDQo+IC0NCj4gLSMgdmVy
aWZ5IHRoZSBuZXcgcm9fY29tcGF0IGZpZWxkIGlzIGNvcnJlY3QuDQo+IC1pZiBbICRuZXdfcm9f
Y29tcGF0ICE9ICRyb19jb21wYXQgXTsgdGhlbg0KPiAtCWVjaG8gIlVuYWJsZSB0byBzZXQgbmV3
IGZlYXR1cmVzX3JvX2NvbXBhdC4gV2FudGVkICRyb19jb21wYXQsIGdvdCAkbmV3X3JvX2NvbXBh
dCINCj4gKyMgSW5kZWVkLCB4ZnNwcm9ncyBoYXMgYSBidWcgaGVyZSBhbmQgZml4ZWQgYnkgY29t
bWl0IGY0YWZkY2INCj4gKyMgKCJ4ZnNfZGI6IGNsZWFuIHVwIHRoZSBzYWx2YWdlIHJlYWQgY2Fs
bHNpdGVzIGluIHNldF9jdXIoKSIpDQo+ICsjIEhlcmUsIHdlIHVzZSBucmV4dDY0IGZlYXR1cmUg
YXMgYSBwcm94eS4NCj4gK2lmIFsgJG5yZXh0NjRfc3VwcG9ydGVkIC1lcSAxIF07IHRoZW4NCj4g
KwkjIHJlYWQgdGhlIG5ld2x5IHNldCBybyBjb21wYXQgZmlsZWQgZm9yIHZlcmlmaWNhdGlvbg0K
PiArCW5ld19yb19jb21wYXQ9JChfc2NyYXRjaF94ZnNfZ2V0X21ldGFkYXRhX2ZpZWxkICJmZWF0
dXJlc19yb19jb21wYXQiIFwNCj4gKwkJCQkJInNiIDAiIDI+L2Rldi9udWxsKQ0KPiArCSMgdmVy
aWZ5IHRoZSBuZXcgcm9fY29tcGF0IGZpZWxkIGlzIGNvcnJlY3QuDQo+ICsJaWYgWyAkbmV3X3Jv
X2NvbXBhdCAhPSAkcm9fY29tcGF0IF07IHRoZW4NCj4gKwkJZWNobyAiVW5hYmxlIHRvIHNldCBu
ZXcgZmVhdHVyZXNfcm9fY29tcGF0LiBXYW50ZWQgJHJvX2NvbXBhdCwgXA0KPiArCQkJZ290ICRu
ZXdfcm9fY29tcGF0Ig0KPiArCWZpDQo+ICAgZmkNCj4gDQo+ICAgIyBydyBtb3VudCB3aXRoIHVu
a25vd24gcm8tY29tcGF0IGZlYXR1cmUgc2hvdWxkIGZhaWwNCg==
