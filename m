Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFFC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Apr 2022 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358775AbiDDK45 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358034AbiDDK4z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2022 06:56:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1503D1C8
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 03:54:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220404105451euoutp02f1b33d3fc11a5bdb7910ae59f4084330~irCW7rqQ10409004090euoutp02j
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 10:54:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220404105451euoutp02f1b33d3fc11a5bdb7910ae59f4084330~irCW7rqQ10409004090euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649069691;
        bh=mhGuMWCxl5uD5jeco4oJ6vSFuSBLC4b2IhfAwAO4CFA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=lbsUPIP798DS9KJgGEv1LbGfzEnrGQmTJgRxtpchz+hwdR9f8Qxo3dEBthcS1QVxM
         BBzU7m8JSEqvSekWMOS+eiUgZF0mRhXwoqtlAxQ+1HflcTgeZxocbCyC/ZwZDbmphm
         /RRPTA98m1hROEb1L/kExbgqJXPhhaNL63y4SlVg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220404105451eucas1p1d6ab7c7f5afe16f3687ae84dfede4851~irCWrA6_a2048320483eucas1p1R;
        Mon,  4 Apr 2022 10:54:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B1.43.09887.B7ECA426; Mon,  4
        Apr 2022 11:54:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220404105450eucas1p22ce60fb78dd331764f59bb5a28dac5c3~irCWMuQ8T2711727117eucas1p23;
        Mon,  4 Apr 2022 10:54:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220404105450eusmtrp1a432b4d1a806778c7cc1914911fee698~irCWLpRJY1081010810eusmtrp1G;
        Mon,  4 Apr 2022 10:54:50 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-30-624ace7b6d5f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.C2.09522.A7ECA426; Mon,  4
        Apr 2022 11:54:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220404105450eusmtip187264286de5610a8a5a4c245f3b63cc0~irCV-lTx10900909009eusmtip1f;
        Mon,  4 Apr 2022 10:54:50 +0000 (GMT)
Received: from [106.110.32.130] (106.110.32.130) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 4 Apr 2022 11:54:47 +0100
Message-ID: <47166561-4266-ec1d-0c9f-10d73ab03fed@samsung.com>
Date:   Mon, 4 Apr 2022 12:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.7.0
Subject: Re: [PATCH v4] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <fstests@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220325101908.127071-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7rV57ySDA6uFrT4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRXDYpqTmZZalF+nYJXBmbL+1gKvggU7F9VjtrA2ObeBcjJ4eEgIlE14rjbF2MXBxCAisY
        JTYu+s4GkhAS+MIoseiwEUTiM6PEhAnTWGA6vk2+yw6RWM4oMen2Bia4qt5lX6Ayuxgl3m84
        BtbCK2AncezpbDCbRUBFoufsFnaIuKDEyZlPwOKiAhESv249AopzcAgLZEgsnq4IEmYWEJe4
        9WQ+2AIRgVWMEnvfrGMGcZgF7jFKtBw+yQzSwCagJdHYCTaTU8BaYsq7e6wQzZoSrdt/s0PY
        8hLb384BK5cQUJKYfVkP4ptaiVNbboHNlxBo5pRY8PQ0O0TCReLy9g5GCFtY4tXxLVBxGYnT
        k3ugQVEt8fTGb2aI5hZGif6d69kgFlhL9J3JgahxlLi87z0rRJhP4sZbQYhz+CQmbZvOPIFR
        dRZSSMxC8vIsJB/MQvLBAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFp6PS/4192
        MC5/9VHvECMTB+MhRgkOZiUR3pwgzyQh3pTEyqrUovz4otKc1OJDjNIcLErivMmZGxKFBNIT
        S1KzU1MLUotgskwcnFINTGt9Os5HLgiR2Ku1y73+2dNFosznp6YzPlDes2/+n2n7DpWpFZ3O
        uauupSe2NGmC/oeV3sfZdIXe9Nw0fKwVdnfSjPRrVoVSlTO/Htua0JTZUfupye/aQzsNzk0u
        a36tmFet8kquriE98JX6T+NifUGBhKvNiX/Wei0vczpixXesV3pBJvv5glWdy8r2vWY4oNYa
        EHk5KsSKX/t/yf6D3Xcs1vi6Vv/m0ii9fVLtD3vXsftHBed8c5+52r3mulDlvzhP/z7bvO2J
        T1IfRtX01VS/5lfbt1CiadoktQ0f+Y4tP7LkSav93tNvul0Vsh5xVZ8O0VWwUl/8snWNn/8T
        zduR/J1/D4WY8TL1CP+XUGIpzkg01GIuKk4EAHzW3SKyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7pV57ySDP6f0bb4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmb
        L+1gKvggU7F9VjtrA2ObeBcjJ4eEgInEt8l32bsYuTiEBJYySrReu8EOkZCR+HTlI5QtLPHn
        WhcbRNFHRolFv+czQTi7GCV6rt1iBaniFbCTOPZ0NguIzSKgItFzdgs7RFxQ4uTMJ2BxUYEI
        iWW7pgLZHBzCAhkSi6crgoSZBcQlbj2BmCkisIpRYu+bdcwQiXuMEjv/G0Is62OUuNM0lxWk
        mU1AS6KxE2w+p4C1xJR391gh6jUlWrf/Zoew5SW2v53DDFIuIaAkMfuyHsQztRKf/z5jnMAo
        OgvJdbOQnDELyaRZSCYtYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERi924793LyDcd6r
        j3qHGJk4GA8xSnAwK4nw5gR5JgnxpiRWVqUW5ccXleakFh9iNAUG0URmKdHkfGD6yCuJNzQz
        MDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYMq7tG1n0/xS97ybN5yiy5I3
        +9xf7W+g27YyOm/jTN5nTJoFCRvuLTLdsVqmaI/QoyfehsuWvumZXthmGGVjd8dVuTDyy6EA
        5Rs9m26uOO6lcMpjEefrV/fqnG0mfGbPMXHSuBW+PeGjW/b8E6xBFa9XeK1+GH7/j6vAj4I9
        bi7PDz56/PWfQ5d+bY7UIomGpCtOx4um/XaqO3bp0wHTNsc5ymtt9txyv7p4q5e4udjGpU4b
        d959fTb7aaNAxnWXEz5qC1SdKqsP88fVNUrr1RldujpXzUEw4/YMicsx+3Ye7LDMLY75IPf3
        x+aUb+Frtsg4XnAw/zzL3O7l2dfqmfPj9qlHPZ03b4aQmqjHrGYlluKMREMt5qLiRACrH/1S
        ZwMAAA==
X-CMS-MailID: 20220404105450eucas1p22ce60fb78dd331764f59bb5a28dac5c3
X-Msg-Generator: CA
X-RootMTR: 20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20
References: <CGME20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20@eucas1p2.samsung.com>
        <20220325101908.127071-1-p.raghav@samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

ping...

Regards,
Pankaj

On 2022-03-25 11:19, Pankaj Raghav wrote:
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
> Changes since v3:
> - Change 0x(\d)+ to 0x[[xdigit]]+ (Naohiro)
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
> index 96940549..f96031d5 100755
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
> +start_data_bg_phy=$((start_data_bg_phy >> 9))
> +
> +size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
> +	_filter_blkzone_report |\
> +	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
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
