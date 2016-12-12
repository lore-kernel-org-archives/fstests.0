Received: from mx1.redhat.com ([209.132.183.28]:51254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754031AbcLLKGZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Dec 2016 05:06:25 -0500
Date: Mon, 12 Dec 2016 18:06:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 3/7] reflink: fix quota tests to work properly
Message-ID: <20161212100622.GZ29149@eguan.usersys.redhat.com>
References: <148149316504.31093.16129068344227450710.stgit@birch.djwong.org>
 <148149318401.31093.3864124073555352683.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148149318401.31093.3864124073555352683.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: ocfs2-devel@oss.oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 11, 2016 at 01:53:04PM -0800, Darrick J. Wong wrote:
> Fix the reflink quota tests to su to the fsgqa user so that we actually
> test enforcement of quotas.  Seems that XFS enforces user quotas even
> if root is writing to a user file, whereas everything else lets root
> writes through.  Also clean up some of the variable usage and
> _require_user.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/generic/305     |    2 +-
>  tests/generic/305.out |   30 +++++++++++++++---------------
>  tests/generic/326     |    2 +-
>  tests/generic/326.out |   30 +++++++++++++++---------------
>  tests/generic/327     |   12 +++++++-----
>  tests/generic/327.out |   12 ++++++------
>  tests/generic/328     |   14 ++++++++------
>  tests/generic/328.out |   28 ++++++++++++++--------------
>  8 files changed, 67 insertions(+), 63 deletions(-)
> 
> 
> diff --git a/tests/generic/305 b/tests/generic/305
> index d73d87f..9c3489b 100755
> --- a/tests/generic/305
> +++ b/tests/generic/305
> @@ -51,7 +51,7 @@ _require_quota
>  _require_nobody
>  
>  _repquota() {
> -	repquota $SCRATCH_MNT | egrep '^(fsgqa|root|nobody)'
> +	repquota -O csv $SCRATCH_MNT | egrep '^(fsgqa|root|nobody)' | awk -F ',' '{print $1, $4, $5, $6}'

The version of "quota" is a bit old shipped by RHEL7, there's no "-O"
option support. And this works for me

	repquota $SCRATCH_MNT | egrep '^(fsgqa|root|nobody)' | awk '{print $1, $3, $4, $5}'

Still worth chaning the .out files this way?

Thanks,
Eryu
