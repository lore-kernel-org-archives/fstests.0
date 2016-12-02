Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:44996 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbcLBD3k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Dec 2016 22:29:40 -0500
Date: Fri, 2 Dec 2016 14:29:35 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: cleanups after common/rc split
Message-ID: <20161202032935.GH11750@dastard>
References: <20161201042213.16859-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201042213.16859-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 01, 2016 at 12:22:13PM +0800, Eryu Guan wrote:
> Fix code style issues after the common/rc split, e.g. use tab
> indention, fix if-then-else format, fix while-do and for-do format
> and various whitespace issues. No functional changes.

Couple of quick things....

> +	OPTS=" "
> +	DBOPTS=" "
> +	USAGE="Usage: xfs_check [-fsvV] [-l logdev] [-i ino]... [-b bno]... special"
> +
> +	while getopts "b:fi:l:stvV" c; do
> +		case $c in
> +			s) OPTS=$OPTS"-s ";;
> +			t) OPTS=$OPTS"-t ";;
> +			v) OPTS=$OPTS"-v ";;
> +			i) OPTS=$OPTS"-i "$OPTARG" ";;
> +			b) OPTS=$OPTS"-b "$OPTARG" ";;
> +			f) DBOPTS=$DBOPTS" -f";;
> +			l) DBOPTS=$DBOPTS" -l "$OPTARG" ";;
> +			V) $XFS_DB_PROG -p xfs_check -V
> +			   return $?
> +			   ;;
> +		esac

It saves space and makes it easier to read if you don't indent the
individual cases but do indent the code so multi-line operations
don't end up with weird space indenting:

		case $c in
		s)	OPTS=$OPTS"-s ";;
		t)	OPTS=$OPTS"-t ";;
		v)	OPTS=$OPTS"-v ";;
		....
		V)	$XFS_DB_PROG -p xfs_check -V
			return $?
			;;

> @@ -198,23 +197,23 @@ _test_xfs_logprint()
>  
>  _scratch_xfs_check()
>  {
> -    SCRATCH_OPTIONS=""
> -    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> -        SCRATCH_OPTIONS="-l $SCRATCH_LOGDEV"
> -    [ "$LARGE_SCRATCH_DEV" = yes ] && \
> -        SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"
> -    _xfs_check $SCRATCH_OPTIONS $* $SCRATCH_DEV
> +	SCRATCH_OPTIONS=""
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> +		SCRATCH_OPTIONS="-l $SCRATCH_LOGDEV"
> +	[ "$LARGE_SCRATCH_DEV" = yes ] && \
> +		SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"

If it's a multi-line construct, just use if [...]; then.

> +	_xfs_check $SCRATCH_OPTIONS $* $SCRATCH_DEV
>  }
>  
>  _scratch_xfs_repair()
>  {
> -    SCRATCH_OPTIONS=""
> -    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> -        SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
> -    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
> -        SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -r$SCRATCH_RTDEV"
> -    [ "$LARGE_SCRATCH_DEV" = yes ] && SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"
> -    $XFS_REPAIR_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
> +	SCRATCH_OPTIONS=""
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> +		SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
> +		SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -r$SCRATCH_RTDEV"

And this can become:

	if [ "$USE_EXTERNAL" = yes ]; then
		[ -n "$SCRATCH_LOGDEV" ] && SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV" 
		[ -n "$SCRATCH_RTDEV" ] && SCRATCH_OPTIONS="-l$SCRATCH_RTDEV" 
	fi

> +
> +	$XFS_LOGPRINT_PROG -t $extra_log_options $device 2>&1 \
> +		| tee $tmp.logprint | grep -q "<CLEAN>"
> +	if [ $? -ne 0 -a "$HOSTOS" = "Linux" ]; then
> +		echo "_check_xfs_filesystem: filesystem on $device has dirty log (see $seqres.full)"
> +
> +		echo "_check_xfs_filesystem: filesystem on $device has dirty log"   >>$seqres.full
> +		echo "*** xfs_logprint -t output ***"	>>$seqres.full
> +		cat $tmp.logprint			>>$seqres.full
> +		echo "*** end xfs_logprint output"	>>$seqres.full

Better, I think, with these multi-line file dumps is something like:

		(
		echo ....
		echo ....
		cat ...
		echo
		) >> $seqres.full
> +	if [ $ok -eq 0 ]; then
> +		echo "*** mount output ***"		>>$seqres.full
> +		_mount					>>$seqres.full
> +		echo "*** end mount output"		>>$seqres.full
> +	elif [ "$type" = "xfs" ]; then
> +		_mount_or_remount_rw "$extra_mount_options" $device $mountpoint
> +	fi
> +
> +	if [ $ok -eq 0 ]; then
> +		status=1
> +		if [ "$iam" != "check" ]; then
> +			exit 1
> +		fi
> +		return 1
> +	fi

THese $ok -eq 0 cases can be combined.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
