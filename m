Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95655C43217
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Apr 2022 07:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiDZHzx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Apr 2022 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344550AbiDZHyR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Apr 2022 03:54:17 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0B640E
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650959469; x=1682495469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RKx7rd8ZYfPOOiLBb5ljeWqTHuPi4e8khYux+UcN9+U=;
  b=x/NAqhQcOIdgY/M7+FmrJR5+6J1k/cP0Ksp2pdAbG5IuAJKb3G50mCm6
   j+ruzc9o5nHntv2ViV1SKcbn5lK77qYJXo2dYrsTrKxNENx/0tEZ9x1qx
   X1aIk8CJoEYyIFv3b/C/AaHCG2m57mp/ihbDX9Fgbdp14cqgnPl1xgSRw
   vtkwBLPo+DJNTgD1WSE5d20jZR58DgOQcL/h+uhaDkuy/Ud7SoRBtGb0V
   QxeDYZ42VZV67lIbNqbzx8c2PnEDPNENGfgjfxVJF7uLHTg65lhX5FkCx
   0tGhBX/8rYtDDzUWauq9f0RFIEnITyOnodasG5TFdwYI6E8vfqv3+krEV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="55896794"
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; 
   d="scan'208";a="55896794"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:51:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGjdroPtLQPnBXt399h4udUuA65+jSMlIOtR2jZbaCxYzllEipQBi62IZC6RFYLv9Oj9BjWgxnd8krM7gshsf1Un6r/ZDJsfzZmsd/0x9YwWZgx9MufB3XIqYrL2FTwIbFMGV93e2nzmlWN/LeUdy0X5nzRDQIS8Ga6QH+kIRlAHlbycrVgBvXigXX4vK3lpa6MdRWaAFpRqqEuXIEP6hEpUCvw45LtDEqi01NPl8Sc08jLpkZx4Syk8kmaxdIFWWINZm1nGatDaJ+ErR0mAED6NaizvFFo5QJuN9YMR2wD6Ta+JO+netu8Xvym9sD3kJYJ5giROCLKmbINsUbtm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKx7rd8ZYfPOOiLBb5ljeWqTHuPi4e8khYux+UcN9+U=;
 b=j/HI0s5XNCgSVt9w5a8xUxH7ZOcy5Dir/0JyHVm2IJwnNPhz1F3E+/YYGDj6TbEuqpl0KUbWYsXl+Q8FUMeNeNfqbN/HDU/rGAKh6QFKszZQXykPqQeLrIvFZWioOmXyHrEAW0tWKwBOmqmnbCxhzLNUlV1udCnBWbIZmSTQiZP1VSUUofZqu0i2pQRR6oWVDoZ8wlOWd9umW5RmNJWQ3cndRUOtnzkApObv4IsVzWTOG9bOBofl74Ikl2FuTHuHjUi6ZQU85Sg2enrTgx0mkKzgfa6qNeE6uj1uQO53w4grdcerbndJ1UPDN3jkh3nB2QpfcEeEfozcXeC0CcbviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKx7rd8ZYfPOOiLBb5ljeWqTHuPi4e8khYux+UcN9+U=;
 b=S+wdWUBmpE0EyZlkwH5Aly0rm1KGK6w3hRcDgtk7QtON33g9lceStw0tKGEx2x5S/cXG4ap3f8b3f816Dw9wUtbNAuOtmTHqrIgc9tsnBWbdp2ic5HWn9gAHapE6/dR2/QVQIv3rx4rYxZaWqe2PRMONUJuDWQiwzZqzkQ/vuhs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB5958.jpnprd01.prod.outlook.com (2603:1096:604:d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 07:51:02 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:51:02 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>
Subject: Re: [PATCH] generic/673: Add separate sgid stripping sub-tests
Thread-Topic: [PATCH] generic/673: Add separate sgid stripping sub-tests
Thread-Index: AQHYWT9Xb1PHBCBf10CfIPLz7Zmh+K0B420A
Date:   Tue, 26 Apr 2022 07:51:02 +0000
Message-ID: <6267B2CE.5030807@fujitsu.com>
References: <1650961806-2219-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1650961806-2219-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 876a0114-29cb-43f4-8b57-08da27598297
x-ms-traffictypediagnostic: OS3PR01MB5958:EE_
x-microsoft-antispam-prvs: <OS3PR01MB59581D4D95C7C1DF2E97A397FDFB9@OS3PR01MB5958.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PmPXN5EJ1o76rcxDb905+Nvi9dzAqkjQ2UZpR1C8NOCJcdVCVhhO3lL01ry14IPGd7PoHQaM/jJqyHKkvUKG2HJZ1mcZEYWiEpaovSzRLBQZMYgVYNdmapUV+WaFtoGBa6I4gqDYHxlWvoAshY5ogsQWGvkxPexYnMi2NP3CmXQCFJQ6q8UOLJQLf0PPOT1TJofGNraCELMXtAAOAN6ZeNvCoysWl2kN2+vQMK0wkZ3OIKwYTT8vryFCH7W+1mXKBiLQD5suosBdTKPg6U9dnm1Q87EpzMJjfqPXgQPwKrehWZBIIs4fjbJQEH3E/GWb7eOFaBmjCj2zwsRS4hTdC1x+1SBsNjtf8cMxpzY2PgOFTHOVEUJxT3mfMNWfTEAQquxN3OzBXJbbvAF5l/DJ+HYZ2GZJnUC3RuXn/rz1l1vcHGSoOa+PZWnPp5KFhjQ24I6QPEjlzOwdT2PilLmj7lJhaP/BKuGymSwlFXAz2+zAKNNbveaDYZEmyAexyFGvn8upjQ5WYSRSyqTdHI+OUUQ5FSi89VtA2hDSgIvzGu331cwtkUGRB6p0ZyruRKiWSC4FOgwTwpT+fFbRPqS29OdEfFkTjm2Oqic6386Dbu2u4fUnUZMaFdnhNZTrdtA+AEWdyoWbAQi2ffHNmExJQhvb3TeEX1F90oQJSzhc9Bg4F7kP3P8pMUtU6PwXmEjJIj0AJ9BkCBlCqyWDNl9KEoSMvI7xGposHx2zofqMjQLXd7nVnQRXkc7nUM8IXxr+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(508600001)(85182001)(316002)(36756003)(66556008)(8936002)(33656002)(64756008)(8676002)(66476007)(110136005)(76116006)(82960400001)(91956017)(186003)(5660300002)(6512007)(38100700002)(38070700005)(86362001)(4326008)(66446008)(2616005)(71200400001)(122000001)(6486002)(2906002)(83380400001)(26005)(87266011)(6506007)(41533002)(168613001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UDUyZXRVR2JNbWxqQXlLb1Nsd2RPOHg2TkI0MnduQnNNU2VmT1U5eWN2VGJp?=
 =?gb2312?B?SWFuK3VMZnVCU3J6SVlsUWw4cmVmbkNBemFBYzA5cVluYWtyZE5aT3pDcEJI?=
 =?gb2312?B?TFBqa0NOamEvaHZsOENiaCs2Mi9sSWI4Y3lZWXFwYjAzSkNvZUhZT3JYemtj?=
 =?gb2312?B?ZEpJODdwY296UGZPaXRXb2x1ZFFBL3YzTWh1SVd1K2t3b1c2bHBRWHlDTHBM?=
 =?gb2312?B?V3MyRXFScnIzRjNrZ0t3cXlod094WHFINkROMmdwYTdjcElPdDhxQWJUVkpq?=
 =?gb2312?B?K2R1V25QK05SR1NKWEZTdU5TRmdpdmQyUEZPaGk5aHZLdmhtY0FhOS9Nakov?=
 =?gb2312?B?d0V4L25sY2ZKaGZwTGRLc0RSQ3dkM05CVG1YREdPallLMXRaWi92aVd2WlEx?=
 =?gb2312?B?c1pzRTBlZW9UVTRKZ1M4NFNRc0dFMTBWQUxQT2pPQkcrbzg3K1hVcnZjRlkx?=
 =?gb2312?B?a1d5bzR5cnF0dVMvWVdwOFFDZXdETTZRODUxWi9SbXJXZnhlSmRGUFU2V0hw?=
 =?gb2312?B?UGRKVG5QS1FqUHYwSGhQNVJVL3BxYkFSTTVKbkJRNDNGU09LU2UzbUJPOU9W?=
 =?gb2312?B?YlkwUGdwNU9FTmROODYwQTc2dmlFcndMbmtRZWo5RGo2ZHhkOGxUU1ZCZTJI?=
 =?gb2312?B?bS94cXNWSllEcS9hMjBxdWpDR2ZidHdpMVFpZGVrTWdVNUtvbnFTT0R3NXJQ?=
 =?gb2312?B?TDZkS1VmZXhLMkxlRHYxeE5xTlFKRTJCUzQvcGZibkNETGZHYjMrWEVMcWY0?=
 =?gb2312?B?eWc1OHQvN2ZaMkpWYUVzK1M1TkdnWlFYRVI1VzR0b3U5cHlUKzcwelRKNGRK?=
 =?gb2312?B?Wk1wTUpUekFaR3JPQUZBSVlKL1BVVXdOZHdvNCtubXJFdXY5aUhhMkE4eEhX?=
 =?gb2312?B?MlZvZVo0c0pCamlvdWxpTnhMblFlYjZrdnB5eVkvQys4SjVpTE90TllLanN0?=
 =?gb2312?B?WDNxS1FRTlFhL1ZjZ3BSZ0luL1N3R0k1Q1R1a09Md3lkV0hBWG5aTnBVUGRv?=
 =?gb2312?B?QnExc2hQeERVbjlocUxoNGpZczU4TkRVMnJXTHJNRFl3MUlKWDJnOVd0M2N2?=
 =?gb2312?B?ak9wbUc2NFgxS1NaKzVxY1ZWUlo2bGVXUUp6UUJmNThTLy9pUld2QVlaaFpi?=
 =?gb2312?B?RmtpTWV4clJGNjZDc2JpbVdqY3JUWTlNMmh6Vmg3UmdrWklIM2Zza2lEdFc4?=
 =?gb2312?B?OCt0VEdPZUZuYjY0R1EwejJKV0FVZzI5aEgwQmxsTHFVMDVWMmk1ZFpvd29K?=
 =?gb2312?B?ZTQ2YUpYaVA0N1VWb3cxNlVCVllFTitrZnVPeHFwLzlUaXAyYzZWR3phaTVZ?=
 =?gb2312?B?eVg3UGN3cGhZQ255K1NGSngwUVRmNFEzTnhPQUlHQkFRalk5VVpNTUpXcGdF?=
 =?gb2312?B?NmNxWTdPYnB1M1B4OERZZHA5amEyQUVuME5Xa1BLeGZ4a2lhVi90c1NlcUZZ?=
 =?gb2312?B?S1NVM2J2c2pNL1BZQXJUR080dHRwK3hVak1JUkJEYVk1K1drM1NkRzV6ajJJ?=
 =?gb2312?B?ZFRlck1sTTNUU3V4bEo1N1NtY1dWZlRxSW41YXlXOEp1MlJMSTRjVFMvRnYx?=
 =?gb2312?B?b1d6SXZPV2VLTGc2SFoyVmZ0UE1UeU9kS3YyVlBsdUFIcktRTGNmd3B4L2NV?=
 =?gb2312?B?N1BjYUdITnBVMzlhNElVZitQZ3pvT0JYbGk1Y1ZnOHFsRE1qazdFYWRWRDZh?=
 =?gb2312?B?NW5wVVlTL2g2UjBlcXlBdmpnVURvNzl6RlMyVDlaYU1yZlF5Q1hNUm5DcVBL?=
 =?gb2312?B?OVg1NzZrUkRGdGhJZ2padHRxUTNMR0JmMGNrRXR3TjJrdXlIN01sQVpzaXQ1?=
 =?gb2312?B?L081R1lEd0NrbmlmVnd2d0YwcmJpSkdzRnZxQjgxUisyc3NRM29JVmM5YUlC?=
 =?gb2312?B?R0JzUEgzcWpCV0gzRlNxeWlGLzJqREIrbVg2QktYcVM0UWh0SzNXTGxqSWJT?=
 =?gb2312?B?bnpFV3pRT2wwejZtY3d6dGJNeEdUTEtpZjJQdm5FdnM0UXpVM1RTcW9CQklF?=
 =?gb2312?B?YTNmSlNCQlZpMGVDaHd2NTg2aFcvU2tpY2xaZlVzUG1iY0pGSzFkbWVGbWgr?=
 =?gb2312?B?QmJXMGFLeVYrVDBzNVZMT2RvS1dqZEdZK1BibnRSSHN2Vmt2QjNHRk9Ja083?=
 =?gb2312?B?QkZodkI4OTd3ckdlcGwvNXZ0MGw3MVY3Wlk2VWtCRW4vVGdOYUZMVk5lcVNB?=
 =?gb2312?B?aUhOUEg4aFk5Z1dKM1JCZkJ6am00aFVNY1M4ckVLSUxsL0J5VUJocWJFbzJu?=
 =?gb2312?B?Rys2ZytiTHQxT0p6Q21ucFF4eW8zbVJXWTkrcG5LYnE4V1M5cCtPbVdjbFdi?=
 =?gb2312?B?YklGbk02RGdYWEdrM3RvNXRUWnZnb1FMdWplTElCd1NOV3dabXJxL3BXcEMz?=
 =?gb2312?Q?ng339nFeBKjUVu6fk1L8BSjR9ST7xeqGFMFEX?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <C8BDB991F5B67E49A394275E6577052F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876a0114-29cb-43f4-8b57-08da27598297
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:51:02.2576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDNwftFQFHFgKEeJEnDycUWYGeHqBfRqiHjl4lrG0v1n4miGSyhBmuKxLMg5lgUAqK8g1ICCxqO5o2GGnz+v7luyHS0XPPiXuypLqHp6N2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5958
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24yMDIyLzQvMjYgMTY6MzAsIFlhbmcgWHUgd3JvdGU6DQo+IEV2ZW4ga2VybmVsIGRvZXNuJ3Qg
Z2V0IEFUVFJfS0lMTF9TR0lEIG1hc2sgYW5kIGdldCBBVFRSX0tJTExfU1VJRCBtYXNrLA0KPiB3
ZSBzdGlsbCBjYW4gc3RyaXAgU19JU0dJRCBtb2RlIGluIHNldGF0dHJfcHJlcGFyZSBhbmQgc2V0
YXR0cl9jb3B5Lg0KPiANCj4gV2Ugc2hvdWxkIGNoZWNrIHNlcGFyYXRlIHNnaWQgc3RyaXBwaW5n
IGxvZ2ljIHdoZXRoZXIgd29ya3Mgd2VsbA0KPiBvbiBkaWZmZXJlbnQgZmlsZXN5c3RlbXMuDQo+
IA0KDQpTb3JyeSwgSSBtaXNzIHVzZXItZXhlYyBjYXNlLiBXaWxsIHJlc2VuZCBpdC4NCg0KPiBB
bHNvIGZpeCBjb21tZW50cyBlcnJvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvZ2VuZXJpYy82NzMgICAg
IHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgIHRlc3RzL2dlbmVyaWMv
NjczLm91dCB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDIg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9n
ZW5lcmljLzY3MyBiL3Rlc3RzL2dlbmVyaWMvNjczDQo+IGluZGV4IDAzNzdjNWY2Li41NzJhYmI3
YiAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvZ2VuZXJpYy82NzMNCj4gKysrIGIvdGVzdHMvZ2VuZXJp
Yy82NzMNCj4gQEAgLTUzLDggKzUzLDcgQEAgY29tbWl0X2FuZF9jaGVjaygpIHsNCj4gICAJZWNo
bw0KPiAgIH0NCj4gDQo+IC0jIENvbW1pdCB0byBhIG5vbi1leGVjIGZpbGUgYnkgYW4gdW5wcml2
aWxlZ2VkIHVzZXIgY2xlYXJzIHN1aWQgYnV0IGxlYXZlcw0KPiAtIyBzZ2lkLg0KPiArIyBDb21t
aXQgdG8gYSBub24tZXhlYyBmaWxlIGJ5IGFuIHVucHJpdmlsZWdlZCB1c2VyIGNsZWFycyBzdWlk
IGFuZCBzZ2lkDQo+ICAgZWNobyAiVGVzdCAxIC0gcWFfdXNlciwgbm9uLWV4ZWMgZmlsZSINCj4g
ICBzZXR1cF90ZXN0ZmlsZQ0KPiAgIGNobW9kIGErcndzICRTQ1JBVENIX01OVC9hDQo+IEBAIC02
Niw3ICs2NSw3IEBAIHNldHVwX3Rlc3RmaWxlDQo+ICAgY2htb2QgZyt4LGErcndzICRTQ1JBVENI
X01OVC9hDQo+ICAgY29tbWl0X2FuZF9jaGVjayAiJHFhX3VzZXIiDQo+IA0KPiAtIyBDb21taXQg
dG8gYSB1c2VyLWV4ZWMgZmlsZSBieSBhbiB1bnByaXZpbGVnZWQgdXNlciBjbGVhcnMgc3VpZCBi
dXQgbm90IHNnaWQuDQo+ICsjIENvbW1pdCB0byBhIHVzZXItZXhlYyBmaWxlIGJ5IGFuIHVucHJp
dmlsZWdlZCB1c2VyIGNsZWFycyBzdWlkIGFuZCBzZ2lkLg0KPiAgIGVjaG8gIlRlc3QgMyAtIHFh
X3VzZXIsIHVzZXItZXhlYyBmaWxlIg0KPiAgIHNldHVwX3Rlc3RmaWxlDQo+ICAgY2htb2QgdSt4
LGErcndzLGcteCAkU0NSQVRDSF9NTlQvYQ0KPiBAQCAtNzgsMzAgKzc3LDQ4IEBAIHNldHVwX3Rl
c3RmaWxlDQo+ICAgY2htb2QgYStyd3hzICRTQ1JBVENIX01OVC9hDQo+ICAgY29tbWl0X2FuZF9j
aGVjayAiJHFhX3VzZXIiDQo+IA0KPiAtIyBDb21taXQgdG8gYSBub24tZXhlYyBmaWxlIGJ5IHJv
b3QgY2xlYXJzIHN1aWQgYnV0IGxlYXZlcyBzZ2lkLg0KPiArIyBDb21taXQgdG8gYSBub24tZXhl
YyBmaWxlIGJ5IHJvb3QgbGVhdmVzIHN1aWQgYW5kIHNnaWQuDQo+ICAgZWNobyAiVGVzdCA1IC0g
cm9vdCwgbm9uLWV4ZWMgZmlsZSINCj4gICBzZXR1cF90ZXN0ZmlsZQ0KPiAgIGNobW9kIGErcndz
ICRTQ1JBVENIX01OVC9hDQo+ICAgY29tbWl0X2FuZF9jaGVjaw0KPiANCj4gLSMgQ29tbWl0IHRv
IGEgZ3JvdXAtZXhlYyBmaWxlIGJ5IHJvb3QgY2xlYXJzIHN1aWQgYW5kIHNnaWQuDQo+ICsjIENv
bW1pdCB0byBhIGdyb3VwLWV4ZWMgZmlsZSBieSByb290IGxlYXZlcyBzdWlkIGFuZCBzZ2lkLg0K
PiAgIGVjaG8gIlRlc3QgNiAtIHJvb3QsIGdyb3VwLWV4ZWMgZmlsZSINCj4gICBzZXR1cF90ZXN0
ZmlsZQ0KPiAgIGNobW9kIGcreCxhK3J3cyAkU0NSQVRDSF9NTlQvYQ0KPiAgIGNvbW1pdF9hbmRf
Y2hlY2sNCj4gDQo+IC0jIENvbW1pdCB0byBhIHVzZXItZXhlYyBmaWxlIGJ5IHJvb3QgY2xlYXJz
IHN1aWQgYnV0IG5vdCBzZ2lkLg0KPiArIyBDb21taXQgdG8gYSB1c2VyLWV4ZWMgZmlsZSBieSBy
b290IGxlYXZlcyBzdWlkIGFuZCBzZ2lkLg0KPiAgIGVjaG8gIlRlc3QgNyAtIHJvb3QsIHVzZXIt
ZXhlYyBmaWxlIg0KPiAgIHNldHVwX3Rlc3RmaWxlDQo+ICAgY2htb2QgdSt4LGErcndzLGcteCAk
U0NSQVRDSF9NTlQvYQ0KPiAgIGNvbW1pdF9hbmRfY2hlY2sNCj4gDQo+IC0jIENvbW1pdCB0byBh
IGFsbC1leGVjIGZpbGUgYnkgcm9vdCBjbGVhcnMgc3VpZCBhbmQgc2dpZC4NCj4gKyMgQ29tbWl0
IHRvIGEgYWxsLWV4ZWMgZmlsZSBieSByb290IGxlYXZlcyBzdWlkIGFuZCBzZ2lkLg0KPiAgIGVj
aG8gIlRlc3QgOCAtIHJvb3QsIGFsbC1leGVjIGZpbGUiDQo+ICAgc2V0dXBfdGVzdGZpbGUNCj4g
ICBjaG1vZCBhK3J3eHMgJFNDUkFUQ0hfTU5UL2ENCj4gICBjb21taXRfYW5kX2NoZWNrDQo+IA0K
PiArI0NvbW1pdCB0byBhIG5vbi1leGVjIGZpbGUgYnkgdW5wcml2aWxlZ2VkIHVzZXIgbGVhdmVz
IHNnaWQuDQo+ICtlY2hvICJUZXN0IDkgLSBxYV91c2VyLCBub24tZXhlYyBmaWxlLCBvbmx5IHNn
aWQiDQo+ICtzZXR1cF90ZXN0ZmlsZQ0KPiArY2htb2QgYStydyxnK3J3cyAkU0NSQVRDSF9NTlQv
YQ0KPiArY29tbWl0X2FuZF9jaGVjayAiJHFhX3VzZXIiDQo+ICsNCj4gKyNDb21taXQgdG8gYSBu
b24tZXhlYyBmaWxlIGJ5IHVucHJpdmlsZWdlZCB1c2VyIGNsZWFycyBzZ2lkDQo+ICtlY2hvICJU
ZXN0IDEwIC0gcWFfdXNlciwgZ3JvdXAtZXhlYyBmaWxlLCBvbmx5IHNnaWQiDQo+ICtzZXR1cF90
ZXN0ZmlsZQ0KPiArY2htb2QgYStydyxnK3J3eHMgJFNDUkFUQ0hfTU5UL2ENCj4gK2NvbW1pdF9h
bmRfY2hlY2sgIiRxYV91c2VyIg0KPiArDQo+ICsjQ29tbWl0IHRvIGEgbm9uLWV4ZWMgZmlsZSBi
eSB1bnByaXZpbGVnZWQgdXNlciBjbGVhcnMgc2dpZC4NCj4gK2VjaG8gIlRlc3QgMTEgLSBxYV91
c2VyLCBhbGwtZXhlYyBmaWxlLCBvbmx5IHNnaWQiDQo+ICtzZXR1cF90ZXN0ZmlsZQ0KPiArY2ht
b2QgYStyd3gsZytyd3hzICRTQ1JBVENIX01OVC9hDQo+ICtjb21taXRfYW5kX2NoZWNrICIkcWFf
dXNlciINCj4gKw0KPiAgICMgc3VjY2VzcywgYWxsIGRvbmUNCj4gICBzdGF0dXM9MA0KPiAgIGV4
aXQNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNjczLm91dCBiL3Rlc3RzL2dlbmVyaWMv
NjczLm91dA0KPiBpbmRleCA0ZDE4YmNhMi4uNzY3MjUxZjIgMTAwNjQ0DQo+IC0tLSBhL3Rlc3Rz
L2dlbmVyaWMvNjczLm91dA0KPiArKysgYi90ZXN0cy9nZW5lcmljLzY3My5vdXQNCj4gQEAgLTQ3
LDMgKzQ3LDIxIEBAIFRlc3QgOCAtIHJvb3QsIGFsbC1leGVjIGZpbGUNCj4gICAzNzg0ZGUyM2Vm
YWI3YTIwNzRjOWVjNjY5MDFlMzllNSAgU0NSQVRDSF9NTlQvYQ0KPiAgIDY3NzcgLXJ3c3J3c3J3
eCBTQ1JBVENIX01OVC9hDQo+IA0KPiArVGVzdCA5IC0gcWFfdXNlciwgbm9uLWV4ZWMgZmlsZSwg
b25seSBzZ2lkDQo+ICszMTBmMTQ2Y2U1MjA3N2ZjZDMzMDhkY2JlNzYzMmJiMiAgU0NSQVRDSF9N
TlQvYQ0KPiArMjY2NiAtcnctcndTcnctIFNDUkFUQ0hfTU5UL2ENCj4gKzM3ODRkZTIzZWZhYjdh
MjA3NGM5ZWM2NjkwMWUzOWU1ICBTQ1JBVENIX01OVC9hDQo+ICsyNjY2IC1ydy1yd1Nydy0gU0NS
QVRDSF9NTlQvYQ0KPiArDQo+ICtUZXN0IDEwIC0gcWFfdXNlciwgZ3JvdXAtZXhlYyBmaWxlLCBv
bmx5IHNnaWQNCj4gKzMxMGYxNDZjZTUyMDc3ZmNkMzMwOGRjYmU3NjMyYmIyICBTQ1JBVENIX01O
VC9hDQo+ICsyNjc2IC1ydy1yd3Nydy0gU0NSQVRDSF9NTlQvYQ0KPiArMzc4NGRlMjNlZmFiN2Ey
MDc0YzllYzY2OTAxZTM5ZTUgIFNDUkFUQ0hfTU5UL2ENCj4gKzY3NiAtcnctcnd4cnctIFNDUkFU
Q0hfTU5UL2ENCj4gKw0KPiArVGVzdCAxMSAtIHFhX3VzZXIsIGFsbC1leGVjIGZpbGUsIG9ubHkg
c2dpZA0KPiArMzEwZjE0NmNlNTIwNzdmY2QzMzA4ZGNiZTc2MzJiYjIgIFNDUkFUQ0hfTU5UL2EN
Cj4gKzI3NzcgLXJ3eHJ3c3J3eCBTQ1JBVENIX01OVC9hDQo+ICszNzg0ZGUyM2VmYWI3YTIwNzRj
OWVjNjY5MDFlMzllNSAgU0NSQVRDSF9NTlQvYQ0KPiArNzc3IC1yd3hyd3hyd3ggU0NSQVRDSF9N
TlQvYQ0KPiArDQo=
