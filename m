Received: from mx1.redhat.com ([209.132.183.28]:44956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754902AbeARIs7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 03:48:59 -0500
Date: Thu, 18 Jan 2018 16:48:57 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 2/3] common/filter: factor out expected XFS warnings
 for mount
Message-ID: <20180118084857.GU3102@eguan.usersys.redhat.com>
References: <20180116040254.GE3102@eguan.usersys.redhat.com>
 <1516087617-2077-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1516087617-2077-2-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516087617-2077-2-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 16, 2018 at 03:26:56PM +0800, xiao yang wrote:
> 1) Move filter_xfs_dmesg from xfs/098 to common/filter, and rename
>    it as _filter_assert_dmesg.
> 
> 2) Add _require_no_xfs_debug helper to skip xfs/098 if it is tested
>    on debug build.
> 
> Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/filter |  9 +++++++++
>  tests/xfs/098 | 18 ++++++------------
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 8e1fdb4..8f90b01 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -570,5 +570,14 @@ _filter_aiodio_dmesg()
>  	    -e "s#$warn9#Intentional warnings in dio_complete#"
>  }
>  
> +# We generate assert WARNINGs on CONFIG_XFS_WARN build as expected and make
> +# sure test doesn't fail because of these warnings. This is a helper for
> +# _check_dmesg() to filter out them.
> +_filter_assert_dmesg()
> +{
> +	local warn="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"

When bug_on_assert=0, the "asswarn" can be "assfail" too, we should
filter out both cases.

> +	sed -e "s#$warn#Intentional warnings in asswarn#"
> +}
> +
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/xfs/098 b/tests/xfs/098
> index 9bcd94b..f924b32 100755
> --- a/tests/xfs/098
> +++ b/tests/xfs/098
> @@ -47,6 +47,9 @@ _cleanup()
>  _supported_fs xfs
>  _supported_os Linux
>  
> +# We corrupt XFS on purpose, and debug built XFS would crash due to
> +# assert failure, so skip if we're testing on a debug built XFS
> +_require_no_xfs_debug

Same here, _require_no_xfs_bug_on_assert if we all agree to do so.

Thanks,
Eryu

>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
>  _require_attrs
> @@ -56,16 +59,6 @@ test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-n 8 -3"
>  
>  rm -f $seqres.full
>  
> -# If we corrupt log on a CONFIG_XFS_WARN build, there will be mount related
> -# WARNINGs in dmesg as expected.  We don't want to simply _disable_dmesg_check
> -# which could miss other potential bugs, so filter out the intentional WARNINGs,
> -# make sure test doesn't fail because of this warning and fails on other WARNINGs.
> -filter_xfs_dmesg()
> -{
> -	local warn="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
> -	sed -e "s#$warn#Intentional warnings in asswarn#"
> -}
> -
>  TESTDIR="${SCRATCH_MNT}/scratchdir"
>  TESTFILE="${TESTDIR}/testfile"
>  
> @@ -107,8 +100,9 @@ _scratch_mount 2>/dev/null && _fail "mount should not succeed"
>  echo "+ repair fs"
>  _repair_scratch_fs >> $seqres.full 2>&1
>  
> -# mount may trigger related WARNINGs, so filter them.
> -_check_dmesg filter_xfs_dmesg
> +# We may trigger mounted related WARNINGs if we corrupt log on a
> +# CONFIG_XFS_WARN build, so filter them.
> +_check_dmesg _filter_assert_dmesg
>  
>  echo "+ mount image (2)"
>  _scratch_mount
> -- 
> 1.8.3.1
> 
> 
> 
