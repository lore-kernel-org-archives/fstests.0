Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008AC4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 03:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiLLDDI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Dec 2022 22:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLLDDH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Dec 2022 22:03:07 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529DCE07
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2022 19:03:06 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NVmcx3gyzz15NJr;
        Mon, 12 Dec 2022 11:02:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 11:03:04 +0800
Message-ID: <34a30ec2-9c19-8cf9-2156-eaf62fe6d8c6@huawei.com>
Date:   Mon, 12 Dec 2022 11:03:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: supporting overlay+tmpfs breaks check -n -overlay -g auto
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
CC:     Murphy Zhou <jencce.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>
References: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
 <a4844c99-77f4-470f-f351-a82155b5eca7@huawei.com>
 <Y5aTu/fP6C3ZNPjI@B-P7TQMD6M-0146.local>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Y5aTu/fP6C3ZNPjI@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/12/12 10:36, Gao Xiang wrote:
> On Mon, Dec 12, 2022 at 10:08:33AM +0800, Baokun Li wrote:
>> On 2022/12/12 9:42, Murphy Zhou wrote:
>>> Hi,
>>>
>>> Bisecting points me to this commit:
>>>
>>> commit 92fb58afaa2f38a9369ad5791a4cbf135545617d
>>> Author: Baokun Li <libaokun1@huawei.com>
>>> Date:   Wed May 11 16:34:04 2022 +0800
>>>
>>>       common: xfstests support overlay+tmpfs
>>>
>>>
>>> It breaks this command:
>>> ./check -n -overlay -g auto
>>>
>>> As a result, it fails to show me the list of testcases.
>>>
>>> Please help to check.
>>>
>>> Thanks!
>>> Murphy
>> I tried to run the command on the latest version, and everything was fine.
>>
>> Did I miss anything?
>>
>> What is the version, environment, and config for reproducing the problem?
>>
> Just to mention that we've also encountered this issue by doing
>
> FSTYP=ext4
> ./check -overlay generic/192
>
> it seems the workaround would be:
> 1) add an environment variable: export OVL_BASE_FSTYP=ext4
> or
> 2) update ./check and delete:
>
> # Process command arguments first.
> while [ $# -gt 0 ]; do
>          case "$1" in
>          -\? | -h | --help) usage ;;
>
>          -nfs|-glusterfs|-cifs|-9p|-virtiofs|-pvfs2|-tmpfs|-ubifs)
>                  FSTYP="${1:1}"
>                  ;;
>          -overlay)
>                  FSTYP=overlay
>                      ^ remove this
>                  export OVERLAY=true
>                  ;;>
>
> Thanks,
> Gao Xiang
>
I also tested this use case and the results are as follows, and the test 
is passed.

     [root@fedora xfstest]# export OVL_BASE_FSTYP=ext4
     [root@fedora xfstest]# ./check -overlay generic/192
     FSTYP         -- overlay
     PLATFORM      -- Linux/x86_64 fedora 5.10.0+ #571 SMP Sat Dec 10 
16:41:36 CST 2022
     MKFS_OPTIONS  -- /tmp/scratch
     MOUNT_OPTIONS -- /tmp/scratch /tmp/scratch/ovl-mnt

     generic/192 7s ...  7s
     Ran: generic/192
     Passed all 1 tests

Can you provide a stable reproducer? Or provide the error information or
help track the location where return the error.
-- 
With Best Regards,
Baokun Li
.
