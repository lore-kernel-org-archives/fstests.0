Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21841C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Oct 2021 03:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E6B61211
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Oct 2021 03:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhJPDwe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 15 Oct 2021 23:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhJPDwc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 15 Oct 2021 23:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B33D60462;
        Sat, 16 Oct 2021 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634356225;
        bh=/8XkQKBdYOCw2rYLGbHnMKh6QgudmM8m/0uRi8lkaZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wr9a8zNWUpiFhdKc0DbeBMKr/CowOIkVkWG7GExJzEUbYlpDaY91/Pil+vS3OYL2K
         scFAIWlsMsbSjEAKaXONzS4UjDkzfcHkcxXjBCAMN+TEr+tiSrfKGHCZBAr+/fUeSF
         jjfmyJqT4fGOknt7hOntD/vp8GOlwypoBv//4wHo9iEH14/2PCBKNB4qg6LmM7X4r4
         psl5tSP+N7iy+AyD4uvZ6ghv/BBLXT0B3kYSbq6ETQL8vOAwSUlFmUJO0OOYO+Cadr
         FHdNxDb3a2vgUGCfBzCadXm9rhL9F0Xn5jpLIHTApTvjzxaTv3qHUOq5vASxxJi6pg
         rayOkcV1if6TQ==
Date:   Fri, 15 Oct 2021 20:50:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/648: dmerror must be unmounted
Message-ID: <20211016035024.GI24282@magnolia>
References: <20211016021456.3097323-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016021456.3097323-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Oct 16, 2021 at 10:14:56AM +0800, Zorro Lang wrote:
> Sometimes g/648 fail to unmount dmerror with this error:
> 
>    umount: /mnt/xfstests/scratch: target is busy.
> 
> Even worse, it will cause all later test cases fail as:
> 
>   mount: bad usage
>   Try 'mount --help' for more information.
>   check: failed to mount $SCRATCH_DEV using specified options
>   Interrupted!
> 
> So we shouldn't _fail directly if dmerror_unmount fails, use a while
> loop to try to make sure it's unmounted.

Can we preserve the "iteration XXX scratch unmount failed" message,
please?

--D

> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/648 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/648 b/tests/generic/648
> index 83dd111d..218f207b 100755
> --- a/tests/generic/648
> +++ b/tests/generic/648
> @@ -104,7 +104,7 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
>  		wait > /dev/null 2>&1
>  		ps -e | grep fsstress > /dev/null 2>&1
>  	done
> -	for ((i = 0; i < 10; i++)); do
> +	for ((j = 0; j < 10; j++)); do
>  		test -e "$snap_aliveflag" || break
>  		sleep 1
>  	done
> @@ -112,7 +112,11 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
>  	# Mount again to replay log after loading working table, so we have a
>  	# consistent fs after test.
>  	$UMOUNT_PROG $loopmnt
> -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
> +	_dmerror_unmount > /dev/null 2>&1
> +	while [ $? -ne 0 ]; do
> +		sleep 1
> +		_dmerror_unmount > /dev/null 2>&1
> +	done
>  	_dmerror_load_working_table
>  	if ! _dmerror_mount; then
>  		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
> -- 
> 2.31.1
> 
