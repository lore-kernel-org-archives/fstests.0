Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D0DC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Apr 2022 13:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiDYNDM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiDYNDF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 09:03:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F15E0F3
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 05:59:59 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kn4mK3bpLzGpSR;
        Mon, 25 Apr 2022 20:57:21 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 20:59:56 +0800
Message-ID: <41395380-ada6-5476-b468-a7e7897a1e6e@huawei.com>
Date:   Mon, 25 Apr 2022 20:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] common: overlay support tmpfs
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>, <yukuai3@huawei.com>
References: <20220424063751.1067376-1-libaokun1@huawei.com>
 <CAOQ4uxgEXEgZ-uAYgiJi1sxX9Zzmg25NewBRiRQR6D8z+qOXHA@mail.gmail.com>
 <eccdacb7-ae04-23fe-4657-528d1c22f801@huawei.com>
 <CAOQ4uxhxE0aMyZfHiedqRQ9mvoOdmGXq9NywY_NdUb1MLuosFg@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
In-Reply-To: <CAOQ4uxhxE0aMyZfHiedqRQ9mvoOdmGXq9NywY_NdUb1MLuosFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

在 2022/4/25 18:42, Amir Goldstein 写道:
> On Mon, Apr 25, 2022 at 12:31 PM libaokun (A) <libaokun1@huawei.com> wrote:
>> 在 2022/4/24 20:02, Amir Goldstein 写道:
>>
>> On Sun, Apr 24, 2022 at 2:21 PM Baokun Li <libaokun1@huawei.com> wrote:
>>
>> xfstests support overlay+tmpfs
>>
>> Thanks for this improvement.
>> Can you please share the results of ./check -overlay -g auto ?
>>
>> How many tests ran? notran? failed?
>>
>> Best if you have those numbers compared to
>> overlay+(already supported base fs)
>>
>> All right, I'll share it after the adaptation is completed.
>>
>> ```local.config.example
>> export FSTYP=tmpfs
>> export TEST_DEV=tmpfs_test
>> export TEST_DIR=/tmp/test
>> export TEST_FS_MOUNT_OPTS="-t tmpfs"
>> export SCRATCH_DEV=tmpfs_scratch
>> export SCRATCH_MNT=/tmp/scratch
>> export MOUNT_OPTIONS="-t tmpfs"
>>
>> These mount options for tmpfs are very awkward.
>> Please fix _overlay_base_mount to use -t $OVL_BASE_FSTYP
>> like _test_mount() and _try_scratch_mount() do
>>
>> Could you be more specific?
> --- a/common/overlay
> +++ b/common/overlay
> @@ -81,7 +81,7 @@ _overlay_base_mount()
>                  return 1
>          fi
>
> -       _mount $* $dev $mnt
> +       _mount -t $OVL_BASE_FSTYP $* $dev $mnt
>          _idmapped_mount $dev $mnt
>   }
>
>
> Untested.
>
> Thanks,
> Amir.
> .

Ok, got it! Thank a milion!

-- 
With Best Regards,
Baokun Li

