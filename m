Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51412FA373D
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Oct 2022 07:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJ3Han (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3Ham (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Oct 2022 03:30:42 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF12D6
        for <fstests@vger.kernel.org>; Sun, 30 Oct 2022 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667115037; x=1698651037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94WB4s2JHqu8IEMMgPDVyw+mBIdtxBAHHa9OXvIhZ0E=;
  b=Xy11v6lUARZm4iem8bCt043Z6rK/GTQjDRyRV5ltEeKywyDolTPEJEwh
   avDE7CTFwqsYr2w8IihJQOApiyYrCJzIMUXt/rO3BL7Q2VuHddbiU3CBU
   QsqEqKD1rP6PoahCMaXWT/lObQzabHuDHQEmCY0LJnfkIFFAFHgz0hsac
   M62a2neAbBqHfTxH5/T97NN4Yxa4Z6Vy1encTDXANMxCQ5Y8gUQrvb0Ei
   HzQh9tL22zNSXlUJSqSI4z+Bu7VCNA9JWq14DVKLImQ2dJZJTFqB4SHGh
   4oTdoVd7rwsLlQgwpSTdkqsQG1JWRimQw5ZbVILSw0v68x1bJVVFDDY/K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="68707139"
X-IronPort-AV: E=Sophos;i="5.95,225,1661785200"; 
   d="scan'208";a="68707139"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 16:30:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Qff5MVcFTtEq6NACZRjbECIoxl/vYj7+FHTQIqjQkYbuOb5UUH/FkWML2MxjaRivMDTc2tyw1LJ9h8KqlZkLYBWrInXgNiI294uEWXtOz0yBqVh95AwobnruVTh1qMEn77j7XRPzgs7uY2a7bsqhnEKeptbdoBBSvQDcs6/1gGXTlrByPM56rcL+Q+Im3CzUYjl6f3LOpAKC+uEGAMITlhPyZ1kClPWoYpXcpkHIRwCSwrZUMpP3L8t+lFjTdnQ0+UHJLydG1KP/PmzjJ7/DkEx7P3tlgcQAIE3jCaSdG1wV52UryuHNPK9OkKIA0tRgQOyrqj1/TE2gLPey/wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94WB4s2JHqu8IEMMgPDVyw+mBIdtxBAHHa9OXvIhZ0E=;
 b=h5Dsy07OmBO14d56irnPALHmRvw8K7dVnK41xAazo8aepIoXn7qH+6STLhCp4SM/j/115rfr4uB+VSZHcsCVzgtffLFji4eyf775xzMg/XuJTempmovy/lRznk6cGP9PSbBrzS/lQCarwxJVEge1NIqt8GITyxqEc2oqCO66ZmHVdNp28XWKvMZZkDtC5Qk5lQbtN6Pu/4kGS05fMytB5B2YU0//r7vOH9BFpERgFKlBsAyu3e9DiVtdbIIfiMTWY26sJ3flSc0H/bcbajw3gFpg9MpPj84OxWHq8335Feh7ysWsrj7ektYVOPCv1lkvR4ITKeBfgYkxlRbm5fpynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TY1PR01MB10865.jpnprd01.prod.outlook.com (2603:1096:400:323::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Sun, 30 Oct
 2022 07:30:31 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::736c:538c:ac7:3c87]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::736c:538c:ac7:3c87%4]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 07:30:31 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>
Subject: RE: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
Thread-Topic: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
Thread-Index: AQHY5qts2N5bRvRZeESyJzp2ZHepca4c722AgAA0JwCACXHh8A==
Date:   Sun, 30 Oct 2022 07:30:31 +0000
Message-ID: <OS3PR01MB94990061DFD4223EC681B0AF83349@OS3PR01MB9499.jpnprd01.prod.outlook.com>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
 <20221023064810.847110-2-yangx.jy@fujitsu.com> <Y1YP7ehSZUdVS4/J@magnolia>
 <ddc1978f-686e-de66-71bf-b39dbafc2a9d@fujitsu.com>
In-Reply-To: <ddc1978f-686e-de66-71bf-b39dbafc2a9d@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YjhjZGUwZmMtMWVkOS00N2I4LWI1NmMtZGQwZDY0MzNm?=
 =?utf-8?B?M2Q4O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0xMC0zMFQwNzoyOTo1Mlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TY1PR01MB10865:EE_
x-ms-office365-filtering-correlation-id: 13a49112-5693-409b-d7f3-08daba48a028
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59ahZ+ZpFShJBcZj5VpiUASIzwByQu8UzvOmHlCW2hu7HjhQ5ivPRAyMuk98AgCMQETRIepDUMaUN3P3VCEG3vKATKaE/suyBjPD4FJ9O57cdSGtpXU9oyo8uJMBrP5duvPXInB1+f9QQ1/YeG+VtnNJfOgTBZOpM878O6ARTuSF3n6anAYzpHihUb+OGBjeJiNregNBBJ8nkhfvoXpleU1Ab7SoSjwlc9d89rvBYHQ+ejesFYGlEVOTFb/FCTc1x6/7Ws72vhS32fIhiYkNdF0LJEWiI2IoAhpowNS2Kovd0d3myj/vZoTRwGCvf+mGULj+pNPjP8ynQSIvJbJSeZxW5Ik5eSuTalJMsz6lN/ZlnalHJ3Vjxuq5Yg9p0iof3CO5i58pnmZxIrigbGk5Gn8UPpw02m0FF9HtiCVaZfRO6ICxgt+lS7lvWB9koaEaolms+FmC2C92bgj4n/DlNfIYgT7VHAWeAGm+nWQBymxMVAuVbwnEwraARM/0nSe48xrPtNnImPRHBTtCkkEovC46yzZ6Q7hW/6aZLF5H5j9snkX6JfoM+nLTvuwM6lpiwKXWMFhyuWWIzOHrZTPiB+MUpozHXLfP6JldfQJs5yqv3htioDrbwWDBvTl9+SFpLPmZao9b/aaJ8+cDHLWE302OynHRi6T0iP1D3ReWrogDWDsGlETcjJrEsbJuiCnBJ5XxueotviNhtgFrr8hEM7tI/1oPpYw8yd1VPVn16zEcJ+Bz+WsyXyU65kSwfznADZnMan3ZPrViq/c+GBaaRobO18vwnpXk7IMDJ1oVwLLIcFxbB6vTtXgHtzW4QxnA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(1590799012)(38070700005)(86362001)(85182001)(122000001)(82960400001)(38100700002)(55016003)(33656002)(71200400001)(2906002)(478600001)(316002)(76116006)(4326008)(66946007)(66556008)(66446008)(64756008)(8676002)(66476007)(6506007)(8936002)(5660300002)(6916009)(54906003)(52536014)(41300700001)(7696005)(186003)(53546011)(9686003)(26005)(83380400001)(1580799009)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9DNHNPOE15ZlVseHdKQnN1TjZoMFJEMkdNN2F3TTVwbURlcG94aklCNWp5?=
 =?utf-8?B?aTFMa050cFRxMUdBQ1hhL0NTZDFReXZVUzZCZHdENU9FNWlOMlRTTWJIVTht?=
 =?utf-8?B?UUFwVGM3YlE5NlBhZUlKRmp3bFFWNGVKRVpicDBVZ3RnZ1JrTHNGWTBwSWR2?=
 =?utf-8?B?MzZlSEVQV1dTTi9WT0xnelNWQkI4ZEVUTkwvYTZJTDZkeTNKQ3grME5MelU2?=
 =?utf-8?B?bG9DK0J5Qm1zQzYvUFlMMitod0QxNlQxdjkvR1JDRVdiWnlBSXl6aGFrK3ha?=
 =?utf-8?B?MG9RZzMyVkdMNXhsajdnb1lvYlRQQ1JUM0xWdjZKQURBL2N1R2dWTlNUK0Vq?=
 =?utf-8?B?M0dLaU82TkYxM3NsQm1UYjRYdSt0QWgwNUNaZitUeTJOUFIyYUFCRzIxSU5F?=
 =?utf-8?B?T3FweHhGSHNLdlJVcnJJdWVZTHp0Y29hRFJYMEZ5SXU2UEhkSktxTXFBRmda?=
 =?utf-8?B?WXR2Z21sRnlmQ09NbTE3aTF4VVd6U0l6V29XY3QvY0dTelk0K2paVHRLWis2?=
 =?utf-8?B?bTZyYS9CazRQaHM3YjBQUzgydjJKR0JDNVZYZ2JUQzRzRkl5RzYrS2NKUSt3?=
 =?utf-8?B?TTNkWVEvVUUyWk1ybU1LOFg4eWppZ3dLeEdVTHVOZzk4eDVuQTl6Snk2M0NW?=
 =?utf-8?B?ZWd2K2crbitxUlFHQllsaXRweCtzYjFHTDNldkFVOHBqQW9NSU4yQ1FUUjlO?=
 =?utf-8?B?dE9SZFFyU0ZodmR0aDY3Nm1XYlFYY0JKVjR5MFVVMXkwYy8vM3lTMUJta21r?=
 =?utf-8?B?YmhiSVo2Vjl5eTh0V1BrUDFWQk5BeGl4ZzFBUEFkK1NsRDNBQTdSaVYwL3Zz?=
 =?utf-8?B?TWFrMVgrVjEzWXFRV0hIbW92WDcrVEhDSXBLS0hOT1QwM0JRa2VJcXc0Slp4?=
 =?utf-8?B?ZEhlSkdOMll6dDZpWTh6QlZDSzFKME5iRnNRT0dOWU1VbElRTGRLYi90UHBV?=
 =?utf-8?B?Q0F4bVFOWDBmdVk0cnZSd3dhckdtK3EyZ3I3VllKTG5xN1JsamRGTGxaRmxR?=
 =?utf-8?B?a2FFRWlwZ0cxNHo0ZEplTjlhNkRCNDZyVk1nRDRmendHMzBHRUU1V0hkM2xz?=
 =?utf-8?B?YjR4V0RQU25OMWV2Umtib0xQTDkzcVBWb3lRamMyaGdxcXB0MnlZSkdCeXZF?=
 =?utf-8?B?dUQyU0ZxMWxGTlpjamhqbXBnS0ZWeEprYVErazgvOVgra3E3aGE0TCtnTVFp?=
 =?utf-8?B?ZTM2Y3VqVTh0S0tMR2FMNkRpL21VS3NFeXVUR09HK0c0ZExJYlBxV3BpU3Bh?=
 =?utf-8?B?NkY4V25Ib0U5ajd3cE1SSy9MblljZkIzRSt3ZEhzdjRrcmhaVC9aRk12eGFW?=
 =?utf-8?B?ZHNBWTNkYklPRkc3Uk8wZm9xNjJDU2RIQlp5R2VUM25NVDMyOE5zMElRaDlD?=
 =?utf-8?B?N2hxenk3U3dxQjBTNG0yd2xLTThVY1hwOFdCNy9Ock03cWMzNVhvd1JBTWZE?=
 =?utf-8?B?QzlWN1g5ckt3a2p2dkNIT296anVXajZsK296VUlHYzVtc0tQWmIrL1RsZERW?=
 =?utf-8?B?RXlISmdWWFZOU0E5SzRqVlpPU0NvTlpyQmtwUEQ5bDVGRFgwb1VWb1ZkaENK?=
 =?utf-8?B?V1h2QThCS3VnaEY1bmVxNC9oNllsK0cwcVNEY3FwRkR3QjBLT2RHTXp1NThF?=
 =?utf-8?B?NnlZQXJmUFJmcWN2bVRNVE4wVlZhS1ZBV3U5LzJ4a2NPN2VDdzJLUThvdE0x?=
 =?utf-8?B?Y01qSDlVekR2UHVMdm1JZ00rNlVRSldDSHhXVTJPa0tvTWhINTZDNXlJcWJH?=
 =?utf-8?B?WFVRbWtOaFVDMGhUZ3NiTzZQWGMraGlWeVppa3ZNbGJiYnZqYmNBNnlaVkVp?=
 =?utf-8?B?Rit5L1l4YlUzcGpJN21taXZUT2hmV05XT3gwdkt4UUF2czg5VjVQVkZxNDFx?=
 =?utf-8?B?Zm9SdlBNN2FVTzB3TnJoenhMOGZTYW96cnZjSVY1eUd0ak80dTI0M0N5UjFp?=
 =?utf-8?B?c1NWOHV3cURaazhJckFlaEtpK3N3bnRjVlJKQk5wRVhDRFVxdXVhQU9PS25k?=
 =?utf-8?B?SXpQSUdjYzFxZzRYV1MyL0FWb1V3dVJWdEJBVUtkU2htdTUyK1crM0hQQlBR?=
 =?utf-8?B?U2xFMHJEblBGMnNHZjE1VnVoNjhXZWhLMDNtWTNrSFFiWURtQkhxeTBFekIw?=
 =?utf-8?Q?U5A1WEDmq3NNcAz26bkxIXdjl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a49112-5693-409b-d7f3-08daba48a028
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 07:30:31.3320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lg2ZI/VNQgVXGbZWi+CSUrk0aTKAeHahemVFr7KUgQ8RjnWU0sqRzItRifSY42MLp3sLM7s+Q8d6SXJnVFF3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10865
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgRGFycmljaywNCg0KUGluZywgaXMgdGhlcmUgYW55IGZlZWRiYWNrIG9uIHRoZSBwYXRjaD8N
Cg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBZYW5nLCBYaWFvL+adqCDmmZMgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPiANClNlbnQ6
IDIwMjLlubQxMOaciDI05pelIDE1OjE2DQpUbzogRGFycmljayBKLiBXb25nIDxkandvbmdAa2Vy
bmVsLm9yZz4NCkNjOiB6bGFuZ0ByZWRoYXQuY29tOyBmc3Rlc3RzQHZnZXIua2VybmVsLm9yZzsg
YmZvc3RlckByZWRoYXQuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIIFJFU0VORCAyLzJdIGdlbmVy
aWMvNDcwOiBSZXBsYWNlIHRoaW4gdm9sdW1lIHdpdGggYmxrZGlzY2FyZCAteg0KDQpPbiAyMDIy
LzEwLzI0IDEyOjA5LCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IE9uIFN1biwgT2N0IDIzLCAy
MDIyIGF0IDA2OjQ4OjEzQU0gKzAwMDAseWFuZ3guanlAZnVqaXRzdS5jb20gIHdyb3RlOg0KPj4g
Z2VuZXJpYy80NzAgd2FzIG9yaWdpbmFsIGRlc2lnbmVkIHRvIHZlcmlmeSBtbWFwKE1BUF9TWU5D
KSB3aGljaCBpcyANCj4+IG9ubHkgdmFpbGQgdG8gdGhlIERBWCBjYXBhYmxlIGRldmljZShlLmcu
IFBNRU0pLiBUaGluIHZvbHVtZVsxXSB3YXMgDQo+PiBpbnRyb2R1Y2VkIHRvIGZpeCB0aGUgaW5j
b25zaXN0ZW50IGZpbGVzeXN0ZW0gaXNzdWVbMl0gYnV0IGl0IG1ha2UgDQo+PiB0aGUgdGVzdCBi
ZWNvbWUgbm90IHJ1biBiZWNhdXNlIGl0IGRvZXNuJ3Qgc3VwcG9ydCBEQVguIEFzIERhcnJpY2sg
DQo+PiBtZW50aW9uZWRbM10sIGRpc2NhcmRpbmcgdGhlIGVudGlyZSBtYXBwZWQgcmFuZ2Ugb2Yg
c2NhcnRjaCBkZXZpY2UgDQo+PiBjYW4gZml4IHRoZSBpc3N1ZSBhcyB3ZWxsLCBzbyBJIHRyeSB0
byB1c2UgYmxrZGlzY2FyZCAteiBpbnN0ZWFkLg0KPiBUaGF0IG1pZ2h0IGJlIG9rIGZvciB0aGUq
b3RoZXIqICBkbS1sb2d3cml0ZXMgdGVzdHMsIGJ1dCBpc24ndCB0aGUgDQo+IGZ1bmRhbWVudGFs
IHByb2JsZW0gaGVyZSAoZ2VuZXJpYy80NzAsIHNwZWNpZmljYWxseSkgdGhhdCBkZXZpY2UgDQo+
IG1hcHBlciBjYW5ub3QgcnVuIG9uIHRvcCBvZiBwbWVtPw0KDQpIaSBEYXJyaWNrLA0KDQpXaXRo
IHRoZSBjaGFuZ2XvvIxJIGRpZG4ndCBmaW5kIGFueSBmYWlsdXJlIHdoZW4gcnVubmluZyBnZW5l
cmljLzQ3MCBpbiBsb29wcy4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpbcm9vdEBmZWRvcmEzNSB4ZnN0ZXN0cy1kZXZdIyAu
L2NoZWNrIGdlbmVyaWMvNDcwDQpGU1RZUCAgICAgICAgIC0tIHhmcyAobm9uLWRlYnVnKQ0KUExB
VEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgZmVkb3JhMzUgNi4xLjAtcmMxKyAjMzcgU01QIA0K
UFJFRU1QVF9EWU5BTUlDIEZyaSBPY3QgMjEgMTk6MDQ6NTcgQ1NUIDIwMjIgTUtGU19PUFRJT05T
ICAtLSAtZiAvZGV2L3BtZW0wIE1PVU5UX09QVElPTlMgLS0gLW8gY29udGV4dD1zeXN0ZW1fdTpv
YmplY3Rfcjpyb290X3Q6czAgL2Rldi9wbWVtMCAvbW50L3NjcmF0Y2gNCg0KZ2VuZXJpYy80NzAg
NnMNClJhbjogZ2VuZXJpYy80NzANClBhc3NlZCBhbGwgMSB0ZXN0cw0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkJvdGggZG0t
bG9nLXdyaXRlcyBhbmQgUE1FTSBzdXBwb3J0IERBWCBzbyBpdCdzIGZpbmUgdG8gdmVyaWZ5DQpt
bWFwKE1BUF9TWU5DKSB3aXRoIHRoZSBkbS1sb2ctd3JpdGVzIGRldmljZSBvbiB0b3Agb2YgUE1F
TS4NCg0KRGlkIEkgbWlzcyBzb21ldGhpbmc/IFdoeSBkbyB5b3UgdGhpbmsgdGhlcmUgaXMgYSBm
dW5kYW1lbnRhbCBwcm9ibGVtIGhlcmU/DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KDQo+
IA0KPiAtLUQNCj4gDQo=
