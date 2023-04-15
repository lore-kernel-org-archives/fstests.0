Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44509C77B72
	for <linux-fstests@archiver.kernel.org>; Sat, 15 Apr 2023 00:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDOAfo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Apr 2023 20:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOAfo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Apr 2023 20:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8E49D7
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2023 17:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E8FC64AD9
        for <fstests@vger.kernel.org>; Sat, 15 Apr 2023 00:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0BDC433EF;
        Sat, 15 Apr 2023 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681518942;
        bh=JzZRpTA3rabSKG3GjETI7AkmLslvD/vjh94bZz7GXkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Co4WJXNrInzeuF9/o5JveZA/eLqXOnlgaP2HpaDL1MhW+r0cbnVLn/j7ayjqRvPzW
         uZqE2+MMUqlIH4pt1g4wdDgLq6MOOy6rpWPVET2WLL+iTYdbJ1x9uyJYnNP3195hgD
         1skktg7WX/yTj/TXXrjvTparvRikiuCohHDQzlJDlVS1WGrScb9gduP2cS/FhW9+v0
         zvq/NLJOip/seZqlqcohnlHyTHqT8s6lLRXko4D+KxOxIup0XemgSVAC7HSai02WPU
         6xPJhkRXxAp2PS2NmWQx0f6xUNXCxh2T2i5b0IG6gtuLOMVPMN71PXs8JDqk0vaBBM
         x1hHzcRpkRLyw==
Date:   Fri, 14 Apr 2023 17:35:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/2] check: try to fix the test device if it gets
 corrupted
Message-ID: <20230415003541.GB360885@frogsfrogsfrogs>
References: <20230414221133.3431400-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414221133.3431400-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 14, 2023 at 03:11:32PM -0700, Leah Rumancik wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> If the test device gets corrupted all subsequent tests will fail.  To
> prevent this from causing all subsequent tests to be useless, try
> repair the file system on TEST_DEV if possible.  We don't need to do
> this with the scratch device since that file system gets recreated
> each time anyway.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  check      |  7 ++++++-
>  common/rc  | 41 +++++++++++++++++++++++++++++++++++++++++
>  common/xfs | 12 ++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 1a58a2b2..befbf465 100755
> --- a/check
> +++ b/check
> @@ -536,7 +536,12 @@ _check_filesystems()
>  	local ret=0
>  
>  	if [ -f ${RESULT_DIR}/require_test ]; then
> -		_check_test_fs || ret=1
> +		if ! _check_test_fs ; then
> +			ret=1
> +			echo "Trying to repair broken TEST_DEV file system"
> +			_repair_test_fs
> +			_test_mount
> +		fi
>  		rm -f ${RESULT_DIR}/require_test*
>  	else
>  		_test_unmount 2> /dev/null
> diff --git a/common/rc b/common/rc
> index 90749343..e8fc7e86 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1199,6 +1199,47 @@ _repair_scratch_fs()
>      esac
>  }
>  
> +_repair_test_fs()
> +{
> +	case $FSTYP in
> +	xfs)
> +		_repair_xfs_test_fs "$@" >$tmp.repair 2>&1
> +		res=$?
> +		if [ "$res" -ne 0 ]; then
> +			echo "xfs_repair returns $res; replay log?" >>$tmp.repair
> +			_test_mount
> +			res=$?
> +			if [ $res -gt 0 ]; then
> +				echo "mount returns $res; zap log?" >>$tmp.repair
> +				_xfs_repair_test_fs -L >>$tmp.repair 2>&1
> +				echo "log zap returns $?" >> $tmp.repair
> +			else
> +				umount "$TEST_DEV"
> +			fi
> +			_xfs_repair_test_fs "$@" >>$tmp.repair 2>&1
> +			res=$?
> +		fi
> +		;;
> +	*)
> +		# Let's hope fsck -y suffices...
> +		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
> +		res=$?
> +		if test "$res" -lt 4 ; then
> +			res=0
> +		fi
> +		;;
> +	esac
> +	if [ $res -ne 0 ]; then
> +		_log_err "_repair_test_fs: failed, err=$res"
> +		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
> +		cat $tmp.repair				>>$seqres.full
> +		echo "*** end fsck.$FSTYP output"	>>$seqres.full
> +
> +	fi
> +	rm -f $tmp.repair
> +	return $res
> +}
> +
>  _get_pids_by_name()
>  {
>      if [ $# -ne 1 ]
> diff --git a/common/xfs b/common/xfs
> index e8e4832c..4a130493 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -988,6 +988,18 @@ _check_xfs_test_fs()
>  	return $?
>  }
>  
> +# modeled after _scratch_xfs_repair
> +_repair_xfs_test_fs()

Dumb bikeshed: Can this be named _test_xfs_repair? :D

With that changed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +{
> +	TEST_OPTIONS=""
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
> +		TEST_OPTIONS="-l$TEST_LOGDEV"
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
> +		TEST_OPTIONS=$TEST_OPTIONS" -r$TEST_RTDEV"
> +	[ "$LARGE_TEST_DEV" = yes ] && TEST_OPTIONS=$TEST_OPTIONS" -t"
> +	$XFS_REPAIR_PROG $TEST_OPTIONS $* $TEST_DEV
> +}
> +
>  _require_xfs_test_rmapbt()
>  {
>  	_require_test
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
