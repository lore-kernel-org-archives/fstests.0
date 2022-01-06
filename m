Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22958C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 01:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbiAFBlZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Jan 2022 20:41:25 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:16556 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344431AbiAFBlV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jan 2022 20:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641433282; x=1672969282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wRnHIV5z90Nh7OyDVtgVDsJS+Ypi+ykQ88t2eEnklhU=;
  b=xLdEtpFOdE8j+qKKKHKao869j5c4A0M8P0fwk6zdRj+eJjM3flHTc3IQ
   FbYAqosqVId87zgyXO9dxubbn9/eWB7RkoEOEbu5hdksvcXPrBI+fVMiN
   Hb5JnBzy2J4uznXt3IxuzOPNVXAFhggrevF8WVlSyq0K5kvmh0zBJSh/P
   XSbKlxf6MUzBdibAXiWvd7i6+YVSFti1+0y0r43lkJwQdF462x2EB+7nz
   i8BC2T9F4+NPEqfFfxde/MjRh1qD6mthiAPw+UCmHmZzzkA3ZqPBYZWX+
   DN6cDCbFMAyePnQt2Iqf9XOB8IXMJqy0sJ9tL06KLjbaEN7P56pamoMBD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47047414"
X-IronPort-AV: E=Sophos;i="5.88,265,1635174000"; 
   d="scan'208";a="47047414"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 10:41:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKOLVx8DfnZhvA7qdkO3yr7PUkxlJh5XtsohyKD0Xgik5lHrzO0fOqcY3yob80JoZfmfrNFuY1dbJYIHSgkmB1suaE6K1Eq77pIQnadF0f4T25CbuiOv1Mc1T4R7ikTn55hIdVkTwmeDSjN1BesuLmF0PlZXAVTjWCo0TXIcnTyhkof9b5o0iwFTlBb2GMw0Hjiz+NJJuV467a/1iPiYIPPsXDll2Gyvs7zdvTEUBoBkwg8/f96aUbOUpSTFr5pMbgjuRNvVY5nMHxuZ8zaQdeHz/15m2Y4tBH7Yx18MC2iBMPDLhNyM5BWgBUK4jg4HEzqGkmzW4ICzuMT16cHogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRnHIV5z90Nh7OyDVtgVDsJS+Ypi+ykQ88t2eEnklhU=;
 b=DzBMGL6k1eG3gdQCJiSvKpcyHyHLt36h3FlUYHncDCdU2t5dO122gTlhFGpRrTT7WokL41Q7DvBT6jlAcuKqJI/MEJ48S1fhAQVUPMxIgiw4inToaLj6x2RpZStf6UumJvGtp30cLnm698/bU0nZ45gW7zUL+JANhF4GhXbOG9qzVNQ/8TswKsJhoWGKMFN5cAAIjSCnLLkwc0Eub0+SVfrEmoVhvqz8z/DmYs+U9QDk4tHKH1+3ohp2iXNdkpP7O7skNggntX8s4j/eF2zBQN5Cw52/UxX9Z0c2cK5q/UezfLFpcF/Ls+OL71PyPhWV0E4B5xAjq1aQXyraExrqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRnHIV5z90Nh7OyDVtgVDsJS+Ypi+ykQ88t2eEnklhU=;
 b=Sl+lTmICpjRh4kcTPBAunB1A+pNZAdDuT8dekMw/G/JZUF7T4hw/2tqdQIIeHg2OQzjhWYaHdwBjy6s2N1dU8s1nm5dnY/eomiDEoi02DHB+dD/tdYxGfHDy4EB4Qvk2PyhnCHCHjmyllmoq2tkhTMZRRK6/2L7FNmTUu9nvSOk=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6849.jpnprd01.prod.outlook.com (2603:1096:400:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 01:41:17 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 01:41:17 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] xfs/126: Add a getxattr opeartion after corrupted
 xattr
Thread-Topic: [PATCH v2] xfs/126: Add a getxattr opeartion after corrupted
 xattr
Thread-Index: AQHX4bs11EBmSACDlECczOfyOSMc/qwWdx6AgD8CmYA=
Date:   Thu, 6 Jan 2022 01:41:17 +0000
Message-ID: <61D648E5.3010209@fujitsu.com>
References: <1637817207-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20211126232817.GA266000@magnolia>
In-Reply-To: <20211126232817.GA266000@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 332d995b-b1d0-46c7-a374-08d9d0b5a1db
x-ms-traffictypediagnostic: TYCPR01MB6849:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6849FAC87C93F22993B30C8FFD4C9@TYCPR01MB6849.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xrv2TQJICijmj6M0BP7OZvTirqO1FbIMe77tKIa/CzJ15PGzdWaIqmnTwdQgOtfKR5r6wkBJAUjOsbld0xczPfr+ekJv+iKdOYZVa+xOm2CvZEtZ56a4BBW8MJOGfgpZzt/yzoI0z6uBFZnSFZmsA+wObtcEhY8szGP038bdcBSHNA2Jos22zfLm8ca7VzhhaRHwefm8DO3eZyCxkQfS7Ou+Zs00RjbOCtPNGaLQ/0AcLY0VeoQiFgNYibqPPafQdG10P41HpE79ViP4bzPVi672+xY/L0uqh1EmsHsdRaJqV8duhFnlA7gmZBpr5VZjmITyutZKn5OKlRIuZ7XA/x0QKM9wETtmHX1ud/TybmgLx4C/dOul4exQHL9eNfPWYMPfiC2OQHtSd2NXPLvgOjXgSDKhfPdetFyUonqozh6aVIHYaH36wPOYna5Iv9A+HrtHrgRQBi3PB70TQYDb8WzX5NVORNQUXKPDGgJnHQ+kwu8X9zsDkWmthXZ9Pw1d6ZveaYOhGRMoz2ERKcevCGz/fja8drbadzo7t0hRcm4QgFS6cI++zOeGSMrgzI5PHAgSVd743zTk9TPZKj2C1vXWOoJekaeG4HcTJOU2NSG1ZN3hMvYeGMnxum15cJKHf2dv9ovRcglmHNqrrD/HypZLbiKtoCr0CHE5uLDt1aCytMcI9Ta7IsSjLZ92RvYwzeeN4QIeQF49lNoI4XSgFEBEgMbvAF7jPhHvzDS5y7qGxOFmDwLKZmRjKVl+kt7gRZZ5cRcDIXV+Icte0UB5uw886WOXYFb5XA17mSBm9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(122000001)(85182001)(38100700002)(4326008)(6512007)(38070700005)(2906002)(5660300002)(316002)(186003)(33656002)(87266011)(26005)(83380400001)(6506007)(36756003)(8936002)(8676002)(6916009)(86362001)(91956017)(64756008)(66946007)(66446008)(71200400001)(2616005)(6486002)(76116006)(82960400001)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?blRpSkI2MGI2R29CVU1ubFQ3UTB2Q3c3REkxQjJXQXVkVXh5a2gyK0xNL0s1?=
 =?gb2312?B?UXhncXBmSVppeXlTUXpBQ2ovYjJQTldzdklFWmE4dU5FUDFVbHBxbGFOelF5?=
 =?gb2312?B?Z3JmYk53S2d4Z3RFK01nOFlKZHhOZ1FYM3Bjb3BhbVAwdDRWaWVQQ0lDQ3Nu?=
 =?gb2312?B?KzlLaHdLMGVTYUdTSStBWjNFVHFuWnVvZU9hNk5jeFhTOTNTVTVBcTdWMmxm?=
 =?gb2312?B?K0xKZzVhT2hkd3dTRG9QSTZRZStoQU5KSEF6Q2lqd1QxRWZaRmQxSzhhZ1Iy?=
 =?gb2312?B?VEF2VzQ1cG93aC8wS3BtVFU3aWwzNnV2VU9UZjFJRnBpdjVxRFZwdCtNbjYx?=
 =?gb2312?B?NVM1M1ZiYmpocmIwZkk4RVpLVkFrcDJNSGVycDZKUlV1TW1EbGlxdFhSTDlH?=
 =?gb2312?B?M2podU12T280c1MvbSswUGdNMnZncEl0bjBoNTNTNXZrWjk3WEEzYjlVRXd3?=
 =?gb2312?B?ckJ2Q2tsSEc1cVlJVGxqcVRvVVI4TDd1Z0lkbHVEWXdkbW4wc2IwRENrSlhY?=
 =?gb2312?B?RFlRV0c4enFsYTFidGxlOHJmVXNUSlpQUG14T1luMFl4bnoxQkhIQWhyZEp2?=
 =?gb2312?B?ZDlKUHZTOFlUdWQ1ekt4VGZESjlpZkJueUZzMkt2czdFQ3BhR0V3eFhDWEQ2?=
 =?gb2312?B?OWw4TCtOU0JWRktSZlRQOU9zaTQyWHQybGJkQnRhVE1QVTdpMDJBN050NlVt?=
 =?gb2312?B?djFEemhnRC9rRFQ3SVFqemxlOXhKRGFUdFBLT0VCcGh3Ym4wbXNoVXhYNEcx?=
 =?gb2312?B?eTJ3UHdvZ0Zxdmg4T1BNaWorRFZaRXZwbEowb25xZndJQlY0ODc2d3hRRHRp?=
 =?gb2312?B?eWE3WjRsVDZodW5XL0w3NWM4RDFvOGlpVEovclF6S3JnSVlENGY0TkUvUDQv?=
 =?gb2312?B?T0NjUmRWNUdGMGI0aDdFVXptYnlpUkpCQWlwTzYrRStBTURRanFTS0JtdWNq?=
 =?gb2312?B?N1VxQmJTdXlwVVB5K0dDditDZkk0dWxhMFM2VUZQaHE4OENVaStmTVpFUTF4?=
 =?gb2312?B?NkpGeGNhT1ozK3U2U25LVDZZc2JqZ3VsT0lwMjNMdkVzbEUydVl3TndaM0xm?=
 =?gb2312?B?dkcxTFVPUzBGUndOakRXaE5ONzJiUDFqZUVDR2tFeEJUSWp5ZFE5aXNwRmRN?=
 =?gb2312?B?RlJhZUMzS1FSNndRTXo1QnVtalo2ejRrRDg4WFluejc2VVV5NGthaW0yMXpU?=
 =?gb2312?B?TVU2aVB2YmhoTU02WW9UYnZ4Nlg1dzJEbWlLTnoveUorYXVBRHFNSGVaaEd5?=
 =?gb2312?B?cUZGbmV1bHArM3hqMDFDTWpYYURmVmNrcVVuRVlHTTNnWThHdXJoVzhRVEVQ?=
 =?gb2312?B?S3B5SzdpbFJyVlRtNUxMajJPVytlUEFnUW5UL2JQa1dRMHhld0tqQzFJRm1V?=
 =?gb2312?B?Wm54c3h1VWtuWTBGdE1PZzdDQkEyVHdYaldMbktxMER2RXUxSVlhUG9nakcz?=
 =?gb2312?B?UmYzakF2cWQ4UHVMbXFaNW5NclR6SjJXeDVpQWtabEptWUwwS05jVFpyQW9z?=
 =?gb2312?B?L2NzbFZPU2FNTlgvY2M2a1cvWDNyMzQvMFFxd1dOeFpVVExrWFZGTlhkb3BL?=
 =?gb2312?B?U2c3YTlQNEJPMnZoblNMWE9TNGE5R2VzMGJBV2NhdTRCMVlST1I1WkM3MkJl?=
 =?gb2312?B?cXZMemVpd1lROXZYVjVDdWsyZS82S25rbVkwcHpZdS9wTVlFWVN6Wk5HQzNB?=
 =?gb2312?B?TzZNdTFUbDVxSWJZWjJKb3dCK0lCWVgyaW1yOWlhSmxMYW5JQXZRZFM1MEVw?=
 =?gb2312?B?WC9TazN3L0NRVXBHei9FNFFnbHEwUW1XdVV3ZVFRclNQQUNDbUJtSW5mS2pt?=
 =?gb2312?B?NVdNZVA4Z1BjdDBxSlNraWFCZFZPbHNFa0VLMXVZZ2JBcU0vY0I3SUgwbURo?=
 =?gb2312?B?TytTWW5sS1dodVNaT0VkQldzcVBNeEpSbG1KUTBOMURaQ1ZFbHorVVZGZWNO?=
 =?gb2312?B?QUltd3VLd0FCVDlFZVZqZEtvWUx4RDd2SURMV3JFRHpIbitCSUlPUXNmNHNN?=
 =?gb2312?B?UW9YU2lRWE9haStla2luemoyd0NuZktlVGdEWG9TUGtOb0doNFZwTy9CY3k2?=
 =?gb2312?B?OVZpTXRKR3JTQlhncjRHWmtLUGx5Rm95cTQvWlhaakxGeElKTmV5VjFUclND?=
 =?gb2312?B?SWtvL2Fjb0NrcjVsRFlWTE93d3pwMEs5QlhEK0pCMk5Db1hNM0pHT01QV3RL?=
 =?gb2312?B?U0NtbTR2VzNDejEwdHQySjFNSkxzNlNTZlM4ZmZZbDM3SzFVZkU0WEFWRk9K?=
 =?gb2312?Q?i8QHGYbZpiyw1aiyBgV4yzNZQQ6mZ/mA+P14jovD7E=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <1AF879AD8615F845B4FBEB75D14BCB77@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332d995b-b1d0-46c7-a374-08d9d0b5a1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 01:41:17.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLDNInEsGIlcc2xEv1lpznmQtQOClCUDIM+syAqvjCcm1607fm+p6mqbBVdGHD1xCQ3qaaqbKu0xGuCqZ4cKCDoTVEWNyDt7bzBAt8OMgbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6849
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMS8xMS8yNyA3OjI4LCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IE9uIFRodSwgTm92
IDI1LCAyMDIxIGF0IDAxOjEzOjI3UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBJdCBpcyBk
ZXNpZ24gdG8gcmVwcm9kdWNlIGEgZGVhZGxvY2sgb24gdXBzdHJlYW0ga2VybmVsLiBJdCBpcyBp
bnRyb2R1Y2VkIGJ5IGtlcm5lbA0KPj4gY29tbWl0IDA3MTIwZjFhYmRmZiAoInhmczogQWRkIHhm
c19oYXNfYXR0ciBhbmQgc3Vicm91dGluZXMiKSBhbmQgZml4ZWQgYnkga2VybmVsDQo+PiBjb21t
aXQgYTFkZTk3ZmUyOTZjICgieGZzOiBGaXggdGhlIGZyZWUgbG9naWMgb2Ygc3RhdGUgaW4geGZz
X2F0dHJfbm9kZV9oYXNuYW1lIilbMV0uDQo+Pg0KPj4gWzFdaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2ZzL3hmcy94ZnMtbGludXguZ2l0L2NvbW1pdC8/aD1mb3ItbmV4dCZpZD1hMWRl
OTdmZTI5NmMNCj4NCj4gTkFLLCB0aGlzIGlzIGEgZ2VuZXJhbCBmdXp6IHRlc3QuICBQbGVhc2Ug
Y3JlYXRlIGEgc2VwYXJhdGUgdGFyZ2V0ZWQNCj4gcmVncmVzc2lvbiB0ZXN0IGZvciB0aGUga2Vy
bmVsIGJ1Z2ZpeCBzbyB0aGF0IHlvdSBjYW4gY29udHJvbCBleGFjdGx5DQo+IHdoaWNoIHBhcnQg
b2YgdGhlIGF0dHIgbGVhZiBibG9jayBnZXRzIGNvcnJ1cHRlZCBzbyB0aGF0IHRoZSB2ZXJpZmll
cg0KPiB3aWxsIHNpZ25hbCBlcnJvci4NClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCklNTywg
Z2V0YXR0ciBvciBzZXRhdHRyIHNob3VsZCBhbGwgcmVwb3J0IG1ldGFkYXRhIGNvcnJ1cHQgaW4g
DQpkbWVzZyhjb21tYW5kIGZhaWwpYWZ0ZXIgdGhlIGF0dHIgbGVhZiBibG9jayBnZXRzIGNvcnJ1
cHRlZC4NCg0KSSB0aGluayBpdCBzaG91bGQgYmUgYSBjb21tb24gcGFydCwgbm90IG9ubHkgZm9y
IHRoaXMgY2FzZSBhbHNvIGZvciANCm90aGVyIGF0dHIgY29ycnVwdCBjYXNlIGllIHhmcy8xMjUu
IFdlIHNob3VsZCBhZGQgZ2V0YXR0ciBmb3IgdGhlbSBhZnRlciANCmF0dHIgY29ycnVwdCB0byBh
dm9pZCBzaW1pbGFyIHByb2JsZW0gb2NjdXJzIG90aGVyIHBsYWNlcy4NCndoYXQgZG8geW91IHRo
aW5rIGFib3V0IHRoaXM/DQoNCnBzOiBJIHNob3VsZCB1cGRhdGUgbXkgY29tbWl0IG1lc3NhZ2Ug
Zm9yIHRoaXMuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPg0KPiAtLUQNCj4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0N
Cj4+ICAgdGVzdHMveGZzLzEyNiB8IDYgKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMveGZz
LzEyNiBiL3Rlc3RzL3hmcy8xMjYNCj4+IGluZGV4IGMzYTc0YjFjLi41NDk2ZjNkNyAxMDA3NTUN
Cj4+IC0tLSBhL3Rlc3RzL3hmcy8xMjYNCj4+ICsrKyBiL3Rlc3RzL3hmcy8xMjYNCj4+IEBAIC03
LDYgKzcsMTAgQEANCj4+ICAgIyBDcmVhdGUgYW5kIHBvcHVsYXRlIGFuIFhGUyBmaWxlc3lzdGVt
LCBjb3JydXB0IGEgbGVhZiB4YXR0cidzIGRhdGEgZXh0ZW50LA0KPj4gICAjIHRoZW4gc2VlIGhv
dyB0aGUga2VybmVsIGFuZCB4ZnNfcmVwYWlyIGRlYWwgd2l0aCBpdC4NCj4+ICAgIw0KPj4gKyMg
SXQgaXMgYWxzbyBhIHJlZ3Jlc3Npb24gdGVzdCBmb3Iga2VybmVsIGNvbW1pdDoNCj4+ICsjIGEx
ZGU5N2ZlMjk2YyAoInhmczogRml4IHRoZSBmcmVlIGxvZ2ljIG9mIHN0YXRlIGluIHhmc19hdHRy
X25vZGVfaGFzbmFtZSIpDQo+PiArIw0KPj4gKw0KPj4gICAuIC4vY29tbW9uL3ByZWFtYmxlDQo+
PiAgIF9iZWdpbl9mc3Rlc3QgZnV6emVycw0KPj4NCj4+IEBAIC02OSw3ICs3Myw3IEBAIGRvbmUN
Cj4+DQo+PiAgIGVjaG8gIisgbW91bnQgaW1hZ2UmJiAgbW9kaWZ5IHhhdHRyIg0KPj4gICBpZiBf
dHJ5X3NjcmF0Y2hfbW91bnQ+PiAgJHNlcXJlcy5mdWxsIDI+JjE7IHRoZW4NCj4+IC0NCj4+ICsJ
Z2V0ZmF0dHIgIiR7U0NSQVRDSF9NTlR9L2F0dHJmaWxlIiAtbiAidXNlci54MDAwMDAwMDAiIDI+
ICAvZGV2L251bGwmJiAgX2ZhaWwgImdvdCBjb3JydXB0IHhhdHRyIg0KPj4gICAJc2V0ZmF0dHIg
LXggInVzZXIueDAwMDAwMDAwIiAiJHtTQ1JBVENIX01OVH0vYXR0cmZpbGUiIDI+ICAvZGV2L251
bGwmJiAgX2ZhaWwgIm1vZGlmaWVkIGNvcnJ1cHQgeGF0dHIiDQo+PiAgIAl1bW91bnQgIiR7U0NS
QVRDSF9NTlR9Ig0KPj4gICBmaQ0KPj4gLS0NCj4+IDIuMjMuMA0KPj4NCg==
