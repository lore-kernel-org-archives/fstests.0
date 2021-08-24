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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774CC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 23:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDBD60E78
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 23:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhHXXXa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 19:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231745AbhHXXXa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 19:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629847365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uf8CVzEv/eCUruiEdMmbHrlX4hosp+6j1uUVkEZ38qE=;
        b=IXi/0S/gQsrIhMhjXxJRcsTfasQvKaEYv+jrNn+0zjlSK9evqAjo55lBq4QVrd2Bm/4un3
        xVMtVsrKOhjJw2IEWk+gGa7U9s/yj0AU0nS1QYRRkNjaYuErivk5n1vkUg750fWSaTTyal
        33to5xhMjTZMFXvDpyR1Rn9iMUELbDI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-k2mzwcKIMy-mX0Z4ShtSyw-1; Tue, 24 Aug 2021 19:22:44 -0400
X-MC-Unique: k2mzwcKIMy-mX0Z4ShtSyw-1
Received: by mail-pl1-f198.google.com with SMTP id h13-20020a170902f54d00b00134c35c8d05so2799735plf.4
        for <fstests@vger.kernel.org>; Tue, 24 Aug 2021 16:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uf8CVzEv/eCUruiEdMmbHrlX4hosp+6j1uUVkEZ38qE=;
        b=dVfB9+mFEJEPcf2AUt39+sBL3gjOUPecoz5pLWIq4sJCFxOMOhRRaA0JS1nxxJJRx8
         zQZ/SXcf+84/Ywh2Z65CuneBWax53892CG8xdRiI9rudDWgdWcN9mIpMIouAUJqTdwMs
         KSD0tecD1XdXUAZ9dF4I/wRjunI/zzVuzJqR0IWPU5fZd1vePQkJn+Dh5YpJ+xxwR2w3
         Qo8Hus4bYlBN0s1duev0T/We2pcb+cKPPZ++4GquKV1CvPb0E2ls5sF1y6XUitFdueDJ
         GsT2UTQjpc4OjWlU61u3Mz8JTm+FR34gF+3RYzLXQGplkCnd04SzDs7LN2WvtM7Evp8d
         JsFQ==
X-Gm-Message-State: AOAM532HtDrKBXuet4wnkrJ5I9IZFyPVWzv2Hr9nfXTGaKwGFD2ene7p
        FRbqsMkjsbjRhLkB2p//Zx3TUcGYAbH1sj2nDtVyRyXO8onU3YF358ttYVe2kDodgJdvbDTORjj
        qC0eEURNiZTsWexeqade1uURYvXT24T8hSPT1uGcYmrM3IC0mhEu2MUvh+s1GQ3GFWAdpLg==
X-Received: by 2002:a17:902:7045:b0:130:da61:7778 with SMTP id h5-20020a170902704500b00130da617778mr21727604plt.21.1629847362745;
        Tue, 24 Aug 2021 16:22:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAarn2c44li+zfsKANBp4uSebrs/uhJLLhhb6aTLPWqD3AbgHIIcPNw1bOmGnwZGR0BUhQ1A==
X-Received: by 2002:a17:902:7045:b0:130:da61:7778 with SMTP id h5-20020a170902704500b00130da617778mr21727572plt.21.1629847362351;
        Tue, 24 Aug 2021 16:22:42 -0700 (PDT)
Received: from ?IPv6:2001:8003:4800:1b00:4c4a:1757:c744:923? ([2001:8003:4800:1b00:4c4a:1757:c744:923])
        by smtp.gmail.com with ESMTPSA id g26sm23780979pgb.45.2021.08.24.16.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 16:22:41 -0700 (PDT)
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
To:     Murphy Zhou <xzhou@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824062354.lcbmbz2r6fv5zowo@fedora>
From:   Donald Douwsma <ddouwsma@redhat.com>
Message-ID: <3628adee-a6f1-6621-2988-786334fb6284@redhat.com>
Date:   Wed, 25 Aug 2021 09:22:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824062354.lcbmbz2r6fv5zowo@fedora>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 24/08/2021 16:23, Zorro Lang wrote:
> On Tue, Aug 24, 2021 at 01:04:36PM +0800, Murphy Zhou wrote:
>> And followed by a rw mount.
>>
>> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
>> ---
>>
>> Thanks Darrick very much for reviewing!
>>
>> v2:
>>    Add explaination of the issue
>>    add xfs_force_bdev data $SCRATCH_MNT
>>    use DF_PROG
>>    Re numbered this test
>> v3:
>>    Add _require_scratch_shutdown
>>    Use _get_available_space
>>    Explain why does not use _scratch_mount
>>
>>  tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/999.out |  2 ++
>>  2 files changed, 67 insertions(+)
>>  create mode 100755 tests/xfs/999
>>  create mode 100644 tests/xfs/999.out
>>
>> diff --git a/tests/xfs/999 b/tests/xfs/999
>> new file mode 100755
>> index 00000000..0ce9989b
>> --- /dev/null
>> +++ b/tests/xfs/999
>> @@ -0,0 +1,65 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 RedHat All Rights Reserved.
>> +#
>> +# FS QA Test 999
>> +#
>> +# Testcase for kernel commit:
>> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
>> +#
>> +# After shutdown and readonly mount, a following read-write mount would
>> +# get wrong number of available blocks. This is caused by unmounting the log
>> +# on a readonly filesystem doesn't log the sb counters.
>> +#
>> +. ./common/preamble
>> +_begin_fstest shutdown auto quick
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs xfs
> 
> I'm wondering what limits this test to be a xfs only test? The test steps looks
> common, right?

It needs `shutdown -f` to force the log to disk, if there was a way to do that 
reliably for other filesystems then yes we could shutdown in a different way
and make it generic. 

Don

> 
>> +_require_scratch
>> +_require_scratch_shutdown
>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +# Don't use _scratch_mount because we need to mount without SELinux context
>> +# to reproduce this issue. If we mount with SELinux context, this testcase
>> +# is not reproducing the original issue.
>> +mount $SCRATCH_DEV $SCRATCH_MNT
>> +_xfs_force_bdev data $SCRATCH_MNT
>> +
>> +# Write test file
>> +ls > $SCRATCH_MNT/testfile
>> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
>> +
>> +# Shutdown
>> +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
>> +
>> +# Mount ReadOnly
>> +_scratch_unmount
>> +_scratch_mount -oro
>> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
>> +# Umount and mount rw
>> +_scratch_unmount
>> +_scratch_mount
>> +
>> +# Get fdblocks before repair
>> +fdb1=$(_get_available_space $SCRATCH_MNT)
>> +_scratch_unmount
>> +
>> +# Repair
>> +_repair_scratch_fs >> $seqres.full 2>&1
>> +
>> +# Re-mount
>> +_scratch_mount
>> +
>> +# Get fdblocks after repair
>> +fdb2=$(_get_available_space $SCRATCH_MNT)
>> +
>> +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
>> +
>> +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
>> +
>> +# success, all done
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
>> new file mode 100644
>> index 00000000..3b276ca8
>> --- /dev/null
>> +++ b/tests/xfs/999.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 999
>> +Silence is golden
>> -- 
>> 2.20.1
>>
> 

