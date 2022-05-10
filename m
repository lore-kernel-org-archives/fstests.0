Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF8C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 01:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiEJBm7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 21:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiEJBmN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 21:42:13 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F496275F4
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 18:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652146697; x=1683682697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1K8jA0xT69SICus1x644ktWvV9HuTtOQw7Fc4EjIwIw=;
  b=ogy271EpAFDJd8bbtjtHMclB3Dyi7CgNK3byufV/U7iCU7cdxTv8TP+c
   x6W0HikxnjXAKp/zf6In3DntI4wgOgJ7zZOhnpbmfkth5BlSB+JWXu1Qv
   5FEEXQXLDAwT68/fyYWaCTdQumaw6vc/kjaTNcq6p/sjwcCGXCp7KTbue
   tn0Z/B+hNx9apAAbQd2n/r/qywB2QZZ2Ugn1iVtb9c38vaWJBGNhaOGMs
   zU6U4V4O5sn8i1rhxxtGDOgbwGrF7wF3rqWmKV1/rbd/XPQtK7jD0zbKp
   fgY0YcuT5125rad/WV9OGECbvTMAyVx+Ihx6Ujb09HS2MfhlJ/PXXCq+R
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="55389725"
X-IronPort-AV: E=Sophos;i="5.91,213,1647270000"; 
   d="scan'208";a="55389725"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:38:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acK0ziyb4szerB9SeSJWp6AqIyxzbbc3XIxeOKcFRvmdRkSmPwqFrej3a/ZK9AAEF8QXF1YL07EvrH6FZDyPhcmHoOgSYkVJYtsnIP4aVhFWk5GWwY3UQfMGn5t4Ug/JdV39YfPHR+cjBGDXasGG0Y9Z7aZy4cwyENm1YVQVN713uWfnd2gtbAmaoFirsZalHC29s2LW4+xuYLiBz24TiBVtROpVsGTAq7OvzwDw0g8EdWdJ7H/v60PJjqCF4tNALPsgUEQIm+1A5L5pBocX3K9w/LaVDck0DFXgscmjBraXcP7Onai7rKtcI5jJqiVnNi8FFf5BCB1gO3pX4jmsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K8jA0xT69SICus1x644ktWvV9HuTtOQw7Fc4EjIwIw=;
 b=UD17n1u5/xVqFsOc5nItLGBeUTItdrr06/7Rd1qRfevYANq5EvEz2iKRKsp3KxfA/Low8Hr+rG3aXj3fpqGIhRurMbBZEuqFOJYgOM5AzSgS+yiHbB3Xzfw/ctha7QU44urF2xK8HGHcFUVlXTY3T1xDjF55vxUEgz56+7GZPXIn1UGsfPkiTWQB9JZQWcL//7sq/VKmqJt3Jc6ONnJqRhijMaobv/JctJg9kiQJlUQgR0GvdznAirEwtlr8fIkGOuLaLtAOdc+19Fwq/ioai24e8o1DUuHXd2ppGPvhctfL4zlKeg3/pChSRZfeLTGR1kz2xuZrXz9Vcgie8WF2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K8jA0xT69SICus1x644ktWvV9HuTtOQw7Fc4EjIwIw=;
 b=UUO3FyO8sbrqUbjV+m96yevFnCGHspwrM7qjKzJMyqqPP8LCtJMkHf6cnbgYJ3VNvy2obFFmNSQRAan/TOO1ZhzLP+ASHq0KKvHeYa/un0hRSmDego51SR8kQ3jyI25gkBGoKjxLmNy5RqDXyMXx0W9XtqxFZHgXg5hBPgRfS6I=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB5116.jpnprd01.prod.outlook.com (2603:1096:404:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 01:38:11 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:38:11 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Thread-Topic: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Thread-Index: AQHYY2mFplTGGpABi0u5nHWGTkNSTK0WjnuAgADY3IA=
Date:   Tue, 10 May 2022 01:38:11 +0000
Message-ID: <6279D03B.20605@fujitsu.com>
References: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220509134241.2jfkh2rkmcaxnhc3@zlang-mailbox>
In-Reply-To: <20220509134241.2jfkh2rkmcaxnhc3@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96ecbe5d-4e3c-4bf1-2f56-08da3225be6c
x-ms-traffictypediagnostic: TY2PR01MB5116:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5116408A7E6CBBC582C07269FDC99@TY2PR01MB5116.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vY7r8swY1rzk2IWhsv9QNOjGA2ClnJFl9zUdPIrGHT1pVffAngdgK53j4OQeXIii/M3q+NmF9ooR01oUAr6bR2kk/GFP6OuEYk+KG9nU8CWXWZ1M72HVlabdffaSuK9ZNPosrxB9vJfaOd6JdMJLpX4+ZMaTOURr0Q844lktriLXAsOtQXzNIWPDvRXZY9Uu5DxE2HAXJG4LVJkc0veMEnBjbFzSpOtciRGunZVJ5KTap7iRndJsJSPAI1JE1zvi2ayjl0ospCU9XprpGZtB00dQzNnUHinGxoWGw2a6i5+id9naLbNoRuGpFylw6GebMRhsCN+p8nOQOtZ03ZSTZYbz/6peLDsC0SVkNU2uX7jiGPvmlquTVAUzj0OMww97mm1rn1kyjIddj8w772Rpb9UwHmJdHD+EXZa3TUw9XONb8V41nIjHSPkaHVbhu5x2HgPGYcZNEIylniQ3WLb/rXog/nOItz6JNNIZEL8w8qw/BDzDKKlGTZqNMAJ4t2BDp8UFBho6qxeCZqcdhPDCsbYEJqRzWHdplsVKPAZgxUidFPjRy4Yh9/a2Os1zAOV8U20gWa7TKcKlIhieQoHnK/MXBCpXChcRvPo/DdzO17HiQAqve80ULNR5/UmOTSe6KKigESHCM43y7bEAQCch45oZW3zxmNIYbnW7QjdfRnqVQRR6CBDPXgFJo2Z6bFu6FPshOVji75YM5OhL6wcSxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(36756003)(2906002)(5660300002)(91956017)(33656002)(66476007)(64756008)(8676002)(66556008)(66946007)(66446008)(4326008)(76116006)(6486002)(186003)(38100700002)(38070700005)(86362001)(6916009)(2616005)(8936002)(26005)(6506007)(316002)(122000001)(71200400001)(6512007)(508600001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WEZsVFQwSWx1Z2V3L0xSOElXNC90YmZFQzRMTldyZkxKeDJCeUZHNVVtRU5t?=
 =?gb2312?B?QnhBdi9UckpRUGUzZTVlb293WGJGeE1uRzlJOXFZdk16d1ZkQTVZUzdCVm1z?=
 =?gb2312?B?ang0LzJhUlF5MnJGWVlwcStMRDN1NDVIMmtiMVE4c0szWjRLanp0aUpObTFU?=
 =?gb2312?B?c2puM3cyUmVPaTlkaWt3b1ozZ1UydnRSWUd6TUxHbVFBVXlwRjNabVJBSGVt?=
 =?gb2312?B?QTV3MmlQY1U4NHNJSEZhVVNEbmtjVkM1WW9oaWhUN2FZMlYrNmF4Nzd0ckNt?=
 =?gb2312?B?MFdyS1hlYjRyNlB2RVhaRXdKTXZOZzFodGs1Q2FuUW54OGNMbWQwUHllVWJn?=
 =?gb2312?B?NW5iR3c1SGZxUkZZRFNzMVlRd0YvZThhMjZmU0pjZW41bFhmMnVhaWxEY2tE?=
 =?gb2312?B?dC8wdnpGMlhWdlhVeGVhQ2Uyc3c4d2xNdG0rdHVqVTlKVGxiQlhVNmtTNTk5?=
 =?gb2312?B?OUFBNmZQOWphWWRaMk45bHo5WDFRUXhXYW9ucnFhZHRNTzdXellsMFlkRTE1?=
 =?gb2312?B?TjJFeVM2T1hWcXhSWkdXSW9BU0dza3JKYWp0VWVkY3lHZmxTeHIzdlltT1lB?=
 =?gb2312?B?N2svTHhjckFTU3BNcGM0clhQWWR5VUIvR3RCMTZERlBaQ2dqbjg1WFFaNnFV?=
 =?gb2312?B?b1MyUkY2NmxtcFpCbW9qK25jYm1IYTFIam1OZ0ROVUpENy8wSThlb3haN2dV?=
 =?gb2312?B?MkRpUGhzZW05QWg2TkN3cjBTbTdkTFhjN2ZZZ2tIT3NKT0xJZ0RqVjRzdmpr?=
 =?gb2312?B?VkgzQlduU1lXMXJZZFVZTlE1NmExWjUrbWZoYm5tQkh6UVFMcVVZSEJSR2tS?=
 =?gb2312?B?c3dxN3JEWjUvRGZtNWo3eDJFMEUrTWFmU2JqS2xvS0Z5TlFNdVhaWkJFWldN?=
 =?gb2312?B?Z2hPeVFjemFRMmVmaHJsYUtoWHYvMjkzdkUxNGMreDUzd2VtTlF4ZVlRQXlh?=
 =?gb2312?B?NlVNZ3ZMN1dEWlFUQ0NBaTJDK2FBRlVXQUdOMXFUS3BmR1VNRTg2SHgvL0dC?=
 =?gb2312?B?c1owRytOOUpyWXhsZXlmRzh5NWRhNkpUUjl6MzJCYVRVWkRxRG5YREFjSktz?=
 =?gb2312?B?L0FRU0VEUjhZeWdldmxkYklld0ZDaTZUdmhQKzJMa3JVSFRUc09tQTV2b252?=
 =?gb2312?B?YURvUjNvdVBDdEtpSzB3d1hEbUIwekNDZE1wRmtLWW1mNngycXZpU0p0OWQy?=
 =?gb2312?B?RityMXJrUTlNR21NOHgxMlAwZ0xEb29RbmdKcDRsUmxUWHdHaG5ZczFaODR1?=
 =?gb2312?B?NjBITEZ6ZXQ1VzVBOVh3NGk5OHdXVnc1TmpoTzI4T1Izd0ZkQklZL3VKeE5k?=
 =?gb2312?B?WEtMdXRNaThkTEw1cXpQOHlZOTlJRlFnWWs0M3Rlc3J4c0N2aWowcGk2R3k4?=
 =?gb2312?B?eW9JYncvN2EwZ2ZyMCtKbjE0OWgyNFdqeW05N0Fla2pBS1Z6bjAxNE5iZFN1?=
 =?gb2312?B?eWpPaTJmT0hNQjJjK3dNVzF0dDV0bWtNaGlWdVU3UGV3aWhITEhSKzNkV3E5?=
 =?gb2312?B?UWp4UUc2UVdCNklqTEVkc3hyWTMxWGZVTURDR2JraWlTemdlaEFNaWFTTjBV?=
 =?gb2312?B?K2U4WVNoSGdjdUZKYUZKOHJKQmR5VWZCMXdRSDBTVWdUS3R6RTB3eDdqdXFG?=
 =?gb2312?B?TU92L0RXNFZ0WFpkbnBvT29FU0xQZVptSVRLNzI3enpNbkRQL3c1c0FhZXlF?=
 =?gb2312?B?VHlnaE1mcTVGU2trOXhsNzU3emlRQVhqV29KVUxSeDdLcHpjeTREd0UxQjFs?=
 =?gb2312?B?UUlrY0pPT2M0VTR4dUYxRzRkZVlIMjlQeHJBL0FCYmZoMDBJWDdncTlhN0hu?=
 =?gb2312?B?enFEQi9Ld3QyTVdJSS9JUHJRcENPZG8rTWhJcXE1K2NRUkl6WlNvdXk2VG5p?=
 =?gb2312?B?dnRWbFhiK2Z4a3pJTCtiaGpvQ1RnTjZ4Q1JrWW9SQVJCNVUvUHV1THJLc2Rx?=
 =?gb2312?B?ellCaXphb01VTjkxUkQvdCtWa1YraEk1ZTlIWTdSUkVmdmNIelpES29tR3hG?=
 =?gb2312?B?OW1oaWlOa0ovRFpWalpEQkE4T3crTnJ2QzFkQlpNaTlQZW9xWHhieFo2dlgx?=
 =?gb2312?B?K2M4a0VtdHFsby9LSzFjWjJxL014aFhFenVGN1VXRWNkN1JLUW5ISVlzYmR4?=
 =?gb2312?B?MTlNcGZOVHBOYUducHNyRkg1Y3BQRkhxTkF0azZ0UDh2VTlOd1YrVEdaMEdM?=
 =?gb2312?B?Z3MvcGdzc0RIVEVQMGxyejJacGltMFdwMTBtZytuaW1Od3pEd1JxU3JwWDFX?=
 =?gb2312?B?K3BXS0crOGwybTc3V0sxZG9SN2VGcGhQWWdjZzlyMkYrSkZGdkg1eG1udW9z?=
 =?gb2312?B?YXIrYjRXY2VHR09lOHVjS2VjaDZRYXhaRFNSb2svUW5mOVAxZUs4M1A5NzJs?=
 =?gb2312?Q?/bbc/2NII/h/BK0dfznn7zHSmXfbAN6puaNjH?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <D7524D3A723C1E47B0E1125A813C2E6C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ecbe5d-4e3c-4bf1-2f56-08da3225be6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 01:38:11.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiqogqMJFMyXW7pJwFR70QwEhdEcR+YjAOk+dlRdqZ5WKFtJmjgfhTPE/HSMLREUhimsFGR+dRj8bSrBebtZxZHeqk7mUNBUNwe9tPVNyTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5116
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi81LzkgMjE6NDIsIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIE1vbiwgTWF5IDA5LCAy
MDIyIGF0IDAyOjU2OjU3UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBXaGVuIHRlc3Rpbmcg
dGhpcyBjYXNlIG9uIG15IG1hY2hpbmUsIGl0IHJlcG9ydHMgdGhlIGZvbGxvd2luZyBlcnJvcjoN
Cj4+IHVtb3VudDogL21udC94ZnN0ZXN0cy9zY3JhdGNoOiB0YXJnZXQgaXMgYnVzeS4NCj4+IHhm
c19kYjogL2Rldi9zZGExMSBjb250YWlucyBhIG1vdW50ZWQgZmlsZXN5c3RlbQ0KPj4NCj4+IHNj
cmF0Y2hfdW5tb3VudCBmYWlsZWQsIHNvICBfc2NyYXRjaF94ZnNfZGIgcmVwb3J0cyBzY3JhdGNo
X2RldiBpcyBhDQo+PiBtb3VudGVkIGZpbGVzeXN0ZW0uIEl0IHNlZW1zIGZpbGVzeXN0ZW0gaGFz
IHNvbWV0aGluZyB0byBiZSBkb2luZy4NCj4+DQo+PiBUbyBhdm9pZCB0aGlzLCBqdXN0IGFkZCBh
IDEwMG1zIHNsZWVwIGJlZm9yZSBzY3JhdGNoX3Vtb3VudC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMv
eGZzLzI5OCB8IDEgKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvdGVzdHMveGZzLzI5OCBiL3Rlc3RzL3hmcy8yOTgNCj4+IGluZGV4IGIw
MTUzZWJmLi4xNzUxMDM3OSAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3hmcy8yOTgNCj4+ICsrKyBi
L3Rlc3RzL3hmcy8yOTgNCj4+IEBAIC01MSw2ICs1MSw3IEBAIHdoaWxlIFsgJFNJWkUgLWx0IDEw
MjQgXTtkbw0KPj4gICAJcm0gJFNZTUxJTktfRklMRQ0KPj4gICAjIHVtb3VudCBhbmQgY2hlY2sg
dGhlIG51bWJlciBvZiBleHRlbnRzIG9uIHRoZSBpbm9kZS4gU2hvdWxkIGJlIDAuDQo+PiAgIAlj
ZCAvDQo+PiArCXNsZWVwIDAuMQ0KPg0KPiBIaQ0KPg0KPiBBY3R1YWxseSBJIHdhcyB3b25kZXJp
bmcgaWYgd2UgY2FuIGFkZCBhIHdoaWxlIGxvb3AgdHJ5aW5nIGluIF9zY3JhdGNoX3VubW91bnQs
DQo+IHRvIGF2b2lkIHNvbWUgcmFuZG9tICJkZXZpY2UgYnVzeSIgcHJvYmxlbSwgbGlrZXM6DQo+
DQo+IENoYW5nZSBfc2NyYXRjaF91bm1vdW50IHRvIF9fc2NyYXRjaF91bm1vdW50LCB0aGVuOg0K
Pg0KPiBfc2NyYXRjaF91bm1vdW50KCkNCj4gew0KPiAJbG9jYWwgbg0KPiAJbG9jYWwgaXNfdW5t
b3VudGVkPTENCj4NCj4gCV9fc2NyYXRjaF91bm1vdW50PiAgJHRtcC5zY3JhdGNoX3VubW91bnQu
ZXJyIDI+JjENCj4gCWlmIFsgJD8gLW5lIDAgLWEgIiRNVUxUSV9TQ1JBVENIX1VOTU9VTlQiID0g
InllcyIgXTt0aGVuDQo+IAkJZm9yICgobj0wOyBuPDU7IG4rKykpO2RvDQo+IAkJCXNsZWVwIDAu
MQ0KPiAJCQlfX3NjcmF0Y2hfdW5tb3VudD4+ICAkdG1wLnNjcmF0Y2hfdW5tb3VudC5lcnIgMj4m
MQ0KPiAJCQlpZiBbICQ/IC1lcSAwIF07dGhlbg0KPiAJCQkJaXNfdW5tb3VudGVkPTANCj4gCQkJ
CWJyZWFrDQo+IAkJCWZpDQo+IAkJZG9uZQ0KPiAJZWxzZQ0KPiAJCWlzX3VubW91bnRlZD0wDQo+
IAlmaQ0KPiAJaWYgWyAkaXNfdW5tb3VudGVkIC1uZSAwIF07dGhlbg0KPiAJCWNhdCAkdG1wLnNj
cmF0Y2hfdW5tb3VudC5lcnINCj4gCWZpDQo+IAlybSAtZiAkdG1wLnNjcmF0Y2hfdW5tb3VudC5l
cnINCj4gCXJldHVybiAkaXNfdW5tb3VudGVkDQo+IH0NCj4NCj4gVGhpcydzIGp1c3QgYW4gaWRl
YSBvdXQgb2YgbXkgaGVhZCwgaG9wZSB0byBoZWFyIG1vcmUgc3VnZ2VzdGlvbnMgZnJvbSBvdGhl
cg0KPiBmb3Jrcy4NCg0KQW5vdGhlciB3YXkgaXMgdGhhdCBpbnRyb2R1ZWQgYSBlbnZpcm9ubWVu
dCB2YXJpYWJsZSwgc28gcGVvcGxlIGNhbiANCmVuYWJsZSB0aGlzIGZ1bmN0aW9uYWxpdHkgaW4g
X3NjcmF0Y2hfdW5tb3VudCB3aGVuIG1lZXQgZWJ1c3kgcHJvYmxlbS4NCkJ5IGRlZmF1bHQsIF9z
Y3JhdGNoX3VubW91bnQgd29yayBhcyBpdCBkaWQgYmVmb3JlLg0KDQpCZXN0IFJlZ2FyZHMNCllh
bmcgWHUNCj4NCj4gVGhhbmtzLA0KPiBab3Jybw0KPg0KPj4gICAJX3NjcmF0Y2hfdW5tb3VudD4v
ZGV2L251bGwgMj4mMQ0KPj4gICAJX3NjcmF0Y2hfeGZzX2RiICAtYyAiaW5vZGUgJGlub2RlIiAt
YyAicCBjb3JlLm5leHRlbnRzIg0KPj4NCj4+IC0tDQo+PiAyLjIzLjANCj4+DQo=
