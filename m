Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D84C04A94
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjHNWoA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjHNWnw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 18:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF7AB
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692052986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+54lQGAF6RHNwwWtHMdK8aZR8RUdadlhvvLHQK7RBuE=;
        b=XZ1TF5Cw+7nR21C/IJYNII84zeI3v1dad++eCaisNhFLqhIA3xaybgiEVJgiPfb0sdH38l
        KqUx+nK7G/FT6z0Cl5Je2UHoHHGIIbX9Mfi1wpzTuAtDa8G02tcJ7BNdJkra0YZRnc9Xcu
        vMlSQDbtL32Yp5laGurgC1EoAoaFQCc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-bmR8HgxFOuSfnMAOOC2dTQ-1; Mon, 14 Aug 2023 18:43:01 -0400
X-MC-Unique: bmR8HgxFOuSfnMAOOC2dTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97A8538149A1;
        Mon, 14 Aug 2023 22:43:00 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 138EB63F76;
        Mon, 14 Aug 2023 22:43:00 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:42:58 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org, axboe@kernel.dk,
        tytso@mit.edu, shr@fb.com
Subject: Re: [PATCH] generic/471: Remove this broken case
Message-ID: <ZNqt8tCmI2BmzM/P@redhat.com>
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 10:41:41PM +0800, Yang Xu wrote:
> I remember this case fails on last year becuase of
> kernel commit cae2de69 ("iomap: Add async buffered write support")
> kernel commit 1aa91d9 ("xfs: Add async buffered write support").
> as below:
>      pwrite: Resource temporarily unavailable
>      wrote 8388608/8388608 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -RWF_NOWAIT time is within limits.
>     +pwrite: Resource temporarily unavailable
>     +(standard_in) 1: syntax error
>     +RWF_NOWAIT took  seconds
> 
> So For async buffered write requests, the request will return -EAGAIN
> if the ilock cannot be obtained immediately.
> 
> Here also a discussion[1] that seems generic/471 has been broken.
> 
> Now, I met this problem in my linux distribution, then I found the above
> discussion. IMO, remove this case is ok and then we can avoid to meet this
> false report again.
> 
> [1]https://lore.kernel.org/linux-xfs/b2865bd6-2346-8f4d-168b-17f06bbedbed@kernel.dk/
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  tests/generic/471     | 67 -------------------------------------------
>  tests/generic/471.out | 13 ---------
>  2 files changed, 80 deletions(-)
>  delete mode 100755 tests/generic/471
>  delete mode 100644 tests/generic/471.out
> 
> diff --git a/tests/generic/471 b/tests/generic/471
> deleted file mode 100755
> index fbd0b12a..00000000
> --- a/tests/generic/471
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
> -#
> -# FS QA Test No. 471
> -#
> -# write a file with RWF_NOWAIT and it would fail because there are no
> -# blocks allocated. Create a file with direct I/O and re-write it
> -# using RWF_NOWAIT. I/O should finish within 50 microsecods since
> -# block allocations are already performed.
> -#
> -. ./common/preamble
> -_begin_fstest auto quick rw
> -
> -# Import common functions.
> -. ./common/populate
> -. ./common/filter
> -. ./common/attr
> -
> -# real QA test starts here
> -_require_odirect
> -_require_test
> -_require_xfs_io_command pwrite -N
> -
> -# Remove reminiscence of previously run tests
> -testdir=$TEST_DIR/$seq
> -if [ -e $testdir ]; then
> -	rm -Rf $testdir
> -fi
> -
> -mkdir $testdir
> -
> -# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail with -EAGAIN
> -# when writing to a file range except if it's a NOCOW file and an extent for the
> -# range already exists or if it's a COW file and preallocated/unwritten extent
> -# exists in the target range. So to make sure that the last write succeeds on
> -# all filesystems, use a NOCOW file on btrfs.
> -if [ $FSTYP == "btrfs" ]; then
> -	_require_chattr C
> -	# Zoned btrfs does not support NOCOW
> -	_require_non_zoned_device $TEST_DEV
> -	touch $testdir/f1
> -	$CHATTR_PROG +C $testdir/f1
> -fi
> -
> -# Create a file with pwrite nowait (will fail with EAGAIN)
> -$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> -
> -# Write the file without nowait
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testdir/f1 | _filter_xfs_io
> -
> -time_taken=`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1M" $testdir/f1 | awk '/^1/ {print $5}'`
> -
> -# RWF_NOWAIT should finish within a short period of time so we are choosing
> -# a conservative value of 50 ms. Anything longer means it is waiting
> -# for something in the kernel which would be a fail.
> -if (( $(echo "$time_taken < 0.05" | bc -l) )); then
> -	echo "RWF_NOWAIT time is within limits."
> -else
> -	echo "RWF_NOWAIT took $time_taken seconds"
> -fi
> -
> -$XFS_IO_PROG -c "pread -v 0 8M" $testdir/f1 | _filter_xfs_io_unique
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> deleted file mode 100644
> index ab23272e..00000000
> --- a/tests/generic/471.out
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -QA output created by 471
> -pwrite: Resource temporarily unavailable
> -wrote 8388608/8388608 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -RWF_NOWAIT time is within limits.
> -00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -*
> -00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> -*
> -00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -*
> -read 8388608/8388608 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.27.0
> 

