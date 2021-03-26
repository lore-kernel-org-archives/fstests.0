Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3738C433C1
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7700C61936
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 12:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCZMXe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:23:34 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:37299 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhCZMXP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 08:23:15 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 08:23:14 EDT
IronPort-SDR: a2UnGuKn90YuBIHpRtAMIJ6lyzlk+m0DwKA6yn/hhzhx+k3IzxYfGFpg/Z6JnQHIh7l1seS5rw
 7UycZUl6JJfkQpGOGFkNj74dE6/aN5ctbG2Kv+GLBIjVYJdX4j0OTJjQilSkadfyPbQapttEM6
 BcpOvxesP0ECrE0krbv7C/th55eUwnO0iYQ6NHs/KahQy05Yype5csL/B5H/TkVpJBY4UM4VeL
 ZLIGqK59eVJE8hc5jJbCN30O5B+5g8heGCLT6N4Q6BDiu1wNsQM28xAnW7PX0SQOIzM+ZQ7ndV
 loU=
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="28526474"
X-IronPort-AV: E=Sophos;i="5.81,280,1610377200"; 
   d="scan'208";a="28526474"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 21:16:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GslE1EhQlchiY1uEEaC5giPG1JpbxDDPaqJGthpKTrGSZF6iGW1I82LZCzK/sXIHtIuDfl3ng0Dsgo+XXvztuGh8es9pznvxOY4Ja2hXQBZGJwH1cti5Fx7BOII78HdWDP+sndnAR8uITZ1DU0s+WdU6n22kjczQgZLQRRzNmaEHCI2yqmd80DHJcizuNWZZyrp04/5wx914o89hZiznQPd9tWzN40GnvKMdtqtVSMXq8Jget6nxM8xugPToNKS1MHdehiEQmwvTP1ybPzKYJhHVXy4KQ6CFwTQe+pUKBGXZYbisi7cmJUkTObHVl82FciRiwxL5SV4Ugfp2zNZdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFl2sEyLSQvIK3LrX/l98OZADpCSmzcyROd6Z2r7dU=;
 b=PfjtRxRvtzO0hNOBIC/ns3Uuj4Obi8zwZEQ4IcsQRaTVKOtF63SG6mVXiT0tjheuEXwlqqiGndxE9eOw1kFtJdZcGLaMDRUfMpRC+8S2lnrjofrUQmHJOVNBnNsbycgrMAOyeeYg1JYnlxvQ30ZyjO5JRIq/NYksD6/IeKeyaEoET/qxHD/0+2QPqk7pg0x/zAyDbzw8x25clqcdAoJhkX6ZHfc03adUrwwwa4WqDlpkF0x8SK5y20sGRy27vmc+B3ehD6MO5svIt57cH4edCrm8Erxh9SKFKk8tvUeog5gT5fnhzyHKVD98lX+wfELPV8XXl5FXa8oA+VSUFNAz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFl2sEyLSQvIK3LrX/l98OZADpCSmzcyROd6Z2r7dU=;
 b=NhTJrEdH06QYj2agG8fMKmDnjiTa8YwGPgBXbGi2Z2gkAwTt44UBRDLzusgqGyGZVRUuEqjiphbOP9qs3VAAPpC0oOPPpPrgPMj0mbYcR63XKWPAawWeKF0+67rHExrNcuiyU8rflSbc1GQ+hKXcOD/4hjjCatiz9JY1Hq07M8I=
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com (2603:1096:400:99::12)
 by TYAPR01MB2414.jpnprd01.prod.outlook.com (2603:1096:404:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 12:16:01 +0000
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::a8b2:74bc:1c83:eef0]) by TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::a8b2:74bc:1c83:eef0%7]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 12:16:01 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "lihao2018.fnst@fujitsu.com" <lihao2018.fnst@fujitsu.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 1/2] generic/608: Remove drop cache and umount & mount
 cycle
Thread-Topic: [PATCH 1/2] generic/608: Remove drop cache and umount & mount
 cycle
Thread-Index: AQHXIjiKJ7n2mB7pPkqzemYi5O8yaKqWLxYA
Date:   Fri, 26 Mar 2021 12:16:01 +0000
Message-ID: <605DD078.3090107@fujitsu.com>
References: <20210326115558.7348-1-yangx.jy@fujitsu.com>
In-Reply-To: <20210326115558.7348-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dedf8540-59e1-4138-8a29-08d8f050ebb4
x-ms-traffictypediagnostic: TYAPR01MB2414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB24144D9E7C93855F7CDC202983619@TYAPR01MB2414.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyjoV4aq2Ks24rj0dIqk3zqcmQWRdB3LGZPpjhgtWfa9NzBcsGoD7Smq3A2hDRN2SAx4dfz47fBmgPBOkZ/nBmt/k8CqRGALNLLlV5Fq+VPEikbhrwxlZugkP33bAMqUCMIL1EB6yJpWrBKM+0I9lzCjRdWtyj/mexX/kAiN8gBUZ8VNwXqdxObS7VMcx8HOQSGBZ3LSKFd3Sqi0+jb6tgysG0iS58GKuHiY0CPYG5G5q28ox60YU4V6DqiB/fEd3Y84mV8iFgec+yJoarJMt9t0keZP1G5n0Vb4H9LTcNz8JuFBNbeiMY/QU1i/Pqaqjkvq/R3wqvtdg0XgxQpn3kuQ7h7UJpsKA50s0HdVsscLodYJHKXyOazDvLcX8B2De8ua/yC8mC4QKy0Fi/QiHvFV8kIYkaBisfaySPxn9Chix/qqkCbYh+IT4H0XT8qyG5jwVrHdWpUEmaPTqL7bGTbRb7tHbJmv7LP4sQqdWvHd/aOxKgKbE96px0t61ehF3Omev2Pc+/lRbQuHApiU7ktEEMYz2a+PqSwRCkA6z2q6SfxoIXe0FmSsDfo3gwi/yyV1dWcn9J+celgYP+G+BAKWrAQGoVLRNVQ40xzmJQZGaJf9GsQ7KJzR/atJefRMbQZpA0SHBTmA6Ah2v/TZv65C0v2BUqPmImPo60B8KAjZ1ziJavr0eHVw2o5tJTBh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6382.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(366004)(346002)(376002)(71200400001)(8676002)(33656002)(37006003)(54906003)(8936002)(6862004)(4326008)(6486002)(38100700001)(5660300002)(6200100001)(66476007)(508600001)(6506007)(83380400001)(87266011)(91956017)(66446008)(66946007)(66556008)(64756008)(186003)(36756003)(86362001)(26005)(2616005)(2906002)(6512007)(85182001)(53546011)(76116006)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?am1Pa0owNVNnb1VsVzhWYVpIRFdPTjdycEVpRHZLOG1neU9HeG41UWZLZVdM?=
 =?gb2312?B?ZndyUVptR091WkpFZDgrYnYvMzMvdnZaelhzaGtKTTRscTUvaXVrV3BGUDBq?=
 =?gb2312?B?UXA5N0N4WUVlbVBOQVBBb2lmQ21aRldaSlEwQzJ5T2lhczNPYXNDL3QrU3Jz?=
 =?gb2312?B?Vldlam5RZzJJb2UzcGJEZWNnSUVVTHlTL1pGN3lHalBsaElSck5zSlNBK3JK?=
 =?gb2312?B?SU04eVB6NnpCY2o1MWE0bjNmczFOVm1kWXhianZaQks3QjdVbHlTVUlOZEda?=
 =?gb2312?B?SndCdndrSVRJNUhXM0xjSVA3cFQwaXlkUTdwdlhtaUxyZlY3K04vODhJdVZE?=
 =?gb2312?B?bzBhcFJaZFRmM21ZQzMzRC85NVZEalc5UytKcFM3MFk2MGQxdWd4ZFRDRkl5?=
 =?gb2312?B?QVBTVCtQSnZoSFVTUG9PS0pLUVR0aVBaQ0Zwd2QvaEo1Qms5anlOcGd2UU1D?=
 =?gb2312?B?cHZXc3pmZitCdHFSUEFvSVF6RG54QXhvMFBwOW4xOW1SUmZidE9pbVlhMGZW?=
 =?gb2312?B?NTlMbUFvYlZlV2JGQ28vQzlCSVI1NGdxdGJlK1hiVUtnR21JNzJEVHNJOTND?=
 =?gb2312?B?MXpQaEtRYzJ4WVppWW5rMi90eXZPTFUyUWFFeUtjRC9TSHU5emVWZ0piUUNt?=
 =?gb2312?B?Y3JrQklYdFpwMUpSOTQzcFZCcUdWWmRhMVpQQVFia1MxOVk4clBnSWd1Vmgz?=
 =?gb2312?B?TllyNVV0ZVJJSTFTb1E0cEoxU04wQXJ1ekYxMXRRWGVtcU1UdmdPOU0xblNt?=
 =?gb2312?B?MlFoK1dmM0p3WmIwd05TN0hQbTZMQ3dwaXd2VGRuY3htc0ZrcmdGc0V2L0U1?=
 =?gb2312?B?NTJxVVE4cHBZSXRVS0ZzWlkvdDNiWHBIMThrcVdrSzJSZXF1Ni9Gek9IVTdQ?=
 =?gb2312?B?cWRKVDEvVUMweTRaZjlaaWQxem5JQWhzRFNzalBQR1RkNlZxTEdRQkY4SENl?=
 =?gb2312?B?Y2ZxQ2QyRE1QRnRFeXBQRDJCWFNPTEVRcnVhQ0hmbWg4ODNkL3FKSXZROVdJ?=
 =?gb2312?B?Y2pESEZab1NaZUNDbDNxcVo2bUI4RFZjaDYzNU5CaXd5OHdvYXZQTVNVV3J6?=
 =?gb2312?B?OFNTekdXcHBBdm1XYmJtMFBINCs2dlZvQjlHZkRZN3BIOWpJbjRZOGMrZksy?=
 =?gb2312?B?MU4zVjhMWW55M3hBUUZhWmNSYkd3K3QzUmFxdXE2UkZVYnhNcnlEVGs5SExP?=
 =?gb2312?B?ZTFUSHNlQzdGM1hsUWQ0SVJNYllNK2FGMXR4OWlhTm5lNlY4ak1oOGhwWlZy?=
 =?gb2312?B?MGZqbEltQ2VsYlVJa2s3OEJSWFVsS3ViM2VLQVY1L244V21qMU9VTFZNd3VO?=
 =?gb2312?B?dTY5SUpiamZwWjYwQkh5bEo3TjZwdjhtOUQ4NC90TDBqQTQrdFM5SWJPZ2tG?=
 =?gb2312?B?ck9GTm1sQ2NZVW5aSjkxTTU3WkIzQkJJY0I4SzRuampTbXphU2d4UDNPZHJ6?=
 =?gb2312?B?YXJyV05tcHdnMTArSkRQZGpkRzhkdzdiclNOZ3NKNHN6d1pFWXRmcGZVajR3?=
 =?gb2312?B?M2ZxRmJKTW94dDlGa1VRcW9qMXcyRDNsWHd4cS9yM1NDS2I3M1l3YUZaZzNI?=
 =?gb2312?B?ZFNJbk92NVgraFJRZnFXOTR3SXpYRWFtQ0FRcVQ3Y3B4UXhHOXdYREZlOStC?=
 =?gb2312?B?N3lSczB0akh2Q0w4MFRoa1JZU1kzVlNtWGY1dytYYktGdjlCclN2NG5IQWU2?=
 =?gb2312?B?NnBuZktzSmNQQzAzcXEweG1FbzVwdXZNSm9SVVpjWWJKRlozd1BPcEU1Rndw?=
 =?gb2312?Q?2FVtyI7CGbXcNWCrT1R/ga9AW17PfTlNISLFeJN?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <9F2177ED8989C94695F8A67905EB6E64@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6382.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf8540-59e1-4138-8a29-08d8f050ebb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 12:16:01.4427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAG/HMc0nNysmJ9V+K6aOOeQgIzH9pLyvXy6zYGLOxg4tyrOhdCSwzEffadhfYSvDA43BkkAnvk63FmFDOa5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2414
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGksDQoNClNvcnJ5IGZvciB0aGUgY29uZnVzaW5nIHNlcmlhbCBudW1iZXJbMS8yXS4NCg0KVGhl
IHNlY29uZCBwYXRjaCBpcyBub3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoIGFuZCBoYXMgc29tZSBp
c3N1ZXMuDQpJIHdpbGwgc2VuZCB0aGUgc2Vjb25kIHBhdGNoIGFzIGEgc2VwYXJhdGUgb25lIGlu
IGZ1dHVyZS4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQoNCk9uIDIwMjEvMy8yNiAxOTo1
NSwgWGlhbyBZYW5nIHdyb3RlOg0KPiBTaW5jZSBjb21taXQgZTdiZWQwYjViYzRiLCB0b2dnbGlu
ZyBGU19YRkxBR19EQVggb24gYW4gZXhpc3RpbmcgZmlsZSBjYW4gbWFrZQ0KPiBTX0RBWCBvbiB0
aGUgZmlsZSBjaGFuZ2UgaW1tZWRpYXRlbHkgd2hlbiBhbGwgYXBwbGljYXRpb25zIGNsb3NlIHRo
ZSBmaWxlLg0KPiBBcyBhIHJlc3VsdCwgd2UgZG9uJ3QgbmVlZCB0aGUgcmVkdW5kYW50IGRyb3Ag
Y2FjaGUgYW5kIHVtb3VudCAmIG1vdW50IGN5Y2xlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFv
bGkgRmVuZyA8eGlmZW5nQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8
eWFuZ3guanlAZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiAgdGVzdHMvZ2VuZXJpYy82MDggfCA0MSAr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
dGVzdHMvZ2VuZXJpYy82MDggYi90ZXN0cy9nZW5lcmljLzYwOA0KPiBpbmRleCA4NjFiYmZmNS4u
ZDgxYTI0ODggMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2dlbmVyaWMvNjA4DQo+ICsrKyBiL3Rlc3Rz
L2dlbmVyaWMvNjA4DQo+IEBAIC0zLDEwICszLDEwIEBADQo+ICAjIENvcHlyaWdodCAoYykgMjAy
MCBGdWppdHN1LiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCj4gICMNCj4gICMgRlMgUUEgVGVzdCA2
MDgNCj4gLSMgQ2hhbmdlIEZTX1hGTEFHX0RBWCBvbiBhbiBleGlzdGluZyBmaWxlIGFuZCBjaGVj
ayBpZiBTX0RBWCBvbg0KPiAtIyB0aGUgZmlsZSBjYW4gdGFrZSBlZmZlY3QgaW1tZWRpYXRlbHkg
YnkgdGhlIGZvbGxvd2luZyBzdGVwczoNCj4gLSMgMSkgU3RvcCBhbGwgYXBwbGljYXRpb25zIHdo
aWNoIGFyZSB1c2luZyB0aGUgZmlsZS4NCj4gLSMgMikgRG8gZHJvcF9jYWNoZXMgb3IgdW1vdW50
ICYgbW91bnQgY3ljbGUuDQo+ICsjIFRvZ2dsaW5nIEZTX1hGTEFHX0RBWCBvbiBhbiBleGlzdGlu
ZyBmaWxlIGNhbiBtYWtlIFNfREFYIG9uIHRoZQ0KPiArIyBmaWxlIGNoYW5nZSBpbW1lZGlhdGVs
eSB3aGVuIGFsbCBhcHBsaWNhdGlvbnMgY2xvc2UgdGhlIGZpbGUuDQo+ICsjIEl0J3MgYSByZWdy
ZXNzaW9uIHRlc3QgZm9yOg0KPiArIyAnY29tbWl0IGU3YmVkMGI1YmM0YiAoImZzOiBLaWxsIERD
QUNIRV9ET05UQ0FDSEUgZGVudHJ5IGV2ZW4gaWYgRENBQ0hFX1JFRkVSRU5DRUQgaXMgc2V0Iikn
DQo+ICANCj4gIHNlcT1gYmFzZW5hbWUgJDBgDQo+ICBzZXFyZXM9JFJFU1VMVF9ESVIvJHNlcQ0K
PiBAQCAtMzYsNyArMzYsNyBAQCBfcmVxdWlyZV9kYXhfaWZsYWcNCj4gIF9yZXF1aXJlX3hmc19p
b19jb21tYW5kICJsc2F0dHIiICItdiINCj4gIF9yZXF1aXJlX3hmc19pb19jb21tYW5kICJzdGF0
eCIgIi1yIg0KPiAgDQo+IC10ZXN0X2Ryb3BfY2FjaGVzKCkNCj4gK3Rlc3RfZW5hYmxlX2RheCgp
DQo+ICB7DQo+ICAJbG9jYWwgdF9maWxlPSRTQ1JBVENIX01OVC90ZXN0ZmlsZQ0KPiAgDQo+IEBA
IC00OSwyNCArNDksMTkgQEAgdGVzdF9kcm9wX2NhY2hlcygpDQo+ICANCj4gIAkkWEZTX0lPX1BS
T0cgLWMgJ2NoYXR0ciAreCcgJHRfZmlsZQ0KPiAgCV9jaGVja194ZmxhZyAkdF9maWxlIDENCj4g
LQlfY2hlY2tfc19kYXggJHRfZmlsZSAwDQo+IC0NCj4gLQkjIE9uZSBhcHBsaWNhdGlvbiBpcyB1
c2luZyB0ZXN0IGZpbGUgYW5kIGNoZWNrIGlmIFNfREFYIG9uDQo+IC0JIyB0aGUgZmlsZSBkb2Vz
bid0IHRha2UgZWZmZWN0IGltbWVkaWF0ZWx5IGJ5IGRyb3BfY2FjaGVzDQo+IC0JZWNobyAyID4g
L3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQo+ICsJIyBPbmUgYXBwbGljYXRpb24gaXMgdXNpbmcg
dGVzdCBmaWxlIGFuZCBTX0RBWA0KPiArCSMgb24gdGhlIGZpbGUgaXMgbm90IGNoYW5nZWQgaW1t
ZWRpYXRlbHkNCj4gIAlfY2hlY2tfc19kYXggJHRfZmlsZSAwDQo+ICANCj4gIAlleGVjIDM8Ji0N
Cj4gIA0KPiAtCSMgTm8gYXBwbGljYXRpb24gaXMgdXNpbmcgdGVzdCBmaWxlIGFuZCBjaGVjayBp
ZiBTX0RBWCBvbg0KPiAtCSMgdGhlIGZpbGUgdGFrZXMgZWZmZWN0IGltbWVkaWF0ZWx5IGJ5IGRy
b3BfY2FjaGVzDQo+IC0JZWNobyAyID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQo+ICsJIyBO
byBhcHBsaWNhdGlvbiBpcyB1c2luZyB0ZXN0IGZpbGUgYW5kIFNfREFYDQo+ICsJIyBvbiB0aGUg
ZmlsZSBpcyBjaGFuZ2VkIGltbWVkaWF0ZWx5DQo+ICAJX2NoZWNrX3NfZGF4ICR0X2ZpbGUgMQ0K
PiAgfQ0KPiAgDQo+IC10ZXN0X2N5Y2xlX21vdW50KCkNCj4gK3Rlc3RfZGlzYWJsZV9kYXgoKQ0K
PiAgew0KPiAtCWxvY2FsIG9wdGlvbj0kMQ0KPiAgCWxvY2FsIHRfZGlyPSRTQ1JBVENIX01OVC90
ZXN0ZGlyDQo+ICAJbG9jYWwgdF9maWxlPSR0X2Rpci90ZXN0ZmlsZQ0KPiAgDQo+IEBAIC04MSwy
OSArNzYsMjkgQEAgdGVzdF9jeWNsZV9tb3VudCgpDQo+ICANCj4gIAkkWEZTX0lPX1BST0cgLWMg
J2NoYXR0ciAteCcgJHRfZmlsZQ0KPiAgCV9jaGVja194ZmxhZyAkdF9maWxlIDANCj4gKwkjIE9u
ZSBhcHBsaWNhdGlvbiBpcyB1c2luZyB0ZXN0IGZpbGUgYW5kIFNfREFYDQo+ICsJIyBvbiB0aGUg
ZmlsZSBpcyBub3QgY2hhbmdlZCBpbW1lZGlhdGVseQ0KPiAgCV9jaGVja19zX2RheCAkdF9maWxl
IDENCj4gIA0KPiAgCWV4ZWMgMzwmLQ0KPiAgDQo+IC0JIyBObyBhcHBsaWNhdGlvbiBpcyB1c2lu
ZyB0ZXN0IGZpbGUgYW5kIGNoZWNrIGlmIFNfREFYIG9uDQo+IC0JIyB0aGUgZmlsZSB0YWtlcyBl
ZmZlY3QgaW1tZWRpYXRlbHkgYnkgdW1vdW50ICYgbW91bnQNCj4gLQlfc2NyYXRjaF9jeWNsZV9t
b3VudCAiJG9wdGlvbiINCj4gKwkjIE5vIGFwcGxpY2F0aW9uIGlzIHVzaW5nIHRlc3QgZmlsZSBh
bmQgU19EQVgNCj4gKwkjIG9uIHRoZSBmaWxlIGlzIGNoYW5nZWQgaW1tZWRpYXRlbHkNCj4gIAlf
Y2hlY2tfc19kYXggJHRfZmlsZSAwDQo+ICB9DQo+ICANCj4gIGRvX3Rlc3RzKCkNCj4gIHsNCj4g
IAlsb2NhbCBtb3VudF9vcHRpb249JDENCj4gLQlsb2NhbCBjeWNsZV9tb3VudF9vcHRpb249JDIN
Cj4gIA0KPiAgCV9zY3JhdGNoX21vdW50ICIkbW91bnRfb3B0aW9uIg0KPiAgDQo+ICAJIyBNYWtl
IHN1cmUgdGhlIHJvb3QgZGlyIGRvZXNuJ3QgaGF2ZSBGU19YRkxBR19EQVggc2V0IGJlZm9yZSB3
ZSBzdGFydC4NCj4gIAkkWEZTX0lPX1BST0cgLWMgImNoYXR0ciAteCIgJFNDUkFUQ0hfTU5UICY+
PiAkc2VxcmVzLmZ1bGwNCj4gIA0KPiAtCXRlc3RfZHJvcF9jYWNoZXMNCj4gLQ0KPiAtCXRlc3Rf
Y3ljbGVfbW91bnQgIiRjeWNsZV9tb3VudF9vcHRpb24iDQo+ICsJIyBEbyB0ZXN0IGZvciBjb21t
aXQgZTdiZWQwYjViYzRiDQo+ICsJdGVzdF9lbmFibGVfZGF4DQo+ICsJdGVzdF9kaXNhYmxlX2Rh
eA0KPiAgDQo+ICAJX3NjcmF0Y2hfdW5tb3VudA0KPiAgfQ0KPiBAQCAtMTExLDcgKzEwNiw3IEBA
IGRvX3Rlc3RzKCkNCj4gIF9zY3JhdGNoX21rZnMgPj4gJHNlcXJlcy5mdWxsIDI+JjENCj4gIA0K
PiAgIyBNb3VudCB3aXRoIGRheCBvcHRpb24NCj4gLWRvX3Rlc3RzICItbyBkYXg9aW5vZGUiICJk
YXg9aW5vZGUiDQo+ICtkb190ZXN0cyAiLW8gZGF4PWlub2RlIg0KPiAgDQo+ICAjIE1vdW50IHdp
dGhvdXQgZGF4IG9wdGlvbg0KPiAgZXhwb3J0IE1PVU5UX09QVElPTlM9IiINCg==
