Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20976C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Mar 2022 05:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356802AbiCYFCB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Mar 2022 01:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYFCA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Mar 2022 01:02:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B2344EA
        for <fstests@vger.kernel.org>; Thu, 24 Mar 2022 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648184424; x=1679720424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uCdVYO82XJGRdPbMJPm5wM78K1Z5Xp3hZTjppuEgvNg=;
  b=hwn5eD6lGiM/wYwWxodQiK3qBtVM2zkAu2UMfNEdE3bs6yFymzjN/rSm
   eetPcYXK2NuZRtvxgPMDkNZ/Ey2SAw64OEoIRs49NkYRZ94oHTeTFZMg8
   s8/iwsHL0oVkYX/Cv/e68oFYv2WNulD7CB1UFsOAyKgJ8NH25e+n+Nh9j
   WhNfLZho71gNgTtm3ziwVXo6W364Df6PCpq6XoncjtrMpRFOSRX6ccLzI
   vo3HGS4SZUNmo/2iyzI4G0cMkaXufktr0PO+aZUlvhXKcCpIo/ron55MK
   gWEV+YGbmYs5YY4YV4bh2yiTJHucwAFn0qqwWJCLBAYhMpMPTSXKVGfKu
   w==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="197156088"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 13:00:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFGACaEzPAy9SM4FP/Uvgy2eVlB1znuJb4BF97xN+SlbOtOXii0826ZcLKY5H/X0IQBdNP/vj7do8xryiRkPWi6ZxQ8TZadt0DwkmxSQ8/TggRVqdOL9yZzCk40ES9uMSZuXmerQiLoG6V+zJHejjOaye2a7PQE/eAKeetZZyi7sAJLo7NN2coptQjj1l8lzGG+PVnZZIhi0YcyFSGtSBXmAnu9vlJqQ6aIw+aKDLg/ijxuLFWGBgf/JZrJOPJnUyq2MurpkNYEIJcl+ockLcPqPUWYNhutoLJr5B+2wWqdTk2jNg7VqvPoiDyjuBafDzpAoNDhafpwHNePq1LH6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/0fxYFImmwK8oAoPx5JpTa9gwv6Y7HZPnaZnJF+wYQ=;
 b=O3ntXsxnJtczPjbgkj/LEQpHDXWAwNBKn4tstUKwkeakew5par5a6CYFoWXyH806f1GfL4DxKCYRL0/Y0fZ3XRK/GxHMqRGIf2uquxkOv+gYgWB/Hzk7MD1jSB2BUxkTzWyo8Seqn0gCJcuNoZmqBrJG0RPOUKS2DIvdi6C3isOE97nepacryf7lm3l0Z4pVus9kekXYO2P88W0iAbi36fSbm5tx+1N/hKIitBRMfYHmms0/Wt4HYeHfCIIkLIp//w4UWqaiM/yUuZvxqUL4e0PkJRgrRbniB9jj7H1TJZAd0vnZq5oZeOpO6HpD3+dtjCImJY795PwogEMvt998cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/0fxYFImmwK8oAoPx5JpTa9gwv6Y7HZPnaZnJF+wYQ=;
 b=qPTiGb4nyackmk8uetEVhjFTwI9gNYXuy73vAcheeOkMhtyge/LV1qXiBAnnfL3sa35QsqSQ78f3TEtC2p/yBhirq3frdZ8oh5KarLWXzDIzqG5Nak0ZtS6VH9JQw+tMgxOCK8ZCIQalcr/j3TUy8g9gHcTo26k/gU63a42Xz7g=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7536.namprd04.prod.outlook.com (2603:10b6:a03:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 05:00:19 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 05:00:19 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Pankaj Raghav <pankydev8@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Topic: [PATCH v3] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Index: AQHYPRsQzOpU8qdNN0OMiNDYgGKoaqzPkDqA
Date:   Fri, 25 Mar 2022 05:00:18 +0000
Message-ID: <20220325050017.xh4p736vv6y3wjtu@naota-xeon>
References: <20220321115848.30397-1-p.raghav@samsung.com>
In-Reply-To: <20220321115848.30397-1-p.raghav@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63cd10f1-bec4-4036-7579-08da0e1c5c3a
x-ms-traffictypediagnostic: SJ0PR04MB7536:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB753632D496550A7BFFFCA06F8C1A9@SJ0PR04MB7536.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5vancBipOhxb50ULDc0xDm+tNhxG4+Amg3RFvbDdqWFvtsaIeuRwUV1AdcYWbQNli9soF9PbtgFo5dHKgQ/Ny1K0Qx7OM6H3SrjdkOtp26DIGbVb+mY99T6hDlEXMu30RmHue4EILvRNxBOZTAVB78HgHikYoIekH5pix7KQRdn45TlyJaldWDEFpBRi/bfdKkUry+oJ3jZRrR0U/W5LpFO8ZkSrFGrC5WIfwT9kAzEZLxptZfuD4XNLl6mGADnU9k3eGrhqS6frbDK9YUFn94HnHkL0XYxNZD6E3P3xj6fy36FLf1EjqvOC3a0JmQCd6GQ6xSn7jbaMDGjKA0J9pVt1gZe5/UHeR2GD6uDGm+gWZ6X9jk/97m7VYeMBHMKxrfdDM0q4wJfr3v94L8Uol7yRZZE54PJUJeOozGYNedVohpzp7BQnBK+lVRahR883Lv28BmlOWayIsM4EqSiUHUI3sQU1THCQE7Y778ZYnnw8hqJp8p7X6w9osOCJvGkPLfJSVB8kDpOeruWpyfFuOSw7k79A8jX8IeTTQBaeXQbNqd8V8xGMhM1S+e8t9tq5SRAOn2GjvHKQ7sWKEZtjCCvJi2lr/FM58hTJqnQjBFSL8kqvXblWPjwoZ0Jf9+wIrbBJctFhm52Y9QYEvNBgXNOdih9YEdJp1JwVr/cNlDkAfBnuuAcYqPQ1RGb7Hr12W4R/8WWROhW8BAg5rbMsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(6512007)(38070700005)(6506007)(9686003)(186003)(8936002)(33716001)(54906003)(8676002)(64756008)(71200400001)(4326008)(66476007)(66446008)(66946007)(26005)(86362001)(91956017)(76116006)(6486002)(316002)(508600001)(66556008)(2906002)(5660300002)(6916009)(122000001)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1WsY1tEn/JNy8Nt7Dr1o0SPKnX1pD47Pwd9O9Fu+RHVIdwO+rs2PgZFH12?=
 =?iso-8859-1?Q?053U+rmZYPHyIeHr/urzliMGlIhAoJSMtxCwWu2hhcloFupeREAX8kq7q+?=
 =?iso-8859-1?Q?5uTP64pbQXNnDjVST07I6tjGcPKmvYNMDLzZIOZG7wm544fUKBuvai/xS6?=
 =?iso-8859-1?Q?QseNq0XznGnxitn8cI+ZxESqmLFXrB1dBqf9NcFMnY1CTkWHZl8ATjQ9Vj?=
 =?iso-8859-1?Q?CtksQ1B2IUbeDS53QaoHxTilb6sKz386D7dj0qVvWL6+O7KCQrVMRmGasf?=
 =?iso-8859-1?Q?u7lXI3rQA4o6Hb/sRh1popoPSjvKO9P08AH+5anKoa3SogkF1P035eUFmJ?=
 =?iso-8859-1?Q?U/3hdHYJXE91ejO5qK43jTVtROBhF0fcSbrY9rtOdeXzrZxpovDIQCS42O?=
 =?iso-8859-1?Q?fi+3XXRO4w6dGGH6eL/AUJqkXnxze+4M3QNAOdIa95OyoZqcSe+2aT96zm?=
 =?iso-8859-1?Q?AjGBjOXmqIjRPm8PKfY5Umr7dfQVI9ujaGkhLtIBKMqlVEE94tUjxdjz+o?=
 =?iso-8859-1?Q?lPkDAT3K93FF1Zx2w7UBaVD/pxIRybXhEOjum16DtE0STLhMShDtldrk6z?=
 =?iso-8859-1?Q?OehCDZBDJBx8i/RKAR+UafV/3CqDdiEB7NfKj3vFg6uzrXYD0fsQylwZXo?=
 =?iso-8859-1?Q?3NlIZvmyun9+KNp1ZW1en8R12RRmLgvlUwz5vSGFCra5Ymgqk0iwS493XF?=
 =?iso-8859-1?Q?ABRxu+C2hEROcQg39fvj/bov7snumgdpX6CGfcwIcNmanXEpnIocJqdFCk?=
 =?iso-8859-1?Q?OMg4rdiZbLswzeZRGZqbceDi/4X8qUHbef5Pungnj39VINxUrIr5fmA2dB?=
 =?iso-8859-1?Q?WQpusUD45j2XeIO021UdMVAvBPP6xUpwdinkVDwVIReQNTSsWBZHedQQXz?=
 =?iso-8859-1?Q?iR1imzSpP731yN1bbXro1WAupDcjx1Ctkzk3EQ6djVhOrJ0XN9+ZExBiVB?=
 =?iso-8859-1?Q?nLPLp4u6jMBS4JH6KHDMigVpKXin/17vP5DQ88YP/Nkwk2OxaC+guaGAKL?=
 =?iso-8859-1?Q?4Ai0ZZjX6fMhXtD7AyxtCOa2cp4gDg5bLWqkIJp9uS2lJFtcQzVrEWTns8?=
 =?iso-8859-1?Q?QJdTn+aKmBbnEPwsaeTc4cZPAG65rFW6PvQcauBO4mfKwJYvQneYxnd6Xq?=
 =?iso-8859-1?Q?5onSTNX8FhnMfTDwYVP9/rU2+7Zro+frrIE5kQCZ5cOwQbLOC+VuUIOgTc?=
 =?iso-8859-1?Q?bh6Bvw/Eib2vtRcMq6Nq/AFSGoSD56yUx9biCmeUfZ8ZWSeYLbTcAqgmV1?=
 =?iso-8859-1?Q?g+f8/SWgSr61hrGUMbQWQkmehCq5/ZIX+qSwFko70W+gGySphcais0JQeN?=
 =?iso-8859-1?Q?cGEF9bG8Lmdyo6sMVU1QKksWPhIqAisTPEnZXgmaam3Dr9JSotLMJO1YoE?=
 =?iso-8859-1?Q?t7GoDD8MAxworSqGm02wXL4zSPji4uMHipXSNX4OhaGCZO0Phvacn8CoRR?=
 =?iso-8859-1?Q?D4EuVxYsKPxwkMG1HSzQYfdXlCp6SH3OoUOpGakLh17GB9odp1SEfCvz0y?=
 =?iso-8859-1?Q?xkXCquOZvxy4NwOiMpk48zCgV078uZUXHYMNgVm4r5xg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <92FA825D03B74D47A875094F2FA4F3A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cd10f1-bec4-4036-7579-08da0e1c5c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 05:00:19.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEJ4IHXGD33j+LHX/ydtUr3DISir56vKMVTxAu8QGX2HopbdgORqVtinGKTwXSwHl6CehrSRSLnZqeWAtMOpoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7536
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 21, 2022 at 12:58:48PM +0100, Pankaj Raghav wrote:
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
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

I tried this test, but it didn't work. See below.

> ---
> Changes since v1:
> - Add a filter that can append a 'cap' column for blkzone version <2.37
>   (Naohiro)
> - Extract the capacity from the zone on which the test is performed as a
>   zoned device can have variable zone capacity(Naohiro)
>=20
> Changes since v2:
> - Use btrfs inspect-internal utility to find the first data zone address
> instead of hardcoding. (Naohiro)
>=20
>  common/filter   | 13 +++++++++++++
>  tests/btrfs/237 | 21 +++++++++++++++++----
>  2 files changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/filter b/common/filter
> index 257227c2..5fe86756 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -634,5 +634,18 @@ _filter_bash()
>  	sed -e "s/^bash: line 1: /bash: /"
>  }
> =20
> +#
> +# blkzone report added zone capacity to be printed from v2.37.
> +# This filter will add an extra column 'cap' with the same value of
> +# 'len'(zone size) for blkzone version < 2.37
> +#
> +# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> +# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 .=
.
> +_filter_blkzone_report()
> +{
> +	$AWK_PROG -F "," 'BEGIN{OFS=3D",";} $3 !~ /cap/ {$2=3D$2","$2;} {print;=
}' |\
> +	sed -e 's/len/cap/2'
> +}
> +
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 96940549..cb897416 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -35,8 +35,13 @@ get_data_bg()
>  		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
>  }
> =20
> -zonesize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_secto=
rs)
> -zonesize=3D$((zonesize << 9))
> +get_data_bg_physical()
> +{
> +	# Assumes SINGLE data profile
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
> +		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
> +	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
> +}
> =20
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount -o commit=3D1 # 1s commit time to speed up test
> @@ -49,12 +54,20 @@ if [[ "$uuid" =3D=3D "" ]]; then
>  	exit 1
>  fi
> =20
> +start_data_bg_phy=3D$(get_data_bg_physical)
> +start_data_bg_phy=3D$((data_bg_zone >> 9))

start_data_bg_phy=3D$((start_data_bg_phy >> 9)) ?

> +
> +size=3D$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
> +	_filter_blkzone_report |\
> +	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)

The pattern should be "cap 0x[[:xdigit:]]+" as it is hexadecimal. I
missed this point before.

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
