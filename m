Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC9EC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Mar 2022 09:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiCRJaO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiCRJaL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Mar 2022 05:30:11 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F92E710D
        for <fstests@vger.kernel.org>; Fri, 18 Mar 2022 02:28:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220318092849euoutp013d23cf1bd19537ebbff36d576b9dd647~db5ZBan-K1892818928euoutp01Z
        for <fstests@vger.kernel.org>; Fri, 18 Mar 2022 09:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220318092849euoutp013d23cf1bd19537ebbff36d576b9dd647~db5ZBan-K1892818928euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647595729;
        bh=JM5fCq1Hbx2dM5gDRcW6R7phqvrvHwlpWQurJfly9vA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=fkOMnyvNCyCQMyUG7EyX6/wFjwmHuVLkjqLzzGbYgmEhXtU49VzfjUvud6WT8n25I
         F/GojNdgdDw9v2+lumEkQkYxvrJwvVYn1UzeXDAMMTpCzC/9V0HLRM6HMKEDfZqL7S
         G6+GG3E7VOEeU1rD8WlZe5DDMWlpD/3CedOOiziQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220318092849eucas1p1230e706ead031acaef957ef5b09eb71c~db5YwxEK-2975929759eucas1p1I;
        Fri, 18 Mar 2022 09:28:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E1.21.09887.1D054326; Fri, 18
        Mar 2022 09:28:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220318092848eucas1p28865d837f61b4ae5b3c6cef84f250933~db5YMgUGl2939229392eucas1p2N;
        Fri, 18 Mar 2022 09:28:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220318092848eusmtrp19bb597885c14d97f9fbcc4e3ef304edf~db5YLs4UZ2910229102eusmtrp1F;
        Fri, 18 Mar 2022 09:28:48 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-3d-623450d1f57f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.64.09404.0D054326; Fri, 18
        Mar 2022 09:28:48 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220318092848eusmtip2540c4efef21cb42185972aedfb42e13c~db5YEkIrt1184011840eusmtip22;
        Fri, 18 Mar 2022 09:28:48 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.227) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 18 Mar 2022 09:28:45 +0000
Message-ID: <400c8167-c1cb-77aa-2469-3ccaefbe8932@samsung.com>
Date:   Fri, 18 Mar 2022 10:28:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH v2] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220318075448.ansaa57hy5k3jkge@naota-xeon>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.227]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87oXA0ySDL7tlLX4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRXDYpqTmZZalF+nYJXBnLHjYyFfQLVKw49J+5gfEXTxcjB4eEgInEyQkOXYxcHEICKxgl
        rl+awgzhfGGUmPjyNZDDCeR8ZpR4908CxAZpOPXhBhNE0XJGiSn3j0I5QEVPVz9ihXB2M0pc
        3XOSEaSFV8BO4trR12A2i4CqxKPTm9kh4oISJ2c+YQGxRQUiJF4e+csEYgsLZEi8Od8JFmcW
        EJe49WQ+WFxEQF3i49OjbCALmAX+Mkn8fDGHEeQJNgEticZOsJmcApYSH57vZ4To1ZRo3f6b
        HcKWl9j+dg4zxAvKEm+uzGWDsGsl1h47ww4yU0KgnVPi8bQZTBAJF4kHZyayQtjCEq+Ob2GH
        sGUkTk/uYYFo6GeUmNryhwnCmcEo0XN4MxMkWK0l+s7kQDQ4Svw88J0FIswnceOtIMRBfBKT
        tk1nnsCoOgspLGYh+XkWkh9mIflhASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBE
        dPrf8S87GJe/+qh3iJGJg/EQowQHs5II77/fxklCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMz
        NyQKCaQnlqRmp6YWpBbBZJk4OKUamASfRq3bbLg2gWF12vYLa/Z8MOdokpqqI/rIz+2bdYXV
        rW+BVhtnOfhP0Ww3/vAjXu6XHte3J8qfH75a/yt30tLjM79JXSjmCvHvu3zNPuXt88+3rdwf
        x0yOiBNpypC68/3V1oNOG06K2zecnMmb9+vEplCv6BaRqf/3bn3s/u8pe2VAg6Cd860sq8cb
        185ZfshxyQn9knUaivq7qnPeLp9jJ/Itoazf7b9w9Y88h93vZTWV69ZcsA59LPHlQ/7pLcm/
        fj/ZHrFladDP1ym37S0sNp7Pn7cwU+uqzMOdqfIMl04UHtCLYIsWUN/hsH2q+iqtR0vcdTja
        E3o28Sx4HRD9hSuk3V28TuhKvv/sWweVWIozEg21mIuKEwH801IdswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7oXAkySDJo/m1r8Pnue2eJ0y152
        i79d95gszr89zGRxY8JTRouJxzezWqy5+ZTFgd1j56y77B6bVnWyeexsvc/q8XmTnEf7gW6m
        ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxl
        DxuZCvoFKlYc+s/cwPiLp4uRk0NCwETi1IcbTF2MXBxCAksZJfb/u8AKkZCR+HTlIzuELSzx
        51oXG0TRR0aJiRva2CGc3YwSf/YcZgOp4hWwk7h29DUjiM0ioCrx6PRmdoi4oMTJmU9YQGxR
        gQiJtmVTmEFsYYEMiTfnO8HizALiEreezGcCsUUE1CU+Pj0Kto1Z4C+TxM8Xcxghtu1hlDj3
        bg7QfRwcbAJaEo2dYAs4BSwlPjzfzwgxSFOidftvdghbXmL72znMEC8oS7y5MpcNwq6VeHV/
        N+MERtFZSO6bheSOWUhGzUIyagEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzACN527OeW
        HYwrX33UO8TIxMF4iFGCg1lJhPffb+MkId6UxMqq1KL8+KLSnNTiQ4ymwECayCwlmpwPTCF5
        JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MXT96k04skt6vd1DI
        8jjTucw2vfbcYyyzDdgf1px782S7Rvqu9NNevxVvGyzlctrffergh6S7t7aFOKSKuswJi2x6
        FaR4Mkn1zSt91VqmrMefzUoYf61smHRjf1OkjLplwH/+3Te1I8u38YmvmZHY8Oqj4VPNl2tr
        tblO3H/68s7h43deG7x3WZDn4+xntzzt8JbnR+Ouvym/+qvjuTtv/bP/B/a2WddX3ZPymL2b
        z4L96pa0spvM6r5SaT/Tj2z2XufxgG+yz7t7topPNSxj5rywu38myy4xweZhWUxdksKjf+mf
        32Uvmco5dUGiT3/2wpXGJxkq90nvf/ux56Ww4iy/Bw2O1uZvRIpDfeNmK7EUZyQaajEXFScC
        AOa5gU1pAwAA
X-CMS-MailID: 20220318092848eucas1p28865d837f61b4ae5b3c6cef84f250933
X-Msg-Generator: CA
X-RootMTR: 20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd
References: <CGME20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd@eucas1p1.samsung.com>
        <20220317122839.44404-1-p.raghav@samsung.com>
        <20220318075448.ansaa57hy5k3jkge@naota-xeon>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2022-03-18 08:54, Naohiro Aota wrote:
>>  
>> -zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
>> -zonesize=$((zonesize << 9))
>> -
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_mount -o commit=1 # 1s commit time to speed up test
>>  
>> @@ -49,12 +46,18 @@ if [[ "$uuid" == "" ]]; then
>>  	exit 1
>>  fi
>>  
>> +data_bg_zone_idx=5
> 
> Hmm. Yeah, it's currently there. But, I'd hesitate to use that like a
> constant number.
> 
> Instead, how about querying "btrfs inspect-internal" like in
> get_data_bg() do? E.g, like this:
> 
> # Assumes SINGLE data profile
> btrfs inspect-internal dump-tree -t CHUNK $SCRATCH_DEV | grep -A 4 CHUNK_ITEM |\
> 	grep -A 3 'type DATA\|SINGLE' |\
> 	grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
> 
> This command dumps the location of data BG in a byte unit.
> 
> Then, we can calculate the sector number and can supply it to "blkzone
> report -o".
> 
Got it. I also prefer this over hardcoding.
I think we can reuse the get_data_bg function as it also outputs the
same data BG offset.
Like this:

start_data_bg_zone=$(get_data_bg)
start_data_bg_zone=$((data_bg_zone >> 9))

size=$($BLKZONE_PROG report -o $start_data_bg_zone -l 1 $SCRATCH_DEV |\
...
Let me know your thoughts.
>> +size=$($BLKZONE_PROG report -c $data_bg_zone_idx $SCRATCH_DEV | tail -1 |\
>> +	_filter_blkzone_report |\
>> +	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
>> +size=$((size << 9))
>> +
>>  reclaim_threshold=75
>>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>>  fill_percent=$((reclaim_threshold + 2))
>>  rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
>> -fill_size=$((zonesize * fill_percent / 100))
>> -rest=$((zonesize * rest_percent / 100))
>> +fill_size=$((size * fill_percent / 100))
>> +rest=$((size * rest_percent / 100))
>>  
>>  # step 1, fill FS over $fillsize
>>  $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
>> -- 
>> 2.25.1

-- 
Regards,
Pankaj
