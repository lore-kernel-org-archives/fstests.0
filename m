Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BDDC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 02:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiGSCNJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Jul 2022 22:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiGSCNI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Jul 2022 22:13:08 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8055E3CBF3
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2022 19:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658196787; x=1689732787;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5uwP4IE8jSgpOBrazxP9GeGuf7koHfFU3e07us5BIuU=;
  b=rdK/3Z0t6YEBhhznzutWxv8CCdEqAjOvfzIeE74HS+E7fsRsME2jTi3d
   4z13VQtx9+WUlbOPdOWIDjKRCyj72Z9gJdG2G+FYjJ6R31m7fhqR6r+Ys
   b7huBCVr/yMfPU4Rdpt5tHWbnKhUDQlxPAHchZHO0oR+lVABEpGHBCWxP
   /uiY0UYfqQCh6gQHMMHr9KlZ3+R0aIN5RzD/uqL25uYsJ9H7JnP93qko3
   SUe3QNeBPKHWl4gjJ9SlMViMashUNHoq6K3ECEy1uWcpDlXXWQJ/Q9OvQ
   6DoE1nAbQLKFGC55ATsIq+cvrS2PCb2tyuSwikUKQ4FxBeT8bdFUa981Z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="60665970"
X-IronPort-AV: E=Sophos;i="5.92,282,1650898800"; 
   d="scan'208";a="60665970"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 11:13:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3rCMdkJhKDJVNtAm4qy9wEdvcyrPUKPn9AcEf86guBXFkgl36mjqUkjBfhtiOOVKXLwJ+rfDlMsJWdkDEF8NlQ0Y1PeDtTtQk5jomwC1YZ0UAnj6eYFwm3aT/XnuuBTZ4t46GKQ2QXCVeUlwQ4hg8GOeCubdYXLx8cyvrn4Z0tAwy8tiORjlDnPjOXkhDsfASwYhs6XlssaMcsj2iofaoyWGe6MjLanVcaVIF/UooZy6eCRd+WQvmOXqTdwQ2yvpRzbNHbAcmkzsu27hvp2xeAUPbpW6RzMuZgrdMtgoFfEUTmLS+nYhMhjmEeEmBGq/Ro6jSf3SAsranP/8s2oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uwP4IE8jSgpOBrazxP9GeGuf7koHfFU3e07us5BIuU=;
 b=akTWRv7cTwsLD6m1yqK2vNllURcNBivDLxxWhBTPBOBBjitdnKYfpaLHZOg+Ply1K4VD80fZeyUKKZ1pZ9qGwRcN8vdwVuH6cILr1YN9/mSKfmmDl+RUnKXpWQ8xbRJKsDy93fTYf0BJ4FD6vp6xCRTnHwyG8KA55CxXMFtWXA4qRjDqEtDA8sPkC0WuFWEyMB8lMVUebc41SX3uGTAAUlHMcOTH7HyfuaL0aV02P0ZX8+nPs7APG394zfDI9aBPITmyh2g9Jl9ZmUOG/KvgpotJV6AsCaIKXfIR+SM22PmWDg1DIqaHsfMYGmHHPJHQ4CrPULmuCCmO+CpNf6xa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uwP4IE8jSgpOBrazxP9GeGuf7koHfFU3e07us5BIuU=;
 b=kpvamJ+wf058FPOFtiG/5zWB5QRy5UTBsKEvARc0F9iyxNnlAztxKNJZIPx1rvvgN19RwVsXJCBx7Qro2aaaqgoP95LxaB/LcYodfA6CwOJ9bPPfPfKNRwdM58wnPc+39h4FYX47aeXbQESACA8S3+71XMdY0nW9SBaHoXnATEs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3959.jpnprd01.prod.outlook.com (2603:1096:604:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 02:13:02 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:13:02 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] xfs/270: Fix syntax error
Thread-Topic: [PATCH v2 1/2] xfs/270: Fix syntax error
Thread-Index: AQHYkEf7dWlq1nGQxUiEcatCQRazUK2FGoQA
Date:   Tue, 19 Jul 2022 02:13:02 +0000
Message-ID: <730f0fe9-246d-683a-e1f1-68c2951ca1d2@fujitsu.com>
References: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adebf645-55c7-4f6f-08c3-08da692c35a0
x-ms-traffictypediagnostic: OSBPR01MB3959:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7GXEauMJGxCtmEoy/Wi/xRdzT9hNjJ8CREoHlxgbD//e6JWtpMcNSX7cX7wskYZEYxlHhJiJ5E5WreiXmlfqTEm2lZCYr4zneNX5H+CvQzCxO4GNU3aUBdWcaNg5IzjaC3QR6H3BTK/u+eT3+SRrX6wHg1TPjePHqTAzMf3vGiyPLkoQwiLXk7X3G7aVK6clXsLVBkm13YBTiWR/gQmyR46mVOrTteNK6+EpMpCn2Wsv1/2f3189Vd4hktcOawOb0M6x36znAnI72/tEKswXBFD78gMJ1Ez6eAfjKLPsLXh3NJ9OYFE6MNhTl/nX5xw5Lc1uBg10PCbmhhG7RHIs8EWdVJUr/vVUuHkzC/g+1kTBf9/Cp1luiHWYFys1PBJfwJ0uExdTri41bDrIWHBe9RfQxTwDLf6N9df7pBB+qPz+OjH1uBbD9afwGVxv/jcVGYVtdDp9AtG+T9odgvybnDkWzhQ3O+Fsa9lTj2XNIqbOvQd9aYMVES0h59uDt/ovkBBhr5slhrMz/+cgpeUGiqLCwljcAd+Z73oFTzGxhf6Z9Mwc0m3QSGRQBkDW3bATouNI3NPsk5UTNMgVVev3TlIyiGk0mtc6P9sxdEJS/QMmzFK/gb2i6fhEqkUrN3kut5OPpyQbEONz+TWlrfnh2vZh8ckNtjStALpunabLP184N1BoOUxRq0qXE32ZVfs4qtG3LyIg+Z1bUhw2xEuF33Mjp0TaPglXBvmGcOqxFRSFX+vgriA3exOCZ04+3GNToiMNbpBZeuKPJMlei0DsEV6wGGP0nBSZ7gsc4EcAThQKiSUqDhMYzBMPDjtRz1kahOaIt8vkxK2SpEaPRaDE4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(86362001)(8936002)(82960400001)(8676002)(38100700002)(64756008)(66946007)(38070700005)(31696002)(76116006)(66556008)(66446008)(66476007)(85182001)(91956017)(316002)(36756003)(6506007)(6916009)(26005)(83380400001)(41300700001)(6512007)(186003)(31686004)(2616005)(478600001)(71200400001)(122000001)(6486002)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVpSYkxqU3ZrSEVsb0VFTGwxaXl2enYrK2dCZEl0RE5NMGJxYithNGc5eDV2?=
 =?utf-8?B?d0ZVazVUM1RJZ2VFUm9POFd5eXg1cWZES3YwUkptanR3blVVWmVyT0QwbWlH?=
 =?utf-8?B?OC9HM0I5NHpaQVQvOXA3ejNldTBvVk1EdE9YOW5VcFNuRTVaSmZTaWMrUks0?=
 =?utf-8?B?OG5PUklNTjNNM3JrSVlnYmFUM0RkdzZOTXlYS3RCN210U1ZHcHRkQkNRUDRU?=
 =?utf-8?B?blRpVG90dzI2M3o3ajdzeHVqUXFUNFNlaktabHBtNTlXc0c5WUxMeWsybjNs?=
 =?utf-8?B?YWk2K3ZLaDFQV2NIb2kwWHZaZjkxaU84TWVzcWhCYjM2QlpBWHc0YXNiL0JK?=
 =?utf-8?B?QUlBR1BjeFNUSDRYbUdzYXdYbnRhWGtKY2xuOUlDODlRVVoxZ1Y2bmliZGRv?=
 =?utf-8?B?SGNiUVNSTWdCeENGbTUzRkJXRVdGbXBBK3BGbW0xSStnTlZXMGlmQXRndUhC?=
 =?utf-8?B?Kzh2WWdRd0VPQ1ZBd0U5WUxOOUlQRHBCeVhxVUR2RlpJRlVYMFdiaTNGNXBJ?=
 =?utf-8?B?aFF4TjRhMXFuQVlKNmpqcUE1d2xVazdwRUNGZUUwMDF1cThQVDBySVpIbmFD?=
 =?utf-8?B?aENZNHNCeXBRdmN5bVNpanhHdjNiT1RLSWVCT081b05sUm1vS2JuVUZSTXVF?=
 =?utf-8?B?d3BjQnFqT0k2dnhIbFE5VXQwM1JYQnFVN3AyR0MzQnV6U2R0dHBERGZPVlhX?=
 =?utf-8?B?VlNHaUUwYVZGMlJkendQNjRQVDdjaS9Oa3gxVFRzNlpuZi9qdFdIUUxlYWFD?=
 =?utf-8?B?R3hmem13OWU5VjZ3SFN4R1QxYW1UWmowUVFKTysrOTBwVHdUcUtmMXlzMlUv?=
 =?utf-8?B?bVBsN2xCblhsSEVuQ1U0UjlkZTk3NStjYmh6YU9pU1IxUkJ2aitsT3ZsZVNV?=
 =?utf-8?B?dDYyZ3hGL2l2WGJXVXJSQlh5SU9KdUhjblE0Q2FlbVJnV3lZMHZoYUxFQndj?=
 =?utf-8?B?Y0ZWeGdMNjR1eC9vWE13T2VsYjQwVUJIc2NaL1NHWVhSRU9DODE5d1VPRzNU?=
 =?utf-8?B?MWVRTm9hcFJ0VklJSDZBb1FraS9hRmhxT1hsV29QOXVockt2TnREZllrM29X?=
 =?utf-8?B?K0FPK3dVVGV4emRKSWtCZVRtQlQvVEpQY0F1cHl4M2srb0ZuYnNOV3RJRWRZ?=
 =?utf-8?B?VGRPeDZHQW12NVF1WmljT0UxaDVtYTZmNDltYkd3OThubkwzK1RmMUdsNHps?=
 =?utf-8?B?eE1BUXJPdWViQW1aNEpEQVZyY1l4Ni9LNWNaTEI5MjlzYjl1VkNRWGUxdSsz?=
 =?utf-8?B?c3pmcUlZS1dTakVpS0QzUVp1RHdGbXJvZ3NISzdTZWEwK1JhSmNEWXhBYjlp?=
 =?utf-8?B?NFFoNWtkZnZGVFVQelZSMWtmWFBVN3JMTEJmQlJIWDVzREtNNFp2TE1DNWNM?=
 =?utf-8?B?Vm1NbjUzVklMN2kxZkk1emh5djRuMHB1NEVKL2FnQ1ZTdFozY1JKeWREUm5D?=
 =?utf-8?B?VGpBN1dkb3duYzhTUzArMnZjM29valUzL3A3VmpGSEpManc2cEI0KzBJNnNy?=
 =?utf-8?B?TUVEYXN5SWZYckdEYUN2UitSdlduY3NTTURoeG1hd2NhSHNxeWRoK0N6T0M4?=
 =?utf-8?B?a0lpaU80dFFFcURjYzlhM2VIRzFIN0Y2VnY0RnBFYnZBT25lS2ZuTWtyYVF0?=
 =?utf-8?B?L2ZUZEpON1lkVG00Y09WbHlobVJBS0p0Um9LK2dXeVdYcnl1bFgrWElSRnIx?=
 =?utf-8?B?eHJvVndnd09KUDdwUGRqMnFDQ0s4VjhTQU5xTWJyYVFFeTdwdTlhdGtxeFhM?=
 =?utf-8?B?aHNRQkpRMHRDVGtHd2ZaeVhJL0ZaeXNEOFdiaFB4akFkMlE2aUlwc0UrZzQr?=
 =?utf-8?B?dXAxTFBYUTA0K3BWTTcxeUlqcS9VeEgwNFNFb01Qekx5WXVUMkVIV3RzeTVq?=
 =?utf-8?B?RlFnVEFlaHRzUkI2S05DZWJpTm9Qc24vVnAvOVZJbzNxT1ZmWU5WNVRTQngx?=
 =?utf-8?B?OGpVZk42MEdhbFJYU09qN0wwcVFZaGJaRFNPTEU5czU2bU5ZLzRZN0tJSXdN?=
 =?utf-8?B?dlRWcmxwVWFoSmFOV2dQdVFLdDJDOXRCTldoOUVmTnF0cVg5VlIvKzF4Ylll?=
 =?utf-8?B?VlovUnFSMmp5bUJObXpEMzdCK1ZrYnNsNHFQSDJSRHlqdDZOTnVJdHRweE9T?=
 =?utf-8?B?MjVsRFE1eXNGc1UzMUF4dTB2YjNvSTBHem94ejNFREo2N2ZKWEVINkZyeUJr?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <460CA018A363C047BE8810656622DC8E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adebf645-55c7-4f6f-08c3-08da692c35a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 02:13:02.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gfj5qY4PWTC0nVsUd8qk3hVT6eXTv0EFCkh5rQRanqnuJ9M3ebcXgXDoDhqsW47dwEDFH2q5uHDsdy35zmYIBtW/ePix/04juZaddjsOd1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3959
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8wNy8wNSAxNzoyMCwgWWFuZyBYdSB3cm90ZToNCj4gV2l0aG91dCB4ZnNwcm9ncyBj
b21taXQNCj4gZjRhZmRjYjBhICgieGZzX2RiOiBjbGVhbiB1cCB0aGUgc2FsdmFnZSByZWFkIGNh
bGxzaXRlcyBpbiBzZXRfY3VyKCkiKSwNCj4gdGhpcyBjYXNlIHdpbGwgZmFpbCBhcyBiZWxvdzoN
Cg0KUGluZy4NCg0KPiANCj4gKy92YXIvbGliL3hmc3Rlc3RzL3Rlc3RzL3hmcy8yNzA6IGxpbmUg
NTE6IFs6ICE9OiB1bmFyeSBvcGVyYXRvciBleHBlY3RlZA0KPiANCj4gV2l0aCB0aGlzIHhmc3By
b2dzIGJ1ZywgeGZzX2RiIGNhbid0IGdldCBuZXdfcm9fY29tcGF0IHZhbHVlLCBzbyByZXBvcnQN
Cj4gdGhpcyBiYXNoIHN5bnRheCBlcnJvci4NCj4gDQo+IEZpeCB0aGlzIGFuZCBhZGQgYSBoZWxw
ZXIgb3V0cHV0IGZvciB4ZnNwcm9ncyBidWcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1
IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy94ZnMvMjcwIHwg
NyArKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy94ZnMvMjcwIGIvdGVzdHMveGZzLzI3MA0K
PiBpbmRleCBiNzQwYzM3OS4uNDk1NGU5NDMgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3hmcy8yNzAN
Cj4gKysrIGIvdGVzdHMveGZzLzI3MA0KPiBAQCAtNDcsOSArNDcsMTIgQEAgX3NjcmF0Y2hfeGZz
X3NldF9tZXRhZGF0YV9maWVsZCAiZmVhdHVyZXNfcm9fY29tcGF0IiAiJHJvX2NvbXBhdCIgInNi
IDAiIFwNCj4gICBuZXdfcm9fY29tcGF0PSQoX3NjcmF0Y2hfeGZzX2dldF9tZXRhZGF0YV9maWVs
ZCAiZmVhdHVyZXNfcm9fY29tcGF0IiAic2IgMCIgXA0KPiAgIAkJCQkJCTI+L2Rldi9udWxsKQ0K
PiAgIA0KPiAtIyB2ZXJpZnkgdGhlIG5ldyByb19jb21wYXQgZmllbGQgaXMgY29ycmVjdC4NCj4g
LWlmIFsgJG5ld19yb19jb21wYXQgIT0gJHJvX2NvbXBhdCBdOyB0aGVuDQo+ICsjIHZlcmlmeSB0
aGUgbmV3IHJvX2NvbXBhdCBmaWVsZCBpcyBjb3JyZWN0LiBXaXRob3V0IHhmc3Byb2dzIGNvbW1p
dA0KPiArIyBmNGFmZGNiMGFkICgieGZzX2RiOiBjbGVhbiB1cCB0aGUgc2FsdmFnZSByZWFkIGNh
bGxzaXRlcyBpbiBzZXRfY3VyKCkiKSwNCj4gKyMgd2UgY2FuJ3QgZ2V0IG5ld19yb19jb21wYXQg
dmFsdWUuDQo+ICtpZiBbICIkbmV3X3JvX2NvbXBhdCIgIT0gIiRyb19jb21wYXQiIF07IHRoZW4N
Cj4gICAJZWNobyAiVW5hYmxlIHRvIHNldCBuZXcgZmVhdHVyZXNfcm9fY29tcGF0LiBXYW50ZWQg
JHJvX2NvbXBhdCwgZ290ICRuZXdfcm9fY29tcGF0Ig0KPiArCWVjaG8gIk1heSBoaXQgYSBrbm93
biB4ZnNwcm9nIGJ1ZyINCj4gICBmaQ0KPiAgIA0KPiAgICMgcncgbW91bnQgd2l0aCB1bmtub3du
IHJvLWNvbXBhdCBmZWF0dXJlIHNob3VsZCBmYWls
