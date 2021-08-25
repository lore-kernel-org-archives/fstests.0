Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92675C4338F
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCCE600AA
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 01:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhHYBHD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236474AbhHYBHD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 21:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629853576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EG8sW3BaeERwiIQmd1qu/Usb8zj5WAsDwBG85AcEbrg=;
        b=GbH6zbl6C4eLajAfB7E+vCKpXkfW4dCgX+v1bnvF7DEEiuZUTP87YT+I848T7q0inJCb1e
        QBFmfx3hpEtYMa7POxmsE/qrlGfbothkGH42FypnD+9zQWrHfh7X5RE+n6Xu7hD0qNkHq2
        t+ehGzCkUE9uy5ihqvQzPwLwJmuNnh8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-4A_S-JQqP6yk7-X3z73hjA-1; Tue, 24 Aug 2021 21:06:14 -0400
X-MC-Unique: 4A_S-JQqP6yk7-X3z73hjA-1
Received: by mail-pg1-f199.google.com with SMTP id 135-20020a63058d0000b029023cdca61836so13129673pgf.23
        for <fstests@vger.kernel.org>; Tue, 24 Aug 2021 18:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EG8sW3BaeERwiIQmd1qu/Usb8zj5WAsDwBG85AcEbrg=;
        b=BUBPF9Y2G7oT0HTZQezANuymzUtxOanQBd2c2xZlGoYT0vrbTSKqO0k4PVnCdRQOVk
         XCAL8RHVBAMXgML6+R5XF4WP2c/ild6Xwu7WkhznCHINR/bDqLqMlLi5DlFsGPLcEX6q
         A35dU4C1DwM/R83aJk4HZl7NOXmDIc3x+icRtcyOXRufCiiSU5vIWI59swbRlg9JMILi
         2f+5fzFrXP54XEk+qXxLi3XHRSWM6RgVK5FOKBfcQA6dsBYjPtIj5yXksHjgRnx9WeHs
         cW2bMwaWMy4yPfoRFlf8N7swi/tmQTxNL5woHkdWS5+FDiCU4AY/XQqMx1aTXwrg0cfL
         kpsw==
X-Gm-Message-State: AOAM530REZTJ8efl81mdjeCuXDXiGTOOTak9ff0BzA3x4ZH6sAVXv+n4
        J58D6/BPj8S398OHbKz90/S3OrBXEAtK9Rid8MZtL+ScWVQrfP7RPkgLksXJYY0FlZl9ffTu1IU
        j69fluqyYhyBT3wGodp/KSNC8B39MZhJLAfg3F9LxUAK1FMSyNRg7pBLBx5A5fMjJ1VAoSw==
X-Received: by 2002:a05:6a00:2343:b0:3e0:f9a0:c1fa with SMTP id j3-20020a056a00234300b003e0f9a0c1famr42337369pfj.72.1629853573370;
        Tue, 24 Aug 2021 18:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhE315Td6X0F6+42ddpe/xXBSvSLkP3n5IRMxr2u26EiorzyiFNIOicdUSDSAOad91G3RwxA==
X-Received: by 2002:a05:6a00:2343:b0:3e0:f9a0:c1fa with SMTP id j3-20020a056a00234300b003e0f9a0c1famr42337346pfj.72.1629853573029;
        Tue, 24 Aug 2021 18:06:13 -0700 (PDT)
Received: from ?IPv6:2001:8003:4800:1b00:4c4a:1757:c744:923? ([2001:8003:4800:1b00:4c4a:1757:c744:923])
        by smtp.gmail.com with ESMTPSA id o2sm17134965pgu.76.2021.08.24.18.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 18:06:12 -0700 (PDT)
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
From:   Donald Douwsma <ddouwsma@redhat.com>
To:     Murphy Zhou <xzhou@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824062354.lcbmbz2r6fv5zowo@fedora>
 <3628adee-a6f1-6621-2988-786334fb6284@redhat.com>
Message-ID: <a5d58dab-5f4b-884f-d29e-e531e536fc24@redhat.com>
Date:   Wed, 25 Aug 2021 11:06:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3628adee-a6f1-6621-2988-786334fb6284@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 25/08/2021 09:22, Donald Douwsma wrote:
> 
> 
> On 24/08/2021 16:23, Zorro Lang wrote:
>> On Tue, Aug 24, 2021 at 01:04:36PM +0800, Murphy Zhou wrote:
>>> And followed by a rw mount.
>>>
>>> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
>>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>>> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
>>> ---
>>>
>>> Thanks Darrick very much for reviewing!
>>>
>>> v2:
>>>    Add explaination of the issue
>>>    add xfs_force_bdev data $SCRATCH_MNT
>>>    use DF_PROG
>>>    Re numbered this test
>>> v3:
>>>    Add _require_scratch_shutdown
>>>    Use _get_available_space
>>>    Explain why does not use _scratch_mount
>>>
>>>  tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  tests/xfs/999.out |  2 ++
>>>  2 files changed, 67 insertions(+)
>>>  create mode 100755 tests/xfs/999
>>>  create mode 100644 tests/xfs/999.out
>>>
>>> diff --git a/tests/xfs/999 b/tests/xfs/999
>>> new file mode 100755
>>> index 00000000..0ce9989b
>>> --- /dev/null
>>> +++ b/tests/xfs/999
>>> @@ -0,0 +1,65 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2021 RedHat All Rights Reserved.
>>> +#
>>> +# FS QA Test 999
>>> +#
>>> +# Testcase for kernel commit:
>>> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
>>> +#
>>> +# After shutdown and readonly mount, a following read-write mount would
>>> +# get wrong number of available blocks. This is caused by unmounting the log
>>> +# on a readonly filesystem doesn't log the sb counters.
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest shutdown auto quick
>>> +
>>> +# real QA test starts here
>>> +
>>> +_supported_fs xfs
>>
>> I'm wondering what limits this test to be a xfs only test? The test steps looks
>> common, right?
> 
> It needs `shutdown -f` to force the log to disk, if there was a way to do that 
> reliably for other filesystems then yes we could shutdown in a different way
> and make it generic. 

I didn't realize that Ext implements the XFS IOCTL to shutdown the filesystem
in the same way (src/godown.c uses XFS in the IOCTL name),so it will work. 

Sweet!

> 
> Don
> 
>>
>>> +_require_scratch
>>> +_require_scratch_shutdown
>>> +
>>> +_scratch_mkfs > $seqres.full 2>&1
>>> +# Don't use _scratch_mount because we need to mount without SELinux context
>>> +# to reproduce this issue. If we mount with SELinux context, this testcase
>>> +# is not reproducing the original issue.
>>> +mount $SCRATCH_DEV $SCRATCH_MNT
>>> +_xfs_force_bdev data $SCRATCH_MNT
>>> +
>>> +# Write test file
>>> +ls > $SCRATCH_MNT/testfile
>>> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
>>> +
>>> +# Shutdown
>>> +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
>>> +
>>> +# Mount ReadOnly
>>> +_scratch_unmount
>>> +_scratch_mount -oro
>>> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
>>> +# Umount and mount rw
>>> +_scratch_unmount
>>> +_scratch_mount
>>> +
>>> +# Get fdblocks before repair
>>> +fdb1=$(_get_available_space $SCRATCH_MNT)
>>> +_scratch_unmount
>>> +
>>> +# Repair
>>> +_repair_scratch_fs >> $seqres.full 2>&1
>>> +
>>> +# Re-mount
>>> +_scratch_mount
>>> +
>>> +# Get fdblocks after repair
>>> +fdb2=$(_get_available_space $SCRATCH_MNT)
>>> +
>>> +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
>>> +
>>> +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
>>> +
>>> +# success, all done
>>> +echo "Silence is golden"
>>> +status=0
>>> +exit
>>> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
>>> new file mode 100644
>>> index 00000000..3b276ca8
>>> --- /dev/null
>>> +++ b/tests/xfs/999.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 999
>>> +Silence is golden
>>> -- 
>>> 2.20.1
>>>
>>

