Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:12442 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750826AbcCVXe4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2016 19:34:56 -0400
Date: Wed, 23 Mar 2016 10:34:51 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v5 3/3] generic/338-346: Add richacl tests
Message-ID: <20160322233451.GX11812@dastard>
References: <1458127565-24149-1-git-send-email-agruenba@redhat.com>
 <1458127565-24149-4-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458127565-24149-4-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 16, 2016 at 12:26:05PM +0100, Andreas Gruenbacher wrote:
>  
> +_require_richacl()
> +{
> +	GETRICHACL_PROG=`set_prog_path getrichacl`
> +	_require_command "$GETRICHACL_PROG" getrichacl
> +	SETRICHACL_PROG=`set_prog_path setrichacl`
> +	_require_command "$SETRICHACL_PROG" setrichacl
> +}
> +
> +_setup_scratch_richacl_xfs()
> +{
> +	_scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
> +		|| _notrun "mkfs.xfs doesn't have richacl feature"
> +
> +	_scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
> +	_scratch_mount >/dev/null 2>&1 \
> +		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> +}
> +
> +__setup_scratch_richacl()
> +{
> +	_scratch_mkfs -O richacl >/dev/null 2>&1 \
> +		|| _notrun "can't mkfs $FSTYP with option -O richacl"
> +	_scratch_mount >/dev/null 2>&1 \
> +		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> +}
> +
> +_setup_scratch_richacl()
> +{
> +	_require_scratch
> +	case "$FSTYP" in
> +	xfs)    _setup_scratch_richacl_xfs
> +		;;
> +	ext4)   __setup_scratch_richacl
> +		;;
> +	*)      _notrun "this test requires richacl support on \$SCRATCH_DEV"
> +		;;
> +	esac
> +}

These are all _require functions. Please don't combine test
requirements with initial test condition setup, nor hide
requirements inside other requirements. If a test runs some
other _require_scratch_foo() after these richacl checks, then the
scratch device wil be in an undefined state. IOws, these
functions are:

_require_richacl_prog()
_require_scratch_richacl_xfs()
_require_scratch_richacl_ext4()
_require_scratch_richacl()
_scratch_mkfs_richacl()

And the test needs to do this as setup:

_require_scratch
_require_scratch_richacl
_require_richacl_prog

_scratch_mkfs_richacl
_scratch_mount



> new file mode 100755
> index 0000000..88e4141
> --- /dev/null
> +++ b/tests/generic/343
.....
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_richacl
> +_setup_scratch_richacl
> +
> +cd $SCRATCH_MNT
> +
> +r() {
> +	echo "--- runas -u 99 -g 99 $*"
> +	$here/src/runas -u 99 -g 99 -- "$@"
> +}

Need to add _require_runas here, and generic/026, generic/093,
generic/237 and shared/051 also need their open coded checks for the
executable changed to _require_runas. (multiple tests in this
patch need this).

> diff --git a/tests/generic/group b/tests/generic/group
> index 727648c..e892ae9 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -340,3 +340,12 @@
>  335 auto quick metadata
>  336 auto quick metadata
>  337 auto quick metadata
> +338 auto richacl
> +339 auto richacl
> +340 auto richacl
> +341 auto richacl
> +342 auto richacl
> +343 auto richacl
> +344 auto richacl
> +345 auto richacl
> +346 auto richacl

MOst of thse tests take only a couple of seconds to run, right? If
so, then they should probably also be in the quick group.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
