Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7790FC32772
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Aug 2022 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiHWPrE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Aug 2022 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbiHWPqt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Aug 2022 11:46:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56762AB3DE
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2022 04:47:12 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823114637euoutp02c3f267a42f7dc3ba1073c509aba69064~N9szKdn5-1687116871euoutp02h
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2022 11:46:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823114637euoutp02c3f267a42f7dc3ba1073c509aba69064~N9szKdn5-1687116871euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661255197;
        bh=B10ypvqVwJt/Fq7OCyqEIn46ouPAntJQfECocykoOfE=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=OhKgoL/q57/0WWeN+MEBX8Kv2gKOOdtkWYH7ZveF9I/7ObpM95uGgtrDi79VlwrxB
         OYySaklCp09b4OLkBw8YXhoc+3mWs93JuSHsGnKYgzqflT3syjQcpiwe5kJpcn1Np9
         QxoCdIhkBRouRmRWMSmztcX/me3tH1MK/Lt2fOp4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220823114636eucas1p1c74fc58edd6eb83185ce030280ddc6af~N9sy93e7K3218932189eucas1p1N;
        Tue, 23 Aug 2022 11:46:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A8.0B.07817.C1EB4036; Tue, 23
        Aug 2022 12:46:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823114636eucas1p1215ec07b224b3f506883263d148bc0f3~N9syk61CT0612106121eucas1p1N;
        Tue, 23 Aug 2022 11:46:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220823114636eusmtrp12eb76927b83a4368956ebad26d80f76d~N9sykJYpX2270222702eusmtrp1l;
        Tue, 23 Aug 2022 11:46:36 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-a4-6304be1cb12c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C0.5C.10862.C1EB4036; Tue, 23
        Aug 2022 12:46:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220823114636eusmtip104cb915f5969128b79c7e729269c26a7~N9syWBNP81974919749eusmtip1X;
        Tue, 23 Aug 2022 11:46:36 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.52) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 Aug 2022 12:46:34 +0100
Message-ID: <4abc02a3-3518-f5b9-e8c7-cbb77dca30a9@samsung.com>
Date:   Tue, 23 Aug 2022 13:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [RFC 0/1] adapting btrfs/237 to work with the new reclaim
 algorithm
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB7416A0B8F8FA5698EB11A0D49B719@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.52]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87oy+1iSDVqXaVn8Pnue2WLx7+8s
        Fqdb9rJb/O26x2RxY8JTRouJxzezWqy5+ZTFgd1j56y77B6bVnWyeexsvc/qcWbBEXaPz5vk
        PNoPdDMFsEVx2aSk5mSWpRbp2yVwZWzruc1c8Iqz4uSnE4wNjHfYuxg5OSQETCTm39/K1MXI
        xSEksIJRYvbJB8wgCSGBL4wSHydbQiQ+M0p8uryBCaZjxo1vjBCJ5UBFK7oZ4ao2ft0F5exi
        lLi0cxobSAuvgJ3Eod8fwOayCKhKfF3zhwUiLihxcuYTMFtUIFJize6zYEcJCwRJHF1wFMxm
        FhCXuPVkPthqEYEsieYpp1lAFjALzGOS6Hx1nbWLkYODTUBLorETrJ5TIFZiZ/trFoheTYnW
        7b+h5shLbH87hxniBSWJ63PPQdm1EmuPnWEHmSkh0M0pcfX9FEaQmRICLhJLP8tB1AhLvDq+
        BRpgMhKnJ/ewQNjVEk9v/GaG6G1hlOjfuZ4Notdaou9MDkSNo8TVO4eYIcJ8EjfeCkKcwycx
        adt05gmMqrOQQmIWko9nIflgFpIPFjCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhM
        SKf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8FZfZEgW4k1JrKxKLcqPLyrNSS0+xCjNwaIkzpuc
        uSFRSCA9sSQ1OzW1ILUIJsvEwSnVwBTrftf2UUnbKpVvX/59Snw3/cPSqMvJR++/stdgzOi7
        0xBWz8uZXV15W0dK/uha1mPtDy/sCHR0qewvSpvHeuOjTlLO0cmdu7KKX1/9bRyxUXLpqohl
        TW2heyo+pvd9X2nr94v5wM9669OsX3LYjZ4HeLI//FO1ymSS59+WoDJWa5vDxT8/Pp/Wqs+6
        Sr1lqR9/4sWoCd0rLQOP/Xm+ONc+Sn9N2LG7jybULTa4fO3lBSmbjZe4dacIcqY/YJ4oM2vx
        pN8/tRIsy5zflSXdYlxg9n//+wp/9qcpp3UKGtZYB/Ev2vNqG+/MVKWKc5a2TNJ7q29m/ZxU
        6OIsp8X0b/k2952rgu4Y/123Ku/yy3AlluKMREMt5qLiRACimOSqtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7oy+1iSDVpf8Fr8Pnue2WLx7+8s
        Fqdb9rJb/O26x2RxY8JTRouJxzezWqy5+ZTFgd1j56y77B6bVnWyeexsvc/qcWbBEXaPz5vk
        PNoPdDMFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZWzruc1c8Iqz4uSnE4wNjHfYuxg5OSQETCRm3PjG2MXIxSEksJRRYvfrE2wQCRmJT1c+
        QhUJS/y51sUGUfSRUWLx7LVQHbsYJe4/3MwIUsUrYCdx6PcHZhCbRUBV4uuaPywQcUGJkzOf
        gNmiApESD5c1MYHYwgJBEkcXHAXbwCwgLnHryXywuIhAlsTkmX+ZQRYwC8xjkuh8dZ0VYtsD
        RokZCy8CVXFwsAloSTR2gjVzCsRK7Gx/zQIxSFOidftvqKHyEtvfzmGGeEFJ4vrcc1B2rcSr
        +7sZJzCKzkJy3ywkd8xCMmoWklELGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbytmM/
        t+xgXPnqo94hRiYOxkOMEhzMSiK81RcZkoV4UxIrq1KL8uOLSnNSiw8xmgIDaSKzlGhyPjCZ
        5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MCm1Mup4JDBtm6Wh
        vj92t4Df47YbompaPus2Z3yTalY4plPQ9egVy+Qvbz5u7P6294FRzB55n1a1fHP57avkld9J
        JJc16nNcOj3zvttW7pXZJYec/HY9E8tcsmzXdx45/tf6c3bayKx6Fnn/9iGP57+m7TzlX9jg
        uuztxsqbMm1xvtfzcr6afq+WZnJKc7gb7yPAkOfy+n+2UIbJ1qIFZae0u4PT1wuW+X+MvL7L
        9bmg3Rur38ddbqSd85dg/SK/IEb64XouVQ4OWzOBruyM3x+KhG+2Jzz/8Wnhilvn7G/cCevz
        ntb4u3KasNaTo6sn2e4Quripujrt9Oxff0W4BHsm3zv8WGfHOrdvp1ffyFRiKc5INNRiLipO
        BAAMELbtbgMAAA==
X-CMS-MailID: 20220823114636eucas1p1215ec07b224b3f506883263d148bc0f3
X-Msg-Generator: CA
X-RootMTR: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
References: <CGME20220819115338eucas1p11b916296213572e97a03241ebdc399d0@eucas1p1.samsung.com>
        <20220819115337.35681-1-p.raghav@samsung.com>
        <PH0PR04MB7416A0B8F8FA5698EB11A0D49B719@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022-08-22 16:29, Johannes Thumshirn wrote:
>>
>> Only partial reclaim is happening for bigger sized drives. The issue
>> with that is, if I do another FIO transfer, the drive spits out ENOSPC
>> before its actual capacity is reached as most of the zones have not been
>> reclaimed back and are basically in an unusable state.
>>
>> Is there a limit on how many bgs can be reclaimed?
>>
>> Let me know if I am doing something wrong in the test or if it is an
>> actual issue.
> 
> Can you try setting max_active_zones to 0? I have the feeling it's yet 
> another (or perhaps already known, Naohiro shoudl know that) issue with 
> MAZ handling.

The Max active zones is set to 0 (QEMU defaults to 0). I also changed the
backing image format of QEMU from qcow to raw, and still the same issue of
partial reclaim for a drive size of 100G.

I tried the same test in a 100G drive with 1G zone size, and it is working
as expected.

root@zns-btrfs-simple-zns:/data# ./reclaim_script.sh
Open zones before big file transfer:
4
Open zones before removing the file:
59
Going to sleep. Removed the file
Open zones after reclaim:
4

I am not 100% sure what is causing this issue of partial reclaim when the
number of zones is higher.
