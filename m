Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39608 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360AbbBECtM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 4 Feb 2015 21:49:12 -0500
Date: Thu, 5 Feb 2015 13:48:57 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/8 v4] common/rc:  define dump.f2fs and logstate for f2fs
Message-ID: <20150205024857.GG12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-7-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423004840-45315-7-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 03, 2015 at 03:07:18PM -0800, Jaegeuk Kim wrote:
> This patch defines dump.f2fs and logstate for f2fs's clean and dirty logs.
> And, also it adds _link_out_file_fs to specify output according to filesystem.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/config |  1 +
>  common/log    | 20 +++++++++++++++++---
>  common/rc     | 22 ++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 9fb3703..cdc2214 100644
> --- a/common/config
> +++ b/common/config
> @@ -221,6 +221,7 @@ case "$HOSTOS" in
>          export MKFS_UDF_PROG="`set_prog_path mkudffs`"
>          export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
>          export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
> +        export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
>          export BMAP_F2FS_PROG="`set_prog_path fibmap.f2fs`"
>          export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>          export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
> diff --git a/common/log b/common/log
> index 87074d9..186eb4c 100644
> --- a/common/log
> +++ b/common/log
> @@ -218,11 +218,25 @@ _check_log()
>  
>  _print_logstate()
>  {
> -    _scratch_xfs_logprint -t | tee -a $seqres.full >$tmp.logprint
> -    if grep -q "<DIRTY>" $tmp.logprint; then
> +    case "$FSTYP" in
> +        xfs)
> +            _scratch_xfs_logprint -t | tee -a $seqres.full >$tmp.logprint
> +            DIRTY="<DIRTY>"
> +            CLEAN="<CLEAN>"
> +            ;;
> +        f2fs)
> +            _scratch_f2fs_logprint | tee -a $seqres.full >$tmp.logprint
> +            DIRTY="sudden-power-off"
> +            CLEAN="unmount"
> +            ;;
> +        *)
> +            ;;
> +    esac
> +
> +    if grep -q $DIRTY $tmp.logprint; then
>  	echo "dirty log"
>      fi
> -    if grep -q "<CLEAN>" $tmp.logprint; then
> +    if grep -q $CLEAN $tmp.logprint; then
>  	echo "clean log"
>      fi

The only output from this function is "clean log" or "dirty log".

so:

_scratch_xfs_logstate()
{
	_scratch_xfs_logprint -t | tee -a $seqres.full | grep -q "<CLEAN>"
	echo $?
}

_scratch_f2fs_logstate()
{
	$DUMP_F2FS_PROG $SCRATCH_DEV | tee -a $seqres.full | grep -q "unmount"
	echo $?
}

_print_logstate()
{
	case "$FSTYP" in
	xfs)
		dirty=$(_scratch_xfs_logstate)
		;;
	f2fs)
		dirty=$(_scratch_f2fs_logstate)
		;;
	*)
		;;
	esac

	if [ $dirty -ne 0 ]; then
		echo "dirty log"
	else
		echo "clean log"
	fi
}

> +_link_out_file_fs()
> +{
> +	if [ -z "$1" -o -z "$2" ]; then
> +		echo Error must pass src and dst.
> +		exit
> +	fi
> +	rm -f $2
> +	ln -s $1.$FSTYP $2
> +}

Not sure why this is necessary, but I'll point that out where it is
used.

> +
>  _die()
>  {
>          echo $@
> @@ -2435,6 +2450,13 @@ _require_dumpe2fs()
>  	fi
>  }
>  
> +_require_dumpf2fs()
> +{
> +	if [ -z "$DUMP_F2FS_PROG" ]; then
> +		_notrun "This test requires dump.f2fs utility."
> +	fi
> +}

Actually, I'd make that

_require_logstate()
{
	case "$FSTYP" in
	xfs)
		if [ -z "$XFS_LOGPRINT_PROG" ]; then
			_notrun "This test requires xfs_logprint utility."
		fi
	f2fs)
		if [ -z "$DUMP_F2FS_PROG" ]; then
			_notrun "This test requires dump.f2fs utility."
		fi
		;;
	*)
		_notrun "$FSTYP does not support log state probing."
		;;
	esac
}


> +
>  _require_ugid_map()
>  {
>  	if [ ! -e /proc/self/uid_map ]; then
> -- 
> 2.1.1
> 
> 

-- 
Dave Chinner
david@fromorbit.com
