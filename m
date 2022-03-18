Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2768FC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Mar 2022 07:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiCRH4O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Mar 2022 03:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiCRH4O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Mar 2022 03:56:14 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE7116E213
        for <fstests@vger.kernel.org>; Fri, 18 Mar 2022 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647590092; x=1679126092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vHmcQCDgIg/euyPfaq2uNvO+Hbu+TaU2coU1bTSiz2Y=;
  b=AMKnp7OlfxyS14N4n0EBNfYMzXvMzjEKuTo9PdsxHZ2FbasxZMzPxu1A
   BnAEsX27OtBmhkZq1p2P476yTg/UAlGqumzL91JrGy7yqih18IUF5Fh8z
   SUlUrDycwg+S8pF7sy0c2y6XP8CH3PesSfTckERy8ifRKgG5/M561Of0n
   RpaA5mqR3GHCj3S8sUwonRGf9rchjtRwuG1LPhH496HFMv0WgxivePUC0
   ecsVG12BshzT76z+mvLrJmxNQv45nKCauaDOLeJ5uxN/7VbM9Bzugns+i
   gA4Uvx3XGYadZDXxHDsjce7MSg7AegYw4ODlvK6LcX2uK1zmgDY608SmO
   g==;
X-IronPort-AV: E=Sophos;i="5.90,191,1643644800"; 
   d="scan'208";a="195684743"
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2022 15:54:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5l2pDkVXBtiiEebWcV9/ziJDnlcRBBDEAXaep1RCU41r7VydARf7NbfpLVNlrts12S687K2wtB/r+wqv0Zl/SBKWsAqddiHh6Z0yQSmtZXXwHR3TU2QUcZT7SWPBPqbNuNN/u7xZTBLp6hzrDQQ10g6xLJ5m2FSxfem1tW1O7peD0R/j0P1UTsuVXRvJ/l94X9+aVOq0Vzu/QIvwHhYGgY5fes7CLPBGLLBSznXSnoiFc1R5q1vtS9+sTmBMKEpvvXtK1mJ3kRbY18XChb+nA2LLsYRPPvS4bb94eaY21qJMNLQaLZZYsPwQYXELCLOPat8UbD0tOw1oXHzbT11vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W29x8OZMsqOUE5fepkA1dAa5h/3ZYmqsTI315G6pL10=;
 b=jvxZvEZAlGKPd//o6cFroYnwsn4gN59zhMrNxwzHP+0+9scQg2cHMYV/ONw2R6/24BNgcMdvZ1l0yAMENL4alWDfS5veNEnYxvphPuc4GLbCNSzIOUC9mTgZnRMbSxWv+D0XgrG0nhi0lXmog135JvvF+Ffjnw5aNiXdTIReEq6sONNn5jxyvpamjvLI19MeiQBwg0OK37qM6l1xsXsT2bvwHm5OQZybfXnmt/YpilWYLXPAngOrNlbnDZbf4KLts7OlxlUnls/3NKYf4Wo+4N/Hv/1dEB070b9qfKyfLPG+tVEmvaAEHiAjSCVAbPadvk8lXKAd3EAaLXhkn/k4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W29x8OZMsqOUE5fepkA1dAa5h/3ZYmqsTI315G6pL10=;
 b=VraubbtFb+yHMw0wXIP3LC3gGIwujcD2O+1ybrIp3F73TOIfZYOS1STYQAOXFXsH9MA3NLuv8T+184sYGdS/xUbRLL8rREVfhtRd1lnpd2PTSQyhFD+psus6eJBsRGgbVBWEMZHgADXHAu4kbJByheWRYE3LcllTv2xDO6rfDH0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW4PR04MB7236.namprd04.prod.outlook.com (2603:10b6:303:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 07:54:50 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 07:54:50 +0000
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
Subject: Re: [PATCH v2] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Topic: [PATCH v2] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Index: AQHYOfqObn2ZwWKzeUi+twUUxPGDSazExusA
Date:   Fri, 18 Mar 2022 07:54:49 +0000
Message-ID: <20220318075448.ansaa57hy5k3jkge@naota-xeon>
References: <CGME20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd@eucas1p1.samsung.com>
 <20220317122839.44404-1-p.raghav@samsung.com>
In-Reply-To: <20220317122839.44404-1-p.raghav@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62ddf825-16b6-4df7-eeb9-08da08b4943b
x-ms-traffictypediagnostic: MW4PR04MB7236:EE_
x-microsoft-antispam-prvs: <MW4PR04MB7236000746AC3CAC70C8AE428C139@MW4PR04MB7236.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWkpT0aMZrPI9vrIY8nr8wN7LSn+E+vRzUidID0t/tzz+YpY3ZioyNym1QJd4zz/ZzraK9T8x/efnOjKx1UlwiajCA3xVM1D2Gl5AEMIP185X6OELDcIwNfPoLsi3HVHNHAt7QuNe3ZuRWu9h0nLNcX/PKXQ8I6BQoyDmV+GYExx8NF4MWT5XDW5x2UT/2kHysxZEGHWCrX8xmxjFsz6XnKlv7S+JFQPwW7VA5uGOMkjJS0WXdEyqvVPJz2IpzQbjuWR2P1D7XX1+RSRq4R5OkWOUuAxR/cN23V24DbjypvNv1HLDmRW7p1vknThrMRahbOSAt7naYaFoWSa5fZV4OPT4mhVVIijC0zM1X3VVwjykPVDv+8l0HLi0AkWQqqj543JcrYHF/rCTpm0LrcCeavRGtoJVRS60e4RIJWzF985JWzIjXFdgZWC14Lj2uooYYyZaLGFKlPMCg4/ivmJzsZwRRrZmZJnbrtFq7VMSSo9IEpq1LspICVKxiQbAy8jQutUDl9bi8hRtHT+2naGz8RX8ZGpuMTaeP1VnYwTpS0XOmwYbeDSd1LsCD/Du0yLnNWxSu/Gxmb71hsnCmLfBILtd2wfJtE9Rm/XQ2HILqlVx2gTbyMbBKFSA8mk+H11WyT/zTjgObPylS15CDD3dk4HyGvEgdkTBtXbgjq4NERD7dqHF5Bs3YWgytRCldJ0w3cyPW9/bjn2LrbIVwo40A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(122000001)(71200400001)(316002)(8936002)(66556008)(64756008)(66446008)(8676002)(66946007)(66476007)(91956017)(76116006)(4326008)(38100700002)(83380400001)(2906002)(5660300002)(54906003)(6916009)(508600001)(6506007)(33716001)(9686003)(6512007)(186003)(86362001)(82960400001)(38070700005)(26005)(6486002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OPfdv1zEIN5FJ9CLbLSEP7+MpludIqeAt/fjnL7R8KF85U3H47zPn4+5WA?=
 =?iso-8859-1?Q?VfNjV+jag2JsYTpIo5hXITdj8LG2SHScb6yTq8sb+OGPQWRe7eJuSaTeS/?=
 =?iso-8859-1?Q?PUyYsZ6ooanpWL4ebHNYw13UiiCmOnCOEOcS8U0nc9qsHOelqNkHE+tn8R?=
 =?iso-8859-1?Q?3Lh991kkG3xpzE+6ZB8TT+RWEIkWtKW4IPcjn2U03dGvvJ4a9bbnCNH1ae?=
 =?iso-8859-1?Q?xiSeWvnuPWW0I7utlwPq+EUuNIhKKdDE4mazej7F+6EJX51HjwY2HZgHWt?=
 =?iso-8859-1?Q?oK3ahsdxskeaagPUbxKIVDWArcrQofiS4ml1rboQTDCNnnf/7wqAU0UrIH?=
 =?iso-8859-1?Q?nch/J663yXcFMSyuQAGiiwBuFfNKpywt+gb337HZ/skSaFVV4bDhdlskmY?=
 =?iso-8859-1?Q?CS0Djm6jqVTCDmDtXdE8Nc74MJcw+chqP4GkjtpHY5aJZ4gr0U458dZg5b?=
 =?iso-8859-1?Q?4OYRki41AVFnI/t8QDhPAsEumfh7Fee2b0tErQaI5Jare2bfisNYRvNzHt?=
 =?iso-8859-1?Q?H/svUSUAeC0YdS3n4tn/bPDgPJF0w1DmxTZBUx2qnXAUkyOho1nZ7AhBes?=
 =?iso-8859-1?Q?kulapfBW7H4eKPxqpYdA39le971yrYU2M/v2M1Mc27CSP7lQB8o3WTlCDS?=
 =?iso-8859-1?Q?n2J4uom6OakMr2o5Nhvg2nVPtR/8Rq67Uoh6ML/qVGVNVAR5a5JBFVRAK7?=
 =?iso-8859-1?Q?y/JUZnK9LahynDu0sun/foUOb2xPT7/+I9ea/XuN7JylambdkVbNMoxTPN?=
 =?iso-8859-1?Q?5IXDVdSClHRJ0mjSMkK5rSxcIdxB9BzlucM/IYJTO1JgOGpyMwN1HmdEo8?=
 =?iso-8859-1?Q?tqOkLOpnxnjUXwn1OoJsKi1JSyJhZFCSq6MqXH5w2uP7YeOsgd4JBmpBvK?=
 =?iso-8859-1?Q?RACrUHELl3NIR1MmcOKRuICotbTjQ6Csvwqq057UKc7aV1G124QQ8MtMb6?=
 =?iso-8859-1?Q?fiSKfFmMMo90Ef76cgXKBHLc5uRr7S/In/MtbRK8LZqzfB1KipykDkJr0A?=
 =?iso-8859-1?Q?mMQrMszCq1Q2TiRhBTqqgKU+JBeSIxnrXimLRYCbcSmRab+5H5aBOOCjEV?=
 =?iso-8859-1?Q?9Qk5GOG6PpDQ5vlNkPg0MXYS8H4SrGmXwwe3Qw6XUHLQ+vZwMC4IAQjejV?=
 =?iso-8859-1?Q?S/Y5BBa9P3Xq1jxVIk1/xi5oTVxYAX06DOSsKNc5TtyaTA1q8gjKS3OjuC?=
 =?iso-8859-1?Q?7LvhQHY6gkWaWxTzfNPq7c2vLLpgUWSr+eOHMijHwwCqLDWHJ1YcL+Xs6Z?=
 =?iso-8859-1?Q?loZ+FKCcvi3SaIphfs0UvLjzV+fJikVPHo/wNT85HcqdRyLMQrqRqJCcqX?=
 =?iso-8859-1?Q?SlvNRnPmq4PAvVWM+zMceB6Eu9N+lKaqpBvE80K4v9T8sRYXr+rA4IbuGS?=
 =?iso-8859-1?Q?9L7dKY4G81hW9quFoXXE8uMYZ9ErVSIjlt8Vg82xhmwPkDdMazNMuJJb51?=
 =?iso-8859-1?Q?NOP070C9iQr9dr6PrVjcNTa7DqPsZ81B9Qc+TihcDdNDnSRA/2TP5FFiuN?=
 =?iso-8859-1?Q?1opwc2wTDaCDwpTjzMOle6StvqSad0XPDK/p5F9T9aqQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BCF7501129F4694B945724BE7ECFC958@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ddf825-16b6-4df7-eeb9-08da08b4943b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 07:54:49.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsljlfPy3HKjNbPUNNTMKCUNb7UiIMloe/3WSV1F9AkD4q+VOSr5AcD57VAbmwStzSgJmZafNx8orO4eZYUgig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7236
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 17, 2022 at 01:28:39PM +0100, Pankaj Raghav wrote:
> This test will break when zone capacity !=3D zone size because the
> calculation of the size to be filled is done using zone_size instead of
> the actual capacity available per zone. Fix it by using zone capacity.
>=20
> As a zoned device can have variable capacity, use the capacity from zone =
5
> as it is the first data block group.
>=20
> The support to extract zone capacity was added to blkzone only from
> version 2.37. So zcap will be used only when the blkzone version is
> greater or equal to 2.37.
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Changes since v1:
> - Add a filter that can append a 'cap' column for blkzone version <2.37
>   (Naohiro)
> - Extract the capacity from the zone on which the test is performed as a
>   zoned device can have variable zone capacity(Naohiro)
>=20
>  common/filter   | 12 ++++++++++++
>  tests/btrfs/237 | 13 ++++++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/filter b/common/filter
> index 257227c2..5acd57dd 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -634,5 +634,17 @@ _filter_bash()
>  	sed -e "s/^bash: line 1: /bash: /"
>  }
> =20
> +#
> +#blkzone report added zone capacity to be printed from v2.37.
> +#This filter will add an extra column 'cap' with the same value of
> +#'len'(zone size) for blkzone version < 2.37
> +#
> +#Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> +#After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
    ^- nit: need a space after '#'

> +_filter_blkzone_report()
> +{
> +	$AWK_PROG -F "," 'BEGIN{OFS=3D",";} $3 !~ /cap/ {$2=3D$2","$2;} {print;=
}' | sed -e 's/len/cap/2'
> +}
> +
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 96940549..33a0d81d 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -35,9 +35,6 @@ get_data_bg()
>  		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
>  }
> =20
> -zonesize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_secto=
rs)
> -zonesize=3D$((zonesize << 9))
> -
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount -o commit=3D1 # 1s commit time to speed up test
> =20
> @@ -49,12 +46,18 @@ if [[ "$uuid" =3D=3D "" ]]; then
>  	exit 1
>  fi
> =20
> +data_bg_zone_idx=3D5

Hmm. Yeah, it's currently there. But, I'd hesitate to use that like a
constant number.

Instead, how about querying "btrfs inspect-internal" like in
get_data_bg() do? E.g, like this:

# Assumes SINGLE data profile
btrfs inspect-internal dump-tree -t CHUNK $SCRATCH_DEV | grep -A 4 CHUNK_IT=
EM |\
	grep -A 3 'type DATA\|SINGLE' |\
	grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2

This command dumps the location of data BG in a byte unit.

Then, we can calculate the sector number and can supply it to "blkzone
report -o".

> +size=3D$($BLKZONE_PROG report -c $data_bg_zone_idx $SCRATCH_DEV | tail -=
1 |\
> +	_filter_blkzone_report |\
> +	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
> +size=3D$((size << 9))
> +
>  reclaim_threshold=3D75
>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>  fill_percent=3D$((reclaim_threshold + 2))
>  rest_percent=3D$((90 - fill_percent)) # make sure we're not creating a n=
ew BG
> -fill_size=3D$((zonesize * fill_percent / 100))
> -rest=3D$((zonesize * rest_percent / 100))
> +fill_size=3D$((size * fill_percent / 100))
> +rest=3D$((size * rest_percent / 100))
> =20
>  # step 1, fill FS over $fillsize
>  $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqre=
s.full
> --=20
> 2.25.1
> =
