Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20DC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 17:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BFC61157
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 17:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352327AbhIHRGs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:06:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17349 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352400AbhIHRGs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Sep 2021 13:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631120739; x=1662656739;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=duyoKrMuBRKYgIbv8AhHIXZuwFxSbc/6oVHnl6SZUJdl5HaIs5l2Fubz
   rVl358hdA8J8xaB8lfTH1mAfQhwakhmACUvnpH6wjxuDfrvqqciA7qQ7P
   rwHf5IcenFhLLN9XMfAzZvGvnxjkwuBCw/ljTZwB5xJ/6um7WkRZgicn5
   6pXtzwryVOMcFi6+T1wBUp3SXFxRXiNtFeiTQJ7xJ4C4tkVIrLp++aVIG
   pLt3H1OKkgnEbhj/zuq+SuzPp3FjX1tvB4t3BLzkiOnF2tpkJxLlL05Dm
   nfGq/gl9rz3ySuQ8jj1VKebbUDq8GaTEuNdPufem7I5V09WsFLX2D+UQY
   A==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="184280705"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 01:05:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTLFUKVWONw+9XkcL20sBHjrc/+QvXSHmbd+0CYlpdM9B51T2XvAPhGWRsqxq+rq+KtFbFD9k10azYhCgiQUzrM9PQQ0H7n3sx2cfWUZvRk0HrtEN449JZ/9w7zZRGR9D4NWGUM/e4oK1U5jky/GvkR/PpQ625XVfszSV0sUxxU3SmXQD7axXTEG+jvjQYbLmB8BCUXbBfo7peBxnDCAJbYpNObjkosOfFNKKgZQLUVC4+rNq1u/LRNYhS6D8GsQkeJ+Eqaj03GKDYb7fbiMmIDGn3CfxKg9W1J86ggkuCxtgHWz4PmvSiLFs7SQ65s5ezE5nC/Z3qOKNbXErfc/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VKMi/j/bO0/oCQneQLFdzkeDqr4BJzCG4foN78lqvvadHnixP/i1Hlu9g4vgV8l7u4ShZXgOpYSMT4MS5+kwPwaZw43fMDMeSoNAlm7uEsqIw7hQTT9ez7moxppSNAGxcsCJeQ8y/lXIqQPIeXdYMe9P1dT/yliGKVJSwaItbBbelIJiVamLJqhu/1roq9Qy2yjyax+XNhSJply8KmNL3kHcinjEZLVG48C9R03zSNkdRkO+sYwDKpn2BsWZr2nGCn7B3hIfdVCjblx0tAe9OvP/oy36GY7FjbA8BLvTM+842HeYbzGV3nS1syirfHSzNo6+5IFdl4HDNGqWnyYnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FMavCV/hv7rwy3Dm2j1JEunqUlXwgtebDsBY+qAicshwjanD48YPdWc4w5irL4tVL7vnuU4TpD+3QEMUdwfXfmljjT5zkc8kWMn06eDcHG1E4HGTp6VRKVlhBxGwFRGz/tW020RPnTmBNXKofFNipg54Z2cg0M9Zj1Vx0rwdmgo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7413.namprd04.prod.outlook.com (2603:10b6:510:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 17:05:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 17:05:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 2/3] btrfs/146: Add _require_scratch_dev_pool before
 _require_dm_target
Thread-Topic: [PATCH v2 2/3] btrfs/146: Add _require_scratch_dev_pool before
 _require_dm_target
Thread-Index: AQHXpIy+2y4GWb0pVkiPTKy0ut78Dw==
Date:   Wed, 8 Sep 2021 17:05:19 +0000
Message-ID: <PH0PR04MB74165CE8DAB0FE1CEC1605FC9BD49@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3cbd2e3-562b-4eb0-9955-08d972ead6b0
x-ms-traffictypediagnostic: PH0PR04MB7413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7413E13079EBB7E92239E4699BD49@PH0PR04MB7413.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4fKqV2pWWxKe2JOL+0g/8iIdJDbyPYFtEX2tUlG2Duq8a4vrL9F8QnBFutYQRmaK1n001x/L7BA8e0CLDbT8t5/eSgsdE7PoRGk6dgoy6Qixe2tcEbbyo9HU5SUALW5m/LUL03+3vLIvcIq6z/w13F0C6UcmaG0VQvnbYnszFTXNHGYbMtKUShy8bciEh9viKAQP3jwG17w2sig4MGpR0AJYkQlZf394pJEVmdUnuan6cYN5EEldqGrtIoNhwRxhpx4RgjyBBcvHJpENLb6bZxVBxQ7+zRWpuc+EHQ/h4cxF2HFwnAv7kEJH0s8heFJtH7Pa24Gn/iDyktKCJ0csjIck2SaC9SZOuc+g6IsFjt39TGI9JdfkkKdJGSYRDGRV+3GoNcLNtRtFQY2uq56Lq3G88xbFwTdDnPJ/qKFptn+Kd9vLDinHEv4txPf4AzFkVYLRxNE30+QQQqoHFRI11HoleLLl7L2n0S5G2UthUcvNfV3EBtzHpTIYikwemHrgRdFURyus6+yoGUEXCquEPfQJMRjYSItlbqv4961dmu4XJa0pLsFXZM9iAbIEiJ6ydDAEC/eYsuzjiU9VdYmMeYKCKeb15F461aXe6G6fekRZDVp9olNsBSGiDLE7rigBbqIRT2TskXV9QHPeCMW8H6xz922jqr2LnGDERLxjI+GJmrglkRtGJoMzXhnGFlSNDjdFw/fI0+E4Yn6gHro3QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(2906002)(4326008)(91956017)(8676002)(38070700005)(122000001)(478600001)(71200400001)(38100700002)(186003)(7696005)(76116006)(110136005)(26005)(9686003)(54906003)(5660300002)(4270600006)(316002)(64756008)(55016002)(86362001)(19618925003)(66946007)(8936002)(33656002)(52536014)(558084003)(66476007)(66446008)(6506007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e5Qy7smqo/6g4i7uf5kLghPfTH1HgWQN13gL61oW4twL5O0f9TeJ9T6qRu+2?=
 =?us-ascii?Q?LG5ikIPDgwywPIemUeP6XRJ4h+KwC4vM/peo3awReBA+zAv2oRxVDDsGWy+e?=
 =?us-ascii?Q?3GeC7hR1fYAdto1VDr9QVXHgxq3TsMig0nBaGv7lYiLUpzIgZbGVR8Eza0Wx?=
 =?us-ascii?Q?el4duy6tD2DJ+AiRBDDT+V2BvSIejJ7KinZr+X3hwYp3VNDPaJ5xDuPb2dcD?=
 =?us-ascii?Q?PcCV3vHaVKy/za81wqEC+depvTY0RMBQYNm2PhPJJIVzdgSCK0Tm7cIYieDp?=
 =?us-ascii?Q?NmJU4XyhPVZs3zpsZ81o7A4T8gz03rgg1yR1NY3G6rN6j1PUuAvIVjbVsyak?=
 =?us-ascii?Q?9eq/4dzG2+WArcd6rYFBBYkBJ3xRcjI+9rm+E4m3LXTxdLNzzNqQHNUdmAfn?=
 =?us-ascii?Q?3b29yaDt7j7kTMpmJ3GNkSAWHFeFBM3JiqhwRH05RX1D+gb1MnlmV7/UAFwQ?=
 =?us-ascii?Q?pPcu2dAnKGzElyQPRdQFPQeDIN5aRZi4QlhKJJjXBFcbAc97Eg65dhFKw/Ed?=
 =?us-ascii?Q?JrdG6rwKEyukrRZErL1dguiMvBnTjVsYJNZcQzgZ9qIt+9zM0GEwhvUvKvhd?=
 =?us-ascii?Q?UqQfHbC0D7bpaxt44SznILtLxY57OT2Zf7ZnwgqhSZ7kW0Um2PoepwZgiNdP?=
 =?us-ascii?Q?/1U4RMXT/VJRn+ylDV2sQx7FozMoruEDoKROrFsvq3noruOPtjDn+P+N+NbZ?=
 =?us-ascii?Q?0x9x3kL2A6jGbe1B7G084cQUCFG2StlFRUODfqz7iYarQ/VG4twR4BpQ0ynh?=
 =?us-ascii?Q?JcaM2vPjXa6FYwiUkaTJweEABec0DUE5UZdyTMhWjfX9VxUaQc70j1T0ObEi?=
 =?us-ascii?Q?LwAhhYGi8WqZ5n1MJvTw3LMB/VUwhYDMEh6G5U9iX63yK4AhZPMYL70hP/vp?=
 =?us-ascii?Q?olm8RP8blet9Ee7BYMlhiTtukd2a4g0dEqrbka7t6NQzhD0kW7JEmQL25kRm?=
 =?us-ascii?Q?jGQT9W5bsLk4OnXV1XTwNkXEO+k6HjjnfVt+T5A0/SSucvI5XA+j4sxsZ0x7?=
 =?us-ascii?Q?RcfnAa9xpvt9A/vI7Txi5f8g+WodW65JXNIhA1JqRVBJCFCXt2kqjnYofDCU?=
 =?us-ascii?Q?zN+3Ce4NbGUvbM0IXlI6f0WZCg/m3sYWp1T/QMIRe9XKVAYMIHqPtMOYpNEP?=
 =?us-ascii?Q?XLea9dpUNT85zYweL6Q19cNyu/QbCIHXsEIfbgoe3CJwxM6UWaICWccIBZnc?=
 =?us-ascii?Q?HmGA+LX2xyFANnLCV/RDsR0IUqadax0/QKT+MSaL4WXZPHoOVF7cRyYdPoIa?=
 =?us-ascii?Q?j995MGXVTgcGMyzL0L9UInOLfhc+m1wNdELXR4VZxyxYscDM8f2+gxN6CUB0?=
 =?us-ascii?Q?6LuZctqxds4RF4F+Ic7SfnPw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cbd2e3-562b-4eb0-9955-08d972ead6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 17:05:19.4170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NA7ghNeBiARRGchu/Y5tJeryGAXkkUBuUfQ+zZkWIVcbh2kjSIzErrTSUK9on+umMJNHMoJSh6G8HWfsIiDK42dwUlPWihyrXRstoyEQbqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7413
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
