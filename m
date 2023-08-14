Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FDC001DB
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjHNPiI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHNPh4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 11:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444CA10D0
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 08:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FFB63D7F
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 15:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349CDC433C8;
        Mon, 14 Aug 2023 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692027474;
        bh=skbddAFFYuBQwzT2ccLGP27dSlr1S8DpzFbPztRCp8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGXBAOgao6Czy/dK4JHpLgSoZrIF4l/mzVwkrsH28/Qygq1q/96rJr+Ns3wp9kZ0W
         SK1WtH1HD5J2h+z5ANrjmiah+oVwhZ5Il96qhZQqm0CT0sPZuIY5MHhj9vW/4tIMWa
         5Z1ow4lGVWDAbqgO+ilOuUPk8IIZvh9n0ueDrbk050Jtng5bGm1/+J40kuerTklsco
         9rcvAj/PtpNsU2bahlLuhJLTJ0QJvEZdhfp+eTcUGCbp/T0hgIPRnCk6qqXmb5KKKC
         5t4UZvclaXhYy4dISO9HEIWYAkyW343ObkPoG5GTUKQ5LqyO48c6cDPYdpA1lMXONJ
         q5z18HRomrLVQ==
Date:   Mon, 14 Aug 2023 08:37:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, axboe@kernel.dk, tytso@mit.edu, shr@fb.com
Subject: Re: [PATCH] generic/471: Remove this broken case
Message-ID: <20230814153753.GR11377@frogsfrogsfrogs>
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Fine with me, since nobody thinks this test does anything useful, nor
has anyone made it do something useful.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
