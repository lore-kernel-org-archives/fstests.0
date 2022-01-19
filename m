Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878CFC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 07:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351960AbiASHTz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Jan 2022 02:19:55 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:40231 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239455AbiASHTy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jan 2022 02:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642576794; x=1674112794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DlPuc1P9rWJ/FmqMor2ZSJHNLYJjtZc1HaFsyImyIxA=;
  b=NMyH9z7VhwqZ0gZCGXE4YBU2N2ytBb3JJgHyyAX18H7AAFHIC0B4obsd
   SqnYaGd6gNKAdx//rD/etxOvPJcnbO+ff+nqtIaWfYFa3JKNxsNzCbwg+
   vMwcJPf6TZqH9iBUK5P5IIjyygDYUuo2DT2XApuMF55j6kckJrFK+zvR4
   Lz5i164iUdmmJbJorXdYBYxKRkuZnW+tvnxfQKgYS7gOM2jHmOh6IPxpY
   DFZ0POEPqgxt70kfOZHna7Fw69m5Wiy/IaUCsU/xQwGKsh0zOKza6ZCHc
   p51z+OKgXL6IRDXpdZPBlvGP9EmwQozdPMP03qT8UVphBH6FApQ0o5IA6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="47965270"
X-IronPort-AV: E=Sophos;i="5.88,299,1635174000"; 
   d="scan'208";a="47965270"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 16:19:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzc1p0oPAaC6+I1XHgRb0AV2eZRsMlihDa4xlc/JyHpwYtSP6NsoTxdG+oRjMRvsZEskUthwBbcLozdU2CHRBcAt8i/tRdg8L6w/z5g2lVyyFPIz3xBhih5MGsDahHXOVt55BGvjtY9YlTlCZXqUh+hsAvY0sF2gC9mcYo7f7jPGRXgcvXRhDk2hB94G/3CGfb/8YM4rtwdMymWorAHSJBZBgAi5RV33y3YpSSHnHwQI1EEl0bwn0hrW+z2bA3Dv8NWksPe+dHiS7TiQ7uiKwk3CwBVRVlbB84abPzlZrD7KaYtt3StFZ5dLL4B/ZuXcMYI4avhuu1yOh1yRD4dFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlPuc1P9rWJ/FmqMor2ZSJHNLYJjtZc1HaFsyImyIxA=;
 b=KbJ//hqE8Pi1YQeyls6CapAJSHBqf/AZ9ubpAFzmlTcUOIx32cZW4PoZn2eQroq+uFEuC9L6tiDIgkQBSBP9yQWbbwdP1dOxnuljZLiI5GV8x/ElvW8AguohlwMUQjfXGsmuEQmAHSgHn7dDY0LwZW5zRFh+AlsCJp+xf17B1SM94bZFr6IH51ETYf49cNFU3vh7l9W7Mk1LVrIQfxh1adBc8Ue6tvPpAOzw1VDdEdGyToakEM93pcfrH6fqrhKLIiquEd04ipK5ODMpt4PvlDVTMWiXt2rT+Vu8w1FEcbwlWaC2ns7/xJONecQKoYSJFu2Rq0eq9lzmvRKGua/tiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlPuc1P9rWJ/FmqMor2ZSJHNLYJjtZc1HaFsyImyIxA=;
 b=ipnIFI0GeyBJFifsHzMFDsmACiANNfyIpcJSjJdzW2kjsapu5xBccDzCX1rpBwbZhE0VUNAXjSwt6MIsdhhwtcJb1nl4ZA2CevMmahS+3quC/TRAMFJQGuY8VOn6gJA9yED75YImZbVMN6JgRxuypXzuQoSCbujhVYfmM3gvJeU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2476.jpnprd01.prod.outlook.com (2603:1096:404:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 07:19:48 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 07:19:48 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "morgan@kernel.org" <morgan@kernel.org>
CC:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Topic: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Index: AQHYC3T1GUs88bXDK0iuG+0P5NW4eaxoEG4AgAADSICAABP+AIAAGcGAgACPp7qAAQ/kAIAAEkYA
Date:   Wed, 19 Jan 2022 07:19:48 +0000
Message-ID: <61E7BBD6.3010706@fujitsu.com>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
        <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
        <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
 <87r195i1lq.fsf@oldenburg.str.redhat.com> <61E7AC82.8080801@fujitsu.com>
In-Reply-To: <61E7AC82.8080801@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5575eea-0849-4800-6d46-08d9db1c13d5
x-ms-traffictypediagnostic: TY2PR01MB2476:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2476082C2058FE90AD30ABCDFD599@TY2PR01MB2476.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4L+tuJgOe65iCmeTs9mksGbofbG3XpKPDmPKqlj1o+sfLRPXXmiSNp1l4BOY70w5+emB/7I48zm7olhulMSEaeUnZRTFh2JymTjKhd3QUKlXSAyJ9fOKAa1qBZ1VZ23njpqoOaX5yWitglcAKp31BboZ7sRfO2tKEJt7vlaUf7k2ApLQH11TffHXNJC6TwQWqBxBvTBx0oGQE+OggKcj+WuS0gV3qHoPv3ht8u7Xd9rGGKZAPFwUQbw0DoGN/u17tc3lyaLPAR7yOYepe2LMXsIgv/huH6iSc002BU/WnNxRtzHMn5tl4USd7olPXh5I7PmcOIPhomPWqixPrQmzWOp/i2faDf2VcZ/lhGn4WlssrTgbipDyOjFidWNKr7AsKBvssXxACBp71KEeWrb1E1Ox9/vuS7KHQQ8T4A4PKuq0um0ZZX+jIcFVIjqTNgMfTBeCBem1hODRNKUAi+EtWMbBS5tSWOXENHQ27SlxtHNPH9FWpemrnk+AbosqFapa9RCPygCmQPBhOq4QzAGhy9vti6gNjZlVeOuwdYjNrpIy8ydoEK/svU792FSOCXyImfMOaSFHM/4mgcsea3s1czbfNY9Y+ad2iy4zpSjUz/sOZZLcnTaF6HLVRHvXb4lUTv0vj/nNYLdRAmgZtxudpKesZFYMVSmpIyQzPSJatYzmQ4XdUOvqMskQciZRbGC/iQb2Osvv/NVbHoa77I4N5p6NFG25ZFGa6QD8QwFNTfrD/HIlpnTRU+lEnuloN4Z02VzR9Bos5Gpq54tR6jl05AMUl4gZZkdguysOacgEpWA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(5660300002)(316002)(87266011)(2616005)(54906003)(66946007)(71200400001)(6916009)(2906002)(26005)(64756008)(82960400001)(66476007)(91956017)(76116006)(6512007)(38070700005)(66446008)(66556008)(33656002)(6486002)(508600001)(122000001)(38100700002)(8676002)(8936002)(36756003)(86362001)(85182001)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z0VranJsL2NKa2tBWFNIaU9IRXMwSm9sVzU5ZkJCZExUZWdwMldZWEk4aGZV?=
 =?gb2312?B?UTI0dmNxMzZNREVQenJuV1h1RjNZQ2xDbFYyKzBDek55MS9xWC9LMnhMeXNX?=
 =?gb2312?B?K0lhempxbVJZTVBuT2pwZzNGZDRCVm9QWXcva1VNNURmaUNMcTdaeUxCd0RP?=
 =?gb2312?B?d0xuUEU0UlNJMDJqUWZ6UTMvTHcvbnJYZVRxcEFIZHNvTitWMjg3V0xVTU40?=
 =?gb2312?B?SWFQb2FidCtLTFZjdFRxWlBJR0k2amNSZXRqRjY1NzZLbEQrYzgwekhkK3R1?=
 =?gb2312?B?bEZzQkJsTlRveGtXQzNxdVF2T2NsaVMxOUoxNTJCbk94TjErRXQ2ZnBxRnVW?=
 =?gb2312?B?SGFuSHVObEVkWk5RZlRVWXFERGRJSjFaUC9xVGFaQkhzQ3dZK0lORnpncjdl?=
 =?gb2312?B?RS9tZkJWUU9DY0ZweE9JUURnL1RYYkEvL1JxcUlYRW5USEJhcVFSS3o0RWN6?=
 =?gb2312?B?TFdFa1RJeWF0ZENzcW5YK29zVVpmTnEwZ1diSFgvM2haWWJTUTR2UEFnUStv?=
 =?gb2312?B?aTlRdWltbFFDYUtndlVpNVpGNXhpbHFtT2NSYzRCVHFEakx1VFVDOXY2MURH?=
 =?gb2312?B?SjhESkk0VElDR3pBT0FvVlNSbHI0cFhNdXJFdVp2MHRwZDRQKy9oMm9jSEds?=
 =?gb2312?B?S3NWdmswMzNieUoxeGFLMWwxYkZEd2ZmN3pucUF3c1VXNXNXaGJka1B4QWdx?=
 =?gb2312?B?Z24vYnR1RWpLTElqUWhHdllmQWdiMFhsOXhOY1p3Q3FjZWhaelhiZUpla0ZD?=
 =?gb2312?B?VDVJa0tQeHo5bW5wRzR0aFA5N3lVczE0ZG8wbUl6NHQwQlltbVRZQVNDcFhC?=
 =?gb2312?B?WTU5TVNFZ2ppbDRpSndNWmJmenlidWdZbC9ESXRZc3p3c1BRMm80MHk5N080?=
 =?gb2312?B?Wno4cCtsUkNGbkYxcGs4ai9MWHpPSEJrcE1sWmZVYWZwaUg5RTZ6dTQ4ay9U?=
 =?gb2312?B?aEtNeVdYYWFLeUZEVXl4NE8vbkpLeXVhS2huL05wcWhVQzA1NjdLSHRMLzZT?=
 =?gb2312?B?K2NHZWEybjEzaGFCVmllQ1BhcW1MSkVMVEZUbWhBc3lYb3l2emgzRmI1c0M0?=
 =?gb2312?B?RTEzaGtiY1RSREFONkYwekRGRjVzWXg3UEEvRG9CYWx3OEt1bTJOSEtVNDI5?=
 =?gb2312?B?TFVsMWo2Q1FEWVhDdG9hTDhTM29tdE1nM1pNNEpBNktvR1YxRDEwWFFQcXdY?=
 =?gb2312?B?WC8yeERaOThuaE5ROVNPZzhUOHA5QWJ5TE5ZaXhkVUN2bndJWEhMdElHbGxw?=
 =?gb2312?B?d21RZFBRbHg2bHdWNXM5WXJRZE4zYlBRZkZtTnhVbUdmN3FhdXMrZ2IyVjgy?=
 =?gb2312?B?bGNRM25QQXpqVGpwd1kzMW1HT2xWWDFlTVl3VnpjdXdHR3FJV3A4c2g1LzhL?=
 =?gb2312?B?T3RkUS9UOEdKSHVIYnhVbTBMaVY4QzFobnlWSlhkSC9ORHk3MHZZdzBRdXFQ?=
 =?gb2312?B?SzFqOHMwVFlpelhLUzE4M09UTFFkUWswMnQ4RC9pdG5rVVJnRmxpWGJ3cHRl?=
 =?gb2312?B?eEQxMWhpMG5mRWVsQzBudkJCT3FNRHgzQXRWZ0dYR1I5V0RsUWowNkZYM0ov?=
 =?gb2312?B?ZEdhUnlwczJHNWZlN2w2MmJMUkN6Y0V4Z3JsbXA5Z2E3bGdZekNBcHpLQ29J?=
 =?gb2312?B?bnRCTmpGR2JpeWhmTW9CS25NNkx4K3h4bnRHcXVVcERXUFhrVmVsVTJkcGRH?=
 =?gb2312?B?SXB6bXJRYm1Fb0xJV1JNSVhtaVlOZGZyeEtmZGFVditTenVRVVJoNjBNcENy?=
 =?gb2312?B?VmtpdW93MmRkdkdoRy91eGViMno4ZEdrYU5vbENFblF4b2pINU4vMkVxWmNr?=
 =?gb2312?B?Z0VHRlN6cTJOUXhoM2JzaGR0Z2dpVmthZkVORTFKN0drZEJvVjMyL2FnTjl0?=
 =?gb2312?B?NFF5cldpMmVVS2F0Ti8rSWZEWUJzQmFzRndrNEtxN1F6QWw2VTVYWWkyaTF3?=
 =?gb2312?B?Rlk1ckMybkdaSUwwZWI1dkJpa0JUYkJmRGhMazcwd04vRmZKYjROOEpBdUlh?=
 =?gb2312?B?bkVEdHJ4RFpjemR2ZnZEMldzN2htc3ZKYm5FTDFIVytOeVZRY0QyR2Ewc1k2?=
 =?gb2312?B?V0p0WDVPZXFRaVJZRjZ0U1p0US8wU2Nxb1hsNW8rTkplaGtRdldTcTU3NkY4?=
 =?gb2312?B?RXBrMVVzUnFXSGFvRk1MQldnMVhLUTFHS29HS3BHc2VNVTBGbTV6ZkQ1VnNp?=
 =?gb2312?B?MWRvQ2VReWVTbDUxMjZqbGdzVzVuRHZlcTdWUEN1RzVCdWZobTd4RWptME9J?=
 =?gb2312?Q?LIcZCPwkRc8PO5csJXz8qPccdPKaVwIAPne33czpbQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <374BE740E458FF4484510E868360A4D3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5575eea-0849-4800-6d46-08d9db1c13d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 07:19:48.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUVP8S5SMmpgN8uWdXhd573ZWoOE24ZlYcq8BNIz++hJFRF5veSp5w1zy3nnBfvfezEE0en5eGcOsDjyAL+xLgYcMu7VgrqvVhs7PM/hYk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2476
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgQW5kcmV3DQoNCmVycm5vIGRvZXNuJ3QgYmUgaW5pdGlhbGl6ZWQgdG8gMCB3aGVuIGMgcHJv
Z3JhbSBsaW5rIHdpdGggbGNhcCBzaW5jZQ0KbGliY2FwLTIuMzAgKGNvbW1pdCBmMWY2MmE3NDhk
N2MgUmVmYWN0b3IgdGhlIHdheSB3ZSBkbyB0aGUgcHN4IGxpbmthZ2UNCmluIGxpYmNhcCBpbnRy
b2R1Y2VkIHRoaXMgYnVnLikNCg0KVGhlIGMgZXhhbXBsZSBjb2RlIGFzIGJlbG93Og0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KI2luY2x1ZGUgPHN0ZGlvLmg+
DQojaW5jbHVkZSA8ZXJybm8uaD4NCg0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0K
ew0KICAgICAgICBwcmludGYoImVycm5vICVkXG4iLCBlcnJubyk7DQogICAgICAgIHJldHVybiAw
Ow0KfQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCiNnY2MgdGVz
dC5jIC1sY2FwIC1vIHRlc3QNCiMuL3Rlc3QNCmVycm5vIDENCg0KQmVzdCBSZWdhcmRzDQpZYW5n
IFh1DQo+IG9uIDIwMjIvMS8xOCAyMjowMiwgRmxvcmlhbiBXZWltZXIgd3JvdGU6DQo+PiAqIHh1
eWFuZzIwMTguank6DQo+Pg0KPj4+IG9uIDIwMjIvMS8xOCAxMTo1NiwgVGhlb2RvcmUgVHMnbyB3
cm90ZToNCj4+Pj4gT24gVHVlLCBKYW4gMTgsIDIwMjIgYXQgMDI6NDM6MjZBTSArMDAwMCwgeHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbSB3cm90ZToNCj4+Pj4+PiBZb3UncmUgcmlnaHQgb2YgY291
cnNlLCBidXQgb3V0IG9mIGN1cmlvc2l0eSwgd2hpY2ggQyBsaWJyYXJ5IGFyZSB5b3UNCj4+Pj4+
PiB1c2luZz8NCj4+Pj4+IEkgdXNlIGdsaWJjLTIuMzQuDQo+Pj4+DQo+Pj4+IEhtbSwgb2suICBJ
J20gdXNpbmcgZ2xpYmMgMi4zMSwgYW5kIGluIHRoaXMgcGFydGljdWxhciBwcm9ncmFtLCBlcnJu
bw0KPj4+PiBzaG91bGRuJ3QgaGF2ZSBiZWVuIHNldCBieSBhbnkgcHJpb3Igc3lzdGVtIGNhbGwu
ICBJJ20gZ3Vlc3NpbmcgbWF5YmUNCj4+Pj4gaXQgd2FzIHNvbWV0aGluZyBpbiBjcnQwIHdoaWNo
IGVuZGVkIHVwIHNldHRpbmcgZXJybm8/DQo+Pj4gSXQgbWF5YmUgYSBnbGliYyBidWcuDQo+Pj4g
SSBjYyBnbGliYyBtYWlsaW5nIGxpc3QgYW5kIHNlZSB3aGV0aGVyIHRoZXkgaGF2ZSBtZXQgdGhp
cyBwcm9ibGVtLg0KPj4+DQo+Pj4gQEZsb3JpYW4NCj4+Pg0KPj4+IE5vdywgSSB1c2UgZ2xpYmMt
Mi4zNCBhbmQgcnVuIHRoZSBmb2xsb3dpbmcgcHJvZ3JhbVsxXSBidXQgdGhlIGVycm5vIGlzDQo+
Pj4gbm90IDAgaW4gdGhlIGJlZ2lubmluZy4gU28gaXMgdGhpcyBhIGtub3duIGJ1ZyBvbiBnbGli
Yy0yLjM0KFRoZW9kb3JlDQo+Pj4gZG9lc24ndCBtZWV0IHRoaXMgcHJvYmxlbSBvbiBnbGljYi0y
LjMxKT8NCj4+Pg0KPj4+IFsxXWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9mcy94ZnMv
eGZzdGVzdHMtZGV2LmdpdC90cmVlL3NyYy9leHQ0X3Jlc2l6ZS5jDQo+Pg0KPj4gSSdtIG5vdCBh
d2FyZSBvZiB0aGlzIGlzc3VlLiAgQ291bGQgeW91IHJ1biBzdHJhY2Ugb3Igc3RyYWNlIC1rIHRv
IHNlZQ0KPj4gd2hlcmUgdGhlIGZhaWxpbmcgc3lzdGVtIGNhbGwgaXMgY29taW5nIGZyb20/ICBU
aGFua3MuDQo+IEV2ZW4gYmVmb3JlIG9wZW4gY2FsbCwgZXJybm8gaXMgYWxzbyAxLg0KPiANCj4g
VGhlIHN0cmFjZSBvdXRwdXQgc2VlIGF0dGFjaG1lbnQuDQo+IA0KPiBJIGZvdW5kIHRoZSBmb2xs
b3dpbmcgZGlmZmVyZW5jZShjb21wYXJlIHdpdGggZ2xpYmMtMi4yOCwgc2VhcmNoICdlcnInDQo+
IGtleXdvcmRzKQ0KPiANCj4gYmFkKGdsaWJjLTIuMzQpOg0KPiANCj4gbWFwKE5VTEwsIDgxOTIs
IFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkN
Cj4gPSAweDdmZGY4MTVhMzAwMA0KPiAgID4gIC91c3IvbGliNjQvbGQtbGludXgteDg2LTY0LnNv
LjIoX19tbWFwKzB4MjYpIFsweDIxYzU2XQ0KPiAgID4gIC91c3IvbGliNjQvbGQtbGludXgteDg2
LTY0LnNvLjIocnRsZF9tYWxsb2MrMHhhMCkgWzB4MWRjNTBdDQo+ICAgPiAgL3Vzci9saWI2NC9s
ZC1saW51eC14ODYtNjQuc28uMihfZGxfY2hlY2tfbWFwX3ZlcnNpb25zKzB4NGVjKSBbMHgxMjFm
Y10NCj4gICA+ICAvdXNyL2xpYjY0L2xkLWxpbnV4LXg4Ni02NC5zby4yKF9kbF9jaGVja19hbGxf
dmVyc2lvbnMrMHgzZSkgWzB4MTI0ZGVdDQo+ICAgPiAgL3Vzci9saWI2NC9sZC1saW51eC14ODYt
NjQuc28uMih2ZXJzaW9uX2NoZWNrX2RvaXQrMHgxYikgWzB4MWNhYl0NCj4gICA+ICAvdXNyL2xp
YjY0L2xkLWxpbnV4LXg4Ni02NC5zby4yKF9kbF9yZWNlaXZlX2Vycm9yKzB4MzEpIFsweDFlODEx
XQ0KPiAgID4gIC91c3IvbGliNjQvbGQtbGludXgteDg2LTY0LnNvLjIoZGxfbWFpbisweDFlNDYp
IFsweDQ0MTZdDQo+ICAgPiAgL3Vzci9saWI2NC9sZC1saW51eC14ODYtNjQuc28uMihfZGxfc3lz
ZGVwX3N0YXJ0KzB4M2Y2KSBbMHgxZDY5Nl0NCj4gICA+ICAvdXNyL2xpYjY0L2xkLWxpbnV4LXg4
Ni02NC5zby4yKF9kbF9zdGFydCsweDIxNykgWzB4MjA5N10NCj4gICA+ICAvdXNyL2xpYjY0L2xk
LWxpbnV4LXg4Ni02NC5zby4yKF9zdGFydCsweDcpIFsweDEwOTddDQo+ICAgPiAgbm8gbWF0Y2hp
bmcgYWRkcmVzcyByYW5nZQ0KPiBhcmNoX3ByY3RsKEFSQ0hfU0VUX0ZTLCAweDdmZGY4MTVhNDQ4
MCkgPSAwDQo+IA0KPiBnb29kKGdsaWJjLTIuMjgpOg0KPiANCj4gbWFwKE5VTEwsIDEyMjg4LCBQ
Uk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApDQo+
ID0gMHg3ZmViZDYyOGIwMDANCj4gICA+ICAvdXNyL2xpYjY0L2xkLTIuMjguc28oX19tbWFwKzB4
NDcpIFsweDFjMzc3XQ0KPiAgID4gIC91c3IvbGliNjQvbGQtMi4yOC5zbyhtYWxsb2MrMHg4YSkg
WzB4MWE5NGFdDQo+ICAgPiAgL3Vzci9saWI2NC9sZC0yLjI4LnNvKF9kbF9hbGxvY2F0ZV90bHNf
c3RvcmFnZSsweDIzKSBbMHgxMmFjM10NCj4gICA+ICAvdXNyL2xpYjY0L2xkLTIuMjguc28oaW5p
dF90bHMrMHhhNSkgWzB4MWRhNV0NCj4gICA+ICAvdXNyL2xpYjY0L2xkLTIuMjguc28oZGxfbWFp
bisweDJjNmQpIFsweDUxZWRdDQo+ICAgPiAgL3Vzci9saWI2NC9sZC0yLjI4LnNvKF9kbF9zeXNk
ZXBfc3RhcnQrMHg0OGUpIFsweDFhMTRlXQ0KPiAgID4gIC91c3IvbGliNjQvbGQtMi4yOC5zbyhf
ZGxfc3RhcnQrMHgyNzUpIFsweDIxMzVdDQo+ICAgPiAgL3Vzci9saWI2NC9sZC0yLjI4LnNvKF9z
dGFydCsweDcpIFsweDEwODddDQo+ICAgPiAgTm8gRFdBUkYgaW5mb3JtYXRpb24gZm91bmQNCj4g
YXJjaF9wcmN0bChBUkNIX1NFVF9GUywgMHg3ZmViZDYyOGI3NDApID0gMA0KPiANCj4gQWxzbyBp
ZiB1c2UgZ2NjIHRvIGNvbXBpbGUgdGhpcyBjIHByb2dyYW0gZGlyZWN0bHkgaW5zdGVhZCBvZiB1
c2luZyBtYWtlDQo+IGluIHhmc3Rlc3RzIHRlc3RzdWl0ZSwgIHRoZSBlcnJubyB2YWx1ZSBpcyBu
b3JtYWwoMCkuDQo+IA0KPiBBZnRlciB0cmllZCwgSSBmb3VuZCBpZiB1c2luZyB0aGUgZm9sbG93
aW5nIGNvbW1hbmQsIGVycm5vIGlzIHN0aWxsIDANCj4gZ2NjIGV4dDRfcmVzaXplLmMgLWcgLU8y
ICAtRF9HTlVfU09VUkNFICAgLURfRklMRV9PRkZTRVRfQklUUz02NA0KPiAtZnVuc2lnbmVkLWNo
YXIgLWZuby1zdHJpY3QtYWxpYXNpbmcgIC1XYWxsIC1vIGV4dDRfcmVzaXplDQo+IA0KPiBCdXQg
aWYgSSB1c2VkIGxpbmsgd2l0aCBsY2FwLCB0aGVuIGVycm5vIGJlY29tZXMgMSBpbiB0aGUgYmVn
aW5uaW5nLg0KPiANCj4gRXZlbiBJIHVzZSBsYXN0ZXN0IHVwc3RyZWFtIGxpYmNhcCwgdGhpcyBw
cm9ibGVtIHN0aWxsIG9jY3Vycy4NCj4gDQo+IEkgYW0gc3RpbGwgbG9va2luZyBpbnRvIGl0IC4N
Cj4gDQo+IEJlc3QgUmVnYXJkcw0KPiBZYW5nIFh1DQo+IA0KPj4NCj4+IEZsb3JpYW4NCj4+DQo+
IA0K
