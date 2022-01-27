Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CCCC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jan 2022 03:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiA0DJ4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Jan 2022 22:09:56 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:19378 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbiA0DJz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jan 2022 22:09:55 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 22:09:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643252996; x=1674788996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vjDAkb+IzStBkXoFbw99s8soZtBCvFoI0GrWFipqt3k=;
  b=O4A2tZrERz8+zrxpY7qztVlNgavE35aAd9ESg+tpVFl0V52V+bDiAEur
   /KII75SbOq272t/vBSF6ocQcyRKhC0qc5uvTZZKUZ675DCCJEjtOgrcAO
   Mkp63IjjNg7MOr27OzHD9w+pF2osFncajzcL6QDGYmgYrbgJ6iPEMX+St
   VL/l2AtJN6DnxEPrRHd6GFOegHd7/j3Sal8x7zBR5W5vrZpBdIsDvKDOH
   bRLYsLrMdv+gPI28Jn5ueutupYl88RKGwcwxKLRstoQY82kOVG4bq4vPU
   38DOK892G8IGqXNgsB/Xkxcm2SSAc9o4WZC/O6j0CvwmK/rN2TSOlQt5X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="56368108"
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000"; 
   d="scan'208";a="56368108"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 12:02:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/GdBsOgmhFdpQdHFvyGt8SwzsD9mHFIG2/GuLZ/iRW5umA4Xqh0GKFG+HJnZKjLCpmRh3DTQpdzM0UvJgBvSG/xA+dw3e8zRC/jO2yctMyllXBtybEV54hgo8sQDBiwfe+x0ShISDR6LgzC4KRBZaDml6lSfeevm4BRc6jHXJCJltsXiaguXjbkJ2ZCXVCDqAkd7TxzaNhLcXjJHBMVpOWQuL/A220DFrn15rJZeqKPMfIKuJft7cwkZwXnowtYRB1GWWgFP5qxdVWoC0YvkbT/9R7wNrduLkad72G5VN/cTutVKDamPlSQO/gL5Km1QWnnyNL9K66uu+OhYl9i4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjDAkb+IzStBkXoFbw99s8soZtBCvFoI0GrWFipqt3k=;
 b=WnkO2jyoQNI4NEKbLK0lddCvkOaCjVQGngetlrtf0h0U9mb7FH/KHGrDpSxLxiaTrlEQtiG3RxOzPLvvlv1apjIDmUYTWLTHmJ7oXbs+CFj9XVcFBynHY4hkjtej6irys9v4BEZmV3QFRYld9D6/2/RVHZ1MljqnZdbGUnLhflrVCqDMl+sPFP+z1GtTAGOKXa3hiKDnkGFq12j4pIFCp98uAA481eSLYFgcCk99DJ/D6eqV/mahTUGQATK7mGGbwHeZF3N0TpiGe0K11FrBZjmsgdJix3s7vpMHw1QW7c/PfKE5okY+Tfmbqch1tAXslT5xrv4ZHh9TjJOM8nbafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjDAkb+IzStBkXoFbw99s8soZtBCvFoI0GrWFipqt3k=;
 b=TsM2CVFrhL72epadUg5Zk/WsCc3FhCk01zcjfDbkPiZS34nlZhDDPi7eMrZdW/Jh+qzXGtAiCanZ3w0CfX8uvg2BaxvGE/LnQ78sinSZpgY+A49gNaL8Q6Bg7Hb19mlrc2ue3PUhoKfx8Xt2l8qR/+OzJ1iYIflMDaL6e2IHRTk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4729.jpnprd01.prod.outlook.com (2603:1096:404:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 27 Jan
 2022 03:02:36 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 03:02:36 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Eryu Guan <guan@eryu.me>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr
 corrupted
Thread-Topic: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr
 corrupted
Thread-Index: AQHYC3tRbuMdH0UVeE6ebS0mJCLmL6xwnfGAgAWf9AA=
Date:   Thu, 27 Jan 2022 03:02:36 +0000
Message-ID: <61F20B74.1090008@fujitsu.com>
References: <20211126232817.GA266000@magnolia>
 <1642407736-3898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ye1TiTOUdGoemiV9@desktop>
In-Reply-To: <Ye1TiTOUdGoemiV9@desktop>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8f528a9-d06a-4966-433f-08d9e14178fd
x-ms-traffictypediagnostic: TY2PR01MB4729:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4729739B8E613026D39162D9FD219@TY2PR01MB4729.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oF/pyagPvlb/kjGorvuA6+j1fZxlnEYkx7ak6DSwBmLdZGGobR7s4Cc77eB534bigB/OOfcFJSTmnU4Bg5AApPDiJ0XnBsLQpC5J1WA/R5FAj6L1F+RRGCaz3b1SaCWezOPLKz6EbgdnQ+BFwKMPyzz/nMeaJYFQBOXi68GwWo+NWt29HUGDAwVPmIDGJHdwGYrzwCMVy3NZrTIGphvdWKISY66Ekqn+3aelsKsYtFSyqY1P2HCZrhs3NjUbxVtV5FN2ZR/sWvMv/ICFOuuodaqP2Ls45G5CcmljvNYH/6lxx9WyGX80SH2sQ585+WH/FIysrSswTeAq9JlObL2Ujwj0deidWJo/jPCBurOTtxDSzUvFeOl2ruSXAepqnXJ2Km+pMkVMZd/AewWO38H+NiWCZjn+r75nCabSeLwi0piW1xdtXZCZCtxJz4RNkDg3SBMgCPIx0tRm4svL00kC7zdrOUUOeOGOpoTUL0liL6oyffdLretNYVjGqWZFXvJoTvLSJN/dS5Em7ik4tTlvcIUYvotA7LlWLaZpJHAihtr+fYKi620XMNLGofq3ViEt2pmu/TBViyuIL7ZAJQUKeB7jBzcRPeJDoDcNDDNhZaEb6pChjCU6bguvrCs98281+zgimoZbFmbTW22tRFXdkAAqyo81LMdHoNY8gZzFY/l0lUrJTjuXxFo/HurJXLWSJouGdOhF2oX5VWGp8pQm2/hKkSEbjmMs3Qy8dqdm2lo5vlSbNT33imBcnWPMCdwkzcXCAB0VJR95pkJQsQloD58t5Zc/x53TVir8Gl7DjAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(76116006)(6512007)(82960400001)(186003)(4326008)(508600001)(38070700005)(122000001)(38100700002)(91956017)(71200400001)(33656002)(85182001)(36756003)(2906002)(2616005)(6506007)(87266011)(8936002)(8676002)(64756008)(86362001)(316002)(66446008)(5660300002)(66476007)(66556008)(54906003)(6486002)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K3I0ZkxCYmE1N3M5L0ZSVU9aQm5xN29reW45MFAwR20wR1BjaHZFZlJ5aVRR?=
 =?gb2312?B?bUxJb0RYa0xUcndVVjhmMzRheGtsWXB3VGpxWUgzMEtCSGhEUTQwbXlzY2JG?=
 =?gb2312?B?UEE0azN3c0llUFRNblYxcytEMHVkZXFtTE0vaW82dEJxNlN6VHJITm91L3Q1?=
 =?gb2312?B?L1B5OVcvZ1Q4SUxqRnpCUEJtZXRGc0hHVitPRzlUckl2am12RWJRbmd5a0lh?=
 =?gb2312?B?WFh4RVROR1VTcTkwTkdZOXJWa1JXajJEYi8xS0NoNExadHp5dnpiNld0bGg2?=
 =?gb2312?B?ZHF0aVgzVThQbVdnbnNHb1pIRzQzaHU2UkpaS2dvd0J2QkpGSHVCazJXUVh0?=
 =?gb2312?B?VzlDM05EcHcwa29TZ3g2NDNTS2R6ME50R1Jvdm5kRVFwSDNoYXdVbXVLb2JT?=
 =?gb2312?B?NW92VXRvWmtmcDJmaFc5UG5nZXFsR3NBdnJEV25zM09Wc1FJOUJBWE40SVc0?=
 =?gb2312?B?TG4rU2dFakczRmxiVWorSGZ2d0ZWUnZPMHZwWjNxWlk5empaNHo4QUozQzFt?=
 =?gb2312?B?djlQcDF2WVBBT2lzZ3dJR0UyVWo4emhBN3RoUkJHTWJXYm90SndmdVdtSTZo?=
 =?gb2312?B?ODg2c2p3cVFpdjFxSWpGTTN0bkFUS2E2N0JkbnliQ2tBRTdvc2R1TXdoSzFM?=
 =?gb2312?B?TUxmS3pFTlV0TXRmYzM3RTBWSUpvQ09qZEJkalUvMzdaZDQ3dWtZd0VHaEhO?=
 =?gb2312?B?MHo4VlFNWGZKL2pPd0VuVW5obytPSlBsbzlPU1RJc21vanZZVHk5cTZJcS9m?=
 =?gb2312?B?R1FIaWJLL2JlMEkyNllSRGtGVm1MMUt0Mzc0QURCZTloZzluYlAwSWpoNjl5?=
 =?gb2312?B?eXhDdkhBVHUvamdOWndJaUM5cVlRbE43UTJ0SWs3b3ZnOUdaWnRIZnFGOVEv?=
 =?gb2312?B?N0xlcUk1WEpoTEVicG8xR0s4VnZIaDU4cG1NM3VuL1RQTnpLaVg5Q2xVaXNC?=
 =?gb2312?B?WFBvQWxsSmdFbElZS1lXYVo0VWY2Y1NGN0Z4dlUybU03Tm80QWhWUmpUbEh6?=
 =?gb2312?B?T0swSmgvRmpYcGJXeVZyM0dzUlBnZXRHUXRUTlJjZ2hIa1UxUkFtZDR0TGpT?=
 =?gb2312?B?Y1c4MjB5VnltSEpMeFc2dVlzZU9lRGphMUZ3NUNCUXAvbWFtdmpDQXNqWG9h?=
 =?gb2312?B?Y05tbEtmeXNZVExsdDZJdjM4em81b2NEakhTSk0xVnJCaFUyZndmNmdteDJk?=
 =?gb2312?B?VDlPUU5yTVBPWUNScDI0bTMyUCtQWGVzT2wrMUtQckZOTEpUVk90Y1VwRnA3?=
 =?gb2312?B?ZnVEd3RhdTF0c0dNd3l4OGpYanYrUHZzZkRiVG1oS2ExVlBOaFVoVG50N0VI?=
 =?gb2312?B?NmZ2WnNUVjRRUTBsVy83ZWVDeDNJMDhJLzRkYTZueENJYmk5OHJubVVEemdD?=
 =?gb2312?B?THFyaGs5QWpGWWJ4U1ZGVHQydEo2WXpNYlVXZWxVcGVWQjJ2eW1pbldmZjRt?=
 =?gb2312?B?Y3B6K1VwNlBtYWV5N09wTUpRUW1kUVdLeVBmaDJoeE8vYWhqc2xxdi9lQW1r?=
 =?gb2312?B?MmgrUGpOZ0dvK0NvNGJvWVkxYzFoNnRhQno3dUF4a3VBdVBlSVBHOS9hU0or?=
 =?gb2312?B?elIxMHVYTjRiRmNpUTFTY0ZKUlJWVzhyUHhpVmtNbzBYSW5WNGRDSXB5c1h0?=
 =?gb2312?B?aG93ekNJTzVhd2xYcFIwYUkySVVvcEl5eW1OMndrT3RMZ0VwVEFoRVBWNjky?=
 =?gb2312?B?cytnTFdZVWIzZUo2NGZKTVNkVjBiZXJHNUdJaG5xMTlyamp2MnpMUEx2WGlq?=
 =?gb2312?B?L0lMRGNMMGlMd0pUTUpvYmQ1Z1d2VmVEK0Jpa0RuN3RzRDU4a0xyVHhmZHRZ?=
 =?gb2312?B?Z01tWm4xako5bC8yNFNSS2FnbGgvUG1hd09ST0hKTTFwa0FWWGdlVnQ2TWRB?=
 =?gb2312?B?bzNpUDZGVXZoT0R4UURsc21janR6aWREeHR3OFBhV25LZU0wRjJPL3I3NGcz?=
 =?gb2312?B?RHFSTFZVQUlrcTlaQVllNngycWJObUJBZzFyajd5cFg5VXhlYkFueW1xbEpP?=
 =?gb2312?B?RzhvVXN4eFEyMXNSYzIrUlRWMkpaVEZISy9JdERvUTV4SFpSdlQ5Y0l0blBh?=
 =?gb2312?B?VkN4VUp5NG9TVmlwamFTMWwxMlV5UWNNdm5GT2JITTVQWHQ5b2dEM1Y1enBi?=
 =?gb2312?B?d1B6RDFRTHgzQWdRWTJGU2hBVUZpNHBTeHZvMFBNT2d3clFJa1lxeE1DQlpu?=
 =?gb2312?B?RGxHQjQ4STNEVTQxeVlmTWlXQkpjT2VJMG5ibEZYSXJrMmFxWlVZV29OdFpj?=
 =?gb2312?Q?7B4y8auZ7gvzvoAjoPrZ5l8B0uQ6SeYQj+/GYJfH1Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <0D9B9BE74245A144879DAF74D98D1E9C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f528a9-d06a-4966-433f-08d9e14178fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 03:02:36.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/AGnM4iLh+egDd86bZYpKFPVCtF9K3vkz8KWX0awlwCsiF1px+PbQ4GRgtdKjHsKUfl1bBF0AcwIRryTqpU5O/Td3fAtcarWbKNelV1OSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4729
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8xLzIzIDIxOjA5LCBFcnl1IEd1YW4gd3JvdGU6DQo+IE9uIE1vbiwgSmFuIDE3LCAy
MDIyIGF0IDA0OjIyOjE2UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBBZGQgZ2V0ZmF0dHIg
b3BlcmF0aW9uIGluIHRoZXNlIHRocmVlIGNhc2VzLCB3ZSBjYW4gYWxzbyB1c2UgeGZzLzEyNihj
b3JydXB0IGEgbGVhZg0KPj4geGF0dHIncyBkYXRhIGV4dGVudCkgdG8gcmVwcm9kdWNlIGEgZGVh
ZGxvY2suIFRoaXMgZGVhZGxvY2sgaXMgaW50cm9kdWNlZCBieSBrZXJuZWwNCj4+IGNvbW1pdCAw
NzEyMGYxYWJkZmYgKCJ4ZnM6IEFkZCB4ZnNfaGFzX2F0dHIgYW5kIHN1YnJvdXRpbmVzIikgYW5k
IGZpeGVkIGJ5IGtlcm5lbA0KPg0KPiBTbyB0aGlzIHdhcyBpbnRyb2R1Y2VkIHNpbmNlIDUuOSBr
ZXJuZWwsIGFuZA0KPg0KPj4gY29tbWl0IGExZGU5N2ZlMjk2YyAoInhmczogRml4IHRoZSBmcmVl
IGxvZ2ljIG9mIHN0YXRlIGluIHhmc19hdHRyX25vZGVfaGFzbmFtZSIpLg0KPg0KPiBmaXhlZCBp
biA1LjE2IGtlcm5lbC4NCj4NCj4gQW5kIGFkZGluZyB0aGlzIHJlZ3Jlc3Npb24gdGVzdCBpbiB4
ZnMvMTI2LCB3aGljaCBwYXNzZWQgaW4gdGhlIHBhc3QuDQo+IHByb2JhYmx5IHdvdWxkIGNhdXNl
IGFsbCB0aGUgYWZmZWN0ZWQga2VybmVscyBpbiBiZXR3ZWVuIHN0YXJ0IHRvIGhhbmcsDQo+IGFu
ZCB0cmlnZ2VyIGEgZmFsc2UgcG9zaXRpdmUgcmVncmVzc2lvbiBhbGVydC4NCj4NCj4gU28gSU1P
IGl0J2QgYmUgYmV0dGVyIHRvIG1ha2UgYSBzZXBhcmF0ZWQmICB0YXJnZXRlZCByZWdyZXNzaW9u
IHRlc3QgZm9yDQo+IHRoaXMgY2FzZSwgYXMgRGFycmljayBzdWdnZXN0ZWQuDQpPaywgTm93LCBJ
IHVuZGVyc3RhbmQgYnV0IGRvbid0IGZpZ3VyZSBvdXQgaG93IHRvIHNldGF0dHIgIHRvIHVzZSBs
ZWFmIA0KYXR0ciBibG9jayBhY2N1cmF0bHkgYW5kIGNvcnJ1cHQgbGVhZiBhdHRyIGFjY3VyYXRs
eSBldmVuIEkgaGF2ZSByZWFkIA0KdGhlIGRvY3VtZW50YXRpb25bMV0gaW5zdGVhZCBvZiB4ZnMv
MTI2IHVzaW5nIGdlbmVyaWMgZnV6eiB3YXkuDQoNClNvIGlmIHNvbWVib2R5IGNhbiBkbyB0aGlz
IG9yIHRlYWNoIG1lLCBJIHdpbGwgYmUgcGxlYXN1cmUuDQoNClsxXWh0dHBzOi8vZ2l0aHViLmNv
bS9kandvbmcveGZzLWRvY3VtZW50YXRpb24vYmxvYi9tYXN0ZXIvZGVzaWduL1hGU19GaWxlc3lz
dGVtX1N0cnVjdHVyZS9leHRlbmRlZF9hdHRyaWJ1dGVzLmFzY2lpZG9jDQoNCg0KQmVzdCBSZWdh
cmRzDQpZYW5nIFh1DQo+DQo+IFRoYW5rcywNCj4gRXJ5dQ0KPg0KPj4NCj4+IEFsc28gbWFraW5n
IGdldGZhdHRyIG9wZXJhdGlvbiBhZnRlciB4YXR0ciBjb3JydXB0ZWQgaXMgYSBjb21tb24gcGFy
dCwgc28gd2UgY2FuDQo+PiB0ZXN0IHdoZXRoZXIgdGhlIHNpbWlsYXIgZGVhZGxvY2sgb2NjdXJz
IGluIHRoZSBmdXR1cmUgaW4geGZzLzEyNChjb3JydXB0IGEgYmxvY2sgeGF0dHIpDQo+PiBhbmQg
eGZzLzEyNShjb3JydXB0IGEgbGVhZiB4YXR0cidzIGluZGV4IGV4dGVudCkuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+
PiAgIHRlc3RzL3hmcy8xMjQgfCAyICstDQo+PiAgIHRlc3RzL3hmcy8xMjUgfCAyICstDQo+PiAg
IHRlc3RzL3hmcy8xMjYgfCAyICstDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy94ZnMvMTI0IGIv
dGVzdHMveGZzLzEyNA0KPj4gaW5kZXggMzkzMDcyMTguLmMzY2NjZmQ1IDEwMDc1NQ0KPj4gLS0t
IGEvdGVzdHMveGZzLzEyNA0KPj4gKysrIGIvdGVzdHMveGZzLzEyNA0KPj4gQEAgLTY0LDcgKzY0
LDcgQEAgX3NjcmF0Y2hfeGZzX2RiIC14IC1jICJpbm9kZSAke2lub2RlfSIgLWMgJ2FibG9jayAw
JyAtYyAic3RhY2siIC1jICJibG9ja3RyYXNoIC0NCj4+DQo+PiAgIGVjaG8gIisgbW91bnQgaW1h
Z2UmJiAgbW9kaWZ5IHhhdHRyIg0KPj4gICBpZiBfdHJ5X3NjcmF0Y2hfbW91bnQ+PiAgJHNlcXJl
cy5mdWxsIDI+JjE7IHRoZW4NCj4+IC0NCj4+ICsJZ2V0ZmF0dHIgIiR7U0NSQVRDSF9NTlR9L2F0
dHJmaWxlIiAtbiAidXNlci54MDAwMDAwMDAiIDI+ICAvZGV2L251bGwmJiAgX2ZhaWwgImdvdCBj
b3JydXB0IHhhdHRyIg0KPj4gICAJc2V0ZmF0dHIgLXggInVzZXIueDAwMDAwMDAwIiAiJHtTQ1JB
VENIX01OVH0vYXR0cmZpbGUiIDI+ICAvZGV2L251bGwmJiAgX2ZhaWwgIm1vZGlmaWVkIGNvcnJ1
cHQgeGF0dHIiDQo+PiAgIAl1bW91bnQgIiR7U0NSQVRDSF9NTlR9Ig0KPj4gICBmaQ0KPj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3hmcy8xMjUgYi90ZXN0cy94ZnMvMTI1DQo+PiBpbmRleCBmYjVmNTY5
NS4uYTdlYjUxZmIgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy94ZnMvMTI1DQo+PiArKysgYi90ZXN0
cy94ZnMvMTI1DQo+PiBAQCAtNjQsNyArNjQsNyBAQCBfc2NyYXRjaF94ZnNfZGIgLXggLWMgImlu
b2RlICR7aW5vZGV9IiAtYyAnYWJsb2NrIDAnIC1jICJzdGFjayIgLWMgImJsb2NrdHJhc2ggLQ0K
Pj4NCj4+ICAgZWNobyAiKyBtb3VudCBpbWFnZSYmICBtb2RpZnkgeGF0dHIiDQo+PiAgIGlmIF90
cnlfc2NyYXRjaF9tb3VudD4+ICAkc2VxcmVzLmZ1bGwgMj4mMTsgdGhlbg0KPj4gLQ0KPj4gKwln
ZXRmYXR0ciAiJHtTQ1JBVENIX01OVH0vYXR0cmZpbGUiIC1uICJ1c2VyLngwMDAwMDAwMCIgMj4g
IC9kZXYvbnVsbCYmICBfZmFpbCAiZ290IGNvcnJ1cHQgeGF0dHIiDQo+PiAgIAlzZXRmYXR0ciAt
eCAidXNlci54MDAwMDAwMDAiICIke1NDUkFUQ0hfTU5UfS9hdHRyZmlsZSIgMj4gIC9kZXYvbnVs
bCYmICBfZmFpbCAibW9kaWZpZWQgY29ycnVwdCB4YXR0ciINCj4+ICAgCXVtb3VudCAiJHtTQ1JB
VENIX01OVH0iDQo+PiAgIGZpDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMveGZzLzEyNiBiL3Rlc3Rz
L3hmcy8xMjYNCj4+IGluZGV4IGMzYTc0YjFjLi41MTlkMzc3ZSAxMDA3NTUNCj4+IC0tLSBhL3Rl
c3RzL3hmcy8xMjYNCj4+ICsrKyBiL3Rlc3RzL3hmcy8xMjYNCj4+IEBAIC02OSw3ICs2OSw3IEBA
IGRvbmUNCj4+DQo+PiAgIGVjaG8gIisgbW91bnQgaW1hZ2UmJiAgbW9kaWZ5IHhhdHRyIg0KPj4g
ICBpZiBfdHJ5X3NjcmF0Y2hfbW91bnQ+PiAgJHNlcXJlcy5mdWxsIDI+JjE7IHRoZW4NCj4+IC0N
Cj4+ICsJZ2V0ZmF0dHIgIiR7U0NSQVRDSF9NTlR9L2F0dHJmaWxlIiAtbiAidXNlci54MDAwMDAw
MDAiIDI+ICAvZGV2L251bGwmJiAgX2ZhaWwgImdvdCBjb3JydXB0IHhhdHRyIg0KPj4gICAJc2V0
ZmF0dHIgLXggInVzZXIueDAwMDAwMDAwIiAiJHtTQ1JBVENIX01OVH0vYXR0cmZpbGUiIDI+ICAv
ZGV2L251bGwmJiAgX2ZhaWwgIm1vZGlmaWVkIGNvcnJ1cHQgeGF0dHIiDQo+PiAgIAl1bW91bnQg
IiR7U0NSQVRDSF9NTlR9Ig0KPj4gICBmaQ0KPj4gLS0NCj4+IDIuMjMuMA0K
