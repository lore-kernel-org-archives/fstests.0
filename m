Received: from mx1.redhat.com ([209.132.183.28]:49146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcLXKUO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 24 Dec 2016 05:20:14 -0500
Date: Sat, 24 Dec 2016 18:20:11 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V2] generic/395: test GETNEXTQUOTA near INT_MAX
Message-ID: <20161224102011.GS1859@eguan.usersys.redhat.com>
References: <a3c43ff2-c641-aba4-b10e-781a3f3c86e3@redhat.com>
 <8c91051e-8a78-cb20-d926-ea86e5b4645a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c91051e-8a78-cb20-d926-ea86e5b4645a@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 07:11:21PM -0600, Eric Sandeen wrote:
> XFS kernel code had a bug where GETNEXTQUOTA-type
> quotactls requesting an ID near UINT_MAX could overflow
> and return 0 as the "next" active ID.
> 
> This test checks that by creating an active quota near
> UINT_MAX, then asking for the next one after it.
> 
> The proper answer is ENOENT, but if we wrap we'll return
> ID 0.
> 
> This also changes test-nextquota.c so that it checks
> both GETNEXTQUOTA and XGETNEXTQUOTA even if one fails;
> it stores the failure conditions and returns 1 if either
> of them fails.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: cleanups from Eryu's review.
> 
> Eryu - I need to send a _require_getnextquota patch, and some
> other cleanups to 244, similar to your review of this test
> (I copied this test from 244).
> 
> I'll do that in reply to this patch, hopfully tonight, yet.

Thanks, Eric!

> +# remount just for kicks, make sure we get it off disk
> +_scratch_unmount
> +_qmount
> +quotaon $SCRATCH_MNT 2>/dev/null

I removed this quotaon too and merged.

Thanks,
Eryu
