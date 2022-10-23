Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3FECAAA1
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Oct 2022 06:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJWGsV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Oct 2022 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJWGsU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Oct 2022 02:48:20 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EC774CF5
        for <fstests@vger.kernel.org>; Sat, 22 Oct 2022 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666507700; x=1698043700;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qO013uyRQSJ8WghQmhxu07LVV3FiozKD74p1aaTkB50=;
  b=ivDfxB3MipDq5jEKjyJVdSN3WlbV+hiddjzUkY3Js8JuR92Mewwb6N4E
   UWuy0T9SbUuMQgzhdeHe4UQZ9dfiLPWggBQ3gpCeT24Rhn+ku3noS71qW
   VWcd3GVlKN+48rcMhsIHHi/5YHebvMwfHWXu5GtCZTRjuYsWpoDWqWPZv
   2iqMg3s3f5uoTmevsNQh4BtEU0l1w8rYxDOyjgiuJXPb4ChMq2kVfRv+j
   /3q1V5rR3rw/AUvsyTZWMvKMqDHFgpV7ML7hOt/Z5OG6AtFp/IxAb0Bnv
   bKFIBnBW8A4T5J7vKanpgRINsJ+WsG0JeO0S/vb/CSXthewldUfbBMkdt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="67780747"
X-IronPort-AV: E=Sophos;i="5.95,206,1661785200"; 
   d="scan'208";a="67780747"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 15:48:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6MPfnFWmCR4mxcrrLMT6A1w1C0WPlNuH7OwJHojgKil7ap+U3gVxxCvvuayOIgs3LEevm2r2egVKjQFBSfKMt3il4b4B1a+VKUAvl+K6VTj48UAVO5MVL6cg5oEqD9W7PYLq5AJFnmCXNaiBb8h7J5UUj5uzQmf0tOssaVvjUrTef/QQwxorjNTbi9k1h7ga3gnLItG9RxVVbCoKbjDvSCswlGcnTThd59EspOe+k/N5SdIm8vU9aO6OP6FpxhG4mumVWDg7uesTTQqWQ1pNwZMFZMc5pD1qLuD2mK8xbTA3xaR9JHBO20mblYxLkpnRSH5HPk4/j8pJDr13q8dcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO013uyRQSJ8WghQmhxu07LVV3FiozKD74p1aaTkB50=;
 b=RNJGulq4VyJqajCQlGIJoQqlNEZtT+RRfoviADnB4+88NdEP2QZHpH1wMza9f8tSbAYJSPnQ4xLRTV/8A/vV7UCb1Nh4PVyl8pbgY6Z+NFJ4I144+ynZsdUmVVNwQPaDolKk4ZuJ0hK7pgB8WK1ib0C6Ysl9CFI0+hQrjjmwPbAWhzKHDhmeix+1zfBPCdtUNyDV2IDawl/QL0eewwBZoQRNJjUGhjzbDgpkcnFgI5rX6K1MXvLEtfjJbMCTyaP8P9Sd6ThBMD4EnLmC0LJbUTJu87NgYaELJLJ/gBAcHSKMhwyIwEil2JWPzuhuqyXTGjdNoGqJrk2CbwwGFSpm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB5574.jpnprd01.prod.outlook.com (2603:1096:604:c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 06:48:13 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%9]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 06:48:13 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "zlang@redhat.com" <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH RESEND 1/2] common/dmlogwrites: Extend _log_writes_init() to
 accept the specified size
Thread-Topic: [PATCH RESEND 1/2] common/dmlogwrites: Extend _log_writes_init()
 to accept the specified size
Thread-Index: AQHY5qtrauyWt1QcBk6xetvg+rfetw==
Date:   Sun, 23 Oct 2022 06:48:13 +0000
Message-ID: <20221023064810.847110-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB5574:EE_
x-ms-office365-filtering-correlation-id: 3d6b3624-bff2-45c6-5b35-08dab4c28e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjIHFeuBnxOp8w5hNhzZxtHco8WDqUNST27qToKpXOomRddi/rcBG94McNAqLVJnmujXuLI0b2UFITQeqd/dTbmJxFRhwWeRoFJyo1HtNQbdpdd+14X0JvYhLnjzzmTOikGJg0ZnMikM/pV7o6ocjB4sJa0pdhlZMXCBf+RNQCYdQtlZ/pZGi+VJpR66wVI5JG338sKYtTN8qW15KTIU2D3fBDujlZ+kOEJUiK6fVNL3llSuYhaC6VXlHQDArD3LiVT92mMLL8x7NRc8CMrKykuz0XIyfLlgrIkj5Gy8o0Ziov2lAykK16AxW3O4c/TeJXWH10tfjOhmQB4X12vgxXS7nPVvi0LLBjrSk7v4wNw/3aostO4x6wVdJcUx/1MGHFlQmHhfHpywHlYNFVCl8NUJOouJRoUv3ThcSaSp6+fOLMqKhTXtE2bS6nO3e0+r8STHjWO5yqv0N/B1XJFqOZzduHZmt6o8334PDFixxZUUuBjRgNuCsWl56aZ13wMBCy3DlAMQwUMADqPHIlHZ4NL1vu/HhG21518YMNp6QlHVxs1pLyJ1VhpTVZpqP+dgl86YM+H6CkuJzQIn8iyawZQWGc9C/k5yAYjtkRqa0LtAltwizfFHLbItJYQmvfdzDSqMGThfBjwpxTt9z5nSZmUtEeVTC+Zmr0tqNTl40C6lhGbWq/UqgSen+jBPZvoWSIWv6q4AykO3JHL2YCWn52x1sJfmtcVrLGZA+/RFguNWdzIvBbxqCEj92Xv/j7NyhlRc//o6X0sdHOh/+pR+lGtCbZwTQH1GmBbvZnvPb/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(1590799012)(451199015)(83380400001)(122000001)(71200400001)(38100700002)(82960400001)(6486002)(38070700005)(1580799009)(4744005)(36756003)(66476007)(64756008)(6506007)(76116006)(4326008)(8676002)(66946007)(66446008)(66556008)(5660300002)(478600001)(186003)(2616005)(2906002)(1076003)(91956017)(41300700001)(26005)(54906003)(107886003)(6512007)(85182001)(316002)(110136005)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WW5yd01mRTR3QkhtL0pUeU95WDJEOUxQVmtlR3UvcFpmaFRrS3gzZFkzS0F5?=
 =?gb2312?B?NUhiT0JTblJtcjVkbktGNmN1S1RJaVMvK250YjFUQklVL3ZlWlI1OGhCaGcw?=
 =?gb2312?B?VlU4d1NHUkZxdXk4VVZQa2xRU0ZTUy9tU0tDN1lSUVZ1ZFBXKythOStzZStp?=
 =?gb2312?B?cFRLWjRiVWNyR2p6M3cvbnNMcC9lTGl5cG8yRlRZZ3UxZXcyZFdPWXB3TGJm?=
 =?gb2312?B?Zy9aamRxcDdOcFR2TXVTUDFqd3BSNC9Ybjgrclk5Sm4yc1FlNG5uaEJjUSs1?=
 =?gb2312?B?OVgzT0FJSHBmbXpJbkVpZXFuTy9VTzdtMjNQckZwdUlITWhBOC92YlFTYlhP?=
 =?gb2312?B?WlN6VTVVQmp4N1QwNmJZY3MxYy9hRnB4cTl5UEhxZzBiLzIxSEZLVHFiNENE?=
 =?gb2312?B?TXVDM0Yrci9ITE5xZi91NUdzejZMa1RjcFVvN2NxQlVSMGhPRnJCZ1FiQ0lO?=
 =?gb2312?B?NmtLK0NlY3FRdE9yc0VHYjdxQjJNZGpxb2lzcVBCWGw0Z3BmOTRWMWl4Zmor?=
 =?gb2312?B?Nm4vMGlXR01kS2V0dHZmKytacWd3ZnZ4UndocDZOaVBOZW1obEdSOWR4Qk1S?=
 =?gb2312?B?NE5kbGFGRDJrc0hzc2pvd1ZCTWx6VU1tUkJHc2FCZFhidHU5YWpKQUdxc0cx?=
 =?gb2312?B?ek9vYzFVaVhjZXJLUjlYWWxPbURVREJnVTE1NHRxazJzZFRjR2VvUm5MNy80?=
 =?gb2312?B?d1pTblQwTmtOanZvN25FT0RlNUQ5d0tOaDNZZG8vNmI0elRyZWJXdzFwZSsr?=
 =?gb2312?B?M00yU251a3kxS0lwZ1Fob3B6RTMxNUFwc1Y3ZWNEM0tlbHQrZGVyZC9KQjgz?=
 =?gb2312?B?bWRhUUNudkRoWGJTN3liYnF2cXF0ZGdhOHZtODZhV0JDQm03bzZlU0ZWekp3?=
 =?gb2312?B?dnZFa0hRWTFUT2tyUHl4eDY1ZGVJZE5nWE1IcGZodzNUdDEyZ28rRHVYZzBz?=
 =?gb2312?B?Ulc4QUpPZGVDSWJieWpqSFJqNnc5RHZVN1hWTDJKSFV2WjJPTUVOZW5oMEQ4?=
 =?gb2312?B?VFVTTDA4NDV1SFZ1NWIyTDVKZGhrMHFVaHFVeHV1UytXTXhvV2tSQStOeXA0?=
 =?gb2312?B?Ym05NHFtMFdibktYYk1RenZsNy9sU3VCQ3lET1ByTWIzbTNldVUrV09hUE1J?=
 =?gb2312?B?aDdWZnk4dGRWb2N2REczZzc3bTN2UForejR0bktFUzh4bldlcU5wYklwR1lp?=
 =?gb2312?B?RFNtbEt5elZCN2JGcW5kbzdrckg5Y09XR2F6ZG9DdE5vTVJMcXdVamhvOU9C?=
 =?gb2312?B?YnJsdWtQOUhsSElFNXFlb3c1YklQMWZmdXI2Vm92ZWtEeFVqeUxUNkNzRjd6?=
 =?gb2312?B?ZG9qVGNtNGIyWWhHc01TdnYxQnhVNFRLZ2JlMEFucFpqdlkzb0tyN2Z1TGZw?=
 =?gb2312?B?bmtzc2c2a2kzbWs4clI1S21Pek4yZG1lSS9RMlZCQ1FNc0N5VSt6SDNkdEVy?=
 =?gb2312?B?SHNKWTZ5Mk9FQ0t2WEV6MFJDQXd4dHJESHhkQXdCK1VDZEppc3EvRGxwWitx?=
 =?gb2312?B?NWphT3N0L1VGWVZqUGRvTFZHbTZBNUZvY0JDWnBMYU05MFkwNFRTajJsYzNx?=
 =?gb2312?B?OTBXa05TNHg4dnMxWm1ON1Qyb1RaQmtkMGozc2F0Tk93a1ZDTFoxMWo1UDZI?=
 =?gb2312?B?NGpjNFBBZjZNM2xtbWl4ZzMyWmNtakF6U2FmRzR2YUZFKzU3REd6MzkrNlhz?=
 =?gb2312?B?dlcwYW45YWhaRytZWmZjaGdDWW5aL1hVNWlhbG9BRS83MWtCZmt3QTJkbjRZ?=
 =?gb2312?B?dEt2UkxvZjRkcDZBK2sxQTQwc0ZqUmJaMWRZVnp2YXZmTmNWcjFOdzVxN1ZD?=
 =?gb2312?B?K29UZjYvUDVhWXB6dStiUjgvSkJvMWFmeFdZelRldUdHdFcwMStkSm5VSldJ?=
 =?gb2312?B?SEhDWHRiaURDSlRJWG1KSGZEblBPR1ZDQ1NXMTQ4bFg5eE9UZkRpYzNFU29O?=
 =?gb2312?B?WG04NzFsRllPckMrTE5YeTBpZmhidE15NmNzMzNrZFJqaTFUYVlVZ0FyNDFZ?=
 =?gb2312?B?S3RYSDAyRmNFdXR6cnQyQTBTNzhBZTdpZGdWYld1Tjd3MFFrcmxmb25RUUha?=
 =?gb2312?B?Y3ZMeEtIYkJ4NmxwRUxVNm1mczRNZVpabUwxV0hKZno5dHJPYWpqM3pRVS9h?=
 =?gb2312?B?Y2hyMHhMNzhsUHRGUVVvalN1Rno4OHB2TzZRVGxPYjllMGhwODRmcVBHdWxF?=
 =?gb2312?B?ZkE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6b3624-bff2-45c6-5b35-08dab4c28e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 06:48:13.3309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8NUAka1uMy/0BRLYYKUQFpxcYnqHRv7Qj2UQd4+TBKSPmJw9pZM8SaDnVXbnHvDd1TBjtpx64FNHxziN2C9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5574
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SXQgaXMgdW5uZWNzc2FyeSB0byBhbHdheXMgY3JlYXRlIGEgbG9nLXdyaXRlcyBkZXZpY2UgYmFz
ZWQgb24NCnRoZSBzaXplIG9mIHRoZSBlbnRpcmUgdW5kZXJseWluZyBkZXZpY2UuDQoNClNpZ25l
ZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQotLS0NCiBjb21tb24v
ZG1sb2d3cml0ZXMgfCAxMiArKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2NvbW1vbi9kbWxvZ3dyaXRl
cyBiL2NvbW1vbi9kbWxvZ3dyaXRlcw0KaW5kZXggOWZhMWM5NzcuLmQ3YjIzY2VjIDEwMDY0NA0K
LS0tIGEvY29tbW9uL2RtbG9nd3JpdGVzDQorKysgYi9jb21tb24vZG1sb2d3cml0ZXMNCkBAIC02
MSwxMiArNjEsMjAgQEAgX3JlcXVpcmVfbG9nX3dyaXRlc19kYXhfbW91bnRvcHQoKQ0KIA0KIF9s
b2dfd3JpdGVzX2luaXQoKQ0KIHsNCi0JYmxrZGV2PSQxDQorCWxvY2FsIGJsa2Rldj0kMQ0KKwls
b2NhbCByYW5nZT0kMg0KKwlsb2NhbCBCTEtfREVWX1NJWkUNCiANCiAJWyAteiAiJGJsa2RldiIg
XSAmJiBfZmFpbCBcDQogCSJibG9jayBkZXYgbXVzdCBiZSBzcGVjaWZpZWQgZm9yIF9sb2dfd3Jp
dGVzX2luaXQiDQogDQotCWxvY2FsIEJMS19ERVZfU0laRT1gYmxvY2tkZXYgLS1nZXRzeiAkYmxr
ZGV2YA0KKwlpZiBbIC16ICIkcmFuZ2UiIF07IHRoZW4NCisJCUJMS19ERVZfU0laRT1gYmxvY2tk
ZXYgLS1nZXRzeiAkYmxrZGV2YA0KKwllbHNlDQorCQlsb2NhbCBibGtzej1gYmxvY2tkZXYgLS1n
ZXRzcyAkYmxrZGV2YA0KKwkJQkxLX0RFVl9TSVpFPSQoKHJhbmdlIC8gYmxrc3opKQ0KKwlmaQ0K
Kw0KIAlMT0dXUklURVNfTkFNRT1sb2d3cml0ZXMtdGVzdA0KIAlMT0dXUklURVNfRE1ERVY9L2Rl
di9tYXBwZXIvJExPR1dSSVRFU19OQU1FDQogCUxPR1dSSVRFU19UQUJMRT0iMCAkQkxLX0RFVl9T
SVpFIGxvZy13cml0ZXMgJGJsa2RldiAkTE9HV1JJVEVTX0RFViINCi0tIA0KMi4zNC4xDQo=
