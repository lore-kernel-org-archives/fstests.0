Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E55C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Mar 2022 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244958AbiCXHsY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Mar 2022 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiCXHsX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Mar 2022 03:48:23 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45D972BD
        for <fstests@vger.kernel.org>; Thu, 24 Mar 2022 00:46:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220324074647euoutp02442ac116b59fb853de15ae393105a505~fQYBDUObk1317813178euoutp028
        for <fstests@vger.kernel.org>; Thu, 24 Mar 2022 07:46:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220324074647euoutp02442ac116b59fb853de15ae393105a505~fQYBDUObk1317813178euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648108007;
        bh=ODKlqIi2/7Frzo4dNW8dBD0tWiz3oKpNQpoavFeHHpE=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=hcT2p7aBSkDAwBi0C00g8E5Nuaj7/JBheLT/MN59w55gpAGgNSb/yom3TThBjMNXi
         qRg2p8HyQf3QZZNSZeByeiPD4nGurBvpDIZICXnT6Ucqbvem4q0HgLC7DwBzBHY+Q5
         lEWGdTOrU/YkNQB9BtdqDd0cFvX8VgdJSSYDGyFg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220324074647eucas1p1ca5884c9851be9ef939419a9621381cf~fQYA5CcVq2506225062eucas1p1b;
        Thu, 24 Mar 2022 07:46:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0C.37.10009.7E12C326; Thu, 24
        Mar 2022 07:46:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220324074647eucas1p1c1d67cf73cc7bcd998521ef6de963fe9~fQYAfZM2y2506225062eucas1p1a;
        Thu, 24 Mar 2022 07:46:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220324074647eusmtrp2ec72fa221d23a85b10c37e2472824ab8~fQYAen_x52029420294eusmtrp2Y;
        Thu, 24 Mar 2022 07:46:47 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-70-623c21e75182
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D6.AC.09404.7E12C326; Thu, 24
        Mar 2022 07:46:47 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324074647eusmtip2d6cc32ccb8a83069c1ddb1552646e09a~fQYAW1aBv3117231172eusmtip2U;
        Thu, 24 Mar 2022 07:46:47 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 24 Mar 2022 07:46:41 +0000
Message-ID: <25dc3711-a531-734a-3703-d1ad54270a4c@samsung.com>
Date:   Thu, 24 Mar 2022 08:46:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH v3] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Content-Language: en-US
To:     Pankaj Raghav <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <fstests@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220321115848.30397-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7rPFW2SDG5flrP4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRXDYpqTmZZalF+nYJXBkdB9awFKyVqWhqjWtgPC/WxcjJISFgItFxpJ+1i5GLQ0hgBaPE
        jM6N7BDOF0aJl5MOMkI4nxklpl9pYIdpmbHyHxOILSSwnFHi/0duuKJvXS3MEIldjBLHHyWB
        2LwCdhK/zm5nBbFZBFQlHu25wwgRF5Q4OfMJC4gtKhAh8fLIX7ChwgIZEmeOrACrZxYQl7j1
        ZD4TyAIRgfOMErMuzgU7iVlgN6PEqVkPgU7i4GAT0JJo7AS7jlPASuLjvMdMEM2aEq3bf7ND
        2PIS29/OYYb4QEni2vOnLBB2rcSpLbfAFkgI/OeQmL3qNlSRi8SvUyuhXhaWeHV8C5QtI/F/
        53yohn5Giaktf6CcGYwSPYc3M4FcJCFgLdF3JgfCdJQ4dLcOwuSTuPFWEOIePolJ26YzT2BU
        nYUUFrOQ/DwLyQuzkLywgJFlFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAaOv3v+Kcd
        jHNffdQ7xMjEwXiIUYKDWUmE9/5l6yQh3pTEyqrUovz4otKc1OJDjNIcLErivMmZGxKFBNIT
        S1KzU1MLUotgskwcnFINTM5rfT/O3vrPQvLPkzjPRI1F2rld1pd2lW5XuHD+/1Lzoq8nWO4s
        3DXhzwabw61h34KPvTpdlG73eru+0aqlj7kvf4+5l3f9dMXTK5/326eqnwj5LDO1i3+r8/uN
        PlKy3pdqDOX/ZH05dthMNOYVY88fsy0V1pLzBNZtjLLSWHT1fbPunU6BX4K/kw60+gnwtaVV
        5svt1S+IO+n4ceINO5ZLrYLHH/zyYXNMW56eYmPC68ux1zv7rpJGzAQdF9E1sw/tSdHbklj8
        tMNwY5nrKqu63F2HzXezOfD6nLr+f3t+hUWZ6LeKOcw7Tx/OOPj1cepJ22/bmYSORXNvq5m2
        19u5TkDLc4fHroeu55/bOiqxFGckGmoxFxUnAgBWjMBDsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7rPFW2SDD5tYbf4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkd
        B9awFKyVqWhqjWtgPC/WxcjJISFgIjFj5T+mLkYuDiGBpYwS72YdYYFIyEh8uvKRHcIWlvhz
        rYsNougjo8TaLVOhnF2MEkf2tIJ18ArYSfw6u50VxGYRUJV4tOcOI0RcUOLkzCdgNaICERJt
        y6Ywg9jCAhkSZ46sAKtnFhCXuPVkPtgZIgLnGSV6/p8Dc5gFdjNKnJr1kB1iXS+jxJ+NW4Ac
        Dg42AS2Jxk6w+zgFrCQ+znvMBDFJU6J1+292CFteYvvbOcwQPyhJXHv+FOq3WonPf58xTmAU
        nYXkwFlIDpmFZNQsJKMWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzgbcd+btnBuPLV
        R71DjEwcjIcYJTiYlUR471+2ThLiTUmsrEotyo8vKs1JLT7EaAoMpYnMUqLJ+cAUklcSb2hm
        YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwKS5eI2K/Jk7/uL20zsjI6ZJ
        /38oE3u6XiNjQRJ3tlK2RFL88tnMpe55Cp+dp7Qt2ND4/m9j5KvqlmPLdrIwLvonK8OhO1ND
        5G2bWHr1sW/zlHIkvJ6tKPsqp5n/xnSOpf1u8eVbnB7H/5i6WO+NxSe5jNR5s/PWv8lwdpJz
        fDH/YW0kd49ZUmfAae/oov3cfYrmBm9XvDJ9nLHsjXJ9Wn2S488y+SfMrv+Lry79scZjv4+A
        /zL9Oerf9JuOcO7JvlrwvdZ5ze1Ym+m9NwK8mttsDG1+LO/dvuZ2c6vw8bTOF4L3DxscuXdp
        3u3oxWtY51dyndFwLJDbfMlJ6NTCa71rI5su3Mt8F6Zx4nXxNyWW4oxEQy3mouJEAOKXh8dp
        AwAA
X-CMS-MailID: 20220324074647eucas1p1c1d67cf73cc7bcd998521ef6de963fe9
X-Msg-Generator: CA
X-RootMTR: 20220321115901eucas1p1e6f4d9e551efefcc7cef20b2be764bf2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220321115901eucas1p1e6f4d9e551efefcc7cef20b2be764bf2
References: <CGME20220321115901eucas1p1e6f4d9e551efefcc7cef20b2be764bf2@eucas1p1.samsung.com>
        <20220321115848.30397-1-p.raghav@samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

friendly ping....

On 2022-03-21 12:58, Pankaj Raghav wrote:
> This test will break when zone capacity != zone size because the
> calculation of the size to be filled is done using zone_size instead of
> the actual capacity available per zone. Fix it by using zone capacity.
> 
> As a zoned device can have variable capacity, use the btrfs utility to
> get the zone capacity from the first data block group that the test will
> be performed on.
> 
> The support to extract zone capacity was added to blkzone only from
> version 2.37. So zcap will be used only when the blkzone version is
> greater or equal to 2.37.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Changes since v1:
> - Add a filter that can append a 'cap' column for blkzone version <2.37
>   (Naohiro)
> - Extract the capacity from the zone on which the test is performed as a
>   zoned device can have variable zone capacity(Naohiro)
> 
> Changes since v2:
> - Use btrfs inspect-internal utility to find the first data zone address
> instead of hardcoding. (Naohiro)
> 
>  common/filter   | 13 +++++++++++++
>  tests/btrfs/237 | 21 +++++++++++++++++----
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 257227c2..5fe86756 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -634,5 +634,18 @@ _filter_bash()
>  	sed -e "s/^bash: line 1: /bash: /"
>  }
>  
> +#
> +# blkzone report added zone capacity to be printed from v2.37.
> +# This filter will add an extra column 'cap' with the same value of
> +# 'len'(zone size) for blkzone version < 2.37
> +#
> +# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> +# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
> +_filter_blkzone_report()
> +{
> +	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
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
>  
> -zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
> -zonesize=$((zonesize << 9))
> +get_data_bg_physical()
> +{
> +	# Assumes SINGLE data profile
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
> +		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
> +	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
> +}
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount -o commit=1 # 1s commit time to speed up test
> @@ -49,12 +54,20 @@ if [[ "$uuid" == "" ]]; then
>  	exit 1
>  fi
>  
> +start_data_bg_phy=$(get_data_bg_physical)
> +start_data_bg_phy=$((data_bg_zone >> 9))
> +
> +size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
> +	_filter_blkzone_report |\
> +	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
> +size=$((size << 9))
> +
>  reclaim_threshold=75
>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>  fill_percent=$((reclaim_threshold + 2))
>  rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
> -fill_size=$((zonesize * fill_percent / 100))
> -rest=$((zonesize * rest_percent / 100))
> +fill_size=$((size * fill_percent / 100))
> +rest=$((size * rest_percent / 100))
>  
>  # step 1, fill FS over $fillsize
>  $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full

-- 
Regards,
Pankaj
