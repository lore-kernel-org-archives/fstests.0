Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751296AbeBWE3a (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Feb 2018 23:29:30 -0500
Date: Fri, 23 Feb 2018 12:29:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/xfs: Initialise OPTIND for getopts calls
Message-ID: <20180223042928.GV18267@eguan.usersys.redhat.com>
References: <20180223035454.1406-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223035454.1406-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 23, 2018 at 02:54:54PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> According to the bash man page:
> 
> 	OPTIND is initialized to 1 each time the shell or a shell
> 	script is invoked.
> 
> This doesn't appear to be true - in tests scripts with no other
> getopts calls, I'm seeing the getopts loop in _xfs_check to fail
> to parse input parameters correctly. Tracing shows the parameters
> are being passed to _xfs_check correctly, but on occassion getopts
> simply doesn't see the,

Hmm, unfinished sentence here?

Otherwise looks fine to me.

Thanks,
Eryu

> 
> Hence when running tests with both external log and real time
> devices, tests are failing at random because xfs_check is
> mis-parsing the parameters passed to it and not configuring the
> external log correctly:
> 
> _check_xfs_filesystem: filesystem on /dev/sdg is inconsistent (c)
> *** xfs_check output ***
> aborting - no external log specified for FS with an external log
> *** end xfs_check output
> 
> Fix this by ensuring OPTIND is correctly initialised before using
> getopts. Do it for all places that call getopts that don't already
> set OPTIND=1 before starting their parsing loop.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> ---
>  common/xfs        | 1 +
>  tests/generic/074 | 1 +
>  tests/generic/075 | 1 +
>  tests/generic/112 | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/common/xfs b/common/xfs
> index 2cb77778831a..2aff1b3bcb5c 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -119,6 +119,7 @@ _xfs_check()
>  	DBOPTS=" "
>  	USAGE="Usage: xfs_check [-fsvV] [-l logdev] [-i ino]... [-b bno]... special"
>  
> +	OPTIND=1
>  	while getopts "b:fi:l:stvV" c; do
>  		case $c in
>  			s) OPTS=$OPTS"-s ";;
> diff --git a/tests/generic/074 b/tests/generic/074
> index 5f205b509eb6..d39f9a3d4309 100755
> --- a/tests/generic/074
> +++ b/tests/generic/074
> @@ -87,6 +87,7 @@ _usage()
>  
>  _process_args()
>  {
> +    OPTIND=1
>      while getopts "f:l:n:?" c $@
>      do
>          case $c
> diff --git a/tests/generic/075 b/tests/generic/075
> index 321c72177618..e9dd4a5c5dcd 100755
> --- a/tests/generic/075
> +++ b/tests/generic/075
> @@ -98,6 +98,7 @@ _usage()
>  
>  _process_args()
>  {
> +    OPTIND=1
>      while getopts "l:n:N:?" c $@
>      do
>          case $c
> diff --git a/tests/generic/112 b/tests/generic/112
> index 0ab1c8c87907..5ab1cb3ad4ca 100755
> --- a/tests/generic/112
> +++ b/tests/generic/112
> @@ -94,6 +94,7 @@ _usage()
>  
>  _process_args()
>  {
> +    OPTIND=1
>      while getopts "l:n:N:?" c $@
>      do
>          case $c
> -- 
> 2.16.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
