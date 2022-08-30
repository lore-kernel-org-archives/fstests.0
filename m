Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FFECAAD4
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Aug 2022 09:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiH3JD4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3JDz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2022 05:03:55 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEA4A222E
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661850233; x=1693386233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xPKnZFeITDmwlecUlPcZwpLPWhafXLmLAMCkqj76w2s=;
  b=VksP0k1Mx2gTNXZfx/la2vLp1bdCyM+RUOT4fFjB6iBolBQju3x0NHoW
   X6j9vu6hfKg/WxNAiUce7GoadLwXc+56hymdziQc+B9g+7mGNnKYU4Hiq
   Xif8bkRuVcM/k2Ll6QR67Kd83Yo7ppmCeXhoAnfnm9mrqrnn2t50x07hw
   MJ4+kx0HEEQnm2/4JshMT/d9gKwwnhbQnyPEzqLUaw5yjZvUxNE3TMMaN
   x7dCYt3CAZA1DL5iRui3ii7IevHuYwtgzftE3t/1BZHF+65+q33HruF/o
   brX24/piKOVkS+CCcWrHY+tKNMS4LnuDH00h3SYDgyXk64oaiAO1XuhCl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="63923032"
X-IronPort-AV: E=Sophos;i="5.93,274,1654527600"; 
   d="scan'208";a="63923032"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:03:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt7H/irHvuvW6kWK9e4BhuxhpHVVdUdGlOOo2K7mMdKLAeFLZoWFCznQ9yEHCUQoPIIOh3TBhEy3X9zwii+OmFyyHyP4MN9jsfX0jR5tZBiN74KKGwi2n3FJ1JWbejN9wPTK2hLRrPTeYrag3yF1x8o+tLV7Rljl5o8IBceNYZ9UyS0dSgPnOd6neN7hIdrb+OH2at0JZwWWeeLmmeSWTMH5Z4eaTKOYlPenrmWDq11G0fPxqZ0dRkfsKhiWX5SQsILNEJ3S7N92ScTRH43SSjvX3ILAVTZdKBlC4XXPXXuhqbyogx6ZQOaXLyrWDJtuAo/olijnOhzUCVw5CF4Bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPKnZFeITDmwlecUlPcZwpLPWhafXLmLAMCkqj76w2s=;
 b=gbL5/c8qvYLsupV/dChDhTq5isePmHBwJkbcb62A686CnQxRWCZhRUHHVAdL0XQPSbDjLVOfXlq/LuqVJs6bOUzTucNJy0vaegxgZTSa8q2oyN6hLy5iQXqFp5jJMk2g+owRe0sXoq6dcsLCnIBFLD+ZCwCXd2xCh31nmXMcW1Yf6wXgHZ2JuIPRA1Uw6mflrprz64wo6exvV0ayKUo1wleGVd0MQTCXy974cu2l049IMKUpgXuCKFpTvj/b/QdceSOi8Nuc7Fu+2G/sd7+6ZU28UPXKmyf5xm00AsEOj8DbZIH/pMxYv2NsJ7DgfBFXFs8Lfmt8jG5EwFq9q8jqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB9613.jpnprd01.prod.outlook.com (2603:1096:604:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 09:03:47 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 09:03:47 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] vfs: Add new setgid_create_acl test
Thread-Topic: [PATCH v2 2/2] vfs: Add new setgid_create_acl test
Thread-Index: AQHYoMoRaNiTIVb7qUm9Z3Y401DIEq3GEo2AgAFbtoA=
Date:   Tue, 30 Aug 2022 09:03:47 +0000
Message-ID: <1067728c-7f48-b8d4-f37e-b02bd56aeada@fujitsu.com>
References: <20220725142020.rtc2mgfhcw47v4t4@wittgenstein>
 <1658827881-2347-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1658827881-2347-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220829132011.krq2er4ghhwwq5kj@wittgenstein>
In-Reply-To: <20220829132011.krq2er4ghhwwq5kj@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 482fdbbc-8200-469f-0bfa-08da8a668c7a
x-ms-traffictypediagnostic: OSZPR01MB9613:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sL882xZaupzSgOaC3xBt0i8ZhrB/loSQdNO1h791BguyxwU22NN7GIxJWp5fRFWLPHGOYQK+3VyB64oRII9HvYhYB6trXCCAP9xTJ8SGip1hW8xvu1KBqaWd2yOuv8iA43HRzp7pJVy+s17Ioj1kZal7QEuZCxOF0573j1KPcOhABr8XVFluRH4gnRb+L/+GrlHbAsqL6m0y0eYycHI62FV4/naGVlKVYD9P+Z2g+KainJt/Kn32QHP+wbkVYQHFdRpDUdBVoWxWnPm/GGFm198DJZ/pu/DSxAOTgn366FSTQ26tkcaGa4CefPvwHkEkWbKGF8GmgLwHhgGx/o9Se0hvs7stahuRAsYg6CUPBo0FmFWDEV/k5WuL1mUKU1Nzd2L2589KNbICsNbBq4MpcBawqMWT+EzXikmjgMBzmeDo6QTVSl5I6x11TJ0Z3mICn60zVPbNeAmim3IT5JJ0V27NmismGKIZ4DBmo2lnPKIXohNM9OrABWZj00AfL02dy46a2ffMZCutrf5gnsg0W8Fai+NWEoTur8rMYyFXIMPh+s3nN4E+K7cOuNZPERDFmaS1JXOfcclf6KkWmaMMqk8EyIpWmrFUcOcBORQHVEfG68O6rxSuU5Q72q2qiCEODD3XWn5lkq8IKHFWo2HfR7BeR3w3b2AJfl8yNf9VKYRruUsvTbFrdAysGl444R+AK7BJL7PopU0MlM1fIy4VjPepmeBwhEFpOjzC9UOOs/f+zXelG1CkKGDVyK3cCyVaHI1G7Kx18pqL/m2dCzBB+kiuD3qr0pgf54B4jyDuh4l+Z/dLw9ymrApiBZbXZbMD5CxH9Mw5l9OJBI1JYoUoPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(1590799006)(66946007)(66476007)(66556008)(8676002)(76116006)(6486002)(4326008)(6506007)(83380400001)(2906002)(66446008)(8936002)(5660300002)(26005)(6512007)(478600001)(41300700001)(91956017)(31686004)(316002)(71200400001)(186003)(38070700005)(2616005)(31696002)(122000001)(86362001)(1580799003)(45080400002)(82960400001)(6916009)(64756008)(36756003)(85182001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm9tWjF6djBuTEU2R2xJeWllNzF3SFV2am1jRkx1UGY4emFFTS9lTDZ6VURQ?=
 =?utf-8?B?ZmR4dUFacGs3eXliVFE2bFQ3d1QwckREcllkYXg1TDhlc0hiUmFDREpkcWcx?=
 =?utf-8?B?M3RsaDBFMTNnNjA3cXg0aERBME1TanZFUmkxNThIaFdSb0ZseXJ2dy9kZ0xF?=
 =?utf-8?B?SzRSdkV3S3RoZEVpUnhZa2NsNXFJUkZWLy9NNWFNUXVzRUF6ZXdBS3k0Vkxn?=
 =?utf-8?B?QmdESlRaRlNZb0JBZW5XSjRETmdYVkRHY2dCTjhqd3FlMjhTRDhaZmpJUWNM?=
 =?utf-8?B?aVBZZU40d29ubDVsTFNFM3o0VmJUWTRYRHZDM1ZQQXAvWk5qSGpsSnNQRE1F?=
 =?utf-8?B?ZFJONFpxemdOS3lSRUdITUVCSVo3b0Z0Ukh1azdnWnlTMHdhTnJGWjE1aHVz?=
 =?utf-8?B?ZVRWSWp4RllSQVlzSWVUSzB1a0FQelNGNWVqU2JGaU5ESmpadHpCaHM3Z3Ft?=
 =?utf-8?B?NzBkajM5NHlIaWFLL1hSV3l0VjJ2TExIRnUwbzh1MGVoRmNqbFJsVTcwU1B5?=
 =?utf-8?B?eE93ODltUkozN1JFSFhuY3grVHlHRlJ3TmQzS1ZZdC84ekxBNHJWcHZqdFdx?=
 =?utf-8?B?YlVPa0h3Y2hvcEc1VDA3OGFpMVc1ZXhqd0xZUG5HaFVhQUxGOHpWU0JwNlRy?=
 =?utf-8?B?eGpTQXpzNkV3TWhQZ05lbHRubDhCbTN1UzZLYmVOK293aVFydEFXSW9HdjFK?=
 =?utf-8?B?bkV5NkF6cnpabFFPcW0yQ3RSSy8rQ09SUXZMbGhhb2d2UFBwODhScUVzYnp2?=
 =?utf-8?B?Sm1IR25yWWJEQU1KTHN4TkJCajlDbkp2T3Z2NmcwSk5hdEFmaTl5ZXJPSEpn?=
 =?utf-8?B?dSthUkVGTldJMHFDYmZKbmtuZEVoWS9qUnQ0emhQdjNQSDc1V0hDZkFrRGk5?=
 =?utf-8?B?WTRsZ2J0bWRJOTNCcHIraUtzL001VldqQ0dqbXJGY3Y5bndIRWYwZ21mYnVF?=
 =?utf-8?B?OUVMT0VrcytLTkx6OEVBQXhyZU1TZzNTS0FseDltMkhFT3dnODNMemJWblox?=
 =?utf-8?B?dEQ3MDkrd2lsenkzMVBwS1dudHZ3R0E0MFNSQUJuMEFycXhEMnBUSlQ3L2Qy?=
 =?utf-8?B?TmhwMTBubWw1Q1RReTJ6NWcvclgxc0FZYmluZ050RkdwRGhnUklvbWtUbjVl?=
 =?utf-8?B?Uyt1YjMrb1BIaEt2OVRvLzhMQTk3SndBNnpCVWY1cHJ4ZitNY2xTVGQzcEUx?=
 =?utf-8?B?ckZHa0ZBWVNRWjh4OGZRRzlLSndQWFhSYlBiU1FkZm5TTnUxZDlvbTVrYmRK?=
 =?utf-8?B?ZmlyUFhWbjBxRDVqdThSQmgyOEZUdGpsZE1DUExWZDVLUUJPakRWcjc3MWRC?=
 =?utf-8?B?eHNFZVRJMTZhYVdTSGh0c3BSZDkzdnkwVTM3aXRpM1ppQnNoQ0ozVzRuZDlz?=
 =?utf-8?B?amVmcGVxckExZ09OUVFlblROY2hyVm5OOXZsd0FSWjZEYjE5eE9pRUNiV21x?=
 =?utf-8?B?REI1eCtXV1RiZmJrTUVtVlp0Z05QMjVDSTlVSWtCL1ovSnpSSGRMb21LRUpw?=
 =?utf-8?B?dVhPYzVGb0owY1p1RXROVFlJQVFQdXhKY0JZaXNrSnB3SUNOUmVnVldYYzRN?=
 =?utf-8?B?R1BnOTJRZmJCWVU5R0plYXZlMVcyalVkNmZOc280dWVmckJLNWlVU2tFNW5Z?=
 =?utf-8?B?R2lKdlQvbEtGbHpsZzgzYkV2RWI1YUQ0NU1MczFKTUNDRzJPYzVEVzFpTFg4?=
 =?utf-8?B?a1dMU3B6dnVYNlF2MlhtYnp1aHhVbzRCTXlZNmQ4djJWWVdsVlAxVmtiUUtr?=
 =?utf-8?B?bjdvVG9haVQ0WW1mUlU4WXdQZXNpRnB6RkV0WVhDeTQyb2dDUnlGeGU1cjdS?=
 =?utf-8?B?QzFCZDdSYmlXVlk4NVc5MXRoNnJ4V0JEVjdxL0tjeXBHNXlQMi9JVUg1a1pX?=
 =?utf-8?B?b0ZSWHM1WGhzNk0vSWViR2RvTlpMeDhzYzlrWDVZejFsMVczYk9EZU9ZYmxN?=
 =?utf-8?B?NEk0Q1d2TWg2ZVkraWpyVlBNQzFuaFFpcEdsRHBEc1grTnBUVTVOU0Ria3NJ?=
 =?utf-8?B?QnBIMEdOM2hjZEZ5eE53M0luUkNlb25sUkRoMktuZkZ2WTNkVVRibDRWV3FZ?=
 =?utf-8?B?b2ErUWxocVc1V3I4dlRCak1KN0tjdWlzWVo5dm5hbjluYjREQVpHVFYzQ3N0?=
 =?utf-8?B?R0JIcHJIeWNPR0dudFFzZWQyZXFNb1lOdUQwNlA4ZEkzMXV4M0FlR1NPbElD?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAC0F7C46BC0E34499C621A43AD22E66@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482fdbbc-8200-469f-0bfa-08da8a668c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 09:03:47.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lUgE0OMZZIRYgdHhulgjM9ArFNR2NK1y1nsNX8IU+SIcWa7+8qP38+CUiiMMzoDgDcQNjvjwvhboiaHJvELWFWNw7q7b4Gj0C4I41HMk1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9613
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQpvbiAyMDIyLzA4LzI5IDIxOjIwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVl
LCBKdWwgMjYsIDIwMjIgYXQgMDU6MzE6MjFQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFRo
ZSBjdXJyZW50X3VtYXNrKCkgaXMgc3RyaXBwZWQgZnJvbSB0aGUgbW9kZSBkaXJlY3RseSBpbiB0
aGUgdmZzIGlmIHRoZQ0KPj4gZmlsZXN5c3RlbSBlaXRoZXIgZG9lc24ndCBzdXBwb3J0IGFjbHMg
b3IgdGhlIGZpbGVzeXN0ZW0gaGFzIGJlZW4NCj4+IG1vdW50ZWQgd2l0aG91dCBwb3NpYyBhY2wg
c3VwcG9ydC4NCj4+DQo+PiBJZiB0aGUgZmlsZXN5c3RlbSBkb2VzIHN1cHBvcnQgYWNscyB0aGVu
IGN1cnJlbnRfdW1hc2soKSBzdHJpcHBpbmcgaXMNCj4+IGRlZmVycmVkIHRvIHBvc2l4X2FjbF9j
cmVhdGUoKS4gU28gd2hlbiB0aGUgZmlsZXN5c3RlbSBjYWxscw0KPj4gcG9zaXhfYWNsX2NyZWF0
ZSgpIGFuZCB0aGVyZSBhcmUgbm8gYWNscyBzZXQgb3Igbm90IHN1cHBvcnRlZCB0aGVuDQo+PiBj
dXJyZW50X3VtYXNrKCkgd2lsbCBiZSBzdHJpcHBlZC4NCj4+DQo+PiBJZiB0aGUgcGFyZW50IGRp
cmVjdG9yeSBoYXMgYSBkZWZhdWx0IGFjbCB0aGVuIHBlcm1pc3Npb25zIGFyZSBiYXNlZCBvZmYN
Cj4+IG9mIHRoYXQgYW5kIGN1cnJlbnRfdW1hc2soKSBpcyBpZ25vcmVkLiBTcGVjaWZpY2FsbHks
IGlmIHRoZSBBQ0wgaGFzIGFuDQo+PiBBQ0xfTUFTSyBlbnRyeSwgdGhlIGdyb3VwIHBlcm1pc3Np
b25zIGNvcnJlc3BvbmQgdG8gdGhlIHBlcm1pc3Npb25zIG9mDQo+PiB0aGUgQUNMX01BU0sgZW50
cnkuIE90aGVyd2lzZSwgaWYgdGhlIEFDTCBoYXMgbm8gQUNMX01BU0sgZW50cnksIHRoZQ0KPj4g
Z3JvdXAgcGVybWlzc2lvbnMgY29ycmVzcG9uZCB0byB0aGUgcGVybWlzc2lvbnMgb2YgdGhlIEFD
TF9HUk9VUF9PQkoNCj4+IGVudHJ5Lg0KPj4NCj4+IEhlcmUgd2Ugb25seSB1c2Ugc2V0ZmFjbCB0
byBzZXQgZGVmYXVsdCBhY2wgb3IgYWRkIEFDTF9NQVNLIHRvIGNoZWNrDQo+PiB3aGV0aGVyIGlu
b2RlIHN0cmlwICBTX0lTR0lEIHdvcmtzIGNvcnJlY3RseS4NCj4+DQo+PiBMaWtlIHVtYXNrIHRl
c3QsIHRoaXMgcGF0Y2ggaXMgYWxzbyBkZXNpZ25lZCB0byB0ZXN0IGtlcm5lbCBwYXRjaHNldCBi
ZWhhdmlvdXINCj4+ICJtb3ZlIFNfSVNHSUQgc3RyaXBwaW5nIGludG8gdGhlIHZmcyogaGVscGVy
Ig0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5j
b20+DQo+PiAtLS0NCj4gDQo+IEhleSBZYW5nLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNo
ZXMhIEp1c3QgYSBtaW5vciBjb21tZW50IGJlbG93Lg0KPiANCj4+IDEuYWRkIGtlcm5lbCBjb21t
aXQgaWQNCj4+IDIubW92ZSB1bWFzayBpbnRvIHBhcmVudCBwcm9jZXNzIGludGVhZCBvZiBjaGls
ZCBwcm9jZXNzDQo+PiAzLnJlbW92ZSBkdXBsaWNhdGVkIGNvbW1lbnQgZm9yIEFDTF9HUk9VUF9P
QkogYW5kIEFDTF9NQVNLIGJlY2F1c2UNCj4+IHdlIGhhdmUgbWVudGlvbmVkIGl0IGJlZm9yZSB0
aGUgZnVuY3Rpb24NCj4+ICAgc3JjL3Zmcy9pZG1hcHBlZC1tb3VudHMuYyB8IDcwNCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBzcmMvdmZzL2lkbWFwcGVkLW1v
dW50cy5oIHwgICAxICsNCj4+ICAgc3JjL3Zmcy92ZnN0ZXN0LmMgICAgICAgICB8IDM0NSArKysr
KysrKysrKysrKysrKystDQo+PiAgIHRlc3RzL2dlbmVyaWMvOTk5ICAgICAgICAgfCAgMzMgKysN
Cj4+ICAgdGVzdHMvZ2VuZXJpYy85OTkub3V0ICAgICB8ICAgMiArDQo+PiAgIDUgZmlsZXMgY2hh
bmdlZCwgMTA4NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDc1NSB0ZXN0cy9nZW5lcmljLzk5OQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMv
Z2VuZXJpYy85OTkub3V0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NyYy92ZnMvaWRtYXBwZWQtbW91
bnRzLmMgYi9zcmMvdmZzL2lkbWFwcGVkLW1vdW50cy5jDQo+PiBpbmRleCBmNjNhYzQ0Yi4uZjkz
NGNmNGEgMTAwNjQ0DQo+PiAtLS0gYS9zcmMvdmZzL2lkbWFwcGVkLW1vdW50cy5jDQo+PiArKysg
Yi9zcmMvdmZzL2lkbWFwcGVkLW1vdW50cy5jDQo+PiBAQCAtODA4Myw2ICs4MDgzLDcwMCBAQCBv
dXQ6DQo+PiAgIAlyZXR1cm4gZnJldDsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgaW50IHNl
dGdpZF9jcmVhdGVfYWNsX2lkbWFwcGVkKGNvbnN0IHN0cnVjdCB2ZnN0ZXN0X2luZm8gKmluZm8p
DQo+PiArew0KPj4gKwlpbnQgZnJldCA9IC0xOw0KPj4gKwlpbnQgZmlsZTFfZmQgPSAtRUJBREYs
IG9wZW5fdHJlZV9mZCA9IC1FQkFERjsNCj4+ICsJc3RydWN0IG1vdW50X2F0dHIgYXR0ciA9IHsN
Cj4+ICsJCS5hdHRyX3NldCA9IE1PVU5UX0FUVFJfSURNQVAsDQo+PiArCX07DQo+PiArCXBpZF90
IHBpZDsNCj4+ICsJaW50IHRtcGZpbGVfZmQgPSAtRUJBREY7DQo+PiArCWJvb2wgc3VwcG9ydGVk
ID0gZmFsc2U7DQo+PiArCWNoYXIgcGF0aFtQQVRIX01BWF07DQo+PiArCW1vZGVfdCBtb2RlOw0K
Pj4gKw0KPj4gKwlpZiAoIWNhcHNfc3VwcG9ydGVkKCkpDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsN
Cj4+ICsJaWYgKGZjaG1vZChpbmZvLT50X2RpcjFfZmQsIFNfSVJVU1IgfA0KPj4gKwkJCSAgICAg
IFNfSVdVU1IgfA0KPj4gKwkJCSAgICAgIFNfSVJHUlAgfA0KPj4gKwkJCSAgICAgIFNfSVdHUlAg
fA0KPj4gKwkJCSAgICAgIFNfSVJPVEggfA0KPj4gKwkJCSAgICAgIFNfSVdPVEggfA0KPj4gKwkJ
CSAgICAgIFNfSVhVU1IgfA0KPj4gKwkJCSAgICAgIFNfSVhHUlAgfA0KPj4gKwkJCSAgICAgIFNf
SVhPVEggfA0KPj4gKwkJCSAgICAgIFNfSVNHSUQpLCAwKSB7DQo+PiArCQlsb2dfc3RkZXJyKCJm
YWlsdXJlOiBmY2htb2QiKTsNCj4+ICsJCWdvdG8gb3V0Ow0KPj4gKwl9DQo+PiArDQo+PiArCS8q
IFZlcmlmeSB0aGF0IHRoZSBzaWQgYml0cyBnb3QgcmFpc2VkLiAqLw0KPj4gKwlpZiAoIWlzX3Nl
dGdpZChpbmZvLT50X2RpcjFfZmQsICIiLCBBVF9FTVBUWV9QQVRIKSkgew0KPj4gKwkJbG9nX3N0
ZGVycigiZmFpbHVyZTogaXNfc2V0Z2lkIik7DQo+PiArCQlnb3RvIG91dDsNCj4+ICsJfQ0KPj4g
Kw0KPj4gKwkvKiBDaGFuZ2luZyBtb3VudCBwcm9wZXJ0aWVzIG9uIGEgZGV0YWNoZWQgbW91bnQu
ICovDQo+PiArCWF0dHIudXNlcm5zX2ZkCT0gZ2V0X3VzZXJuc19mZCgwLCAxMDAwMCwgMTAwMDAp
Ow0KPj4gKwlpZiAoYXR0ci51c2VybnNfZmQgPCAwKSB7DQo+PiArCQlsb2dfc3RkZXJyKCJmYWls
dXJlOiBnZXRfdXNlcm5zX2ZkIik7DQo+PiArCQlnb3RvIG91dDsNCj4+ICsJfQ0KPj4gKw0KPj4g
KwlvcGVuX3RyZWVfZmQgPSBzeXNfb3Blbl90cmVlKGluZm8tPnRfZGlyMV9mZCwgIiIsDQo+PiAr
CQkJCSAgICAgQVRfRU1QVFlfUEFUSCB8DQo+PiArCQkJCSAgICAgQVRfTk9fQVVUT01PVU5UIHwN
Cj4+ICsJCQkJICAgICBBVF9TWU1MSU5LX05PRk9MTE9XIHwNCj4+ICsJCQkJICAgICBPUEVOX1RS
RUVfQ0xPRVhFQyB8DQo+PiArCQkJCSAgICAgT1BFTl9UUkVFX0NMT05FKTsNCj4+ICsJaWYgKG9w
ZW5fdHJlZV9mZCA8IDApIHsNCj4+ICsJCWxvZ19zdGRlcnIoImZhaWx1cmU6IHN5c19vcGVuX3Ry
ZWUiKTsNCj4+ICsJCWdvdG8gb3V0Ow0KPj4gKwl9DQo+PiArDQo+PiArCWlmIChzeXNfbW91bnRf
c2V0YXR0cihvcGVuX3RyZWVfZmQsICIiLCBBVF9FTVBUWV9QQVRILCAmYXR0ciwgc2l6ZW9mKGF0
dHIpKSkgew0KPj4gKwkJbG9nX3N0ZGVycigiZmFpbHVyZTogc3lzX21vdW50X3NldGF0dHIiKTsN
Cj4+ICsJCWdvdG8gb3V0Ow0KPj4gKwl9DQo+PiArDQo+PiArCXN1cHBvcnRlZCA9IG9wZW5hdF90
bXBmaWxlX3N1cHBvcnRlZChvcGVuX3RyZWVfZmQpOw0KPj4gKw0KPj4gKwkvKiBPbmx5IHVtYXNr
IHdpdGggU19JWEdSUCBiZWNhdXNlIGlub2RlIHN0cmlwIFNfSVNHSUQgd2lsbCBjaGVjayBtb2Rl
DQo+PiArCSAqIHdoZXRoZXIgaGFzIGdyb3VwIGV4ZWN1dGUgb3Igc2VhcmNoIHBlcm1pc3Npb24u
DQo+PiArCSAqLw0KPj4gKwl1bWFzayhTX0lYR1JQKTsNCj4+ICsJbW9kZSA9IHVtYXNrKFNfSVhH
UlApOw0KPj4gKwlpZiAoIShtb2RlICYgU19JWEdSUCkpDQo+PiArCQlkaWUoImZhaWx1cmU6IHVt
YXNrIik7DQo+IA0KPiBBbGwgdGhlIGNhbGxzIHRvIHVtYXNrKCkgaW4gdGhpcyBwYXRjaCBzaG91
bGQgYmUgYWZ0ZXIgdGhlIGZvcmsoKSBpbiB0aGUNCj4gY2hpbGQgcHJvY2Vzcy4gVGhlIGRpZSgp
IGhlbHBlciBpcyBvbmx5IHN1cHBvc2VkIHRvIGJlIHVzZWQgaW4gY2hpbGQNCj4gcHJvY2Vzc2Vz
IGFueXdheS4NCg0KT2gsIHllcywgSSBkaWQndCBub3RpY2UgaXQgYmVmb3JlLiBXaWxsIG1vdmUg
aXQgaW50byBjaGlsZCBwcm9jZXNzIG9uIHYzLg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCg0K
PiBUaGUgcmVzdCBsb29rcyBmaW5lIHRvIG1lLiBTbyB3aXRoIHRoZSB1bWFzaygpIG1vdmVkDQo+
IHlvdSBjYW4gYWRkLA0KPiBUZXN0ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNyb3NvZnQp
IDxicmF1bmVyQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAo
TWljcm9zb2Z0KSA8YnJhdW5lckBrZXJuZWwub3JnPg==
