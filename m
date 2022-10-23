Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C981FECAAA1
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Oct 2022 06:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJWGmh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Oct 2022 02:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWGmh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Oct 2022 02:42:37 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Oct 2022 23:42:35 PDT
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED974CDB
        for <fstests@vger.kernel.org>; Sat, 22 Oct 2022 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666507355; x=1698043355;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qO013uyRQSJ8WghQmhxu07LVV3FiozKD74p1aaTkB50=;
  b=LIzL8W0bEt52EvfGceXWuL4zS99kFKsQQp+0F3KYCLDhXV/c5qQXfteT
   Cgy8eXdjvbzmM9uEEaqfSim7w8ktyvocIvLUdiSeOQSwxU2nPjL9RUd2w
   8O/98qYAokoEViHHw5mlsUqNUrh804uxs5FOWZu8KmWbCwwaG7pzbj2V4
   Gqm4ZzdjXVbSCbyaUQ9RokAO6WLiBXGqbmr6QVzB+UjSK0Z0W/hI6U6xd
   yvIwVVBnNHvZ5+ZvyzQQM+85tKCwYVH2lbb+Xj5xKzUImrMHwNq8JiXSX
   VP3SSE+drC55+t1P65UOch495AXAEj9SgZAmPCBjXcJ0cTSx//JcIp05m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="68289482"
X-IronPort-AV: E=Sophos;i="5.95,206,1661785200"; 
   d="scan'208";a="68289482"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 15:41:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/QkmbVtcVB+It1YysuZtwy6RKx9NCioox4+NthxACv5SgjCaDZHtfD4hgiuUl3K3cCWTB8qXpLZF36A1hmYhklfSevnja676XwBC6AVlgvj4qqZLbz8GeOmhNYJykdaj3/7VVZ9oeL7ysMhRa0tme2wDjamG9+g6PLi2nI4xvrlUL37qeog8+dtH4gSUuxlFEKfoA24QwXaVEXEOfe+iNPHDXE1EJ5ACotU0o8WGX2Ymado2fGKThWLlCHs7pW4epmRVffwxaY268S/ZNgeK0J6U6zSZdwcHuEb4sudTKe/j5o2GHDmYlNHf1vi8dOzrlWQiSff/WZat7CmlZ8ELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO013uyRQSJ8WghQmhxu07LVV3FiozKD74p1aaTkB50=;
 b=h7WoLXYXe+Nw8n00l6XjH++f7MYmwciYeh7uTCZlsugsWMqspIp3BkMyEZn8bW5wPhJWnlJqCVsN8EoVyXuraEpiaWIfEE0hHeYCIJWQBkOBx0dUYnC2Fv7GBg+31n0MdF2QDgDXlHD4Duf+0YgvaTMKTxuEWisrFIBkSJmegh8T89lYQ3wRNOehnyz9meknU4l6e50U0R4hUu5OQVRIVeJnVeQWkpVSE9frIig74vf3hC1KVqqpWj9rjwGSFO9ge3BNRQHioXynaCTGNzzaaXlrwxz8Ya+jog1a82DRNIe+pQuCxoV66A0lJjSR7FheKvRDcZCRcqk15EIAm2PiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB10026.jpnprd01.prod.outlook.com (2603:1096:604:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 06:41:26 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%9]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 06:41:26 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "zlang@redhat.com" <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH 1/3] common/dmlogwrites: Extend _log_writes_init() to accept
 the specified size
Thread-Topic: [PATCH 1/3] common/dmlogwrites: Extend _log_writes_init() to
 accept the specified size
Thread-Index: AQHY5qp5A1yh4jXncUaFs/jwsVXS4Q==
Date:   Sun, 23 Oct 2022 06:41:25 +0000
Message-ID: <20221023064122.846926-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB10026:EE_
x-ms-office365-filtering-correlation-id: 4a3fa1f8-8295-4091-b066-08dab4c19bb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRH0zAWjJIe3hfFwk7W44m8Ed/N6O406fDAZHJGpqPkECtwwMYaiMQZ5Dw0yvfFz98O3rk6KBkedYuawQXa6e7mFQmqUN0nvZ3MyWEk+VJj+4pyg+JQu2qS/wPYYK1UeluNRo6r/CTxiphSz4DQpKyaJ9GRtk7KIsv654Ym0U+m5RSwEcXfuWmvx0Bq+wqznqNJOTu2xr3leO49nFnn9XU4EWZ9sDMiEj2oGdsSFMeD7s/llVz47BtVAgFnOUrPXTd5nz6raqoxqhK7B/YOfAk5mWo1j2vIBj9IO46IGniBWBiaTztktpIzfB5ArCzPYd9Askw/Ypi3lPAb2JuBO8b2Ia3HVaibwBPNimG/QzoMl68BKT08kbgTt86dBYTA0JMcDp2qyLCNizkEDiFvgTsNswDjMDsYZ6QE75VLlXtWiwp5xAp6oF1d8yeH+xZrp0R6hFpGRA1WKkvIPwpR1fHTCQfxKDHhOMJu0axHeMVAzitWsqiFZkAb0phhV6zlTBo16+ZdIiPXSaqS2L0juqqJDHfP/GDbCfGc6/uWictBcMEE+TOyO25KcBMA89evT8YaxYstinszpNpfpb/kkeznNUdJQAZFCfItQRT3HdiadwZDC/mM55+SarhBTRe5taF9gUPw+e3HJ2NmpT1fRkUXMEZQCp46OB5ztbycjO1tEXMh3ENEJHWYaPwhaIuhKfZOmjmjvCPdYURj/ESfo2BGq7dLuLAhgIAXpE53ZAqL+UG6+zCdBF3fxQUyIcPDm2dRcKQdNxOEtZM+x+LVele9iVp8N39C6p7bpfOMoJws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(1590799012)(478600001)(122000001)(38070700005)(6486002)(1580799009)(71200400001)(54906003)(110136005)(316002)(26005)(8936002)(66556008)(8676002)(5660300002)(64756008)(76116006)(66476007)(66946007)(66446008)(91956017)(6506007)(4326008)(85182001)(36756003)(41300700001)(6512007)(2906002)(38100700002)(83380400001)(2616005)(107886003)(4744005)(82960400001)(186003)(1076003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZEpYNnpETU02NXRrdWpnK29OajBnU2Y5RlV2cno5Z1ZpdmFIRGdQS3gxcEdx?=
 =?gb2312?B?YldvcGlLUWlqc0l2bHE1NS9JcUhmSmQ4NmxCcGl1ZkdEZTVEVkVWRG0wM1lN?=
 =?gb2312?B?dThvTzdkOWhUUElkbHRoRE1rNE9FemFZcmRHS2VmL0hzWnFFMkIyaTA2VEhF?=
 =?gb2312?B?YnhiMGVSVGJvbTl2aDVVbkVybWVyTk0rUDFaVkZnMTZDY01NWjRlakxQZHl0?=
 =?gb2312?B?YW1BYTViazdtbkdxa3grVk1HOVVNbGV1TCtNUzZyOHFNQ3NZcUJjSUxvQkJt?=
 =?gb2312?B?TzIyUEgweU1wZWhteEMvdkw4Q3FmdGpLZGpBK0h3dzZJeUJEbFRHZ25aeGhy?=
 =?gb2312?B?WnA5WlVBem1wc2ZoR0h3TWV6Z0ZUQkdQLzBCNEUzOWdraHBWMFJOOFZCYmV5?=
 =?gb2312?B?QWJjR3JqYzhlTzc5RlBTVncvM2ZqWDEwQ0dxTG81YW95emQ5WW82WTRkVUp1?=
 =?gb2312?B?d0plU0ZrdFBscDFnaXJKVUJ0SzdOZnRIcVRJOVRQRHpySGw5MmhnTjRFWWVi?=
 =?gb2312?B?MmRGZ3Nid2ppUHM3SU5hZi9pRGVDa3dMbHUwQWxvbjRSVXIweWlxcEs2bE5y?=
 =?gb2312?B?MlBDSkpEVjRkSkZLelhpcC9wZ1lWSUxHTFAxaUZZS0NlanVudU42NWVZZUt5?=
 =?gb2312?B?SWFOWkM0Z0g2ckV0MXhybzliREtNUndYUDNKZjJwaDdxZlpYaTVZdTJGNDBz?=
 =?gb2312?B?UTdUSzlVOUdQM0xzdUdlOG5zU1BsU0U4eW9zSGlrLzZ4ZWtJeVRMM0pvaUkz?=
 =?gb2312?B?QVBCRnBDdEhOQm5tOWFJaTBDblN4OUQ1bWlwbkRYRlVrVXk5MUpDK3JNNFR4?=
 =?gb2312?B?eWx4amFGdi9DNC9RVXU4MFhyVGlKUE01TVk5Uk5Sa0Y1eTlVaGFpL1hxSzZE?=
 =?gb2312?B?MlNNVlR4TEZ1NUlzTlZMVDZ0dFh6RTNDWFQvVmtlRXZHeU52MkViR0VDdDNn?=
 =?gb2312?B?Vm1kKzdIeUVDcVlCb2JLaW44ajZSb1Y2eTA5dC9kVDJ2S1AwWDh1ekdreHcz?=
 =?gb2312?B?YjBjSEhrcGdpRzd1d0NkSFUvRFdIa1p2b0dPcDFrb1lsYVovRmNzVkVRUWpO?=
 =?gb2312?B?aXVlMFo5a3oyNmdoNXJkWnRjdm93eUhoTlhjSUhoeVRUWDhsY3FQYTNDUnpz?=
 =?gb2312?B?Um1uSGVoaTNlM3FLS2NQUFh6c2lZUEhrN2dqN2ltdEJZNHZQeDZHVU00UHlz?=
 =?gb2312?B?czU4Mm8yZGMzVWdxUWI0UXJHc3NMTFJubEtsdHFRUDhpZlI1TGtTS29iZXcr?=
 =?gb2312?B?T0h5eDdxcjJWM01GckVXdVlobmp0ZmFJbFBlb0Nzb0NReUFKRGltVG5rbEtE?=
 =?gb2312?B?Zy9TdExnMHNXUUJXSHVUMU5mOTNjRmx0amwyQUlLcDJaU2g3dXpiWGtRSmxE?=
 =?gb2312?B?NHZISzllL2RkYkU3VDZMeW1pc1MveWdCeVg4RzVEMDFNeXVQN09NQ2tHT3gz?=
 =?gb2312?B?VGhOSFNVc1ZObnpxWGNzK3dRcXFCS2t2TCsyMWI5bitONXZyYmo1byt3TXBk?=
 =?gb2312?B?dVdmZWxmdTQvZnRyQktHUUNSd3RQRTFrNy9BdExNRXovK2lWa2J5TmhkdUZ5?=
 =?gb2312?B?ODNVeUltNUtSMHMyc3M5eGErOE1IVXNYbnhXODRkcVgveiswcWxYUk1MV0I1?=
 =?gb2312?B?bk1mNjVoby9FTUZ0a0JiekVTS1FOai9uYUdrSWhsbG1hWGMzcUZSVjhZQXc5?=
 =?gb2312?B?akpCRGpmVVRSWDB0Tjg5c1RzMWdIYjdVN2dVRzJQdDZWSkdkbDMzcWl2QWpu?=
 =?gb2312?B?VStNNTJiMW9WRGlvWUY4bUF5aHl0WVBEQ1ZERWZZbUxZeVZYdmp4OG95RnVR?=
 =?gb2312?B?bmdHMWRNOWIyL2I2RDhMbXZ3YUxuRDhIVEtXY2NKTENld2pEdTZvcER6S0Rv?=
 =?gb2312?B?WkVZRGd5Q1h1Qk5GUjVOR3RFKzQ3Y1JqR0JCc3NIT3M0NncxWUpkQ2tJVmNm?=
 =?gb2312?B?Rm9sR1AxSGJndzA5bTdSSUpvOWcrVWc2ZU52SVdialRieDAxM0FWRnJIUHhF?=
 =?gb2312?B?b0xPT1BUd3ozeURtSkxTZHk3aEVBdnYydUg2aEhRVzcyU1FJTlNJaWl6aDNv?=
 =?gb2312?B?YWsySUswME5veEt6TCtpQUFxa2pKNitiWEx0VGZ3dkN0S2pRVWwzN0JsSERk?=
 =?gb2312?B?bWF3R3lha2ZGV3FRbW5YUVdEajFSeUZoT1R4aXc2dEpFRDRsTjhRNUhaajJM?=
 =?gb2312?B?R2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3fa1f8-8295-4091-b066-08dab4c19bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 06:41:25.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEYX1YDmv5xn4Xf4cJ8U5e/COHVgMFi2Bz2Jxl37EwR1K760Y3rZsHf4CukU0Exw3tCyCuCpKK4rrmRzPjFVHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10026
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SXQgaXMgdW5uZWNzc2FyeSB0byBhbHdheXMgY3JlYXRlIGEgbG9nLXdyaXRlcyBkZXZpY2UgYmFz
ZWQgb24NCnRoZSBzaXplIG9mIHRoZSBlbnRpcmUgdW5kZXJseWluZyBkZXZpY2UuDQoNClNpZ25l
ZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQotLS0NCiBjb21tb24v
ZG1sb2d3cml0ZXMgfCAxMiArKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2NvbW1vbi9kbWxvZ3dyaXRl
cyBiL2NvbW1vbi9kbWxvZ3dyaXRlcw0KaW5kZXggOWZhMWM5NzcuLmQ3YjIzY2VjIDEwMDY0NA0K
LS0tIGEvY29tbW9uL2RtbG9nd3JpdGVzDQorKysgYi9jb21tb24vZG1sb2d3cml0ZXMNCkBAIC02
MSwxMiArNjEsMjAgQEAgX3JlcXVpcmVfbG9nX3dyaXRlc19kYXhfbW91bnRvcHQoKQ0KIA0KIF9s
b2dfd3JpdGVzX2luaXQoKQ0KIHsNCi0JYmxrZGV2PSQxDQorCWxvY2FsIGJsa2Rldj0kMQ0KKwls
b2NhbCByYW5nZT0kMg0KKwlsb2NhbCBCTEtfREVWX1NJWkUNCiANCiAJWyAteiAiJGJsa2RldiIg
XSAmJiBfZmFpbCBcDQogCSJibG9jayBkZXYgbXVzdCBiZSBzcGVjaWZpZWQgZm9yIF9sb2dfd3Jp
dGVzX2luaXQiDQogDQotCWxvY2FsIEJMS19ERVZfU0laRT1gYmxvY2tkZXYgLS1nZXRzeiAkYmxr
ZGV2YA0KKwlpZiBbIC16ICIkcmFuZ2UiIF07IHRoZW4NCisJCUJMS19ERVZfU0laRT1gYmxvY2tk
ZXYgLS1nZXRzeiAkYmxrZGV2YA0KKwllbHNlDQorCQlsb2NhbCBibGtzej1gYmxvY2tkZXYgLS1n
ZXRzcyAkYmxrZGV2YA0KKwkJQkxLX0RFVl9TSVpFPSQoKHJhbmdlIC8gYmxrc3opKQ0KKwlmaQ0K
Kw0KIAlMT0dXUklURVNfTkFNRT1sb2d3cml0ZXMtdGVzdA0KIAlMT0dXUklURVNfRE1ERVY9L2Rl
di9tYXBwZXIvJExPR1dSSVRFU19OQU1FDQogCUxPR1dSSVRFU19UQUJMRT0iMCAkQkxLX0RFVl9T
SVpFIGxvZy13cml0ZXMgJGJsa2RldiAkTE9HV1JJVEVTX0RFViINCi0tIA0KMi4zNC4xDQo=
