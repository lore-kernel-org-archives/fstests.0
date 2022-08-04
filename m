Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA83C19F29
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Aug 2022 01:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiHDBdq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiHDBdp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 21:33:45 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 18:33:44 PDT
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FA55B06D
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659576824; x=1691112824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tPr8LWedshCUvzdW+/mDiEXLKsWpDAqMIZqdtqxcv40=;
  b=InEKOQVpgQVNT6TjyNchbf8K7mCF2rdEO7OcH4DWfzDVf6pihTDTevOP
   fcEXJj9A6nw0goPZycbUIqQ0r0NvbPceN0LZXiKVRAFxokoVMsObjPr9g
   qyS811URIVIX2JT8gvet4HOUqUvhpGNxKYsMwF/9JlH5eQM+NAUJnLIo2
   uTvPoiQg8dmmKKPrBhCcfj4Di9WzEwCyMQ6bGAZ4lbpFvH0eKslNff8wq
   tXOh+nONH+AL49mQe609OOs3OMWfrkFiafwGK4mGzX4/7yWn2jbXjhQeS
   LwhlltE5FXKnoygWmOZStQtRAZfp9uthIuRONIt1v1SrvyKuHXf/fIc4K
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="62160926"
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600"; 
   d="scan'208";a="62160926"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 10:32:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVFXrYe3LXfBrlvC56kNjm0EmIglVYj6TsSr6JN+HQobLppj6ee8G3ZliIbZl8cWS/x2Zk+/pff7tX7etVkOHTB8jTXHa7SF+Q7Njs95Js+nAqsyPQS7HPNYh55/lXuy9NU0Y2dtYv9MPNQW8s5deezk75gUNM5Cv77iZSPLM2G5MEUwRf1QYNeC+nNbzrtFAlN0akwzd61Zp413hQz62IC+hsKFyiYV5/gVgRxyb3qdYdyFaXoatyg3FiBEjJ7CzU4Eoc+RZWD6xuXlRrq/CeLXSE3dLWiWgydWxlCxXdlqiYcVJNtyz90BLL+LJY6b+ORsoVfw2lErZLIxO5xwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPr8LWedshCUvzdW+/mDiEXLKsWpDAqMIZqdtqxcv40=;
 b=MYpcGvzaetVjodYAa4V0ahNZP7uyTXbUepaZNL0ymqQxcyx0k1KwtezZ0qr7yu+oxJqdxUywpSXDbBKB1wf3eyyFU5SXuvMD3BUzcbCe7wKlgo26IBv7/aPjJB+aj56IGsxv924LIKODppx3PgahRPd8LhtQfd+Xt58T149wRwGW+GPrJ8xTmkM4eSb5lOdjhKA91bAkETnAom+XS0bdc09IGOhMdEGIHZHVnDCAuvh4/yLX8Zgopc7tDA2rR2p/aeDZBMGxa7t0ckHewdy2BqsR028QG+oXQM4hsE2qwEngO832qTfNr6iJETewQgU0vtCilZs/HRKrRvKyqbjf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com (2603:1096:604:107::13)
 by OSAPR01MB4929.jpnprd01.prod.outlook.com (2603:1096:604:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 01:32:32 +0000
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::ccd:ccc6:1a42:94cd]) by OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::ccd:ccc6:1a42:94cd%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 01:32:32 +0000
From:   "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     Zorro Lang <zlang@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>
Subject: Re: [PATCH] generic/688: Skip test if fs doesn't support security
Thread-Topic: [PATCH] generic/688: Skip test if fs doesn't support security
Thread-Index: AQHYpkTjL44pREWUQEOnjgSDKcleL62bVLMAgAFpAwCAAECjgIAA+VWA
Date:   Thu, 4 Aug 2022 01:32:32 +0000
Message-ID: <f6d185e8-beee-a0d7-f07f-1e1ffef99635@fujitsu.com>
References: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
 <20220802091700.d2e3u7defue7kwbd@zlang-mailbox>
 <4e39344d-bc71-1b6b-f23e-07627c76a983@fujitsu.com>
 <20220803104027.c5nme65zgwzccut5@zlang-mailbox>
In-Reply-To: <20220803104027.c5nme65zgwzccut5@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21807c3c-f401-460e-a6a3-08da75b933e7
x-ms-traffictypediagnostic: OSAPR01MB4929:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufxSRNWZPTO0NqyHzDIcVNwnXXvWVJ9W37z4zcbmJKXg9navIKxJcRj8CZAfLSrrpLwdys/YOFmHXTwXsio+4Za/5UbpYxqvHAuDznaIt3gg9anToMM10gC5Dir/OIeTbDjg77wPAUh58uG720t46viOF8wb+mH/0EJxAnUWqfCjljaqC9Qi+5h4Fodmlngq8qk6gHysHxy9vIaCbnMA68A91I2bUCmtRFgk3FNFVOyGNpnNHJ6WJMsBhS2B4Opa9GSTD0dkGjWVV2eA9ZeTjkGoa1lZBXki/U0hTohfu4l86eMXKh144WPaGNwxMdhbjzCBwI1lQUF9E1PFU8md0iahmPmHM0cVctjGRYYATCjupB7MOspNns2Euyh/USk4MFsOAbnCDzXsJbyOqWmLRoPY0SyOY1VW9Xka+traknwUJ3pgK1fjSMtmL9DqBuBBqmfdGGPwFCOfuBdjGVUv7NzDSgIBmZ9NX5d5VydeL7f5ku6rxTAot0/sEKKSntWn+JQ7AlvaSkdWJLwdWnJAOODdvAF4WI3V7SCNmvTSWdqco/McheiYFduRmCR2cQRodahI8zYjFHmPIMg4YmP26bGWEWAwOlGL6rFJlgJOcaFtGjijrKr4AV5cFONgv9rDhDk3Mm/syAPMZfXd5YYnaBB5ng+dbOrRMHp8mKQVqS7GrtpA9cOeQrqIy/CBZg5y0yP+XGDnwkVSv9IIMbLFRkd8AeyjTxsRLbjk/XhCm7AN+YSOgIBN5KBoFCzNxuMuoaBNTuablj3gxuNk6Jk62H4PhvIPoK8YmnfOdxJxafazgjddDIp69EUtZIjAPu3SHFgwyh4cHT5iexAw8x8lmid4GbP1mCHRvdd+/ASHA65Z1k2/e4dR0o3hnMQ7yL3k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(38100700002)(966005)(6486002)(26005)(6512007)(6506007)(82960400001)(66476007)(71200400001)(91956017)(66446008)(53546011)(66556008)(41300700001)(15650500001)(478600001)(31696002)(5660300002)(2906002)(86362001)(8676002)(122000001)(36756003)(38070700005)(76116006)(85182001)(8936002)(4326008)(83380400001)(6916009)(54906003)(31686004)(316002)(2616005)(186003)(66946007)(64756008)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJXTnNmUXlGYXN6RE5CeHAvQ3ArRGt3NVlRcVREMUNCUGdhZ0VtTjF2RldG?=
 =?utf-8?B?NEJ1K2p4Njk2bTVNZ1pONEpxL0xLZUJ4czI2dmd2NnBpbGM4S2ZhamRnTHgx?=
 =?utf-8?B?RVp0SncrZlpybFR2djJ0ejZGbXphUFdqaWRxeWdTR0taUmM0ZDA2S0F3dWZy?=
 =?utf-8?B?Qm9Bc1JFZnhUL0twL2xXdWtNY0pySWlYT3U2ZkZDZVVpSURRMk8zMzk0c25Y?=
 =?utf-8?B?Sk56UnFtbnNHdXo5NHRCTitQRkpsVTZMajJyVFhleWFOK1JTYU5KaUZWU2Q4?=
 =?utf-8?B?eGRNWldlRXJKS1V5THhyYVZVaFNkeTF2M3VucjVSb0IvZHVFMVdES0oxVEoy?=
 =?utf-8?B?TjhEUlA4Ym4yWjU5OTQ2RjdQa2RNY3lhNTB5V0NvQkRPN1ZpWUxmOUV5K05Y?=
 =?utf-8?B?enRYcmtTUEtXNWFpSzdSRTAzRnlRWUZYYWlEYkswalpxMmRSdGNMYlc1cXpo?=
 =?utf-8?B?WlozMDNhb2k3em02cmdNR2FtRUtpeStOMFJJOG9WWkpOSVhNL245T1VoYXRn?=
 =?utf-8?B?MlAvVE1ybHl0TWViaXpMdXB4azFGNjcxQXVabmNOdGhsZlhiTWkybFA2bjBX?=
 =?utf-8?B?WlZiNlRnTUhsdXpzUHMwZzVmRDVjNUZFQUREWGQ2OXB3amZrYVBJVUZabmo0?=
 =?utf-8?B?dkVGNlVqZzZPaUxlM1BlV2JqMjBmcHIwZGMvWDZPOXZ3MGRPUHhuMytJaTl2?=
 =?utf-8?B?LzRNekJmSkl2dS9XaWFCWm1vZjdVY05yQW5YVjB4enlSVElrSXZDRHk0RnNE?=
 =?utf-8?B?aGxZRkJGc0RmS3p1dlZQalhqcDdyTDdMUnd0UDBUczBmSjlEaW1kR3E3YXJm?=
 =?utf-8?B?UTFlaG9LQ2RuZWZqSmZwSUxtZEQ3d0o1U2N5cHprSDlCRnA3ZnU4S0tGS1Z1?=
 =?utf-8?B?SmFaZ0RMVFQrallyUnhJMGdCV1pNYkY1aGJBaXd6RkJxVWprR0gzeU53bEVD?=
 =?utf-8?B?Ujc0eVhMNlBva1p5Q3QybXpHYlJ3emNxdUdKWkJKdkIrM0FSUFhNMGFDZ3JF?=
 =?utf-8?B?bTRadEhjWG5PdW1TNUNqcGRzNnNVbi9NVEJPbHJFY256L1F1cHNINHhPZTNh?=
 =?utf-8?B?RjhTNDRWdWtLK01uSno0MWJGblV0dzRxcVk1YzJuK1hGVGZKUmhiWjhCemtl?=
 =?utf-8?B?VERwVzB3LzVhNEhqeGZZUFJtUGRVdEdsRzZWVzZYQ2dUcnlVZXJrK2VtTFpU?=
 =?utf-8?B?V05KMmNISVJiSzN1M1dGZnBYSmtKR09pR0NBOG16TEp5eU5zRjgwM3dCWVFq?=
 =?utf-8?B?Y2lET293RThkZDVnUk1kbEdlUEdEclg0UjFZRVBvYStSOUpQZGgzWE1sVGd6?=
 =?utf-8?B?K0VTOFNKUlRERkIwajB1dUV4Mml4cEFzclJtbkJ3VGdlcksvd25mODZOOEw5?=
 =?utf-8?B?RzJnbkFUQVBhUUxpQ2FocDA2VkdUaHBvdjlmYy9TaHowbWJ6TlNmeHppc09n?=
 =?utf-8?B?b0kzZnR6bFFlaFEvOXN5S3BOSmxoMWlGRlBPZnBkNUx0TW1maG0wQ2N6N29F?=
 =?utf-8?B?cUhiMjFpNEhpQ0p5VHhPWUp0TnpvK1RoeDlSaEcrN0dub0MwUFlnWTdQNzUv?=
 =?utf-8?B?Z3hENFlyUzRXUXUrRXlpd2NDK3VvajJoSHBmb3pFMlJ1UTZmbW50WVlueE1v?=
 =?utf-8?B?Sm9jSGdaclhPejJMbHBSZVl1ZWExY2k0eCtsNVpOZ2VUN3BnVWkzblNhTDR6?=
 =?utf-8?B?N0R6eUx3WndIbW8rWklCWUNlelBmbE1VVWZVVVVsSGRtNFFqSEpkdk84ekZB?=
 =?utf-8?B?cU1BcXFkS25mTTF1TzhyNVZVbzd6SFErblVGY0JQNVRNblEwbzQrYUdJS3Iz?=
 =?utf-8?B?ZWVCSW1zR2NKOW91WWtBZHNuYnoyaFN2M3lDTE56aGo1a2ZhTllLdUYzdzFt?=
 =?utf-8?B?Y3ZPd3o2NmxtVlUvOEJmaGlkOEVGMDdCSTRVM1BjcGhMakwwQy9oVE9tbjh5?=
 =?utf-8?B?MjRZTC8zSHozRzRHUU9UWURzeGNLTjhRUUh1VmJrRFErL0VrbzZ6ZWh3UXZ0?=
 =?utf-8?B?UHhONkhNMWN5TG9yQUZnVjlpb2xEcGFpZkRTRWdQOERmbjFXdmR5ZmFuYWp4?=
 =?utf-8?B?Ukt6L0NSK2U4TytwRktsTHJmcnV3ZTJKeFQ0ZVV3Rnd0bGd6OXNYVGNpTldL?=
 =?utf-8?B?STU3RDNpUVREREZYTmRSNUMvZzNOTmVVWFRITnhnQlFKRDcrMFMzSTZQWjdp?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E739BE9E24646943BA1B586226F97321@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6481.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21807c3c-f401-460e-a6a3-08da75b933e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 01:32:32.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6wsjrJv0SV846kYRG84eq7yxMgJfYIYP7S/+d7Ny43IowXTfIRsOJ/Hk2D1LEG2e3GL92pl1Ag5fRY79SjW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4929
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQoNCk9uIDgvMy8yMiAxODo0MCwgWm9ycm8gTGFuZyB3cm90ZToNCj4gT24gV2VkLCBBdWcgMDMs
IDIwMjIgYXQgMDY6NDg6NDdBTSArMDAwMCwgbGl1eWQuZm5zdEBmdWppdHN1LmNvbSB3cm90ZToN
Cj4+IEhpIFpvcnJvDQo+Pg0KPj4gT24gOC8yLzIyIDE3OjE3LCBab3JybyBMYW5nIHdyb3RlOg0K
Pj4+IE9uIFR1ZSwgQXVnIDAyLCAyMDIyIGF0IDA3OjUyOjQwQU0gKzAwMDAsIExpdSBZaWRpbmcg
d3JvdGU6DQo+Pj4+IFRoaXMgdGVzdCByZXF1aXJlIHNlY3VyaXR5IGF0dHIuIFNraXAgdGVzdCBp
ZiBmcyBkb2Vzbid0IHN1cHBvcnQNCj4+Pj4gc2VjdXJpdHkgYXR0ci4gRS5nLiB2aXJ0aW9mcw0K
Pj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWlkaW5nIDxsaXV5ZC5mbnN0QGZ1aml0c3Uu
Y29tPg0KPj4+PiAtLS0NCj4+Pg0KPj4+IEhtbS4uLiBsb29rcyBsaWtlIHdlIGNhbiByZS1zdGFy
dCB0aGlzIGRpc2N1c3Npb24gbG9uZyB0aW1lIGFnbzoNCj4+Pg0KPj4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2ZzdGVzdHMvMjAyMjAzMjMwMjM4NDUuc2FqNWVuNzRrbTdhaWJkeEB6bGFuZy1t
YWlsYm94Lw0KPj4+DQo+Pj4gQWJvdXQgaG93IGNhbiB3ZSBkZWFsIHdpdGggdGhvc2UgZnMgZG9l
c24ndCBzdXBwb3J0IGNhcGFiaWxpdGllcywgZS5nLiBuZnMsIHZpcnRpb2ZzPz8NCj4+DQo+PiBB
aGgsIHNvIEkgZG9uJ3QgbmVlZCB0byBzZW5kIGEgdjIgcGF0Y2ggdW50aWwgeW91IGZpbmlzaCBh
Ym92ZSBkaXNjdXNzaW9uLg0KPiANCj4gQWN0dWFsbHkgSSdtIG5vdCBzdXJlIGlmIHdlIG5lZWQg
YSBfcmVxdWlyZV9jYXBhYmlsaXRpZXMoKSwgb3IganVzdCB1c2UNCj4gIl9yZXF1aXJlX2F0dHJz
IHNlY3VyaXR5IiBmb3IgYWxsIGZpbGVzeXN0ZW1zIHdoaWNoIHN1cHBvcnQvdW5zdXBwb3J0DQo+
IGNhcGFiaWxpdGllcy4gSG9wZSB0byBoZWFyIG1vcmUgcG9pbnRzLg0KPiANCg0KSSB0aGluayBh
IF9yZXF1aXJlX2NhcGFiaWxpdGllcygpIGlzIG11Y2ggYmV0dGVyIHRoYW4NCiJfcmVxdWlyZV9h
dHRycyBzZWN1cml0eSgpIi4NCg0KPiBJZiB5b3UnZCBsaWtlIHRvIHNlbmQgdjIsIHRoZXJlJ3Mg
bm90IG9ubHkgZy82ODggbmVlZCBjYXBhYmlsaXRpZXMuDQo+IA0KPiBUaGFua3MsDQo+IFpvcnJv
DQo+IA0KPj4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBab3Jybw0KPj4+DQo+Pj4+ICAgIHRlc3Rz
L2dlbmVyaWMvNjg4IHwgMiArKw0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS90ZXN0cy9nZW5lcmljLzY4OCBiL3Rlc3RzL2dl
bmVyaWMvNjg4DQo+Pj4+IGluZGV4IDQyNjI4NmI2Li5kMTFiNGMyMSAxMDA3NTUNCj4+Pj4gLS0t
IGEvdGVzdHMvZ2VuZXJpYy82ODgNCj4+Pj4gKysrIGIvdGVzdHMvZ2VuZXJpYy82ODgNCj4+Pj4g
QEAgLTcsNiArNyw3IEBADQo+Pj4+ICAgICMgRnVuY3Rpb25hbCB0ZXN0IGZvciBkcm9wcGluZyBj
YXBhYmlsaXR5IGJpdHMgYXMgcGFydCBvZiBhbiBmYWxsb2NhdGUuDQo+Pj4+ICAgICMNCj4+Pj4g
ICAgLiAuL2NvbW1vbi9wcmVhbWJsZQ0KPj4+PiArLiAuL2NvbW1vbi9hdHRyDQo+Pj4+ICAgIF9i
ZWdpbl9mc3Rlc3QgYXV0byBwcmVhbGxvYyBxdWljaw0KPj4+PiAgICANCj4+Pj4gICAgIyBPdmVy
cmlkZSB0aGUgZGVmYXVsdCBjbGVhbnVwIGZ1bmN0aW9uLg0KPj4+PiBAQCAtMjgsNiArMjksNyBA
QCBfcmVxdWlyZV9jb21tYW5kICIkR0VUQ0FQX1BST0ciIGdldGNhcA0KPj4+PiAgICBfcmVxdWly
ZV9jb21tYW5kICIkU0VUQ0FQX1BST0ciIHNldGNhcA0KPj4+PiAgICBfcmVxdWlyZV94ZnNfaW9f
Y29tbWFuZCBmYWxsb2MNCj4+Pj4gICAgX3JlcXVpcmVfdGVzdA0KPj4+PiArX3JlcXVpcmVfYXR0
cnMgc2VjdXJpdHkNCj4+Pj4gICAgX3JlcXVpcmVfY29uZ3J1ZW50X2ZpbGVfb3BsZW4gJFRFU1Rf
RElSIDY1NTM2DQo+Pj4+ICAgIA0KPj4+PiAgICBqdW5rX2Rpcj0kVEVTVF9ESVIvJHNlcQ0KPj4+
PiAtLSANCj4+Pj4gMi4zNC4xDQo+Pj4+DQo+IA==
