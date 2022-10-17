Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB99C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Oct 2022 10:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJQKCd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Oct 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiJQKC0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2022 06:02:26 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 03:02:23 PDT
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C415F12E
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666000944; x=1697536944;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AbxkfOec1+isEQdR+zRRMoq9Z7pmFjQBOd4tC+P1MJk=;
  b=UE3yfxwW7SPhwNIQboAzaXj+2bu+EfCzBPndQwldpnCNDLNOrNjV4cET
   zNlvs64E1Io9ZQs5+NZTZbO97VwVS/ifnAK9Zp0WSMgNjGLY8pGUNq+no
   /zhPm7Gtc826AemA3cIliAiVdo05fL6lpmNTYC9JDKIJeR+ELVoQZOvdu
   uH42iP7+atYA1EzFnsYNpQJ+hS2aNAL6z62JpPFAAOyng/Ns9es5X7V/2
   pJGgXWCZ9n+3uyvd4/hEnzNK+TfWKZJdRkgmwiy6IS47Tcv8TyhgMCeyI
   EVNsLeG0t1PH+zKiKmfyMpH75Gde9X031pCK2laW5EzEsgOVkrow1w1bJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="67771102"
X-IronPort-AV: E=Sophos;i="5.95,191,1661785200"; 
   d="scan'208";a="67771102"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 19:01:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1BwgWQvaZopjcO+55DqKTROLehR31KUynf15gPnLl6o1uyJq0ZCVOJaCz9A6c4h8oSeg+bEZa7jaiFHIGBpe3nV9hr4zjgtfzwZCDPnXf34p2/lCicIJEqE57NotlQXuXBwbvZ00nvtu075BKjctPDQAJFJKcygdJzUpFP0mCgdiOHUPNDuu5LnWaRAGrrzF/rytBosTIJOFV+uEN8/DLy/iHo6N/39rdDpXIgucna4TJXJDR5a1sHJQzB2SXWfwDqs7Y3TAzrzf2NWL9wa9QrQT622X/0TpoLRw3dhGQrQ8PfYYJBqzaI81omyVgDJ2BgSnYnoTkEGuIoJRMsP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbxkfOec1+isEQdR+zRRMoq9Z7pmFjQBOd4tC+P1MJk=;
 b=Q7WUq6JuFvF7tSuZlijx4IojqXndlC1Pue+so2wPBw6K4cyMIYnhpJbJTHBPkddNgranbBxxjKVfuvI/ZIiqXIXbxMJMp/hl7H2e+S90mhkdNfpE+pAdPzfogKM3S4QnQLR9u0jr4ejcxIcD0voKuXjbnE2TdTdaIQZDogP8mzPbIZpkBZ1rNECnTDHfhVcR+OVn2k3Z5knWP807oBTxj0JPgnoVYAJ9Omc2RWWwcDkGl4NiVN3rIpEEsDQq3MfjlAC+DoNAvab+bN5ClpS+EvCpQNUkkQH45Ko54e+0sma1ryYNn4uedkkDbsa5+lyMgsAm2BVSm9YpiTHIU20/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSYPR01MB5560.jpnprd01.prod.outlook.com (2603:1096:604:8b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 10:01:13 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 10:01:13 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>,
        Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/193: add to perms group
Thread-Topic: [PATCH] generic/193: add to perms group
Thread-Index: AQHY4g5QDyONrabejUiewQcnM/I9gq4Sa6oA
Date:   Mon, 17 Oct 2022 10:01:13 +0000
Message-ID: <7eb737f8-5fb2-97ac-6ad7-eb1ce8a59f30@fujitsu.com>
References: <20221017095311.68280-1-brauner@kernel.org>
In-Reply-To: <20221017095311.68280-1-brauner@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OSYPR01MB5560:EE_
x-ms-office365-filtering-correlation-id: a1910245-3631-4f36-e834-08dab026860d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GA+mS20vQX2TYxWxOqneNsUE+dbL1ChfPCP+GU/GPFexj5RYwtUJSkzZiodxfcAJwX2ZcVrnFQCWCZTDezvCNurjHLTTtX8owirtpZekviXFY/jBOrYPX3rxojXBqwPjfEIyHwxaNZwJHrr1FpwCjvqKWVC/Fv9YdhWfpKzC+Tmy8AlOeWMEF8JGyARYTRUR0WKzpS7+XLpeNSAAYdI1KgDZBa4XzRXBaCtpoUGzjo2hRu+H4Y4awOm3w/WIqyxmUVvTszExuD+TfXIKHTOLBt6qbwpc6yDJ1KiV1VGSG3LCZi1Klwhf2dTJ1ZSpRBApeFN814Dh5FSC+epFsYV1ncuN1r5H+Zg26GC0plmZMyjMjpWyelUWrCWJNQGxEiAVVEJhJzyblphpBCX9MAmlAGXF3pcxoEUiw7Jsh/AF/6yqQdPKIn4suIvoN8OPBdI/qRswk7zJq4a9kKFhChw56OnyxEz/KTCulVOeSMynBpC/3KqcqXOhCZD2gtzlJEovWsDW6HaDiXOj8uQ5mexUeMj3uYhsZSocEWobsh2SQFJOFHZHszRhtXK+OzaC3QeoFSX/CpQWLTgdSJzywN8w9lXRCZkI+kZSB2QgilucCzIMKm1qjup8p9nUDTskFJq/DEXET7ESDsbRdQNpSXeyqP9Agmor244u3sQqVhTeNSJZrmoPVNPBeij11rcJohsJ6WGPkoipT22nef02YE35x+xcmPRI5PL2wKZyPY2obGxvvUIwvJS74EsPQz6MlfIIQWz2422fO1sjhPrzz+sd9bTqAjkscS5eVF3S5dd3k8oPQ75wrjhkXUrjhanDEtx2FkgVnNUQBaijSpU7OwhWQois23FbXffd188cUWrnFrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(1590799012)(451199015)(6486002)(71200400001)(186003)(2616005)(83380400001)(38070700005)(31696002)(86362001)(122000001)(82960400001)(38100700002)(4744005)(5660300002)(2906002)(64756008)(41300700001)(8676002)(478600001)(110136005)(6512007)(6506007)(26005)(316002)(66476007)(66556008)(66946007)(76116006)(66446008)(91956017)(45080400002)(8936002)(31686004)(36756003)(85182001)(1580799009)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2l2anZqQ3J4K3drRHA4UmZyTG5JSlN0RkZEajdqMFdZdFdRMlZaT1ZuOFV5?=
 =?utf-8?B?clNJWkp1RXpPbjZJTUtTN3Q2QWNiTkRBZTlwWVBlMkN1T3hYdy9FblJ4V29P?=
 =?utf-8?B?eldRcFZWRm1oWEMvRW5rTGhqTkd2Kzk1YWErcTRQL3d6VDNuZkwxNlRIN09S?=
 =?utf-8?B?SEZnR200TjBmZ1IwVGs4WkF2eENFaHNOZGE3OE1WUlpIQ1pQZlZsUm8ybEFO?=
 =?utf-8?B?c0ZLb3owSU5oaU5RVlFPZ0RKc29ydlh1d2I5c0lZY1c0RmFkbGl5SG1XZVh4?=
 =?utf-8?B?eHNqSWpMdVdMVzR3ekkvMjZ2Rk44aHlhVUkzd08vKzZlM0lGdW5QYXd1cGF6?=
 =?utf-8?B?ZUppYmYrQzVxYXZNb0lCS0VzNEt4TXZsNE52MjV4NHIvSnRsYWhudFY0bGFB?=
 =?utf-8?B?MEE0TGZNUG91elRPRWU2czJCNXFNZVJOYkFCbEdiclBQUmhHSGxJZGFGR09n?=
 =?utf-8?B?REMwZUk5d1NEZXJLaXI1Ym9JaDQ0alZPL3VTbDZ4eXpjQktkZ0M1UlN5TjVi?=
 =?utf-8?B?Z3diMTJnbFdna3FzQzZRWkdnandMTUdxTWZlTnBPY2xuQSsxTndkZjIzUXFj?=
 =?utf-8?B?M2hyazl4UE9OZUJ3aWs3UXFtdmYxRzVObXBBdWJIUHVVNkY1Q01kdXZSNmFl?=
 =?utf-8?B?c0NhSk96NGQ3UWxCanU1dG43RWVKWm9LdFBEbks5d2NSejVmcHptMjJvYzJH?=
 =?utf-8?B?K3pza1JUa3NlejVSNHBBcmxoeDRYak0ydnVtNk81U0pXNXJ3MWlxaG5GU2tC?=
 =?utf-8?B?dXRCY2Z1ZDZHK29GUkxwMHBMQXpUOEdVaEM2SUdERVFTTVJENzAweTZjUlVy?=
 =?utf-8?B?VWNQWG1IL1U2cFRlQzd4bmdlRlF0azBpRTNHQ05aYlQ5eUkydzN4ZTl2WWFq?=
 =?utf-8?B?VFlqY2s1eWYwcnErdGF3NGVqSTJvRkZ2YU5QQ05wU1N1dXZrTG5EUUh5dUdR?=
 =?utf-8?B?WUJiTnQxT0t6VzZjcno1aXZreTNmWVJoZGRCWmU2dG9udkxlMjlhdDBBZ3FL?=
 =?utf-8?B?Ukt1eVBFRHZRS3ZRS3VVeG9qeENPS1AxRU1NZVFIMjlyZ2N4WkZIQ2RWM1cx?=
 =?utf-8?B?cGVsbkRabnZQMm1RZjJTVmx4Yyt1b09tOWtPUFRsbEJ3dVB2NWR5STQ2WXhw?=
 =?utf-8?B?YjB6ZEZzMFk4WVRjZWN6bWNhZCtvYk5zajg3VnBJRUFLZndrL1hoMnZGckZJ?=
 =?utf-8?B?TTQ0a2R1SlgyVUxoM2E5bmJ4cS8vYnRPbW8veEI2WEdWWU5aZ3lUZHQ2VEpF?=
 =?utf-8?B?ZXJVbjNYQkZYWFpJTkpUU2s2S3hnVGZKQk1BS0ZTd0haRm1uUG5ZQ2JuZnBF?=
 =?utf-8?B?ZjdDRTNublR1WmhrOU9vV0c5ZnBaNW94ZEt4UG9xUEJ3d0ZIc1pFZnhCVW1o?=
 =?utf-8?B?d3FDZzdRVTZBSHBkK3RzZm4xYnc4cXIyWEUxYUVrbTZOWEs0Skd6ZDZ4WjhB?=
 =?utf-8?B?OTNaNi9qSmp5a0dtZ3FmRWdBejgwVzRyL04yeUw1bHNYdFEwSk53V3NGOVVP?=
 =?utf-8?B?N3ljR2FMNVFCRSsyeFBZWGdIMFFIdnEyY2x3ckQyK256TVJnOG5COGpYM2FD?=
 =?utf-8?B?T1JscnJ5QWo4U202bTBTN21kbzdVdUk3Z2d2WktLQTN0eVhmb2NYVE9DT20w?=
 =?utf-8?B?WmJrMkxjT083Zi9DUGZhWkdTMzZBTDk1V0wxY2VXYSthSlZWU0t0akpRY013?=
 =?utf-8?B?R2l4b0tQbGZ1Rk1KTCs0Y0MxR1hRWFBra0lsOVljNy9XV2tWRUZTcThRTUVs?=
 =?utf-8?B?cWprVEU5cmxqMGg1OGYyWk1MazJYQ2Q1ZzN4b3pzaDhvNjRmRUl4S2JvYWxm?=
 =?utf-8?B?ZEFVTUl5RElOSjduK1ZtZ2NSWmpXdE5MRHEvWmhKYURyelZOeUtsOW54QlE3?=
 =?utf-8?B?RWZzR3hQYTJ2R2Z6YXFUSFJEUlVjblk4ay9xQzBXQUlpNXRSK05lK0JOcWI1?=
 =?utf-8?B?WXlNNlZlYWpQb05QckxaL1IzM0dBNEpNVGJrT28rQkpYOVhhcHZUNzlialpO?=
 =?utf-8?B?dFRFcHVIc3Axc1JwRVpRVjRPclkzWmxQU0RKajJ1ZGNHUDlVOHZoUFpra3hv?=
 =?utf-8?B?OWtjdnFBSlczT09relhLVXZvUjlzZnhiTUNsdFhrbW13UkFadWE0alVDNVVa?=
 =?utf-8?B?azhnYysvNno5MnNaMERDbklNZEZEbTM0ZzgyZkljeUswbVV2dDU5SW93Sk1H?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA03E484BE6164448E96C61EBF0DA7BE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1910245-3631-4f36-e834-08dab026860d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:01:13.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AS1Fso9ccwhqKjkn9amZxQ85utRSuaZbUt9dEWupJpRdxhHLSJmi30dzR54uq0Rv/0+TQDVggTh0WsyhfTdxs8YbeskbgRugWChShfzd7RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5560
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQoNCm9uIDIwMjIvMTAvMTcgMTc6NTMsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBUaGlz
IHRlc3QgY2hhbmdlcyBwZXJtaXNzaW9ucyBhbmQgc3BlY2lmaWNhbGx5IHRlc3RzIGZvciBzZXR1
aWQgYW5kDQo+IHNldGdpZCBiaXRzIHRvIGJlIGRyb3BwZWQgb3Iga2VwdC4gSXQgcmVhbGx5IG5l
ZWRzIHRvIGJlIHJ1biB3aGVuIC1nDQo+IHBlcm1zIGlzIHNwZWNpZmllZC4NCg0KWWVzLCBSZXZp
ZXdlZC1ieTogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCg0KcHM6IGdlbmVy
aWMvNjdbMy00XSBhbmQgZ2VuZXJpYy82OFszLTddIHRlc3Qgc3VpZCBhbmQgc2dpZCwgdGhleSBz
aG91bGQgDQphbHNvIGFkZCBwZXJtcyBncm91cC4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoTWljcm9zb2Z0KSA8YnJhdW5l
ckBrZXJuZWwub3JnPg0KPiAtLS0NCj4gICB0ZXN0cy9nZW5lcmljLzE5MyB8IDIgKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90ZXN0cy9nZW5lcmljLzE5MyBiL3Rlc3RzL2dlbmVyaWMvMTkzDQo+IGluZGV4IGRk
YWZmNjliLi5lMjcxMGIwNyAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvZ2VuZXJpYy8xOTMNCj4gKysr
IGIvdGVzdHMvZ2VuZXJpYy8xOTMNCj4gQEAgLTcsNyArNyw3IEBADQo+ICAgIyBUZXN0IHBlcm1p
c3Npb24gY2hlY2tzIGluIC0+c2V0YXR0cg0KPiAgICMNCj4gICAuIC4vY29tbW9uL3ByZWFtYmxl
DQo+IC1fYmVnaW5fZnN0ZXN0IG1ldGFkYXRhIGF1dG8gcXVpY2sNCj4gK19iZWdpbl9mc3Rlc3Qg
bWV0YWRhdGEgYXV0byBxdWljayBwZXJtcw0KPiAgIA0KPiAgIF9yZWdpc3Rlcl9jbGVhbnVwICJf
Y2xlYW51cF9maWxlcyINCj4gICB0YWc9ImFkZGVkIGJ5IHFhICRzZXEiDQo+IA0KPiBiYXNlLWNv
bW1pdDogYTc1YzVmNTA1ODRlMDNjYTc4NjJhZDUxZjQ4ZWZkMmQ1MjRkMWRjNQ==
