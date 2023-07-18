Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97496EB64DA
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jul 2023 08:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGRIaX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jul 2023 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGRIaV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jul 2023 04:30:21 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902B01B6
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2023 01:30:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230718083016euoutp0195c2b2ed42df196d58b87381a380cdbd~y6QTF5T1k0493304933euoutp01E
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2023 08:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230718083016euoutp0195c2b2ed42df196d58b87381a380cdbd~y6QTF5T1k0493304933euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689669016;
        bh=IGo0o+bjTrcmx8KS3AxhpkdHjQgEY+RvcpYFbl2QF0s=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=tcSf05OrPVLo6CxlyKYeSAcovgE7GDzkU6AecyZrIttvAhmdYR3jsiR/ESgAtjPd2
         XvqadeNhZJzBqYY+I2d8zGHNFZDmWDEF5Zy4GIIkIIb3tObuAsB3db+Fm7/aZY452j
         OswBcqcFNda4RFvG21jdGB113r4jNQgKxZIM7viA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230718083016eucas1p2f48bfe6def836ced6d9a516a77379fe3~y6QSxFLxg2574925749eucas1p2b;
        Tue, 18 Jul 2023 08:30:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D9.7C.37758.89D46B46; Tue, 18
        Jul 2023 09:30:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230718083016eucas1p258a1f6abb2ddfdbe6fdfab976639ad31~y6QSaTXJ61001010010eucas1p2o;
        Tue, 18 Jul 2023 08:30:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718083016eusmtrp124d5582572a2905bddd3700d0adef7b8~y6QSZfOjs0632206322eusmtrp1m;
        Tue, 18 Jul 2023 08:30:16 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-3f-64b64d987dd5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.39.10549.89D46B46; Tue, 18
        Jul 2023 09:30:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230718083016eusmtip1528a8e5c448dc50825bdca8aeff78877~y6QSQf-eP2555925559eusmtip1A;
        Tue, 18 Jul 2023 08:30:16 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.188) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 18 Jul 2023 09:30:15 +0100
Message-ID: <a1deec64-2769-1612-c3c1-8ea78bf1b1f8@samsung.com>
Date:   Tue, 18 Jul 2023 10:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <df936e0b-fdd1-458b-370f-5041108551b9@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.188]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87ozfLelGCw6rmDR+OcIs8Xplr3s
        Fn+77jFZrLn5lMVi78mdrA6sHjtn3WX3+Pj0FovH+31X2Tw+b5LzaD/QzRTAGsVlk5Kak1mW
        WqRvl8CVcbYntuA5b8W5c0/YGxgXc3cxcnJICJhIrNy9jL2LkYtDSGAFo8Sj6U8ZIZwvjBK3
        dmxlBakSEvjMKPF1phBMx+0bKxgh4suBOlanQzQA1ex5dJwVwtnNKLH/8lEmkCpeATuJN48X
        g9ksAqoSN05eZYeIC0qcnPmEBcQWFYiWWP94LxuILSwQLvGtaR2YzSwgLnHryXywXhGBqYwS
        3RP0IOL2EjPe3AZaxsHBJqAl0dgJNpITaNWsfVtYIUo0JVq3/2aHsOUlmrfOZoZ4QFnixtR9
        LBB2rcSpLbeYQG6WEHjDIdE25QMTRMJF4smfM1C2sMSr41vYIWwZidOTe6CaqyWe3vjNDNHc
        wijRv3M9G8hBEgLWEn1nciBqHCVOTTjAAhHmk7jxVhDiHj6JSdumM09gVJ2FFBKzkHw8C8kL
        s5C8sICRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgujn97/jXHYwrXn3UO8TIxMF4
        iFGCg1lJhPf7qk0pQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZ
        ODilGphmu21dXlJjeu4U2yRh7+Xv7lsHsiWb6CRls2X217st/PU4POp6e21C1DGT681+pt5T
        fh5Q5Jrevtnu3ywGA5Gu3XPec02RO5r5Wb7i6pMHCceib0ge41T8P3fFIbaEiNxzeasv3llo
        nHrg9/6Lm8ucGHzErl4/u3ttx6YOSauNF5smqx0Vvqr5q4fZNOF6YdC/HMvaBc0Or1W/7ig3
        vDanRCc+fbGPW/T6bD7mDKktyR9qZ+6YXh/73bAm20i9K2PZw51pbnMV1j04uNU7pvrgvTox
        LtGdZRP9pp2U//B16s9z/U3/fDzDvvF4d7qKbg24miX2bk0jR+QMu4rk0k2TXiqkFuy9ZXBp
        rneqYKgSS3FGoqEWc1FxIgB1N6krpgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7ozfLelGBydx2HR+OcIs8Xplr3s
        Fn+77jFZrLn5lMVi78mdrA6sHjtn3WX3+Pj0FovH+31X2Tw+b5LzaD/QzRTAGqVnU5RfWpKq
        kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcbYntuA5b8W5c0/Y
        GxgXc3cxcnJICJhI3L6xgrGLkYtDSGApo8TLO9tYIBIyEhu/XGWFsIUl/lzrYoMo+sgo8Wr+
        ZihnN6PErY/Twap4Bewk3jxezARiswioStw4eZUdIi4ocXLmE7CpogLREhsuPAKzhQXCJb41
        rWMDsZkFxCVuPZkP1isiMJVRonuCHkTcXmLGm9tg84UEVjFJrG2Q62Lk4GAT0JJo7AQbzwm0
        dta+LawQ5ZoSrdt/s0PY8hLNW2czQzygLHFj6j6ox2olPv99xjiBUXQWkutmIbliFpJRs5CM
        WsDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwTrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS
        4f2+alOKEG9KYmVValF+fFFpTmrxIUZTYBBNZJYSTc4HJoq8knhDMwNTQxMzSwNTSzNjJXFe
        z4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmUyePiypPVrnd0Vtw/PR3Cb6YNal3WpaUfGX5bxBV
        Nn3p0t+6zqFzNnIER0iceBIfZN6eImcx02ml8NuYtQ0y5fZ/2YNmL988ZfI91s0y/dNkL8vo
        LFx2/OK+IoZrf4WvaGc847rose8s5x3d6+218dtf6n16uXSRnb3gzL+3zCyifmXGaBef+7rP
        zDKy9vj+19se3PknrrXLI2vtGdNHm+7Zdup+qPj7clGB76H9R47xHPn70MaKZfMdy/JXKkyW
        6wwmsRubz++PYLG7lZgUHZxzs/JQ+Zaj+1Z8+2jwO+bIn1cPO7xaPIWf/orN7812C24xTJr2
        +sAC24mr9kVvM2dUlHnANfGYJNsujbSPn5RYijMSDbWYi4oTAXsPpfFcAwAA
X-CMS-MailID: 20230718083016eucas1p258a1f6abb2ddfdbe6fdfab976639ad31
X-Msg-Generator: CA
X-RootMTR: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
References: <CGME20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0@eucas1p1.samsung.com>
        <20221216105750.28493-1-p.raghav@samsung.com>
        <f6365013-ab73-5b2b-6dba-3b628dbe1b56@oracle.com>
        <b1bee446-4099-e605-ce59-e9cdaf19bd25@samsung.com>
        <df936e0b-fdd1-458b-370f-5041108551b9@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-07-13 17:10, Anand Jain wrote:
> 
> 
> On 13/07/2023 20:04, Pankaj Raghav wrote:
>>
>> Hi Anand,
>>
>> On 2023-07-12 09:06, Anand Jain wrote:
>>> On 16/12/22 18:57, Pankaj Raghav wrote:
>>>> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
>>>> commit and cc4804bfd639 ("btrfs: skip reclaim if block_group is empty"),
>>>> reclaim algorithm has been changed to be less aggressive, which breaks this
>>>> test.
>>>>
>>>> The test has been adapted so that the new auto-reclaim algorithm can be
>>>> tested with the following flow:
>>>> - Write a small file
>>>> - Write a big file that crosses the reclaim limit
>>>> - Delete the big file
>>>> - Check that only the block group that contained the small file is reclaimed,
>>>>     and the small file is relocated to a new block group.
>>>> ---
>>>
>>> SOB is missing.
>>>
>>> Pankaj, this patch has not been integrated yet.
>>> Could you please resend it?
>>>
>>
>> Actually, I encountered an issue with this testcase where it worked
>> perfectly well for smaller drives, but started to fail for bigger ZNS drives.
>>
>> Thread: https://lore.kernel.org/all/20220819115337.35681-1-p.raghav@samsung.com/
>>
>> Could you try it in your setup and see if it works correctly?
> 
> Right. I'm also facing some issues. However, the stack trace indicates
> a memory error, which I attributed to my low-resourced nullb device.
> I'm trying to emulate a zoned device using other methods, but I haven't been successful yet.
> 

You could easily emulate a zoned device in QEMU with either using NVMe[1] or virtio[2]

[1] https://qemu.readthedocs.io/en/latest/system/devices/nvme.html#zoned-namespaces
[2] https://www.qemu.org/2022/11/17/zoned-emulation/
