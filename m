Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66553C28D13
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Aug 2022 12:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiHVMXE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHVMXE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Aug 2022 08:23:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852632B81
        for <fstests@vger.kernel.org>; Mon, 22 Aug 2022 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661170981; x=1692706981;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=D91wrzFaAdHZhkdWvUrPsZR5rDXnMpCpmfApyBG/lHI=;
  b=H2coDXYXg7ZtJUWO8uin+a0N6CuDMv2PUCouPTLwP0aCIjy/m5CQNGix
   VxHOx/EFzffge622ANQ2/FVyNamEuZW1BQtEX/6UnZ5ZvAFQEcwq7NnbO
   kGpLeFbCZbuw7LSqhwRhIcd84EFamexnOEkv+MdvIjirryTxRdKP8F9DN
   jnyUrMceDkMG2HmC6c7C1KKy+7gs5cvu2TDtkkYfNNwSKCHbS5KPAVef5
   05HAR/HEXMJQqFxziGqd3s0R/1EJDpw+WLN5Mlq6Dg0XJBU4tSK3ua0b5
   4jM4HLSDgdbP2iHBmPciSaj6sDhMnCxNTasWuxLbFGRykak+QnAZj8edw
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654531200"; 
   d="scan'208";a="207777004"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2022 20:22:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk4/VdCXBB3MYzyyJqOREWGPmFPEYdp5M75L/OA1Ow7oibNoEYzJAgjNX8KH7OKeMp8JZz4a2DKYf2zQg4kFiaJ8hOcTZZhmPs8CHIMpLh3zTLjrktBWeSqB9UncMJZDYyhERAKlqaDIW1qSfjUIVlu49Lo7HH2Q2Z0T//BCSl/rbRERHARfIUNt5RJIGu3sWdeUkNOY/l3Eu/CD4KBLHqeZeOOnRusTeVQM719RFeEn9Q0GN92Tzf+T2rvrdwd6wg56NFEWr6DtGnIuTjaZFrwSbFnfW8PcWzYOa68rm2xiNLMIzeipzVjMLQUaLBh6donqVIHRnzHeIkckqljl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D91wrzFaAdHZhkdWvUrPsZR5rDXnMpCpmfApyBG/lHI=;
 b=f6zSJZ81A2za248odYRCjRu/s7Hzcd6sjaybSnNs1Jqt9HMeM4sC4wLkmMq/qxNHa9XBpTbHTW48Aa8gOBmL6VuoVUH2m6K19RXDudeNmhA6A/GNTN5WNRcDUhQu7kbIvf51I1pY+SmTzbeUKss+EE66rCVkqkS8+CflwZhB06OxwahTXhvnPTgHft0welXZVEcmH1QiIqmhyOFfkZOwvDUjsRt8jVDCZLJh6PZU8/92rgXXoHUG9to8Yh/DVPgY/ZMIE9DvrF9rl/5+1giKVXhPgLPZ0ptfzmDnO+GS/Z137FXTKtZ8X9WK5k/pDU5v+1qXZoIiztbFuXZn3LTzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D91wrzFaAdHZhkdWvUrPsZR5rDXnMpCpmfApyBG/lHI=;
 b=c5HZDDOMyEaDb2SoyYPx2TfuBFNPrM3zak3jWtXZlm6TK9W9Ego7/fHWa89QEeVGhmnlAMtNzLZO87k1hcpw5mKJoPWlJQVYSnngsOL2sF9xZIoHVP94qwH5X27xU1DRUIfsGbgZ7Rfr4OvTurf+9ERv+5dHtoU+J1vrD+xWync=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3778.namprd04.prod.outlook.com (2603:10b6:406:cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 12:22:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 12:22:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [RFC 1/1] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Thread-Topic: [RFC 1/1] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Thread-Index: AQHYs8JZ3PpGE6SanE6ok8KWF5+l2w==
Date:   Mon, 22 Aug 2022 12:22:55 +0000
Message-ID: <PH0PR04MB741686A56A3ACA576F380A759B719@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220819115337.35681-1-p.raghav@samsung.com>
 <CGME20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad@eucas1p1.samsung.com>
 <20220819115337.35681-2-p.raghav@samsung.com>
 <PH0PR04MB741618CBF8C989CB7AE2E6E99B719@PH0PR04MB7416.namprd04.prod.outlook.com>
 <08bba73a-4e13-63ea-3a4c-33dba359a84f@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 524c8fb6-0efd-4ddb-43d1-08da84390ab1
x-ms-traffictypediagnostic: BN7PR04MB3778:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u8k71nuHPNzY8gDA0b9pEm8n7g4wrGtOb56c4qqNGTXDbcBEiX3cUHcnex+aY01mmIdPZ9fxNGYg97NyfiozsStfKd4YwxXECsNtJMK5OI32fxmUqHjkLM9SBhvVH0VuzRRFYORQqiQKcd8e6NVAWYpyEhj1tYomOpqV4ifh6v+S7vztHLD/xbl4FLn/Au/Y8/ZmlW8rWNxKbo6r8U/C+jOUlPdXpyjydDJfEgNQ2zbr8OCuX3JBgT9lwpOS8ugtsR/orT3NebJoTveIAd4azxqMn7nQn5uG212RlwglHa6ht4c4jvo80T4yalA8xVpbZNjmHT1evy6n+tXsq/Ke06BtZ2xI42u50g167vH2m+/HcoMNu9gXvBbDLP357QRIC5Oegz2VZz0RrRCxI3JX2AuRu7kHEYqJPYU5DBGMmVYujamfkOjc1MznxB9tV228MwDqi/w7tTL506O6SK5Fi0xkdYTPDKnmhdZ+mMFIrNfBoGScJTx8J6WbfVyYQi2evirSXwE0MTqNiSia1ytzu46GP7h7fQzPBmiAKyKF73m5dFYJ8fWvG8UkiPpzRliI725tWOoAX/jOVIX0ENwX1dDPbloOCRx9mTsdBre0a9N18ut6F0LBXat2EFzZaSR3Ri/LwvI77dSSY/0/00oGvSqPB/rvLiX8aIaWWycsUotUG0AAA2+0CqCagFR9SrBa5pXFaowoJLWaBhGRrRqC/JfR92xzFh8bzC8/saKTHkMMffzM20NxH0MY+7dZF+tG0jUat2hD0gHnK0Fo8vlGlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(86362001)(82960400001)(38070700005)(122000001)(38100700002)(316002)(110136005)(54906003)(6506007)(8936002)(5660300002)(52536014)(76116006)(66946007)(66556008)(66446008)(91956017)(66476007)(64756008)(4326008)(8676002)(2906002)(186003)(55016003)(41300700001)(71200400001)(478600001)(53546011)(7696005)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3mO6mJFKPc2bv9MfOLLJausBSkxNsOGtJHLweXA0tKxGOcqu/MdQdYHUM0/a?=
 =?us-ascii?Q?tVPOIrkO1an5bd0l3ErsosP+H3XaD7tuM3OX2jMqT7ZKfyALs6NWm7v3mLYv?=
 =?us-ascii?Q?aCMjYHDLyPm+zy2hl0cd4QVjB2xrQHoCZnOupazavCjeiHY4t3QtYAJHsNX7?=
 =?us-ascii?Q?Km2qsN+QCVBL9j3BveGK3kNjObjSd4uZMFsLLNrIMFCASghbNjALVMVnR6rt?=
 =?us-ascii?Q?kA7wGY/2A2pIEpeiSLuq6+l1U7882863cq0ulXAHvqp8ZTK+/UFyfkzxr5VC?=
 =?us-ascii?Q?rK10J0QjGUAKUOUGbDB+jt70ToOw8ikmbQNXQYlz1fxLVqp3yQi5yIG/6GsC?=
 =?us-ascii?Q?cllcKZyxRtbbHtXI4FpRqU4ESakHZYQqDgQTLhtKYqBbdETdyKfHMHCU+ENG?=
 =?us-ascii?Q?UVYvGFe39hjm7pLGUKWNlyruaRhZvmpROrggsL8icHJXauO+ItHT4FBccZ6C?=
 =?us-ascii?Q?wE2ZNrYbqylWVBJh/QiU+UGaofkIL+Vhzk3ASj7ueYiOh47ruIm8AquBNbsH?=
 =?us-ascii?Q?1cEWMZggNxNcc3KrGlBToeaQOW1qUSSS4xKGaqwtnXiqItal1xWMWn+kfCwC?=
 =?us-ascii?Q?405vaijCOQT62fyLjc1EXhrjBSJP/O9YRHoaNahZ26YTgogE/yY2lvDEojf/?=
 =?us-ascii?Q?hP7ClVBgDT/UFSNTxiiLDdCKIzP1suRvDptEheZpnUq1PL/Egahl0XawIh1Z?=
 =?us-ascii?Q?pyG1rAKh95J0HNNMgh+0UM5A4Z40Gy7znTJcMQuvbl2R3IjWaaGT/5SRPYsj?=
 =?us-ascii?Q?qC3XCfXHdH+lhr0gMYwaZxcyXtHyqu4XpMQ8J5fA67jTXtXBiJ8VL+Tj55GN?=
 =?us-ascii?Q?q1Oz2+RI94xF87HibnD2+ckN/L5bjTtxlXIZdSG263l3WJc4UUCpnB5Vjgaf?=
 =?us-ascii?Q?uNeZBGsRPUnnQHvz1OLkPdyeCnpHjfycDmDEGiv/+kIa3N54SBb9EGjS9HUs?=
 =?us-ascii?Q?1Do52YHPoNMupY5bC9p6ihJnHueZ4fcyt0tpbNf9DQx8Y46dCLkVF/q84GoW?=
 =?us-ascii?Q?POfY11HIWO4moW46KXtjUQi/MxMji8ACKr7YSB0Hd8obzKrZp32vKaWRKr41?=
 =?us-ascii?Q?eZl42VfyLpi4lccPva0SmZqztdPvH9Y4qJBxgqA6eh7prtr54/LSVCGjQVst?=
 =?us-ascii?Q?JNicG65Ffj0rK9UOj7cQRod5j0yN4qGV/PWe4QfJU3kh18O9pistBgxQieGZ?=
 =?us-ascii?Q?O7b8fVDa1PHBDe7tMc3PyHiSdllRwAsAH/MoHQYtJF//Q+jACiPG546oWdfI?=
 =?us-ascii?Q?roRYWQxMR0HFTANq0kKpgqLAlY1tpH5Sma3wXR/p5hT+gkjPl+kJ5rBcZsDb?=
 =?us-ascii?Q?363XvdD17hojVRKs4WuB2h6Yri51yIvgHIMe9JHLTJhEe5Mcn4Z8ftWxDiMT?=
 =?us-ascii?Q?iJOhln1nTXr665q7/BkMqGwaGAmMUaiac3fFHT+aoeblimju02nlGFRaLoO8?=
 =?us-ascii?Q?TRAbfRiGlbs4NoZmD0W61kpkmNDQDZ1HQCLtenhKuzZJVVWVFILpyz5lyzwC?=
 =?us-ascii?Q?zMtekEI4GA9wJbRDE/tqvRePS6LxMVTodZrmY/momQzCdwfXQiuJGqbXX0ps?=
 =?us-ascii?Q?WPUk0xW14+1WDq39TlYQMG4HJWeaOzu//S+gOu5ViuczO2lT8kZ2BBdexGqK?=
 =?us-ascii?Q?3trVKNUDOGX5sZ5DBh19RyEsMbij/o7ArKIkOf8bGkKeLO0UKnXQBzQqz+Vv?=
 =?us-ascii?Q?xe3f5YL18fufu6tm3YdbDmWvoD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c8fb6-0efd-4ddb-43d1-08da84390ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 12:22:55.3269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vY26NUniCx/qjGAOKZeRZYYiHZ+tq1TJLVeLAx65R40r8srRxNF1JAPp/s28pun9oqSk8NuC+BZBnoXOPUAzgsj2bGPqF+g8LGy0XGGDxvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3778
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 22.08.22 12:49, Pankaj Raghav wrote:=0A=
> On 2022-08-22 11:40, Johannes Thumshirn wrote:=0A=
>> On 19.08.22 13:53, Pankaj Raghav wrote:=0A=
>>> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")=
=0A=
>>> commit, reclaim algorithm has been changed to trigger auto-reclaim once=
=0A=
>>> the fs used size is more than certain threshold. This change breaks thi=
s=0A=
>>> test.=0A=
>>>=0A=
>>> The test has been adapted so that the new auto-reclaim algorithm can be=
=0A=
>>> tested along with relocation.=0A=
>>=0A=
>> S-o-b missing.=0A=
> Oops. I hope it can be added before committing.=0A=
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>=0A=
> =0A=
>>=0A=
>> Thanks for doing this!=0A=
>> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
> Thanks for testing it Johannes.=0A=
> =0A=
> I did encounter an issue when I was trying out this test in a larger zone=
d=0A=
> device. I have explained the issue in my cover letter. I don't know if it=
=0A=
> is an issue with QEMU. As I don't have a physical PO2 device with me, did=
=0A=
> you see any of the issue I mentioned in the cover letter? If not, it migh=
t=0A=
> be an issue with the QEMU ZNS implementation.=0A=
>=0A=
=0A=
I've been testing with my usual smoke test setup on null_blk with 128MiB =
=0A=
zone size and capacity =3D=3D size. Haven't encountered any issues with thi=
s.=0A=
