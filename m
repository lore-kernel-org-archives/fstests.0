Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622AEC433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C43610A6
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhKHRSW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235503AbhKHRSK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Nov 2021 12:18:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46DF5610A6;
        Mon,  8 Nov 2021 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636391726;
        bh=uWB/U1dhz5NKKPiCZ81LWmEqI1Ba5Xp/lKd7grNYPFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiCug0DhjFo7ZGu0uE3bHceLYTA/StTK0Yi0dsoE8xGVXS0C79eDyNV2YY5KMUhDb
         qPiQL2+1UYdqeBQv0RnQPL7ep0Gx6+sGUWo9yuNmJYSFEFqWZYrVVtX7dHRS17cXzO
         96PUuE04NyC5OCLZntlE62Anu+MXQHsHxoB2+UVKGBhTJmg+J39dVAcZ17iCEpL8fa
         VMMNiI40w7L3hj/vUf2gzc+knS91uKwfFXEdu7e9xwu/ygeS8sKWRDyu1VVykoFYa1
         qZZJV6f/gLTrcWx+UjuZRr/h/8V5EGYrLweQW3woMKzWmkBXmnEQ4wMClye7yGfgWU
         H52jiUoBBvAkg==
Date:   Mon, 8 Nov 2021 09:15:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@suse.com>,
        Anthony Iliopoulos <ailiop@suse.com>
Subject: Re: [PATCH] generic/528: take fs timestamps granularity into account
 in tolerance interval
Message-ID: <20211108171525.GI24282@magnolia>
References: <20211108144905.11515-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211108144905.11515-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 08, 2021 at 02:49:05PM +0000, Luís Henriques wrote:
> Filesystems timestamps granularity can cause spurious test failures:
> 
>   QA output created by 528
>   btime has value of 1635818936
>   btime is NOT in range 1635818937 .. 1635818942
> 
> This test output makes it looks like $testfile was created *before* the
> 'date' command was executed.  What really happen was that btime was
> truncated according to the granularity defined by filesystem (I've seen
> this with both ext4 and xfs, but I guess others are also affected).
> 
> Since granularity can't be worse than a second, simply adjust the test
> tolerance interval by 1 second.

/me wonders if that's still going to trip over vfat/ntfs, but as far as
modern xfs/ext4/btrfs go, this should be sufficient.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  tests/generic/528 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/528 b/tests/generic/528
> index 24d1ee0e5ec7..a63827b1139b 100755
> --- a/tests/generic/528
> +++ b/tests/generic/528
> @@ -41,7 +41,7 @@ btime=$(date +%s -d "$($XFS_IO_PROG -c "statx -v -m $STATX_BTIME" $testfile | \
>  	grep 'stat.btime =' | cut -d '=' -f 2)")
>  test -n "$btime" || echo "error: did not see btime in output??"
>  
> -_within_tolerance "btime" "$btime" "$now" 0 5 -v
> +_within_tolerance "btime" "$btime" "$now" 1 5 -v
>  
>  status=0
>  exit
