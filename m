Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86049C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Mar 2022 15:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356839AbiCPPog (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbiCPPof (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Mar 2022 11:44:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC7C10FE3
        for <fstests@vger.kernel.org>; Wed, 16 Mar 2022 08:43:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220316154312euoutp01b03c18a01575f3885187ec1429407006~c5ts0Nx_h0032700327euoutp015
        for <fstests@vger.kernel.org>; Wed, 16 Mar 2022 15:43:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220316154312euoutp01b03c18a01575f3885187ec1429407006~c5ts0Nx_h0032700327euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647445392;
        bh=y8lf4lyJiZ2IzG3+NA1XO1gGw4Od7lhdz1eIhl5cbYA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=XAU/EUTQDmg6CAV9eQwItFANzlGi8ZyB9jyGkBaBMvdkD5moPJIWo4mn4a8SMgGTG
         0gE82ufUwHDcDVeyO6vsEbazqZmzMsm6YP91zt1knkH65WQS6lfdGDeV0PMFLkwKyn
         ofI3TTe9I2uthn6DvhOwlMSFMBJpiIJQ1msiOTzA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220316154312eucas1p17389252df8ac1c6b5215686a5e38b6be~c5tso_0C_2320723207eucas1p1f;
        Wed, 16 Mar 2022 15:43:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D6.91.09887.09502326; Wed, 16
        Mar 2022 15:43:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220316154312eucas1p2030ff670b1240809ab8b1737fb5d497f~c5tsREQVy1026510265eucas1p2v;
        Wed, 16 Mar 2022 15:43:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220316154312eusmtrp17033ef3a2ebc54fc2459e8d61c5eaeb4~c5tsQadiW2562225622eusmtrp1w;
        Wed, 16 Mar 2022 15:43:12 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-b2-623205907b4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.03.09522.09502326; Wed, 16
        Mar 2022 15:43:12 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220316154312eusmtip16432a94cf789ac3c0c2d1ee4e619c2bd~c5tsHceIl1786617866eusmtip17;
        Wed, 16 Mar 2022 15:43:12 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.179) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 16 Mar 2022 15:43:10 +0000
Message-ID: <74e35575-cd2c-07b7-396a-086fc1da2822@samsung.com>
Date:   Wed, 16 Mar 2022 16:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220316040748.j5olvwr4qqpmvqgr@naota-xeon>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.179]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87oTWI2SDHr2qlr8Pnue2eJ0y152
        i79d95gszr89zGRxY8JTRouJxzezWqy5+ZTFgd1j56y77B6bVnWyeexsvc/q8XmTnEf7gW6m
        ANYoLpuU1JzMstQifbsEroy3c/UKOvgrVlxcxtrA2MTTxcjBISFgIrH8i2AXIxeHkMAKRon5
        jw6xQThfGCVOLvrLCuF8BnJOXgPKcIJ1tN6ZwQ6RWM4o0bL9JDtIAqxq14sciMRuRomFx/ax
        giR4BewkLm9oZwaxWQRUJSa/6GeHiAtKnJz5hAXEFhWIkHh55C8TiC0skCrx7GsbWD2zgLjE
        rSfzweIiAuoSH58eBbuPWeA/k8SlZ7PZQZ5gE9CSaOwEm8kpYCnR9eA9G0SvpkTr9t/sELa8
        xPa3c5ghPlCW6Lz6iAnCrpVYe+wM2DcSAs2cEm1bmlggAeMisWqWPESNsMSr41vYIWwZidOT
        e1gg6vsZJaa2/GGCcGYwSvQc3swE0Wwt0XcmB6LBUeL/vVlQM/kkbrwVhLiHT2LStunMExhV
        ZyEFxSwkL89C8sIsJC8sYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZiETv87/mUH
        4/JXH/UOMTJxMB5ilOBgVhLhPfNCP0mINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTE
        ktTs1NSC1CKYLBMHp1QDk1hH0PkArRThBUH7xF5mKm/MP7M6feL8zSEagVuilFdqZjTcWCr1
        buP5m1evekr+FwjQa1730m53WV5JjO0JuZdcb6KeTVNySp8xS8FNI9Z6Z3KTrufT3E+d28N+
        WZpV+2a2TjQWLuBSfntA2i5zzaUcKc8trrUBb3Y5br/Qm922/kbnJ+4wyznbrk2YaZnBycd4
        WUbJavbx2lAZxr03rCV/PU9c+Te1Kj62KbeJZ9nv3qSl58KdRQ41BjefUPDJkrztvmNO5T6Z
        4zaHy9KWm+7psp+2f6L2jzl7Hr36ePWIxbZs3vXNy91qDKy7E8sNVjw+0PtbbE7O+aOtB29/
        4Djy8escHa343ZWbbTKKlViKMxINtZiLihMBgYWXNLEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7oTWI2SDC6+47H4ffY8s8Xplr3s
        Fn+77jFZnH97mMnixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V4/MmOY/2A91M
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlv
        5+oVdPBXrLi4jLWBsYmni5GTQ0LARKL1zgx2EFtIYCmjxNSD2hBxGYlPVz6yQ9jCEn+udbF1
        MXIB1XxklHh6aAozRMNuRol595NBbF4BO4nLG9rB4iwCqhKTX/SzQ8QFJU7OfMICYosKREi0
        LYPoFRZIlbi2dy0jiM0sIC5x68l8JhBbREBd4uPTo2DLmAX+Mklc7P7DArFsD6PE3GsuXYwc
        HGwCWhKNnWDzOQUsJboevGeDmKMp0br9NzuELS+x/e0cZogHlCU6rz5igrBrJV7d3804gVF0
        FpLzZiE5YxaSUbOQjFrAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMHK3Hfu5eQfjvFcf
        9Q4xMnEwHmKU4GBWEuE980I/SYg3JbGyKrUoP76oNCe1+BCjKTCMJjJLiSbnA1NHXkm8oZmB
        qaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD0wZh5X33jHWfnBB3S98Va+zJ
        uXfONN/5qutSq74YO8qsnb3p37oJs9/XzL31d5Pu7uyoh+Z3yjx/bd8jr5a16tBjd/unbA+a
        hB49S+Zom795YtzzFF37b9Hz10Y4ikiKSty1ajSa/5DnFtu9VxfvHvJ455Nf43Ur41uKzifn
        tKJexpZNzLwL7a882+VnKFB0cILTzs/OW65c5za22+jPsXvzsjrDnQ8SGIO/rLFh/lZ97skr
        uwcy2+eej20qnpyXctZ3t0X2xi1dQidThNtLt6+v+dgofnLG8wNCKusmq/3U/PzH8fOHw99M
        HgiWPGP2m5FhrcY+MTlOROpwr+z0rY5bNku9lguP1VGIrpuTGq3EUpyRaKjFXFScCAA4ORbC
        ZQMAAA==
X-CMS-MailID: 20220316154312eucas1p2030ff670b1240809ab8b1737fb5d497f
X-Msg-Generator: CA
X-RootMTR: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
References: <CGME20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90@eucas1p1.samsung.com>
        <20220315201756.18829-1-p.raghav@samsung.com>
        <20220316040748.j5olvwr4qqpmvqgr@naota-xeon>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Naohiro,

On 2022-03-16 05:07, Naohiro Aota wrote:
>> +# blkzone supports printing zone cap only after version 2.37
>> +_blkzone_req_major_ver=2
>> +_blkzone_req_minor_ver=37
>> +blkzone_ver=$($BLKZONE_PROG --version | cut -d " " -f 4 | cut -d "-" -f 1)
>> +blkzone_ver=( ${blkzone_ver//./ } )
>> +blkzone_major_ver=${blkzone_ver[0]}
>> +blkzone_minor_ver=${blkzone_ver[1]}
>> +if [[ $blkzone_major_ver -ge $_blkzone_req_major_ver &&\
>> +	$blkzone_minor_ver -ge $_blkzone_req_minor_ver ]]; then
> 
> I'd like to have it as a helper.
> 
> Or, how about adding a filter and a wrapper function to add a "cap"
> filed whose value equal to the zone size for the old version (like
> with _getcap() and _filter_getcap())? Then, we can just call:
>   zonecap=$(_blkzone_report ... | grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
>   size=$((zonecap << 9))
> 
That is a good idea. I will give it a shot. Thanks.

>> +	zonecap=$($BLKZONE_PROG report -c 1 $SCRATCH_DEV |\
>> +		grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
> 
> But still, zone capacity can vary for each zone. So, we need to read
> the capacity of a zone where the data BG resides on.
> 
Do we support variable zone capacity in Linux? IIRC variable zone sizes
are definitely not supported but I am not sure about variable zone capacity.

But even if we do support, I see that the zone 5 (old_data_zone) and
zone 6 (new_data_zone) during the test and what if the new_data_zone
(zone 6) has a smaller cap than old_data_zone (zone 5)?
The main question: Is there a way to deterministically tell where the
data BG will reside and where it will relocate before we start the test
with variable capacity?

My first look indicates that adding variable zone capacity will make the
test a bit more complex and I am not sure if it is worth the effort if
there are no use cases for it.
Let me know your thoughts.

-- 
Regards,
Pankaj
