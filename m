Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10632C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 13:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiLMNgP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 08:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiLMNfy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 08:35:54 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606352036A
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 05:35:52 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221213133549euoutp02810aa39599fddd5d39817ce43e811dd6~wXcIJPwzM3209432094euoutp02c
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 13:35:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221213133549euoutp02810aa39599fddd5d39817ce43e811dd6~wXcIJPwzM3209432094euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670938549;
        bh=OcNiREXTspaU+YaubXr0mjOOWSZRCxtFnMHaee0G7rM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=SdGkyXubJ28ReL8kSJy9FFrUIM20+mzUOrOe0sEANUA458P7LnrAEgNDY0aw62HaZ
         cAYQyX5f59yaoqtSK8vQZRiwHYLQwoNgM7zcrnsZDgS4ZWkSHvY/zxC3sCYYx3gBNn
         ivt8KS1ap5BFdBjXSWHHGGxlOM3PYrXLvFnv48+w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221213133549eucas1p231c48793d433951977a0988616b68c4d~wXcH3EGli0792507925eucas1p2B;
        Tue, 13 Dec 2022 13:35:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.DB.10112.5BF78936; Tue, 13
        Dec 2022 13:35:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221213133549eucas1p156d56813d54afd648d76f4dd94f0f9a3~wXcHgO44L2015020150eucas1p1p;
        Tue, 13 Dec 2022 13:35:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221213133549eusmtrp12a300a0cab73a22250389b046e59c83a~wXcHfjaPN3061830618eusmtrp1C;
        Tue, 13 Dec 2022 13:35:49 +0000 (GMT)
X-AuditID: cbfec7f4-cf3ff70000002780-fa-63987fb5c819
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.DE.08916.4BF78936; Tue, 13
        Dec 2022 13:35:48 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221213133548eusmtip25c001045c518b4d7c71f749ff0d9d830~wXcHRJ39V1214012140eusmtip2-;
        Tue, 13 Dec 2022 13:35:48 +0000 (GMT)
Received: from [192.168.8.141] (106.210.248.200) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 13 Dec 2022 13:35:47 +0000
Message-ID: <c18784f1-4b68-27dd-9042-1a546a4bacea@samsung.com>
Date:   Tue, 13 Dec 2022 14:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [RFC 0/1] adapting btrfs/237 to work with the new reclaim
 algorithm
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>, <boris@bur.io>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <d39c1b29-4489-d998-c503-81449df442a7@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.200]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7pb62ckG8y/LGzx6M0UVovfZ88z
        Wyz+/Z3F4nTLXnaLv133mCxuTHjKaDHx+GZWizU3n7I4cHjM+jOb1WPnrLvsHptWdbJ57Gy9
        z+pxZsERdo/Pm+Q82g90MwWwR3HZpKTmZJalFunbJXBlbHv7mK3gNnfFy32BDYzTObsYOTkk
        BEwkPnUfY+1i5OIQEljBKHHkSiM7hPOFUeLQhkUsEM5nRoln87qYYFrazqxlhEgsZ5S4dLed
        Fa5q57fVzBDObkaJlduWgbXwCthJTJq6hh3EZhFQlViw/Cg7RFxQ4uTMJywgtqhAlETThZ9g
        trBAkMTRBSA1HBwiAsYSP9dZg8xkFnjOJHH9YAczSA2zgLjErSfzmUBq2AS0JBo7wco5Bawl
        jvxghajQlGjd/psdwpaX2P52DjPEA8oSm95PY4OwayXWHjsD9rKEwHROieZHa6ESLhKX7jxl
        gbCFJV4d38IOYctInJ7cAxWvlnh64zczRHMLo0T/zvVsIEdIAB3RdyYHosZR4uqdQ8wQYT6J
        G28FIe7hk5i0bTrzBEbVWUgBMQvJY7OQvDALyQsLGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al
        6yXn525iBKao0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4VTWmJQvxpiRWVqUW5ccXleakFh9i
        lOZgURLnXTGlI1lIID2xJDU7NbUgtQgmy8TBKdXAVDvr0/TpSbP9XTw5nrT+f/5z3pNvXxYK
        p2pWL/5Xud7Zc+2mUx1nJtyxfmJa/OzQ/sMGL1fKfFwkqlAfIf13Bsevv8t8vp9KzX6yWdMh
        eJbF7n+eogy3tF0T/d+t25bRcUpjzrWr0258T3fr0fsWGfopU8/3j9CRTdPU225GdyxRlD2t
        9qNzMlPJsjnH1siqsqmfU5hxdkrWUa0yt6eP5vPt/2aq6fxJ2nrGi08nLthfaJrqNsHMNCvL
        reGJddjBxcp22SxtDyvkXohevq/3zvucjqbvUQ151WtOmuEzeJp1a65c6thxYGawQImhjPnG
        4IkVem4t6l+4ug4FbX5/9JrKtRMlkxWDlsWtZ6nfM0uJpTgj0VCLuag4EQAM5DMGwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7pb6mckGzQ/MrV49GYKq8Xvs+eZ
        LRb//s5icbplL7vF3657TBY3JjxltJh4fDOrxZqbT1kcODxm/ZnN6rFz1l12j02rOtk8drbe
        Z/U4s+AIu8fnTXIe7Qe6mQLYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQytr19zFZwm7vi5b7ABsbpnF2MnBwSAiYSbWfWMnYxcnEICSxllJj7
        /iIbREJG4tOVj+wQtrDEn2tdbBBFHxkl9r/cxw7h7GaU+DvpNiNIFa+AncSkqWvAOlgEVCUW
        LD/KDhEXlDg58wkLiC0qECVx8/xDJhBbWCBI4ugCkBoODhEBY4mf66xBZjILPGWS+Lj2E1i9
        kMBvJom2VUIgNrOAuMStJ/OZQOrZBLQkGjvBWjkFrCWO/GCFqNCUaN3+mx3ClpfY/nYOM8T9
        yhKb3k+D+qtW4tX93YwTGEVnITluFpIFs5CMmoVk1AJGllWMIqmlxbnpucWGesWJucWleel6
        yfm5mxiBcb3t2M/NOxjnvfqod4iRiYPxEKMEB7OSCK+qxrRkId6UxMqq1KL8+KLSnNTiQ4ym
        wBCayCwlmpwPTCx5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M
        U/miP/ueOOwSp7DwhLQM4xeeCbs2TV81ofzBtumVinNVshhcp97OuLF04v+tByXueIofD9ha
        s8tD9NBL+TtNn75FT6qfNV+2fx6L+b0Ov8u6D7afcEmw69Gczph27Ijbtdk3CkPXJbsm+uU5
        T0gtWsTi+Z5/Z4bUhzpj/7NlX1+I5i/Q3h2/niVb7HLwjOiMq5Fyqbx7T6S+bjvSIKoRX3qp
        pXr5uUTppNIAtevzD+/UO/joXUZwzpT1bH2roiIe5HuHNTMxXi00bjXS/r1apHzyOqdapxSe
        qcaP0jgW3vk2w1fAqtr3b+9V0a1mlzc6iWTsOLeUre+ThmHerKT5Kqod392c/l3c3TfDwiRW
        iaU4I9FQi7moOBEAn7IOO3QDAAA=
X-CMS-MailID: 20221213133549eucas1p156d56813d54afd648d76f4dd94f0f9a3
X-Msg-Generator: CA
X-RootMTR: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220819115338eucas1p11b916296213572e97a03241ebdc399d0
References: <CGME20220819115338eucas1p11b916296213572e97a03241ebdc399d0@eucas1p1.samsung.com>
        <20220819115337.35681-1-p.raghav@samsung.com>
        <PH0PR04MB7416A0B8F8FA5698EB11A0D49B719@PH0PR04MB7416.namprd04.prod.outlook.com>
        <4abc02a3-3518-f5b9-e8c7-cbb77dca30a9@samsung.com>
        <252ec35c-01bf-e597-7a14-5724b6015b1c@samsung.com>
        <d39c1b29-4489-d998-c503-81449df442a7@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Johannes,
  I gave my test a retry, and it started failing for all cases. This commit
by Boris changed the behavior of reclaim to be less aggressive:

https://lore.kernel.org/linux-btrfs/977bdffbf57cca3ee6541efa1563167d4d282b08.1665701210.git.boris@bur.io/

It looks like I need to change the test to cater the current behavior.

The current reclaim algorithm is consistent across all sizes, unlike before.

I will change the test to do the following:
- Write a small file
- Write a big file that crosses the reclaim limit
- Delete the big file
- Check that **only** the block group that contained the small file is
reclaimed, and the small file is relocated to a new block group.

Let me know if the flow of the test case is correct.

On 2022-12-05 17:04, Johannes Thumshirn wrote:
> On 05.12.22 15:53, Pankaj Raghav wrote:
>> Hi Johannes,
>>
>>> Btw, what ever happend to this patch?
>>
>> As I said before, I had trouble reproducing reclaim for 100G drive size,
>> and asked if you could reproduce the same on your end. I did not get any
>> reply to that.
>>
>> I wanted to discuss with you what I was seeing during ALPSS, but we never
>> got around that!
> 
> Ah right! I'll try to reproduce it on my end as well.
> 
> But even with that one problem it makes the test pass again on my other setups.
> 
> So I think it's still an improvement to the status quo. Can you maybe resend it,
> so it's again on Zorro's list?
> 
> Thanks,
> 	Johannes
> 
> 
