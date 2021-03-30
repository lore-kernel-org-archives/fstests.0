Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D4C433C1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 01:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B9B6192F
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 01:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC3Beq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 21:34:46 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:46698 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhC3Bef (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Mar 2021 21:34:35 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 21:34:35 EDT
IronPort-SDR: ww5bOwioOoCqh5u9/oBcTbfCrhDdBRjeg62pxxFfFz7oFO0h4/5wkq+t4vVX4EHPQN4H7p+gvk
 iBNBH2g5HlaDN9hVh/jV4kcY/SVqJI/bNLm/H4rBwtyQwAouMm9MILkH27VmYucgNJWcRR+Woz
 LzidJdgg9ptsZUC2yOwg/N8NNnD0whx4ZTZxB66tdqr/u4YSShz7UTWTKyGk+TirOHTkFRf/BG
 S2Nqh/IeeuH+vKai302F7h+DmedgR4q6ue5GK2ofFlRVfK4l4v5Tu/CcrySyATlEfx7IRtKjGo
 ceM=
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="28762933"
X-IronPort-AV: E=Sophos;i="5.81,289,1610377200"; 
   d="scan'208";a="28762933"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:27:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XotffukZ8Q2RpKzDc8CoaRLSKtWMvB/P7kM1JiBR6wF2W9HZ7sEfN+BzE7JrPX6OdJekkFQRGdzRIT6nZRZPbK4wyWhP+sGNaMZcOA9hJ4MAk7WaqsZ4SA641D71Ec6nLU0OFwR+BpK/mVbge617/d0UaudR/hQLWFN5eO/M0KY+e+zOGvXGYosysM228df6YSfX5JCVLvFwn05LREX02Z4o5aQtXzs+S/c6qdi2MOnnVZHcy5Y0FlPpE3fZ7IOHZOY0hLZSY7RrNcU6cNEItkGsDRff1lvxnhcU9tjf7eF7uFRPMovTP4Cs4o9k4ukU5anfWvL55x3kK1i3sWmaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkufAg/qAMX1FPOYlLtgBJDYStWfyQiSi66oCgNhRT0=;
 b=KHWff6nXgVkSfp69ofME+bdOC7jZlMnZ08HIBAJv+iNah+Mjedunav+55yO7B7+ofqftSalVu0yaRtZIv2ltT2GN5bEdTSFJnXacCvkpNFU1OZmy6eKWco6b4v+OTHtOqBWrLp5yh6EYUbkJjCGM3N/DagEsFZIcUV0AqdMQRhhVjI96zeNSdrkcITLeRdI0ABEUxh6ps+phsHV2OWlQy7GPCX08n+2wx3uuCl6E2bTkFyXbCx9h+9cUiqslsIyHDW8NnJo5ImC4GHYu86YCPvmQhmc4ey0ZkZzuWSvreQc27QgmeH/VOd5V3U3sP8PS6bMbrk4H5E5Rf+OIOhpOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkufAg/qAMX1FPOYlLtgBJDYStWfyQiSi66oCgNhRT0=;
 b=gvXDCPbYhN969G+6Si7Bl5VyHCIi7lclpIwzj4tabboWLuanfe/NAeICGfsyWfc5QDMOrqV4Dg2YjdTlH/s+Wi3JaUvEn8tFrjE6zx0CSVfW9ZO1RRf4/NQqhBhL2zp6FH6CLYilsUtX8IcrA93npr5Tsy73BHPX9u5RGC+aO30=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB6040.jpnprd01.prod.outlook.com (2603:1096:604:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 01:27:22 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::d890:a1e4:ea0a:15c0]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::d890:a1e4:ea0a:15c0%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:27:22 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "lihao2018.fnst@fujitsu.com" <lihao2018.fnst@fujitsu.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "xifeng@redhat.com" <xifeng@redhat.com>
Subject: Re: [PATCH v2 2/2] generic/608: Add new regression test
Thread-Topic: [PATCH v2 2/2] generic/608: Add new regression test
Thread-Index: AQHXJH5o3K7vx41beUaCMS/yjsuLgKqbSEOAgAB2ZwA=
Date:   Tue, 30 Mar 2021 01:27:22 +0000
Message-ID: <60627E78.3050304@fujitsu.com>
References: <20210329092054.5278-1-yangx.jy@fujitsu.com>
 <20210329092054.5278-2-yangx.jy@fujitsu.com>
 <20210329182333.GZ3014244@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210329182333.GZ3014244@iweiny-DESK2.sc.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48af1844-9fe8-44f4-0667-08d8f31af7a7
x-ms-traffictypediagnostic: OS3PR01MB6040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB6040F6CD95319323195A081D837D9@OS3PR01MB6040.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQDyklDbV6cFa8pdMJBb++sh+b1YwnxH/SA7fEFv5nqJ2bOh2tzJBuchfr56xhzsT6FiQgeSUkzS6UREfIjI6WSF619zAbcYwbSDTHW3Suh96BxS0+k5o9OhzMFlrcNOaT6JY8buqje9ysqbTv1WqhpcIII9jlW/VnnrIlkdgj5Fp3m2vu4J0TYm0LmvHxEXty/DJ9FR4kD//WfcT/m2qObYUfS6T0e1r1wUJRKAzsS562lOxD0/O25Ovm2rGvT+Sap5xVKGUcS8KWH+hpK0znOlf4rjekhUAOZv6TIwBp4vDQb2YYjC2GnOAW7VBYo03t/VKcque6NraarFysHRvn5CbIb82efkcC8fMrEYMQr0ajPlfbxmaxjFovCMbIr/lLAmH9ZubiN7+PQp6Bs9HW7QFYQticLTF0Jrjz/o3fBUln9RQZIeq7pjeNUhsmJQath7WND5XeD0eDAXPxkmKYfHFFcBA9npKsh0PpfATPYz+wm3pdk+vpy98XlGTDw59F+hD72LJwEa7fFu8ecQuKyLW8KvWVkGhcF9+MiYvNHFf+luNrwjJWbnhGB+TeLV4ZF9apUb9oGEKG2sbT8dq7ZV2bZ6DN4P1n0P8q5ZTXCZKWgdllPvwrCYfLr9H5l5MJjVgJwFN+ytJBoo8VkQaYYcK/6i4smkSvXBq83iCpgytZCR4hv3COwhbjHRjdMs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(66946007)(6512007)(8676002)(71200400001)(2906002)(478600001)(26005)(83380400001)(85182001)(66446008)(87266011)(4326008)(38100700001)(91956017)(64756008)(66556008)(66476007)(8936002)(86362001)(6486002)(316002)(2616005)(53546011)(6506007)(33656002)(54906003)(36756003)(6916009)(76116006)(186003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?bVNTWVdpMW1kdDVVb01nUXZxSVJleFpJUWZxdXlOajFRZDk4VG1lVHI2UTdX?=
 =?gb2312?B?Z05pUUpnR0E1VlFiU0VsdmhnUTBoZVVGZ0RIelIwMDNJTjBGVTlWbk40VHE1?=
 =?gb2312?B?TWllMTdSYjhVSzhmUENISTZMVjZvcWMwckRxZFBYeUQ4SnA0MkZqS091Ukdu?=
 =?gb2312?B?dnlSWnM3WmdTV1hORjY4TVNEcUJyU0hLc0ZuRkg1bTYrN2ZjKzV0TStFOFVU?=
 =?gb2312?B?NDdHSHdnSHBSTm93U1FITnRNNHpFUFRkU2pJeENrV3Z5bThNdDFwNi9aeUhx?=
 =?gb2312?B?aTRKVHZieUd0OUlReFA1a2dnbXVOZ2JxZWE3a2RCTDFtam5mQUFabll6YWtx?=
 =?gb2312?B?b1dIaTNjY3BFRnZHNFdCSnlOS2pzOVpTaDlmUzZYbTlzcjBBMk9KMElKL1VD?=
 =?gb2312?B?MDNvWkN0N1lKZ0JrVjhUdnlaZXFaaGJ6bjVxKzdRTEU1L1U2ZU5tZXBTV1B4?=
 =?gb2312?B?RTBvdXkxYjh6bmxXaERobDdqZG1HYW8vQjlOdElYYkE3UEMxMks3RmpPYy83?=
 =?gb2312?B?RmRXRzczVGdxSlFoVU9adG55WVFSTTNvNGN4VEc3cHFFbHdXRkxzZVFRdDI2?=
 =?gb2312?B?OHZJSTAvZ28zbWJDZ0xwTVBaUHQ0dFg0UVVINEpnVXAwNitLaXBkUkZnSzhK?=
 =?gb2312?B?TTIzNm11VEhscDEyczZpaVgwQnZpQnJhcmkzRUFMaGhRNTlGd0xnUlJXTzJp?=
 =?gb2312?B?c25ML3Q0QUlXN3dpT1pmckZVR0VBQTBaYjZGWHlaSjhmMEhZMjBsSjJzeGdC?=
 =?gb2312?B?NE84c3k4SVBEWjhONFEySWxWdWlPNEU4N3J1b0FvSlZkUUZQZndjUDJSbU1a?=
 =?gb2312?B?c0ZsMWQ2SVo0VDlSY3dIQjM5ZkNJK01qcUFBMXJ2dWY4WjIyWlh5c2VnMTJp?=
 =?gb2312?B?QVNNTFdKSGRYY0xoakJ3Z3B3TnlUcE1MWTl0RHdsb3FidVZkUmJQR0lYYmR6?=
 =?gb2312?B?c2JiV3ZUK21majlZOW1WOEpVNjNMVlhvcDl5MjNveW9NbW5MOW5lWmhhdTJn?=
 =?gb2312?B?eXNDdlpGemYxQUtyaC9nV2JNZVVzbldBTGJsRlZueUR0VENPa2xXbWk1Sysr?=
 =?gb2312?B?RlpyZVdIMTJaRW9VN3VEeEtxcnBlSzZ6a2VBWi9PVENXYmcxU3ZOeUc3MG55?=
 =?gb2312?B?Y000SituMzMvZklNS2pZa3ZoQ2ZBN0VYYkUxMUFSVkFJejAyODRpekJhVVV3?=
 =?gb2312?B?aHo5ejVRcnQvdDVqdWRiRE1WV0VPT0orbDFldmpXTUVFT29mamRWd054U1VD?=
 =?gb2312?B?cnFIU3pTZ2dFVld6T0JhMGo4UEdoUTV6bEVsUU5UV3JSLzB0aDJlNTI4VWR4?=
 =?gb2312?B?RklNTzJKVlVQNmlDQXkzTS9OS1hMZWYxblJQUXN2QXJmbDMrb2NVU0ZtNDlZ?=
 =?gb2312?B?TDM5NjE2VEdYQ21JQTN5YWVKbXluMmpkMVpwWktNMG1jcC9aODludEYzWERI?=
 =?gb2312?B?SmZzRE5iK1hodkI4UUxuelVnQVFuSXo0Q0tpaHNKV2liWENPMUdiRjJnSWJN?=
 =?gb2312?B?eTd2SXRhVmN5SGFvQ1kxTm1rSlJ6TlVydGQ5SW9VZ0tveUJCcy9BQkFWMFV1?=
 =?gb2312?B?OXRySlJvQ1Y5QjlkeCs0OHA2MDI2a1NqTU5SWndNdHEvbXJPMGxHTHNBdVdL?=
 =?gb2312?B?WXoyTHVtTnIyT2orL09zSjFlSHZaczUrdW1pbGRwRlYwMjNKMFErcmVwdzJB?=
 =?gb2312?B?REc1b0hqdDdmSjR2cXJHYVlETGhVSmtkZzRaSW0xaWlHcjkrbXhzN0dYOHZp?=
 =?gb2312?Q?7YWX/YEP9RIfyU5Jsb+BrwxKdmlcjQKsUEA3eyn?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <F96964A2442BA14A8CBA0AF5E2EAE1FB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48af1844-9fe8-44f4-0667-08d8f31af7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 01:27:22.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WSHEqP2NdNUtz3FA70dvzUwiQi3JF1b6INRx0hQqWMVCD4/0nd4tEb63RPkY4uAPI1U/qBmKSiS+YJBLSHRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6040
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

T24gMjAyMS8zLzMwIDI6MjMsIElyYSBXZWlueSB3cm90ZToNCj4gT24gTW9uLCBNYXIgMjksIDIw
MjEgYXQgMDU6MjA6NTRQTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4gV3JpdGUgZGF0YSBp
bnRvIGEgZmlsZSBhbmQgdGhlbiBlbmFibGUgREFYIG9uIHRoZSBmaWxlIGltbWVkaWF0ZWx5LA0K
Pj4gdGhlIHdyaXR0ZW4gZGF0YSB3aGljaCBpcyBzdGlsbCBpbiB0aGUgYnVmZmVyIHdpbGwgYmUg
bG9zdCB3aGVuDQo+PiB0aGUgY29ycmVzcG9uZGluZyBpbm9kZSBpcyBldmljdGVkLg0KPiBUaGlz
IGFuZCB0aGUgY29tbWVudCBiZWxvdyBhcmUgY29uZnVzaW5nLiAgRG9lc24ndCB0aGUgYnVmZmVy
ZWQgZGF0YSBnZXQNCj4gd3JpdHRlbj8gIFdoaWNoIG1lYW5zIHRoZSBkYXRhIGlzIG5vdCBsb3N0
Pw0KSGkgSXJhLA0KDQpUaGFua3MgZm9yIHlvdXIgcXVpY2sgY29tbWVudC4NCg0KSG93IGFib3V0
IHRoZSBmb2xsb3dpbmcgY29tbWl0IG1lc3NhZ2U6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCldyaXRl
IGRhdGEgaW50byBhIGZpbGUgYW5kIHRoZW4gZW5hYmxlIERBWCBvbiB0aGUgZmlsZSBpbW1lZGlh
dGVseSwNCnRoZSB3cml0dGVuIGRhdGEgd2hpY2ggaXMgc3RpbGwgaW4gdGhlIGJ1ZmZlciBzaG91
bGQgYmUgc3luY2hyb25pemVkDQp0byBkaXNrIGluc3RlYWQgb2YgZGlzY2FyZGVkIHdoZW4gdGhl
IGNvcnJlc3BvbmRpbmcgaW5vZGUgaXMgZXZpY3RlZC4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBJ
T1cgdGhlIHRlc3QgaXMgY2hlY2tpbmcgdG8gbWFrZSBzdXJlIHRoZSBkYXRhIGRvZXMgbm90IGdl
dCBsb3N0LCBub3QgdGhhdCBpdA0KPiBkb2VzLiAgV2hhdCBhbSBJIG1pc3Npbmc/DQoNClJpZ2h0
LCB0aGUgZGF0YSBzaG91bGQgbm90IGdldCBsb3N0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlh
bmcNCj4gSXJhDQo+DQo+PiBJdCdzIGEgcmVncmVzc2lvbiB0ZXN0IGZvciBjb21taXQgMjZiMTVh
MDQyYjhhLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZzx5YW5neC5qeUBmdWppdHN1
LmNvbT4NCj4+IC0tLQ0KPj4gICB0ZXN0cy9nZW5lcmljLzYwOCB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNjA4IGIvdGVzdHMvZ2VuZXJpYy82MDgN
Cj4+IGluZGV4IGQ4MWEyNDg4Li42NzRiZDJjZiAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL2dlbmVy
aWMvNjA4DQo+PiArKysgYi90ZXN0cy9nZW5lcmljLzYwOA0KPj4gQEAgLTcsNiArNywxMiBAQA0K
Pj4gICAjIGZpbGUgY2hhbmdlIGltbWVkaWF0ZWx5IHdoZW4gYWxsIGFwcGxpY2F0aW9ucyBjbG9z
ZSB0aGUgZmlsZS4NCj4+ICAgIyBJdCdzIGEgcmVncmVzc2lvbiB0ZXN0IGZvcjoNCj4+ICAgIyAn
Y29tbWl0IGU3YmVkMGI1YmM0YiAoImZzOiBLaWxsIERDQUNIRV9ET05UQ0FDSEUgZGVudHJ5IGV2
ZW4gaWYgRENBQ0hFX1JFRkVSRU5DRUQgaXMgc2V0IiknDQo+PiArIw0KPj4gKyMgV3JpdGUgZGF0
YSBpbnRvIGEgZmlsZSBhbmQgdGhlbiBlbmFibGUgREFYIG9uIHRoZSBmaWxlIGltbWVkaWF0ZWx5
LA0KPj4gKyMgdGhlIHdyaXR0ZW4gZGF0YSB3aGljaCBpcyBzdGlsbCBpbiB0aGUgYnVmZmVyIHdp
bGwgYmUgbG9zdCB3aGVuIHRoZQ0KPj4gKyMgY29ycmVzcG9uZGluZyBpbm9kZSBpcyBldmljdGVk
Lg0KPj4gKyMgSXQncyBhIHJlZ3Jlc3Npb24gdGVzdCBmb3I6DQo+PiArIyAnY29tbWl0IDI2YjE1
YTA0MmI4YSAoImZzOiBIYW5kbGUgSV9ET05UQ0FDSEUgaW4gaXB1dF9maW5hbCgpIGluc3RlYWQg
b2YgZ2VuZXJpY19kcm9wX2lub2RlKCkiJw0KPj4NCj4+ICAgc2VxPWBiYXNlbmFtZSAkMGANCj4+
ICAgc2VxcmVzPSRSRVNVTFRfRElSLyRzZXENCj4+IEBAIC04Nyw2ICs5MywyNiBAQCB0ZXN0X2Rp
c2FibGVfZGF4KCkNCj4+ICAgCV9jaGVja19zX2RheCAkdF9maWxlIDANCj4+ICAgfQ0KPj4NCj4+
ICt0ZXN0X2J1ZmZlcmVkX2RhdGFfbG9zdCgpDQo+PiArew0KPj4gKwlsb2NhbCB0X2ZpbGU9JFND
UkFUQ0hfTU5UL2RhdGFmaWxlDQo+PiArDQo+PiArCSMgV3JpdGUgZGF0YSBpbnRvIGEgZmlsZQ0K
Pj4gKwllY2hvICJCdWZmZXJlZCBkYXRhIj4gICR0X2ZpbGUNCj4+ICsNCj4+ICsJIyBUaGVuIGVu
YWJsZSBEQVggb24gdGhlIGZpbGUgaW1tZWRpYXRlbHkNCj4+ICsJJFhGU19JT19QUk9HIC1jICdj
aGF0dHIgK3gnICR0X2ZpbGUNCj4+ICsNCj4+ICsJIyBXaXRob3V0IGNvbW1pdCBlN2JlZDBiNWJj
NGIsIGVuc3VyZSBpbm9kZSBjYW4NCj4+ICsJIyBiZSBldmljdGVkIGJ5IGRyb3BfY2FjaGVzDQo+
PiArCWVjaG8gMj4gIC9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcw0KPj4gKw0KPj4gKwkjIFRoZSB3
cml0dGVuIGRhdGEgd2hpY2ggaXMgc3RpbGwgaW4gdGhlIGJ1ZmZlciB3aWxsIGJlIGxvc3QNCj4+
ICsJZ3JlcCAtcSAiQnVmZmVyZWQgZGF0YSIgJHRfZmlsZSB8fCBlY2hvICJCdWZmZXJlZCBkYXRh
IGlzIGxvc3QiDQo+PiArDQo+PiArCXJtIC1mICR0X2ZpbGUNCj4+ICt9DQo+PiArDQo+PiAgIGRv
X3Rlc3RzKCkNCj4+ICAgew0KPj4gICAJbG9jYWwgbW91bnRfb3B0aW9uPSQxDQo+PiBAQCAtMTAw
LDYgKzEyNiw5IEBAIGRvX3Rlc3RzKCkNCj4+ICAgCXRlc3RfZW5hYmxlX2RheA0KPj4gICAJdGVz
dF9kaXNhYmxlX2RheA0KPj4NCj4+ICsJIyBEbyB0ZXN0IGZvciBjb21taXQgMjZiMTVhMDQyYjhh
DQo+PiArCXRlc3RfYnVmZmVyZWRfZGF0YV9sb3N0DQo+PiArDQo+PiAgIAlfc2NyYXRjaF91bm1v
dW50DQo+PiAgIH0NCj4+DQo+PiAtLSANCj4+IDIuMjEuMA0KPj4NCj4+DQo+Pg0KPiAuDQo+DQo=
