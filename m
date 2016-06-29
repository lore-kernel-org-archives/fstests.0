Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:37418 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873AbcF2GSK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2016 02:18:10 -0400
Date: Wed, 29 Jun 2016 16:11:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/082: rename _filter_project_quota to a avoid
 function name conflict
Message-ID: <20160629061109.GS27480@dastard>
References: <1467163987-11242-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467163987-11242-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 28, 2016 at 09:33:07PM -0400, Theodore Ts'o wrote:
> Commit 8469a8c1: "xfs/133-4: filter redundant projid 0 quota report
> info out" added _filter_project_quota to common/filter, and this
> conflicted with a _filter_project_quota function in generic/082.  So
> rename the function in generic/082 to avoid the conflict.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/082 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/082 b/tests/generic/082
> index a727c10..fa61ba9 100755
> --- a/tests/generic/082
> +++ b/tests/generic/082
> @@ -36,9 +36,9 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> -_filter_project_quota()
> +_filter_project_quota_line()
>  {
> -    grep -v "^project quota on"
> +	grep -v "^project quota on"
>  }

Functions starting with "_" denote common scope functions (i.e.
from externally sourced files), not local test functions. Just
remove the "_" prefix here....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
