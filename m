Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:48590 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966301AbcKXUA2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Nov 2016 15:00:28 -0500
Date: Fri, 25 Nov 2016 07:00:13 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: teach _scratch_mkfs to handle mkfs option
 conflicts
Message-ID: <20161124200013.GT31101@dastard>
References: <20161124160643.2438-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161124160643.2438-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 25, 2016 at 12:06:43AM +0800, Eryu Guan wrote:
> Currently in _scratch_mkfs only xfs and ext4 could handle the mkfs
> failure caused by conflicts between $MKFS_OPTIONS and mkfs options
> specified by tests, because of _scratch_mkfs_xfs and
> _scratch_mkfs_ext4. This is a very useful functionality that allows
> tests to specify mkfs options safely and to test specific fs
> configurations, without worrying about mkfs failures caused by these
> options.
> 
> Now teach _scratch_mkfs to handle such mkfs option conflicts for
> other filesystems too, i.e. mkfs again only with mkfs options
> specified by tests. Also add the ability to filter unnecessary
> messages from mkfs stderr.

Nice!

.....
> +	local extra_mkfs_options=$*
> +	local mkfs_cmd=""
> +	local mkfs_filter=""
> +	local mkfs_status
> +
> +	case $FSTYP in
> +	xfs)
> +		_scratch_mkfs_xfs $extra_mkfs_options
> +		;;
> +	nfs*)
> +		# unable to re-create NFS, just remove all files in
> +		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
> +		# created in previous runs
> +		_scratch_cleanup_files
> +		;;
> +	cifs)
> +		# unable to re-create CIFS, just remove all files in
> +		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
> +		# created in previous runs
> +		_scratch_cleanup_files
> +		;;
> +	ceph)
> +		# Don't re-create CephFS, just remove all files
> +		_scratch_cleanup_files
> +		;;
> +	overlay)
> +		# unable to re-create overlay, remove all files in $SCRATCH_MNT
> +		# to avoid EEXIST caused by the leftover files created in
> +		# previous runs
> +		_scratch_cleanup_files
> +		;;
> +	tmpfs)
> +		# do nothing for tmpfs
> +		;;
> +	ext4)
> +		_scratch_mkfs_ext4 $extra_mkfs_options
> +		;;
> +	udf)
> +		mkfs_cmd="$MKFS_UDF_PROG"
> +		mkfs_filter="cat"
> +		;;
> +	btrfs)
> +		mkfs_cmd="$MKFS_BTRFS_PROG"
> +		mkfs_filter="cat"
> +		;;
> +	ext2|ext3)
> +		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
> +		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
> +		;;
> +	f2fs)
> +		mkfs_cmd="$MKFS_F2FS_PROG"
> +		mkfs_filter="cat"
> +		;;
> +	ocfs2)
> +		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
> +		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
> +		;;
> +	*)
> +		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
> +		mkfs_filter="cat"
> +		;;
> +	esac
> +	mkfs_status=$?

I suspect that $? can be undefined at this point - it's value is set
by whatever the last command was run, and not all the cases above
run a command.  This might be better handled by something like:

	case $FSTYP in
	nfs*|cifs|ceph|overlay)
		# unable to re-create this fstyp, just remove all files in
		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
		# created in previous runs
		_scratch_cleanup_files
		return 0
		;;
	tmpfs)
		# do nothing
		return 0
		;;
	ext4)
		_scratch_mkfs_ext4 $extra_mkfs_options
		return $?
		;;
	xfs)
		_scratch_mkfs_xfs $extra_mkfs_options
		return $?
		;;
	udf)
		mkfs_cmd="$MKFS_UDF_PROG"
		mkfs_filter="cat"
		;;
	.....
> +
> +	# return immediately if FSTYP is handled by dedicated helpers
> +	if [ -z "$mkfs_cmd" ]; then
> +		return $mkfs_status
> +	fi

And then this can go as well.

> +
> +	# save mkfs output in case conflict means we need to run again.
> +	# only the output for the mkfs that applies should be shown
> +	eval "$mkfs_cmd $MKFS_OPTIONS $extra_mkfs_options $SCRATCH_DEV" \
> +		2>$tmp.mkfserr 1>$tmp.mkfsstd
> +	mkfs_status=$?
> +
> +	# a mkfs failure may be caused by conflicts between $MKFS_OPTIONS and
> +	# $extra_mkfs_options
> +	if [ $mkfs_status -ne 0 -a -n "$extra_mkfs_options" ]; then
> +		(
> +		echo -n "** mkfs failed with extra mkfs options "
> +		echo "added to \"$MKFS_OPTIONS\" by test $seq **"
> +		echo -n "** attempting to mkfs using only test $seq "
> +		echo "options: $extra_mkfs_options **"
> +		) >> $seqres.full
> +
> +		# running mkfs again. overwrite previous mkfs output files
> +		eval "$mkfs_cmd $extra_mkfs_options $SCRATCH_DEV" \
> +			2>$tmp.mkfserr 1>$tmp.mkfsstd
> +		mkfs_status=$?
> +	fi
> +
> +	# output stored mkfs output, filtering unnecessary output from stderr
> +	cat $tmp.mkfsstd
> +	cat $tmp.mkfserr | $mkfs_filter >&2

Perhaps you could make this a function? Because then it can probably
be used in _scratch_mkfs_ext4 and _scratch_mkfs_xfs as well?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
