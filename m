Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B95C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Mar 2022 08:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiCYI15 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354548AbiCYI1u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Mar 2022 04:27:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC5CC535
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 01:26:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220325082613euoutp01dfcbf5ae32b559acd4b67f6aa08cfb00~fkjuR8HAP1479414794euoutp01T
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 08:26:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220325082613euoutp01dfcbf5ae32b559acd4b67f6aa08cfb00~fkjuR8HAP1479414794euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648196773;
        bh=Ut0jZrVoS5Wru1rFgBM4dpyQO8YUwjuLmHMhA6ECROw=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=iyp/+WKZ9Gjc1zE9BP1d73sf2rUPOxMwokpxmYRsMq33dgvhhdf8KK+oMWoEgZ4W+
         cGWP6us/lsb3dnkVkK4X98n5vaQ6LoZpUJQttHnnDDQqYtjMhMzTneymAkPVt6zqPc
         niTY7Bzx0cJMIkVkR7NGz7pMy1NjkehBBuzfD3pM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220325082612eucas1p1b013e7b75ca69d383667318635ac64d2~fkjuEN4vo0623406234eucas1p17;
        Fri, 25 Mar 2022 08:26:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A4.94.09887.4AC7D326; Fri, 25
        Mar 2022 08:26:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220325082612eucas1p1d321a67001cbe8789ac157e8ef0f3c9a~fkjtsDi3G2748027480eucas1p1U;
        Fri, 25 Mar 2022 08:26:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220325082612eusmtrp2bd9ae795eb2f177879c73e3d271f4c86~fkjtq9YL60065200652eusmtrp2Y;
        Fri, 25 Mar 2022 08:26:12 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-9c-623d7ca4b2d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6B.FE.09404.4AC7D326; Fri, 25
        Mar 2022 08:26:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220325082612eusmtip1b7423738f0c5fd71a62c41a4f296287d~fkjteOQUI1646416464eusmtip1M;
        Fri, 25 Mar 2022 08:26:12 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 25 Mar 2022 08:26:06 +0000
Message-ID: <be8f9576-35f2-52b0-a75c-b65b192f82b8@samsung.com>
Date:   Fri, 25 Mar 2022 09:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.7.0
Subject: Re: [PATCH v3] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220325050017.xh4p736vv6y3wjtu@naota-xeon>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7pLamyTDFZtNLP4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRXDYpqTmZZalF+nYJXBl7D69nLVjPWTFx7my2BsYL7F2MnBwSAiYSX89/Z+xi5OIQEljB
        KPHpdAcrhPOFUWLKjVY2COczo8SPholwLRc/X2CGSCxnlGhqWckEV9Xb9haqZRejxJabL9lA
        WngF7CTmdc9lBbFZBFQl3jS2MkHEBSVOznzCAmKLCkRI/Lr1CGyFsECGxJkjK8DqmQXEJW49
        mQ9WLyLgI7F68iSwa5kFrjFJHPm8DCjBwcEmoCXR2AnWyylgKbHk1UIWiF5Nidbtv9khbHmJ
        7W/nMEO8oCRx7flTFgi7VuLUlltgH0gINHNKHDjexwaRcJFYvWoRVJGwxKvjW6D+l5H4v3M+
        VEM/o8TUlj9QzgxGiZ7Dm8EukhCwlug7kwPR4Cjx8OpsFogwn8SNt4IQB/FJTNo2nXkCo+os
        pLCYheTnWUh+mIXkhwWMLKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECk9Hpf8e/7GBc
        /uqj3iFGJg7GQ4wSHMxKIrz3L1snCfGmJFZWpRblxxeV5qQWH2KU5mBREudNztyQKCSQnliS
        mp2aWpBaBJNl4uCUamDyUrV8Wx7Nn6B3LfHAjLS2pjTJvdfnLTnwf/WWRfeZHZ/ZC2d0i/1f
        l8rpqXM9dO7P5uVNz/7+Zcu+d/G+5zRW2b1LmXZaZ002lfyevr9yz0HVtJ17HYyf5AQbJWZm
        Kb+1bPLen/biYHgo21y99WzCySsuveWL9IvnVdST1VD1NlJ3bFPgSZW//eylsNmJmGXapw4G
        vP/2IIPRx+Ds2wfvr8i+ifSVvev3udXpkty3ltDjWseaReUXL/+zZFKH5yqB5upf94QX2ies
        4r767a7EvwMN5hOrk2elZovd+nhyTW/yCdF13/0OJuc7JqhNeb+nWL6l5tfaErO/Indrk/9P
        +CPWazmjMbM806WDK1SJpTgj0VCLuag4EQAbFpdNtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7pLamyTDI5fk7T4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehl7
        D69nLVjPWTFx7my2BsYL7F2MnBwSAiYSFz9fYO5i5OIQEljKKNG0+BVUQkbi05WPULawxJ9r
        XWwQRR8ZJdon/2KEcHYxSvR3/WcCqeIVsJOY1z2XFcRmEVCVeNPYChUXlDg58wkLiC0qECGx
        bNdUMFtYIEPizJEVYPXMAuISt57MB6sXEfCRWD15EtgCZoFrTBJHPi8DSwgJ7GGUuH7EsYuR
        g4NNQEuisRPsOk4BS4klrxayQMzRlGjd/psdwpaX2P52DjPEB0oS154/ZYGwayU+/33GOIFR
        dBaS82YhOWMWklGzkIxawMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzB+tx37uWUH48pX
        H/UOMTJxMB5ilOBgVhLhvX/ZOkmINyWxsiq1KD++qDQntfgQoykwjCYyS4km5wMTSF5JvKGZ
        gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5OepmzlKc6rik+P//TwDLwY
        s6S8RzTizo/Z859bsvgc4ZwtwvNyr6Q183Sj9eYJPia7eK2dL16N6brhk/yqskrkgKhAUYub
        3UemxqN9Elmh1alXkz82Tl/w/MXXHRlrZkpq72VY0JGzO/XC+zd/PJ9eV/+xNGDN6R1rb32q
        08gvEZ01f+Fmy71Niam18nxeD/X/eIRe+DlZ3Mws7/iHuOfVbHKTAmy9fhdayb+qyrnqeyFg
        UlzItWgz8w+r55ZUBSdsE32yKXbyRQ7mhCP58b2frsTutxDr3HnSd9ebStZWtzPnOOcnTlQ+
        Nf+8xlPZKIGdxz2mz76xY+ERmQy7nASTiUXZ7Z8+ba8P8b66e7ISS3FGoqEWc1FxIgB3Fk5U
        aAMAAA==
X-CMS-MailID: 20220325082612eucas1p1d321a67001cbe8789ac157e8ef0f3c9a
X-Msg-Generator: CA
X-RootMTR: 20220325050027eucas1p13068f112ed6aedec1da1c45ec9f2acc2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220325050027eucas1p13068f112ed6aedec1da1c45ec9f2acc2
References: <20220321115848.30397-1-p.raghav@samsung.com>
        <CGME20220325050027eucas1p13068f112ed6aedec1da1c45ec9f2acc2@eucas1p1.samsung.com>
        <20220325050017.xh4p736vv6y3wjtu@naota-xeon>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2022-03-25 06:00, Naohiro Aota wrote:
>>  
>> +start_data_bg_phy=$(get_data_bg_physical)
>> +start_data_bg_phy=$((data_bg_zone >> 9))
> 
> start_data_bg_phy=$((start_data_bg_phy >> 9)) ?
> 
Oops. I fixed this in my test machine but forgot to put these while
sending my patch. Thanks.
>> +
>> +size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
>> +	_filter_blkzone_report |\
>> +	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
> 
> The pattern should be "cap 0x[[:xdigit:]]+" as it is hexadecimal. I
> missed this point before.
> 
I will fix it up.
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
