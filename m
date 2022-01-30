Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F8C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Jan 2022 02:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiA3Cvp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 29 Jan 2022 21:51:45 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:20820 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353586AbiA3Cvk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Jan 2022 21:51:40 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jan 2022 21:51:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643511100; x=1675047100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GzzeMOwpzbi2uCLQ5c4A4VLuWG9lldF7s33I8lF51ao=;
  b=j8rax/DRBZd5zQqF37jQq9vWJWpAC297a1FlXXy3rFSQehvb3jGU9sDN
   NBXGbUpnTaY81sK5osJC9f/v2w7oaChv2o6z0ohz69KZW+oFo2+3+2ppm
   Cvl3X2bgOFyZJH8VVlLMigjvBrA4GJGZ/vPZsUnfWohm2sv3Tm4u1p0VH
   cHrLdgDwLlfm4KgUz9SpgDJvpwU6Q4Ra8T/Shj+DhZSZqkU8f1gAGYoTi
   cJpynkVGRpacJxryipwaLzLxW0sRZQ2anp6XB6l4LjZBnxU1xQ3vBYfbo
   0bCANjUocYK0SzjhZTOJhc9O/2t7x/eyox4gmy25SNQ4mcSnFLYSit6ac
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="48818408"
X-IronPort-AV: E=Sophos;i="5.88,327,1635174000"; 
   d="scan'208";a="48818408"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 11:44:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPp0FvabRS3T5Y0h25Jox2zwRe9/CA3sbv4FFQkVaYYXoNBpPnv5glG0blXeqSTe4Gh9Zb0KwjRG9HKIbTKpJfwghPjLfKkAFIelUEahM+1Rgm/Jx6dmS5adpkBQFQzVHppmqb1LWl/s53CeYXPJ2Cwb9pV+BbXmQ3lwD/SSuLD6B18H46LhMjBxKp4hhfjkPIAx4tB3O5eY+kwMiQ2uN+H8/+u6GXfrvUGc5GerI/kn8w6XHw6SBl4T0wHyW6KkzaYU+Y4SYMw9LPvPVw7q2P6GxQ6JPjKR3vR3YS/DH5R1e8Sc/Uym7NccS4paABM94uw4dmGI9mrL8gPTGvnOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzzeMOwpzbi2uCLQ5c4A4VLuWG9lldF7s33I8lF51ao=;
 b=bDE/xyGxdnRpT4jXeEbUu0+ymaoCFYMYzCW/Y640N4H/Y+N/BL+Rp+Lxj4N0Bmlvqh5MWeHPE0WoNBXBIsJr663IfoxPZFUcmOggXZS5qO05b/SMMxGmSXqQXqcfMo7yQZ5ruwRVMllVYzyu9X9+ml8rXoZpSsSvaHtxj+ahVqIcIVIRs7s15pIuOJYozYpfilmdbNKQZOE+QxmnNzWaH6f/nByiFHZg5MiEgFitCGHh4JgkBcooGGi1G17hHqIN940eaBzUeFPMeF4MdilRzTWB22OD64iMMqB8V0aOBPyjVP81t7sSyY82E3iUQP7dnQbdXJE3ndMsFCG1OksIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzzeMOwpzbi2uCLQ5c4A4VLuWG9lldF7s33I8lF51ao=;
 b=pdzD8pHDzQRuHPJ356AVS9JM2L5t4HYbE6UmjCHK93GLkqs1N2prIdbkqvjRLBw2wAyBuxpbEHHfx1SgADAkfFQJYZfhhZuxcR2IBnJ+ljLvgssyC6HJ+M5P8iKOqutsRhkwKhCxmmf2LED9DSHyizOzKaOG/NS02tzp+ViwqyQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2588.jpnprd01.prod.outlook.com (2603:1096:404:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Sun, 30 Jan
 2022 02:44:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 02:44:21 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     Eryu Guan <guan@eryu.me>, "djwong@kernel.org" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr
 corrupted
Thread-Topic: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr
 corrupted
Thread-Index: AQHYC3tRbuMdH0UVeE6ebS0mJCLmL6xwnfGAgAWf9ACAACB3AIAEkXWA
Date:   Sun, 30 Jan 2022 02:44:21 +0000
Message-ID: <61F5FBB3.6000702@fujitsu.com>
References: <20211126232817.GA266000@magnolia>
 <1642407736-3898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ye1TiTOUdGoemiV9@desktop> <61F20B74.1090008@fujitsu.com>
 <20220127045928.ad2d7bqdatiymq7a@zlang-mailbox>
In-Reply-To: <20220127045928.ad2d7bqdatiymq7a@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 436a17a5-596f-4279-8cb0-08d9e39a6b61
x-ms-traffictypediagnostic: TY2PR01MB2588:EE_
x-microsoft-antispam-prvs: <TY2PR01MB25884F3E53E61A2BE0C36970FD249@TY2PR01MB2588.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ousEOCMI/6eiJMYHpgnt+Fb+uzKbRE82xzthfEZDPgiYu69CmeWDG9fTiZPOMkBitHn3aZBqp8ltYCOUZb/abxvn+02aHY8psdXMpRBvos8qc1G283J7hXYd7UvKgkR8RXW6AT2baYioNtUYnmhJkhWmiRSBDVmEwfab4JODzVajwz9GAyIuKfae41tQw9uqhoVcn9cFVpN6qC8z5E8ByNzFgTniJNKzE1oUGQMIk0psGOHHEWw2JFA8zOy3CcxTql7qmEwBZY4Ii5zRJTUBj18ZcPDpO3CBmaVTYa4FmqRpfF3DT/mnUcJLQP1YFhY3p6Ztw/2NMHuENHL5v2m2zwNy29FTsXPWu2vy3IqJIM5BcKqHZ9R6/JsgZrmpXmRZzPeNGiIo7IOV1pVZY/dLcQgvgEapgXHCc6U9rbY23qjxTVo4aJkhiVOQPxAvpX418vcjkSzWWtqL9npYD0x1rqME/cCIZNCEW1Fq6aegqeCZEfF9PRX7uXYz8fk4qGtiZ/EytwBVrJRu1Ceetq//tUCMWEBcYk/z8rIVdhU1rnvlh0Xzb5qVQev8hxuVUJvRJCa2/IS2HSmt68Vpa2GMylF7D4CNXR2UD12dfT81F03ht/n7FRjAfznJm/QPv00Y3rae2pYhLE03lQjbciAaMgcDeRchcalD94peCTIiey2NuGovndjitahiVTWuE4XYl9RhH1dKQXYJN3ktMbbfAedio+ZyT9gzwEVMXzYzH+APv+aovNCo7WLHhOnzILdBbtKmT139kRDbfrSH/M66+SS+KfVzD360oLpapsZ0mQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(36756003)(6916009)(54906003)(316002)(76116006)(66446008)(91956017)(64756008)(66556008)(66476007)(8676002)(8936002)(5660300002)(6506007)(87266011)(6512007)(71200400001)(38100700002)(4326008)(66946007)(86362001)(33656002)(26005)(186003)(83380400001)(2616005)(508600001)(38070700005)(85182001)(122000001)(6486002)(2906002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bVlsU2VycUdXT0h4Ukw5QmN0RUk4aTBUSEZCcDZJRE1HMWtDNWptOHQ4aVdj?=
 =?gb2312?B?d0RRcm8ya3Ezb0gxZm85QzI3WFBrTHFaTTI3dm9McjZWTlh3N3BLVExURnBI?=
 =?gb2312?B?cHdsNGlaQU8wSHNDcWV1NWtsQXBmRXFyWDEzMWswTVBDaWhjQlZvZ0xGY0Uy?=
 =?gb2312?B?V0VQaDZwRFZqV2tNWVE1bjhHUUF5RTBDNy9JbU1lK0pBalp0K2tDVGk2Tkpi?=
 =?gb2312?B?d1R3YVc1d3J0ZGQxV0lIRGlKWWt2WUlmaWJFVTBleVZnOVVJa2RJbTl6NGEx?=
 =?gb2312?B?MFNxRmE0SVBHQUF0L1JaUmRvclMvWWhCQ2JvL2toclB4ZkZ1Qm44ZUV6Qi9t?=
 =?gb2312?B?SHFUb0laR1A0YWlRZXZrR04xZVFMUFVCZWZ6TVdWcS9reWVVcmx4MzhKTFBJ?=
 =?gb2312?B?K2lhanFOOUdScVVOVWxISE5tQXFXNlRmOXBER3haV3NqRFpJcWxiSW0vWFgv?=
 =?gb2312?B?bkppc0pjaWh2S1J1WklENFdDalJwNEhibEh5Vm5YZjRXNW1SSDZPdFJWQktn?=
 =?gb2312?B?emZCSXBQeDZ4SnZaS004U1BDbFJqNEF4T1YvQ2JPVzBQNzk2cDVDaGUrcFFU?=
 =?gb2312?B?UjJqbm9lem52SmdybFlPRDdEeFZuNGRjV2Z3T29qMjUyOWtEL1RmK1pwd1BU?=
 =?gb2312?B?YVZpamlEeW0wODM0QjFjV1JGelNQZitTMlk2R1pOdGptQWFSdWZ3ak9jZG5Y?=
 =?gb2312?B?Y0FkVUo4Zk1jd3JrUW9DNjg0ZkRYRDhldXIrdWhnWkxCVUs4WDAwN2xzYnV1?=
 =?gb2312?B?SjBXZDcxY2pjSUFQaXQ3SmRFcDdjU014b09MNStReTQ3dzVUaFpyY2NhOHFS?=
 =?gb2312?B?b1l6VG9GTllNckt5QWs3Y1RJYkxVelVGa29RMU9IS2p5U3o4ZUgyamVTbXFp?=
 =?gb2312?B?REpqZTRoQitNUm1yYVlHNUtnZ3RvYys2OUt2cklUMmFWTFZ0Zm5yUS9uV1lS?=
 =?gb2312?B?TXFBL05yUTFGNkgvbFhRYzRKc09rVkdRYmZIcXBhb1lOYXVpT3Q4T1BmUkxK?=
 =?gb2312?B?SVlJNjRsdGlGOXA0RVYyb0NsZFoxYUpkeHVLL0pZa0Z4MUR2WEpmUUFWTjRp?=
 =?gb2312?B?aEJjRFh1eTNSS2Mwd1krNnNXblhOM2Rxek90dm40dlF6eThKdW9XZHBJKzJm?=
 =?gb2312?B?YzRyZXhjNmdnSFAwbkg5RHJHeTI0bUJzaTNkVTFZU2xMb0U2azdUSnp0U0Ey?=
 =?gb2312?B?MGVvejh2Q0JrNEJyanZReGdTNUZ4VVlKSUV6ZkhSbGtGbHVHRU5SbG05QU9U?=
 =?gb2312?B?bmpwZnpqSGhyMnFsbmNLaVhtVmdBQ1NCRkxIY0dVU2t5WmFQQnc0WkJmeUJ0?=
 =?gb2312?B?VVNaaXRJQURrSk5XRmxvMXVLQUcyeGpzSXRuWjdTM0c0aHlYNzZtM3E1aHY1?=
 =?gb2312?B?elc0OFBTbitCYW5pZlZTRU85TTZuNTNJeGFDNzlzanJqNDRkT0F3aG1MR3Vp?=
 =?gb2312?B?VkkvRnVuSHQvRnpVaWVMREwvek5NSHVRdVA3RCtUbmlrd3J2TkNLR1dCVmJY?=
 =?gb2312?B?VURjRkt2V1Q0b0tqbmRrSHFtOW9yUTYvdnJoTDhyaUFvV3Zpd3hNeHNvcmRY?=
 =?gb2312?B?MWd2bUhQdFVkYzFmN01hbUVyZWtYZ0crMWhaemh2YVdyN2NWUXAwdnNEOCt0?=
 =?gb2312?B?QldnS1c2VFJQTGlIdEwxZUVMQnR0NXA4cVJYcTM2Z1Rqdm5jRDRQdU5JUzBi?=
 =?gb2312?B?bFU2OG8vRWZ6TUo0SmFsMFR6UzlGTitKdk14c2RoNWJVK3d5NXBXbnpRRTlB?=
 =?gb2312?B?Y0NMK29yUHhHdy9MWXJQZCt3Qm5ibDQ0cWd4S3RxRnFBdUpzVkdKYStUaWNE?=
 =?gb2312?B?VVMvOURnUnNKSUhJWEprOE00OWhQYitnVTFwOFYvUUVmSzVFNXQvWlpua1dU?=
 =?gb2312?B?TGllZDU0cHVDNDB3M1Z0OEtpOVAvQ0pzZmV2eStKYVZSWU81SGNLZkwyY01w?=
 =?gb2312?B?L0ViSHJvVFRicHlJRVFFREVHL0YxN3g0SXMzTUhIZGM1T3JockNqQkhjUFEz?=
 =?gb2312?B?cXVyM00vQTR3Vk1Ga2tINk9IRVRHdmZ0dFFweFhtZVU1ZHRFYUNsYlNxZStk?=
 =?gb2312?B?US9oZU4yb05SUWNZUnplamQ4OFdpZWhERitIdHZNRVYrWUV5dkFMdjJGc003?=
 =?gb2312?B?dkVUVzNhMlVTSGZqWDhGVnBiS3cwY0xkNkozYXZXcG1uZEhWRjdvQ0lEZDZo?=
 =?gb2312?B?Z1ZjTXN0bi9BaEN4RCtYc0FORXZjRDVDbWVzbkpPWEVhcFNneXdFVDJReE5k?=
 =?gb2312?Q?WhjFPoAZxqZvd4zKIFQuQfusc16TnicAoZh0QLqYHg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <214150B5CD78194F8EC5D298AF265C14@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436a17a5-596f-4279-8cb0-08d9e39a6b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 02:44:21.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93fi0DZRsaVYYUNM7cMIW++RLfGzv9yVWTwHIzVswXEZjvsKIcZXDTb89S/W0LLMhaWhlUEF0gzIuLvyiUpwT1x7zlghe8fwfsWc4f0rhgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2588
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi8xLzI3IDEyOjU5LCBab3JybyBMYW5nIHdyb3RlOg0KPiBPbiBUaHUsIEphbiAyNywg
MjAyMiBhdCAwMzowMjozNkFNICswMDAwLCB4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gb24gMjAyMi8xLzIzIDIxOjA5LCBFcnl1IEd1YW4gd3JvdGU6DQo+Pj4gT24gTW9uLCBK
YW4gMTcsIDIwMjIgYXQgMDQ6MjI6MTZQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+Pj4gQWRk
IGdldGZhdHRyIG9wZXJhdGlvbiBpbiB0aGVzZSB0aHJlZSBjYXNlcywgd2UgY2FuIGFsc28gdXNl
IHhmcy8xMjYoY29ycnVwdCBhIGxlYWYNCj4+Pj4geGF0dHIncyBkYXRhIGV4dGVudCkgdG8gcmVw
cm9kdWNlIGEgZGVhZGxvY2suIFRoaXMgZGVhZGxvY2sgaXMgaW50cm9kdWNlZCBieSBrZXJuZWwN
Cj4+Pj4gY29tbWl0IDA3MTIwZjFhYmRmZiAoInhmczogQWRkIHhmc19oYXNfYXR0ciBhbmQgc3Vi
cm91dGluZXMiKSBhbmQgZml4ZWQgYnkga2VybmVsDQo+Pj4NCj4+PiBTbyB0aGlzIHdhcyBpbnRy
b2R1Y2VkIHNpbmNlIDUuOSBrZXJuZWwsIGFuZA0KPj4+DQo+Pj4+IGNvbW1pdCBhMWRlOTdmZTI5
NmMgKCJ4ZnM6IEZpeCB0aGUgZnJlZSBsb2dpYyBvZiBzdGF0ZSBpbiB4ZnNfYXR0cl9ub2RlX2hh
c25hbWUiKS4NCj4+Pg0KPj4+IGZpeGVkIGluIDUuMTYga2VybmVsLg0KPj4+DQo+Pj4gQW5kIGFk
ZGluZyB0aGlzIHJlZ3Jlc3Npb24gdGVzdCBpbiB4ZnMvMTI2LCB3aGljaCBwYXNzZWQgaW4gdGhl
IHBhc3QuDQo+Pj4gcHJvYmFibHkgd291bGQgY2F1c2UgYWxsIHRoZSBhZmZlY3RlZCBrZXJuZWxz
IGluIGJldHdlZW4gc3RhcnQgdG8gaGFuZywNCj4+PiBhbmQgdHJpZ2dlciBhIGZhbHNlIHBvc2l0
aXZlIHJlZ3Jlc3Npb24gYWxlcnQuDQo+Pj4NCj4+PiBTbyBJTU8gaXQnZCBiZSBiZXR0ZXIgdG8g
bWFrZSBhIHNlcGFyYXRlZCYgICB0YXJnZXRlZCByZWdyZXNzaW9uIHRlc3QgZm9yDQo+Pj4gdGhp
cyBjYXNlLCBhcyBEYXJyaWNrIHN1Z2dlc3RlZC4NCj4+IE9rLCBOb3csIEkgdW5kZXJzdGFuZCBi
dXQgZG9uJ3QgZmlndXJlIG91dCBob3cgdG8gc2V0YXR0ciAgdG8gdXNlIGxlYWYNCj4+IGF0dHIg
YmxvY2sgYWNjdXJhdGx5IGFuZCBjb3JydXB0IGxlYWYgYXR0ciBhY2N1cmF0bHkgZXZlbiBJIGhh
dmUgcmVhZA0KPj4gdGhlIGRvY3VtZW50YXRpb25bMV0gaW5zdGVhZCBvZiB4ZnMvMTI2IHVzaW5n
IGdlbmVyaWMgZnV6eiB3YXkuDQo+DQo+IEdlbmVyYWxseSwgaWYgeW91IGtlZXAgY3JlYXRpbmcg
YXR0ciBlbnRyaWVzLCB1bnRpbCB0aGUgYXR0ciBvdXQgb2YgYW4gaW5vZGUNCj4gaW50ZXJuYWwg
YXR0cmZvcmsgc3BhY2UsIHlvdSdsbCBnZXQgbGVhZiBibG9jayBhbmQgc2VwYXJhdGVkIGF0dHIg
dmFsdWUgYmxvY2tzLg0KPiBJZiB5b3Uga2VlcCBjcmVhdGluZyBtb3JlIGF0dHIgZW50cmllcywg
dW50aWwgdGhlIGF0dHIgZW50cmllcyBvdXQgb2YgYSBibG9jaw0KPiBzaXplLCB5b3UnbGwgZ2V0
IG5vZGUgYW5kIGxlYWYgYmxvY2tzLg0KPg0KPiAgRnJvbSB4ZnMvMTI2LCBEYXJyaWNrIHVzZSBh
IHdoaWxlIGxvb3AgdG8gY3JlYXRlIGF0dHJzIGluIGFib3V0IDggYmxvY2tzLg0KPg0KPiBucj0i
JCgoOCAqIGJsa3N6IC8gNDApKSINCj4gc2VxIDAgIiR7bnJ9IiB8IHdoaWxlIHJlYWQgZDsgZG8N
Cj4gICAgICAgICAgc2V0ZmF0dHIgLW4gInVzZXIueCQocHJpbnRmICIlLjA4ZCIgIiRkIikiIC12
ICIwMDAwMDAwMDAwMDAwMDAwIiAiJHtTQ1JBVENIX01OVH0vYXR0cmZpbGUiDQo+IGRvbmUNCj4N
Cj4gKEFsdGhvdWdoIEkgZG9uJ3Qga25vdyB3aHkgaXQncyA0MC4gRnJvbSBhYm92ZSBzZXRmYXR0
ciBjb21tYW5kLCBJIHRoaW5rIGVhY2ggeGZzX2F0dHJfbGVhZl9uYW1lX2xvY2FsDQo+IHRha2Vz
IDI4IGJ5dGVzLCBlYWNoIHhmc19hdHRyX2xlYWZfZW50cnkgdGFrZXMgOCBieXRlcy4gQW5kIHRo
ZXJlJ3JlIG5vZGUgYW5kIGxlYWYgYmxvY2tzLCBub3Qgc3VyZQ0KPiBob3cgRGFycmljayBrbm93
cyBpdCdsbCB0YWtlIDggYmxvY2tzIDopLg0KPg0KPiBJIGRpZG4ndCBnaXZlIGl0IGEgdGVzdCwg
bm90IHN1cmUgaWYgRGFycmljayB3b3VsZCBsaWtlIHRvIGdldCAxIG5vZGUgYmxvY2sgYW5kIDcg
bGVhZiBibG9ja3MgYXQgaGVyZS4NCj4gVGhlbiBoZSBsb29wIHRyYXNoIGVhY2ggYWJsb2NrcyAo
ZnJvbSAxIHRvIGVuZCksIGV4Y2VwdCB0aGUgcm9vdCBub2RlIGJsb2NrLg0KPg0KPiBsb2ZmPTEN
Cj4gd2hpbGUgdHJ1ZTsgZG8NCj4gICAgICAgICAgX3NjcmF0Y2hfeGZzX2RiIC14IC1jICJpbm9k
ZSAke2lub2RlfSIgLWMgImFibG9jayAke2xvZmZ9IiAtYyAic3RhY2siIHwgZ3JlcCAtcSAnZmls
ZSBhdHRyIGJsb2NrIGlzIHVubWFwcGVkJyYmICBicmVhaw0KPiAgICAgICAgICBfc2NyYXRjaF94
ZnNfZGIgLXggLWMgImlub2RlICR7aW5vZGV9IiAtYyAiYWJsb2NrICR7bG9mZn0iIC1jICJzdGFj
ayIgLWMgImJsb2NrdHJhc2ggLW8gNCAteCAzMiAteSAkKChibGtzeiAqIDgpKSAteiAke0ZVWlpf
QVJHU30iPj4gICRzZXFyZXMuZnVsbA0KPiAgICAgICAgICBsb2ZmPSIkKChsb2ZmICsgMSkpIg0K
PiBkb25lDQo+DQo+IFRoYW5rcywNCj4gWm9ycm8NCg0KVGhhbmtzIGZvciB5b3VyIGV4cGxhaW5h
dGlvbiwgSSB3aWxsIGZpZ3VyZSBvdXQgZWFjaCBkZXRhaWwgYWZ0ZXIgDQpDaGluZXNlIEx1bmFy
IE5ldyBZZWFyLg0KDQpIYXBweSBDaGluZXNlIEx1bmFyIE5ldyBZZWFyIGluIGFkdmFuY2UuDQoN
CkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPg0KPg0KPg0KPj4NCj4+IFNvIGlmIHNvbWVib2R5IGNh
biBkbyB0aGlzIG9yIHRlYWNoIG1lLCBJIHdpbGwgYmUgcGxlYXN1cmUuDQo+Pg0KPj4gWzFdaHR0
cHM6Ly9naXRodWIuY29tL2Rqd29uZy94ZnMtZG9jdW1lbnRhdGlvbi9ibG9iL21hc3Rlci9kZXNp
Z24vWEZTX0ZpbGVzeXN0ZW1fU3RydWN0dXJlL2V4dGVuZGVkX2F0dHJpYnV0ZXMuYXNjaWlkb2MN
Cj4+DQo+Pg0KPj4gQmVzdCBSZWdhcmRzDQo+PiBZYW5nIFh1DQo+Pj4NCj4+PiBUaGFua3MsDQo+
Pj4gRXJ5dQ0KPj4+DQo+Pj4+DQo+Pj4+IEFsc28gbWFraW5nIGdldGZhdHRyIG9wZXJhdGlvbiBh
ZnRlciB4YXR0ciBjb3JydXB0ZWQgaXMgYSBjb21tb24gcGFydCwgc28gd2UgY2FuDQo+Pj4+IHRl
c3Qgd2hldGhlciB0aGUgc2ltaWxhciBkZWFkbG9jayBvY2N1cnMgaW4gdGhlIGZ1dHVyZSBpbiB4
ZnMvMTI0KGNvcnJ1cHQgYSBibG9jayB4YXR0cikNCj4+Pj4gYW5kIHhmcy8xMjUoY29ycnVwdCBh
IGxlYWYgeGF0dHIncyBpbmRleCBleHRlbnQpLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZ
YW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICB0ZXN0
cy94ZnMvMTI0IHwgMiArLQ0KPj4+PiAgICB0ZXN0cy94ZnMvMTI1IHwgMiArLQ0KPj4+PiAgICB0
ZXN0cy94ZnMvMTI2IHwgMiArLQ0KPj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3hmcy8x
MjQgYi90ZXN0cy94ZnMvMTI0DQo+Pj4+IGluZGV4IDM5MzA3MjE4Li5jM2NjY2ZkNSAxMDA3NTUN
Cj4+Pj4gLS0tIGEvdGVzdHMveGZzLzEyNA0KPj4+PiArKysgYi90ZXN0cy94ZnMvMTI0DQo+Pj4+
IEBAIC02NCw3ICs2NCw3IEBAIF9zY3JhdGNoX3hmc19kYiAteCAtYyAiaW5vZGUgJHtpbm9kZX0i
IC1jICdhYmxvY2sgMCcgLWMgInN0YWNrIiAtYyAiYmxvY2t0cmFzaCAtDQo+Pj4+DQo+Pj4+ICAg
IGVjaG8gIisgbW91bnQgaW1hZ2UmJiAgIG1vZGlmeSB4YXR0ciINCj4+Pj4gICAgaWYgX3RyeV9z
Y3JhdGNoX21vdW50Pj4gICAkc2VxcmVzLmZ1bGwgMj4mMTsgdGhlbg0KPj4+PiAtDQo+Pj4+ICsJ
Z2V0ZmF0dHIgIiR7U0NSQVRDSF9NTlR9L2F0dHJmaWxlIiAtbiAidXNlci54MDAwMDAwMDAiIDI+
ICAgL2Rldi9udWxsJiYgICBfZmFpbCAiZ290IGNvcnJ1cHQgeGF0dHIiDQo+Pj4+ICAgIAlzZXRm
YXR0ciAteCAidXNlci54MDAwMDAwMDAiICIke1NDUkFUQ0hfTU5UfS9hdHRyZmlsZSIgMj4gICAv
ZGV2L251bGwmJiAgIF9mYWlsICJtb2RpZmllZCBjb3JydXB0IHhhdHRyIg0KPj4+PiAgICAJdW1v
dW50ICIke1NDUkFUQ0hfTU5UfSINCj4+Pj4gICAgZmkNCj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3hmcy8xMjUgYi90ZXN0cy94ZnMvMTI1DQo+Pj4+IGluZGV4IGZiNWY1Njk1Li5hN2ViNTFmYiAx
MDA3NTUNCj4+Pj4gLS0tIGEvdGVzdHMveGZzLzEyNQ0KPj4+PiArKysgYi90ZXN0cy94ZnMvMTI1
DQo+Pj4+IEBAIC02NCw3ICs2NCw3IEBAIF9zY3JhdGNoX3hmc19kYiAteCAtYyAiaW5vZGUgJHtp
bm9kZX0iIC1jICdhYmxvY2sgMCcgLWMgInN0YWNrIiAtYyAiYmxvY2t0cmFzaCAtDQo+Pj4+DQo+
Pj4+ICAgIGVjaG8gIisgbW91bnQgaW1hZ2UmJiAgIG1vZGlmeSB4YXR0ciINCj4+Pj4gICAgaWYg
X3RyeV9zY3JhdGNoX21vdW50Pj4gICAkc2VxcmVzLmZ1bGwgMj4mMTsgdGhlbg0KPj4+PiAtDQo+
Pj4+ICsJZ2V0ZmF0dHIgIiR7U0NSQVRDSF9NTlR9L2F0dHJmaWxlIiAtbiAidXNlci54MDAwMDAw
MDAiIDI+ICAgL2Rldi9udWxsJiYgICBfZmFpbCAiZ290IGNvcnJ1cHQgeGF0dHIiDQo+Pj4+ICAg
IAlzZXRmYXR0ciAteCAidXNlci54MDAwMDAwMDAiICIke1NDUkFUQ0hfTU5UfS9hdHRyZmlsZSIg
Mj4gICAvZGV2L251bGwmJiAgIF9mYWlsICJtb2RpZmllZCBjb3JydXB0IHhhdHRyIg0KPj4+PiAg
ICAJdW1vdW50ICIke1NDUkFUQ0hfTU5UfSINCj4+Pj4gICAgZmkNCj4+Pj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL3hmcy8xMjYgYi90ZXN0cy94ZnMvMTI2DQo+Pj4+IGluZGV4IGMzYTc0YjFjLi41MTlk
Mzc3ZSAxMDA3NTUNCj4+Pj4gLS0tIGEvdGVzdHMveGZzLzEyNg0KPj4+PiArKysgYi90ZXN0cy94
ZnMvMTI2DQo+Pj4+IEBAIC02OSw3ICs2OSw3IEBAIGRvbmUNCj4+Pj4NCj4+Pj4gICAgZWNobyAi
KyBtb3VudCBpbWFnZSYmICAgbW9kaWZ5IHhhdHRyIg0KPj4+PiAgICBpZiBfdHJ5X3NjcmF0Y2hf
bW91bnQ+PiAgICRzZXFyZXMuZnVsbCAyPiYxOyB0aGVuDQo+Pj4+IC0NCj4+Pj4gKwlnZXRmYXR0
ciAiJHtTQ1JBVENIX01OVH0vYXR0cmZpbGUiIC1uICJ1c2VyLngwMDAwMDAwMCIgMj4gICAvZGV2
L251bGwmJiAgIF9mYWlsICJnb3QgY29ycnVwdCB4YXR0ciINCj4+Pj4gICAgCXNldGZhdHRyIC14
ICJ1c2VyLngwMDAwMDAwMCIgIiR7U0NSQVRDSF9NTlR9L2F0dHJmaWxlIiAyPiAgIC9kZXYvbnVs
bCYmICAgX2ZhaWwgIm1vZGlmaWVkIGNvcnJ1cHQgeGF0dHIiDQo+Pj4+ICAgIAl1bW91bnQgIiR7
U0NSQVRDSF9NTlR9Ig0KPj4+PiAgICBmaQ0KPj4+PiAtLQ0KPj4+PiAyLjIzLjANCj4NCg==
