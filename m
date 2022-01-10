Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B8EC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Jan 2022 17:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiAJR3X (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiAJR3X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Jan 2022 12:29:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D4C06173F
        for <fstests@vger.kernel.org>; Mon, 10 Jan 2022 09:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E47EB815CB
        for <fstests@vger.kernel.org>; Mon, 10 Jan 2022 17:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ACFC36AE3;
        Mon, 10 Jan 2022 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641835760;
        bh=sqErIshbOPNxCzhSUZx1K1M0ElldVdwnqx2oe9vLWRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2zZrJFPSOnUFbBIa0YHGmdLzOCjWRL5mWCmvPXedamNf51+t8ipAgDmd3qJhDb6l
         fU0lYh6LZtagjB6UTJwJDDpFYeaAfqDXrluVZamK3FgFxkv7aFz9qsq/e3gS1QKkbF
         MaQNimxXgUgUeWy1wIqEAvzoK5Qc6h5plhmOIlPrMx+37nXfPb6LeZQVWS3aqFnFr/
         9xEdUqkEENULNORjtyUM8M0/Y4ZkuwCW0UcHAmmiUmxIbjUu8h8YdPD05S/jWiW/AY
         dUE2AYnbxZDhESnm9PQQ6vZcAYBxsVNX8i9meV4kjtts0kJUiiCKRCppJzS44oaCrU
         NpDk0rV7t9Jow==
Date:   Mon, 10 Jan 2022 09:29:19 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: fix _check_xfs_scrub_does_unicode on newer
 versions of libc-bin
Message-ID: <20220110172919.GE31566@magnolia>
References: <20220109195935.3453304-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109195935.3453304-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 09, 2022 at 02:59:35PM -0500, Theodore Ts'o wrote:
> Debian 10 uses ldd from glibc 2.28, where as Debian 11 uses ldd from
> glibc 2.31.  Sometime between glibc 2.28 and 2.31, ldd has been
> changed so that the message "not a dynamic executable" is sent stderr,
> where before it was sent to stdout.  As a result, it caused
> regressions for tests such as generic/453 which uses
> _check_xfs_scurb_does_unicode:
> 
> generic/453 5s ... 	[22:42:03] [22:42:08]- output mismatch (see /results/xfs/results-4k/generic/453.out.bad)
>     --- tests/generic/453.out	2022-01-08 15:15:15.000000000 -0500
>     +++ /results/xfs/results-4k/generic/453.out.bad	2022-01-08 22:42:08.596982251 -0500
>     @@ -4,3 +4,4 @@
>      Test files
>      Uniqueness of inodes?
>      Test XFS online scrub, if applicable
>     +	not a dynamic executable
>     ...
> 
> Fix this by sending stderr from ldd to /dev/null.  This is not a
> perfect solution, since it means that even if xfs_scrub was compiled
> with libicui18n, we will skip the online scrub portion of generic/453.
> However, this fixes the regression when runtime OS is changed from
> Debian Buster to Debian Bullseye when xfsprogs is built statically.
> 
> In the long run, it would be nice if we could determine whether
> xfs_scrub has unicode support without using ldd --- perhaps by
> signally this in the output of xfs_scrub -V --- but we'll need to
> discuss this with the xfsprogs maintainers.

Hm, yeah, I suppose we could improve the way xfs_scrub reports its own
capabilities.  I'll work on that, though in the mean time I think you
can detect it via...

strings $XFS_SCRUB_PROG | grep -q 'Unicode name.*%s'

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

In the meantime, this at least shuts up the false fail, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 87b9b69b..add6170c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4909,7 +4909,7 @@ _check_xfs_scrub_does_unicode() {
>  
>  	# We only care if xfs_scrub has unicode string support...
>  	if ! type ldd > /dev/null 2>&1 || \
> -	   ! ldd "${XFS_SCRUB_PROG}" | grep -q libicui18n; then
> +	   ! ldd "${XFS_SCRUB_PROG}" 2> /dev/null | grep -q libicui18n; then
>  		return 1
>  	fi
>  
> -- 
> 2.31.0
> 
