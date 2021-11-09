Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC791C4332F
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A951E611BF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 17:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhKIR3E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhKIR3D (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Nov 2021 12:29:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 947FD61027;
        Tue,  9 Nov 2021 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636478777;
        bh=N/5+jE2wMVleliNrjMEDInq7YsgD5JVviIBfl+xljys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5L7xN6a6ZeqbgcZJch+jfjeWWGhPtdjFcX8hY7ZQanaW114OCq1WuzxQAsUI/q9C
         sDWFf87KT57FELTOqASTI39aNNEdzZcMvb2sAO7M/UUqK7rzDLhz4G50nCVDAc4xNl
         TyAsL+x8lPSTb/zIIQNkSoNUnDAPqmcAMskp36cnfuRbbog59i2YJ4ZMOB3H8IkEm3
         7ONjNNSP/+/Oj2iGfB/b8wkIpz3RR7ekB8ln31jJUcqudwhKc7XI6WRBMw3UYkLSbw
         ZJLlh+/F749olIagwX6rgbyUIhg31u3wtSJnNtAmS4cKOStNjHJL04BECH4C1QAgrz
         PV8SLZqWBEDGQ==
Date:   Tue, 9 Nov 2021 09:26:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/648: dmerror must be unmounted
Message-ID: <20211109172617.GL24282@magnolia>
References: <20211024120512.2383377-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024120512.2383377-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 24, 2021 at 08:05:12PM +0800, Zorro Lang wrote:
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
> loop to try to unmount it enough times.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> As Darrick's review point, V2 brings the "iteration XXX scratch
> unmount failed" _fail back.
> 
> Thanks,
> Zorro
> 
>  tests/generic/648 | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/648 b/tests/generic/648
> index 83dd111d..e5c743c5 100755
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
> @@ -112,7 +112,21 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
>  	# Mount again to replay log after loading working table, so we have a
>  	# consistent fs after test.
>  	$UMOUNT_PROG $loopmnt
> -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
> +	is_unmounted=1
> +	# We must unmount dmerror at here, or whole later testing will crash.
> +	# So try to umount enough times, before we have no choice.
> +	for ((j = 0; j < 100; j++)); do
> +		sleep 1
> +		_dmerror_unmount > $tmp.unmount.err 2>&1
> +		if [ $? -eq 0 ];then
> +			is_unmounted=0
> +			break
> +		fi
> +	done
> +	if [ $is_unmounted -ne 0 ];then
> +		cat $tmp.unmount.err
> +		_fail "iteration $i scratch unmount failed"
> +	fi
>  	_dmerror_load_working_table
>  	if ! _dmerror_mount; then
>  		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
> -- 
> 2.31.1
> 
