Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:8663 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbbJRViM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2015 17:38:12 -0400
Date: Mon, 19 Oct 2015 08:37:45 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: introduce XFS_IO_AVOID env var
Message-ID: <20151018213745.GX27164@dastard>
References: <1445107518-32022-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445107518-32022-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 17, 2015 at 02:45:18PM -0400, Theodore Ts'o wrote:
> Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
> using various advanced file system features such as "fpunch"
> "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
> command which is included in the space-separated list found in the
> XFS_IO_AVOID environment variable will be skipped using _notrun.

This tells me what the change does, not why you need it.

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  README    | 4 ++++
>  common/rc | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/README b/README
> index f8a878c..bb0075b 100644
> --- a/README
> +++ b/README
> @@ -78,6 +78,10 @@ Preparing system for tests (IRIX and Linux):
>                 added to the end of fsstresss and fsx invocations, respectively,
>                 in case you wish to exclude certain operational modes from these
>                 tests.
> +	     - setenv XFS_IO_AVOID which may contain a list of space separated
> +	       xfs_io commands which will be avoided in case you want to
> +	       exclude tests that require the use of certain file system
> +	       operations such as "fpunch", "fcollapse", "finsert", or "zero".

Again, what, not why.

>          - or add a case to the switch in common/config assigning
>            these variables based on the hostname of your test
> diff --git a/common/rc b/common/rc
> index adf1edf..61de97e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1603,6 +1603,11 @@ _require_xfs_io_command()
>  	fi
>  	command=$1
>  
> +	if echo "$XFS_IO_AVOID" | grep -wq "$command"
> +	then
> +		_notrun "Avoiding xfs_io $command"
> +	fi
> +
>  	testfile=$TEST_DIR/$$.xfs_io
>  	case $command in
>  	"falloc" )

And the following case statement actually tests where the xfs_io
command is supported by the binary and kernel, and notruns if it
isn't supported by either. Why isn't this sufficient?

Can you describe the problem so we can understand why explicitly
avoiding certain xfs_io operations rather than using probing is
necessary?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
