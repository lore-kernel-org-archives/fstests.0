Date: Mon, 17 Oct 2016 08:46:08 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 3/3] fstests: run xfs_io as multi threaded for 'quick'
 tests
Message-ID: <20161016214608.GC14023@dastard>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
 <1476615222-7804-3-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476615222-7804-3-git-send-email-amir73il@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 16, 2016 at 01:53:42PM +0300, Amir Goldstein wrote:
> Try to run xfs_io for tests in group quick with command line
> option -M which starts an idle thread before performing any io.
> 
> The purpose of this idle thread is to test io from a multi threaded
> process. With single threaded process, the file table is not shared
> and file structs are not reference counted.
> 
> In order to improve the chance of detecting file struct reference
> leaks, we should run xfs_io commands with this option as much as
> possible.
> 
> Analysis of the effect of xfs_io -M on tests runtime showed that
> it may lead to slightly longer run times in extreme cases (e.g +3s
> for generic/132), but has a negligable effect on runtime of tests
> among the 'quick' group (worst case +0.3s for generic/130).
> 
> Therefore, we automatically add the -M flags only to tests in the
> 'quick' group.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  check     |  2 ++
>  common/rc | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/check b/check
> index 69341d8..e568598 100755
> --- a/check
> +++ b/check
> @@ -574,6 +574,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  
>  	    mkdir -p $RESULT_DIR
>  
> +	    export TEST_GROUPS=`grep $(basename $seqnum) "$SRC_DIR/$(dirname $seqnum)/group"`
> +

Do we really want to go down this path of changing behaviours
of utilities based on what group  they belong to? It means we can no
longer look at the test code and recreate the command line without
having to work out what group context the test is running under. And
how do we tell that it's correct and we don't inadvertantly break
it? I ask this because.....

>  	    echo -n "$seqnum"
>  
>  		if $showme; then
> diff --git a/common/rc b/common/rc
> index a838750..7c478cf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3799,6 +3799,21 @@ init_rc()
>  	$XFS_IO_PROG -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
>  		export XFS_IO_PROG="$XFS_IO_PROG -F"
>  
> +	if echo $TEST_GROUPS | grep -q quick; then
> +		# xfs_io -M flag runs xfs_io as multi threaded process
> +		# in order to catch fdget/fdset reference leaks, because
> +		# file structs are not reference counted in a single threaded
> +		# process.
> +		# Because reference counted fdget/fdset may lead to slightly
> +		# longer run times in extreme cases (such as generic/132),
> +		# we limit the use of -M flags to tests with short runtime,
> +		# where the effect of the flag is negligable.
> +		#
> +		# Figure out if xfs_io supports the -M option
> +		$XFS_IO_PROG -M -c quit 2>/dev/null && \
> +			export XFS_IO_PROG="$XFS_IO_PROG -M"
> +	fi
> +

.... I can't see how this works - init_rc is
called and sets $XFS_IO_PROG long before TEST_GROUPS is set and
exported. How did you verify that the correct xfs_io command lines
were being issued?

IMO, either turn it on for everything if it is supported, or make it
an explicit command line option to enable. A couple of seconds of
extra runtime here and there means nothing for a typical auto test
run which can take hours to run....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
