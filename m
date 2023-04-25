Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13574C6FD18
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 08:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjDYIBk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjDYIB1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 04:01:27 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 01:01:12 PDT
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66465BBA4
        for <fstests@vger.kernel.org>; Tue, 25 Apr 2023 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682409672; x=1713945672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7At99hdiT3m/4Y7b96/47i9x5m6RYldb59efFzkCs/I=;
  b=X/QHsJ1JvfoQKCLGvTQNEzn2E2TdjX60syaGPD8lfP5ttinQBFKoXWEa
   Y0G+8d+FyIpJqT5qHqWVAwCil4RHUZhgDeyxMRIQnmyTsaHa8T/J4fdMd
   uZoaqL1IYkw+W8LGQHe4tq9+A/Ks8fH3CFHWFCpJuo/Lq0xOgwlvLdMw5
   mdfSuBjCweiX+8R+C0QgNzg2ixSuoI7XXq76MJb5dOgwIXry4CPANnOuo
   NAEf6At2I21Pl9lcUhX9XXGzSrW9xtv7FEdMvmm1+M513D2Hm6aHb6OcI
   YiynYwlk/jbunyp7R7Iu8ZEg4zj5navLTuxzNa58JKc3qBC3L877HGFWk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="85384721"
X-IronPort-AV: E=Sophos;i="5.99,225,1677510000"; 
   d="scan'208";a="85384721"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 17:00:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbeuUfpzDus630ijKAVbudhmvmaiyKnqCtPbcwFinMDv83osL0DHcGmefjibDv7BfWo27sb83sBKoVhnv3MYiwoHWq6IuZ06xrhXY9DgkFHTSdMh5ixnh+iev24n+JQ4tqHh+DEvQhYnccFCsaWuX5pi9c2Ci3ZMVTORz4TDI8azSbV7XoNLhisvk73TQ0SWXAL4gDyCbu0b5n1lcd06rcA91YSWRP5XQgS4SG15xaVjCA2v3/II0DjN6WCzzlKkQqsMce82WVkz70DpZCcfVHK879vASWHpJeZ6tF1x0LPijRPaAYPNJ3wUpQ3/ehF44WlSqlrWoZZbLyWXcDK0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7At99hdiT3m/4Y7b96/47i9x5m6RYldb59efFzkCs/I=;
 b=dLDum4qltrF0eDPXtLy9zRB0bom6yMLGMOhEKi/ti3D08MzrPA6a2SPYg5Cezh9K+BZnlBl8JBqG5uPPKstp/er5AQ2LzbOfW9YkEUojlqxQ1JcgsPuhSLB7o0RF/sV9GJ9bNHoZnrCLBRGsHuQilJsb099V5J4oNin5pPee314++7hGPqBulcrCByLmxnEJc9XJnUm9r8mapEvk99W9umqO2BBwlSlrbcsvONyDuuM5KMcUdAvTpHvL77k8fy+RwYNlPCHjpG8P1F/x91iUmplxKcqtyRby3x30oPWgGVKYKufEWmh/OAXMzr83SBKnEbeB1ni0vwoB9KOkb3LauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10731.jpnprd01.prod.outlook.com (2603:1096:400:297::6)
 by TYCPR01MB9861.jpnprd01.prod.outlook.com (2603:1096:400:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 08:00:02 +0000
Received: from TYCPR01MB10731.jpnprd01.prod.outlook.com
 ([fe80::2a3f:7761:f2a8:6978]) by TYCPR01MB10731.jpnprd01.prod.outlook.com
 ([fe80::2a3f:7761:f2a8:6978%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 08:00:01 +0000
From:   "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
        "brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH] src/detached_mounts_propagation: Fix compile error
Thread-Topic: [PATCH] src/detached_mounts_propagation: Fix compile error
Thread-Index: AQHZdzebSPn0xvUDYUySrw+xWXarHK87pgeAgAADZwA=
Date:   Tue, 25 Apr 2023 08:00:01 +0000
Message-ID: <1ac90f0d-69bf-2507-c0db-684923e3bf70@fujitsu.com>
References: <1682400834-16985-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
In-Reply-To: <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10731:EE_|TYCPR01MB9861:EE_
x-ms-office365-filtering-correlation-id: f7878ac5-e43c-4396-4b19-08db45631291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhvEzoibeiyeiXCQhZKFUEYveCSR9Y96E+cBa2+TwBkxQsCpQuq9JpzH8O3mx3GUHmmCZ9ShpcLeOtTZGVg0W6zDQEMBI0uN+v3/PG6SjK6rlmUar9RBT+5WF5jwjQ/tfeqVJdqVbpqflu6KN4G7Hlbe4NH8v5uEr0sxf7yclyaOE+7qMajliLMBqf0vQSdUbHgYe1ynm7VWWjYd3Hk27AFjx7d/ot9AijBnNWNIz0gX+1iI6YgpOJHFs8LRKLa/3kU7dJ48BGwachp20sG2Xy89IuO7DiChV1A+KR3dcot5MVzy0HSewnJqHejwE+ehkVAQeDv8cwS/T5iEvnDp6eD1ZBfNS/U3s20hxT3ZzsrcEUUv/UZjoYo+f+/mLjW7wwy//wtcApT2rak9iZZuZKOniydqS6VtFAxfxl4y2R0TY9TqY9N+Brr/hzD9JumWWTpU62PLyCbdcnRvwhVJwjPIamlmPd7oR7kGUL4KdL0yMaA+Tm5WyYUbJluPPHg+maqPDj+HbYqEOvosbugJzXwRtvwGDeInE+ZmLAsK3+SDrzZXr0vmH5S2kpwf4ILhIe/EOLegtnqkuhuk9+NVEMxQygR2PshGSeQiv0/u+/agYI6/PR0th2txCycYHhr2i57hUle0XLCHth/MHglIV1z+x+KKDxs83oYEYMqT80c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10731.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(1590799018)(76116006)(2906002)(66446008)(66476007)(66556008)(66946007)(64756008)(316002)(4326008)(5660300002)(1580799015)(8936002)(38070700005)(8676002)(41300700001)(85182001)(36756003)(31696002)(86362001)(186003)(26005)(6512007)(122000001)(71200400001)(53546011)(38100700002)(478600001)(84970400001)(6486002)(83380400001)(31686004)(2616005)(6506007)(110136005)(82960400001)(54906003)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG5QWTNTMExKNlBDaGVIZ3JHMFNBTlVZa2RJL1dMbk92UnYwUXRCWmJKek5H?=
 =?utf-8?B?MVZ6eHF1enM5TkdLWi9VcEhVTXlyckxiNjNwZXUyUkhDb0NDa2M2WGpwRWdI?=
 =?utf-8?B?ako3U2E5VWJReEhpUDhBMzNKeWtKRlE0dTJ6YWpKMk9peWMxM1dwVzR6bjhG?=
 =?utf-8?B?ZGV2azVzVDVEK0tVR1hzdjVITWt5aFFLNVJqTXFpUVhvdVZ6U1ArNnFEdGRo?=
 =?utf-8?B?d1VrMkJmSDYxS0pKRGVIZGdhMmRWMURSdnhCOUo2bWlsMkMzcjZWWm9UVk9R?=
 =?utf-8?B?bmN4RXpYTFVVN2NzZGZCclJuai9nMm02elc2U1dWUC93NFcwYW5ZMXNLSnhE?=
 =?utf-8?B?VTlPMENOV3VCRnhtRlpQbEM2RzlqZ3lnTVBOeU5UK3JSUjllQ0xobG5nbUlq?=
 =?utf-8?B?YTVUTnJVNnhJSjdHUitsOGpKVGN2b0YvM2MyZ05HVW1vSXNBWEx6Q21jaHE1?=
 =?utf-8?B?cEdCdEFCR0YreDRSTmRzZStZRGdma3VXK2JLV21hamlKMkoySTVBdWpLV2tJ?=
 =?utf-8?B?UmZXMWV4T1Qvei9ObWlJQjIrRThnZTJBTjFQZzZScEF5NHRHeVd3eWp4eGt0?=
 =?utf-8?B?dm5XTTc3bk5IZ0oxMmRmMDRTd0dRbnBldjljd3lKa1drRk0zc0FickU2QVY3?=
 =?utf-8?B?b0pPUjRoWEJoMDZaTUxwUE1RVlB1NnIxMWl5eXdqTG5lODFIMnFraHBRNWkr?=
 =?utf-8?B?bmViQWhMbm5rdHFEaUJJZFVvOHo0dmZTK21rMytKK0JkUlVrcE0yRVl6eng1?=
 =?utf-8?B?WEQ1OFc2eFhrZjUvbGUrRzlha051U0FLMXIySW9HYnhIVUlVcVNON2hUcmVw?=
 =?utf-8?B?aHdnZ2x3NHVPZkhTLzlZcnRSTC85L0ZMdGYxNFlHQVc2VFpBbEtyRWJtcUpr?=
 =?utf-8?B?WVluaUtiYXE0T1N4U0xDcDE1L2lNRjdqaS9mSDhqdWdiL0c2K2drS2wwMG52?=
 =?utf-8?B?R0c4VVFLcHVTWVB2TW54YmFlNG81SlZocG9zV2hOTEMvcFU3RndvUU1ZYnpM?=
 =?utf-8?B?TmFCK1hOallIaWprUjNCWURGcG1YMm05cFF0aW1BaGZhTkRuVEpXT0gzSzFs?=
 =?utf-8?B?bDJYcWlHWk1aUEtUWlpmQnQ0L000ck5nMUg5Z1ovSUlTQklrV0M0Rk4zdnhP?=
 =?utf-8?B?WnVaWHVIUldlM25NZUFjc3FBVnpxMnhHQkt1amFVQzVDTWpzTngzYTgzUlJF?=
 =?utf-8?B?YzlVemFqTkx2bXJPTHY1L3hiSG92RmhOdlZjKzd1WG40U0NERmxFcTBCTlVw?=
 =?utf-8?B?OVBOTHlhdFZiNjdDY3lZUGtGS201eXZibkg5TkIzbVVyTlJQY1VzcWdCcUhC?=
 =?utf-8?B?UHE4NG05eEM4MkQwSjQ4MDkwRVhsT2ozdWJDOEJLODZNbE9tWDZoSmQyQVpk?=
 =?utf-8?B?WEhlRUVjaHZ1ZGRNb1R5OXcreUMyY2phZ1IzYkVXenAyUlI1eU0wa3BFL0xE?=
 =?utf-8?B?NHNkU3ZQd2lLdFRZRzlvOURKTWhzMUsvY3FZdHRTeTNHNnJXWjhaaDFYcSsy?=
 =?utf-8?B?QUlqZ1dqZWRyN0I2ZGtjYmlHUWlIQU90WGp0VDZ2VE9UUkJCVjRnOUxaUGRv?=
 =?utf-8?B?T0l6dFlsSFh4RFQ2VXNid2tGeGMzaW5ySk5pV01qVVZQd3VpdERLRUJHUnlE?=
 =?utf-8?B?QmkwbnhEaE1vbGU0S1RhZXBYQ0VacXA3YUwyVWtmS3RlYVkvL21oVy9BZFB2?=
 =?utf-8?B?YUFiT1VNVEpaeWxDN0xGbHZuU1RXTjNycWp0YjFFbTk1OTFoenFEbXV3ZXZi?=
 =?utf-8?B?Z0hieDV0dVJxeTdjRm1tNVhYVGw4TU41cTBCTm5SQjNqbVVmMXpGZjBwODhU?=
 =?utf-8?B?ZUs1Y1dqNEYzdEY2U2VaSWV3RDJRNDJSZEpIZ3F3TTdRY0FPUjBwVFRvbW5B?=
 =?utf-8?B?UWhSeW5BREVzQUZQSldDb2NqeHBOVXM3TnB0REU2QlZjK2FEVHF1dFBLaDh1?=
 =?utf-8?B?OTJMdnduWWFKZ21sVGRpWU9WUEhRamlVQlZQWUNtRVArMytiaVpjb0I3eGFW?=
 =?utf-8?B?bFlFRnYyV1d2aFNKa2U1T2tZWTFSOWE2VEx3ZE9hSWI3TytkNnZIWlBYeHJK?=
 =?utf-8?B?VGNYWm0ySXh6VldGR1Zzdk1kU2VHYWE4b1NFcEVGQU80ek5LQkpDM0FubFpX?=
 =?utf-8?B?MUVNbFYvUTNiR0tKdjl4U1QwRWsvekNpRjVDazBaNFdxbTk0bkhhWkk1dldC?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F355AB77D3F374193AD098567A06E1C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mj9Y9cQd9M/nX7aB5pVn8wfQdl90mP3GzDmhrps+AoYIrmfvUo7MzODNg8mQntdUKBwjfjnH2hF/RWhcw+rTraIsTn1kNvABrSnWpyD77M+x25tYC+HyjHmQTgTVzFVYrH7v3x2xhs3EkiIbj5howhxSRiKzRLt3/6m2bXVX8tQ43YOxmL8+8TroX4w0oOJqc0SUjVHwLLCdKnwtodpXaWOCmy782JMk8dhxk0KvA/SVo6whNXeP1qi7uak4td4N37ZgHvbAfPlk+Sb9E3caQh6ZsLmiheqzaz0T8FcSOY9+wEmCVBT5gdad0mQs0+PEnl70gDTQHx9ozoBnAfNQEPUlY2g6XBVoTy/KPfX5htbF1eV8WY7wIxqKHHh3CV31TUj6PrZFNw+WthlwX68EPk7R7b2HnBKQ5W+LK1XlKMuocOW9l5zDC501xPEQwBrBXM30HGq0Lr1UvwbC8ln5CbEZq9Lln/QnvuEOnloWaSPXdLr/5uWE76DIgV/3xl2cojpCKYGcTCFV7iMilgI7+6qJPZs8HpBxll9ukyMKvacGISpt1BckvPxbui+vm8THgAA/JGzNTjyAKV1fXYSiu2SkGXV+1R1Cn+1BN5GCuinrBfc4cjc5tkzzPN78np/o6qhXgT6GbEvJG9yKJ1RpUhQK12vRXjjtAH3Rhy3IS2nEkhu7UfJHF5IpBohfVSEYr2i5EXhH2hMO0Ui0xc2hwpZr9qZgn2UnrwwkiCh+wLp4isUgHjm+SXJnqVIQUYoVBMk9EtJCoa4w37xOPcrCKM2E7yGvHupAjeTPwDoATjb0eQ91liWzh/thFsmX9xt8D7do0bR1Dg+3zD2q0xxZPCwwmdVgzYLmV1oU+Yg9smY=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10731.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7878ac5-e43c-4396-4b19-08db45631291
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 08:00:01.8176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vem9lkgu8SB0vrMIxi9OFANMZils4kn/dqoJKXofPsMcPvDh8pv9Voq72l7yv92UHu5dSlwtFa7/GcI0oe/7qKo8ADq3GpPnMuLiH2PREQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9861
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQoNCm9uIDIwMjMvMDQvMjUgMTU6NDcsIFppeWFuZyBaaGFuZyB3cm90ZToNCj4gT24gMjAyMy80
LzI1IDEzOjMzLCBZYW5nIFh1IHdyb3RlOg0KPj4gTmV3ZXIgZ2xpYmMgc3VjaCBhcyBnbGliYyAy
LjM2IGFsc28gZGVmaW5lcyAnc3RydWN0IG1vdW50X2F0dHInDQo+PiBpbiBhZGRpdGlvbiB0byA8
bGludXgvbW91bnQuaD4od2UgYWxzbyBpbmNsdWRlIHRoaXMga2VybmVsIGhlYWRlciB3aGVuIHVz
aW5nDQo+PiBnbG9iYWwuaCkuDQo+Pg0KPj4gVXN1YWxseSB3ZSBzaG91bGQgdXNlIGdsaWJjIGhl
YWRlciBpbnN0ZWFkIG9mIGtlcm5lbCBoZWFkZXIuDQo+PiBCdXQgbm93IG1vdW50LmggaXMgYSBz
cGVjaWFsIGNhc2UgYmVjYXVzZSBib3RoIG5ldyBnbGliYyBoZWFkZXIgYW5kDQo+PiBrZXJuZWwg
aGVhZGVyIGFsbCBkZWZpbmUgInN0cnVjdCBtb3VudF9hdHRyJy4gVGhleSBhbHNvIGRlZmluZSBN
UyoNCj4+IG1hY3JvLg0KPj4NCj4+IFNpbmNlIHdlIGhhdmUgc29tZSBzeXNjYWxsIHdyYXBwZXIg
aW4gdmZzL21pc3NpbmcuaCwgd2UgY2FuIHVzZQ0KPj4gPGxpbnV4Lm1vdW50Lmg+IGRpcmVjdGx5
IGluc3RlYWQgb2YgPHN5cy9tb3VudC5oPi4NCj4+DQo+PiBJbiBmYWN0LCBuZXdlciBnbGliYygy
LjM3LTEpWzFdIGhhcyBzbG92ZWQgY29uZmxpY3QgcHJvYmxlbSBiZXR3ZWVuDQo+PiA8c3lzL21v
dW50Lmg+IGFuZCA8bGludXgvbW91bnQuaD4uIEluIHRoZSBmdXR1cmUobWF5YmUgdGVuIHllYXJz
KSwNCj4+IHdlIGNhbiByZW1vdmUgdGhpcyBrZXJuZWwgaGVhZGVyIGFuZCB1c2UgZ2xpYmMgaGVh
ZGVyLg0KPj4NCj4+IFsxXWh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDth
PWNvbW1pdDtoPTc3NDA1OGQ3Mjk0MjI0OWY3MWQ3NGU3ZjJiNjM5Zjc3MTg0MTYwYTYNCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4g
LS0tDQo+PiAgIHNyYy9kZXRhY2hlZF9tb3VudHNfcHJvcGFnYXRpb24uYyB8IDUgKystLS0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvc3JjL2RldGFjaGVkX21vdW50c19wcm9wYWdhdGlvbi5jIGIvc3JjL2Rl
dGFjaGVkX21vdW50c19wcm9wYWdhdGlvbi5jDQo+PiBpbmRleCAxN2RiMmMwMi4uZGQxMWY3YmUg
MTAwNjQ0DQo+PiAtLS0gYS9zcmMvZGV0YWNoZWRfbW91bnRzX3Byb3BhZ2F0aW9uLmMNCj4+ICsr
KyBiL3NyYy9kZXRhY2hlZF9tb3VudHNfcHJvcGFnYXRpb24uYw0KPj4gQEAgLTIwLDcgKzIwLDYg
QEANCj4+ICAgI2luY2x1ZGUgPHN0ZGlvLmg+DQo+PiAgICNpbmNsdWRlIDxzdGRsaWIuaD4NCj4+
ICAgI2luY2x1ZGUgPHN0cmluZy5oPg0KPj4gLSNpbmNsdWRlIDxzeXMvbW91bnQuaD4NCj4+ICAg
I2luY2x1ZGUgPHN5cy9zdGF0Lmg+DQo+PiAgICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPg0KPj4g
ICAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQo+PiBAQCAtMTI3LDcgKzEyNiw3IEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+PiAgIAlpZiAocmV0IDwgMCkNCj4+ICAgCQlleGl0
X2xvZygiJW0gLSBGYWlsZWQgdG8gY3JlYXRlIG5ldyBtb3VudCBuYW1lc3BhY2UiKTsNCj4+ICAg
DQo+PiAtCXJldCA9IG1vdW50KE5VTEwsIGJhc2VfZGlyLCBOVUxMLCBNU19SRUMgfCBNU19TSEFS
RUQsIE5VTEwpOw0KPj4gKwlyZXQgPSBzeXNfbW91bnQoTlVMTCwgYmFzZV9kaXIsIE5VTEwsIE1T
X1JFQyB8IE1TX1NIQVJFRCwgTlVMTCk7DQo+PiAgIAlpZiAocmV0IDwgMCkNCj4+ICAgCQlleGl0
X2xvZygiJW0gLSBGYWlsZWQgdG8gbWFrZSBiYXNlX2RpciBzaGFyZWQgbW91bnRwb2ludCIpOw0K
Pj4gICANCj4+IEBAIC0xNzQsNyArMTczLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkNCj4+ICAgCQl9DQo+PiAgIAkJY2xvc2UoZmRfdHJlZSk7DQo+PiAgIA0KPj4gLQkJcmV0
ID0gdW1vdW50Mih0YXJnZXQsIE1OVF9ERVRBQ0gpOw0KPj4gKwkJcmV0ID0gc3lzX3Vtb3VudDIo
dGFyZ2V0LCBNTlRfREVUQUNIKTsNCj4+ICAgCQlpZiAocmV0IDwgMCkgew0KPj4gICAJCQlmcHJp
bnRmKHN0ZGVyciwgIiVtIC0gRmFpbGVkIHRvIHVubW91bnQgJXMiLCB0YXJnZXQpOw0KPj4gICAJ
CQlleGl0X2NvZGUgPSBFWElUX0ZBSUxVUkU7DQo+IA0KPiBIaSBZYW5nLA0KPiANCj4gVW5mb3J0
dW5hdGVseSwgd2UgZmluZCBhbm90aGVyIGVycm9yIGFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2g6
DQo+IA0KPiBCdWlsZGluZyB2ZnMNCj4gICAgICBbQ0NdICAgIHZmc3Rlc3QNCj4gSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIHV0aWxzLmg6MzIsDQo+ICAgICAgICAgICAgICAgICAgIGZyb20gdXRpbHMu
YzoyMToNCj4gbWlzc2luZy5oOjExNTo4OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mICdzdHJ1Y3Qg
bW91bnRfYXR0cicNCj4gICAgMTE1IHwgc3RydWN0IG1vdW50X2F0dHIgew0KPiAgICAgICAgfCAg
ICAgICAgXn5+fn5+fn5+fg0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gdXRpbHMuYzoxMzoNCj4g
L3Vzci9pbmNsdWRlL3N5cy9tb3VudC5oOjIxMDo4OiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQg
aGVyZQ0KPiAgICAyMTAgfCBzdHJ1Y3QgbW91bnRfYXR0cg0KPiAgICAgICAgfCAgICAgICAgXn5+
fn5+fn5+fg0KPiBnbWFrZVs0XTogKioqIFtNYWtlZmlsZTozMDogdmZzdGVzdF0gRXJyb3IgMQ0K
PiBnbWFrZVszXTogKioqIFsuLi9pbmNsdWRlL2J1aWxkcnVsZXM6MzE6IHZmc10gRXJyb3IgMg0K
PiBnbWFrZVsyXTogKioqIFtpbmNsdWRlL2J1aWxkcnVsZXM6MzE6IHNyY10gRXJyb3IgMg0KPiBt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjUxOiBkZWZhdWx0XSBFcnJvciAyDQo+IG1ha2U6ICoqKiBb
TWFrZWZpbGU6NDk6IGRlZmF1bHRdIEVycm9yIDINCj4gDQo+IA0KDQpJIGhhdmUgc2VhcmNoZWQg
dGhlIHBsYWNzZSBvZiBpbmNsdWRlIDxzeXMvbW91bnQuaD4NCg0KYXMgYmVsb3c6DQoNCm00L3Bh
Y2thZ2VfbGliY2Rldi5tNDo4ODojaW5jbHVkZSA8c3lzL21vdW50Lmg+DQpzcmMvYWlvLWRpby1y
ZWdyZXNzL2Fpb2Rpb19zcGFyc2UyLmM6MjM6I2luY2x1ZGUgPHN5cy9tb3VudC5oPg0Kc3JjL2V4
dDRfcmVzaXplLmM6MTU6I2luY2x1ZGUgPHN5cy9tb3VudC5oPg0Kc3JjL2dldGRldmljZXNpemUu
YzoxNzojaW5jbHVkZSA8c3lzL21vdW50Lmg+DQpzcmMvdmZzL3V0aWxzLmM6MTM6I2luY2x1ZGUg
PHN5cy9tb3VudC5oPg0KYXV0b200dGUuY2FjaGUvdHJhY2VzLjA6MTkyOTojaW5jbHVkZSA8c3lz
L21vdW50Lmg+DQphdXRvbTR0ZS5jYWNoZS9vdXRwdXQuMDoxMzg1ODojIGluY2x1ZGUgPHN5cy9t
b3VudC5oPg0KYXV0b200dGUuY2FjaGUvb3V0cHV0LjE6MTM4NTg6IyBpbmNsdWRlIDxzeXMvbW91
bnQuaA0KDQpvbmx5IHV0aWxzLmMgaW5jbHVkZSB4ZnN0ZXN0cyBvd25lciBoZWFkZXIsIG90aGVy
IGMgc291cmNlIGZpbGVzIHNob3VsZCANCm5vdCBiZSBhZmZlY3RlZC4gSSB3aWxsIHJlbW92ZSAg
PHN5cy9tb3VudC5oPiBpbiB1dGlscy5jIGFuZCB0aGVuIHNlbmQgYSB2Mi4NCg0KQmVzdCBSZWdh
cmRzDQpZYW5nIFh1DQo+IExvb2tzIGxpa2Ugd2UgaGF2ZSB0byBmaXggc3JjL3Zmcy91dGlscy5j
IHRvbyBiZWNhdXNlIGl0IGluY2x1ZGVzIGJvdGggPHN5cy9tb3VudC5oPg0KPiBhbmQgInV0aWxz
LmgiIGFuZCAidXRpbHMuaCIgaW5jbHVkZXMgIm1pc3NpbmcuaCIuDQo+IA0KPiBJIHNpbXBseSBy
ZW1vdmUgI2luY2x1ZGUgPHN5cy9tb3VudC5oPiBpbiBzcmMvdmZzL3V0aWxzLmMgYW5kIGl0IHdv
cmtzOg0KPiANCj4gZGlmZiAtLWdpdCBhL3NyYy92ZnMvdXRpbHMuYyBiL3NyYy92ZnMvdXRpbHMu
Yw0KPiBpbmRleCA2ZGI3YTExZC4uZjMwZTNiZDkgMTAwNjQ0DQo+IC0tLSBhL3NyYy92ZnMvdXRp
bHMuYw0KPiArKysgYi9zcmMvdmZzL3V0aWxzLmMNCj4gQEAgLTEwLDcgKzEwLDYgQEANCj4gICAj
aW5jbHVkZSA8c3RkbGliLmg+DQo+ICAgI2luY2x1ZGUgPHN5cy9ldmVudGZkLmg+DQo+ICAgI2lu
Y2x1ZGUgPHN5cy9mc3VpZC5oPg0KPiAtI2luY2x1ZGUgPHN5cy9tb3VudC5oPg0KPiAgICNpbmNs
dWRlIDxzeXMvcHJjdGwuaD4NCj4gICAjaW5jbHVkZSA8c3lzL3NvY2tldC5oPg0KPiAgICNpbmNs
dWRlIDxzeXMvc3RhdC5oPg==
