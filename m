Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA87C43334
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Jul 2022 05:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGEFsC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Jul 2022 01:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEFsB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Jul 2022 01:48:01 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 22:47:59 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1495A1
        for <fstests@vger.kernel.org>; Mon,  4 Jul 2022 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657000080; x=1688536080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3QX4Km/L7zz4tty7tZb7UlYSVOXxtD4wBjypNi4IfbQ=;
  b=SPL4AeMEuvvkObRsLQThKmxbzkHpMsrhqzcdUAJBUCG/V8xO70oNhKJo
   gwUqbOXt6RnJt//BK6QBg9Rnb20oKH7O+4f71yb34uSBoMmufQ75EMvHt
   SIfyvYonLojvyZMDc9Czye+nSsUwQgpG8nCBzBdVnQk/L8OCOFlkPNPI7
   ZDp9zwXLv3cdKdFFztPAWL2xuKLeZj8TskDJgPn5GLewdVSRb8dp95SgF
   jyK7wKaBtb5DmzndDWSzyRk1XQoHdIxT7leafzHyghXTpwD1l8gRw7nJs
   klI5Q67sUWdoJJ9j7IukLdag/nVzYBB5OzYKqOCSid710kJjQruiAntJw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="59592062"
X-IronPort-AV: E=Sophos;i="5.92,245,1650898800"; 
   d="scan'208";a="59592062"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:46:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjpiqc696WdixKezlTkol+b8tP7GqINicZWHGNXgea6KcCkk3cGmHwt8lL6MUq89PQ96ifgdnqnjlA/Se2tuaLvkIZZV3Y0+qZIp4KheglsDE/vAmAISDYzalUePx63RkWtEB8fNkAYT/gud2aKrp9ZDhe2FxPrCHzgzQCCt9xaDBX7ZHjd4BG5dYc91FoP9KaaofTFkhb2fX29hU7L3/MPw7eMu6zqogTvV6LIpacAXShl3/jGL6PxE0Pjd5TBSRmffAOMkjqg53C+waiAwQ7LQEXo5r0DwVpmC0pCu8kIn9m4/nddL9M15N6PtY8+Ff4ki1IjQRW1NyDfiuqCXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QX4Km/L7zz4tty7tZb7UlYSVOXxtD4wBjypNi4IfbQ=;
 b=iwotb9z3E2nrt02ghqm6JTpgMbpekuZr4DumuM65c7ySGL+dC1//vxis1c/UHnoQOheCkk9/DkKrnq7gczHSi4lxHW2jCvw8k3gC4i/yoXexbO0po/oav74MamOVv+XxoTPumL45lb2ctUYDCSvMs26Wr8wXBruJXh+U/mH0dyngCfjHc7X9dMgjhd0/s60ZxMzcnpc+IzzfNL/Ih53zThiDT59+DRsxd5jgafzD1O0FLuh3QvmSo1luZPW3XaAJG3oTXb3dBQDPoLBB90Syr4pnATS8+ITafokhC7nTIHnWMrNQLt4q5BAO8djLiv8PxBGuuz3y5wEZvlX2fItRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QX4Km/L7zz4tty7tZb7UlYSVOXxtD4wBjypNi4IfbQ=;
 b=pS6Dj6JUIpY/iAGsenY/gyk9SYfVk11ILetExXf0rOs4UJQlUEsRsnLGYKjepdAIdH6NLioWUt+M10kxUdm64W//KUhSb/fG6hAVvJrT3LOFFIFg8qj9QKPtLbqmbAcJguiKz3KUOvsLilN1yOCd0GICz6eXjbLhewHB7cUXKY8=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3618.jpnprd01.prod.outlook.com (2603:1096:604:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 05:46:50 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 05:46:50 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/2] xfs/270: only check new_ro_compat value when mkfs.xfs
 supports nrext64 feature
Thread-Topic: [PATCH 1/2] xfs/270: only check new_ro_compat value when
 mkfs.xfs supports nrext64 feature
Thread-Index: AQHYiin5NB1CMHYLW0CyC1PmVpHMQK1uZREAgAD83IA=
Date:   Tue, 5 Jul 2022 05:46:50 +0000
Message-ID: <62C3DE8F.5030306@fujitsu.com>
References: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220704154242.sfq7ekeprovowcr2@zlang-mailbox>
In-Reply-To: <20220704154242.sfq7ekeprovowcr2@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdf1ae2c-7b3d-43bd-2d6e-08da5e49c1fb
x-ms-traffictypediagnostic: OSAPR01MB3618:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVNUoIwZcQtKoVwyUCKfbiQfOOmRKyN5qiBUvcesqZGL0uCJ+u0omWJLVNwikj31wqHfOiuX4Y4s+S+ziCroa5yVMEy/OWHkdRd+xibIxoqsb0nvObSkIMQFHD8spJyV1k4Us46wOk3dpPg3MfDFPWXbZ2yG2+YeymwX0PqXeVXBKoYT/Ge9hWuekGOQnCSM7Gd1rxaTz+f4HQRjHY42NxULZVo2BNjMZ2f4OPs/PA1ETKIg0rZ1WLXSoYHulhxA3KqntOlhzl8EIBDtiZflqp4C4+C220E32JDpurmcYaUt3QPEpvN0y6K3gxzu55ZPTmzYg1kLlO6GRlK03kHtLFZx5RHOA6DdNY6WWkmzyfUslfbYdFdsG7jTxoOYrRXAkJWNapEzHiv+Tm5QMsRqAU9uvVT/h5bVc/SrvSs1wVhGW2Qtf+si5WnCnZ9sVIi/VuvZ9Aiarggs1JC/vGaQXYcKwJr9ZigkTtK8H7cAl55j2t5Fdzd/G382CIht200xNETPfpVhf2FWStoWK4s38vmm+csTNFOyz37KwMCPmJdPGlo0fuWvb24uO3LE4JWomDu/+TaPTccO/r62P6odvid2V0ZjdmLmg3qkKwJ9PQOxaFgeSglq157ibK4qvjylLgI3R7X2iKVroF0ATkx77+w3UQvrvVkZ1GfSa3267dviUgphdJPPgkO5K7JSLJmdS6IHPCGc8VyoUe+fu913YFPlYBUvwYLSXuynGxl5RKqNPfRPrv7Fjphn2bvlCIFie6SPyX05mfvLigKPYSzC1rNTirzuLkBOddYoMK/CjmRSfC3Af4ic6c01vDmdtyA4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(83380400001)(186003)(2616005)(38100700002)(38070700005)(122000001)(41300700001)(82960400001)(66446008)(66476007)(5660300002)(8936002)(4326008)(8676002)(66556008)(2906002)(6512007)(66946007)(6486002)(26005)(87266011)(478600001)(316002)(76116006)(6506007)(6916009)(91956017)(71200400001)(86362001)(33656002)(85182001)(36756003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aElPc2pWcW5vMXphWGwzM2NCNjh5dEpraCtzRUN0b3R5WmM2ZEVPS3pDYWZj?=
 =?gb2312?B?S1hYNGxLOWV3R2pNRXVNaEFnWDJzeW85bWdmdTBuNHRWMkd3dFVYZmMwd1Bs?=
 =?gb2312?B?dS8xbmlPOEZ6WFFEcU1EREp5b2Nqd1lTdzlMQW1aajBwVVVzNFljVitUMVVP?=
 =?gb2312?B?T0dqeEdZTmZNSmtFaG5xOGZtT1pGZVQ2Y25ITml1dCtoNjJhaHhmWmZoNVhF?=
 =?gb2312?B?ZXVxR3d3Nkw4OW52UVpIcDk3SVNUY0lJdlN2VVdkVGR4U0ZWV3A4NE9sUjFS?=
 =?gb2312?B?Vm1ra0xLQ1pNaEhOVVl5K0xpSlZsTVM0NVdSQWtXU0Nyc1NUaTBKeGZlYlJw?=
 =?gb2312?B?Zzl4aDB6THl0eWI0SDJ1aHFHaitIYUI0VWo0b2NpVXR4OFM0MTFBVGxCMlY2?=
 =?gb2312?B?WlhLNFZGd1VxTG5LbHFyZmtMY2dEN1FEUUVsRUIzVG9aSmd4MC94Y1JFckgx?=
 =?gb2312?B?T2wxbjMyUUZpeWtGZGdBR2FoZ2FHdEVRYzBuNGFKMXl1K2pOSDNGaFNCRTV2?=
 =?gb2312?B?VjNQNjdIRkwxRzUzbmw1L1grdm1hRGVYS3VzbkpqajcyNzkwNDFSZm4zZW9N?=
 =?gb2312?B?NWdlNUxTbkNVZFdhVTI2ZmRoaGtUSUhNRW42ZHNXdDNjRmR0QmZYb0tEbDg2?=
 =?gb2312?B?QURIdXlhRnhIaDdJZFdybi9sdmtJSUZiRTNuTGtXZ0lBK3dWK3JlWUNhUkpP?=
 =?gb2312?B?VVRMRUg3TkVjV0x2ZXkyVm5lYW9kODQ3ZHJhYUlkdGErR05SUlc3NnVUMkc4?=
 =?gb2312?B?aDQ0MnJCY053eXJXTjYyK1VTNXV4djlQZXZwVWhGY2YyTUFhd0dXSlBoTDlX?=
 =?gb2312?B?bWFLVDJtcHhXaS9lTUdjcVBDT0tOMStGdVpxcVYwenI4M2pvdHNMa1JtTTdI?=
 =?gb2312?B?a01jRUsvc3c3WjNtNHlKc2c0VktwdTZVZFFOWmxaSFZMLzcyMGtYNDBYSFZD?=
 =?gb2312?B?bDhCbkJtRUdMcUxCRGFiY1ZPVzdzd1l2bi81aDRydlNCT1NtcEtBL21LaG93?=
 =?gb2312?B?VjRmYThVVHVNdDNhVFZydXRYNE9vU2xsblVFQVEwRXNqRmVmR0RyL0lpVHNX?=
 =?gb2312?B?SkYxVFowalZkN1FaeERValBBVFhjQTZvQ0M2NjVQbVlUd1J0Q2YyTWxNemEz?=
 =?gb2312?B?MHc1WjhKRmsySkJ6aitzeEliRUU4KzR4bll6bk1ydHZuSzViVlF1OERQdG1E?=
 =?gb2312?B?M3I4NjlRaU1NVUtXUEV0OGZRUVlxU05xSlVBVForUGdBVmxSK1NaM0Y4MUpP?=
 =?gb2312?B?RjNmd1pWWlFCb2kzTWk2aWtxajZldmxQWWdUQlVMSTY2Z0RZNmlGNkJib3lT?=
 =?gb2312?B?T0tLaHpxSlR2NGlOS0ZzQW8yUGhoV0V2SHBoSVJGdm4wQ2IyVHdoL1ZpUTNP?=
 =?gb2312?B?Ylk4d0Z2WUJkQTlWaE5FaTJtbzI5RWZ0TVY2K2o0ZjJkVkZjMkN5L1lwUHFl?=
 =?gb2312?B?aXRKcm50N3lMRHlMTU1pY0hGajZDeHZkeGJ6U3FKR1IvcTJzeml2Q2l6L2Nx?=
 =?gb2312?B?Y2NHY0pOU3kvNGlaVEo1VWs4bW9lSERDcU5OT0Fhb0QyUjljMGhFaklzQnlO?=
 =?gb2312?B?UFNBbFpqMWtucTRwNldRbjQ5ZENXRE0zZ2xYS1FTT0FoUVJGYXpyemNlQlF3?=
 =?gb2312?B?NEZPcWdpTlo0cGloMWJlM2ludUZBdWZTVWlsOG01bUxkZDQrNmdGNENjdFpD?=
 =?gb2312?B?cG9HYklVSDdoc0M2UU5MQ0h5UEVzdDlKTEF0K2hxYUhXNWV3WmoybWoycWhi?=
 =?gb2312?B?Z2lrQy95UG5PNGNJWHNNeHJOcEVUcWpHVGZ0RStlNDk2TE9BVUlrQTN2NUdY?=
 =?gb2312?B?cnZWOGMrRDI0NE9Nd3BwMVY5M3lpb01ucXpjb2NiQTlqMSthWVRlRXYrUFcw?=
 =?gb2312?B?UklCZnJsWmR6SkU4M2ErWDlvNVJTUStNZW9McHAzdGxyT1ZvRG56QXVJc2dk?=
 =?gb2312?B?NHJLTXRHZUxIZkxOT2tQRnEzaTNGWVBIcUZCTXQvaVJ3MTl6UDRTVGxPSi8r?=
 =?gb2312?B?WjkrcUY2TVo5YVo5aTMrL0xEdnNCSWljakZJNEl5OHg4MU5WSUFYYWlPT3Nl?=
 =?gb2312?B?eElwYlcvQ1ZJY0V4UlY1MW5XdGxtMDYzR2JEN2pNdmhEYmtxRVdGYU9LSmNZ?=
 =?gb2312?B?MFBTRmtyNG5Rc0dSeXF0S0taYVhPVTJHR1NyTUwwdXQrWmUwM2F2SnN2L0t5?=
 =?gb2312?B?cUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <5DBB98DB12A7B840BE4183B69653F967@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf1ae2c-7b3d-43bd-2d6e-08da5e49c1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 05:46:50.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT3XtJ1YDXrGA73XE7b/3qvOTGDF64rgOdVSHSp1XSoNJ/Tadax86TVNUed4QGmfVgkk9BbE0KBI8tAdXvKTOvXyqEA1uIxnnijKxEoJ4iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3618
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8wNy8wNCAyMzo0MiwgWm9ycm8gTGFuZyB3cm90ZToNCj4gT24gTW9uLCBKdW4gMjcs
IDIwMjIgYXQgMTA6MzA6MDJQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IEN1cnJlbnRseSwg
dGhpcyBjYXNlIGZhaWxzIG9uIG9sZCB4ZnNwcm9ncyBhcyBiZWxvdzoNCj4+ICsvdmFyL2xpYi94
ZnN0ZXN0cy90ZXN0cy94ZnMvMjcwOiBsaW5lIDUxOiBbOiAhPTogdW5hcnkgb3BlcmF0b3IgZXhw
ZWN0ZWQNCj4+DQo+PiBHZXR0aW5nIHJvX2NvbXBhdCB2YWx1ZSB3aWxsIHJlcG9ydCB0aGUgZm9s
bG93aW5nIGVycm9yIGFmdGVyIHNldHRpbmcgbmV3IHJvX2NvbXBhdA0KPj4gdmFsdWU6DQo+PiAr
Y2FjaGVfcHVyZ2U6IHNoYWtlIG9uIGNhY2hlIDB4NTYwMzNmZGU0OTIwIGxlZnQgMSBub2RlcyE/
DQo+PiArY2FjaGVfcHVyZ2U6IHNoYWtlIG9uIGNhY2hlIDB4NTYwMzNmZGU0OTIwIGxlZnQgMSBu
b2RlcyE/DQo+PiArY2FjaGVfemVyb19jaGVjazogcmVmY291bnQgaXMgMSwgbm90IHplcm8gKG5v
ZGU9MHg1NjAzM2ZkZjkxMTANCj4+DQo+PiBPbGQgeGZzcHJvZ3MgbWlzcyBhIGJ1Z2ZpeA0KPj4g
ZjRhZmRjYjBhZCAoInhmc19kYjogY2xlYW4gdXAgdGhlIHNhbHZhZ2UgcmVhZCBjYWxsc2l0ZXMg
aW4gc2V0X2N1cigpIikuDQo+Pg0KPj4gSGVyZSB3ZSBza2lwIHRoZSBnZXQgc3RlcCBvZiBuZXcg
cm9fY29tYXAgdmFsdWUgd2hlbiBucmV4dDY0IGZlYXR1cmUgaXMgc3VwcG9ydGVkLg0KPj4gQWxz
byB3aWxsIGFkZCBhIG5ldyB0ZXN0IHRvIGNvdmVyIHRoaXMgeGZzcHJvZyBidWcuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0t
DQo+PiAgIHRlc3RzL3hmcy8yNzAgfCAyMyArKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvdGVzdHMveGZzLzI3MCBiL3Rlc3RzL3hmcy8yNzANCj4+IGluZGV4IGI3NDBj
Mzc5Li41ZmY4M2VhZCAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3hmcy8yNzANCj4+ICsrKyBiL3Rl
c3RzL3hmcy8yNzANCj4+IEBAIC0yMiw2ICsyMiwxMCBAQCBfcmVxdWlyZV9zY3JhdGNoX25vY2hl
Y2sNCj4+ICAgIyBPbmx5IFY1IFhGUyBkaXNhbGxvdyBydyBtb3VudC9yZW1vdW50IHdpdGggdW5r
bm93biByby1jb21wYXQgZmVhdHVyZXMNCj4+ICAgX3JlcXVpcmVfc2NyYXRjaF94ZnNfY3JjDQo+
Pg0KPj4gK25yZXh0NjRfc3VwcG9ydGVkPTANCj4+ICtfc2NyYXRjaF9ta2ZzX3hmc19zdXBwb3J0
ZWQgLW0gY3JjPTEgLWkgbnJleHQ2ND4gIC9kZXYvbnVsbCAyPiYxJiYgIFwNCj4+ICsJbnJleHQ2
NF9zdXBwb3J0ZWQ9MQ0KPj4gKw0KPj4gICBfc2NyYXRjaF9ta2ZzX3hmcz4+JHNlcXJlcy5mdWxs
IDI+JjENCj4+DQo+PiAgICMgc2V0IHRoZSBoaWdoZXN0IGJpdCBvZiBmZWF0dXJlc19yb19jb21w
YXQsIHVzZSBpdCBhcyBhbiB1bmtub3duDQo+PiBAQCAtNDMsMTMgKzQ3LDE4IEBAIHJvX2NvbXBh
dD0kKGVjaG8gJHJvX2NvbXBhdCB8IFwNCj4+ICAgX3NjcmF0Y2hfeGZzX3NldF9tZXRhZGF0YV9m
aWVsZCAiZmVhdHVyZXNfcm9fY29tcGF0IiAiJHJvX2NvbXBhdCIgInNiIDAiIFwNCj4+ICAgCQkJ
CT4gICRzZXFyZXMuZnVsbCAyPiYxDQo+Pg0KPj4gLSMgcmVhZCB0aGUgbmV3bHkgc2V0IHJvIGNv
bXBhdCBmaWxlZCBmb3IgdmVyaWZpY2F0aW9uDQo+PiAtbmV3X3JvX2NvbXBhdD0kKF9zY3JhdGNo
X3hmc19nZXRfbWV0YWRhdGFfZmllbGQgImZlYXR1cmVzX3JvX2NvbXBhdCIgInNiIDAiIFwNCj4+
IC0JCQkJCQkyPi9kZXYvbnVsbCkNCj4+IC0NCj4+IC0jIHZlcmlmeSB0aGUgbmV3IHJvX2NvbXBh
dCBmaWVsZCBpcyBjb3JyZWN0Lg0KPj4gLWlmIFsgJG5ld19yb19jb21wYXQgIT0gJHJvX2NvbXBh
dCBdOyB0aGVuDQo+DQo+IE15IHBlcnNvbmFsIG9waW5pb24gaXMgLS0gY2hhbmdlIGFib3ZlIGxp
bmUgYXM6DQo+ICAgICBpZiBbICIkbmV3X3JvX2NvbXBhdCIgIT0gIiRyb19jb21wYXQiIF0NCj4g
dG8gYXZvaWQgdGhlIGJhc2ggc3ludGF4IGVycm9yLiBUaGVuIHRoZSBmYWlsdXJlIChvbiBvbGQg
eGZzcHJvZ3MpIGNvcnJlc3BvbmQNCj4gdG8gYSBrbm93biB4ZnNwcm9ncyBidWcuIFRoYXQncyBn
b29kIGVub3VnaC4NCg0KT2ssIHdpbGwgZG8gaXQgb24gdjIuIFRoYW5rcy4NCg0KQmVzdCBSZWdh
cmRzDQpZYW5nIFh1DQo+DQo+IFRoYW5rcywNCj4gWm9ycm8NCj4NCj4+IC0JZWNobyAiVW5hYmxl
IHRvIHNldCBuZXcgZmVhdHVyZXNfcm9fY29tcGF0LiBXYW50ZWQgJHJvX2NvbXBhdCwgZ290ICRu
ZXdfcm9fY29tcGF0Ig0KPj4gKyMgSW5kZWVkLCB4ZnNwcm9ncyBoYXMgYSBidWcgaGVyZSBhbmQg
Zml4ZWQgYnkgY29tbWl0IGY0YWZkY2INCj4+ICsjICgieGZzX2RiOiBjbGVhbiB1cCB0aGUgc2Fs
dmFnZSByZWFkIGNhbGxzaXRlcyBpbiBzZXRfY3VyKCkiKQ0KPj4gKyMgSGVyZSwgd2UgdXNlIG5y
ZXh0NjQgZmVhdHVyZSBhcyBhIHByb3h5Lg0KPj4gK2lmIFsgJG5yZXh0NjRfc3VwcG9ydGVkIC1l
cSAxIF07IHRoZW4NCj4+ICsJIyByZWFkIHRoZSBuZXdseSBzZXQgcm8gY29tcGF0IGZpbGVkIGZv
ciB2ZXJpZmljYXRpb24NCj4+ICsJbmV3X3JvX2NvbXBhdD0kKF9zY3JhdGNoX3hmc19nZXRfbWV0
YWRhdGFfZmllbGQgImZlYXR1cmVzX3JvX2NvbXBhdCIgXA0KPj4gKwkJCQkJInNiIDAiIDI+L2Rl
di9udWxsKQ0KPj4gKwkjIHZlcmlmeSB0aGUgbmV3IHJvX2NvbXBhdCBmaWVsZCBpcyBjb3JyZWN0
Lg0KPj4gKwlpZiBbICRuZXdfcm9fY29tcGF0ICE9ICRyb19jb21wYXQgXTsgdGhlbg0KPj4gKwkJ
ZWNobyAiVW5hYmxlIHRvIHNldCBuZXcgZmVhdHVyZXNfcm9fY29tcGF0LiBXYW50ZWQgJHJvX2Nv
bXBhdCwgXA0KPj4gKwkJCWdvdCAkbmV3X3JvX2NvbXBhdCINCj4+ICsJZmkNCj4+ICAgZmkNCj4+
DQo+PiAgICMgcncgbW91bnQgd2l0aCB1bmtub3duIHJvLWNvbXBhdCBmZWF0dXJlIHNob3VsZCBm
YWlsDQo+PiAtLQ0KPj4gMi4yNy4wDQo+Pg0KPg0K
