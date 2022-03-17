Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDDBC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 09:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiCQJym (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiCQJym (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 05:54:42 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1DB1AAF
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 02:53:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220317095321euoutp01cc36e1b09f515b1d0fa5ee3ea6fca99e~dIlhF2C8H2275222752euoutp01T
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 09:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220317095321euoutp01cc36e1b09f515b1d0fa5ee3ea6fca99e~dIlhF2C8H2275222752euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647510801;
        bh=vDIaV1z5PD0hxJICIcbz95rhlQLt4a49dNTVslbiU/w=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Y2JZtgPki9nfbQM6WRFLcTURxEsg6wYzC2SZ+o578mnFisEkepPUR+cYSnBUMNd3O
         WV/KjStuYS+rGY2vJI8vIuuNUELXifdji7sDZT1C+ici13gGytlFHJArTiZsuOBoel
         lBPaBvSuCcB+Uw6ioU5dcppEvgMxGBovgE1Ot3dM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220317095320eucas1p2c3f68b9c1014f20026748d1282ad4c17~dIlg3M93P2976129761eucas1p2v;
        Thu, 17 Mar 2022 09:53:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.16.10009.01503326; Thu, 17
        Mar 2022 09:53:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220317095320eucas1p2b08c7d221bf0e3869e8fe09173660874~dIlgSSixl0368703687eucas1p2I;
        Thu, 17 Mar 2022 09:53:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220317095320eusmtrp29e29f272b2b0817a13000974aae55365~dIlgRfJzZ2275022750eusmtrp2i;
        Thu, 17 Mar 2022 09:53:20 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-e8-623305103e24
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.DB.09404.01503326; Thu, 17
        Mar 2022 09:53:20 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220317095320eusmtip2a193e8b8fe8befabfc9c93a23d79fd13~dIlgJy61O2663326633eusmtip2F;
        Thu, 17 Mar 2022 09:53:20 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.227) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 17 Mar 2022 09:53:17 +0000
Message-ID: <f0d81a7a-5085-14ec-a65a-93a3aeb8b110@samsung.com>
Date:   Thu, 17 Mar 2022 10:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <71d35f2c-8522-c076-ce5d-d6d00d9d5309@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.227]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87oCrMZJBk9bzCx+nz3PbHG6ZS+7
        xd+ue0wW598eZrK4MeEpo8XE45tZLdbcfMriwO6xc9Zddo9NqzrZPHa23mf1+LxJzqP9QDdT
        AGsUl01Kak5mWWqRvl0CV8aE/3IFz3kqjj2vaGBs4upi5OSQEDCRmN+8iq2LkYtDSGAFo8Tk
        H3+gnC+MEjN6N7KBVAkJfGaUeLbQGKbjbudSJoii5YwSS/afg+oAKvrwejkTRMduRom1O/JA
        bF4BO4kVT1eBTWIRUJVY8mQVK0RcUOLkzCcsILaoQITEyyN/wXqFBVIlnn1tYwaxmQXEJW49
        mQ8WFxGIkdhwqI0FZBmzwAkmiVMNk4GGcnCwCWhJNHayg9RwCrhJvJy7mQ2iV1Oidftvdghb
        XmL72znMEB8oS7y5MpcNwq6VWHvsDDuE/Z9D4sLNCAjbRWLPqwNQNcISr45vgaqRkfi/cz7Y
        9xIC/YwSU1v+QDkzGCV6Dm9mAjlIQsBaou9MDkSDo8T/e7NYIMJ8EjfeCkLcwycxadt05gmM
        qrOQgmIWkpdnIXlhFpIXFjCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMQaf/Hf+0
        g3Huq496hxiZOBgPMUpwMCuJ8J55oZ8kxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6
        YklqdmpqQWoRTJaJg1Oqgak7wfZLXwRviV3M5YwXa1i6bNjYFLcu4fu+/98f2SgWs+ti/Bp5
        dcGiAVv8NtXPiL0XnPum77XXZTaP66xLDqid3pons8z7+553eoc57q+z0Fkg6hr/a6Woy71t
        rG9VGOXKy3J+aH9YYSQs8/QUR2ncO8Oz/44bz7n+hFnZcu8ZtV0a03rr9980c3zm1H561d+0
        qAciei9cn/ct+PhgwZcHIk672zmFs496Zj9OC9C9zv9h7RUp/eYnu6s4rZ1Ox5wVf1qo7r6j
        wW99jcr5CJmGiwv7DXVS7Uq3H9gXuFzGVl82PX7WA4uz2sds/k8/eiF24QaVQ13vQmLk3gpz
        Hrt0xcBIMmuT+cN1th6/byqxFGckGmoxFxUnAgAEvGTcsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7oCrMZJBjfOC1r8Pnue2eJ0y152
        i79d95gszr89zGRxY8JTRouJxzezWqy5+ZTFgd1j56y77B6bVnWyeexsvc/q8XmTnEf7gW6m
        ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwJ
        /+UKnvNUHHte0cDYxNXFyMkhIWAicbdzKVMXIxeHkMBSRomZRzvZIRIyEp+ufISyhSX+XOti
        gyj6yChxqXUDlLObUWLixvmMIFW8AnYSK56uYgOxWQRUJZY8WcUKEReUODnzCQuILSoQIdG2
        bAoziC0skCpxbe9asF5mAXGJW0/mM4HYIgIxEhsOtbGALGAWOMEkMbvlHjPEtrVMEnsuXwZy
        ODjYBLQkGiFO5RRwk3g5dzMbxCBNidbtv9khbHmJ7W/nMEO8oCzx5spcNgi7VuLV/d2MExhF
        ZyG5bxaSO2YhGTULyagFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqN327GfW3Ywrnz1
        Ue8QIxMH4yFGCQ5mJRHeMy/0k4R4UxIrq1KL8uOLSnNSiw8xmgIDaSKzlGhyPjB95JXEG5oZ
        mBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MOmHOb0JdZF//svyTGDdgRkr
        n6tzXe0LNdBmYdxS0MnlO8t+p86j77+qciXu11TGTto7813mAVcjseKNmf6+94M2+lbZd9zY
        p/Xr/meWP2kcWvOuuvZ2/8xQKLzTeTYwM06/R1OJR7r45qqHjjdtnrtMsHf3E+mfsO3foocZ
        eVWpE6ZtWPznUIi75bbW+Sk7a01Py0i9NohgL6w7fsZp5yaeviuNPWvF5Ta82jrLV+go027O
        GRlSZUu5sz5mPXn/9nQowzuNd5c+qHG9KK1LV20+8yHIdvKB6TumVnl7NTO3ajiUxQYVcdxd
        vTfywcN9kUZamX8KGQN/pkaHTL567laT8cMtOzWKbQpnZHWEKbEUZyQaajEXFScCALBbYxJn
        AwAA
X-CMS-MailID: 20220317095320eucas1p2b08c7d221bf0e3869e8fe09173660874
X-Msg-Generator: CA
X-RootMTR: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
References: <CGME20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90@eucas1p1.samsung.com>
        <20220315201756.18829-1-p.raghav@samsung.com>
        <20220316040748.j5olvwr4qqpmvqgr@naota-xeon>
        <74e35575-cd2c-07b7-396a-086fc1da2822@samsung.com>
        <71d35f2c-8522-c076-ce5d-d6d00d9d5309@opensource.wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2022-03-17 00:20, Damien Le Moal wrote:

>>> But still, zone capacity can vary for each zone. So, we need to read
>>> the capacity of a zone where the data BG resides on.
>>>
>> Do we support variable zone capacity in Linux? IIRC variable zone sizes
>> are definitely not supported but I am not sure about variable zone capacity.
> 
> No, variable zone capacity is not supported in Linux. By that, I mean that
> drive that may change the capacity of a zone after a reset are not
> supported. So a zone capacity in Linux is always fixed throughout the life
> time of the NS it belongs to.
> 
> But nothing mandates that all zones have the same capacity. A drive could
> expose zones with different capacities. That is the point Naohiro was making.
> 
Got it. Thanks for the clarification.
>>
>> But even if we do support, I see that the zone 5 (old_data_zone) and
>> zone 6 (new_data_zone) during the test and what if the new_data_zone
>> (zone 6) has a smaller cap than old_data_zone (zone 5)?
>> The main question: Is there a way to deterministically tell where the
>> data BG will reside and where it will relocate before we start the test
>> with variable capacity?
>>
@noahiro: So the data BG for btrfs starts from Zone 5 if I understand it
correctly. Can I then hard code the test to read the cap from zone 5? I
think that should fix your concern.
>> My first look indicates that adding variable zone capacity will make the
>> test a bit more complex and I am not sure if it is worth the effort if
>> there are no use cases for it.
>> Let me know your thoughts.
>>
> 
> 

-- 
Regards,
Pankaj
