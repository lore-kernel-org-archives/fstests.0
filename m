Received: from mail.cn.fujitsu.com ([183.91.158.132]:41414 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727218AbeK1SNE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 13:13:04 -0500
Message-ID: <5BFE3FCF.1070700@cn.fujitsu.com>
Date: Wed, 28 Nov 2018 15:12:15 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/47[23]: remove from auto/quick groups
References: <20180223050112.4090-1-david@fromorbit.com>
In-Reply-To: <20180223050112.4090-1-david@fromorbit.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/02/23 13:01, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> generic/472 is for changes that are not upstream and seem dead in
> the water at the moment, so remove this test from the auto and quick
> groups until it's been resolved upstream and the changes merged.
>
> generic/473 really doesn't seme useful. FIEMAP is a debugging
> interface, xfs_io is a debugging tool and so trying to make every
> filesytem report exactly the same thing for a ranged query just
> strikes me as the wrong thing to be doing. This fails on XFS, and
> there's no apparent resolution to that in sight, so remove the test
> from the auto and quick, too.
Hi Dave, Eryu

generic/473 with XFS got the mismatched extent info and was marked as a
broken test:
-------------------------------
Hole + Data
0: [0..127]: hole
-1: [128..255]: data
+1: [128..135]: data
-------------------------------

Is this a correct behavior? If not, is this issue going to be fixed in
the future?

Best Regards,
Xiao Yang
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/group | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/generic/group b/tests/generic/group
> index b2ce7a66ce81..1e808865772f 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -474,8 +474,8 @@
>  469 auto quick
>  470 auto quick dax
>  471 auto quick rw
> -472 auto quick rw
> -473 auto quick
> +472 rw
> +473 broken
>  474 auto quick shutdown metadata
>  475 shutdown auto log metadata
>  476 auto rw
