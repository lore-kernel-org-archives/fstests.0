Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B22C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiASCHh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 21:07:37 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:27933 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350649AbiASCHg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 21:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642558057; x=1674094057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QiL1LaYX0AxhqOYEODL0tr6ZSZrucTEP5H47WooMu90=;
  b=L/K5HeKSu2Q9+PiYWvdbpDNUC69WfiQr/0gjSh3sRTMQFESFeIah56lj
   aT0mIY6ZUo1Kut5IvKDcp1OtGihcUG/NtQtBs/fKlIC0kWfOgK+Xw7szv
   R5o87tDA90VcLG+22z+m+a84MRIhy+Yvy47RkOExVyn4Mwa4NeGpVQULI
   NOIwHTo7sX/NnFIw/NXp1AEvqHy1fUMC7Jam8CcjT6J89QoP75nYFESUv
   QD4TYSQ50Gs1nERucykku9dxw4Ym/nvT8XgPBi0G9TzYWYz+U+MbCZAKW
   /QdYRMiOGTBzWbfoeb9bbwooiR+YcMOgDFoTomUjFeWpRRQIA+puTGj87
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="56187683"
X-IronPort-AV: E=Sophos;i="5.88,298,1635174000"; 
   d="scan'208";a="56187683"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:07:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW/iQSnWjZCRx+4s/UmofG2JmXJLinPRF+NPvGkNWwMHM499LNcBYNpRi33lMbgg8Mli9+47HX7TUo0pShC1Jeh014oKmwIwFwY6ROG0N1gpObjBSiTXN9PO4qGmGeVNxLjhQWaz2Jy9fGEDKllJ7OQHUFAINvtNSQQXSs4HEE4w/fVotnN3HrRYOy7WzGX027eHbg+PK6xFM7jx6/zQMcnHabEfsPvt0dBGEfDFeE7mDAkY+tBWQfMeMwsb4jith3nE3ycyAdUkj9kSb6NT5KLvlLPGdTwOiH51lQx1Yhc4YyhKkyDR6OxsZvJceRgTM9R3BR1x5ZF5T9DWUg8X3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiL1LaYX0AxhqOYEODL0tr6ZSZrucTEP5H47WooMu90=;
 b=fXt0mqgJdSv0pNjmYyuHpg5iGi4jauxSQzdkSgdb+fSD1kwghzjG2pHjJzCgD0bWruykJppPlDGraYiL6Ag2aa+KmPyfhVgS7+AxWP5DPHZAjJ12jagdmgM5Z7tDxM2O3X0p7mb7EqIB73wButyKqlAkKXnt67o+r+8j2jiqOvv3Y0mhZ7sNnMMq6lJYoa/3EW4SVzxshkRojqiX0h+bEb7bBf2w6Kvkaqv0wDzWIUgorJvH3Mmz6DtRJdxB3e3VRCFzkXfu9tI844Nyu7D1xaP1qwA5wYcnumtEX4QBZcNuIRgnx307/9iJ5xpg7c/PW8IXRHS+5NFTxpQTN6vJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiL1LaYX0AxhqOYEODL0tr6ZSZrucTEP5H47WooMu90=;
 b=hWqSu8teasFkiTnC6lk+QYqxt4GS/9c8C3QWjgnvLVUoGmSQr37H7nu/gBXMhljdpeMVeRxEz2VUQEeSjj+vm+pkz/PH7qgYiFagAA8rGYYsQocHIC7BTPYISetF716htdefzgnonLP/CChrWooZQUS0lH6RiUPlIvoOFRZY+wU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB9589.jpnprd01.prod.outlook.com (2603:1096:604:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Wed, 19 Jan
 2022 02:07:31 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 02:07:30 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Topic: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Thread-Index: AQHYC3T1GUs88bXDK0iuG+0P5NW4eaxoEG4AgAADSICAABP+AIAAGcGAgACVWa2AAMU3AA==
Date:   Wed, 19 Jan 2022 02:07:30 +0000
Message-ID: <61E772A4.3030608@fujitsu.com>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
        <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
        <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
 <87fspl6s44.fsf@igel.home>
In-Reply-To: <87fspl6s44.fsf@igel.home>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd2ac983-c7b6-42bd-10e8-08d9daf0733b
x-ms-traffictypediagnostic: OS3PR01MB9589:EE_
x-microsoft-antispam-prvs: <OS3PR01MB95891360E4EE4A7DF913D240FD599@OS3PR01MB9589.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukf/OZuXPavc6h5YeRyvPxIaEPuYH77qFU3uf6bu5oJGEgV26HhhsG63psegKdVn19vYlS02DzunncCH6WUKEkSO5rv/z53TNM6mMh08HQa+EBVCDO6KtLV0BEieuYmhUMH9n1MV5EQ27zN/7LS3Y1Uk8dYQ9LHfXt2MLe3OJx14WT5DUzx1fBY9/JocX+lbgNM4k4UExhMx4Wn4DxhGVwXVeROQZDyorX+7gnZNqfZz7YbNqHqOGEdgD5ijZ7gX6L2YYfgz7YFWbHgMACJ4P6QAZ3f1+AvrmT5P3qaoJRoreZFjkozV4u13EwKgIeWPH+JqC6WndcrKDaAAHmsFqKwKxLiFmuI+D5PGV6GuENkSNTPTi9BDftlfIsvc/1sDfaIbst1kF/RDR7KuGKg8k4HFPnn8+NfACgEDejG/M8tc7TyGPDX/3KGu1By3yzrX3MSxsAy9OhquCE2A5sZVyxwbwolmGIYsuIQbW0cP09vA8fN26iMh3Th/JeezAMvDWvB2yAcLpYa07gG32e2p1vuzMPWNLrPptWmyxpmIoyL1pHdvcWmpk3rxoe+JCaaXRSDWd9a9MjmSW1vIneaoKgSTh9+3nDn5Yh9v+ALIiw1BQH02viQemLbR5v29RQZuLkn0xYfmkCBEjbT6rGlKNgSW5BqvwJum7ieqg7Kt6kmT9OK97Ii34d+VKPjdAyYeySLeA1uCqdP2i9PSdncfN0w68mQhZGpvi3CQB4ocsXgxDhUMLh+8KZCUXSeScTWQzbN2KgzrM7Jc5nJpfIcaWcX9anJ15mUU85SRvIHuesA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(6916009)(6512007)(91956017)(64756008)(66946007)(186003)(316002)(66556008)(66476007)(33656002)(6506007)(26005)(54906003)(38100700002)(8936002)(4744005)(122000001)(71200400001)(6486002)(86362001)(66446008)(8676002)(87266011)(2906002)(82960400001)(508600001)(38070700005)(2616005)(36756003)(85182001)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VW40cVFoRmQ5aDZWWVo2TU5EZ2s0Nzk5TWxxNFRaT3l4b29aV2ZTTXZjME1t?=
 =?gb2312?B?cXZ3UXFLTUlCdTg3NG1nYWhlU1VzcEMxMUczT25yVmI4dUptaG5GeG4xaFVL?=
 =?gb2312?B?MnFCaFEwSnVabFVDYitMc2dLcVoxK3A2MTYvK3NhdnRuQWROTU4zVUtCK0s5?=
 =?gb2312?B?R0wyNjdBS2hlWGk5SU1LWEJUdkY1SHFhZ3JlSGdFV2NZR3huYWc2TzIxRlVo?=
 =?gb2312?B?bi9FdTllMVVwNm1heGlEb21sWVlNdnNNSlVwOVhGWlFONURFYTY0RXVMRkJU?=
 =?gb2312?B?UGc2a3RCNkJQL1VUelN4TWM1YXBjSmNDMWRCbGFwS2lTZ0hzZ3J2NW1iUTJO?=
 =?gb2312?B?OGd0OUprOU8vakM3dkdZU2hMWDdFczNpRnRzV25ma1dVZWhpRUIydHhwbG03?=
 =?gb2312?B?OEVTVjRJWG5SdHV4ZmpHT25WM2EyZFZESlRhbVlpUytrYnlxd29SbGJHSVZ3?=
 =?gb2312?B?ZWtLazdxNGR3b1A5YkVHQmYrWTdlbGpVNk5rUElpNzBFRHdHVXV2RTFIQlFu?=
 =?gb2312?B?TUM1eWFhYzJvUHJON0tmSEFCOGU2TWFzMEprQ2R2R0tTcDZTMWFGVDFrMWxK?=
 =?gb2312?B?ckZZbmVaSUZBVTZZUWh3V3VxVzRCWUVkbkxNdU9ybjdaWUZOSURvRXo3ald0?=
 =?gb2312?B?bHMwWW1uRWtEMDdmZGsrZTlyTXpBSGpMSHp5b0lHZDhSR0YxMFVWeElrWlUy?=
 =?gb2312?B?SFc4ZFRLdHlIdXpYb2EvK3hyNlNDdUFBK2ZmZ3FXSWhpV0NZRENPSW9Uczdi?=
 =?gb2312?B?cEltUFZvOGhKSSsvU2Y2dGdvcUhxTUMvU2UvYW1vSHNZRWZ4QlRYSVlUSW02?=
 =?gb2312?B?TE1ZcjIxdCs4bHRzMFRsNFlNOWpjMSt4UXBlMjBXNFA0ekFTY0N6b2RFT0Z6?=
 =?gb2312?B?Zys4OVFiOUNtSXFPb3N3Ukc2Y2VVcTFHNzB6UWErQ1lSaWZUUEd4V0JpNE9m?=
 =?gb2312?B?YjExWXA5RjA5djFCM2pRQXNabW1oNmZMdjJUNENaazZueGxDZ3d6ejVVbnIy?=
 =?gb2312?B?OGhrM2VXMVZkSDhlYjJMK3dvaG9sbGZkTW43Y0YrQTE2YTNjYVUrTy9jbE1w?=
 =?gb2312?B?SzhESmlwT3g3cnQzS3ZuL1RhbFlKNDYzVnNSQy93dWVFa1FUY2pwMTZJNG54?=
 =?gb2312?B?SEkvcmIxeHRoYTVhRWM0ejBvRHZHNXVnYzZMcGg3TDRRc1pCNDhGV1dyemdt?=
 =?gb2312?B?S3p6b0NQMWwzVjhtMlpGQkVCdUVQKzdOODZuamM5OVBRMUJ6S1U1RXhIVGR3?=
 =?gb2312?B?WGRsYXVDa0V6S01OMklzdU9pMTRrTjg1VXVrRzZlbnVNZE45LzFCRHNuV2V3?=
 =?gb2312?B?bklEbW1MVG9BbS9waFE0a05paDZwb0cxNmlWUEZEelY0dXZ6Y3NURzg3K2Rz?=
 =?gb2312?B?VGtqYW5ibTlUNmREZWRVS2J2YUpNWm9ZT0VhckhHb1JiNlExRDVEK09Ec0dQ?=
 =?gb2312?B?Y3V5Ni84d1dmN2NVSzVNa2k4U0ZyVnVjSkpKMytac3NYYWlJMUFhQ0JjOS9Y?=
 =?gb2312?B?MDh2WXIwUmpqU2xsbDBDMHV2QWpJWmJYZGNIbDVBbzdyaVBQTkZCcHo4NkxM?=
 =?gb2312?B?dzc5OVY0LzZkMCtTZkkvRkRVYTlhUDVjUkRCaDVZNzR5TUcweURmRk8xcDEr?=
 =?gb2312?B?U3czYmw1djJCOFQ1Wk1oeW5aVzB2Q3pMYXVqUGUxWjV5b24zVnZDdGIyNXJ1?=
 =?gb2312?B?bHpYNk5HZGVteTJjMUFTVjVQbVNYd2Q0NkZ0UnZmd3FoTTRRb1ZyQjh6dHlp?=
 =?gb2312?B?RnVHQnk5alhhaFpTR1hCNkFvWXdxRDFQbE9nd1lTVVZzT1NKOXpBcEw0S0tu?=
 =?gb2312?B?R0NrWHNNcmF5bHYwUkVpbUZxQkYvejZlTmJXZmk0RnJXZzBQeUgvdjkzZ2tF?=
 =?gb2312?B?ZlVjbUs5c0YvQ2pSaXIyMW9RNUFlbHNZR0dRelNSZUlJQ0h5cGpCT3dZVG95?=
 =?gb2312?B?RkZ4TWFxUkwwM3VYcmdTR3VBUEkvanNaZUNxT0NDYjJFWGE1RzRlN2g0V3p4?=
 =?gb2312?B?QTV0RDFWOTFhZHlFS29LOVExeXh6aHIxT2tLSFhHdjdRNkZwQ1RCZWorSVd4?=
 =?gb2312?B?dkVPNzVBZzZ0QVJNN1dnYVlKbStGM24rUE5zeHlPYVp6L2wvL1dJTitFTjFS?=
 =?gb2312?B?K1RiT0hXd0Eyc2Z0cVZLOXRyRmFpelBoNXhCZ3hTZDRvNFVCNVhpbUlLc0Yx?=
 =?gb2312?B?S2JOR0VSdDY2SnMvbFFFL0hiTmduUTYvcDNNSFJuUUlnY1lRbDREbkdjZjlW?=
 =?gb2312?Q?MIeJ2q9RZp1MKdnNk4N0txKr/FtjYKojujgy6fLUT0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <BEE07C5F6436344285FB468E8433A63A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2ac983-c7b6-42bd-10e8-08d9daf0733b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:07:30.9111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyaLdjn3b9ZAD9LrVAFFYorNAqXrsMvtI7ic2zK27v75oIQyhEK9Nh7aAr8HOpSdO3tb9UKKY0vwnc9tJPTcv2QkjW3gBqHdVxPvuUMNAIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9589
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8xLzE4IDIyOjIyLCBBbmRyZWFzIFNjaHdhYiB3cm90ZToNCj4gT24gSmFuIDE4IDIw
MjIsIHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+IA0KPj4gTm93LCBJIHVzZSBn
bGliYy0yLjM0IGFuZCBydW4gdGhlIGZvbGxvd2luZyBwcm9ncmFtWzFdIGJ1dCB0aGUgZXJybm8g
aXMNCj4+IG5vdCAwIGluIHRoZSBiZWdpbm5pbmcuIFNvIGlzIHRoaXMgYSBrbm93biBidWcgb24g
Z2xpYmMtMi4zNChUaGVvZG9yZQ0KPj4gZG9lc24ndCBtZWV0IHRoaXMgcHJvYmxlbSBvbiBnbGlj
Yi0yLjMxKT8NCj4+DQo+PiBbMV1odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZnMveGZz
L3hmc3Rlc3RzLWRldi5naXQvdHJlZS9zcmMvZXh0NF9yZXNpemUuYw0KPiANCj4gTm90ZSB0aGF0
IHRoZXJlIGlzIGEgY2FsbCB0byBvcGVuIHByZWNlZGluZyB0aGUgc3RydG91bGwgY2FsbCwgc28g
bm8NCj4gZ3VhcmFudGVlcyBjYW4gYmUgbWFkZSBhYm91dCB0aGUgdmFsdWUgb2YgZXJybm8gYmVm
b3JlIHRoZSBsYXR0ZXIuDQpJIGp1c3QgdHJpZWQsIHRoZSBlcnJubyBpcyAxIGJlZm9yZSBvcGVu
IHN5c2NhbGwuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPiANCg==
