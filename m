Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D65C19F28
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 06:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiHCGqO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiHCGqM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 02:46:12 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 23:46:09 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743C656D
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659509170; x=1691045170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5VdpwZnkNA6wsylF6xr7Jo3ErhfQpUeNRj7+AOWS2sY=;
  b=j8Yw96ylTosQOpKV8Ad4hwsSEFRhgykkVnFhoZgu7wSrOTXTOG3gzL/P
   RHJ7Ovkvb3kbkBaLqXX6bVTvSTILQoCt/JnOKjGwFp4GdlwVDovFxpnC2
   VLpHZFHrCggR5DITN4mEnhZJJO11t8hkkn6lJ7rNJIM5rMc++4/e/CdfQ
   OPmU0Pep4hi1z/gC/nEjAaI3UWX3wlx9v/dL2lVPz+8zMz9R9zchBsXR/
   sjHG3M30kTCKk7AFTg+7wn0qoFBba1EODHiXbiBj1qJpEXnDQpWX5B8xm
   tTdn3AO1UmvST8223x7uMGOnTOC/I8eyDQQQEsoTtpDzPPOoFRLB8sgjk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="61874403"
X-IronPort-AV: E=Sophos;i="5.93,213,1654527600"; 
   d="scan'208";a="61874403"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:45:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri4iZQar5O/dFQQf9FkNbD8sx8w7OHiD1MmEwH82xYBhEn7MopkDhrsEdfqii4/GHs2SN8z8ORn+bz5imwUtKP+Z0ZTRaxZDXpv7yo8uOh60xm+8iEQXtnox3rn0H4CGyP1U/y6p9/rNXhY+0W0SEZZKGgzyqIMFWrcFfWB61sk+ulWt+HOZaNbfDOiRD7iuANdJQL1pBelRDkREN4IpgU1Hf6npoJ3popgZ69YGl/+JH5ZKUw8MUGMZ5oqJGajTD5zIe6CBBzeUkbMi+YDjyDKs4cIRr/gbKV0qRnggQEJgGEjtpC/qhgJdv6VY3PfZk7zH7N2U1dXS4jEHRdKC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VdpwZnkNA6wsylF6xr7Jo3ErhfQpUeNRj7+AOWS2sY=;
 b=PzdH9RhrU3ucFt5xl7iiHibxO4YCBwHp3eSPWNNcdkayo+IOTHij5jFZwdPlZH1GeXHQ2a6yloZviQLzjNk2kUL/0m+tUgWgDW09DhqU2sFd1TZZnzSVmPgc4ZZYCb8sh1oP/KS5yOGOnCDEDDmM9TjS3OozQ7qJ+OWDSsDeB5OB/X9xzTpRwd3VUWbGSxODov8uMJ473WfEE00Nh8b4TwjQgbsBkGcekvIxTL3yEHO/Bt9BGv7Sy7bYw+54LfystoydVtkHPT4+jU11edt4ok+mFJyGolj2sr9KTq937FTTT81+fuwRU5iPCYys+kfwAW1xI7INfPrz5qmC8tpWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com (2603:1096:604:107::13)
 by TY2PR01MB5162.jpnprd01.prod.outlook.com (2603:1096:404:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Wed, 3 Aug
 2022 06:45:00 +0000
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::ccd:ccc6:1a42:94cd]) by OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::ccd:ccc6:1a42:94cd%9]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 06:45:00 +0000
From:   "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/688: Skip test if fs doesn't support security
Thread-Topic: [PATCH] generic/688: Skip test if fs doesn't support security
Thread-Index: AQHYpkTjL44pREWUQEOnjgSDKcleL62cK3OAgACRMwA=
Date:   Wed, 3 Aug 2022 06:45:00 +0000
Message-ID: <607cea62-5afd-063e-169c-bd2b5e885271@fujitsu.com>
References: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
 <20220802220537.GC3861211@dread.disaster.area>
In-Reply-To: <20220802220537.GC3861211@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25086a83-ff82-40ac-841e-08da751baffd
x-ms-traffictypediagnostic: TY2PR01MB5162:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9Rl8lxs7LxSRwByo6gFUPg+ruSfTR8CUneiF4uj4hmgEIhu+Nkt/i/HF9ydI79o/h5kLMaDDT21IVjnDTDMm7HaXHaz6jBmv9q2GYLKKEIDhGlfwcyQ9LMRcFuuHe6ninLZndCQHUq0dLDfYvtQ+fSqlIk4+oSOQ1IZU127pVd+81AWgrt0nGvrk92iz2xhABRkzXWAktbuO4NLhGZqbM27w8s1chYYy0aKD876sq/mSOr2HS+192wNf1Rapdfotgi45+GrZHyjv9babeNE1NArxKYSyMYgOx7WwODreWN4IS8WqotLV9LBDWU7owjS+XD86zi20eFdt/KjgyyMAut4Mt3BA+RhwdMX+pCjuQLJP1rg86aEKAi+BShTuF9FUtvirYlHHYlipdPDbZEQONQ/W0DPHk2HXZzprhy5vZxq6mTlkLT0iURUyy7vI7t+uzet6pBhS9Hn7Qt5fH5n0H2bYRT2xMHzE6vNuQJJPe/aDWW5XLxVDblPVkKXzRrqEuY2qARCjC1Q6IEHW4sudj9lepyKldybE7gU1OH0VRJoS8qt845DFIhkvlaRT3yz76zEu5tpRd3d5ykqlJjQ0JFOhD94yyPw+SYpOn8PZxl7cYy4l2HQNK25pH+K2T3mOcw2AjgI0ooM7w6mL5JSk+WtPMhVk3l5KiBcrVMTcr405S5sXukHWin7TcY56Gg/N3Iiu9HE0AUL6Dsslf4a7zFyDYUl3kFuCUJj8YE9iNBBLxGsiD3Fv+01L58f5MH1gWHNjXYYoLPdDSakLir1Y5FSILUdCLVEpNWLN6eiMttLN6mGO0jnJmhN0wbWLJOLqQjmhal1m2gzKiWdXe7Tu0TGLWfWtyZ4TfcU4r7Gdos=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(38100700002)(6486002)(6506007)(26005)(6512007)(71200400001)(4744005)(82960400001)(91956017)(66446008)(66556008)(53546011)(41300700001)(478600001)(66476007)(15650500001)(64756008)(5660300002)(31696002)(2906002)(86362001)(76116006)(83380400001)(8676002)(122000001)(36756003)(38070700005)(8936002)(85182001)(4326008)(31686004)(6916009)(316002)(2616005)(186003)(66946007)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2pZbHhSNWpWWjVCSThmb3R1bUNNbXYzTGhSOCt1RUJ6amxrZ1hHMElPcXlm?=
 =?utf-8?B?eWtkZkJtVHFQWjRPaG5reElOM0JWT2YwaU55VHlmK3FqS0RURUFwaTQvM1p5?=
 =?utf-8?B?cEJGeUZyQW4vRDNwVUtBS2VaeE5UdTRlSkloaWVyV2VXTEd3a1YvcnYwSUgr?=
 =?utf-8?B?aFRkT09WbUI2VFpvdlNZYzN3K3BIZnMvWUNqRC90WHhtUit4SmVPNHdpUlR4?=
 =?utf-8?B?dFRPVFVsVnpUeFFTekcxeFlJSHNsb1BPS240bVNaUnZ0UnZMZHpVSFJ5bU44?=
 =?utf-8?B?bExwZnpvczBOZ1d2LzVlWitXdVcraFYvUk9vVEI5bW1KdHJXblNHVldCMnI3?=
 =?utf-8?B?Smx4YlhlQmpRKzRwZGZwbk5jQVlKQzdEVXNvbHhad3gyeUc1Wmc5Vm53Tnpm?=
 =?utf-8?B?dkdyS2tyaEFQNGY3R0N6R0hGRFd6Uk8zZzB5UHhUbU1ycFpkMXRyMURUb1Zm?=
 =?utf-8?B?ak9JNkI3RUpneTk5NDNZNGVwc0N3bnlBTmVjbmx2MnAydDB1bkRKa2R1R3hD?=
 =?utf-8?B?dW1kMnMrVDNBWXlNc0NTRFRzcnlOTm5oeUJMNXR5LzRkVzFFR2pnK3RiQmIz?=
 =?utf-8?B?cXdsb3VhM0lrMXp0UVU4MkUzYXE0NWlWMEFKVitSeWljWng4eS94OHpSRWY0?=
 =?utf-8?B?WlBSaHVLUUFqNTJhelJvZGVCNm1JZ2ZYWHMwaGJkNFNaSlJLbzdQK1BSZFlO?=
 =?utf-8?B?UXBNMHBXSmVEWUFqVCt6UWR2MmxYcHZVV0F3OEtRRVFweU9aQU9Sa1JUMDJq?=
 =?utf-8?B?cmZXTENUNitLbUJaK1JaMjJXditoVGlsVjF1LzZiNU51YnJZN1JmcW1xcmV2?=
 =?utf-8?B?b0djYkFsQ05TVVlLTHNIcHpHUlExUFpXR0tnUERZSENrd1hPakJreWRwTGg4?=
 =?utf-8?B?RHJnQ3N6ekU4d0lwVzVlTStxWlNIcHk5S2lwTmUyLzhlZVpHY3pNT05jSXZI?=
 =?utf-8?B?eFF5KzhaNmt1LzVZWjR2ZkRCUlhHbjgrbUI2cjhWamozUHAzU1ZobUR2K1V5?=
 =?utf-8?B?T2NqbjB2eVluNUhhdE9tcnhhdloyRkFkU0ZJc3l2aURoeW5iWVdiVG50ZktK?=
 =?utf-8?B?blg0eVVXK201VDdrY21BSUZya29SbVRUMTJBTFQveGFQZE1jQ2p4aWxPYW1a?=
 =?utf-8?B?emJId1Qxd21NYVhvM0IydHNQN3ZIaThlTkNHNkFDaHBVTDFqd3RScmxDd1NC?=
 =?utf-8?B?RFZ3cDE1bHJXK1ZtR2ZhNk5iNGVhWUZWQ1NRdlVjTUs0c0RFOWw0MFEvcW9i?=
 =?utf-8?B?ZlZOWHMzTkczeUxXTnlONXBzZlp5WTJJdGdwUmE5UWJDRHFHeFZPSzhCRjVL?=
 =?utf-8?B?VjJqVERRSmsvWFd2Nm1vVzFFWXgzbzh1dSthNkNESjlia3hpSnJRejQvbmtV?=
 =?utf-8?B?aWJyQWd4SXdRU3BrTUtHVytPRGc0aWRuc2hsLzg1NHI0TlpURlJLVllIWW1k?=
 =?utf-8?B?T2E3NUpjbzlmZlREL095UWJGeG5MbE5SOEt0aVlySUVCbTZGV3ZDSy9zNDF2?=
 =?utf-8?B?THpkMlVUdmN3M3JwRFh6SW5GakM4d2luYmwyZnBIVWJFUFJVWTFlcG5ZenM0?=
 =?utf-8?B?dEpwTHAzQnlnQWRFRUd6ZmR1S1lLdjY0NmFXV2U2eXEwWng4ZVBpcm1HTk1p?=
 =?utf-8?B?czNZbmpUVDhDaGErRklxY0RyckdzbHBhVFRTdEtoYnI3Rlc1VlpRSVh4ZUVH?=
 =?utf-8?B?NTJObnYxbHNzSVdBSXlOeHM2bWk0cVBvaXFuNWcxUjBGbmZYbHovMUVNY3o3?=
 =?utf-8?B?Q1JieTFNZit4c1BUcDB1OC9VMDBhdmtyOEt6VFpoWTJiMWhiOERQNGVacHM0?=
 =?utf-8?B?YUdzRnI0dXE2aDVoOXhKUHFBWnRDTG92WUFLZmZ1SFpoaW1ldU1yZ1J2bGwz?=
 =?utf-8?B?SFJOUjFudXovQjllMVdHZW5NU2tUVE9qemJmTjR5c2ZrZ0JDU2FnREhGQVRo?=
 =?utf-8?B?cVh4ZXA0NGJuWlBQTzh4aE1Rb1R4NDlhOGdzamlKLzFQN0dudXYyTExTWFpu?=
 =?utf-8?B?Snc2b25LaEhXNkZ5ZDc0TEl1OUg1NTg4RTV6TXJpNjMxellFMEljNGtYRSth?=
 =?utf-8?B?RGtGWTc0VlErcGNnTkV0dWRYRE9pREJYQzF4bnRUaWNRc0VLY29zMEQ1YUFz?=
 =?utf-8?B?WXZjWWlWUGxGdG9XcEFqcC9SWnFGOWNyRWNnRWsrejdkSlRvUUFMVzdQaHZT?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32D0F0729DD8284788344775E4CCEF72@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6481.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25086a83-ff82-40ac-841e-08da751baffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 06:45:00.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoMHpwPu3vE+ZrB3Cjs60u4og60lIQYAduO8XtbFdommOjKpHgaF25XADMPX8ccZXz8AZn0uH8uYz7EUR51KnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5162
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgRGF2ZS4NCg0KT24gOC8zLzIyIDA2OjA1LCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+IE9uIFR1
ZSwgQXVnIDAyLCAyMDIyIGF0IDA3OjUyOjQwQU0gKzAwMDAsIExpdSBZaWRpbmcgd3JvdGU6DQo+
PiBUaGlzIHRlc3QgcmVxdWlyZSBzZWN1cml0eSBhdHRyLiBTa2lwIHRlc3QgaWYgZnMgZG9lc24n
dCBzdXBwb3J0DQo+PiBzZWN1cml0eSBhdHRyLiBFLmcuIHZpcnRpb2ZzDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogTGl1IFlpZGluZyA8bGl1eWQuZm5zdEBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4g
ICB0ZXN0cy9nZW5lcmljLzY4OCB8IDIgKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9nZW5lcmljLzY4OCBiL3Rlc3RzL2dl
bmVyaWMvNjg4DQo+PiBpbmRleCA0MjYyODZiNi4uZDExYjRjMjEgMTAwNzU1DQo+PiAtLS0gYS90
ZXN0cy9nZW5lcmljLzY4OA0KPj4gKysrIGIvdGVzdHMvZ2VuZXJpYy82ODgNCj4+IEBAIC03LDYg
KzcsNyBAQA0KPj4gICAjIEZ1bmN0aW9uYWwgdGVzdCBmb3IgZHJvcHBpbmcgY2FwYWJpbGl0eSBi
aXRzIGFzIHBhcnQgb2YgYW4gZmFsbG9jYXRlLg0KPj4gICAjDQo+PiAgIC4gLi9jb21tb24vcHJl
YW1ibGUNCj4+ICsuIC4vY29tbW9uL2F0dHINCj4+ICAgX2JlZ2luX2ZzdGVzdCBhdXRvIHByZWFs
bG9jIHF1aWNrDQo+IA0KPiBJbmNsdWRlcyBkb24ndCBiZWxvbmcgaW4gdGhlIHRlc3QgcHJlYW1i
bGUvc2V0dXAgc2VjdGlvbi4gVGhleQ0KPiBiZWxvbmcgYSBmZXcgbGluZXMgYmVsb3cgaW4gdGhl
IHNlY3Rpb24gdGl0bGVkOg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcG9pbnQuIDopDQoNCj4gDQo+
ICMgSW5jbHVkZSBjb21tb24gZnVuY3Rpb25zLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gRGF2ZS4N
Cj4g
