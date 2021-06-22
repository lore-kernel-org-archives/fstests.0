Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD225C4743C
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 01:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8135160720
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 01:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhFVCBF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 22:01:05 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:10251 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFVCBF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jun 2021 22:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624327130; x=1655863130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OA3VVYmvgrhzF1IxYI1MsZkTSVeW5kx98EYsOhYWMQo=;
  b=DFJhbNk98XSFtvMnSfO6tweAWXXow42QkOgdWO4L/1nmZjhfVSR4hbr+
   XMYqcFS4uTnBjV+HkAmsWYENgwtQsAFPkQwsj54DoSgPs9aF8De+XqLLB
   2rhkguLKDSJqBay9nVL5C/bwXkrwoYX96/Nul6ao2DLmJfrerYKectnj+
   SPfr1D9Lj+yEHcBqlGEoWqyoHHdKeJ/Fuf1/ArgfaOrFA/iaH1D4r9nWX
   KiQC381QyjH0sesV7UkoiOfw7nbt3BK6Rg0RprpJUGdjRpX8RmHdvU4Rz
   lI/sHa0S0vijmWbSJhJJsDgdJTWer4hKC4oIlFAqyhqiOLKOcsLKXtYcH
   A==;
IronPort-SDR: JkVu+TobJzbNv+YQzbD4SIzxuOFUaz9I/h57eqyOBZWKIvIgLR8YIKUbqpfXDMyLe4S56BmUGT
 XdB9Wr2kznNK/LpjGUFHbrWFr/4VrCiqfhQ/Coffaig2iw7GrCuOiSv5vYaywNPoO/Snnd3tDa
 LeNW9SJDPwU85l7ysVWuwu4+KxuFMlmBSwcCijaw2409udThEouNpK5Cl9lZjYWSaLaZdulhU7
 CwDkMcR8etcW49ZAAZzuGIVMPX2bGF3vSspSAI+vIZdI/8KHxWSXq1M9Rco4ZftDli313c9sLQ
 OUU=
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="33309938"
X-IronPort-AV: E=Sophos;i="5.83,290,1616425200"; 
   d="scan'208";a="33309938"
Received: from mail-sg2apc01lp2053.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.125.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:58:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apgGLh1G88nZJPEeeaom5jhbk8eyfB9M5InTIDh49Mr/8nncrZbTFU33Jb9H/7zXvwiWOZzpZR1zcBQtfDDE9T9vx2pxo+1IjR+QC6Ql+n6M5F8xYuAMzJjEYRnxfh7s6RL1CSSefcF2/CWCx5t6VdTF16iN+ycnUrMHTw5uusXjE0F3QBvBYOjNdCqfCTmNDukgemRHWjnawa6GX0JkupCjzM3J/LE8EnDTkDAI0kHu3swlGLZGDSXbuTGlHhBg4LmWw49zwV0oN4s54OM0qJj8FTB1JmyaXcxs6IQVEZwHcHUlBWy1EFtfN9HhC7qHq7oVsk7bpPFSYmag9rh7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA3VVYmvgrhzF1IxYI1MsZkTSVeW5kx98EYsOhYWMQo=;
 b=U3w/oVW39GtjaCWoQ+hThv1zn4OSa8l7A2yZ7ourdLD4Kh/LybUieexJ9MuR2gA7uu1dKL0ktCQEsP8mbJzVTcJ7LS9gMVAzLhv5VQoSDWGX7mOYHkqUTR0INbaK00eU8MXhwkKTD5DI+B1381OATau6pE6aOqXWtM1pQWHheNFXKpDzghS1vQvUaZ2HHWYEENxGSehDw940rwaUDa8A1eq7C2IqzqphKKtIL7DLFFDEZscPV3B8pPFPqvect9e7X1jlBWFuKoZua/manXrNDaCw6zVcb0Et0/hrzPlWn9IFb+dJ4pet/TqpA01Lw8cHgOZ+aYL4FjqGUieUxgum4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA3VVYmvgrhzF1IxYI1MsZkTSVeW5kx98EYsOhYWMQo=;
 b=bdsbLHwSYGYwLc6BQss5iwubvVQJwACQpTdrbt16UxX7FLOM8ARd0dhkfmDWEGnIxKSN6W/Mhh2nosRNZoQ+64bJHhlhUAx+ASRgjY42P8H9mpv4hr2bbuvahPkPX5mNYuwCYF5ylbKTF/ohim+MXev3BgLiuMUCgFUTDjguxdA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB5195.jpnprd01.prod.outlook.com (2603:1096:404:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 01:58:44 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::f84c:9ac2:ee90:c6d4]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::f84c:9ac2:ee90:c6d4%9]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 01:58:44 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Thread-Topic: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Thread-Index: AQHXZsImHcLnKPExrkqddjkUR+DyD6sfRtKA
Date:   Tue, 22 Jun 2021 01:58:44 +0000
Message-ID: <60D143E5.9040204@fujitsu.com>
References: <20210621164851.1808923-1-tytso@mit.edu>
In-Reply-To: <20210621164851.1808923-1-tytso@mit.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c55f6917-1081-43fe-8342-08d93521446f
x-ms-traffictypediagnostic: TY2PR01MB5195:
x-microsoft-antispam-prvs: <TY2PR01MB51951126BD4A04CF0E4A29D5FD099@TY2PR01MB5195.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bld9nTK2N/KPKBEUFS1bTMzcI7AUS+rWn6q4x22oxuJxFiU9UMhhbnYdxl88v8eBesAFRhNYTgMM2VwkOOIrtlhNESja6LJUoyLlyND/JRoKudHjlfEex/C/fWTQhTMH9X/fWxggpSpMtA1AimGvmLxm2NhDp3i599zj95X+H75hvVxbS8ohXV23ptEskA28E2NX6eSNZlhL5jUfb5ls/lXvi3OKKFjw/yelb/ztU4Ve9cIDPZs7w0X7yAwxQ648114SNEPf625ckmj/Q8XPsAdf+7D/myiMFMn5lRwFwEiI/5Nvc6rPwAsr0pVeCh8mdDa9IAxgQu/lz820OFdSpkxZ8mtYb50QNhDETK5/t/2Y/ejsEElupojLzRe1YGQ6K3PyVMeOgPeLtzNm/hqn7eqEz/b/7Jzdetm84oL9Pi1TY8RTjX+vEqZDTrg5VbkSzBAlD0uOkQnpWsPhDip+fbfSFLJEhTmD5d7Ue4CjroFZP7NbqpZXoQ6Ipg15tgwOW7uEui0/Qx1xQLcUW0RsgYBmPQnz5vSfhf8U8Ne3eMlkXh2GAJahy1Q25Nmro5VFwuFA+BOC+BL7sLlwRa8wsjcVyMNzzjTIpHlaC9YBKQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(2906002)(71200400001)(85182001)(38100700002)(26005)(8936002)(8676002)(2616005)(122000001)(83380400001)(6486002)(4326008)(66946007)(5660300002)(33656002)(186003)(6512007)(86362001)(316002)(54906003)(87266011)(6916009)(36756003)(478600001)(64756008)(91956017)(66446008)(6506007)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZUVSQnhBSzRFblp4UFhoL3ZqLysycHlKbGpPVDRTNEZ0dEdjUDdiMC9KbGlX?=
 =?gb2312?B?MGVtRFI3cWovamhIRStXMVdPd2dIanVWMmFFVXdxMzVPSFZNTjRMWGtMOGh1?=
 =?gb2312?B?R0NFNEF0cExHMHVCS3R2RTVMVWNEVG56Y1JzVjhnUDhKSThVdnNkRHVoZS9z?=
 =?gb2312?B?bGM0Nm5XcXJZS3UwSVQ0djFFMlVNQnlzODJzSmQ3TTlRcHhGd1AvTjNXS2lq?=
 =?gb2312?B?ZE5zN3MzQldvakhqVk40UjNFN2YyN2w5OGZJblFOeWlmUGlGWEZrVVZpcGpu?=
 =?gb2312?B?cFhDVndpaTZYR3hWUVd1RkxEL2lwaWlJaUp0ZGJTeVBSRlRFMjB1NlRlMVZV?=
 =?gb2312?B?aFJYSkNqLy9Ld2poUVZZa05BWlE2RkYrN3JKUWhQbk9LRlhsNkFnSXFibHBz?=
 =?gb2312?B?bTYxTHdTRjVYTTZSMkR3VVpla1o5OGhFTTdueklzU2xOc3lCT3RSOExheCtB?=
 =?gb2312?B?SFJuZVE2M3F5dVZTTFo3YkZoaWFHazhNekl0SFdKY0N2U04wWGFGUGF5ZVRx?=
 =?gb2312?B?VkpRTWV0MFU1aGJZb1c4Umh6ZUh3ZXRXdm9DUWtjVzBEWGVrQU13VXBKT2Jx?=
 =?gb2312?B?RW1uSEVsdXJWUU9EdzJLR2Vid0JWUFZUaVd3OHJSUGVyTkN4L0xZQmdwZUxz?=
 =?gb2312?B?VXBDMHZkampWMmdTZnljWkVwZEh1MEpsVTR1bFNHbEhmTWIyaTRFczRwd1FJ?=
 =?gb2312?B?Z1ZtMFJkczVncVkzRU0yRXNIaWxuR0txYUZ3aHpBRGNEL0hBb1ZJWVQ4RU5v?=
 =?gb2312?B?US9PNDlkS0xESU9wRU12QUlBUm0wSGlpbDNtbDZNRmZpeWM2VXNYYWl5RitI?=
 =?gb2312?B?UzhQOURnWjFSY1ZRdmZVbjdxTzFQN0pMbW8wdWk1c0FuUDl6emFuQnVWRVJu?=
 =?gb2312?B?QUpUS3ZJQkUvbm4rVWZHY0p2SUUzNkdJRjRIZUprNCtKSnAvM3UwdHlCR2tX?=
 =?gb2312?B?ZC9yRkxrVXlIdHcxSERQNitYeVJzT01SczUyMWc2cGZxdDR5MEpNMWZwaFcw?=
 =?gb2312?B?b01seFlKcy9uM1EyQXAvWm9nMkYwUWtZeWxGK3pZeTRhTlEwdTVPRVVYcUsz?=
 =?gb2312?B?TGYyK0xyWk1MVDV0RkdwTFFqaGtkbU5yeFdYNnB0cGN5ZkYyS0hvZGJzUncz?=
 =?gb2312?B?My9KU2pBQmdwZGRsRk05ZzJxdDBKRURtVzRyeFNqOTluUG9XMjQzbDVibHF1?=
 =?gb2312?B?OG53M3k3V04ycHFWd010ZDE5bHU4eTFDYUtXbjhXdVFkOWhqM1RIWW9OQ0w1?=
 =?gb2312?B?RkNNSGNoYUNQVE1ObWtva0t5Y0tTRzRJUWVHSllTTnJ6SzdWSHl0MllWUHRq?=
 =?gb2312?B?bGlJbXYyQWkxR2FWRFJwbCtsRjV4VW9kSjlnaUp6WUU3RXlrUi9IT0ZDTy9O?=
 =?gb2312?B?Rndld1JoNm91SWYyOUNxakp5Y3hqWFRBY1BJL3FoaE5rV0tTbi9GOVBXeVEr?=
 =?gb2312?B?aTJGM1JBZ2RRa3FEeDVLdmVIcGNYRzBMcFdiSVZiaytpVEF1TWwxSHQ5aXRi?=
 =?gb2312?B?Rk1DR0lGUVdKUWQ0UWNvenN3UGdORk51aTNja25HK0NtZXZES1FqSzI4RkRt?=
 =?gb2312?B?Y1RDNitOaWVYak90NmZ6OEdiOFNBb1I5b2xtalBzaDFlR1g2MDVpbDVHZmpv?=
 =?gb2312?B?Zk1SMDVZeTRuR1BNSDhqNTlUVmpVNHcwUlVjdG5PWWl6RGE1YW1ROG9oZTVy?=
 =?gb2312?B?OXBiQlo5aWs5NE14OVhCUUhScjI4NWxCd2lFb0U3MFNNZU9mVENGOFhJcyt6?=
 =?gb2312?Q?C/yS25Bp4J0sGEN/X1guFGr/fUr8HZJJV2MLvfR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <6D55A5DD13BF4446A36EB51C818D73F4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f6917-1081-43fe-8342-08d93521446f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 01:58:44.7320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdcegF1g8ISVQmktrfTKsToFq9oftjifkj2zZfoRtx7bbvIUg6KyzrXFYZL5TOZQInPuA1ZErpCQWAyWLkn7PnwFaH1K1/gnXx8nJPuzOAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5195
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMS82LzIyIDA6NDgsIFRoZW9kb3JlIFRzJ28gd3JvdGU6DQo+IGV4dDQvMDQ4IHdpbGwg
ZmFpbCB3aGVuIHJ1bm5pbmcgb24gb2xkZXIga2VybmVscyB0aGF0IGRvbid0IHN1cHBvcnQNCj4g
dGhlIGZpbGVuYW1lIHdpcGUgZmVhdHVyZS4gIFRoZSBqb3VybmFsIGNoZWNrcG9pbnQgaW9jdGwg
aXMgYSByZWxhdGVkDQo+IGZlYXR1cmUsIGFuZCBsYW5kZWQganVzdCBhIGxpdHRsZSBiaXQgYWZ0
ZXIgZmlsZW5hbWUgd2lwZSBmZWF0dXJlLCBzbw0KPiB1c2Ugc3VwcG9ydCBmb3IgdGhlIGpvdXJu
YWwgY2hlY2twb2ludCBpb2N0bCBhcyBhIHByb3h5IGZvciBzdXBwb3J0DQo+IGZvciB0aGUgZmls
ZW5hbWUgd2lwZSBmZWF0dXJlLg0KPiANCj4gV2l0aG91dCB0aGlzIGNoYW5nZSwgdGhpcyB0ZXN0
IHdpbGwgZmFpbCB3aGVuIHRlc2luZyA1LjEwLCA1LjQsIGFuZA0KPiBvdGhlciBMVFMga2VybmVs
cy4NClRoYW5rcy4gV2l0aCB0aGlzIHBhdGNoLCBpdCBmaXggZmFpbHVyZSBvbiBjZW50b3M3Ljkg
YW5kIGNlbnRvczguNC4gQnV0DQpJIGNhbid0IGZpbmQga2VybmVsIGNvbW1pdCBmb3IgZmlsZW5h
bWUgd2lwZSBmZWF0dXJlIGFuZCBqb3VybmFsDQpjaGVja3BvaW50IGlvY3RsLiBDYW4geW91IHBy
b3ZpZGUgdGhlbSBpbiBjb21taXQgbWVzc2FnZT8NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaGVvZG9yZSBUcydvPHR5dHNvQG1pdC5lZHU+DQo+IENjOiBM
ZWFoIFJ1bWFuY2lrPGxlYWgucnVtYW5jaWtAZ21haWwuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9l
eHQ0LzA0OCB8IDggKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZXh0NC8wNDggYi90ZXN0cy9leHQ0LzA0OA0KPiBp
bmRleCA1MTE4OTYxOC4uMzVlNmFhN2YgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2V4dDQvMDQ4DQo+
ICsrKyBiL3Rlc3RzL2V4dDQvMDQ4DQo+IEBAIC05Myw2ICs5MywxNCBAQCBfc2NyYXRjaF9ta2Zz
X3NpemVkICQoKDEyOCAqIDEwMjQgKiAxMDI0KSk+PiAgJHNlcXJlcy5mdWxsIDI+JjENCj4gICAj
IGNyZWF0ZSBzY3JhdGNoIGRpciBmb3IgdGVzdGluZw0KPiAgICMgY3JlYXRlIHNvbWUgZmlsZXMg
d2l0aCBubyBuYW1lIGEgc3Vic3RyIG9mIGFub3RoZXIgbmFtZSBzbyB3ZSBjYW4gZ3JlcCBsYXRl
cg0KPiAgIF9zY3JhdGNoX21vdW50Pj4gICRzZXFyZXMuZnVsbCAyPiYxDQo+ICsNCj4gKyMgVXNl
IHRoZSBwcmVzZW5jZSBvZiB0aGUgam91cm5hbCBjaGVja3BvaW50IGlvY3RsIGFzIGEgcHJveHkg
b2YgZmlsZW5hbWUNCj4gKyMgd2lwZSBiZWluZyBzdXBwb3J0ZWQNCj4gK2lmIHRlc3QgLXggJGhl
cmUvc3JjL2NoZWNrcG9pbnRfam91cm5hbCYmICBcDQo+ICsJISAkaGVyZS9zcmMvY2hlY2twb2lu
dF9qb3VybmFsICRTQ1JBVENIX01OVCAtLWRyeS1ydW4gOyB0aGVuDQo+ICsgICAgX25vdHJ1biAi
ZmlsZW5hbWUgd2lwZSBub3Qgc3VwcG9ydGVkIg0KPiArZmkNCj4gKw0KPiAgIGJsb2Nrc2l6ZT0i
JChfZ2V0X2Jsb2NrX3NpemUgJFNDUkFUQ0hfTU5UKSINCj4gICBta2RpciAkdGVzdGRpcg0KPiAg
IGZpbGVfbnVtPTENCg==
