Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269CC4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Dec 2022 09:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiLQJex (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 17 Dec 2022 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLQJev (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 17 Dec 2022 04:34:51 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 01:34:49 PST
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEFC2935F
        for <fstests@vger.kernel.org>; Sat, 17 Dec 2022 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1671269689; x=1702805689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JnWyHkuyFztu2X+qLretNRVhQlO0rJbLZJ4sOgCgtmI=;
  b=JGWITESD0PRdVAMVXCVnkHLRMQrsdyu7QNX1MaZIiYF1RYGAq8KMF1uJ
   jMVjpLCFXIX/qQWIc7WSm57ZiGrnWyWkUKM5dGlxPtGLm/gdYUSrNsjVS
   nP8pd5mAxZP/VRJgNNh5UlUuXhtBnIvneAORHmBrPRNehc1F5fWBtavkd
   S96ueJ3y+4QUQFKr89bvSQy175XXf5KZ7BwNFV7rrdCUAO/BHXvq+CxIg
   WqGRDqeCLcg1TJBwf74Ys+Alx/c3xQAK7PhXetLgcCEk2AyJ4J2TzDcic
   d2kJBk4ZgQLkZhr45NIE7VF739p21eq/YqsSlVy0iFYR5t7QjIoxEFfiV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="72811075"
X-IronPort-AV: E=Sophos;i="5.96,252,1665414000"; 
   d="scan'208";a="72811075"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 18:33:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixHzGVkdKAryuHnyu3kUWrnO1NKSrl1luJnKm/ETDM7odZdsT9X8wTQ5rH4LuenB0xsKMTk9hv0Ug5cZBu3LW41HxAiXRjXIVvLlBXVCx9foZK1aY1dHX4N98s6ldpruIlOKhsgR6IroibecZRaiVdX1LhT5GeEaaCmzzsqqmNia9NGDcBeeIz+EFoAq4loCGpLbgvL2Lc+TNraspPS6kPrtYfN4e6feRRY4sUizdVx9hQ8kv4CLX2S2WGawINXZT7FbNyDYhb/Wpf0+u4SMOs/OB4bYZoYoZ85+uH4ajq0AQRcFUL27M4TH7Cn5ImCjKuHrrXatAMg8xJC7hwasBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnWyHkuyFztu2X+qLretNRVhQlO0rJbLZJ4sOgCgtmI=;
 b=fTINkwjTePDfh3tTxJH18hSOj/d8/NKTz9JE7t+oXi1wRH4vKYX/UhwwbqCkD+zaiRVt0H4O6wevYc/9m6cGH2wWl7+ZTd4dIxXVwS2/wvFrgCCRcuq6Uxo+fobNLp9Cg4RaUzwS/Rmh+hFPzgDKRvRxUP9nORDNqK8irc6c4cJNSn8jMNlDVBiJL4kbS0M6qEpdrdY7oRHLZXVbcmIrEvOZ9vSL2qJiewOM8LRmzdxEWtfaCVosV0Yos0xls+OhxBmRCVOtGuV62YFBFgQcQ0RHF8ThzkhKMfJkQFxKYCsxS/j7LsxEvajRuQYdEeIUr1DUEm5KdpJojjyb+bc/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB10651.jpnprd01.prod.outlook.com (2603:1096:400:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 09:33:41 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::7ad:d97f:5f18:3e64]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::7ad:d97f:5f18:3e64%3]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 09:33:41 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH] xfs/243: add _require_scratch_delalloc()
Thread-Topic: [PATCH] xfs/243: add _require_scratch_delalloc()
Thread-Index: AQHY/yVsirCxxZhFC0uMyLy+UgbZAq5MspEAgCVEIyA=
Date:   Sat, 17 Dec 2022 09:33:41 +0000
Message-ID: <OS3PR01MB9499ADBBFC0524B5FB43982983E79@OS3PR01MB9499.jpnprd01.prod.outlook.com>
References: <1669198883-16-1-git-send-email-yangx.jy@fujitsu.com>
 <20221123162708.5odsnr7woikadldn@zlang-mailbox>
In-Reply-To: <20221123162708.5odsnr7woikadldn@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?gb2312?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?gb2312?B?NTBfQWN0aW9uSWQ9OWY1M2ExZWEtY2IwMi00ZTVlLWIxMDQtZDg1MjI3YzEx?=
 =?gb2312?B?ZWUzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?gb2312?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?gb2312?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?gb2312?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?gb2312?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?gb2312?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRKlWPz87TVNJ?=
 =?gb2312?B?UF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBf?=
 =?gb2312?B?U2V0RGF0ZT0yMDIyLTEyLTE3VDA5OjMyOjM2WjtNU0lQX0xhYmVsX2E3Mjk1?=
 =?gb2312?B?Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEy?=
 =?gb2312?Q?1d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TYCPR01MB10651:EE_
x-ms-office365-filtering-correlation-id: fd819c09-fb03-4a4e-c31b-08dae011c8c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2YhrNhPDSx+Sv+fSyqNnmQCCcUv/U2hxk2jo30xXxCqggjrGcXxSC+d/I5dHRxSCDpi+knGwhzx5hSpoLWYroNk/0AlhEgYtAvExdASZYmLUDhR/+o85x0HfNZtRXfNS87rbZ5UVqJwFruoSEq5aUt1PTaxK6WbEuraj36JFziUJ58q5OblDizOeeKQEd3951v2ysS8pMb66zFCiRJ/ejs3XZmrNv9H6n9Q/KN11se80ZFplPczTFTv728VjeFIh08nk0+lgzbtgL45w8lg11t0fs4ANGJ+ndvj89t0FjXvkMryjslqi+zqUfTgv9UTDKUW8B4aJdRJ6pDXWrOJ01DG2/kR8rbpL2dOPIIQ72IO6o5exEzLeIx8EvFJHX4FgZa898QPkwXaBiEvspbMHgUp4W3vpKKo8+GNDrTEAj22cTQwasTL3MtapNwn18BOodIotxpUrXcRShiGU3aBJwmYJf0QUYHsAYGefAAPJEKZQ91ygJtT7yNuk1qFPIW0hdoFvfwUuOYjklnBum7r8vg1gcx9BGYJLgdVzY/27qTm6Kg/osm+5jPBT9+VrEphU3f6pFz1LePx6iYo5W96pGZWX/EpdZ/ESgNvQ57RenxqCLvJxB1leClGkr880L+dPExKQ54jl7BFZwQ1nQcBS3SuanLqouTvtGiz+8zU9mB87efFJkQKGySJPjh6WCSJ1PY8vdNpaGZrXhY/wzrpT6u/z/D3iAsaAeYV3VSqYJIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(1590799012)(451199015)(316002)(33656002)(55016003)(6916009)(83380400001)(4744005)(41300700001)(85182001)(8936002)(5660300002)(52536014)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(4326008)(76116006)(2906002)(38070700005)(6506007)(86362001)(7696005)(53546011)(71200400001)(478600001)(82960400001)(1580799009)(122000001)(38100700002)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WWl0d3NZa2k3WTJGWmozcDJtU2h2aXhUTjlGck95dmwvekI3WXRlODVkUFlr?=
 =?gb2312?B?bVV1eDE2dnRlc3hmNjJrYUcxU0FhZ1FKUkM3WXMvMW1HdmN3UGxTbE5FVURs?=
 =?gb2312?B?MUtHbmRrMDZETTdESGNyamw5R2lkRkVmcFJEN3IxV1FFendXaVdXSitnWTVa?=
 =?gb2312?B?Tmp2K2ZaRjkrZmhIa1dvKzRIdXVhS3gyK1NqcXljRUtlTm1RY1lWaHN3MVpU?=
 =?gb2312?B?ai9WTExIK2ZDRHJwQldwREZwTXNJcFZUV2wrdC8yQjlnbHozSWIwbzgzS2tX?=
 =?gb2312?B?alFOWU1NRzR4UW02ek9kK0VCL0R3MS9uSHh3SktZYmpWdFRiUnZjcEVmcnYw?=
 =?gb2312?B?OWdQVFFxbStWY3o1d2tob0xLZXZaVktub21BUUpMajBhSUlmdUJrZURXdmFr?=
 =?gb2312?B?NExlaFEzTVZhYkp3Tnlrc2RUZUczUHVzb2dZZE0yd1J6Y2ZYNENKczA4cUJs?=
 =?gb2312?B?cGlKWXQ0YTFpbUxDNHVucmxHRmFLUnhSNThXZW1KY2N6Vk5nUEU2bEc1NWM3?=
 =?gb2312?B?ck1qdHZ6WGFTL1RNbEZKaXRvSitUT3dXRHZTc0tCS0JIUFBieFJZa1JuaXVk?=
 =?gb2312?B?cmdHbkxoMldYckJ6RDNDcEtMOFphN1NZWDMvRlVDZ3QvbDA3Q05qVGhncEJ2?=
 =?gb2312?B?ekw1VFBORDdQZy9maWdETkp5QkhTYWZ5OC9yek9iUjk1RWtOaWpkWEJJVHZL?=
 =?gb2312?B?bmdxODk0K0plQTJtQUJaeGNuci9vcmM1cm4veDBvRkZEaXdUQ0tyS3JlNVVM?=
 =?gb2312?B?a2s3ZFN2WnhXKzkyTmszVkNtY1d2bmEra0REWkt2alZlVDFKdC9lYldVZU8z?=
 =?gb2312?B?WmpMWWFPTkdzRTZlbGdMTFRNQnFjZWI2ajF6cEJ4Skk4U2V2UWpZS09EekFz?=
 =?gb2312?B?Q2JxcU40WlFobVRrSGx4cW95ZTdIOUg4SHRRclcvQzZHVjdUM0k1amIycXBZ?=
 =?gb2312?B?SnZDRFRkTlp0MUc3RDcwYmlBSTB6bjRvUUd5MjZjc0x5UWJ6R0wzdmJ1cXRq?=
 =?gb2312?B?QmNtUnloeFlmVkFZcVdQcTBmV3FvQStidFg4NW45TDZaeTV6YUdsbnh2a2Zk?=
 =?gb2312?B?QkdnbVc1U29mNGVlbDVTeksrcTU0WnVEM0kwZEUvTEZpemJxNVhQVWJwUlJk?=
 =?gb2312?B?b1BscVRtdVIydExRajNpUmNPdDFtdFRmZUFZUUcwVVArdmdiZ1dLN2JVTTF4?=
 =?gb2312?B?SE5oMjVhSWExZHV2Y0NETWZha3dvTmQxNzZIUndQNi9ST0hacTEzSHVTOVNZ?=
 =?gb2312?B?bXJIcTBiWlg2aVpjWmJualRrRVFrTHQvK0F1TFJFaHJvdXlpanRscFNubzU0?=
 =?gb2312?B?c0dVQnBQRDVsOWppT29tWTBEK25TNG5NcytLWlZnUnJBekkxYjErR3NEbVBL?=
 =?gb2312?B?aHJQOG80b3dSTWREamQxUW56VlJXQUtwTHQrQ3EyQ1VNL09mTmFmeit0SU9y?=
 =?gb2312?B?YzRHVDlBeGlUSnZUREZPd0F3RkpCVEU3K1VkcUpCZng1K1Q3TEN5WXBjWG5M?=
 =?gb2312?B?YkJYeVBwVm9GNUR3VU9WWEtzWHpGVWppMUIycGVDYVMwaFhGVng2TkdOZm52?=
 =?gb2312?B?YUphWERHdjYzb0tuSGpkOU1KZWxkSHN4Z1R4VjRHSWl0bXhteWM5WlpBbTN2?=
 =?gb2312?B?MDhLQit1elRtTlcwbW1rcENSek5UVzd0TWcyeTUyUEZRQ000UTBwZUM4Z0hF?=
 =?gb2312?B?L3RrVnlMZEVhaWhoaFNQbEFjeXErWVc5ODVLVUV5cDdGYzd6Z0ZqbkNueVZh?=
 =?gb2312?B?UjAxd2FlQnJHMjZWdW1DTkJJTTNFZldiTnhuQ3pkUXpJMEdzQUJaWGsyOFQv?=
 =?gb2312?B?TmZBblhhMUh2L0RDamhSUkRTcUk1cGR3bjRjZVdmOWRLMFpYRTFDSkp1VDNu?=
 =?gb2312?B?VlJ0YkgxR2dyakt3T0xtSExwb2twK2ViN0lFNGkrNUhSL2hLV2QwaENZM29h?=
 =?gb2312?B?bE1YNzR1Tnlkd2hhMXRYdHN0WS9nQTZud3VabGdMRFBHNDNSR0FOeExrUXB4?=
 =?gb2312?B?ODlmeUM1TXZmVUtTY3BtMU0yQW1OMzRYeFdCMC9jZmllZlpNYUh0VFhVZmk3?=
 =?gb2312?B?MVNBMjFScUJOcXU2NFRQdGxzZDgyVXk3VEhVQ0NGOUFHdXVIZGpjTzh3QWky?=
 =?gb2312?Q?PvM33GvclCWlOwaaTsruf7d1F?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd819c09-fb03-4a4e-c31b-08dae011c8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 09:33:41.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBMo2sbw5k7iSi3GW/LHGbKWnloIsb6m/eV8LOA0JlRhk3m7qWbDUL2uYXS4dRjtZYIajK5DDbUH217hPeV2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10651
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgem9ycm8sDQoNCklzIGl0IE9LIHRvIG1lcmdlIHRoZSBwYXRjaD8NCg0KQmVzdCBSZWdhcmRz
LA0KWGlhbyBZYW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBab3JybyBM
YW5nIDx6bGFuZ0ByZWRoYXQuY29tPiANClNlbnQ6IDIwMjLE6jEx1MIyNMjVIDA6MjcNClRvOiBZ
YW5nLCBYaWFvL9HuIM/+IDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCkNjOiBmc3Rlc3RzQHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0geGZzLzI0MzogYWRkIF9yZXF1aXJlX3Nj
cmF0Y2hfZGVsYWxsb2MoKQ0KDQpPbiBXZWQsIE5vdiAyMywgMjAyMiBhdCAxMDoyMToyM0FNICsw
MDAwLCBYaWFvIFlhbmcgd3JvdGU6DQo+IHhmcy8yNDMgcmVxdWlyZXMgdGhlIGRlbGFsbG9jIGZl
YXR1cmUgb2YgWEZTIHNvIHJldHVybiBbbm90IHJ1bl0gd2hlbiANCj4gWEZTIHdpdGggZW5hYmxl
ZCBEQVggZG9lc24ndCBzdXBwb3J0IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5n
IDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QgdG8gbWUsIHRoaXMg
Y2FzZSBzdGFydHMgdG8gZmFpbCBmcm9tIHhmcyBkYXggc3VwcG9ydHMgcmVmbGluay4NCg0KUmV2
aWV3ZWQtYnk6IFpvcnJvIExhbmcgPHpsYW5nQHJlZGhhdC5jb20+DQoNCj4gIHRlc3RzL3hmcy8y
NDMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3hmcy8yNDMgYi90ZXN0cy94ZnMvMjQzIGluZGV4IDhmMGM1OTM5Li43Mzll
ZmU0YSANCj4gMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3hmcy8yNDMNCj4gKysrIGIvdGVzdHMveGZz
LzI0Mw0KPiBAQCAtMjcsNiArMjcsNyBAQCBfYmVnaW5fZnN0ZXN0IGF1dG8gcXVpY2sgY2xvbmUg
cHVuY2ggIF9zdXBwb3J0ZWRfZnMgDQo+IHhmcyAgX3JlcXVpcmVfeGZzX2RlYnVnICBfcmVxdWly
ZV9zY3JhdGNoX3JlZmxpbmsNCj4gK19yZXF1aXJlX3NjcmF0Y2hfZGVsYWxsb2MNCj4gIF9yZXF1
aXJlX3hmc19pb19jb21tYW5kICJmYWxsb2MiDQo+ICBfcmVxdWlyZV94ZnNfaW9fY29tbWFuZCAi
Y293ZXh0c2l6ZSINCj4gIF9yZXF1aXJlX3hmc19pb19jb21tYW5kICJmcHVuY2giDQo+IC0tDQo+
IDIuMzQuMQ0KPiANCg0K
