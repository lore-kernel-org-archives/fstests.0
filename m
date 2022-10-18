Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E72C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Oct 2022 06:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJRG0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJRG0n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Oct 2022 02:26:43 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 23:26:33 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13E74348
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666074394; x=1697610394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TwNkTmGJbTeuCLEarrRwwd2tcwGElW0GcvS04GrjO3s=;
  b=HZrTTkM1jdO4c29gskxhBIkxNlRlZfzR321ZPhR3NtEzMBKkDM/Sz+zk
   0bcUf306iZdbahTebLx7YizMIWJpifuIyTaqss4wwpIpN97p6SXrNi+px
   juSHz6h46mwWC4fpAIhmBZvbV9bZxfzEbKSAP3z4OkVeaSUyCQajMRucf
   JeOQL4d1RVT7RW9LWOhPR7b1ATVpM8qXJUFOOfpcK865fP64MJcPPiy4x
   2JKvAFigrZq6oFAeOQFvm6x8kiXvbxszYGcCcuG50v7tjy6a6NusqazPY
   hScMiXcyEYu6aNePbeOMsdtm/QbLyHrft2VFkBw7NfHUFz79PldDtnykk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="67519968"
X-IronPort-AV: E=Sophos;i="5.95,193,1661785200"; 
   d="scan'208";a="67519968"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:25:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnJtiHDlakPMqaX6YXECOKMGCi9G3ghxdHDFRYu6aq+5FRU9ud7ehu1/fV/XyQJd82Ex0lvzHn7QKbhPzsxbGL8ZOuD/djI/pSGD9tZLI5DXXNQGwncxm1Ays/P/pReJevNhNtqLmLu57NQM/0ejqG8/7AHxx2TqeXGrmYw0yAoyt+KvsSNW8mVZJu2/JfLuY2W3LYYan02ZavAx0eUBssC2HT6ZeftBGaJ9MwW3gJRzhKrBvrRbb8/LstT88CU0AsSy7RmzJYPlT8FBkGX3KW+ZGCwZZgB/DCcqY305dzIWVHIYoHRZaEq722AGyOP5vKX/sgM0qOyltOAR2RGp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwNkTmGJbTeuCLEarrRwwd2tcwGElW0GcvS04GrjO3s=;
 b=hOi7YRpGLKf9xt1ltk0X14ErvDVFezyI6KL59ncQo4h9KNy8Zpzi+IDhZ0dF4fkVwwe26psapNDHoxCgxvg5u01Onj+H11UCgSOAcwYLzKth5im54YuTz+ddwjPiRbAJUiJ9IcU+4FjBd1OMlZHOkJNBedAYXKZbPCEjCavi10Rn89bErfDijZ5ekpfef5ctPYVxwJ+yN+Hi4KlbxeAhgwT0NJR0TJ/IBhZjnGRmYlymGId7fxw4TorQ/Rnrqxs5tZ0Sg6WOmPE0pWsnhyNuTJxDVsnO/UwZi4AMAVYxCuDm4kPsH1j0CHffAf/ook19p35FoZ9V6d7moSI0/QtQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB10346.jpnprd01.prod.outlook.com (2603:1096:400:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 06:25:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 06:25:18 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "brauner@kernel.org" <brauner@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] Add more suid/sgid related cases to perms group
Thread-Topic: [PATCH] Add more suid/sgid related cases to perms group
Thread-Index: AQHY4p9b/LrTBCXJqkaaucA+L86exK4TrP+AgAATfQA=
Date:   Tue, 18 Oct 2022 06:25:18 +0000
Message-ID: <a5c5b77d-efe7-6535-90c4-f2e0c4ffe65b@fujitsu.com>
References: <1666066330-2006-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20221018061613.ul7nqupy3g34vjqe@zlang-mailbox>
In-Reply-To: <20221018061613.ul7nqupy3g34vjqe@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYWPR01MB10346:EE_
x-ms-office365-filtering-correlation-id: a066641b-1318-4b98-e050-08dab0d18738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2eJhZBJffHyRUuQqS3jD18hcsYG4nUFtVSgZzBBPDoFARnQxBbLnbJxE7vsUbfsYjiNZ2XNM8rh85R8DuSKC3n0IldxEyiMQ6UwuaPFGsPPWuSVG6phW4G1yizqcg9VdhoA/uckURecy0TpnunDyU6FPGjPh1+tgL7Iu/9K/EUMvfIhdAkrtE+5oPrINTYYf+Jb0a67FasYa/Ka5SQu+XxM42XvvHw2tjnU4NLLvAYMaLOQUXyUUADm8F4U+prB3YeRRda2llgrw+AQa0zNfJez1fG0woV8e4oicer8dEvHZYSx2tIwgqgYOlUWVAulZ/1k80GxvBTH7qFDOr5PkO4hZHtoIKr4dw2B/ahUg1OI/v15O0Hw22mYBkpEuMnRGf5sAd/vD5g1Mgs8TdPpp9+G5fmkYAL4QWNGoJmVAsd1FMEjDddNuxe6FrxsOqS9fnvELfMoFixFyW/BKJ7l3CMhTSOdx1iZwQujPoPi3cHlKKFGdryxqkiS3wvQKza9pMR1dCyHgBDlJeciAQ92puaQD1LwsvrukcdJwZyKbWPVRA46nAyC/ueFHjJ2rnxNlCSVojNK/LKJYWE9nrHdsChR6/+S3poki3kbMBH3fjGDMLe7EEYyA5oIwEp21JGSYfKK/6RhI689JhGu6FxE8L3mtEZH7nQ/RLgqJ7MDnP3zCuhO8yVB4c6qzuDFNeX2xcrcqnqPa03TpSgDwj3mqzf30prTTDjVFT8ELgj1IAY9ReMVYVGdYi0XBVO+QK2NFOkzXx4LIUH58W43Q8Pdx19RKYRy0dL1rAaFKf33wN2CA5xrl0p29KtsGC5O7yt1ZNTVJbApYB42stiob146iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(1590799012)(451199015)(186003)(2616005)(26005)(478600001)(6486002)(6506007)(6512007)(86362001)(71200400001)(31696002)(91956017)(76116006)(8676002)(36756003)(66946007)(4326008)(66556008)(66476007)(66446008)(64756008)(6916009)(54906003)(316002)(83380400001)(38070700005)(5660300002)(8936002)(85182001)(41300700001)(38100700002)(82960400001)(31686004)(2906002)(122000001)(1580799009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEEyMjY3WFdSamcveTVsREtUWFRrbUM1Y0E4d1hBZDZvVWN3aGY1c1BMU253?=
 =?utf-8?B?Q21wU1o1YVVhSkFHTTBhYzZubFA0SkI0eUtFQUZ6Ynk1SUxwWkpWL053d21h?=
 =?utf-8?B?aEQ1SFQ5ejc0d3BoTm5tbUdjSUV2c0p0eEorYm1zS0xEK2t0Y01IdFZjcHhU?=
 =?utf-8?B?UmVLY0VzdWZiZERFai9sRXcvaUV5VTJjV083YVVaOHA4VGRDK2tOSXBKTTQ2?=
 =?utf-8?B?R1NqUHk1TzNxalBZRVlvTVJxc1pWUGExNzlLeGVWUG5Ea2NCeDdhbmlsZzNv?=
 =?utf-8?B?VG1nVE0xb2VyQmJHdy8xOWp5dVBXV0QxbEcwTlJRR25SNzJVOWhwTHBOVG9i?=
 =?utf-8?B?MGl3UkdVaS9wSlZERHJFRUl3UGQ3dzVyNjltVzIwLytJMHRZbmxPaEx2aldC?=
 =?utf-8?B?OVkyQmh2eTh3Vm5FYVZKZHF2ZmFCakNSQ2lxTFQwY0JTVW0xcW1KQmNVc0VF?=
 =?utf-8?B?WHo0ZlJQNzlDckVNSWhiSzFLYWlLZFluY2lmNnpvSVVvNWRXaWxqU2RGMS9p?=
 =?utf-8?B?VllKL0dVcEtkWHUyQUhqRU9tTEVvY1JjMFBENUt4dzRuenpJOTU4M3ZLSWNI?=
 =?utf-8?B?OUJWSDRocW9mK0tjWTFNVE84T3VNeExPYnRsU1V1RDJmaEM0UUc2VEUzVGRC?=
 =?utf-8?B?enVDcGtXWE9ETkpWU0QyWFRmcWl6bWM5OGtoOFdwZXRVd1VRdk5rdWRuZ0Ra?=
 =?utf-8?B?RndGNWIreUJWTVloWG9kNC9CNDIzK0RkeWN4Ynozd200Sk50MjBPZSt2ampt?=
 =?utf-8?B?STZJd3hDeDNVVEgrUytMemdLOWJUZFI0cEl4bjZvTnJYNFZSdm84bURrOG1t?=
 =?utf-8?B?eVI3V2pHRmMyVm4vdnpwVGR6d1RRc0gzaGlEUVhCdFNyc3QrODdLRVpMQXVM?=
 =?utf-8?B?K3VJQUJZTFZzU2RoWndBYTROUlZkcU16NE80OElPVURiWWRFd2hIUklqOXNk?=
 =?utf-8?B?S244UEgyN0xlRHZwTGNTRHBiREgrNkR0NVNCajlyRUhOUTRWSGliKzgyKzd1?=
 =?utf-8?B?M0phUU8yd201d1Y4bzl6WE1MVit3Ym1qWnlLNHJIN2J6Q3M1aWNnMDlwSnUz?=
 =?utf-8?B?S2tGKzM4TjdISUZBY0ZXWDYxa0FORVFOSFlTWG5oWWlKSjFZUlRmbGkxcTFx?=
 =?utf-8?B?enpXNi9qTmNaSk81RVR6MWRONzBzemxXNlY2cDM4dE0xQjdvdHhpeW9UZjhr?=
 =?utf-8?B?NmkrQ05KQ3BvQTNRSDdtaXFhb2FmOVNYRHEyeC9paGorc2VaNnBwRnNmbFVK?=
 =?utf-8?B?bEJ6WWltM215ckhvSFpWWnJoYlNGZ2dsT2Zqd2Y4Ukg0UVJwMml6d1RtQWU4?=
 =?utf-8?B?YU9aWkFjSjE1TVFPSjY3RkplTlNGSFhYSndBd1pBSEtKRFhKbFRRWmxjYlEz?=
 =?utf-8?B?NWxHNTJqeHpwLzhuWStSNStZSmgrNXB1eVJQdzJQQWltclFtb3JwTmZYLzd5?=
 =?utf-8?B?NUVRUjJpK0VzWDRydVhxc2l5UVd0bEpsUG5BUWJVckszVjNlZG1PbEJYOHVj?=
 =?utf-8?B?TTdhQVNucWxmbE9pLzNuaGNSb1N0cFBsUnRJYXZPVXVWWTd5R3ZnMVhJeGdN?=
 =?utf-8?B?VWRCRUFNZlJUWmtRNGhYeXRGTDdEeWtlU1pCQVBhUy9HeWJZR2xOOStPdnU3?=
 =?utf-8?B?QUZ4Z2FGaGtKZWc0Z2d3MXpqSjNZdzhGWmZjSkxKa0NNTHovYm1KYllGWnBi?=
 =?utf-8?B?QlhhRVgrc0tsOWxxcmhNbFRLQXVKVDFheVcvYkcvNG5iOVpuQnU4eno0MDhE?=
 =?utf-8?B?UXZYQ1pQMCs1WHRTRThNUWo0K0hubkQ2V0xzWnVMOFJDTkpjcy9tR2xNRDdI?=
 =?utf-8?B?SmI4SjhURnRtQW1xdTc1bkxiSk1oVVVkM0t0eUdPYUtrQ2xsN3MzckdHQ1RS?=
 =?utf-8?B?bFpJWVhPb0xNTnVvNFM5SzZyUHM3ZHR5UkkvVDd5cjBHc3F3bVBXL3NYMzZy?=
 =?utf-8?B?aDdxeHMxTHVsbFI4M2tVMWJVRnZ6dGlGT0dCRGpwOS9tL3BINFNReko3MDlX?=
 =?utf-8?B?a3NNSWxzb1RIc2hNYVlLUGl4YlM3TTBrc1NqM3BDblZnMitLVFh0WldmaVNo?=
 =?utf-8?B?TmtZUzc3WmIxMzMrdEh1MGRHRmhjU2V1ei9Wc2FIMldOU2dSRDNaUTZ4L0Rq?=
 =?utf-8?B?NHFLUFc4N2ZJdCt5WCszaG1uY1BoU3kwUWx4bUkrLzQ4RkxqUEdzSm5sQzhG?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B5AE9C60BA5945808C99558B8DC550@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a066641b-1318-4b98-e050-08dab0d18738
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 06:25:18.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJcyaRpisvlFuo5vpE2N4WFSGtcN7hMX/P50BgzIodQElQzLHHnyQeoafSShxeHk6uaeRFnooeAujpsXPR5OgGg2PxZ8+g+HxnauOYBn7Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10346
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgWm9ycm8NCg0KPiBPbiBUdWUsIE9jdCAxOCwgMjAyMiBhdCAxMjoxMjoxMFBNICswODAwLCBZ
YW5nIFh1IHdyb3RlOg0KPj4gSnVzdCB1c2UgdGhlIGZvbGxvd2luZyB3YXlzIHRvIGxvb2sgZm9y
IHRoZXNlIGNhc2VzDQo+PiAxKSBncmVwIC1uc3Igc3VpZCBvciBncmVwIC1uc3Igc2dpZA0KPj4g
MikgZ3JlcCAtbnNyIGNobW9kIHwgZ3JlcCAiK3MiDQo+PiAzKSBncmVwIC1uc3IgSVNVSUQvSVNH
SUQgdGhlbiBzZWFyY2ggZXhlY3V0ZSBwcm9ncmFtIGllKHZmc3Rlc3QvaWRtYXBwZWRfbW91bnRz
KQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5j
b20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvZ2VuZXJpYy8xOTMgfCAyICstDQo+PiAgIHRlc3RzL2dl
bmVyaWMvMzU1IHwgMiArLQ0KPj4gICB0ZXN0cy9nZW5lcmljLzY3MyB8IDIgKy0NCj4+ICAgdGVz
dHMvZ2VuZXJpYy82NzQgfCAyICstDQo+PiAgIHRlc3RzL2dlbmVyaWMvNjgzIHwgMiArLQ0KPj4g
ICB0ZXN0cy9nZW5lcmljLzY4NCB8IDIgKy0NCj4+ICAgdGVzdHMvZ2VuZXJpYy82ODUgfCAyICst
DQo+PiAgIHRlc3RzL2dlbmVyaWMvNjg2IHwgMiArLQ0KPj4gICB0ZXN0cy9nZW5lcmljLzY4NyB8
IDIgKy0NCj4+ICAgdGVzdHMvb3ZlcmxheS8wMTUgfCAyICstDQo+PiAgIDEwIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gQWNjb3JkaW5nIHRv
IHRoZSBkZWZpbml0aW9uIG9mICJwZXJtcyIgZ3JvdXA6DQo+ICAgIHBlcm1zICAgICAgICAgICAg
ICAgICAgIGFjY2VzcyBjb250cm9sIGFuZCBwZXJtaXNzaW9uIGNoZWNraW5nDQo+IA0KPiBJdCdz
IG5vdCBvbmx5IGFib3V0IHN1aWQvc2dpZC4gSSB0cnkgdG8gY2hlY2sgbW9yZSAocm91Z2hseSks
IGZpbmQgYmVsb3cNCj4gY2FzZXNbMV0gbWlnaHQgYmUgcmVsYXRlZCB3aXRoICJwZXJtcyIsIHBs
ZWFzZSBkb3VibGUgY2hlY2sgYW5kIGFkZCBtb3JlIHByb3Blcg0KPiBjYXNlcyBpbnRvIHBlcm1z
IGdyb3VwIChpZiB0aGVyZSdyZSBtb3JlKS4NCg0KT2ssIHdpbGwgZG8uIENhbiB5b3Ugc2hhcmUg
d2hpY2ggc2ltcGxlIHdheSB5b3UgdXNlZCB0byBmaW5kIHRoZXNlIGNhc2VzPw0KDQpCZXN0IFJl
Z2FyZHMNCllhbmcgWHUNCj4gDQo+IFRoYW5rcywNCj4gWm9ycm8NCj4gDQo+IFsxXQ0KPiBnZW5l
cmljLzA5OSwgZ2VuZXJpYy8xMDUsIGdlbmVyaWMvMTI4LCBnZW5lcmljLzIzNywgZ2VuZXJpYy8z
MTQsIGdlbmVyaWMvMzE4LA0KPiBnZW5lcmljLzMxOSwgZ2VuZXJpYy8zNjIsIGdlbmVyaWMvMzYz
LCBnZW5lcmljLzM2NCwgZ2VuZXJpYy8zNjUsIGdlbmVyaWMvMzY2LA0KPiBnZW5lcmljLzM2Nywg
Z2VuZXJpYy8zNjgsIGdlbmVyaWMvMzY5LCBnZW5lcmljLzM3MCwgZ2VuZXJpYy8zNzUsIGdlbmVy
aWMvNDQ0LA0KPiBnZW5lcmljLzY5OCwgZ2VuZXJpYy82OTksIG92ZXJsYXkvMDA0LCBvdmVybGF5
LzAwOCwgb3ZlcmxheS8wMjMNCj4gDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMv
MTkzIGIvdGVzdHMvZ2VuZXJpYy8xOTMNCj4+IGluZGV4IGRkYWZmNjliLi5lMjcxMGIwNyAxMDA3
NTUNCj4+IC0tLSBhL3Rlc3RzL2dlbmVyaWMvMTkzDQo+PiArKysgYi90ZXN0cy9nZW5lcmljLzE5
Mw0KPj4gQEAgLTcsNyArNyw3IEBADQo+PiAgICMgVGVzdCBwZXJtaXNzaW9uIGNoZWNrcyBpbiAt
PnNldGF0dHINCj4+ICAgIw0KPj4gICAuIC4vY29tbW9uL3ByZWFtYmxlDQo+PiAtX2JlZ2luX2Zz
dGVzdCBtZXRhZGF0YSBhdXRvIHF1aWNrDQo+PiArX2JlZ2luX2ZzdGVzdCBtZXRhZGF0YSBhdXRv
IHF1aWNrIHBlcm1zDQo+PiAgIA0KPj4gICBfcmVnaXN0ZXJfY2xlYW51cCAiX2NsZWFudXBfZmls
ZXMiDQo+PiAgIHRhZz0iYWRkZWQgYnkgcWEgJHNlcSINCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9n
ZW5lcmljLzM1NSBiL3Rlc3RzL2dlbmVyaWMvMzU1DQo+PiBpbmRleCA0YmM2OWVlYi4uN2MxMDhk
MWIgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9nZW5lcmljLzM1NQ0KPj4gKysrIGIvdGVzdHMvZ2Vu
ZXJpYy8zNTUNCj4+IEBAIC03LDcgKzcsNyBAQA0KPj4gICAjIFRlc3QgY2xlYXIgb2Ygc3VpZC9z
Z2lkIG9uIGRpcmVjdCB3cml0ZS4NCj4+ICAgIw0KPj4gICAuIC4vY29tbW9uL3ByZWFtYmxlDQo+
PiAtX2JlZ2luX2ZzdGVzdCBhdXRvIHF1aWNrDQo+PiArX2JlZ2luX2ZzdGVzdCBhdXRvIHF1aWNr
IHBlcm1zDQo+PiAgIA0KPj4gICAjIEltcG9ydCBjb21tb24gZnVuY3Rpb25zLg0KPj4gICAuIC4v
Y29tbW9uL2ZpbHRlcg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNjczIGIvdGVzdHMv
Z2VuZXJpYy82NzMNCj4+IGluZGV4IDRkOGRjMDdlLi42ZDFmNDllYSAxMDA3NTUNCj4+IC0tLSBh
L3Rlc3RzL2dlbmVyaWMvNjczDQo+PiArKysgYi90ZXN0cy9nZW5lcmljLzY3Mw0KPj4gQEAgLTcs
NyArNyw3IEBADQo+PiAgICMgRnVuY3Rpb25hbCB0ZXN0IGZvciBkcm9wcGluZyBzdWlkIGFuZCBz
Z2lkIGJpdHMgYXMgcGFydCBvZiBhIHJlZmxpbmsuDQo+PiAgICMNCj4+ICAgLiAuL2NvbW1vbi9w
cmVhbWJsZQ0KPj4gLV9iZWdpbl9mc3Rlc3QgYXV0byBjbG9uZSBxdWljaw0KPj4gK19iZWdpbl9m
c3Rlc3QgYXV0byBjbG9uZSBxdWljayBwZXJtcw0KPj4gICANCj4+ICAgIyBJbXBvcnQgY29tbW9u
IGZ1bmN0aW9ucy4NCj4+ICAgLiAuL2NvbW1vbi9maWx0ZXINCj4+IGRpZmYgLS1naXQgYS90ZXN0
cy9nZW5lcmljLzY3NCBiL3Rlc3RzL2dlbmVyaWMvNjc0DQo+PiBpbmRleCBhMzEzMDI0OS4uYzNm
ZjFiN2IgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9nZW5lcmljLzY3NA0KPj4gKysrIGIvdGVzdHMv
Z2VuZXJpYy82NzQNCj4+IEBAIC03LDcgKzcsNyBAQA0KPj4gICAjIEZ1bmN0aW9uYWwgdGVzdCBm
b3IgZHJvcHBpbmcgc3VpZCBhbmQgc2dpZCBiaXRzIGFzIHBhcnQgb2YgYSBkZWR1cGxpY2F0aW9u
Lg0KPj4gICAjDQo+PiAgIC4gLi9jb21tb24vcHJlYW1ibGUNCj4+IC1fYmVnaW5fZnN0ZXN0IGF1
dG8gY2xvbmUgcXVpY2sNCj4+ICtfYmVnaW5fZnN0ZXN0IGF1dG8gY2xvbmUgcXVpY2sgcGVybXMN
Cj4+ICAgDQo+PiAgICMgSW1wb3J0IGNvbW1vbiBmdW5jdGlvbnMuDQo+PiAgIC4gLi9jb21tb24v
ZmlsdGVyDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy82ODMgYi90ZXN0cy9nZW5lcmlj
LzY4Mw0KPj4gaW5kZXggNGM5MzM0NmQuLjMwMmY4YmIyIDEwMDc1NQ0KPj4gLS0tIGEvdGVzdHMv
Z2VuZXJpYy82ODMNCj4+ICsrKyBiL3Rlc3RzL2dlbmVyaWMvNjgzDQo+PiBAQCAtNyw3ICs3LDcg
QEANCj4+ICAgIyBGdW5jdGlvbmFsIHRlc3QgZm9yIGRyb3BwaW5nIHN1aWQgYW5kIHNnaWQgYml0
cyBhcyBwYXJ0IG9mIGEgZmFsbG9jYXRlLg0KPj4gICAjDQo+PiAgIC4gLi9jb21tb24vcHJlYW1i
bGUNCj4+IC1fYmVnaW5fZnN0ZXN0IGF1dG8gY2xvbmUgcXVpY2sNCj4+ICtfYmVnaW5fZnN0ZXN0
IGF1dG8gY2xvbmUgcXVpY2sgcGVybXMNCj4+ICAgDQo+PiAgICMgT3ZlcnJpZGUgdGhlIGRlZmF1
bHQgY2xlYW51cCBmdW5jdGlvbi4NCj4+ICAgX2NsZWFudXAoKQ0KPj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL2dlbmVyaWMvNjg0IGIvdGVzdHMvZ2VuZXJpYy82ODQNCj4+IGluZGV4IDAzNDgxZTY5Li4x
OWNjYjIyOCAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL2dlbmVyaWMvNjg0DQo+PiArKysgYi90ZXN0
cy9nZW5lcmljLzY4NA0KPj4gQEAgLTcsNyArNyw3IEBADQo+PiAgICMgRnVuY3Rpb25hbCB0ZXN0
IGZvciBkcm9wcGluZyBzdWlkIGFuZCBzZ2lkIGJpdHMgYXMgcGFydCBvZiBhIGZwdW5jaC4NCj4+
ICAgIw0KPj4gICAuIC4vY29tbW9uL3ByZWFtYmxlDQo+PiAtX2JlZ2luX2ZzdGVzdCBhdXRvIGNs
b25lIHF1aWNrDQo+PiArX2JlZ2luX2ZzdGVzdCBhdXRvIGNsb25lIHF1aWNrIHBlcm1zDQo+PiAg
IA0KPj4gICAjIE92ZXJyaWRlIHRoZSBkZWZhdWx0IGNsZWFudXAgZnVuY3Rpb24uDQo+PiAgIF9j
bGVhbnVwKCkNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9nZW5lcmljLzY4NSBiL3Rlc3RzL2dlbmVy
aWMvNjg1DQo+PiBpbmRleCA2YTEwODg0Mi4uYTU4ZWNjZGEgMTAwNzU1DQo+PiAtLS0gYS90ZXN0
cy9nZW5lcmljLzY4NQ0KPj4gKysrIGIvdGVzdHMvZ2VuZXJpYy82ODUNCj4+IEBAIC03LDcgKzcs
NyBAQA0KPj4gICAjIEZ1bmN0aW9uYWwgdGVzdCBmb3IgZHJvcHBpbmcgc3VpZCBhbmQgc2dpZCBi
aXRzIGFzIHBhcnQgb2YgYSBmemVyby4NCj4+ICAgIw0KPj4gICAuIC4vY29tbW9uL3ByZWFtYmxl
DQo+PiAtX2JlZ2luX2ZzdGVzdCBhdXRvIGNsb25lIHF1aWNrDQo+PiArX2JlZ2luX2ZzdGVzdCBh
dXRvIGNsb25lIHF1aWNrIHBlcm1zDQo+PiAgIA0KPj4gICAjIE92ZXJyaWRlIHRoZSBkZWZhdWx0
IGNsZWFudXAgZnVuY3Rpb24uDQo+PiAgIF9jbGVhbnVwKCkNCj4+IGRpZmYgLS1naXQgYS90ZXN0
cy9nZW5lcmljLzY4NiBiL3Rlc3RzL2dlbmVyaWMvNjg2DQo+PiBpbmRleCA0Mjc5Zjc2Yi4uZWY5
ZWE0N2EgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9nZW5lcmljLzY4Ng0KPj4gKysrIGIvdGVzdHMv
Z2VuZXJpYy82ODYNCj4+IEBAIC03LDcgKzcsNyBAQA0KPj4gICAjIEZ1bmN0aW9uYWwgdGVzdCBm
b3IgZHJvcHBpbmcgc3VpZCBhbmQgc2dpZCBiaXRzIGFzIHBhcnQgb2YgYSBmaW5zZXJ0Lg0KPj4g
ICAjDQo+PiAgIC4gLi9jb21tb24vcHJlYW1ibGUNCj4+IC1fYmVnaW5fZnN0ZXN0IGF1dG8gY2xv
bmUgcXVpY2sNCj4+ICtfYmVnaW5fZnN0ZXN0IGF1dG8gY2xvbmUgcXVpY2sgcGVybXMNCj4+ICAg
DQo+PiAgICMgT3ZlcnJpZGUgdGhlIGRlZmF1bHQgY2xlYW51cCBmdW5jdGlvbi4NCj4+ICAgX2Ns
ZWFudXAoKQ0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNjg3IGIvdGVzdHMvZ2VuZXJp
Yy82ODcNCj4+IGluZGV4IDc4Y2I2MjAyLi5mNGExYzFiYiAxMDA3NTUNCj4+IC0tLSBhL3Rlc3Rz
L2dlbmVyaWMvNjg3DQo+PiArKysgYi90ZXN0cy9nZW5lcmljLzY4Nw0KPj4gQEAgLTcsNyArNyw3
IEBADQo+PiAgICMgRnVuY3Rpb25hbCB0ZXN0IGZvciBkcm9wcGluZyBzdWlkIGFuZCBzZ2lkIGJp
dHMgYXMgcGFydCBvZiBhIGZjb2xsYXBzZS4NCj4+ICAgIw0KPj4gICAuIC4vY29tbW9uL3ByZWFt
YmxlDQo+PiAtX2JlZ2luX2ZzdGVzdCBhdXRvIGNsb25lIHF1aWNrDQo+PiArX2JlZ2luX2ZzdGVz
dCBhdXRvIGNsb25lIHF1aWNrIHBlcm1zDQo+PiAgIA0KPj4gICAjIE92ZXJyaWRlIHRoZSBkZWZh
dWx0IGNsZWFudXAgZnVuY3Rpb24uDQo+PiAgIF9jbGVhbnVwKCkNCj4+IGRpZmYgLS1naXQgYS90
ZXN0cy9vdmVybGF5LzAxNSBiL3Rlc3RzL292ZXJsYXkvMDE1DQo+PiBpbmRleCBmZDIzZTM3My4u
ZjBjMDU1NzkgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9vdmVybGF5LzAxNQ0KPj4gKysrIGIvdGVz
dHMvb3ZlcmxheS8wMTUNCj4+IEBAIC03LDcgKzcsNyBAQA0KPj4gICAjIFNHSUQgYml0IGluaGVy
aXRhbmNlIG92ZXIgd2hpdGVvdXQuDQo+PiAgICMNCj4+ICAgLiAuL2NvbW1vbi9wcmVhbWJsZQ0K
Pj4gLV9iZWdpbl9mc3Rlc3QgYXV0byBxdWljayB3aGl0ZW91dA0KPj4gK19iZWdpbl9mc3Rlc3Qg
YXV0byBxdWljayB3aGl0ZW91dCBwZXJtcw0KPj4gICANCj4+ICAgIyBJbXBvcnQgY29tbW9uIGZ1
bmN0aW9ucy4NCj4+ICAgLiAuL2NvbW1vbi9maWx0ZXINCj4+IC0tIA0KPj4gMi4yNy4wDQo+Pg0K
PiA=
