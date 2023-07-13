Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC65EB64DD
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 12:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjGMMEg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjGMMEf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 08:04:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57DC1FDB
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 05:04:32 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230713120430euoutp026dfd7fabcba5c135150c5fafe7d86f3f~xa86XoVdp2151521515euoutp02f
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 12:04:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230713120430euoutp026dfd7fabcba5c135150c5fafe7d86f3f~xa86XoVdp2151521515euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689249870;
        bh=1K0jI66/IDgija7Kwz8eCwurfPOVWszqc9VnbxWechU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=aO8s20cdo2W3/rW28104JC9dTt4+MJj5575HTbHfVXsq1gJxXZgq+9Os/tLNWW6/h
         Ac9Q9GTDVU5UmuTfQ8CN7OsRwYi5UUSgBj9+kOgcdFPPfLqdMXYJiH97/za20wtAoC
         0ingvdZDGIRSzLmJWonv1crwlWs91FSnDBM2GNtU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230713120430eucas1p2f1795e8f73acd14c6aa4f4b7bbe7d3dd~xa86HcEEI1874418744eucas1p2J;
        Thu, 13 Jul 2023 12:04:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.87.42423.D48EFA46; Thu, 13
        Jul 2023 13:04:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230713120429eucas1p158d28dce4bbd49b24466a1fa4bdac58d~xa85zj5O71008310083eucas1p1H;
        Thu, 13 Jul 2023 12:04:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230713120429eusmtrp140d38f426de7043d20c0458554a154a5~xa85y-7xe1854418544eusmtrp1a;
        Thu, 13 Jul 2023 12:04:29 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-75-64afe84d118c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.0E.14344.D48EFA46; Thu, 13
        Jul 2023 13:04:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230713120429eusmtip24f5422e2f277754532d6cb3066b54537~xa85kxUxJ0132701327eusmtip2I;
        Thu, 13 Jul 2023 12:04:29 +0000 (GMT)
Received: from [10.66.0.134] (106.210.248.212) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 13 Jul 2023 13:04:27 +0100
Message-ID: <b1bee446-4099-e605-ce59-e9cdaf19bd25@samsung.com>
Date:   Thu, 13 Jul 2023 14:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs/237: adapt the test to work with the new reclaim
 algorithm
To:     Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>, <gost.dev@samsung.com>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <f6365013-ab73-5b2b-6dba-3b628dbe1b56@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87q+L9anGJxfaW7R+OcIs8Xplr3s
        Fn+77jFZrLn5lMVi78mdrA6sHjtn3WX3+Pj0FovH+31X2Tw+b5LzaD/QzRTAGsVlk5Kak1mW
        WqRvl8CVsaTvEUvBJc6Ki0+PMTcw3mbvYuTkkBAwkVh+cSNTFyMXh5DACkaJ1Uc3s0E4Xxgl
        fp6fwQLhfGaUeLnkIytMy5qnN6CqljNK9F3ewQRX9a/xHzuEs5NRYs/ag0wgLbwCdhJPHx0C
        a2cRUJVonPiTESIuKHFy5hMWEFtUIFpi/eO9bCC2sEC4xLemdWC2iMBURonuCXogNrOAvcSM
        N7dZIWxxiVtP5gPN5+BgE9CSaOwEe4gTaNXC/V+ZIEo0JVq3/2aHsOUlmrfOZgYplxBQlni9
        3gbimVqJU1tugd0vIfCFQ2L2zXtQX7pI7No1C8oWlnh1fAs0wGQkTk/uYYGwqyWe3vjNDNHc
        wijRv3M9G8QCa4m+MzkQNY4SpyYcYIEI80nceCsIcQ6fxKRt05knMKrOQgqIWUgem4Xkg1lI
        PljAyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMOWc/nf80w7Gua8+6h1iZOJgPMQo
        wcGsJMKrsm1dihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5O
        qQYmtxUi3FtfBKmV3PkvbcNnuH+6RlhObrXV58UPctTe7t3yjHvNypDtvKsF9bPuzJrK+HTS
        49Masy9wTlCuTfx/+DpHFe8yyw8vEl8VrRf5wHSjTJmhS1nReYdI2VX5sy/XlX3esvef2MzJ
        AsZx09gsxMpsrj837ZZyuC7GxTS7MOHJ+bYPIaXcitMvbHjyjvm2iGXdMdYLbBz8r3qzRZQm
        XrngbNvac/jXrLbcr08PFKyT/fF2WbBK+qGH5+IF97bK+H8K1A/fvzlO8eCWI2Zam3w3TVpQ
        HuwSbZ7Q9IehRKvMe1KSkMGRE19E2KVDFvJekY3OzahP7fWa8Vx0foHP533OPzf9uK7Y7cJl
        VKCixFKckWioxVxUnAgAO8pI4qgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7q+L9anGKy/oGjR+OcIs8Xplr3s
        Fn+77jFZrLn5lMVi78mdrA6sHjtn3WX3+Pj0FovH+31X2Tw+b5LzaD/QzRTAGqVnU5RfWpKq
        kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsaTvEUvBJc6Ki0+P
        MTcw3mbvYuTkkBAwkVjz9AZbFyMXh5DAUkaJh5tOMEEkZCQ2frnKCmELS/y51sUGYgsJfGSU
        WLy8HKJhJ6PEy5V3GEESvAJ2Ek8fHQJrYBFQlWic+BMqLihxcuYTFhBbVCBaYsOFR2C2sEC4
        xLemdWBDRQSmMkp0T9ADsZkF7CVmvLnNCrHgIKNES3cbM0RCXOLWk/lA13FwsAloSTR2gn3A
        CbR34f6vTBAlmhKt23+zQ9jyEs1bZzODlEsIKEu8Xm8D8UutxOe/zxgnMIrOQnLdLCQLZiGZ
        NAvJpAWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC43TbsZ9bdjCufPVR7xAjEwfjIUYJ
        DmYlEV6VbetShHhTEiurUovy44tKc1KLDzGaAoNoIrOUaHI+MFHklcQbmhmYGpqYWRqYWpoZ
        K4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwZfzziX9etvvUzV6F3Suv/5PdW/nR/LT3c70V
        pyfPKZ14LNT7z5Z3M1cblrd7O/C/PydQ9uZsRHDH5lffFc/MtLdK//vXpeDqzKIwnl1Se9Nu
        vWqMi9g38fSClll5GnM1Na4ruDHW9D7p/j05Zc+asBucz8VFtly4MP12f+rLCIvfYda73xld
        fOZ5QG2DVpJB89FJH9euWctof9egNk/if9Yk6xVMB6IVVqzQqonnYJswTeLy3zXXrm5VmmHe
        4i/DvzDy68EH523fpDn/LnyySLOB2d7bImJr352FPrt9uOqD5kp0X1Jp3HPAOpmjV8xgYlbA
        ib8/mK0P7+y5EvI8brdOmNea+OVGWrs+d/xrKlBiKc5INNRiLipOBAB5pnG0XAMAAA==
X-CMS-MailID: 20230713120429eucas1p158d28dce4bbd49b24466a1fa4bdac58d
X-Msg-Generator: CA
X-RootMTR: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
References: <CGME20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0@eucas1p1.samsung.com>
        <20221216105750.28493-1-p.raghav@samsung.com>
        <f6365013-ab73-5b2b-6dba-3b628dbe1b56@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


Hi Anand,

On 2023-07-12 09:06, Anand Jain wrote:
> On 16/12/22 18:57, Pankaj Raghav wrote:
>> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
>> commit and cc4804bfd639 ("btrfs: skip reclaim if block_group is empty"),
>> reclaim algorithm has been changed to be less aggressive, which breaks this
>> test.
>>
>> The test has been adapted so that the new auto-reclaim algorithm can be
>> tested with the following flow:
>> - Write a small file
>> - Write a big file that crosses the reclaim limit
>> - Delete the big file
>> - Check that only the block group that contained the small file is reclaimed,
>>    and the small file is relocated to a new block group.
>> ---
> 
> SOB is missing.
> 
> Pankaj, this patch has not been integrated yet.
> Could you please resend it?
>

Actually, I encountered an issue with this testcase where it worked
perfectly well for smaller drives, but started to fail for bigger ZNS drives.

Thread: https://lore.kernel.org/all/20220819115337.35681-1-p.raghav@samsung.com/

Could you try it in your setup and see if it works correctly?

I remember Johannes also looked into this issue, but we never came to any conclusion.

Regards,
Pankaj

