Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DE0C433B4
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Apr 2021 01:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B776A613AA
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Apr 2021 01:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhD0BmT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:42:19 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:32696 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhD0BmS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 21:42:18 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Apr 2021 21:42:18 EDT
IronPort-SDR: Q68oas/9Py9c+BvdCkSS+PWW/Eerp9gAkHB5OS6w5jAoILJ1JInvW/27576BJSIGE4E0zf2lmy
 La4p7AuqXThrbKyO4IOj7yk3loawWgiPZC+XFZx1TLDOUvUCj5kdS4Dczy7lsQLr7lr20JaeGV
 UrENe3TS5jkNoVsUsgL7UpMZdhQtxBiwhdviq0H6nxlpONq44XrkcEpgaHG3Wq9cGlNfuv4fSp
 sXCoTeOVHWfxMFyIPt/OcHFL/L8lxp2zVNwAfHt1cyeC8CaI9QBLSZQ/NcXtQp7LbRo5YmGMG6
 9jQ=
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="30431555"
X-IronPort-AV: E=Sophos;i="5.82,252,1613401200"; 
   d="scan'208";a="30431555"
Received: from mail-sg2apc01lp2058.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.125.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 10:34:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXWzxjnUH8YfqRQgELOnB6ddhrVkfyx+dxLlQtHgvP9JFatTjMRTtwZ3qHga6VkKXFVem9mTjm2kK+bRaCZBHXdqpmp1R8jZSU1+ZIi2lYskRXHT6nv1QqBW5JDFPXDCWsw/GynO5iMfuskbDqe0f7IO/VbPcj8X2eFV0AyJ5C0PXiVZpv+YsZWDR1Mhpc/fCOZ3id+mDqHx8QEwFyaT/GUP9hixWtgEiSFLT9sXwej8n04q04HcbqxaIfRaynHlKyj5gCyFyQ8Iez1he5/6EBb1YUjvmBNzsHfVkUa/XlFAkOycUFidEkasAh58BHyBdF9p57ckNRZDberJhkKglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh4UbqSGHfH6uKdHhWNZEGBeL92Hb+Nnj60E/sfF3iU=;
 b=T2eLN9vaBb/axanou1uXZr5CIOM8Xn3asHKXvNcKwRZoY0MgQ+17ZRiaggeEELcvuGIFrKrW+66C4n9vj8I3eTV12rHH2k1LApPB06DrDpJZfzAMzCcqSJn3J6BhXJeiCtA37gPC4IxtOL42ITN4r7VqsT49vF+NvCt1yY3fxoCqmp93CZFkuJTgT4VZ9DnKr38hRxD2yOrIh2Klb9LGKSObHDPVOl+v/DaoqJezylRdc9aV2XwFVIj2JxoG09x517prVhEzjLPe0uB0m+3V60+GWCZW5Y0Al2Y54eNuVkkrvlfpruPtjBM8CEgHebtcJMqY0fiVidqsXURbniN/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh4UbqSGHfH6uKdHhWNZEGBeL92Hb+Nnj60E/sfF3iU=;
 b=CLL+gDWwFUdtEA1Qss79S1mY2M1GzwLRrAKz/6qw4sumfV2MMevTbDLWJpyePVuSSdt7loTevMWC0nAvS35DIaEWxPMUzfkVKpZwtgPkqlRLELjREXaZrJ4JFEOzUnd1DtuzdETXhAhRxu2WijrzfRvrw3TA1X/Gh4p9JNnQ4PA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4569.jpnprd01.prod.outlook.com (2603:1096:404:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 01:34:24 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9095:8cd8:6e30:3052]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9095:8cd8:6e30:3052%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 01:34:24 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] idmapped-mounts.c: Use renameat instead of
 renameat2
Thread-Topic: [PATCH v2 2/3] idmapped-mounts.c: Use renameat instead of
 renameat2
Thread-Index: AQHXOlw7FzK4M1CS20GxcyX6VjmvbKrG3T4AgADJ4YA=
Date:   Tue, 27 Apr 2021 01:34:24 +0000
Message-ID: <60877855.6000107@fujitsu.com>
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1619418187-19951-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20210426143228.6nnoedfawpiibchr@wittgenstein>
In-Reply-To: <20210426143228.6nnoedfawpiibchr@wittgenstein>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7b75bb1-d611-45a7-d908-08d9091c96db
x-ms-traffictypediagnostic: TY2PR01MB4569:
x-microsoft-antispam-prvs: <TY2PR01MB45692EE4F25F324EEE7E1897FD419@TY2PR01MB4569.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Go/EdCJinYe2koLAIkrXoqzXFzBWZUpgZmE6DBVLn/zynsVKwsyjXjmpV0axp4Sd6OgGz5XW+p4Yr2vcrP29ircOMNSMfG18gQrOwawmZJx8a9AbvgxRIaEk4RIG8fAF0JrjV143x67NmwEYDBt/OocCJ9fMQv1QxSnHDL/RAc+vHYxGqovzdw1QBlUy4UoyS0FBIBfrSb9ashahmH1riwk1rRigEg7azomvGc8WJyELaLPtBXvoYpbKZvpLUIC2gqucZiEXRi9rshfvAK/uF3YtpinudNv+mJtoQMqhG7utBbei2/9jgkbtIX54IFlVo6yeD0bSQdze+AY1dMZzR5dnxPcTAnGOWdFVQT9o8Y1Q1f8zkMqTArWh5WuSUn+TGcewlMTeRtAhPDJW20JO8XKmFwrv1v6F1OUPJPmYELciA9DM+3j7tQhrxMkbru4l+EfZJbiq99Y/vj1SJjUlmva4loBD75/3OrosiGkwjc5lKzpgdcWBBu9h/o/lh+wTfX0FisyLav13SD8l1g0JutZr0vbpKqPRUSYk8RjUB2k4J2LQjV8ziGUYrZYe2HdmiSPX4m65xMz4xvZHKA0BtJwO01+So3rsEhHMrxiPpFnvGxeU+SuSem3qioALji3uaQ2vxjVTwmVcOt4n8/5jwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(8936002)(6506007)(26005)(87266011)(186003)(8676002)(66446008)(6486002)(85182001)(76116006)(5660300002)(2906002)(122000001)(86362001)(2616005)(91956017)(478600001)(38100700002)(6916009)(4744005)(4326008)(316002)(66946007)(6512007)(71200400001)(64756008)(66476007)(66556008)(36756003)(62816006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Ly9MTUprNytxUXdIT0YyRUNsRGtxMlFUMFE3NlV3aGJDOFBrNERsK1FBSW1S?=
 =?utf-8?B?S0hWMm04ZU4yVkNaRjBTalVxYXJYWDU2TUZnOU1tdnovaU9FWHJVelpNcS9q?=
 =?utf-8?B?VUFYR2JlZS9aU0toOFBCajJSR2dYaGJ1TUdVRWdYS2JBSjhnVTNNSmhmclVC?=
 =?utf-8?B?TE9BQUlGSFpSMno1WVVuYXI5Nk4zUWZCcHdNWUo4MGJ5d0hFMDlhSTJ0V3Fz?=
 =?utf-8?B?OVNJZXRJTzE1NkdvbTFiNTZxODdETDB3L0ZNZlYvZGVOTjIrTitJVEtFVjgy?=
 =?utf-8?B?MHFOUjhLeDRLUmtuTFVudWZWR2FDUnUvWVhNamJIeWV6Y2dodDRWWS9ubTVJ?=
 =?utf-8?B?a1ppZFdrNklPQlpmM2trZTl3Y2RsMjNpc0JHSDdIRDBFRHg4WHVsWlYzNUl2?=
 =?utf-8?B?aUpab25RT0huMFRNeWJPY2JqVVN5UllGVXE3TTUwTWttVlY0ZDl6ZllVVU9r?=
 =?utf-8?B?MmExWVJtYkZKekRNdS9IYW5RZTZDZzMwNjdxV1FzUVlXdFRDdUxPeEhTV3k4?=
 =?utf-8?B?bWdTVWc0aGZGaUc3K1kwb2FxVEVDQStIMG05VG9OVzFVL2htVCt2VEJoNkN5?=
 =?utf-8?B?SjhPb1p0NzZsNGdxZU1DeSsrbGhjRHFLK0RmYU9qc3VldE9yTUF2L3ZicDh1?=
 =?utf-8?B?TlU1RGV3U2h2TU1UM3YzK0szQWtnOHQ5aTVyT1NValZ0UGFZUkJ5QlZwaFdx?=
 =?utf-8?B?TzVSTXBGemlUTzA1NGZGbWdPMGp0Q3FZL2lVZzRZNmNjdmRiaW9NVTh4c2NI?=
 =?utf-8?B?dGVqUytGUm5kTjQrakJRdnFzTlhvbUJLUWNoeHBHdEM5SUd1bk5PeEMyUkFo?=
 =?utf-8?B?RWVhOU95ZGptMFl0ZXd1Y1IwN2Q4OHEvZmJOZXZwUUhaSEpaaE9mYm1mNlhu?=
 =?utf-8?B?Z0F6anFEd3NpTzN2T0NMMUdUUkM2WUhsYWZYbTB5Q1lVMENrenhJa3h6U3U1?=
 =?utf-8?B?dFpQb2kvRHF0OUVERTJraGpMVjRkOGozZlEza1NrYVBqQTdXeWp3VWtHaEdq?=
 =?utf-8?B?S3hrZjRsUTRnRkNENGMwNDQ1Ky9kQlUrT0diMEF0V2UyL3BHNW9nY1dtNGU0?=
 =?utf-8?B?Ui9kbVNMZEgrMlNZUlJYaXRBZU9NWGh6RlJOamFneUNhcTFKZnhDZzB3RytX?=
 =?utf-8?B?ZVVDUy9HQ0RLQzNNOXk2b0ZtR2ZKN3VvREJUTEM1aUw5SkY3S1lGZVliL3Zw?=
 =?utf-8?B?YUU2akUxaHN5RXVLTy9XQ0Y5RkNCUzNYM3A2QUMwWmwrcXRsdlNUbTZKWmFN?=
 =?utf-8?B?YTFieE5ObmZiWnBna0grYTZuZjhrK1VUcW8wY0NVdHZXbEQ2NFFWUDBXVU9t?=
 =?utf-8?B?d2xpQmt2R1hhc2Z5ZFJwdUxrTmZFMnk0cmZ3Sys5UVo5TVNSbUxaNUVlSzll?=
 =?utf-8?B?QmRwdkU0TG1LeVF0OXpTdWZYRU5VZE8rZzI5c1RDc25sN2dnTmc3UFJvSkVY?=
 =?utf-8?B?SnF5MFVxSzFualJRUFdCQVhoeEx5ZHJmWTUzbjZhUnJHSDV2RldJWDlWaU05?=
 =?utf-8?B?eVhIUVdjdzU4N3pyRGh3UVJCSnV2bGlwYWZscUJyS1dvU0dUTVhnZnZlNm9F?=
 =?utf-8?B?eXVUVHVOYVlQTlNqT1JOLzZjL1FkOWFnUnhQak9nNUREc3d4OXdPK3d3bks5?=
 =?utf-8?B?WUh6Q3YwVkFuZnROdXE2dk5DbEFGc0tGU2lrWnlrUXM1UGJyem5PaklsSzR2?=
 =?utf-8?B?ZnRsc09aZ0RUUXZYZyszbDBHNi9BbiswUldwUEZ3RUs3ZU5LdldpdEdRLzFR?=
 =?utf-8?Q?i+NVMQSw4rm8AYdTc2khOM/4c4Fi5vet9szbU4h?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC5D429451AD124EB6E781DA85FB41D9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b75bb1-d611-45a7-d908-08d9091c96db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 01:34:24.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6I5dwNOQsluLKCmFKDXRk3ddp+6yN6XpCo5cCoWeFt99xtfn0ENLkaXa6JQBWdywki2eG6/d0kgJV/LRQQX1EG9zCFCaRp4jHw17QK4kJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4569
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMS80LzI2IDIyOjMyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gTW9uLCBB
cHIgMjYsIDIwMjEgYXQgMDI6MjM6MDZQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFdlIGRv
bid0IGFkZCBmYWxsYmFjayBmb3IgcmVuYW1lYXQyLCBzbyBpdCBidWlsZCBmYWlsZWQgb24gb2xk
IGtlcm5lbC4NCj4+IEFsc28sIHJlbmFtZWF0MigpIG1hbi1wYWdlcyBzYWlkIGFzIGJlbG93Og0K
Pj4gInJlbmFtZWF0MigpIGhhcyBhbiBhZGRpdGlvbmFsIGZsYWdzIGFyZ3VtZW50LiAgQSByZW5h
bWVhdDIoKSBjYWxsIHdpdGgNCj4+IGEgemVybyBmbGFncyBhcmd1bWVudCBpcyBlcXVpdmFsZW50
IHRvIHJlbmFtZWF0KCkuIg0KPj4NCj4+IEluIHRoaXMgc3JjIGZpbGUsIGl0IHVzZXMgemVybyBm
bGFnIGZvciBhbGwgcmVuYW1lYXQyIGNhbGwuIFNvIHdlIGNhbiB1c2UNCj4+IHJlbmFtZWF0IGRp
cmVjdGx5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBMb29rcyBvay4gWW91IG1hZGUgc3VyZSB0aGF0IHRoaXMg
cGFzc2VzIGFmdGVyIHRoaXMgY2hhbmdlLCByaWdodD8NClllcy4gSXQgcGFzc2VzIGFmdGVyIHRo
aXMgY2hhbmdlLg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXI8Y2hyaXN0aWFuLmJy
YXVuZXJAdWJ1bnR1LmNvbT4NCg==
