Received: from mx1.redhat.com ([209.132.183.28]:38629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbcF2N3z (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:55 -0400
Date: Wed, 29 Jun 2016 21:29:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH -v2] generic/082: rename _filter_project_quota to a avoid
 function name conflict
Message-ID: <20160629132952.GN23649@eguan.usersys.redhat.com>
References: <1467206458-2277-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467206458-2277-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 29, 2016 at 09:20:58AM -0400, Theodore Ts'o wrote:
> Commit 8469a8c1: "xfs/133-4: filter redundant projid 0 quota report
> info out" added _filter_project_quota to common/filter, and this
> conflicted with a _filter_project_quota function in generic/082.  So
> rename the function in generic/082 to avoid the conflict.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/082 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/082 b/tests/generic/082
> index a727c10..a41afe6 100755
> --- a/tests/generic/082
> +++ b/tests/generic/082
> @@ -36,9 +36,9 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> -_filter_project_quota()
> +filter_project_quota_line()
>  {
> -    grep -v "^project quota on"
> +	grep -v "^project quota on"
>  }
>  
>  # get standard environment, filters and checks
> @@ -69,7 +69,7 @@ quotaon $SCRATCH_MNT >>$seqres.full 2>&1
>  # just ignored, but quota is still on. This may change in future, let's
>  # re-consider the case then.
>  _scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
> -quotaon -p $SCRATCH_MNT | _filter_scratch | _filter_project_quota
> +quotaon -p $SCRATCH_MNT | _filter_scratch | filter_project_quota_line
>  # second remount should succeed, no oops or hang expected
>  _scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
>  
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
