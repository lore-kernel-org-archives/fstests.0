Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:3456 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754099AbbCPXZS (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Mar 2015 19:25:18 -0400
Date: Tue, 17 Mar 2015 10:24:34 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv3 xfstests 2/3] generic: test openat and new O_BENEATH
 flag
Message-ID: <20150316232434.GJ28557@dastard>
References: <1425909612-28034-1-git-send-email-drysdale@google.com>
 <1425909612-28034-3-git-send-email-drysdale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425909612-28034-3-git-send-email-drysdale@google.com>
Sender: fstests-owner@vger.kernel.org
To: David Drysdale <drysdale@google.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Meredydd Luff <meredydd@senatehouse.org>, Will Drewry <wad@chromium.org>, Jorge Lucangeli Obes <jorgelo@google.com>, Ricky Zhou <rickyz@google.com>, Lee Campbell <leecam@google.com>, Julien Tinnes <jln@google.com>, Mike Depinet <mdepinet@google.com>, James Morris <james.l.morris@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Paolo Bonzini <pbonzini@redhat.com>, Paul Moore <paul@paul-moore.com>, Christoph Hellwig <hch@infradead.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 09, 2015 at 02:00:11PM +0000, David Drysdale wrote:
> Test basic openat(2) behaviour.
> 
> Test that if O_BENEATH flag is set, openat() will only
> open paths that have no .. component and do not start
> with /.  Symlinks are also checked for the same restrictions.
> 
> Signed-off-by: David Drysdale <drysdale@google.com>
> ---
>  .gitignore            |   1 +
>  common/openat         |  61 ++++++++++++++++++++++++++++++
>  src/Makefile          |   3 +-
>  src/openat.c          | 100 +++++++++++++++++++++++++++++++++++++++++++++++++

This strikes me as something that shoul dbe added to xfs_io for
testing, as it already supports a heap of other open flags and
xfstests is already dependent on it.

>  tests/generic/151     |  89 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/151.out |   9 +++++
>  tests/generic/152     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/152.out |  23 ++++++++++++
>  tests/generic/group   |   2 +

I'd also prefer one patch per new test - it's easier to review...

> +_openat_setup()
> +{
> +	local dir=$1
> +
> +	mkdir -p $dir/subdir
> +	echo 0123456789 > $dir/topfile
> +	echo 0123456789 > $dir/subdir/bottomfile
> +
> +	ln -s subdir/bottomfile $dir/symlinkdown
> +	ln -s ../topfile $dir/subdir/symlinkup
> +	ln -s $dir/topfile $dir/subdir/symlinkout
> +	ln -s bottomfile  $dir/subdir/symlinkin
> +}
> +
> +#
> +# Check whether the openat wrapper program is available
> +#
> +_requires_openat()
> +{
> +	OPENAT_PROG=$here/src/openat
> +        _require_command $OPENAT_PROG
> +}

if this is part of xfs_io, then _requires_xfs_io_command "open -b"
could be used to test if the command is supported, and no need for
this function at all.

> +#
> +# This checks whether the O_BENEATH flag is supported by the openat syscall
> +#
> +_requires_o_beneath()
> +{
> +	# Kernels that don't support O_BENEATH will silently accept it, so
> +	# check for O_BENEATH behavior: attempting to open an absolute
> +	# path should fail with EPERM.
> +	$OPENAT_PROG -t -b $TEST_DIR
> +	if [ $? -ne 0 ]; then
> +		_notrun "kernel doesn't support O_BENEATH flag in openat syscall"
> +	fi
> +}

as running the command would tell us if the kernel supports it, too.

> +#endif
> +#endif
> +
> +void usage(const char *progname)
> +{
> +	fprintf(stderr, "Usage: %s [-f dirname] [-b] [-n] [-t] <file>\n",
> +		progname);
> +	fprintf(stderr,"    -f dirname : use this dir for dfd\n");
> +	fprintf(stderr,"    -b         : open with O_BENEATH\n");
> +	fprintf(stderr,"    -n         : open with O_NOFOLLOW\n");
> +	fprintf(stderr,"    -t         : test for expected EPERM failure\n");
> +	fprintf(stderr,"    -h         : show this usage message\n");
> +	exit(1);

Hmm - you're also testing O_NOFOLLOW behaviour too? Perhaps that
should be mentioned/added to xfs_io, too?

The reason I suggest this, even though it's a little more work, is
tht we can then re-use the new flags in other tests easily without
needing to write new helper functions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
