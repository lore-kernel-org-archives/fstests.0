Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B9DC433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 14:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiEGO1f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446580AbiEGO1N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 10:27:13 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9148891
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651933399; x=1683469399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l0Pk4Ggf4qdpqJO4eiSNyBho9HI9ycJzxMAByFjAb4g=;
  b=jo+4uxUtwyC318a/hThrdxI8n2j7kHZ4oKr4yYw5eh/Fys2zso4hL4tX
   /Ysj0pwG0cMhEzL6AOQmyPGgQy1ScstvjdLt1iqf/vvFpiBEgGinMlIuX
   BO5IulT7qblfMcdg/T6hmPj8cI5+UG4zIzMhKqBOAUIb0toTV1cUkhN4m
   t8jP1IGS744RnOzQ3aB+SfsB5o5RAY6zr/+pVTyGRpBitU52ilGFZl6Zo
   qcBI/wn78EQMUOc7mfdIml2pskvlCRRfgEel573XRuirrRgsW9A/XMUO5
   6iKIGfKKOTstuZJatUZjbrsXgfM+4+F4bzi8pfhyOK6YoZg6/gVOSULU9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="63389192"
X-IronPort-AV: E=Sophos;i="5.91,207,1647270000"; 
   d="scan'208";a="63389192"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 23:23:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsWYodHn++y1OdM7EHtGwFX68PM1lfNy8q2nimlY8IkjDtxF+rgmIKPBIxvW/2SJ2vB3bTYM76iJaCuqZwrn1ccT7Y9mDx5Hg/mttRgwBbYRcOWWJXw7HSyntsI4p8hUUuHqcU738Yus9NJ2xUKObuQhPXw2yHVvdRVWidgk41W/+BhuwNw9yEMYTpnok7/7FHT73ZWfXdHNLdG5DTUxW+peZBoMSAcF2NIDzzeegf06tPJckNFXtA16yBf4vg+gh2oFAIJEcBrE3tHpGUjN1N41E1AKZLaw5Z5rOiSJa/fu8VbpGdVeER2zIzVPvXmZKJIRyRYaJZgGXYqAi4/Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0Pk4Ggf4qdpqJO4eiSNyBho9HI9ycJzxMAByFjAb4g=;
 b=hRJR0hyWAujWAgeHFrojaKXp3IOLPjPZ6st/I8/EV3H8JiQxMLw2/HOOiLs2rta3lt+8Rbm/hbul743RVXUccKC8VaxMhjx+HAhqEjPw2m0VnnYd95hUKC2L5p5L9fFVtyjIOxeuVDjoqdCjmX1lqB8EVUzpqPQdQZQFxQkawE4n/nbpMlafAnwycM1y0mFoEG5KeqKqPCyp01DpiJ21zFWEMe04QiNrLoegCcN9vgNQxs3wvNuF5IrxI3tpKgNmecVpWkCdiORarUKBJk3CLu1U+lCO4NxStPE5UW1jrgxtleFlq7JzYI3QRNhzVoLd1UCR0TV9XhVgE6vBDfZlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Pk4Ggf4qdpqJO4eiSNyBho9HI9ycJzxMAByFjAb4g=;
 b=l35tT/lUNnkBXbGxM6sfiUCf/OWy6Lp3+IADVT2DAZyBYOSJ7RWPfs6xNUWngUaOoDR/hB3TMQZqIIrM/aZWFsVjozAuPRl+GAoP+PQhlWXD9c/OJA+sJQMLe81aXPa0RWCNvU0J6D+kx1gr75LUXtEPkqe+JluHKRRPS6wtBbo=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5739.jpnprd01.prod.outlook.com (2603:1096:404:8058::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Sat, 7 May
 2022 14:23:13 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5%7]) with mapi id 15.20.5227.021; Sat, 7 May 2022
 14:23:13 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before
 run_test
Thread-Topic: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before
 run_test
Thread-Index: AQHYYgrQzlyaa30sfU2Asn2nHyPWIK0Taf4AgAAXSACAAAeVAA==
Date:   Sat, 7 May 2022 14:23:13 +0000
Message-ID: <62768F0E.2040904@fujitsu.com>
References: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220507133330.xxuw2x7buluhpnlu@zlang-mailbox>
 <627688B2.3050006@fujitsu.com>
In-Reply-To: <627688B2.3050006@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fa57b58-09db-4bc0-4a5d-08da30351e91
x-ms-traffictypediagnostic: TYAPR01MB5739:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5739C4BF05A6EEB11EA6FA82FDC49@TYAPR01MB5739.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAslkH8xmHenllbAPyq4hYlZhfWeZbNohqRk4TMdG3cJzuQkY7oK2Okl3By0e/9RgnkHz6ciEPK1MSbxR72FzRnWIvoPRGgekAcB7MRs7pjeb8nSu8APPUdQQRX82wUoTiX7fSUddRVU0SbJmfmvi77YWr0FPMmyVYhyE0ct3VScbihMl38xf5dLo6y3ATuBoXaTVV+OpAtyacYYKdv5zvepaqUstfgCAwv7PAhh0GLJFLmvkk9f4c2ISYAoBqmZ22/7+uIzgww5lxvllDURGLIXozMK1ZJW8BP5x1aiBEXTkqu3A4P1vbB7aVBnljpWfVW5/zMlsv3dGbAJiqrX0Cy1uEPC3QZ+FQWWdQNuKN+r8/Tr3Zu9+BJp3Y7/LFxEQEceLFnzd9lYDFOlnlCeLrqBdPq3RYjH0VHeooyClzRaZiNNlr6QQTrJj7XDoC8Rm6rvFvwgaH8WYrMMySG1AFRPnCLdNh5kruOhzkD4h5XzQU96WkZUQrzoDecwSETkgE3GT3pEhks9NG8FXT/0S+hwqF1mg1gW02z2o1TO1M7ZzFwphF8AlFDPaft2G29GXcDK+AXHf+ttYJ0A6FpRpqiyazEOpAplCuglmTqt69FZNPI7fbwhv4pETERSGkgqZ1fEb5ty2U4CWuOc60WUPcluccKgWT/6VD05Z8aDA8UCrp3YIKF5TS06NG5xKIxYU9GwAtK7lu2macXOg1RgCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(83380400001)(26005)(6506007)(87266011)(71200400001)(86362001)(8676002)(2906002)(508600001)(85182001)(4326008)(36756003)(2616005)(316002)(5660300002)(186003)(38070700005)(8936002)(38100700002)(6486002)(6916009)(45080400002)(33656002)(66556008)(82960400001)(122000001)(66446008)(66946007)(91956017)(76116006)(66476007)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NlRhUk9HVWJpaWY0S3JoVjlvNkI3TzJaSUFJaE12UFIxbGlZc2NIZjZNT0F3?=
 =?gb2312?B?YjlXNzFwenVhOENWZU9VZnI5NkorUlRlcnEyazhwcmVqckdxZGtYL1NQYVd5?=
 =?gb2312?B?dW9qRTlvYW5LR3ZNa2ZIdzduaS9ySFFLNkJCNTBZQ0JENlRKVUFGUkNoeHFh?=
 =?gb2312?B?QTJmZ242azc2V2s5RjMyN0x6YUowa21qNHdnWDkxUGVqY3kveld5dmFTY3VN?=
 =?gb2312?B?cDVHc1h0dkpDT3NaNk9xNGlvclBkTXA0OG43ZzlwWGtBWldGOG5pRXBFay8y?=
 =?gb2312?B?bW9sUG9oSzBIS3JmQ3BLS3JOam9zbmVDM1VYWSs1T2k0dTQzUW5za3Jkb0c5?=
 =?gb2312?B?NnhxVUdEdmdVVGh0cGZ0eGV6bGp5TVl3MkYxN0JnWnZNMFl6b05hakNnZG51?=
 =?gb2312?B?VVBJcGdvZGQ4RFFnR0YxWkF3L2NtTmJwWEFMS09OblJxUk9DUHVxbXhvTmxH?=
 =?gb2312?B?aVZaTERkRHROUHFKRXZBTGpadnBsaUV0ZXhSZWNtbmdiTWFHVENONUJlSHRT?=
 =?gb2312?B?MEY5bWZGTUxucThkdHVzZFJaaW5kOFZ4VnBnYVpKUHpwcjBSUDZwZWFwaHkz?=
 =?gb2312?B?RnQxdE5CcjFRUFI2WkxkZHVSUXgxbDNoQW51czJUKzdtTThZbGNjbUg2ekJ3?=
 =?gb2312?B?bloyd3loVVU5bFozckhkSVlHbDJobXpzRks5RGJpdVh0QWppR2ZPNXlDNlF1?=
 =?gb2312?B?Z1c3a0s1ZmplemhCakNjK1FWY21KTkxOT3o3WTU4WEF0Q2xwYjVEamdvL0ZF?=
 =?gb2312?B?V1poRXNXZVdZYVZBQlZhY2I4SVVPK3Z5Ky9DV3gyRG5BWXR1TDRxZnp4MXZ1?=
 =?gb2312?B?UVU3dHFvU1V3bllKOFFNUUtzci9rNXd2ZG9mcGE0Rmkxall0VlVUemlDaDhT?=
 =?gb2312?B?SVNIb1dyR3hCZnFBeml0aUhLWlhqL2tkSWMxY1pXY3Znakc4RTJSNmhkZ2pY?=
 =?gb2312?B?RVlTSVowSWJlbGExN1pJU244Y0xFdmNjSGQxbWJmMXVVN2VSMnc1TU9LOXpU?=
 =?gb2312?B?SlROeDA3d2dUVklITzdsd0pVMVhUNEV2N0pXWk5jQlVkRDlIYnIzOWg4OEM1?=
 =?gb2312?B?TTNCY2lPRXV3dFNLN3JEWFZwbVBqV3pNVVo4bG83Y2wvNzQzMndsQXdEQ0k4?=
 =?gb2312?B?SjdmNzBIZ0FUU0tTaEVhWjUyaDIwMWF6aTNrSUhIYlhKK2sweHdCcWtiYzhx?=
 =?gb2312?B?L0p2ZHFaSzUzSFoxbTh1U1NsZ0hOeFpDQlEwUDBGOXJmSVduVFpQL1oyRUdL?=
 =?gb2312?B?dkxyTXp0YnE5T1Y5elhMOVBQa2ZpQ09jQVpaRUliOXd0MkZOQmtNMTdITy95?=
 =?gb2312?B?V1NET25ZZTdBdXp2MXZQbGErcWxuOG1mNER1UnR0OEtnY1poaHg3OEZZY1VX?=
 =?gb2312?B?dDJvR01zZzVKdVlha3hRdmh6SWVETlBlaXpSb2RPSXo3LzhnNFBGWCtTU3VM?=
 =?gb2312?B?WXozOTZNL3MxeGpLU3JmRVV3MUZmOGh0N0Zqd2wzem1ZT1VoVXpaL2F3a3ZV?=
 =?gb2312?B?dW91TGJndWN5MDVObHZOSHpxQ0tDb1I0cVpFdytTZXZNNlFnTUp3enduQkZ2?=
 =?gb2312?B?ZloyQ3JaOHk2cHdpRExDMTlQTkxtTiszUXEwQ3VsaGg3NFJWNEtqL2hCdExF?=
 =?gb2312?B?c2lQWFR3Vk45aDlWMDRBazAvNkhzcTNMTkZtSy9wcC90THlPWi8rZEZQNFgr?=
 =?gb2312?B?QmNjZkZaVjNNL3l5NWJXdjJSbkJIWXdyaXMrcW1hZ2wrbjZZeURzUmJ5S3RR?=
 =?gb2312?B?MEgrV0F3RzJYeFIrUm5GZTVwQnhWNk9ZeVVGb3hDeEVyKzcraHNjbHVaNTkx?=
 =?gb2312?B?UVEzekp0MjdudnR1MFBPZURQYmw3ODd0SjYwK1hjeVRwd2FoZ3hYdTJQd1dk?=
 =?gb2312?B?T0lBVEJXYUNnWC9wcEJ0a0NibkJWS0VBcU1kdEFnR3ZVSzVhbkdmTGZYd1hw?=
 =?gb2312?B?Vk1NSVlwODE4RmhjT3RZR2tyVitjVzA3cThvVmlYSEhIYm10RGNIdlpWK3dN?=
 =?gb2312?B?ZFlzdjlCWjZXVmRhZG92WEZzRi9HQTBxV2pZdzlRKzlGT0dzdElEaVpsRmQy?=
 =?gb2312?B?ZTFmQTYrei9iRHZEaWM5Wm9YTmFyWGhsVi9CZDQydkxvaE9Gc29qK3EvaE5J?=
 =?gb2312?B?cU5BRmxqWkE4blo2MlVWMFVUM091V0JHVU1FMFdFcnVVZ0Z3RVUyZzZ3bG5j?=
 =?gb2312?B?dGorMm40aTJhbTY4S3FhTHFxYnZNYXRBTkFoR1FTaFNRbytMNDdmakR3U1Yx?=
 =?gb2312?B?VWZYc2dHYTB2N3E4cXI2SWQyYVA0empaV0pEeDdYRmhnKzVBaFRYT0hMTXV6?=
 =?gb2312?B?dWdFa3RuSkphcy9lV2xqYnQ5NUpWY1dwNk0yNDhwVGkyQXovbFdZcGlVdG00?=
 =?gb2312?Q?1ctHS+xOf5bX2aEH8VY3h2djj88Ro32Hl3koH?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <23A736D5C777D84994E32536F99E9C5D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa57b58-09db-4bc0-4a5d-08da30351e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 14:23:13.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqrGV1pmZ2I8nK00AzWq4PqEOXZpWHRZK1V7QPBBaFwNJs83KqvVf9toVqTABqmXvgAvYHRMSVf7OAqV+IDQ91nO4m9aeFJGqP/moQtKRNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5739
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi81LzcgMjE6NTYsIHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+IG9u
IDIwMjIvNS83IDIxOjMzLCBab3JybyBMYW5nIHdyb3RlOg0KPj4gT24gU2F0LCBNYXkgMDcsIDIw
MjIgYXQgMDk6MDU6MjRQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+PiBJZiB3ZSBydW4gY2Fz
ZSBvbiBvbGQga2VybmVsIHRoYXQgZG9lc24ndCBzdXBwb3J0IG1vdW50X3NldGF0dHIgYW5kDQo+
Pj4gdGhlbiBmYWlsIG9uIG91ciBvd24gZnVuY3Rpb24gYmVmb3JlIGNhbGwgaXNfc2V0Z2lkL2lz
X3NldHVpZCBmdW5jdGlvbg0KPj4+IHRvIHJlc2V0IGVycm5vLCBydW5fdGVzdCB3aWxsIHByaW50
ICJGdW5jdGlvbiBub3QgaW1wbGVtZW50IiBlcnJvci4NCj4+Pg0KPj4+IFdlIGFsc28gY2hlY2sg
d2hldGhlciBzeXN0ZW0gc3VwcG9ydCB1c2VyIG5hbWVzcGFjZSwgc28gcmVzZXQgZXJybm8gdG8N
Cj4+PiB6ZXJvIGFmdGVyIHVzZXJucyBjaGVjay4NCj4+Pg0KPj4+IEFja2VkLWJ5OiBDaHJpc3Rp
YW4gQnJhdW5lciAoTWljcm9zb2Z0KTxicmF1bmVyQGtlcm5lbC5vcmc+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4NCj4+
IFRoaXMgcGF0Y2hzZXQgYnJpbmcgaW4gYSBuZXcgZmFpbHVyZSBbMV0gb24ga2VybmVsIDUuMTgu
MC0wLnJjNCsuIEJlZm9yZSBJIHB1c2gsDQo+PiBqdXN0IGNvbmZpcm0gdGhhdCBpcyBpdCBhcyB5
b3VyIGV4cGVjdGVkLCBub3QgYSByZWdyZXNzaW9uID8NCj4gDQo+IE5vLCBpdCBzaG91bGQgYWxs
IHBhc3MgYmVjYXVzZSBJIGRvbid0IGludHJvZHVjZSB1bWFzayBvciBhY2wgb3BlcmF0aW9ucy4N
Cj4gDQo+Pg0KPj4gVGhhbmtzLA0KPj4gWm9ycm8NCj4+DQo+PiBbMV0NCj4+ICMgLi9jaGVjayBn
ZW5lcmljLzYzMw0KPj4gRlNUWVAgICAgICAgICAtLSB4ZnMgKG5vbi1kZWJ1ZykNCj4+IFBMQVRG
T1JNICAgICAgLS0gTGludXgveDg2XzY0IGhwLXh4eHh4eHgteHggNS4xOC4wLTAucmM0LjIwMjIw
NDI3Z2l0NDZjZjJjNjEzZjRiMTBlLjM1LmZjMzcueDg2XzY0ICMxIFNNUCBQUkVFTVBUX0RZTkFN
SUMgV2VkIEFwciAyNyAxMzowMzozMiBVVEMgMjAyMg0KPj4gTUtGU19PUFRJT05TICAtLSAtZiAv
ZGV2L3NkYTMNCj4+IE1PVU5UX09QVElPTlMgLS0gLW8gY29udGV4dD1zeXN0ZW1fdTpvYmplY3Rf
cjpyb290X3Q6czAgL2Rldi9zZGEzIC9tbnQvc2NyYXRjaA0KPj4NCj4+IGdlbmVyaWMvNjMzIDE0
cyAuLi4gW2ZhaWxlZCwgZXhpdCBzdGF0dXMgMV0tIG91dHB1dCBtaXNtYXRjaCAoc2VlIC9yb290
L2dpdC94ZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmljLzYzMy5vdXQuYmFkKQ0KPj4gICAgICAgLS0t
IHRlc3RzL2dlbmVyaWMvNjMzLm91dCAgIDIwMjItMDQtMjkgMjM6MDc6MjMuNTQ3NTAxNTEzICsw
ODAwDQo+PiAgICAgICArKysgL3Jvb3QvZ2l0L3hmc3Rlc3RzL3Jlc3VsdHMvL2dlbmVyaWMvNjMz
Lm91dC5iYWQgMjAyMi0wNS0wNyAyMToyMDo0MC4yMDU4NTI2NjIgKzA4MDANCj4+ICAgICAgIEBA
IC0xLDIgKzEsNCBAQA0KPj4gICAgICAgIFFBIG91dHB1dCBjcmVhdGVkIGJ5IDYzMw0KPj4gICAg
ICAgIFNpbGVuY2UgaXMgZ29sZGVuDQo+PiAgICAgICAraWRtYXBwZWQtbW91bnRzLmM6IDgyNDQ6
IHNldGdpZF9jcmVhdGVfaWRtYXBwZWQgLSBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5IC0gZmFp
bHVyZTogbGlua2F0DQo+PiAgICAgICAraWRtYXBwZWQtbW91bnRzLmM6IDE0NDM3OiBydW5fdGVz
dCAtIFN1Y2Nlc3MgLSBmYWlsdXJlOiBjcmVhdGUgb3BlcmF0aW9ucyBpbiBkaXJlY3RvcmllcyB3
aXRoIHNldGdpZCBiaXQgc2V0IG9uIGlkbWFwcGVkIG1vdW50cw0KPiANCj4gSXQgaXMgYSBjb3B5
LXBhc3RlIGVycm9yLiBJdCBzaG91ZCB1c2Ugb3Blbl90cmVlX2ZkIGluIGxpbmUgODI0MyBhcyBi
ZWxvdzoNCj4gICAgaWYgKGxpbmthdCh0bXBmaWxlX2ZkLCAiIiwgb3Blbl90cmVlX2ZkLCBGSUxF
MywgQVRfRU1QVFlfUEFUSCkpDQo+IA0KPiBDYW4geW91IHRyeSByZXBsYWNlIHRfZGlyMV9mZCB3
aXRoIG9wZW5fdHJlZV9mZCBmb3IgdG1wZmlsZSAgcGVybWFuZW50DQo+IGluIHNldGdpZF9jcmVh
dGVfaWRtYXBwZWQgYW5kIHNldGdpZF9jcmVhdGVfaWRtYXBwZWRfaW5fdXNlcm5zIGZ1bmN0aW9u
Pw0KDQpTb3JyeSwgdGhpcyBlcnJvciBiZWNhdXNlIG9mIHRoaXMgc2l0dWF0aW9uOg0KDQpFTk9F
TlQgQVRfRU1QVFlfUEFUSCB3YXMgc3BlY2lmaWVkIGluIGZsYWdzLCBidXQgdGhlIGNhbGxlciBk
aWQgbm90IGhhdmUNCnRoZSBDQVBfREFDX1JFQURfU0VBUkNIIGNhcGFiaWxpdHkuDQoNClNvIEkg
dGhpbmsgd2UganVzdCB1c2UgQVRfRU1QVFlfUEFUSCBpbiBzZXRnaWRfY3JlYXRlIGFuZCBhbm90
aGVyIHR3bw0KZnVuY3Rpb25zIHN0aWxsIHVzZSBvbGQgd2F5KHNucHJpbnQpLiBJIHdpbGwgc2Vu
ZCBhIG5ldyBwYXRjaHNldC4NCg0KcHM6IEkgaGFzIHZlcmlmaWVkIHRoaXMuDQoNCj4gDQo+IEJl
c3QgUmVnYXJkcw0KPiBZYW5nIFh1DQo+IA0KPj4gICAgICAgLi4uDQo+PiAgICAgICAoUnVuICdk
aWZmIC11IC9yb290L2dpdC94ZnN0ZXN0cy90ZXN0cy9nZW5lcmljLzYzMy5vdXQgL3Jvb3QvZ2l0
L3hmc3Rlc3RzL3Jlc3VsdHMvL2dlbmVyaWMvNjMzLm91dC5iYWQnICB0byBzZWUgdGhlIGVudGly
ZSBkaWZmKQ0KPj4gUmFuOiBnZW5lcmljLzYzMw0KPj4gRmFpbHVyZXM6IGdlbmVyaWMvNjMzDQo+
PiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+Pg0KPj4+IHYzLT52NDogbW92ZSB0aGlzIHJlc2V0IHN0
ZXAgYWZ0ZXIgc3lzX2hhc191c2Vyc24oKQ0KPj4+ICAgIHNyYy9pZG1hcHBlZC1tb3VudHMvaWRt
YXBwZWQtbW91bnRzLmMgfCAyICsrDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3NyYy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQt
bW91bnRzLmMgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jDQo+Pj4gaW5k
ZXggY2UzZjczYmUuLjJlOTRiZjcxIDEwMDY0NA0KPj4+IC0tLSBhL3NyYy9pZG1hcHBlZC1tb3Vu
dHMvaWRtYXBwZWQtbW91bnRzLmMNCj4+PiArKysgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFw
cGVkLW1vdW50cy5jDQo+Pj4gQEAgLTE0MjMyLDYgKzE0MjMyLDggQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkNCj4+PiAgICAJCWV4aXQoRVhJVF9TVUNDRVNTKTsNCj4+PiAgICAJ
fQ0KPj4+ICAgIAl0X2hhc191c2VybnMgPSBzeXNfaGFzX3VzZXJucygpOw0KPj4+ICsJLyogZG9u
J3QgY29weSBFTk9TWVMgZXJybm8gdG8gY2hpbGQgcHJvY2VzcyBvbiBvbGRlciBrZXJuZWwgKi8N
Cj4+PiArCWVycm5vID0gMDsNCj4+Pg0KPj4+ICAgIAlzdGFzaF9vdmVyZmxvd3VpZCgpOw0KPj4+
ICAgIAlzdGFzaF9vdmVyZmxvd2dpZCgpOw0KPj4+IC0tDQo+Pj4gMi4zMS4xDQo+Pj4NCj4+DQo=
