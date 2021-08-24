Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CCBC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196E161248
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 06:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhHXGD5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 02:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhHXGD4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 02:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629784992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Fpb4jlE0VdKSuBL51hjexL6Dqevwgt0IGp30+6nDpg=;
        b=IJhbTp3AH3UYPLBh1N3kvnEMpH3Q7jgqutbqKCjenYBAOET+crWReTugMHxkgp53ejP7qd
        etg4JP+BcHUbSyFr2x/05BlrKgwcpccx/FdbHFwwJE+gfUF9y6whjLX86MWH1g/cDbefKE
        EAoF1m56PCb9FDIil4CAeP+4nE42Ewk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-a72H1kkBN9-HGk00QuAx3g-1; Tue, 24 Aug 2021 02:03:10 -0400
X-MC-Unique: a72H1kkBN9-HGk00QuAx3g-1
Received: by mail-pf1-f199.google.com with SMTP id h14-20020a62b40e0000b02903131bc4a1acso9710783pfn.4
        for <fstests@vger.kernel.org>; Mon, 23 Aug 2021 23:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7Fpb4jlE0VdKSuBL51hjexL6Dqevwgt0IGp30+6nDpg=;
        b=X8zpdG4uYCFyU77idPSN2E1shhFomiuFEESoZ8GdxrqEorUDi+iRWUjL/2AZZQRldJ
         +IpVmGgZmo40mEkHfNqDtD7NYZ2rl09TemygcHdIDJGbejL4fKbY1WRQjIDhcdGCUnf2
         4RqLZElCxvfbb9UBhv85zpM0j4JiFtarN5Zl+GtXaq5N1MtcdjxSZBJo3uhYMbjVunKJ
         hxrsybR6iJpYwdHHqxJuznoCgvMJfp7sk71RxLin2g1d3Wm32pmChL0l5QNKTieMuS3T
         aQmn4jKYOIQdtBiQisgSg8d/4QALT9u5QB7LIVSk6ZVRWmQ+m6o0eyVCEexIwaOPnLjc
         5eYA==
X-Gm-Message-State: AOAM533jn5XfuImYfHuWiNsqNql1+EN5h88YDRzqORpm/Eg8Ti6+ug4x
        hygUAXZQaQM5FpXMXb8NnwPB87RhwfQuW2LmfWaEg8VCaXlqHA8fpY9jzjzuU9Uy1fTAELyKkgR
        WZVF7OcDlHCrV4l8rBw==
X-Received: by 2002:a65:4581:: with SMTP id o1mr34995614pgq.349.1629784988945;
        Mon, 23 Aug 2021 23:03:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybjrjwSmKaToGqXXUnZHWQHpITEuC+XKeGVz6d9tsEZdu6+Qv0+BPdYHkJ9Vc99HEXggcZ6g==
X-Received: by 2002:a65:4581:: with SMTP id o1mr34995594pgq.349.1629784988685;
        Mon, 23 Aug 2021 23:03:08 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gd20sm1060177pjb.42.2021.08.23.23.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 23:03:08 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:23:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        ddouwsma@redhat.com
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
Message-ID: <20210824062354.lcbmbz2r6fv5zowo@fedora>
Mail-Followup-To: Murphy Zhou <xzhou@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        ddouwsma@redhat.com
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 24, 2021 at 01:04:36PM +0800, Murphy Zhou wrote:
> And followed by a rw mount.
> 
> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> 
> Thanks Darrick very much for reviewing!
> 
> v2:
>    Add explaination of the issue
>    add xfs_force_bdev data $SCRATCH_MNT
>    use DF_PROG
>    Re numbered this test
> v3:
>    Add _require_scratch_shutdown
>    Use _get_available_space
>    Explain why does not use _scratch_mount
> 
>  tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/999.out |  2 ++
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/xfs/999
>  create mode 100644 tests/xfs/999.out
> 
> diff --git a/tests/xfs/999 b/tests/xfs/999
> new file mode 100755
> index 00000000..0ce9989b
> --- /dev/null
> +++ b/tests/xfs/999
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 RedHat All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# Testcase for kernel commit:
> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> +#
> +# After shutdown and readonly mount, a following read-write mount would
> +# get wrong number of available blocks. This is caused by unmounting the log
> +# on a readonly filesystem doesn't log the sb counters.
> +#
> +. ./common/preamble
> +_begin_fstest shutdown auto quick
> +
> +# real QA test starts here
> +
> +_supported_fs xfs

I'm wondering what limits this test to be a xfs only test? The test steps looks
common, right?

Thanks,
Zorro

> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +# Don't use _scratch_mount because we need to mount without SELinux context
> +# to reproduce this issue. If we mount with SELinux context, this testcase
> +# is not reproducing the original issue.
> +mount $SCRATCH_DEV $SCRATCH_MNT
> +_xfs_force_bdev data $SCRATCH_MNT
> +
> +# Write test file
> +ls > $SCRATCH_MNT/testfile
> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# Shutdown
> +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
> +
> +# Mount ReadOnly
> +_scratch_unmount
> +_scratch_mount -oro
> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> +# Umount and mount rw
> +_scratch_unmount
> +_scratch_mount
> +
> +# Get fdblocks before repair
> +fdb1=$(_get_available_space $SCRATCH_MNT)
> +_scratch_unmount
> +
> +# Repair
> +_repair_scratch_fs >> $seqres.full 2>&1
> +
> +# Re-mount
> +_scratch_mount
> +
> +# Get fdblocks after repair
> +fdb2=$(_get_available_space $SCRATCH_MNT)
> +
> +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
> +
> +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> new file mode 100644
> index 00000000..3b276ca8
> --- /dev/null
> +++ b/tests/xfs/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden
> -- 
> 2.20.1
> 

