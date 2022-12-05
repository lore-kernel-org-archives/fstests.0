Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369BAC4321E
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Dec 2022 14:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiLEOxL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Dec 2022 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLEOxJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2022 09:53:09 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57521706B
        for <fstests@vger.kernel.org>; Mon,  5 Dec 2022 06:53:07 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221205145303euoutp014659011a10af73be59d05646ed6f4e82~t7VRueIKR0699106991euoutp01S
        for <fstests@vger.kernel.org>; Mon,  5 Dec 2022 14:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221205145303euoutp014659011a10af73be59d05646ed6f4e82~t7VRueIKR0699106991euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670251983;
        bh=K9Vz3nL0nK3NSQ9eGMVWb/2Q1feh4j7Qo4QhwuCJYDw=;
        h=Date:Subject:From:To:CC:In-Reply-To:References:From;
        b=OHibGCH23BBs5GN6VCAE/c+jzmC1j9WFEq1ssoTu8+anPfrMJ0nZI91k0lv8GwYvn
         qbkYAElssjrDxkzy610EEVh+PP+M/njmbP8lnsWr9mooq7/tCMIXb7X/XQ6xPl8/Io
         cOSZTvN8RiJpWcovzpBria2wJ3woghh7I/GxZJIs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221205145303eucas1p1ec5165bfc0ce9bf929fa3883fc6525b0~t7VRcSimh0753907539eucas1p1t;
        Mon,  5 Dec 2022 14:53:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.88.09561.FC50E836; Mon,  5
        Dec 2022 14:53:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221205145303eucas1p13d4aa8371b92abde7f920ae1c4e23d4f~t7VRGoSKH0543905439eucas1p1B;
        Mon,  5 Dec 2022 14:53:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221205145302eusmtrp12de1b7ab3b232d1326ae5aa2a4e3a3d5~t7VRBVUO53004830048eusmtrp1L;
        Mon,  5 Dec 2022 14:53:02 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-9e-638e05cf9e3f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.FC.08916.EC50E836; Mon,  5
        Dec 2022 14:53:02 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221205145302eusmtip10af27853183248b642c7c361d4d20c8a~t7VQ0M3AU1334313343eusmtip1I;
        Mon,  5 Dec 2022 14:53:02 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 5 Dec 2022 14:53:01 +0000
Message-ID: <252ec35c-01bf-e597-7a14-5724b6015b1c@samsung.com>
Date:   Mon, 5 Dec 2022 15:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [RFC 0/1] adapting btrfs/237 to work with the new reclaim
 algorithm
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <4abc02a3-3518-f5b9-e8c7-cbb77dca30a9@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7rnWfuSDWZ8E7X4ffY8s8Xi399Z
        LE637GW3+Nt1j8nixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V48yCI+wenzfJ
        ebQf6GYKYIvisklJzcksSy3St0vgyljf+4GxYB5vxYrn/WwNjEu5uhg5OSQETCSu3uph6WLk
        4hASWMEo8e9KHyuE84VR4sbsiewgVUICnxkl7v3X6WLkAOs4sNkBomY5o8Sxzm9Q3UA1px+/
        YINwdjFKTFr5gQmkm1fATuLGhglgNouAisTB6S9YIOKCEidnPgGzRQWiJJou/ASzhQWCJI4u
        OMoOso1NQEuisRPMFBEwlvi5zhqkglngKpNEz8RsCFtc4taT+WDTOQXsJZavnscIEdeUaN3+
        mx3ClpfY/nYOM8THShIT5t1ng7BrJU5tucUEcrKEQDenxM2zq5kgEi4Sy67eY4WwhSVeHd/C
        DmHLSJye3MMCYVdLPL3xmxmiuYVRon/nejZICFlL9J3JgahxlLh65xAzRJhP4sZbQYh7+CQm
        bZvOPIFRdRZSQMxC8s4sJC/MQvLCAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ
        6PS/4592MM599VHvECMTB+MhRgkOZiUR3hcbe5OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ866Y
        0pEsJJCeWJKanZpakFoEk2Xi4JRqYMrO+eC5XP5FmrJkm1Jsw9dGEZf3s1SPlVSy3u4s2Wen
        0vT1BAOT+949jOWty65meU74VrN3jXdLyGPHBbf8V1rvS/kxtz1sF7PBlv4g8VQVrteFcdwX
        5xxkEpnns+qhWkGGZ4lxSsKCClu1rxfe1c+pWLA62DD6p4jf716v1o87Y0r0S1Pvx93tuvno
        RISd/hMexeu1px/tvPyyv5Nz/g+PjRu7Ow50/zhXcOaDkPWr5RoVN65cma4aP0XBNHnutMZ2
        Iff3Ej7SPAqbNzSv2bnyer7VoannDy8uZfZaL/Hl56H8PQwGlX5df40Nj/oqHmB9d+T8h5eH
        HtcsmC5ivtnF8si3vTK9lRmLNjHv36XEUpyRaKjFXFScCAD2Eg/WtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7rnWPuSDaacMrb4ffY8s8Xi399Z
        LE637GW3+Nt1j8nixoSnjBYTj29mtVhz8ymLA7vHzll32T02repk89jZep/V48yCI+wenzfJ
        ebQf6GYKYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy1jf+4GxYB5vxYrn/WwNjEu5uhg5OCQETCQObHboYuTiEBJYyiixY1U/axcjJ1BcRuLT
        lY/sELawxJ9rXWwQRR8ZJWYeXMUK4exilFhwvocNpIpXwE7ixoYJTCA2i4CKxMHpL1gg4oIS
        J2c+AbNFBaIkbp5/CFYjLBAkcXTBUXaQK9gEtCQaO8FMEQFjiZ/rrEHGMwtcZZLY/X0hC8Su
        qUwSjzpvMIP0MguIS9x6Mh9sDqeAvcTy1fMYIeKaEq3bf7ND2PIS29/OYYb4QEliwrz7bBB2
        rcTnv88YJzCKzkJy3iwkY2chGTULyagFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuN4
        27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHeFxt7k4V4UxIrq1KL8uOLSnNSiw8xmgLDaCKzlGhy
        PjCR5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MFnr3zuU1xo6
        fc6amAuFE+4ppz78+HWX99fZXZ0WX1fYhcWamnOyPTjwin/6Ea+Mkgs23NPzrjnHbNq2R7o7
        cotSSvxSk5epGSnr58hr7LcXZv1wOX9fMdfPq9tlHocql36R/ZP6s19D8dGlCyVd+TFd4uXJ
        HsfU42awG4Zz/FnY+/D6o01iEtfu1t95q+zJ9niftkGlu/Gu6ulrP+kUpU1l13G+6xrlt0Bj
        43QLo99H9vWs9Ty70oR56ZQpMn4mmTYBGTyWPRFe6XOThWruugrWqEw9dKBCqvVnavCjW1Kr
        eKSPFMuYLpsf07N47/3Y0JXq/dF3NaJslt/eNqfliUDPszkXn16Ku/5S8065gRJLcUaioRZz
        UXEiADH85FZsAwAA
X-CMS-MailID: 20221205145303eucas1p13d4aa8371b92abde7f920ae1c4e23d4f
X-Msg-Generator: CA
X-RootMTR: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
References: <CGME20220819115338eucas1p11b916296213572e97a03241ebdc399d0@eucas1p1.samsung.com>
        <20220819115337.35681-1-p.raghav@samsung.com>
        <PH0PR04MB7416A0B8F8FA5698EB11A0D49B719@PH0PR04MB7416.namprd04.prod.outlook.com>
        <4abc02a3-3518-f5b9-e8c7-cbb77dca30a9@samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Johannes,

> Btw, what ever happend to this patch?

As I said before, I had trouble reproducing reclaim for 100G drive size,
and asked if you could reproduce the same on your end. I did not get any
reply to that.

I wanted to discuss with you what I was seeing during ALPSS, but we never
got around that!

Regards,
Pankaj

On 2022-08-23 13:46, Pankaj Raghav wrote:
> On 2022-08-22 16:29, Johannes Thumshirn wrote:
>>>
>>> Only partial reclaim is happening for bigger sized drives. The issue
>>> with that is, if I do another FIO transfer, the drive spits out ENOSPC
>>> before its actual capacity is reached as most of the zones have not been
>>> reclaimed back and are basically in an unusable state.
>>>
>>> Is there a limit on how many bgs can be reclaimed?
>>>
>>> Let me know if I am doing something wrong in the test or if it is an
>>> actual issue.
>>
>> Can you try setting max_active_zones to 0? I have the feeling it's yet 
>> another (or perhaps already known, Naohiro shoudl know that) issue with 
>> MAZ handling.
> 
> The Max active zones is set to 0 (QEMU defaults to 0). I also changed the
> backing image format of QEMU from qcow to raw, and still the same issue of
> partial reclaim for a drive size of 100G.
> 
> I tried the same test in a 100G drive with 1G zone size, and it is working
> as expected.
> 
> root@zns-btrfs-simple-zns:/data# ./reclaim_script.sh
> Open zones before big file transfer:
> 4
> Open zones before removing the file:
> 59
> Going to sleep. Removed the file
> Open zones after reclaim:
> 4
> 
> I am not 100% sure what is causing this issue of partial reclaim when the
> number of zones is higher.
