Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BA5C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 13:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385265AbiEGOAG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbiEGOAC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 10:00:02 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA429CA5
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651931772; x=1683467772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2eydHgaO8z1X8hO+kW5C752eLJoCGpNUoqfFZ6xdpF4=;
  b=Es/0MlPrqmz1p8BJPOWmbXvCH0BUlBzaZxWKBh164sIgaWM1HyXyefKk
   NuTBQ+U+SEjLsGpfFXVS7j363nWWMn4A0OAobj6QSNh1f4srnnRi68eLc
   ghH0oI2fR1/be2MkLiuNNF5WHLhnzTR2szgz646pvIyYFTVF9OaCsQXm6
   v7cb8rYK6dUd3doehPhd0x4cAFTS4Jplc9QncmJisvX29Q6yTTbeiS6DK
   fYbILOVNfibqY02ujPYRiDXckff5DqupWnp0S3bNcIK5Su/BkGawDfBYi
   o6LuZj/AUPJ3VsLVlq5A5SmfhTbxJmRKlBf0B4SLgfrqOr5/jHFijOFIZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="55409804"
X-IronPort-AV: E=Sophos;i="5.91,207,1647270000"; 
   d="scan'208";a="55409804"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 22:56:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4C1h1wdni5r2+6/0jQc2fghIBF3QSupWoT1z09saZ7ZVrDID98OS48c+a6lf+K4gUU9JwPDG5G72IWS8BYs2vMaXRgaDMreeaCt7W3UCGu+36qTbR633xc6d0OkZLyKIDW325tTvu+C/lUU23uN3Lj0hqErvBbJiEywSmkUF8+ezDx4ptHKyuKejDcP78g5GNTW9YbY5lv2Q5D5RdiqNX0bNUfqYrEKytUGgNIbyyCrdiD9YRkQbMsexdmq2rv+sElv70harPjRwjYVpwSin8hQ+PFtlF3Is/Ht6o9YuiT+eynGXaIHY9IQMXbvwANAVw5kVaWvVJC1rW4io7gEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eydHgaO8z1X8hO+kW5C752eLJoCGpNUoqfFZ6xdpF4=;
 b=Wkh6l1lujpW72viHA4L50rw+tKJCn3bAkKUnCcI9GZJuuEYLhkuesACRhjgFCSDHG9vWop2YFk3MTuYVCbvMTdrUDV+w4zk26H9IdkJVsOzd0AFUcgRQLhlo7cj2VHtFaNIkYWzNvrT4LpNYOQPzGhtUHotTBDC2ST4MVfUkeLc/sVqn35HuMrEZZ1OpOsZO10Cg7OtLYpuUYAfzHPfIpTtnP86gcQNl6D7jPEY0XGrbvP5rI8YJZD4mhBo4Y6vVAE8nE08hwsbL8cus13azoPW0ccsAhkgELwWSBelAMF5iDKLI22TKp+UpFZ33jUZq/1OkaMyGQYE7p1NREGnDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eydHgaO8z1X8hO+kW5C752eLJoCGpNUoqfFZ6xdpF4=;
 b=k2zYZxgVQFhxgFYr7XVlL3c6lYxY7k6CkxGDHxYpTo1AdxkTVNnB5yXTNs7Dy/2CmmmVk3ktOPJnoddVOJLxoRdb+++kE8C7vU1IkRlVdW6x2+O2ZIQWII4Zvfc7PracsS5fHMMqeG77XiqVYbgXwNUmfcds//ylPLTZu7JZegY=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2380.jpnprd01.prod.outlook.com (2603:1096:404:6f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 13:56:05 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5%7]) with mapi id 15.20.5227.021; Sat, 7 May 2022
 13:56:05 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before
 run_test
Thread-Topic: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before
 run_test
Thread-Index: AQHYYgrQzlyaa30sfU2Asn2nHyPWIK0Taf4AgAAXSAA=
Date:   Sat, 7 May 2022 13:56:04 +0000
Message-ID: <627688B2.3050006@fujitsu.com>
References: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220507133330.xxuw2x7buluhpnlu@zlang-mailbox>
In-Reply-To: <20220507133330.xxuw2x7buluhpnlu@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 416b7505-0669-4620-aa84-08da30315432
x-ms-traffictypediagnostic: TY2PR01MB2380:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2380245928CE0A1859DBDE3DFDC49@TY2PR01MB2380.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTu+sdufOPMIe85IAM4ZNwTI9DqIkqf5X0iM6/DOMUxXDqz0+fMyNZG3d46aQMSI3/Puvh1yAY0aC+wcyTUIYeJBsbLVLB/bYmqL9O3DuK9VJS4VEPPKfjn0Iti0o2S3694E5XWYlVArl7DXOjOVpeonZYr9dfrAZVaCLuNJCMPBtQfUGNiJsfCsyoJpcn5RkHgrmpfjn8HOuDtMtbenLLGJ/8zldbK4VcwN+ew/sf/eNPvHlODs5SRFwWYT/nQrQR2GKBjhkMF0IRvQW8c8b+fMfMXKE4fUwzLQS+PXc+pRUM5lGhcxRmjhDhl6+tzbG953GnwwSYHuP0EJoN/50bw1c8zOyW0z6lRdX62rzSemu6koHUZj7q4nF/Gkbb4eA2N+KJXXEWi63f2j6FsmmiuZyDzXt2OZJqdsX0AO02VDe14s4ed4oiguIe6v4Qi6fHIgaBmiZpJ5g+vwXzJThipiprNbiLa6+G0GT4c2+g90q1CxkM+GoV3yEOd2Ex+nRY4LP//ugfBOmLG4XBI93rcFUtdW803/sYCw12L79NprMA664pIV9YfJf4AkoOfc7Uwb+1ih6qgwKGOGFo+TVeHvu0XOJuO8HPqHcTxaYfAJunz1qidp7Tp5fpZVBmzDRPnqSspxbGRLl1JgAFMATWjICmQHrcrge7wEQqMh1NoYSRwXlAWV/TY7F4EMVBVOr2ntfdj1XEf177R14bpLMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(8936002)(33656002)(6486002)(83380400001)(508600001)(5660300002)(38100700002)(38070700005)(2616005)(86362001)(6506007)(87266011)(6512007)(45080400002)(26005)(2906002)(186003)(85182001)(82960400001)(6916009)(54906003)(122000001)(66946007)(76116006)(91956017)(66476007)(36756003)(8676002)(4326008)(66446008)(316002)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RW1ZbkFTSXFsczJKUWpoYVp1OGJnbjdoTVgxcFIrbjlXc1FGWUhqM2RXSG5T?=
 =?gb2312?B?UE1yU2VOZHZFZUkvQm9nRU1FeUMwVEVXYnp3RURHdDZjS3BjeU82L3dXNGJp?=
 =?gb2312?B?bEszUFNoS2JYQ3JlN3RmcUFwQTdnSTZHM0pwWkZLbTdXZ3pTbVhWYTdDbG9L?=
 =?gb2312?B?UXUvK3poQXpvcHNzc0F5bzRtRmk4dmh2RVp5cWRlVFcvNm81c1ZJQXJ5Qmd4?=
 =?gb2312?B?blQ2VlZWYVF2VjVhYm1La3NxWTZjQzJSbmNJQm43WDVOQ0hzb2FTSjdWZkpD?=
 =?gb2312?B?VHlrYzJZdWlVck0wbHN0ZmxXemZrVnQxWUREYWNVWExvSXRXTXF6dW1lclBD?=
 =?gb2312?B?cUV1YkpQVEZ5S1RaTjM5dkF5cXQ0OFFNOFptd01nSUhjVHptRC96WUFjUld3?=
 =?gb2312?B?RWlObjhxQnlBdWpyOEJlVTlPazdQblFkck1zMkxhMS9aclF4WGFBSHZ3eWZV?=
 =?gb2312?B?MXFPSWhXS0JQNGlvZ21NOFNWYXNlcEhNeFlERWJHall6cEZKOEJQeVlNWmsv?=
 =?gb2312?B?cnBQd0JPZEh3YmZkeUlhekhJQUxNYlBOUHpqUG5tQjV3RjBVaVNPU21aM3I0?=
 =?gb2312?B?MU9zemNzVExnZFVTZFE1eFN0ZDBXR3lJYlpFT1djUlB5d1JvZERYVjBtQ2Jv?=
 =?gb2312?B?NCtncWh3OGZPSXlCd0cyWW1oOVJ4K0VuWHR2ejFyNE43Qy9JZld0S2FJZ0RX?=
 =?gb2312?B?dXNsdmRHU21Gcmw1R1pscXNQWE10RmVwajM4T0hyVUtXRkF6VklYa3N3a1dK?=
 =?gb2312?B?REFmTndOdm9QYmRGcHZ0V0d1UlBFaGdQbGJQeW9YemJxNERqdnRsTU45Wllq?=
 =?gb2312?B?Wkt4OTdUdG9aUSs3S2JvUGFQT01WRWRHL0N6bUZrS1N4bkZFLzUyVXIxRC9D?=
 =?gb2312?B?TE5MbnVHdUxqOXlCNkpQOTZsY2VVaEY5M0x6OGVzVXFCZzVITXovSnhrSndT?=
 =?gb2312?B?Um1KUUhKZDBZQkRRQTd1b0F1ZUhxS09VVXhYelZqYTA2QXBsMHg1dkFZc3RQ?=
 =?gb2312?B?ZXh6U2IrWlVvT2NZaDZEZ1dLSXJWSEthY1NoZTk0RVBIbVoyeHNZbU5KcHgv?=
 =?gb2312?B?T0tVZnllREl1dXliNkI2TXI5SytjMWU1T1pCbDRJSElmREQvZFI0blpybkpx?=
 =?gb2312?B?alhqWEpJNmhJa0cvSGZtZDZQYTJ5MGRJUFhLYTBVRDZkSmI1aGltazBGRkY1?=
 =?gb2312?B?NE14TUhsRWE4OVZxVnlQVHgvVGQ1SXNHOG9yL2NiWGlGVk1BQU40ZHp3OWhT?=
 =?gb2312?B?TXk3MWNldzUzOVVYTzU1YTBIVitGU1FKNnUzL2YxRDBiNzBpZjc0UEUrZ003?=
 =?gb2312?B?d2ltZmROMVYrL0x4eUtZVmxWYUkxVHpDVmVsNTdHYldoZ3dRaGJZZUhFVlhM?=
 =?gb2312?B?RXZKQXhRSjNOSHMwTmZOQ2czZ1FITTQ5MmNPOFZMcHJrWi9kTE43Sk4wRS8y?=
 =?gb2312?B?ZTVzYkl1YUM2T0N0WGdsNTZBZ3dvYTl0bTgyVzlhMDRROXYxeWNsM1ZPbWJw?=
 =?gb2312?B?d0lTNUhUZmt3MjlBc09QeE1JMVdjaEZZOGFOVjlMbmZpR0dBemlvNHM3Y0lK?=
 =?gb2312?B?SDMzQXpubFNtSno4V2FMTGU4VmkvYWUvRnVxeis5cDBUMTM1UWlycEtWWEhJ?=
 =?gb2312?B?MUJFRTZUZlVrUEFuZ3RUb2FYZ1ZSazJEaDFmUnhjTmxRalZNNFRyZXdiRkFJ?=
 =?gb2312?B?Nm9jUVQydjRJdnR4K0pKTVg3VW9nd28wZWxXc1l0WDZPZ1FuWWdpSEFxeUZF?=
 =?gb2312?B?NWJ2bW9uRi81U0dTclp1V2s4a2ovVGFhTEZ0Nnd3bkZkYkVhejhLNEZoNWNx?=
 =?gb2312?B?NjRWWkpIblhyN3daaW05OWc1ZXJkQ1hJVng2L0wvZHg0VUFjdVVXaHZKZUNo?=
 =?gb2312?B?S1BUb2RBZGZ0RTY5TlR4SlpSMGoxblJXT25JKzVYaXc0WEEzVEY3RnduK3lD?=
 =?gb2312?B?cWNlT1ZOTy8xMEQ0OXVwNkV5dTFCREc1bFQ0dTg3MzFFZGpDMU9YeElOekxk?=
 =?gb2312?B?c1d0VTdSN3dhVGQyTDJsU3B2cFA5aWl1YThQY0lBMVdsdkI2anZVNVdZeHVX?=
 =?gb2312?B?N3cvUk9oalFxVW9LNFZGaTRIMzV5UHdVRzYvNkQ4Mzh3YTRUQVBhTGFiSnJ4?=
 =?gb2312?B?d0tXZGZHV01FZjNJNFFXSWZBR0k4RTBnR0NjdW50eFpQU3E2UHIxaU5xbVhy?=
 =?gb2312?B?bll2NitoTVM4ZnVwcWlObi90L2NGYlBIVnFOSUxYcmtYWFFrUWdoM2dra2Fu?=
 =?gb2312?B?UElXYVZSUjN6TmM2NGswcG44V3BpVTVXZ1RPWVFPc3JZTnBJQStYTUFJZzd2?=
 =?gb2312?B?cENiYis0SnpFVzFtQ3pqd2UyemRxV0RLSURIOWVJRFJFbXl4MXc3L3d6YzNk?=
 =?gb2312?Q?UwB4GH0W1WliykqsDaC/UF3FVt8DwEZhHFKO2?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <197F085CE16A024C866D66FF57C136B8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416b7505-0669-4620-aa84-08da30315432
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 13:56:05.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPd1XqeYEo+SJZxsnbWYKavtADbjx7QfOhbnCoXWHNFl9OEjkOxqXHxx+pyQlt7zIQgIYLSeyHypRdl1hZLBluL/iRZfwfJY3gguZieFov0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2380
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi81LzcgMjE6MzMsIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIFNhdCwgTWF5IDA3LCAy
MDIyIGF0IDA5OjA1OjI0UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBJZiB3ZSBydW4gY2Fz
ZSBvbiBvbGQga2VybmVsIHRoYXQgZG9lc24ndCBzdXBwb3J0IG1vdW50X3NldGF0dHIgYW5kDQo+
PiB0aGVuIGZhaWwgb24gb3VyIG93biBmdW5jdGlvbiBiZWZvcmUgY2FsbCBpc19zZXRnaWQvaXNf
c2V0dWlkIGZ1bmN0aW9uDQo+PiB0byByZXNldCBlcnJubywgcnVuX3Rlc3Qgd2lsbCBwcmludCAi
RnVuY3Rpb24gbm90IGltcGxlbWVudCIgZXJyb3IuDQo+Pg0KPj4gV2UgYWxzbyBjaGVjayB3aGV0
aGVyIHN5c3RlbSBzdXBwb3J0IHVzZXIgbmFtZXNwYWNlLCBzbyByZXNldCBlcnJubyB0bw0KPj4g
emVybyBhZnRlciB1c2VybnMgY2hlY2suDQo+Pg0KPj4gQWNrZWQtYnk6IENocmlzdGlhbiBCcmF1
bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFlh
bmcgWHU8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBUaGlzIHBhdGNo
c2V0IGJyaW5nIGluIGEgbmV3IGZhaWx1cmUgWzFdIG9uIGtlcm5lbCA1LjE4LjAtMC5yYzQrLiBC
ZWZvcmUgSSBwdXNoLA0KPiBqdXN0IGNvbmZpcm0gdGhhdCBpcyBpdCBhcyB5b3VyIGV4cGVjdGVk
LCBub3QgYSByZWdyZXNzaW9uID8NCg0KTm8sIGl0IHNob3VsZCBhbGwgcGFzcyBiZWNhdXNlIEkg
ZG9uJ3QgaW50cm9kdWNlIHVtYXNrIG9yIGFjbCBvcGVyYXRpb25zLg0KDQo+DQo+IFRoYW5rcywN
Cj4gWm9ycm8NCj4NCj4gWzFdDQo+ICMgLi9jaGVjayBnZW5lcmljLzYzMw0KPiBGU1RZUCAgICAg
ICAgIC0tIHhmcyAobm9uLWRlYnVnKQ0KPiBQTEFURk9STSAgICAgIC0tIExpbnV4L3g4Nl82NCBo
cC14eHh4eHh4LXh4IDUuMTguMC0wLnJjNC4yMDIyMDQyN2dpdDQ2Y2YyYzYxM2Y0YjEwZS4zNS5m
YzM3Lng4Nl82NCAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIFdlZCBBcHIgMjcgMTM6MDM6MzIgVVRD
IDIwMjINCj4gTUtGU19PUFRJT05TICAtLSAtZiAvZGV2L3NkYTMNCj4gTU9VTlRfT1BUSU9OUyAt
LSAtbyBjb250ZXh0PXN5c3RlbV91Om9iamVjdF9yOnJvb3RfdDpzMCAvZGV2L3NkYTMgL21udC9z
Y3JhdGNoDQo+DQo+IGdlbmVyaWMvNjMzIDE0cyAuLi4gW2ZhaWxlZCwgZXhpdCBzdGF0dXMgMV0t
IG91dHB1dCBtaXNtYXRjaCAoc2VlIC9yb290L2dpdC94ZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmlj
LzYzMy5vdXQuYmFkKQ0KPiAgICAgIC0tLSB0ZXN0cy9nZW5lcmljLzYzMy5vdXQgICAyMDIyLTA0
LTI5IDIzOjA3OjIzLjU0NzUwMTUxMyArMDgwMA0KPiAgICAgICsrKyAvcm9vdC9naXQveGZzdGVz
dHMvcmVzdWx0cy8vZ2VuZXJpYy82MzMub3V0LmJhZCAyMDIyLTA1LTA3IDIxOjIwOjQwLjIwNTg1
MjY2MiArMDgwMA0KPiAgICAgIEBAIC0xLDIgKzEsNCBAQA0KPiAgICAgICBRQSBvdXRwdXQgY3Jl
YXRlZCBieSA2MzMNCj4gICAgICAgU2lsZW5jZSBpcyBnb2xkZW4NCj4gICAgICAraWRtYXBwZWQt
bW91bnRzLmM6IDgyNDQ6IHNldGdpZF9jcmVhdGVfaWRtYXBwZWQgLSBObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5IC0gZmFpbHVyZTogbGlua2F0DQo+ICAgICAgK2lkbWFwcGVkLW1vdW50cy5jOiAx
NDQzNzogcnVuX3Rlc3QgLSBTdWNjZXNzIC0gZmFpbHVyZTogY3JlYXRlIG9wZXJhdGlvbnMgaW4g
ZGlyZWN0b3JpZXMgd2l0aCBzZXRnaWQgYml0IHNldCBvbiBpZG1hcHBlZCBtb3VudHMNCg0KSXQg
aXMgYSBjb3B5LXBhc3RlIGVycm9yLiBJdCBzaG91ZCB1c2Ugb3Blbl90cmVlX2ZkIGluIGxpbmUg
ODI0MyBhcyBiZWxvdzoNCiAgaWYgKGxpbmthdCh0bXBmaWxlX2ZkLCAiIiwgb3Blbl90cmVlX2Zk
LCBGSUxFMywgQVRfRU1QVFlfUEFUSCkpDQoNCkNhbiB5b3UgdHJ5IHJlcGxhY2UgdF9kaXIxX2Zk
IHdpdGggb3Blbl90cmVlX2ZkIGZvciB0bXBmaWxlICBwZXJtYW5lbnQgDQppbiBzZXRnaWRfY3Jl
YXRlX2lkbWFwcGVkIGFuZCBzZXRnaWRfY3JlYXRlX2lkbWFwcGVkX2luX3VzZXJucyBmdW5jdGlv
bj8NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQoNCj4gICAgICAuLi4NCj4gICAgICAoUnVuICdk
aWZmIC11IC9yb290L2dpdC94ZnN0ZXN0cy90ZXN0cy9nZW5lcmljLzYzMy5vdXQgL3Jvb3QvZ2l0
L3hmc3Rlc3RzL3Jlc3VsdHMvL2dlbmVyaWMvNjMzLm91dC5iYWQnICB0byBzZWUgdGhlIGVudGly
ZSBkaWZmKQ0KPiBSYW46IGdlbmVyaWMvNjMzDQo+IEZhaWx1cmVzOiBnZW5lcmljLzYzMw0KPiBG
YWlsZWQgMSBvZiAxIHRlc3RzDQo+DQo+PiB2My0+djQ6IG1vdmUgdGhpcyByZXNldCBzdGVwIGFm
dGVyIHN5c19oYXNfdXNlcnNuKCkNCj4+ICAgc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1t
b3VudHMuYyB8IDIgKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jIGIv
c3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYw0KPj4gaW5kZXggY2UzZjczYmUu
LjJlOTRiZjcxIDEwMDY0NA0KPj4gLS0tIGEvc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1t
b3VudHMuYw0KPj4gKysrIGIvc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYw0K
Pj4gQEAgLTE0MjMyLDYgKzE0MjMyLDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkNCj4+ICAgCQlleGl0KEVYSVRfU1VDQ0VTUyk7DQo+PiAgIAl9DQo+PiAgIAl0X2hhc191c2Vy
bnMgPSBzeXNfaGFzX3VzZXJucygpOw0KPj4gKwkvKiBkb24ndCBjb3B5IEVOT1NZUyBlcnJubyB0
byBjaGlsZCBwcm9jZXNzIG9uIG9sZGVyIGtlcm5lbCAqLw0KPj4gKwllcnJubyA9IDA7DQo+Pg0K
Pj4gICAJc3Rhc2hfb3ZlcmZsb3d1aWQoKTsNCj4+ICAgCXN0YXNoX292ZXJmbG93Z2lkKCk7DQo+
PiAtLQ0KPj4gMi4zMS4xDQo+Pg0KPg0K
