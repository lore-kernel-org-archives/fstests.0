Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DC2C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Mar 2022 07:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiC2HpY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiC2HpW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Mar 2022 03:45:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119C1890EC
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648539816; x=1680075816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OII36XS2Sqjm4pXJ+aeWUOrPL+my8MFqp/KtrmjotPM=;
  b=FyCPtOhP+OGmEJBYgvQJ+isqXde/6RiF3C64/eLfbBqbRpSCjAhjXLl/
   qU2Da2lXj8FZu7AVLAZXkntcQoUk5oWrIDX2Z1LYSwtdFvokP5rqvLhV1
   QUv1AIuzjrLN1pUI+Ntks4ucStYyyesbIljZwcPgBvYyPqxs86OgNPBtn
   JUuLtNtZKVsSQUtBHiNiRUN+yJ8apMwNwJiU7TJ6Zl2hGyJCkcfnbM21E
   p3tBihLp1W9iaYVT429glGz1b3lxYmB8eCdYTDRz5UbL6EPWP1cLP3+Fm
   opsBTNXuJOsN9gR7qF7XMABWdxoLohrHx8+JBiDkjduumalRphLYDWMQs
   w==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="195407320"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 15:43:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEYpyit1v1M6CeaqXE2UNiRI3y7FwOUju2E7lzfDvrGNnmCHfwL7Bk/NJoJpxnpw/BlLLs3fqnFCjZtOdU6PCYeveJvaKwViuBXt94TxcN1hCIZ1sktlZ0V4zsB1MZnCVHQ5G9Pt9De3G6TfMzui8LBrLnn/PV+vw8UMvak+H8li4Bqqfs7ccY8mjBeltClHyhbhMLICR751gcGM3qdr5S16DJJi5yGSb/Anj9w9WeuTlYpSpSOPSghPhkieDzQWcg1kX0zdoPhMWJbYaupPzXJEG/p3uW3HbCIGxyvPcgVdN9wGudnYepEeC0XNSxrLuST4xyABOSCdJDC5Z96QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OII36XS2Sqjm4pXJ+aeWUOrPL+my8MFqp/KtrmjotPM=;
 b=d705xAM2GNI9I/OIllzlOAiNLEr6vy1AWV566zyd2FD/YZEMAWyqZ++531Vx8c4XQmMh81xzTPiU9oMagSp7BHl544KGNRB9VQVFx7OSWyvawOBzlbeMuHOZixlazMBNkaJhY7DZH22tDogMTkBqKW7eclXBSXElS1Y9uzFKYI/AmqgJjS2MYJbFfOj1+Gb74loKtse2CbUxlJ8WkG2DKXkbxZ0FFly4DRsl74UFbDnH/UWmRMVrGiGa6ilN2ixENELN90AN/45vktAA6LMdwDUzAXi2SPubHOgCRzvMawnT8XRPBn1Y9e6Qm9i6CYx1PcWooMwA0dzKwwWV/Y1xMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OII36XS2Sqjm4pXJ+aeWUOrPL+my8MFqp/KtrmjotPM=;
 b=0B2SNgjtiK5vwLvlg2LHkk9ekfDTaz2qzTcxcAd+86sSBC1dtytPNMpMVOEI3xBJpaRNCR87N/TN8gosgb4RcxnUcfkSFh5Ulafc/UqrB/7kYNPJvgDBt+cF6VzKmFcQDHe7RUwmfXbsBMqRbfS7y57bz2EjyiETpMSvYjkQpW8=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 SA0PR04MB7227.namprd04.prod.outlook.com (2603:10b6:806:ed::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 07:43:31 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::61e6:a275:cbb2:1bbc]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::61e6:a275:cbb2:1bbc%6]) with mapi id 15.20.5102.022; Tue, 29 Mar 2022
 07:43:31 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v4] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Topic: [PATCH v4] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Index: AQHYQDHouLjYk/Wbj0Ov6TTfrlLoQqzWAPoA
Date:   Tue, 29 Mar 2022 07:43:30 +0000
Message-ID: <20220329074330.wcdub2mhqepbzaft@naota-xeon>
References: <CGME20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20@eucas1p2.samsung.com>
 <20220325101908.127071-1-p.raghav@samsung.com>
In-Reply-To: <20220325101908.127071-1-p.raghav@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55737dbe-12d9-4f6d-a6de-08da1157d20a
x-ms-traffictypediagnostic: SA0PR04MB7227:EE_
x-microsoft-antispam-prvs: <SA0PR04MB7227884CCC9382AD88EFC44A8C1E9@SA0PR04MB7227.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cl1anfystnxVYJkQbWGnyTpc5fPlxUo/+Gc2hHuOQ/ly7xE8qSNp5xrxeCHg9lmqnt+UGdaA2OXqXw5YOkbZeYZ3PSaKNUkoMqIal6deILqnsIIe2l41Qhr5ZL3oo1z25RFBIR5d3MgXJ7IyzQCHpIpowvl3BAlXxuDLHTV2q4w3kmmUwPDp8M3SxNcUs5ygeiEhUbl2ROEwZPoYuCdeKR0bxNWAKdaSp5QEdbgZLKJ6cbR0JYkg9fmRczjDREaMursK7L12XtDxMuWWah9YRxfTFdgmV2P84m7+sSMtZRZRJJY1pm1xWhAbJnBzyM9/NSKQCke8iS31vEFJ4cceTiut2g0qQ3i5sxCNifvU//rGnnz1DZzRlU+erzPUG4bVn0gtB5jHxZxTjPT/9OUbJkKCgr6u0q1xu5RM2ayBQDC7DPfe9BLqxV0rsulBcr810KOs+/Vc+QHsoj9Oeroe41VeaWgI/4qCi4c9fYHuTmTKLhPZg13lMR66vFy2b7sWiuNLdzD29D3kMsCIX/iuJ+wW9rLbLDe8XsDqY0nngICZbtohj6ooOVvkao0Xg3qWgVfnW+6UmC6DJP8qgXMJQoenlYtUndE0Cyf1qKIPCaI/MMyujVzbJbw5CKMWzY+NJYpMQbMC9BB52GsuLm2Vmo2wOZFm1fF0BUATp4xS/CwS4/q4pUUeXoa7f6KJCRd1XAjOMQ+dc4aUIOz+g2GGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(186003)(8676002)(83380400001)(26005)(4744005)(2906002)(316002)(6506007)(6512007)(1076003)(66946007)(54906003)(76116006)(5660300002)(4326008)(64756008)(66446008)(66556008)(91956017)(82960400001)(66476007)(9686003)(38100700002)(38070700005)(33716001)(86362001)(71200400001)(6916009)(6486002)(8936002)(122000001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7RM46OQwO7sr0CitIdaq7NysxHNy2xjxX8VK335nHbXXKVMxsAXhOQOTm7?=
 =?iso-8859-1?Q?GHnglW8kbZFnadTMdV9cGTBz51zkUMGYg/Kv4ZB2OGiNi4XJbpl3EN7S+K?=
 =?iso-8859-1?Q?Ia7nZzvDUUWW/FSbhk5P9kpzuyEi9B83PG93Q5vwTwf2adcFiPPsAaWy/M?=
 =?iso-8859-1?Q?3+AXU+AyrYH1z4V0vNgFeLr8fAk7hmpxq+W6LWxV+fHIqWPBV7NaAoc7+q?=
 =?iso-8859-1?Q?5vMYlhp/WEy110NnuDf/pG0swxk8g4ctzHscb1BgqRruXT5kONjwSRvMOg?=
 =?iso-8859-1?Q?AVdYZk22D/brFBWaU4OFGI7NpbilixTjYVuXJuN5woLL2i8D647IJl1em3?=
 =?iso-8859-1?Q?jmm2GE7NwKxMdWPSkINfTj4pCrjegZew8mzxfZf0dPK18ZviqFH6h4GzP6?=
 =?iso-8859-1?Q?SJUW/9UM2vPdMIvpVtBScABo7+ZbxItujANBwVLrJAsfqkKSHllUvsQCes?=
 =?iso-8859-1?Q?Ppn0+KdudbK+HHlkgeGVsDX+K74TPWT2I4eazWkPGRYzTDTiAlSg3v6HL7?=
 =?iso-8859-1?Q?Ma0qBu1sNL60IdPp9sCoi9cXqV+IdMVe984GNRXI0duCT9h7CRmkUHTPwl?=
 =?iso-8859-1?Q?4aYwuW8z2L2rBPlT4mwE5rMTGAooDaW1Zx429cnnRyMdlOEy5GhUzeZllo?=
 =?iso-8859-1?Q?/ftxOvybUvJOSdBasAL1r/BrNwhPfamhlGtQmsSwxN/7ie9F1+RyHrKx4J?=
 =?iso-8859-1?Q?UVxWx2NY7VsNuLaTMjk5PPNyO5urP/78fjsUsdVkx7Fsc6bxoX3Gck/wfZ?=
 =?iso-8859-1?Q?Iv0PzEZFKP14m4sDn5MsaJbvuf3taoWowtDo17iaDt63pAG2J+k/Fn0pK8?=
 =?iso-8859-1?Q?6qK3JlKiHjN5H4dMrmpNoei6q/fgfq/qYvFQs7r84ha0q5PhhE+me8t5bU?=
 =?iso-8859-1?Q?hyVmqrslqRfFgMFct6szdr3KNs4sYo+nnlVzpBscvpehaqho5s66Funj1l?=
 =?iso-8859-1?Q?ewR15xHTm+GEy0f+WHTsfUUSuUl8ZQqdwS7XFlUnyr07QG5gydbpb0vOIJ?=
 =?iso-8859-1?Q?3mF3j8kKGnT8KQUO1pr3oOn9+IIFPFIWakr8lFqu89r7TIrGoRciJh0v2z?=
 =?iso-8859-1?Q?HRRZ626umHp29ThiwI1NmW8xMJzWni0AQgSDpscNPP+z3k5KP8NTunw/Tt?=
 =?iso-8859-1?Q?TJhO1yFkvLH7Z2yfkYbm6YgRq/xXhCd2VPmFN/pqKsL6Jtj2JNzhMDUwhE?=
 =?iso-8859-1?Q?QM9F0+cGjJKg8Okuip8nwmivPBXKNoqodIvRi9Nkk8jXLDxmu7tPys6i1A?=
 =?iso-8859-1?Q?x9Dx7+A6PR7732/0Pq03Z4ljErVvUoLZMqb+lMQPaWbukMnfeZrJJ/jTVJ?=
 =?iso-8859-1?Q?7e0DyFngdt5O2hU7k0sDwbKkLxd1HVbXj15MkTpKxFhrAeskfJVJHUNa5G?=
 =?iso-8859-1?Q?W5fqyLOIbtyTytqBRWLtqFLSl9n/nVCpOIASgmQVxhZ3+tVvy1kQZ6h00r?=
 =?iso-8859-1?Q?/sWcKB1wNUtQqulN1C0nvPVRxrLzt2lCVSV5hMZb07ktDdN0set1Bfef46?=
 =?iso-8859-1?Q?nCUuZx3TAdPY7ulJef6ETstEdNw0YzgykondxhW0aJsNQxeFYWfygu8qjq?=
 =?iso-8859-1?Q?W45l7EIFQOaBdjdNEYLokKbDLqSFymbw1Zf44Yz6Ot7y0ecRlUx2a0/1oh?=
 =?iso-8859-1?Q?5RKCGaZ6R866WjztkTaQte845Ra2cXBxAeaFxW6/Q3/wcbGWU3WH630gI6?=
 =?iso-8859-1?Q?Fg0GuLS25FJyjRdIHVv+wFIqSjOwBFaQsgx/5PxYhaInT9vEB245wzV9Qg?=
 =?iso-8859-1?Q?MDGfKUZ2+OTEDLEnnHoLohNJ9/HRuln0LltcPuL+x1f65WrBnHGO/JKOFb?=
 =?iso-8859-1?Q?ruJMPTCFTMMxom5+BMc7UrwVSQnOCFE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3F5C7FB4DCCEEF489C77AED0990FA843@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55737dbe-12d9-4f6d-a6de-08da1157d20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 07:43:30.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCivVW/ue4Pz+4xQUyQidWjUGKvS8O6oeD39HFtvAkc9eUzOfNmU9YfcW541JzAW5+P7A46lugfSnZjIJhgzyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7227
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 25, 2022 at 11:19:08AM +0100, Pankaj Raghav wrote:
> This test will break when zone capacity !=3D zone size because the
> calculation of the size to be filled is done using zone_size instead of
> the actual capacity available per zone. Fix it by using zone capacity.
>=20
> As a zoned device can have variable capacity, use the btrfs utility to
> get the zone capacity from the first data block group that the test will
> be performed on.
>=20
> The support to extract zone capacity was added to blkzone only from
> version 2.37. So zcap will be used only when the blkzone version is
> greater or equal to 2.37.

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
