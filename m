Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1BDC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Feb 2022 06:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiBQGar (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:30:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiBQGaq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Feb 2022 01:30:46 -0500
X-Greylist: delayed 280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 22:30:31 PST
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF32A5983
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 22:30:30 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220217063030usoutp02cbb0c934a7c7ab586d8a6281f705d33d~UfwaR4tRl1724817248usoutp02i;
        Thu, 17 Feb 2022 06:30:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220217063030usoutp02cbb0c934a7c7ab586d8a6281f705d33d~UfwaR4tRl1724817248usoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645079430;
        bh=xRnfAOJcgp/UpHx4KlXxtFy14+rqZjpwncOOQwPzW84=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RKzpQw2hdkFYCgWKu9Mimr2pVm9vFdmVVhK2Ap7F/gquY503cNxsujxmdVD+SGA9T
         c+ZtzMoSBHWBHa0OUJT8ucyj962/veaxxmK1gEZnu9aXuASfX/5gz4FP2DWbpLL5cV
         miJy5UCECm7Xkkyqnt/G4n0fUOEYHJqKtvkXGP+4=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220217063029uscas1p2edc7134f9b21876f4c6f92ed15b1d102~UfwaKS9K33164231642uscas1p2j;
        Thu, 17 Feb 2022 06:30:29 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 88.B7.09744.58BED026; Thu,
        17 Feb 2022 01:30:29 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220217063029uscas1p1fc9062f241c2c14d8c197bd634c4247f~UfwZ7O5dt1942219422uscas1p1c;
        Thu, 17 Feb 2022 06:30:29 +0000 (GMT)
X-AuditID: cbfec36d-891ff70000002610-6c-620deb85766f
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 4F.12.09671.58BED026; Thu,
        17 Feb 2022 01:30:29 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Wed, 16 Feb 2022 22:29:58 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Wed, 16 Feb 2022 22:29:58 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/3] tests/btrfs: use $AWK_PROG instead of awk
Thread-Topic: [PATCH v2 3/3] tests/btrfs: use $AWK_PROG instead of awk
Thread-Index: AQHYIg4q4tPWNXpes0CAdxyj+dlF0ayX0bUA
Date:   Thu, 17 Feb 2022 06:29:58 +0000
Message-ID: <20220217063028.GC93653@bgt-140510-bm01>
In-Reply-To: <20220215014845.4164719-4-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BE8709A42C7184389022E7EA78E8A61@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djX87qtr3mTDJY1G1ucbtnLbvG36x6T
        xY0JTxkdmD02repk8/i8Sc6j/UA3UwBzFJdNSmpOZllqkb5dAldG/68e5oIPmxgr7hxrYm1g
        fDuZsYuRk0NCwETizf9trF2MXBxCAisZJd5sfssI4bQySXQ/W8ICU/WrrQEqsZZR4mrjRWYI
        5yOjROunjWwQzgFGiamL3oG1sAkYSPw+vpEZxBYR0JDYN6GXCcRmFljKKLFtVT6ILSzgKvF/
        XjdUjZvE8ZPfWSBsI4l3tz4CrePgYBFQlTh1RxckzAt0xcvlG8Hu5hSwlHi64CFYK6OAmMT3
        U2ugxotL3HoynwniakGJRbP3MEPYYhL/dj1kg7AVJe5/f8kOUa8jsWD3JzYI205i8Z1frBC2
        tsSyha+ZIfYKSpyc+QQaEpISB1fcYAH5V0JgJYfEu+UNUAkXiZUvzkMtlpa4en0qM0TRKkaJ
        Kd/a2CGczYwSM35dgKqyllj4Zz3TBEaVWUgun4XkqllIrpqF5KpZSK5awMi6ilG8tLg4Nz21
        2DAvtVyvODG3uDQvXS85P3cTIzDZnP53OHcH445bH/UOMTJxMB5ilOBgVhLh/XCQN0mINyWx
        siq1KD++qDQntfgQozQHi5I477LMDYlCAumJJanZqakFqUUwWSYOTqkGpqnHQoIbqx5YG+7q
        8tqy2WN/vpO7ZXX+qX6tznn/I3WKJBI230rUl7vsU6R6K9JpzqMPKndESvV9xVZ3OS0/3CB2
        5K7bxrOxGVI3605oL06vn3Pn+H4v90fPr6300orT1lj+gWXe5zf/aixZ3Tf9P+wkbp0TfMa5
        /0ZatvDKuCMTHohuybc8d3mlxa9TGUkfv33ePGGS63a/1DV/Zuec/vHsssNkNwHHzZLzdFni
        hQ8KXbm8+8xXqaL3lt/bowuNe3nUu5WlhCcpPnTqcvv58VaxwOeeeXu2m7d+NrRx5XkudeFV
        18Ybso6b9XwmbvfMmK1Y/UqkYK1e8c1PmQs4FkT8XxB4bbqMyj27Qxyqc5VYijMSDbWYi4oT
        AV951COlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWS2cA0Ubf1NW+SQfNOYYvTLXvZLf523WOy
        uDHhKaMDs8emVZ1sHp83yXm0H+hmCmCO4rJJSc3JLEst0rdL4Mro/9XDXPBhE2PFnWNNrA2M
        byczdjFyckgImEj8amsAsrk4hARWM0rc37gAyvnIKLHj/zdWCOcAo8Tt7z3sIC1sAgYSv49v
        ZAaxRQQ0JPZN6GUCsZkFljJKbFuVD2ILC7hK/J/XDVXjJnH85HcWCNtI4t2tj0AbODhYBFQl
        Tt3RBQnzAl3xcvlGqMW7GSV23rnKCpLgFLCUeLrgIdgcRgExie+n1kDtEpe49WQ+E8QLAhJL
        9pxnhrBFJV4+/scKYStK3P/+kh2iXkdiwe5PbBC2ncTiO79YIWxtiWULXzNDHCEocXLmExaI
        XkmJgytusExglJiFZN0sJKNmIRk1C8moWUhGLWBkXcUoXlpcnJteUWyYl1quV5yYW1yal66X
        nJ+7iREYpaf/HY7cwXj01ke9Q4xMHIyHGCU4mJVEeD8c5E0S4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzivkOjFeSCA9sSQ1OzW1ILUIJsvEwSnVwMR2p0936qcTnTqBLM4FRmVN+mr6ZZfePmUW
        M3k1b9qtuU+zvr8IvCJXfK/kaK+JRGbB6y/1fGcuyUYH1cw8VtR42fW4zHn3gINNsrl1cx+3
        +vXfWf604El7oZOWju6+9xK/t9aHeb1a0Mr0Kun+kx3LD3YpX7/8NVXM8X6D31qf3afmimjf
        OrnPfKX5Gh6duh9lXx0XzJDwLXGWtMydv1XzYIO2jd/Xq8sO5iw+etbYzOXDhnMG6wNu3ivU
        T/m/zzTulkZwysTzr+ZJL+YR3jIp7oTMgeDeuvQph3RYFyjv0w0wapc44LP2zqLnwfcW2O+/
        s/bwqaub+r8arRQ79vJqq8JP7TlTFryadGrqwvReJZbijERDLeai4kQA+EjiSUEDAAA=
X-CMS-MailID: 20220217063029uscas1p1fc9062f241c2c14d8c197bd634c4247f
CMS-TYPE: 301P
X-CMS-RootMailID: 20220215014856uscas1p25f54ba46af2fe9551019e93965f7f103
References: <20220215014845.4164719-1-mcgrof@kernel.org>
        <CGME20220215014856uscas1p25f54ba46af2fe9551019e93965f7f103@uscas1p2.samsung.com>
        <20220215014845.4164719-4-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 14, 2022 at 05:48:45PM -0800, Luis Chamberlain wrote:
> Use $AWK_PROG instead of awk in case the default awk
> program is not called awk.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  tests/btrfs/001 |  2 +-
>  tests/btrfs/003 |  2 +-
>  tests/btrfs/006 |  6 +++---
>  tests/btrfs/011 |  2 +-
>  tests/btrfs/022 | 12 ++++++------
>  tests/btrfs/027 |  4 ++--
>  tests/btrfs/035 |  4 ++--
>  tests/btrfs/085 |  2 +-
>  tests/btrfs/090 |  2 +-
>  tests/btrfs/124 |  4 ++--
>  tests/btrfs/125 |  6 +++---
>  tests/btrfs/149 |  8 ++++----
>  tests/btrfs/161 |  4 ++--
>  tests/btrfs/162 |  6 +++---
>  tests/btrfs/163 |  6 +++---
>  tests/btrfs/164 |  4 ++--
>  tests/btrfs/175 |  2 +-
>  tests/btrfs/176 |  6 +++---
>  tests/btrfs/181 |  2 +-
>  tests/btrfs/184 |  2 +-
>  tests/btrfs/185 |  8 ++++----
>  tests/btrfs/194 |  4 ++--
>  tests/btrfs/197 |  4 ++--
>  tests/btrfs/198 |  4 ++--
>  tests/btrfs/215 |  4 ++--
>  tests/btrfs/216 |  4 ++--
>  tests/btrfs/218 |  4 ++--
>  tests/btrfs/254 |  4 ++--
>  28 files changed, 61 insertions(+), 61 deletions(-)
>=20
> diff --git a/tests/btrfs/001 b/tests/btrfs/001
> index 000aeb34..6c263999 100755
> --- a/tests/btrfs/001
> +++ b/tests/btrfs/001
> @@ -66,7 +66,7 @@ ls $SCRATCH_MNT
> =20
>  # Test listing the subvolumes
>  echo "Listing subvolumes"
> -$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> =20
>  # Delete the snapshot
>  $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/snap | _filter_btrfs_subv=
ol_delete
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index 0aa4c991..cf605730 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -167,7 +167,7 @@ _test_remove()
>  	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
> =20
>  	# pick last dev in the list
> -	dev_del=3D`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
> +	dev_del=3D`echo ${SCRATCH_DEV_POOL} | $AWK_PROG '{print $NF}'`
>  	$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs de=
vice delete failed"
>  	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV 2>&1 | grep $dev_del >> $=
seqres.full && _fail "btrfs still shows the deleted dev"
>  	_scratch_unmount
> diff --git a/tests/btrfs/006 b/tests/btrfs/006
> index fd0f89e2..bff6f980 100755
> --- a/tests/btrfs/006
> +++ b/tests/btrfs/006
> @@ -20,8 +20,8 @@ _supported_fs btrfs
>  _require_scratch
>  _require_scratch_dev_pool
> =20
> -FIRST_POOL_DEV=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> -LAST_POOL_DEV=3D`echo $SCRATCH_DEV_POOL | awk '{print $NF}'`
> +FIRST_POOL_DEV=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
> +LAST_POOL_DEV=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF}'`
>  TOTAL_DEVS=3D`echo $SCRATCH_DEV_POOL | wc -w`
>  LABEL=3DTestLabel.$seq
> =20
> @@ -40,7 +40,7 @@ _scratch_mount
> =20
>  echo "=3D=3D Show filesystem by label"
>  $BTRFS_UTIL_PROG filesystem show $LABEL | _filter_btrfs_filesystem_show =
$TOTAL_DEVS
> -UUID=3D`$BTRFS_UTIL_PROG filesystem show $LABEL | grep uuid: | awk '{pri=
nt $NF}'`
> +UUID=3D`$BTRFS_UTIL_PROG filesystem show $LABEL | grep uuid: | $AWK_PROG=
 '{print $NF}'`
> =20
>  echo "UUID $UUID" >> $seqres.full
> =20
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 05ea96b9..0665e126 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -107,7 +107,7 @@ workout()
>  	local num_devs4raid=3D"$2"
>  	local with_cancel=3D"$3"
>  	local fssize=3D"$4"
> -	local source_dev=3D"`echo ${SCRATCH_DEV_POOL} | awk '{print $1}'`"
> +	local source_dev=3D"`echo ${SCRATCH_DEV_POOL} | $AWK_PROG '{print $1}'`=
"
>  	local quick=3D"quick"
> =20
>  	[[ $fssize !=3D 64 ]] && quick=3D"thorough"
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index bfd6ac7f..e2d37b09 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -35,12 +35,12 @@ _basic_test()
>  	# the shared values of both the original subvol and snapshot should
>  	# match
>  	a_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0=
/$subvolid")
> -	a_shared=3D$(echo $a_shared | awk '{ print $2 }')
> +	a_shared=3D$(echo $a_shared | $AWK_PROG '{ print $2 }')
>  	echo "subvol a id=3D$subvolid" >> $seqres.full
>  	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
>  	echo "subvol b id=3D$subvolid" >> $seqres.full
>  	b_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0=
/$subvolid")
> -	b_shared=3D$(echo $b_shared | awk '{ print $2 }')
> +	b_shared=3D$(echo $b_shared | $AWK_PROG '{ print $2 }')
>  	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT >> $seqres.full
>  	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
>  }
> @@ -59,14 +59,14 @@ _rescan_test()
>  	sync
>  	output=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$=
subvolid")
>  	echo "qgroup values before rescan: $output" >> $seqres.full
> -	refer=3D$(echo $output | awk '{ print $2 }')
> -	excl=3D$(echo $output | awk '{ print $3 }')
> +	refer=3D$(echo $output | $AWK_PROG '{ print $2 }')
> +	excl=3D$(echo $output | $AWK_PROG '{ print $3 }')
>  	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>  	output=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$=
subvolid")
>  	echo "qgroup values after rescan: $output" >> $seqres.full
> -	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
> +	[ $refer -eq $(echo $output | $AWK_PROG '{ print $2 }') ] || \
>  		_fail "reference values don't match after rescan"
> -	[ $excl -eq $(echo $output | awk '{ print $3 }') ] || \
> +	[ $excl -eq $(echo $output | $AWK_PROG '{ print $3 }') ] || \
>  		_fail "exclusive values don't match after rescan"
>  }
> =20
> diff --git a/tests/btrfs/027 b/tests/btrfs/027
> index e8679248..46c14b9c 100755
> --- a/tests/btrfs/027
> +++ b/tests/btrfs/027
> @@ -45,8 +45,8 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
> =20
> -	local missing_dev=3D`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
> -	local missing_dev_id=3D`$BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT |=
 grep $missing_dev | awk '{print $2}'`
> +	local missing_dev=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
> +	local missing_dev_id=3D`$BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT |=
 grep $missing_dev | $AWK_PROG '{print $2}'`
> =20
>  	# get some data on the filesystem so there's something to replace
>  	_ddt of=3D"$SCRATCH_MNT"/file1 bs=3D1M count=3D1 >> $seqres.full 2>&1
> diff --git a/tests/btrfs/035 b/tests/btrfs/035
> index 4ddc5bf6..7e644ecf 100755
> --- a/tests/btrfs/035
> +++ b/tests/btrfs/035
> @@ -33,7 +33,7 @@ echo -n "$src_str" > $SCRATCH_MNT/src
> =20
>  $CLONER_PROG $SCRATCH_MNT/src $SCRATCH_MNT/src.clone2
> =20
> -snap_src_sz=3D`ls -lah $SCRATCH_MNT/src.clone1 | awk '{print $5}'`
> +snap_src_sz=3D`ls -lah $SCRATCH_MNT/src.clone1 | $AWK_PROG '{print $5}'`
>  echo "attempting ioctl (src.clone1 src)"
>  $CLONER_PROG -s 0 -d 0 -l ${snap_src_sz} \
>  	$SCRATCH_MNT/src.clone1 $SCRATCH_MNT/src | _filter_btrfs_cloner_error
> @@ -48,7 +48,7 @@ $CLONER_PROG -s 0 -d 0 -l ${snap_src_sz} \
>  echo "File src data after attempt to clone from src.clone1 into src:"
>  od -t x1 $SCRATCH_MNT/src
> =20
> -snap_src_sz=3D`ls -lah $SCRATCH_MNT/src.clone2 | awk '{print $5}'`
> +snap_src_sz=3D`ls -lah $SCRATCH_MNT/src.clone2 | $AWK_PROG '{print $5}'`
>  echo "attempting ioctl (src.clone2 src)"
>  $CLONER_PROG -s 0 -d 0 -l ${snap_src_sz} \
>  	$SCRATCH_MNT/src.clone2 $SCRATCH_MNT/src
> diff --git a/tests/btrfs/085 b/tests/btrfs/085
> index cef4da28..bcbf1a05 100755
> --- a/tests/btrfs/085
> +++ b/tests/btrfs/085
> @@ -112,7 +112,7 @@ new_subvolume()
>  new_default()
>  {
>  	new_subvolume
> -	SUB=3D$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT |awk '{print $2}')
> +	SUB=3D$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{prin=
t $2}')
>  	_run_btrfs_util_prog subvolume set-default $SUB $SCRATCH_MNT
> =20
>  	_unmount_flakey
> diff --git a/tests/btrfs/090 b/tests/btrfs/090
> index 766c24cd..3693a3ad 100755
> --- a/tests/btrfs/090
> +++ b/tests/btrfs/090
> @@ -26,7 +26,7 @@ _supported_fs btrfs
>  _require_scratch
>  _require_scratch_dev_pool
> =20
> -FIRST_POOL_DEV=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> +FIRST_POOL_DEV=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
>  TOTAL_DEVS=3D`echo $SCRATCH_DEV_POOL | wc -w`
> =20
>  _scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> diff --git a/tests/btrfs/124 b/tests/btrfs/124
> index 8771a3c1..e8d77aaa 100755
> --- a/tests/btrfs/124
> +++ b/tests/btrfs/124
> @@ -45,8 +45,8 @@ _require_btrfs_forget_or_module_loadable
> =20
>  _scratch_dev_pool_get 2
> =20
> -dev1=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> -dev2=3D`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
> +dev1=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
> +dev2=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
> =20
>  # RAID1 is not supported on zoned btrfs
>  _require_non_zoned_device "$dev1"
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index b6a28f5c..44ba49ec 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -45,9 +45,9 @@ _require_btrfs_fs_feature raid56
> =20
>  _scratch_dev_pool_get 3
> =20
> -dev1=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> -dev2=3D`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
> -dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
> +dev1=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
> +dev2=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
> +dev3=3D`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}'`
> =20
>  echo dev1=3D$dev1 >> $seqres.full
>  echo dev2=3D$dev2 >> $seqres.full
> diff --git a/tests/btrfs/149 b/tests/btrfs/149
> index 176d8ec5..d6dce45d 100755
> --- a/tests/btrfs/149
> +++ b/tests/btrfs/149
> @@ -75,8 +75,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
>  $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap =
\
>  		 $SCRATCH_MNT/mysnap2 2>&1 >/dev/null | _filter_scratch
> =20
> -sum_src_snap1=3D$(md5sum $SCRATCH_MNT/mysnap1/foobar | awk '{print $1}')
> -sum_src_snap2=3D$(md5sum $SCRATCH_MNT/mysnap2/foobar | awk '{print $1}')
> +sum_src_snap1=3D$(md5sum $SCRATCH_MNT/mysnap1/foobar | $AWK_PROG '{print=
 $1}')
> +sum_src_snap2=3D$(md5sum $SCRATCH_MNT/mysnap2/foobar | $AWK_PROG '{print=
 $1}')
>  echo "File digests in the original filesystem:" >> $seqres.full
>  echo "md5sum $SCRATCH_MNT/mysnap1/foobar " $sum_src_snap1 >> $seqres.ful=
l
>  echo "md5sum $SCRATCH_MNT/mysnap2/foobar " $sum_src_snap2 >> $seqres.ful=
l
> @@ -90,8 +90,8 @@ _scratch_mount "-o compress"
>  $BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/n=
ull
>  $BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/n=
ull
> =20
> -sum_dest_snap1=3D$(md5sum $SCRATCH_MNT/mysnap1/foobar | awk '{print $1}'=
)
> -sum_dest_snap2=3D$(md5sum $SCRATCH_MNT/mysnap2/foobar | awk '{print $1}'=
)
> +sum_dest_snap1=3D$(md5sum $SCRATCH_MNT/mysnap1/foobar | $AWK_PROG '{prin=
t $1}')
> +sum_dest_snap2=3D$(md5sum $SCRATCH_MNT/mysnap2/foobar | $AWK_PROG '{prin=
t $1}')
>  echo "File digests in the new filesystem:" | tee -a $seqres.full
>  echo "md5sum $SCRATCH_MNT/mysnap1/foobar " $sum_src_snap1 >> $seqres.ful=
l
>  echo "md5sum $SCRATCH_MNT/mysnap2/foobar " $sum_src_snap2 >> $seqres.ful=
l
> diff --git a/tests/btrfs/161 b/tests/btrfs/161
> index ed5b67fa..5aac8fe9 100755
> --- a/tests/btrfs/161
> +++ b/tests/btrfs/161
> @@ -23,8 +23,8 @@ _require_scratch_dev_pool 2
> =20
>  _scratch_dev_pool_get 2
> =20
> -dev_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -dev_sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> =20
>  create_seed()
>  {
> diff --git a/tests/btrfs/162 b/tests/btrfs/162
> index 7680e1e4..1d8dbf95 100755
> --- a/tests/btrfs/162
> +++ b/tests/btrfs/162
> @@ -25,9 +25,9 @@ _require_scratch_dev_pool 3
> =20
>  _scratch_dev_pool_get 3
> =20
> -dev_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -dev_sprout_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> -dev_sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')
> =20
>  create_seed()
>  {
> diff --git a/tests/btrfs/163 b/tests/btrfs/163
> index 59f0461b..c2a04791 100755
> --- a/tests/btrfs/163
> +++ b/tests/btrfs/163
> @@ -38,9 +38,9 @@ _require_btrfs_forget_or_module_loadable
> =20
>  _scratch_dev_pool_get 3
> =20
> -dev_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -dev_sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> -dev_replace_tgt=3D$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +dev_replace_tgt=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')
> =20
>  create_seed()
>  {
> diff --git a/tests/btrfs/164 b/tests/btrfs/164
> index 8fd6ab62..43c55c16 100755
> --- a/tests/btrfs/164
> +++ b/tests/btrfs/164
> @@ -29,8 +29,8 @@ _require_scratch_dev_pool 2
> =20
>  _scratch_dev_pool_get 2
> =20
> -dev_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -dev_sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> =20
>  create_seed()
>  {
> diff --git a/tests/btrfs/175 b/tests/btrfs/175
> index dc6c1921..db877d41 100755
> --- a/tests/btrfs/175
> +++ b/tests/btrfs/175
> @@ -48,7 +48,7 @@ _scratch_mount
>  # Create the swap file, then add the device. That way we know it's all o=
n one
>  # device.
>  _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/n=
ull
> -scratch_dev2=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
> +scratch_dev2=3D"$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $2 }')=
"
>  $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres=
.full
>  swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
>  swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
> diff --git a/tests/btrfs/176 b/tests/btrfs/176
> index 33f9a061..7080d860 100755
> --- a/tests/btrfs/176
> +++ b/tests/btrfs/176
> @@ -22,9 +22,9 @@ _require_scratch_swapfile
>  # We check the filesystem manually because we move devices around.
>  rm -f "${RESULT_DIR}/require_scratch"
> =20
> -scratch_dev1=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $1 }')"
> -scratch_dev2=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
> -scratch_dev3=3D"$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
> +scratch_dev1=3D"$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $1 }')=
"
> +scratch_dev2=3D"$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $2 }')=
"
> +scratch_dev3=3D"$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $3 }')=
"
> =20
>  echo "Remove device"
>  _scratch_mkfs >> $seqres.full 2>&1
> diff --git a/tests/btrfs/181 b/tests/btrfs/181
> index 843413fc..8a3c3c17 100755
> --- a/tests/btrfs/181
> +++ b/tests/btrfs/181
> @@ -32,7 +32,7 @@ nr_files=3D1024
>  get_super_gen()
>  {
>  	local ret=3D$($BTRFS_UTIL_PROG inspect dump-super "$SCRATCH_DEV" |\
> -		grep ^generation | awk '{print $2}')
> +		grep ^generation | $AWK_PROG '{print $2}')
>  	if [ -z $ret ]; then
>  		_fail "failed to get super block generation"
>  	fi
> diff --git a/tests/btrfs/184 b/tests/btrfs/184
> index 2efcfb64..ee43a8d3 100755
> --- a/tests/btrfs/184
> +++ b/tests/btrfs/184
> @@ -27,7 +27,7 @@ _scratch_pool_mkfs "-d raid0 -m raid0" >> $seqres.full =
2>&1 || _fail "mkfs faile
>  _scratch_mount
> =20
>  # pick last dev in the list
> -dev_del=3D`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
> +dev_del=3D`echo ${SCRATCH_DEV_POOL} | $AWK_PROG '{print $NF}'`
>  $BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs dev=
ice delete failed"
>  for i in {0..2}; do
>  	output=3D$($BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del =
2>&1)
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index 7850f1bc..ee97b626 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -28,8 +28,8 @@ _supported_fs btrfs
>  _require_scratch_dev_pool 2
>  _scratch_dev_pool_get 2
> =20
> -device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +device_1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +device_2=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> =20
>  echo device_1=3D$device_1 device_2=3D$device_2 >> $seqres.full
> =20
> @@ -38,7 +38,7 @@ mkdir $mnt
>  _mkfs_dev $device_1
>  _mount $device_1 $mnt
> =20
> -[[ $(findmnt $mnt | grep -v TARGET | awk '{print $2}') !=3D $device_1 ]]=
 && \
> +[[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') !=3D $devic=
e_1 ]] && \
>  						_fail "mounted device changed"
> =20
>  for sb_bytenr in 65536 67108864; do
> @@ -53,7 +53,7 @@ done
>  $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
>  [[ $? !=3D 1 ]] && _fail "cloned device scan should fail"
> =20
> -[[ $(findmnt $mnt | grep -v TARGET | awk '{print $2}') !=3D $device_1 ]]=
 && \
> +[[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') !=3D $devic=
e_1 ]] && \
>  						_fail "mounted device changed"
> =20
>  # Original device scan should be successful
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> index 2431692b..228576e4 100755
> --- a/tests/btrfs/194
> +++ b/tests/btrfs/194
> @@ -29,8 +29,8 @@ if [ $(get_page_size) !=3D 4096 ]; then
>  	_notrun "This test need 4k page size"
>  fi
> =20
> -device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +device_1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +device_2=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> =20
>  echo device_1=3D$device_1 device_2=3D$device_2 >> $seqres.full
> =20
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index 22b37b4b..d259fd99 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -54,11 +54,11 @@ workout()
> =20
>  	# don't test with the first device as auto fs check (_check_scratch_fs)
>  	# picks the first device
> -	device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +	device_1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
>  	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
>  		$seqres.full
> =20
> -	device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +	device_2=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>  	_mount -o degraded $device_2 $SCRATCH_MNT
>  	# Check if missing device is reported as in the .out
>  	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index 035c63fd..1edc8330 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -39,10 +39,10 @@ workout()
> =20
>  	# don't test with the first device as auto fs check (_check_scratch_fs)
>  	# picks the first device
> -	device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +	device_1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
>  	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
> =20
> -	device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +	device_2=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>  	_mount -o degraded $device_2 $SCRATCH_MNT
>  	# Check if missing device is reported as in the 196.out
>  	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index 9ee1a8b3..cbcd60e0 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -72,14 +72,14 @@ echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb
>  # buffered reads whould result in 2 * sectors_per_page errors since read=
ahead code always submits
>  # at least 1 page worth of IO and it will be counted as error(s) as well
>  $XFS_IO_PROG -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" >=
 /dev/null 2>&1
> -errs=3D$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_e=
rrs/ { print $2 }')
> +errs=3D$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | $AWK_PROG '/corrup=
tion_errs/ { print $2 }')
>  if [ $errs -ne $((2 * $sectors_per_page)) ]; then
>  	_fail "Errors: $errs expected: 2"
>  fi
> =20
>  # DIO does check every sector
>  $XFS_IO_PROG -d -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar=
" > /dev/null 2>&1
> -errs=3D$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_e=
rrs/ { print $2 }')
> +errs=3D$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | $AWK_PROG '/corrup=
tion_errs/ { print $2 }')
>  if [ $errs -ne $((6 * $sectors_per_page)) ]; then
>  	_fail "Errors: $errs expected: 6"
>  fi
> diff --git a/tests/btrfs/216 b/tests/btrfs/216
> index 5d6cf902..2ed48668 100755
> --- a/tests/btrfs/216
> +++ b/tests/btrfs/216
> @@ -21,8 +21,8 @@ _require_scratch_dev_pool 2
> =20
>  _scratch_dev_pool_get 2
> =20
> -seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> =20
>  _mkfs_dev $seed
>  $BTRFS_TUNE_PROG -S 1 $seed
> diff --git a/tests/btrfs/218 b/tests/btrfs/218
> index 83ec785e..672ad0ff 100755
> --- a/tests/btrfs/218
> +++ b/tests/btrfs/218
> @@ -27,8 +27,8 @@ _require_scratch_dev_pool 2
> =20
>  _scratch_dev_pool_get 2
> =20
> -dev_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -dev_sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> =20
>  # Create the seed device
>  _mkfs_dev $dev_seed
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> index 2f3ae50f..5d6e33f4 100755
> --- a/tests/btrfs/254
> +++ b/tests/btrfs/254
> @@ -81,8 +81,8 @@ test_add_device()
>  {
>  	setup_dmdev
>  	dmdev=3D$(realpath $lvdev)
> -	scratch_dev2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> -	scratch_dev3=3D$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
> +	scratch_dev2=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +	scratch_dev3=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')
> =20
>  	_mkfs_dev $scratch_dev3
>  	_mount $scratch_dev3 $seq_mnt
> --=20
> 2.34.1
>

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
