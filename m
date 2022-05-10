Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11F3C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 12:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbiEJMJ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEJMJ2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 08:09:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4417856B
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 05:05:30 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KyGnk4VbJzCsd1;
        Tue, 10 May 2022 20:00:26 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 20:05:12 +0800
Message-ID: <1aa6663e-1c1d-3659-231d-29c6d4e448c9@huawei.com>
Date:   Tue, 10 May 2022 20:05:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC v3] common: xfstests support overlay+tmpfs
To:     Amir Goldstein <amir73il@gmail.com>
CC:     fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220510020434.2561224-1-libaokun1@huawei.com>
 <CAOQ4uxhTzqvuD5=5c4O_fhzV9CrHSpipegjUiETgCbNTkdvpvA@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
In-Reply-To: <CAOQ4uxhTzqvuD5=5c4O_fhzV9CrHSpipegjUiETgCbNTkdvpvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

在 2022/5/10 15:51, Amir Goldstein 写道:
> On Tue, May 10, 2022 at 4:50 AM Baokun Li <libaokun1@huawei.com> wrote:
>> The local.config of overlay+tmpfs is as follows:
>> ```local.config.example
>> export FSTYP=tmpfs
>> export TEST_DEV=tmpfs_test
>> export TEST_DIR=/tmp/test
>> export SCRATCH_DEV=tmpfs_scratch
>> export SCRATCH_MNT=/tmp/scratch
>> ```
>>
>> Run `./check -overlay tests` to execute test case on overlay+tmpfs.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> V1->V2:
>>          Fix the bug in version V1 and fix the issue in cycle_mount.
>> V2->V3:
>>          Merge two patches into one completed patch.
>>
>> V1: https://patchwork.kernel.org/project/fstests/patch/20220424063751.1067376-1-libaokun1@huawei.com/
>> V2: https://patchwork.kernel.org/project/fstests/cover/20220507094524.949615-1-libaokun1@huawei.com/
>>
>>   common/config  | 12 ++++++------
>>   common/overlay |  2 +-
>>   common/rc      | 31 ++++++++++++++++++++++++-------
>>   3 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/common/config b/common/config
>> index 1033b890..d5953176 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -610,15 +610,15 @@ _overlay_config_override()
>>          [ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
>>          [ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
>>
>> +       # Config file may specify base fs type, but we obay -overlay flag
>> +       [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>> +       export FSTYP=overlay
>> +
>>          # 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
>>          #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>>          #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>>          #    overlayfs base and mount dirs inside base fs mount.
>> -       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>> -
>> -       # Config file may specify base fs type, but we obay -overlay flag
>> -       [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>> -       export FSTYP=overlay
>> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
>>
>>          # Store original base fs vars
>>          export OVL_BASE_TEST_DEV="$TEST_DEV"
>> @@ -634,7 +634,7 @@ _overlay_config_override()
>>          export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>>          export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>>
>> -       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
>>
>>          # Store original base fs vars
>>          export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
>> diff --git a/common/overlay b/common/overlay
>> index fff67ba1..c4e7ee58 100644
>> --- a/common/overlay
>> +++ b/common/overlay
>> @@ -81,7 +81,7 @@ _overlay_base_mount()
>>                  return 1
>>          fi
>>
>> -       _mount $* $dev $mnt
>> +       _mount -t $OVL_BASE_FSTYP $* $dev $mnt
>>          _idmapped_mount $dev $mnt
>>   }
>>
>> diff --git a/common/rc b/common/rc
>> index 553ae350..ca465438 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -410,10 +410,19 @@ _scratch_cycle_mount()
>>   {
>>       local opts="$1"
>>
>> -    if [ "$FSTYP" = tmpfs ]; then
>> -       _scratch_remount "$opts"
>> -       return
>> -    fi
>> +       case "$FSTYP" in
>> +       tmpfs)
>> +               _scratch_remount "$opts"
>> +               return
>> +               ;;
>> +       overlay)
>> +               if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
>> +                       _scratch_remount "$opts"
>
> That doesn't look right.
> _scrtach_cycle_mount is important for several overlay tests and there
> is no reason to
> skip it if base fs is tmpfs.
> What you need to do is cycle mount the overlay without cycle mounting
> the base fs.
> You could do something like this:
>
>    local unmounted
> ...
>
>    overlay)
>                 if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
>                           $UMOUNT_PROG $SCRATCH_MNT
>                           unmounted=true
>                 fi
>                 ;;
>     esac
> ...
>      [ "$unmounted" = true ] || _scratch_unmount
>      _try_scratch_mount "$opts" || _fail "cycle mount failed"
> }
>
> There are some overlay tests that open code this pattern like overlay/077:
>
> # Remove the lower directory and mount overlay again to create
> # a "former merge dir"
> $UMOUNT_PROG $SCRATCH_MNT
> rm -rf $lowerdir/former
> _scratch_mount
>
> So _scratch_mount is expected to work just fine when base fs is already mounted
> assuming that _check_mounted_on works correctly with tmpfs.
>
> Thanks,
> Amir.
> .

Thank you very much for your advice.

I will send a patch V4 with the changes suggested by you.

-- 
With Best Regards,
Baokun Li

.



