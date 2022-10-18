Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6845C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Oct 2022 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJRC3N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJRC3G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2022 22:29:06 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 19:29:00 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9098FD76
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666060140; x=1697596140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mZ3gMxHULXuDwM33ih0F7GZppEvARBtlrDJN0ZF81Lo=;
  b=vPTvMM1Wmfd3IL/Aotmy8z/d2EMqgUM6tbY90YbjebUIrOje5fYldhID
   i7JS2/JhVUwDws1oAlPu0aOtELOg0HlYBqXLWTTYlB0n5CCOznFEFQH1q
   1slgtF4HVKseoN8xC7kfAejcCXRg9pZsAnE8qsurzne9CZj6yiICQAaX+
   T7PJkiD/MM/FI9P/1d3PJdmdCiJ3g4j3YKbMpTJl+P9JlBEuIeCGmqJPq
   OWYsser33e6GpVv0F8LFOftfly+STBNLHgALNvz2rR5jaj6UE9rDNMwaC
   jKSa49iWS2EmI/slzAk+aoxJsmUlQlhk/QrqU9Z/sx00TOjv9PlScb42W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="67666769"
X-IronPort-AV: E=Sophos;i="5.95,192,1661785200"; 
   d="scan'208";a="67666769"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 11:27:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtmAWhLR7isrbH0ti+3RPcJE41bvkhvwbXWMWxNp6vgPqEVi9Tnj/TVnZqeJoCR+YeqOavlF78s+PV09MNqH/9a0iz/GrgompMlUJqCJyb1TI7JWzM+BL2HrnnWuFF3mTjYm75XaGIXmg6yLD5XqBkvPfsVte6DP5f/ROkkvOqmGpUMuYJg0f6/jijcIhueEdK+QSSSRxVuL+eZNzJjpMLks1DF4pcF7tcCu5tPkm9jLZheL6kFLS8hHrSpa05h8Setrn7F4ccvChckOcE6S1RkddCcwNItmyAGklKDbos5P+bNYzytCDnC53QO2Wk/jB6glHMVuF5OyHubgyt225Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ3gMxHULXuDwM33ih0F7GZppEvARBtlrDJN0ZF81Lo=;
 b=N29RBbPQp9KAHOFWniV+QtbnJinwvoSW9dJNQOEu2HmLS9ohxJUZcfNtpGRnGy5kaDtkz8heJD1qWHlDQHh3xzwfRlmLDiQ6ZCTUY201htmEf4PtcDtYNMgLsRpkz4FAESPEjME1EwEOZIFNGN+y3jzi8bwoG/+DAHpbzwRt8azsIuTJGd2r3cb+MLHS9gM2SDKr7gjBdqOcjRD/+vkLPEwyp7qsFWOk52ftxZD+0OPWsZHjn7hX3vzUgGKev53Weo6yKEW0UgJaTlsfm9bFlpl083mxmMNTvIviv2VruKMRWggnAlmx1hFO9k+YXx9iLglNFJUfUbrJmyJo7dgt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS0PR01MB6067.jpnprd01.prod.outlook.com (2603:1096:604:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 02:27:50 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:27:50 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>,
        Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/193: add to perms group
Thread-Topic: [PATCH] generic/193: add to perms group
Thread-Index: AQHY4g5QDyONrabejUiewQcnM/I9gq4Sa6oAgAApHgCAABqEAIAAz+iA
Date:   Tue, 18 Oct 2022 02:27:50 +0000
Message-ID: <3d37367c-9363-e192-163b-4daba2c73a0d@fujitsu.com>
References: <20221017095311.68280-1-brauner@kernel.org>
 <7eb737f8-5fb2-97ac-6ad7-eb1ce8a59f30@fujitsu.com>
 <20221017132914.zj3lou5cizuuxluv@zlang-mailbox>
 <20221017150408.ddda2hpggg5x7ljh@wittgenstein>
In-Reply-To: <20221017150408.ddda2hpggg5x7ljh@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS0PR01MB6067:EE_
x-ms-office365-filtering-correlation-id: eca7a932-e811-42f0-7fc0-08dab0b05a7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IoBoDAtpO5jVcWadxFgPdliXb5nVVWbuqIGSNVvWlcD+R3+aQhojBAC1Q3GApfhQHSaLdBVJR0EXgAZ8bcpQcuIiFeX7cS7MoizVh2OIAIIbVNc4mysAcJ3QqNwct7lNdPjay4O0nOijWb9Ec4NQof8/AMXM48YEXe/uo11b7eOWW/Rj/IJpbDGjqxlOY2nIGcTACaxPPDyr6z7850/w9gZzDRH35UBD7FXJ+gKbEcBrYRhc4fI+OiSiGDCA15BCbLsOjOouT/mLz7DNk+24tQ8BxhvApwmzqSULY5tGE7eKClqK8YkiIpkfN320IPTXUIgADO2YZVI//Wxz+OmyODk4EDfFpX9hJhfgeOjnETo2AXkd+btuA3zygPT2PZ9MSnfvIGkaCwtTNmOX7hTbE7zKaTEMePyMW7QYjq5LnCH1Z9DO5L7ZvSkrQQJfojwbDNLMPAOOrgr4EnfTNG5iaSpbmx8yiVDaTYoY5JAshoo/B2A5MxQrmGp3OvR7+lKLJtcVi/v54Arnc/exC1IsKLzSI9CmP+beyTsDR59HWVCiRytqxMLBUk8m5ZjxXM4farUQowjyevWpbSb47ZB3B2O/oKNtTtUfV6iEQatFBeKE6+Wk03cjbP+8xREQ/6yVJZzXvf2/t/wERCJMntZO6I4gjLfwhL6uECt5ubYqEle2XD45awk41UeC/LbbTBR+JHIFJ7cFQvupK4T0nrFY++kRbhHxNOQ7wkFKOwMGdDsSQChDWRXiXk0iBT5k1Ka3oQdlaCIQ7HGG9fzvXA9wzo1gAKN000eTKoug2Ab6HH1wOePKhlgrRgyz1UHLpeG4BD+YBwARmRpdBZgKJfCe98EPdYKdDPN2ZJYNe9poJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(1590799012)(38100700002)(8936002)(5660300002)(31686004)(122000001)(82960400001)(1580799009)(6486002)(4326008)(91956017)(6512007)(6506007)(26005)(76116006)(8676002)(64756008)(66946007)(66446008)(66476007)(66556008)(316002)(110136005)(4744005)(41300700001)(478600001)(71200400001)(86362001)(31696002)(2906002)(186003)(2616005)(85182001)(36756003)(38070700005)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEtjblp5YitSOTBKZmNRTTVwTVI5b0thU3hObTJMVm04YzNhMmZwdURQNnMr?=
 =?utf-8?B?WTVreUJNUHBxZ2RPVkVBcUtybXViTkN4R1g1NTdVU2Y1Q0RuaGUzaVpnMGVa?=
 =?utf-8?B?RUlsZlRoUm9MZUpYdVpKV3lWZDl2WFJVYzloSlBFeXZoVVVOVXMrc1lRMnla?=
 =?utf-8?B?TUlJSW5saGozUXBqMSs3cndYazFYa0c2WnhUOTJZc0JTSk5pQTdwL1EraGNr?=
 =?utf-8?B?ZFNWTWc5R0JidXhVR3k0Tk9oOVNYT0J3bUhqKyt5d1U2TE9JdzQ2NVRPVTF3?=
 =?utf-8?B?UElFWlprdU9qNGdGeE5KM0lpREx2S3NYTGpPK1BXelJUeGE0YWJ5bS84UGNx?=
 =?utf-8?B?ckJVZE1mRkM3Uk90SnVBeFlXUU9JTnhyaHNLS3ZjVTFCWlllcFJOdENzMzFh?=
 =?utf-8?B?K1FaS0p5dnhibEhwWFZoUFp1aGZJWDA5cDlhc0RNeVlMTFhESDVhczRGeHJM?=
 =?utf-8?B?YURxTndML05mTENKTFNvYnVPRnBhbmxkYXc5ajRISHpYdGR2KytCZlJxaDc3?=
 =?utf-8?B?KzBuQU1UdmlBUDRzdDhSMHNyTTVpbGwySEc1ZjR5N1A0eDFBRGsyUlZMYmNp?=
 =?utf-8?B?S0tyU2xzRHJQSmFBNEVMQU0wTTFaY25qenVQS3pkVVcxZm14RjJaUzBQbStx?=
 =?utf-8?B?MHAwek9iV3NZMjBQTGtGMU1kYkplMEZQOHRjbUt4RGNkMVJlVExBTTQrTk1I?=
 =?utf-8?B?VWVqb3dtbXU3TGZJUlgyYnVpZWpRZC9WemlDbUxFZ0ZNOUNVTGdTcVhBSm11?=
 =?utf-8?B?eUh3MEI2YzdWVDNZK3p3UFNmMTBTN3JCYnlhUFJrVnowZGlRWHMvYytDclk2?=
 =?utf-8?B?NmQrUmtrTEdiRlQ5QnhNMGIzMVZXR0lwck1mTyt0NjV5U3hnUGFsdS9XSVlO?=
 =?utf-8?B?UHZ5RklWZ2pxRWZadEVMQUs0OGpiVFBnU3NMQm1JbmVIV3RZclJGcnpXL3ky?=
 =?utf-8?B?SXRsbm5kbDUvOXA5MWg4NmdkVFE2U0RQUTQ1QnFJUENEZXF1MlVvMGF3aXVn?=
 =?utf-8?B?NnpFTWNzMTVaNjdXcGxwK0FvTVVHLyt6MS91ODkxVzVXQXdjb0Y5NTF0VDI0?=
 =?utf-8?B?YmFjeFZuRVFpQUpvd1RzMStVY1FHaTN6QXNxQmszamE1d0Z6bUUxNkVsMUNj?=
 =?utf-8?B?MG1mTU5FMmMzbmQrK0FYNDRDbDVSbXMrS0twYzE2K3ZlM0xvM2llWDU0dWNi?=
 =?utf-8?B?bXlpM3BqMzFuVWNKV1BLZzRUbm90WWk4VThWUjFVb0NIcUlBZ05SbXBmVkww?=
 =?utf-8?B?ejRJbWpRaVUrbjd4UHo1ZHBiZEU1SXlLb29OdkRDUGVmWGl5UDdaaE5iNVJS?=
 =?utf-8?B?K0lhNFhCK1RpZ3BmRWZKbitMbk42WDRzWm0zOGJWd2tnK3pGVnBhMERIbTBt?=
 =?utf-8?B?SmF0Qk8vaUl5eWJCY2FiNmROaE9kSTFiYVBObldFdi94Z012R2s5Wk9lcjJQ?=
 =?utf-8?B?SG5ya1l0Z0lYQUlmVVBUNk1HZ1oreUdzZkcweXhQcmZaNjlzZUVJSUxqbnIr?=
 =?utf-8?B?QitiM0VoTDVDMHhTbHRualJnUy80dWhYUkhGblYzdG5kSHIvdVY3OUtQV09P?=
 =?utf-8?B?UlowTEVvTkJCZDdsTXhTcy9lcWR5STM4VUFpTWxoVVJvaHpHWXNLdE4yVmdS?=
 =?utf-8?B?eFNsUDllTjIyYWtWaUU2NFUyNUFvdmUrdTNBVTFxY0ZHbWh3NDEyWnNoTG9B?=
 =?utf-8?B?S0dqRVprc0dYQ2RKWjlzV0tpcEtjNGVtNG1zL2Z5cG03dHZrTGJJNWFtS0dw?=
 =?utf-8?B?am4xLzhFWGtZY1ZlbU9tckxRcWFlRDgwREQySnEwTmozZEpLNVJ0TzdxTlp1?=
 =?utf-8?B?clllRGcxRktCQXdGMU43NHkyS2s1eUNDNmNpZVpwZStXclFvRmdFQ0UreXRF?=
 =?utf-8?B?TjZRZ0g1RW1TbWZKcFZpZXlNMGJ6RWxPa2Z6bU43Zml1cXlOWG5tL0lUbXBI?=
 =?utf-8?B?dTNVNGozMW96NmhrWTRkWFpiUVkrQjVjdnRWQVdLbGNMeDgrQTVlLzFVTEVQ?=
 =?utf-8?B?TUtpS3d5a3hWWE1GajBYRTBzMTdDVkYvRmNCc3N5aGRIK0xBWDJaVWEvamR2?=
 =?utf-8?B?aVQreWtOSHdxNTlkL1l2NWxIcGNTZC9xTitBSVNqdytkSHU4UG5aeWJ0VUFL?=
 =?utf-8?B?bUxpSHl2bmlEVTRQZXk2aWN5Q2IrcHhmbTNDQ1puWEl1aUlGcWRQWWk0WS9R?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46EB1AD8DE4FD44CAF03D20EEC5FD78B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca7a932-e811-42f0-7fc0-08dab0b05a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 02:27:50.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtSuMSYCZS1lGffvKVdw51uJRUbQ7QSoLalZifoCuumuzImBZZbIpwSbDBpbQhQLy6gyg6xh13g9ahVhHAyO8q3j+sY4mjmMjVTL53fkRh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6067
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQpvbiAyMDIyLzEwLzE3IDIzOjA0LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gTW9u
LCBPY3QgMTcsIDIwMjIgYXQgMDk6Mjk6MTRQTSArMDgwMCwgWm9ycm8gTGFuZyB3cm90ZToNCj4+
IE9uIE1vbiwgT2N0IDE3LCAyMDIyIGF0IDEwOjAxOjEzQU0gKzAwMDAsIHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IG9uIDIwMjIvMTAvMTcgMTc6NTMsIENo
cmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPj4+PiBUaGlzIHRlc3QgY2hhbmdlcyBwZXJtaXNzaW9u
cyBhbmQgc3BlY2lmaWNhbGx5IHRlc3RzIGZvciBzZXR1aWQgYW5kDQo+Pj4+IHNldGdpZCBiaXRz
IHRvIGJlIGRyb3BwZWQgb3Iga2VwdC4gSXQgcmVhbGx5IG5lZWRzIHRvIGJlIHJ1biB3aGVuIC1n
DQo+Pj4+IHBlcm1zIGlzIHNwZWNpZmllZC4NCj4+Pg0KPj4+IFllcywgUmV2aWV3ZWQtYnk6IFlh
bmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+Pj4NCj4+PiBwczogZ2VuZXJpYy82
N1szLTRdIGFuZCBnZW5lcmljLzY4WzMtN10gdGVzdCBzdWlkIGFuZCBzZ2lkLCB0aGV5IHNob3Vs
ZA0KPj4+IGFsc28gYWRkIHBlcm1zIGdyb3VwLg0KPj4NCj4+IE9LLCBpZiBDaHJpc3RpYW4gYWdy
ZWVzIHdpdGggdGhpcyBwb2ludCBhbmQgd291bGQgbGlrZSB0byBoZWxwIHRoYXQsIHBsZWFzZQ0K
Pj4gaGVscCB0byBjaGVjayBhbmQgYWRkICJwZXJtcyIgdG8gbW9yZSBwcm9wZXIgY2FzZXMgaW4g
b25lIHBhdGNoLg0KPiANCj4gSSB0aGluayB0aGF0J3MgYSBnb29kIGlkZWEuIFlhbmcsIHdvdWxk
IHlvdSBiZSBvcGVuIHRvIHNlbmRpbmcgYSBwYXRjaA0KPiB0byBhZGQgYWxsIHRoZXNlIHRlc3Qg
dG8gdGhlICJwZXJtcyIgZ3JvdXAgaW4gb25lIGdvPw0KDQpPZiBjb3Vyc2UsIEkgd2lsbCBsb29r
IGZvciBtb3JlIGNhc2UgdG8gYWRkIHBlcm1zIGdyb3VwIGluIG9uZSBwYXRjaCBhcyANCnpvcnJv
IGFuZCB5b3Ugc3VnZ3Vlc3RlZC4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1
