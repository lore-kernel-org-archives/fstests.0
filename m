Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EDEC001B0
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Aug 2023 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjHMPfY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Aug 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHMPfY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Aug 2023 11:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835DE5C
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 08:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35B862E2D
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 15:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C0C433C9;
        Sun, 13 Aug 2023 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691940924;
        bh=tlzax0jMYshZe7Or0sk8siayDiHahT4IA3Oz4cYvhgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JraMj9iMPkdWRYc6/quJ9UQgMa6Od3I6G35Ap2dPsS7Vi8bchNwrYcFxkyur26EGB
         MgvawsM614z2L60ISF9zI5ylZ0DNWZz2WY80jA8zSBFL6ZUbadgLk7EV3cnjDxyREm
         vNZBGJnLNXI+911S9T5TibTThkWuAiFnvfxMTQl/cB6CNR/j7WI+8WCO9nv39otBDZ
         9mz8LMgIS9u8Dp72V903NPDeROJvfIMOJzVQ3L2ThKUrzsXYubRrQC3yxQ0uLGHyAn
         f3NP/bH6ld5nqRTNGMRsQ0qRU2HhADNp4QJO3yY+G4gpMC9qZzhayFRUf1svSGMU9M
         7TSmP3vi+8W9w==
Date:   Sun, 13 Aug 2023 08:35:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/{175,297,298}: fix use of uninitialized var
Message-ID: <20230813153523.GQ11377@frogsfrogsfrogs>
References: <20230812151500.553233-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151500.553233-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 12, 2023 at 06:15:00PM +0300, Amir Goldstein wrote:
> Not sure how those tests pass in regression tests.
> Probably truncate silently fails and is not critical to the test.
> 
> in kdevops I get errors like:
> /data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
>            syntax error: operand expected (error token is "/dev/loop12)")
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  tests/generic/175 | 2 +-
>  tests/generic/297 | 2 +-
>  tests/generic/298 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 07af2199..14825a39 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -33,7 +33,7 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
>  
>  fnr=19
>  echo "Create extents"
> -truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
> +truncate -s $(( (2 ** (fnr + 1)) * blksz)) "$testdir/file1"
>  for i in $(seq 0 $fnr); do

Hmm.  Frankly I don't remember why I put those truncate calls in there.
Does the test still work if you remove them entirely?  AFAICT the test
writes a single block's worth of data to the file, then truncates the
file size to one block.  Which I think is pointless.

>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/297 b/tests/generic/297
> index 6bdc3e1c..1fc48671 100755
> --- a/tests/generic/297
> +++ b/tests/generic/297
> @@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
> +truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))

The loop control logic could be converted to:

echo "Find a reflink size that takes a long time"
deadline="$(( $(date +%s) + timeout ))"
for ((i = 0, now = $(date +%s); i < fnr && now < deadline; i++, now = $(date +%s))); do
	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
	n=$(( (2 ** i) * blksz))
	$XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1
done

(also in 298)

--D

> diff --git a/tests/generic/298 b/tests/generic/298
> index 95d4c02b..2e917a87 100755
> --- a/tests/generic/298
> +++ b/tests/generic/298
> @@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
> +truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> -- 
> 2.34.1
> 
