Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ABBC433C1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 01:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E19B6193A
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 01:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC3Bzr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 21:55:47 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:40252 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhC3Bzd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Mar 2021 21:55:33 -0400
IronPort-SDR: eTmWevCx+1hsPm4LmmrA3W3sGAww1BkZu1ivqxQciI6JJFnTtKlxEu0MXeXsYKK4K/H1HIe9yf
 4Yv843Bw0tjXuAWkoUrPX9/ShWwet/WEr+ADb/5alW5HYDqppD8W1BysmrIl4/gDeysEGo4z8X
 wMxW+KIq+dDGFMZFDFOrt9pCRvvpAkR6QiOTrtg0v13IMho1bc/ymwbO+dGuOfzj8giYUJz7aM
 NJaOdnavePAdTxXbn8j23yEgpo9UVudVPOtutjEPXfO6+xiboBc2sAGql3BP0+jtwx5XXWzhez
 aP4=
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="28764525"
X-IronPort-AV: E=Sophos;i="5.81,289,1610377200"; 
   d="scan'208";a="28764525"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:55:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hviVU315YR99/r5Q4TtNIbnSFLUBvWz6LMfxDG0ugtkao8twJmrYeyjQIvd8IyxBapcDgC9LzVjLzaNBpRUCfug+JFdtRiok+KWX2w5Jo5R2cBBaicTtbq7tR3OwH/kRLt7j39mAIm2kVLrwGpHHemiWUKlEv/zAmp3wfsjB4ncQKRgLLYqZdaUhDdlH0bWveQoHAZgqShl2+9CpQ8Yo5difJgF1zyKGI51FmI1FyUf9oDUupSpe6xCksO2nvxXpCPHWxSH20FOgYx+ikL9Zs1ksEGOm3FYsNdiqub55PSg4mU3wKx5f/VaonYNge6mKltfeCR+E4GpYmv+Gj/CPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wPAc5MwYMiHzGvMycmvdPUbIuQByu47OxtWcPH4y6g=;
 b=mpFMXGFjXOobFyGc+wACxL6ddecZEfHfvLNKYLj15rXwrq6j8C1tT3qSr2G1AQqVjCIU+R4bH4/bz93PQggJNy11RwSscFYF4HA/3SMxq+Galr8i79nxy7tslgPW7wXji57UUhM6z+DA3BhZw9ZNCL5bC8IOH7fhUMIL/iKUM4uSMsew/mxx7ZoFFFZGeXryGwgyHfmJtWKg4pvpCTC6lgozhFIyC4Tuegm0C9lNjgf3/XBoUQsAZdqRvd5+d875weVV2lFg2VUbk7mAExWZdjQHlnEqnm4g1ZuwfiAy2rU8mASx1l5zLkmP8hmV1jdYyZd7/cqIvDrBik+I9pjP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wPAc5MwYMiHzGvMycmvdPUbIuQByu47OxtWcPH4y6g=;
 b=BJXkiU3XWqEHMfU2w5y0e980anGLLpyGq0nGlQOUmtFpbPPXlukJCHReW9JKC3uKrMQYYmZ0K0qPv39JkvIPJGAHi7dTir0CuJt5Bqko9WV3yO8FzQBAJvR5jKafXMq5/n+ogGpC5c+dMNJPMjVyQe1H1zu35LYHP4NlbAQ0tfI=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB3798.jpnprd01.prod.outlook.com (2603:1096:604:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 01:55:27 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::d890:a1e4:ea0a:15c0]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::d890:a1e4:ea0a:15c0%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:55:27 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "lihao2018.fnst@fujitsu.com" <lihao2018.fnst@fujitsu.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "xifeng@redhat.com" <xifeng@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 1/2] generic/608: Remove drop cache and umount & mount
 cycle
Thread-Topic: [PATCH v2 1/2] generic/608: Remove drop cache and umount & mount
 cycle
Thread-Index: AQHXJH5mbHLZu2oC4U+CDhkIW8cWSKqbxoOA
Date:   Tue, 30 Mar 2021 01:55:27 +0000
Message-ID: <6062850D.5040602@fujitsu.com>
References: <20210329092054.5278-1-yangx.jy@fujitsu.com>
In-Reply-To: <20210329092054.5278-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16714499-52b4-4e58-a054-08d8f31ee452
x-ms-traffictypediagnostic: OSBPR01MB3798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB37983B0719E4B0D3BFE3CE94837D9@OSBPR01MB3798.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:74;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxDwQ92B3fjVTY7Gp5ElCu81+dVTJfPXoiXMyxJw0QKAkvUaoTX8O6sojzl/+AshFh1irzaEGGFAnD35E8beKtktBnQ/olpx39tBhsjbjjn+wEmq7Z5e6gWydRjytaza2Wz8X8VLIbPljgQbKjQ9PBjDDMLdRqrBBFR/POwRe3PzkpG167vYq4zg2Z5+s7RbbV1nsi5gm886qf4pNjrzT8kxIYavTiRa3y+WtxnNnWAGxsO6t96CrgZekShT76nzjlaIQclKkBnOXZfIXHTQpTf7XdfXb0Me1qmS9eU6K4UChcO5gODOxbYNTDryvPKxqUcorfIqlHhDvCT4RoognorktKTUjQgPHnvQBbgP1n9vW30Sl3QesAfN3gMY9+A9LVw71iEtdB9tk6NCImRh4tO592NtVDgYTlBXHSsAozS74FWLZR2C8PQoUxuRTftSGDjuo+4aG46VAHYORO74Avq0AEBmz+eWhb9p8g+QUPA81XgMrDRwiOonRsqe5ned/AylXtyeQNRs/bqCEa4vBdTOUzxY9Pfp64SdDxJZ6+O7PirAyHXRMSBDj3DtZE5U1JmE1O3m2YJQffy8urMRgCP4Tbe9uLh2YYDv931asSHd7LhK+y5nT0bsDdnPS8+r7bq092Yv4evQP4QH630eGlXBqTYA40ZQ+qA49SL7F2G5PuVtkS3JplBv9Tv3/8c8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(86362001)(5660300002)(54906003)(8676002)(37006003)(71200400001)(4326008)(83380400001)(6512007)(8936002)(316002)(33656002)(6486002)(85182001)(6200100001)(66446008)(6506007)(66556008)(66476007)(26005)(53546011)(76116006)(91956017)(66946007)(64756008)(478600001)(2906002)(38100700001)(186003)(2616005)(6862004)(87266011)(36756003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?YUsyTTJIVkJIeEpZUzl5SVAyQkpwT295R1M1QUI2ZEs3M0ZhR3VBYVlHZGdq?=
 =?gb2312?B?QXdwbGJFWHNWNWxGWmhJQzlDdDNMNEowQS9OaVdUcWJQZmJRekpxUzVyS2tu?=
 =?gb2312?B?TmcxTHJRck1kaTVheVpNclZvR2RDQnVEb0JhMXRpZ2lDSm9JUFU2ZnFnelda?=
 =?gb2312?B?azJWRkVZTWxqb0d5M1hKb3hTaWtVaVVucTdkT2FJcFBUOHZaYTIxUUpoTVAy?=
 =?gb2312?B?SXhJNHI2L3MyRHJJUzNqZTdSc3lKa1dQNVJEd2YrMlJMYTFDTHdJRnQ3allt?=
 =?gb2312?B?c0Y0T05neEx1cllKSWZ2b3NsbWhoQ1hUbHlBc0V2NjBlUlRHWlVHbVUvTzJl?=
 =?gb2312?B?UnlodjZtaENGdzk0aHBodWFoSFE2Vi9mZEt2d0RmaW5DRFc0cnFoa08vWWN1?=
 =?gb2312?B?RlFWblhFRDVvVUZMbmZyMlFscGhNU3ZZMlkwOHRNdC92WGNwZ0tIc3ZROGUy?=
 =?gb2312?B?QmE3UXEvc1VXZG80bnhwTXJvcCszQ0RIT1hhRm95dDlDNHhDaXpaOHBpaFRk?=
 =?gb2312?B?S0dOWjBlWDlKbW95NkwvTnBiSU1NMHJqaTdma2FhdlVubzBkbUxQRFE1MndC?=
 =?gb2312?B?UDFlOVkzeGlDaGNDWFR1R09oNFdUWGtKcmg3MiticmZXUjFCRkM3aUw5VWxr?=
 =?gb2312?B?SllZekk3dFg0cGdNV0t2a2w0V0tTOVJrYndTeUxnaWlJRnU5WUdGVS8zV3hR?=
 =?gb2312?B?OEtrQUVsRk5zQlg2T1daRjhpemJ4ak5tc2FTcnJyZ3h1WGdXOXhlV2ZBV0No?=
 =?gb2312?B?T09TckZ2QXVKMTJYTnE4WnNHMHBQbng4V2FremFBbUlZTmE2bG1XNThLbmpw?=
 =?gb2312?B?RnNxL3BOVm84a0JZc0l5TnFBaVdBcC91QXBDd2NvT2hOMVpDS2E1VEFhRXNz?=
 =?gb2312?B?U3BTbE5hRFVCYU9iSGNFRG0wNkh1NHJMWXUzeHhuWXF3Z0dUQit2TTAvbUp6?=
 =?gb2312?B?M2k5OTZvQmNSMWxKcVByUGV5WDduV2t3RExtaEZxWUsrcFgwV3dTcGtzSi9L?=
 =?gb2312?B?MStFMCtjSnVnd3ZpRFdkOXFoMlVHWWJsVS9xY2JxVU1hSElqQWJrL3pUVm1B?=
 =?gb2312?B?dk9kSys3NHV1SEhUdEg1NzJESkhTUHdjaG9udFRzeFVjMmNwVWJFZWladHdw?=
 =?gb2312?B?cmNDK2V4VitTQ252bmtua0RXTlhJeGRKdG1ILzNIcFhrQytpUEUzVXVJaFZY?=
 =?gb2312?B?MDVwTVlhVHdXc2pYclErcVNyVGEwYlYzOGYrYUZGK1hxS1hiaGtybGJCeWg1?=
 =?gb2312?B?eXlrek41MjhSSDhPYUU1SFRyOWFseDNtUjBqT1gxQXpDdmlPaGVTV0tlRFBF?=
 =?gb2312?B?cmZrakxkcmU2amdZd0xHbTc5NE0wczgzM2Z5TnpMNTFScjFuaGpqRzlpVXA2?=
 =?gb2312?B?eHI5c0V4SmNFb09mSnhhRDVKVkxSVngvT2VhRzBMenF2QkN2Tk1na1JVSkI4?=
 =?gb2312?B?cUl5dEd6Z2RlSWJxVDZZZnFwMkFwWUFROGg0TG9odUJmb3NWSmROak8veG5I?=
 =?gb2312?B?Yk5qUUVBNk1QMjR4NjdZNzREUmRnSEJ4SUM3UEhVTUQ2bWlsWmgyWkVJT1k0?=
 =?gb2312?B?Vk5nMWZuMXQzMVI1S28rUVYzSWdjalgvNWtFZWlhTE10T0pVRlQ3eUVTNEVF?=
 =?gb2312?B?RnpvT0J5bE1vdStscTR4THd0eEFTTjRYSkhCYkFuc2NLUG9LTUZPRHo2TUxv?=
 =?gb2312?B?bWszMVRBYlpBR3JHNlhIdS8xM3JxaXVQSnRsdVd0OE1wUHQ0aDE4Z29HbmRQ?=
 =?gb2312?Q?UZkVvJwEa9MyDzFZQ26GgpQ6Ci/87v+XLq9Ce/3?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <7418695D2C218144B6D3BC08276C7F1C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16714499-52b4-4e58-a054-08d8f31ee452
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 01:55:27.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vHVxqef2/OrionTjbBgsHuDL3cqHjpKfFOCvG3cUEVOvvzhTLIFXnoD2//OEgpQmThdBu96rRBU/KZGAHS75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3798
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgQWxsLA0KDQpTb3JyeSBmb3IgdGhlIHdyb25nIGNvbW1pdCBpZHMgb24gdGhlIHYyIHBhdGNo
c2V0Lg0KSSB3aWxsIGNvcnJlY3QgdGhlbSBvbiB2MyBwYXRjaHNldCBzb29uLg0KDQpCZXN0IFJl
Z2FyZHMsDQpYaWFvIFlhbmcNCk9uIDIwMjEvMy8yOSAxNzoyMCwgWGlhbyBZYW5nIHdyb3RlOg0K
PiBTaW5jZSBjb21taXQgZTdiZWQwYjViYzRiLCB0b2dnbGluZyBGU19YRkxBR19EQVggb24gYW4g
ZXhpc3RpbmcgZmlsZSBjYW4gbWFrZQ0KPiBTX0RBWCBvbiB0aGUgZmlsZSBjaGFuZ2UgaW1tZWRp
YXRlbHkgd2hlbiBhbGwgYXBwbGljYXRpb25zIGNsb3NlIHRoZSBmaWxlLg0KPiBBcyBhIHJlc3Vs
dCwgd2UgZG9uJ3QgbmVlZCB0aGUgcmVkdW5kYW50IGRyb3AgY2FjaGUgYW5kIHVtb3VudCAmIG1v
dW50IGN5Y2xlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFvbGkgRmVuZyA8eGlmZW5nQHJlZGhh
dC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+
DQo+IC0tLQ0KPiAgdGVzdHMvZ2VuZXJpYy82MDggfCA0MSArKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDIzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy82MDggYi90
ZXN0cy9nZW5lcmljLzYwOA0KPiBpbmRleCA4NjFiYmZmNS4uZDgxYTI0ODggMTAwNzU1DQo+IC0t
LSBhL3Rlc3RzL2dlbmVyaWMvNjA4DQo+ICsrKyBiL3Rlc3RzL2dlbmVyaWMvNjA4DQo+IEBAIC0z
LDEwICszLDEwIEBADQo+ICAjIENvcHlyaWdodCAoYykgMjAyMCBGdWppdHN1LiAgQWxsIFJpZ2h0
cyBSZXNlcnZlZC4NCj4gICMNCj4gICMgRlMgUUEgVGVzdCA2MDgNCj4gLSMgQ2hhbmdlIEZTX1hG
TEFHX0RBWCBvbiBhbiBleGlzdGluZyBmaWxlIGFuZCBjaGVjayBpZiBTX0RBWCBvbg0KPiAtIyB0
aGUgZmlsZSBjYW4gdGFrZSBlZmZlY3QgaW1tZWRpYXRlbHkgYnkgdGhlIGZvbGxvd2luZyBzdGVw
czoNCj4gLSMgMSkgU3RvcCBhbGwgYXBwbGljYXRpb25zIHdoaWNoIGFyZSB1c2luZyB0aGUgZmls
ZS4NCj4gLSMgMikgRG8gZHJvcF9jYWNoZXMgb3IgdW1vdW50ICYgbW91bnQgY3ljbGUuDQo+ICsj
IFRvZ2dsaW5nIEZTX1hGTEFHX0RBWCBvbiBhbiBleGlzdGluZyBmaWxlIGNhbiBtYWtlIFNfREFY
IG9uIHRoZQ0KPiArIyBmaWxlIGNoYW5nZSBpbW1lZGlhdGVseSB3aGVuIGFsbCBhcHBsaWNhdGlv
bnMgY2xvc2UgdGhlIGZpbGUuDQo+ICsjIEl0J3MgYSByZWdyZXNzaW9uIHRlc3QgZm9yOg0KPiAr
IyAnY29tbWl0IGU3YmVkMGI1YmM0YiAoImZzOiBLaWxsIERDQUNIRV9ET05UQ0FDSEUgZGVudHJ5
IGV2ZW4gaWYgRENBQ0hFX1JFRkVSRU5DRUQgaXMgc2V0IiknDQo+ICANCj4gIHNlcT1gYmFzZW5h
bWUgJDBgDQo+ICBzZXFyZXM9JFJFU1VMVF9ESVIvJHNlcQ0KPiBAQCAtMzYsNyArMzYsNyBAQCBf
cmVxdWlyZV9kYXhfaWZsYWcNCj4gIF9yZXF1aXJlX3hmc19pb19jb21tYW5kICJsc2F0dHIiICIt
diINCj4gIF9yZXF1aXJlX3hmc19pb19jb21tYW5kICJzdGF0eCIgIi1yIg0KPiAgDQo+IC10ZXN0
X2Ryb3BfY2FjaGVzKCkNCj4gK3Rlc3RfZW5hYmxlX2RheCgpDQo+ICB7DQo+ICAJbG9jYWwgdF9m
aWxlPSRTQ1JBVENIX01OVC90ZXN0ZmlsZQ0KPiAgDQo+IEBAIC00OSwyNCArNDksMTkgQEAgdGVz
dF9kcm9wX2NhY2hlcygpDQo+ICANCj4gIAkkWEZTX0lPX1BST0cgLWMgJ2NoYXR0ciAreCcgJHRf
ZmlsZQ0KPiAgCV9jaGVja194ZmxhZyAkdF9maWxlIDENCj4gLQlfY2hlY2tfc19kYXggJHRfZmls
ZSAwDQo+IC0NCj4gLQkjIE9uZSBhcHBsaWNhdGlvbiBpcyB1c2luZyB0ZXN0IGZpbGUgYW5kIGNo
ZWNrIGlmIFNfREFYIG9uDQo+IC0JIyB0aGUgZmlsZSBkb2Vzbid0IHRha2UgZWZmZWN0IGltbWVk
aWF0ZWx5IGJ5IGRyb3BfY2FjaGVzDQo+IC0JZWNobyAyID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2Fj
aGVzDQo+ICsJIyBPbmUgYXBwbGljYXRpb24gaXMgdXNpbmcgdGVzdCBmaWxlIGFuZCBTX0RBWA0K
PiArCSMgb24gdGhlIGZpbGUgaXMgbm90IGNoYW5nZWQgaW1tZWRpYXRlbHkNCj4gIAlfY2hlY2tf
c19kYXggJHRfZmlsZSAwDQo+ICANCj4gIAlleGVjIDM8Ji0NCj4gIA0KPiAtCSMgTm8gYXBwbGlj
YXRpb24gaXMgdXNpbmcgdGVzdCBmaWxlIGFuZCBjaGVjayBpZiBTX0RBWCBvbg0KPiAtCSMgdGhl
IGZpbGUgdGFrZXMgZWZmZWN0IGltbWVkaWF0ZWx5IGJ5IGRyb3BfY2FjaGVzDQo+IC0JZWNobyAy
ID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQo+ICsJIyBObyBhcHBsaWNhdGlvbiBpcyB1c2lu
ZyB0ZXN0IGZpbGUgYW5kIFNfREFYDQo+ICsJIyBvbiB0aGUgZmlsZSBpcyBjaGFuZ2VkIGltbWVk
aWF0ZWx5DQo+ICAJX2NoZWNrX3NfZGF4ICR0X2ZpbGUgMQ0KPiAgfQ0KPiAgDQo+IC10ZXN0X2N5
Y2xlX21vdW50KCkNCj4gK3Rlc3RfZGlzYWJsZV9kYXgoKQ0KPiAgew0KPiAtCWxvY2FsIG9wdGlv
bj0kMQ0KPiAgCWxvY2FsIHRfZGlyPSRTQ1JBVENIX01OVC90ZXN0ZGlyDQo+ICAJbG9jYWwgdF9m
aWxlPSR0X2Rpci90ZXN0ZmlsZQ0KPiAgDQo+IEBAIC04MSwyOSArNzYsMjkgQEAgdGVzdF9jeWNs
ZV9tb3VudCgpDQo+ICANCj4gIAkkWEZTX0lPX1BST0cgLWMgJ2NoYXR0ciAteCcgJHRfZmlsZQ0K
PiAgCV9jaGVja194ZmxhZyAkdF9maWxlIDANCj4gKwkjIE9uZSBhcHBsaWNhdGlvbiBpcyB1c2lu
ZyB0ZXN0IGZpbGUgYW5kIFNfREFYDQo+ICsJIyBvbiB0aGUgZmlsZSBpcyBub3QgY2hhbmdlZCBp
bW1lZGlhdGVseQ0KPiAgCV9jaGVja19zX2RheCAkdF9maWxlIDENCj4gIA0KPiAgCWV4ZWMgMzwm
LQ0KPiAgDQo+IC0JIyBObyBhcHBsaWNhdGlvbiBpcyB1c2luZyB0ZXN0IGZpbGUgYW5kIGNoZWNr
IGlmIFNfREFYIG9uDQo+IC0JIyB0aGUgZmlsZSB0YWtlcyBlZmZlY3QgaW1tZWRpYXRlbHkgYnkg
dW1vdW50ICYgbW91bnQNCj4gLQlfc2NyYXRjaF9jeWNsZV9tb3VudCAiJG9wdGlvbiINCj4gKwkj
IE5vIGFwcGxpY2F0aW9uIGlzIHVzaW5nIHRlc3QgZmlsZSBhbmQgU19EQVgNCj4gKwkjIG9uIHRo
ZSBmaWxlIGlzIGNoYW5nZWQgaW1tZWRpYXRlbHkNCj4gIAlfY2hlY2tfc19kYXggJHRfZmlsZSAw
DQo+ICB9DQo+ICANCj4gIGRvX3Rlc3RzKCkNCj4gIHsNCj4gIAlsb2NhbCBtb3VudF9vcHRpb249
JDENCj4gLQlsb2NhbCBjeWNsZV9tb3VudF9vcHRpb249JDINCj4gIA0KPiAgCV9zY3JhdGNoX21v
dW50ICIkbW91bnRfb3B0aW9uIg0KPiAgDQo+ICAJIyBNYWtlIHN1cmUgdGhlIHJvb3QgZGlyIGRv
ZXNuJ3QgaGF2ZSBGU19YRkxBR19EQVggc2V0IGJlZm9yZSB3ZSBzdGFydC4NCj4gIAkkWEZTX0lP
X1BST0cgLWMgImNoYXR0ciAteCIgJFNDUkFUQ0hfTU5UICY+PiAkc2VxcmVzLmZ1bGwNCj4gIA0K
PiAtCXRlc3RfZHJvcF9jYWNoZXMNCj4gLQ0KPiAtCXRlc3RfY3ljbGVfbW91bnQgIiRjeWNsZV9t
b3VudF9vcHRpb24iDQo+ICsJIyBEbyB0ZXN0IGZvciBjb21taXQgZTdiZWQwYjViYzRiDQo+ICsJ
dGVzdF9lbmFibGVfZGF4DQo+ICsJdGVzdF9kaXNhYmxlX2RheA0KPiAgDQo+ICAJX3NjcmF0Y2hf
dW5tb3VudA0KPiAgfQ0KPiBAQCAtMTExLDcgKzEwNiw3IEBAIGRvX3Rlc3RzKCkNCj4gIF9zY3Jh
dGNoX21rZnMgPj4gJHNlcXJlcy5mdWxsIDI+JjENCj4gIA0KPiAgIyBNb3VudCB3aXRoIGRheCBv
cHRpb24NCj4gLWRvX3Rlc3RzICItbyBkYXg9aW5vZGUiICJkYXg9aW5vZGUiDQo+ICtkb190ZXN0
cyAiLW8gZGF4PWlub2RlIg0KPiAgDQo+ICAjIE1vdW50IHdpdGhvdXQgZGF4IG9wdGlvbg0KPiAg
ZXhwb3J0IE1PVU5UX09QVElPTlM9IiINCg==
