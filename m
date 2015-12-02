Received: from mx1.redhat.com ([209.132.183.28]:55089 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbbLBSn0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Dec 2015 13:43:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 046E7A85
	for <fstests@vger.kernel.org>; Wed,  2 Dec 2015 18:43:26 +0000 (UTC)
Date: Wed, 2 Dec 2015 13:43:24 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [patch] fstests: remove generic/042 from the 'auto' group
Message-ID: <20151202184322.GA53117@bfoster.bfoster>
References: <x49wpswogc9.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49wpswogc9.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 02, 2015 at 01:28:22PM -0500, Jeff Moyer wrote:
> Hi,
> 
> This test fails 100% of the time for me on xfs and current git head, and
> is not run for ext4 since ext4 does not support shutdown.  After talking
> with bfoster, it isn't expected to succeed right now.  Since the auto
> group is for tests that *are* expected to succeed, let's move this one
> out.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 

My recollection for this test was that Dave had described the delalloc
extent -> real extent stale data exposure issue and I had a thought on
how to reproduce it based on some work I was doing on the zero range
bits around that time. That happened to prove effective, so I wanted to
get the test included before I lost track of it (even though a real fix
wasn't yet available).

I had played with fixing this a bit before. IIRC, it's potentially
affected by some of the work to kill buffer_head usage in the writepages
path, so I might revisit it once that stuff is more fleshed out. Until
then, this seems reasonable to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> diff --git a/tests/generic/group b/tests/generic/group
> index a33536e..4b70008 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -44,7 +44,7 @@
>  039 metadata auto quick
>  040 metadata auto quick
>  041 metadata auto quick
> -042 auto quick rw
> +042 quick rw
>  043 metadata log auto
>  044 metadata log auto
>  045 metadata log auto
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
