Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80388C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiESSzZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiESSzX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 14:55:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852263397
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 11:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB32FB82695
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A48C385AA;
        Thu, 19 May 2022 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652986519;
        bh=tfkn0BFMd0PWPq9kEx8XPngR+6tPgPvkPRKVFSys8nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQ+5flvX6UAm73zRcDAl/fGvQ7AjYSI0iN59nqawnMQ+WnCrR78QPjQjdRUUMi82U
         leB9xX6+hENhpnuCeZ7Dh1MpupHWozzqiTSQfl2Qd/yeFldvc91FVLikafX4ktUykZ
         lqmj8W04qHbi4jaiwz5YCvlx/9UTaxi6WhOFITE2UPt2uy+CRUdyd65S04yutu4FG3
         Flzbk0FBoW/79Xrk/UhgN1vjCVPdlW+PzQBagU+eyeycSEXHccbwsmK0h8PFCIll8c
         oGdWnINrF3zxZ04XyelsjVmTuwSzLu3vG0AhsNoJ5C+KanVKW9qTJEHknQBXGB1REO
         iksS6TMms65iw==
Date:   Thu, 19 May 2022 11:55:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs/148: make test debuggable
Message-ID: <YoaSlssEeLnj3NU6@magnolia>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070111.1381936-7-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:01:05PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Don't clean up image files - leave them laying around on the test
> device so that when the test fails there's a corpse left behind to
> post-mortem....
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

I guess I missed this one last time
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/148 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/148 b/tests/xfs/148
> index 9427aff0..8d50a642 100755
> --- a/tests/xfs/148
> +++ b/tests/xfs/148
> @@ -16,7 +16,7 @@ _cleanup()
>  	cd /
>  	$UMOUNT_PROG $mntpt > /dev/null 2>&1
>  	test -n "$loopdev" && _destroy_loop_device $loopdev > /dev/null 2>&1
> -	rm -r -f $imgfile $mntpt $tmp.*
> +	rm -r -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -38,6 +38,8 @@ nullstr="too_many_beans"
>  slashstr="are_bad_for_you"
>  test_names=("something" "$nullstr" "$slashstr" "another")
>  
> +rm -f $imgfile $imgfile.old
> +
>  # Format image file w/o crcs so we can sed the image file
>  $XFS_IO_PROG -f -c 'truncate 40m' $imgfile
>  loopdev=$(_create_loop_device $imgfile)
> @@ -91,7 +93,6 @@ sed -b \
>  	-i $imgfile
>  test "$(md5sum < $imgfile)" != "$(md5sum < $imgfile.old)" ||
>  	_fail "sed failed to change the image file?"
> -rm -f $imgfile.old
>  loopdev=$(_create_loop_device $imgfile)
>  _mount $loopdev $mntpt
>  
> -- 
> 2.35.1
> 
