Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AF2C4361B
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Dec 2020 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514A423BF0
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Dec 2020 08:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgLKIbZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728423AbgLKIbY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Dec 2020 03:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607675397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5lhuxxunh2BiRPG7rxqTsKRVZRfclzaVh47PYnopeY=;
        b=iIojOeP76OsNVT0w8zoPXbpG2g+7M2PQMU1ugjObJfkSja68Qg0j2ZKZserPJ9W7YbINkA
        71o341Si5zVyGVS0X1uOItKgI9DOPyLKTn5nNz9/gj+q0BjxmbsdNINIGgVxkzqwZxz1An
        YQd4CxpOuaRztFjrw9tZyjO4okC3NuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-s95PO5K3PNSUK1Yx7Nr8OA-1; Fri, 11 Dec 2020 03:29:55 -0500
X-MC-Unique: s95PO5K3PNSUK1Yx7Nr8OA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBEEB1075644
        for <fstests@vger.kernel.org>; Fri, 11 Dec 2020 08:29:54 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 567D86F989;
        Fri, 11 Dec 2020 08:29:54 +0000 (UTC)
Date:   Fri, 11 Dec 2020 16:45:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/563: use a loop device to avoid partition
 incompatibility
Message-ID: <20201211084508.GY14354@localhost.localdomain>
Mail-Followup-To: Brian Foster <bfoster@redhat.com>,
        fstests@vger.kernel.org
References: <20201210161426.1927144-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210161426.1927144-1-bfoster@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 10, 2020 at 11:14:26AM -0500, Brian Foster wrote:
> cgroup writeback accounting does not track partition level
> statistics. Instead, I/O is accounted against the parent device. As
> a result, the test fails if the scratch device happens to be a
> device partition. Since parent level stats are potentially polluted
> by factors external to the test, wrap the scratch device in a
> loopback device to guarantee the test always runs on a top-level
> block device.
> 
> Reported-by: Boyang Xue <bxue@redhat.com>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  tests/generic/563 | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index 51deaa2f..9292dece 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
>  #
> -# FS QA Test No. 011
> +# FS QA Test No. 563
>  #
>  # This test verifies that cgroup aware writeback properly accounts I/Os in
>  # various scenarios. We perform reads/writes from different combinations of
> @@ -26,6 +26,8 @@ _cleanup()
>  
>  	echo $$ > $cgdir/cgroup.procs
>  	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
> +	umount $SCRATCH_MNT > /dev/null 2>&1
> +	_destroy_loop_device $LOOP_DEV > /dev/null 2>&1
>  }
>  
>  # get standard environment, filters and checks
> @@ -42,14 +44,12 @@ rm -f $seqres.full
>  _supported_fs generic
>  _require_scratch
>  _require_cgroup2 io
> +_require_loop
>  
>  # cgroup v2 writeback is only support on block devices so far
>  _require_block_device $SCRATCH_DEV
>  
> -smajor=$((0x`stat -L -c %t $SCRATCH_DEV`))
> -sminor=$((0x`stat -L -c %T $SCRATCH_DEV`))
>  cgdir=$CGROUP2_PATH
> -
>  iosize=$((1024 * 1024 * 8))
>  
>  # Check cgroup read/write charges against expected values. Allow for some
> @@ -89,12 +89,19 @@ reset()
>  	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
>  	$XFS_IO_PROG -fc "pwrite 0 $iosize" $SCRATCH_MNT/file \
>  		>> $seqres.full 2>&1
> -	_scratch_cycle_mount || _fail "mount failed"
> +	umount $SCRATCH_MNT || _fail "umount failed"
> +	_mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
>  	stat $SCRATCH_MNT/file > /dev/null
>  }
>  
> -_scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount
> +# cgroup I/O accounting doesn't work on partitions. Use a loop device to rule
> +# that out.
> +LOOP_DEV=$(_create_loop_device $SCRATCH_DEV)

I recommend using a file to create loop device. If you'd like to use SCRATCH_DEV
to create loop device directly, you'd better to change the "_require_scratch"
to "_require_scratch_nocheck". Or I think it might be failed, e.g. if SCRATCH_DEV
is a 4k sector size device.

Others look good to me.

Thanks,
Zorro

> +smajor=$((0x`stat -L -c %t $LOOP_DEV`))
> +sminor=$((0x`stat -L -c %T $LOOP_DEV`))
> +
> +_mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
> +_mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
>  
>  echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
>  
> -- 
> 2.26.2
> 

