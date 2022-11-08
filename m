Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C305C43217
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Nov 2022 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiKHOnS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiKHOnR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Nov 2022 09:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C811821
        for <fstests@vger.kernel.org>; Tue,  8 Nov 2022 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667918536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTmDfKiGCHm1PjPPCu7maOE3HaVIzuPbMvII3Riwrts=;
        b=EJqM4RETsapqqOr6BIow7n+io4AryaWNfh2RQKPxOwhXVujgpaG/GPTPBKXiLecdHjL7CF
        kH7BxmUBwBBxpvTcK4K8zkNlzwx+ae8axxsYbbIeqg7p6RTQM6nyLv245SPj+0+rYI9a0l
        jXLi2fJ/qXyKyUopXNhyTZeVGOfaing=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-Ez_QjJz0MzWg4whaUZrZBA-1; Tue, 08 Nov 2022 09:42:15 -0500
X-MC-Unique: Ez_QjJz0MzWg4whaUZrZBA-1
Received: by mail-pg1-f197.google.com with SMTP id s16-20020a632c10000000b0047084b16f23so1982184pgs.7
        for <fstests@vger.kernel.org>; Tue, 08 Nov 2022 06:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTmDfKiGCHm1PjPPCu7maOE3HaVIzuPbMvII3Riwrts=;
        b=kgkn/lIU/AepGPoe14SUVx8S6hjeFwz0Q7N/lOIPzBMk4QYwyXVHBZz7OYrlaAdhxl
         gnaatMsYdWU+IecQch2SADzN7aoJN1Y4Z8dxguuZT9WRPzhRUQkYWnEWn1IjrCE4QjLt
         oVw6j9abMCVYUB7vQjYaAsaPFlNZ7h6QtRI/YOedLCFnEMcwlqSXVjzSgBJJHhkfdm7x
         zpnBgHMb3sLEZYSWFQ08JA0xmluxymAS5fS70aMIFDHeWAGMJ0yRL8vja9Zaa+AvY0fK
         s27QXxiqlyEBEdMLR6pPAqqgeI+8AZTO3O2t06jgVwbR2kB2EBvYC0lbB/uVi71Z0EMA
         YuSQ==
X-Gm-Message-State: ACrzQf1At7Zsjgnd8VlqpWIIOB3iodXbbAEhl71wgLVHtkc9Gm00Da+a
        8EM+2peJEqcHUKNsJL9U4tN6HccIT1ejVS49/hGF4+kcbu4YO+tOC9EiBAoXov0kGNDh+kSLcz7
        JPlnBKXj/3LRMC/ZMQQ==
X-Received: by 2002:a05:6a00:238c:b0:56c:b442:6d28 with SMTP id f12-20020a056a00238c00b0056cb4426d28mr58090613pfc.62.1667918534570;
        Tue, 08 Nov 2022 06:42:14 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5jSSVeekV9DpDNuQACmPPPUJUNryNe6oGscWjR6FWl9XlxATr8rdlJjdX4Z3UrqUqU9vqX5A==
X-Received: by 2002:a05:6a00:238c:b0:56c:b442:6d28 with SMTP id f12-20020a056a00238c00b0056cb4426d28mr58090592pfc.62.1667918534209;
        Tue, 08 Nov 2022 06:42:14 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b0020bfd6586c6sm6214974pjb.7.2022.11.08.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:42:13 -0800 (PST)
Date:   Tue, 8 Nov 2022 22:42:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: check direct IO writes with io_uring and
 O_DSYNC are durable
Message-ID: <20221108144208.tbn5f7rxfsp3lzhq@zlang-mailbox>
References: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 09:38:58AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> failure happens after they complete.
> 
> This is motivated by a regression on btrfs, affecting 5.15 stable kernels
> and kernels up to 6.0, where often the writes were not persisted (same
> behaviour as if O_DSYNC was not provided). This was recently fixed by the
> following commit:
> 
> 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/703     | 104 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/703.out |   2 +
>  2 files changed, 106 insertions(+)
>  create mode 100755 tests/generic/703
>  create mode 100644 tests/generic/703.out
> 
> diff --git a/tests/generic/703 b/tests/generic/703
> new file mode 100755
> index 00000000..39ae3773
> --- /dev/null
> +++ b/tests/generic/703
> @@ -0,0 +1,104 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 703
> +#
> +# Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> +# failure happens after they complete.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log prealloc io_uring
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter

This patch looks very good to me, it even doesn't miss any _require_* helpers
or group names, and its comments are good enough. I can't pick up any problems
from my side, just two tiny review points (as you will change the commit log
at least, so might change them by the way:).

1) This case doesn't use any filter functions, so don't need "common/filter".

> +. ./common/dmflakey
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +test_file="${SCRATCH_MNT}/foo"
> +
> +[ $FSTYP == "btrfs" ] &&
> +	_fixed_by_kernel_commit 8184620ae212 \
> +	"btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
> +
> +_supported_fs generic
> +# We allocate 256M of data for the test file, so require a higher size of 512M
> +# which gives a margin of safety for a COW filesystem like btrfs (where metadata
> +# is always COWed).
> +_require_scratch_size $((512 * 1024))

2) I think nearly no one use a SCRATCH_DEV < 512M to run fstests, but I can't
say this's wrong, so you can decide to keep or remove this line by yourself.
Both are good to me.

With these:
Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_require_odirect
> +_require_io_uring
> +_require_dm_target flakey
> +_require_xfs_io_command "falloc"
> +
> +cat >$fio_config <<EOF
> +[test_io_uring_dio_dsync]
> +ioengine=io_uring
> +direct=1
> +bs=64K
> +sync=1
> +filename=$test_file
> +rw=randwrite
> +time_based
> +runtime=10
> +EOF
> +
> +_require_fio $fio_config
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# We do 64K writes in the fio job.
> +_require_congruent_file_oplen $SCRATCH_MNT $((64 * 1024))
> +
> +touch $test_file
> +
> +# On btrfs IOCB_NOWAIT writes can only be done on NOCOW files, so enable
> +# nodatacow on the file if we are running on btrfs.
> +if [ $FSTYP == "btrfs" ]; then
> +	_require_chattr C
> +	$CHATTR_PROG +C $test_file
> +fi
> +
> +$XFS_IO_PROG -c "falloc 0 256M" $test_file
> +
> +# Persist everything, make sure the file exists after power failure.
> +sync
> +
> +echo -e "Running fio with config:\n" >> $seqres.full
> +cat $fio_config >> $seqres.full
> +
> +$FIO_PROG $fio_config --output=$fio_out
> +
> +echo -e "\nOutput from fio:\n" >> $seqres.full
> +cat $fio_out >> $seqres.full
> +
> +digest_before=$(_md5_checksum $test_file)
> +
> +# Simulate a power failure and mount the filesystem to check that all the data
> +# previously written are available.
> +_flakey_drop_and_remount
> +
> +digest_after=$(_md5_checksum $test_file)
> +
> +if [ "$digest_after" != "$digest_before" ]; then
> +	echo "Error: not all file data got persisted."
> +	echo "Digest before power failure: $digest_before"
> +	echo "Digest after power failure:  $digest_after"
> +fi
> +
> +_unmount_flakey
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/703.out b/tests/generic/703.out
> new file mode 100644
> index 00000000..fba62571
> --- /dev/null
> +++ b/tests/generic/703.out
> @@ -0,0 +1,2 @@
> +QA output created by 703
> +Silence is golden
> -- 
> 2.35.1
> 

