Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1BEC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 11:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbiFTLRR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiFTLRP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 07:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40DEDC13
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655723833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A01ZTwnVXJkIE3EdxY2YLbrRDu+kOTZz0NfqRkbmbBc=;
        b=bB5FW3QvBRdvVjGnrPxAwSWNDW3B/4d3byYQyfEvDvgA8+HhG7B8hY9Y/QcLtn99x/mEmG
        6Oo7Lzm5cIrWfspoZJTq4uXFthsQo4dIWySlUIwXjeuPKtuNuGFLm/BHX7RPfXww5lOLjk
        6IqRSG7cbNPGGfNo0Z6CnWo6pguwQZA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-u5Yh9yugNkerQqzk-b-NXw-1; Mon, 20 Jun 2022 07:17:12 -0400
X-MC-Unique: u5Yh9yugNkerQqzk-b-NXw-1
Received: by mail-qv1-f70.google.com with SMTP id b18-20020a0ccd12000000b004703d1b04e8so4142766qvm.13
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 04:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A01ZTwnVXJkIE3EdxY2YLbrRDu+kOTZz0NfqRkbmbBc=;
        b=tYbFycybEtjrENBzvGlgP+3upwpDN4QQj1Ayv/iMnArUcpTgAmSqrJh4zlCzMD8URl
         mWesZqd2nV2YWKvnDo7hU9w2HTkMW9bMvEXEEwR2HRrCVOG9zoANBAIMjymXUL9J1eMB
         fG76cdHrfrBnhvnTfU8yfglx9Izz26hXP6PeVQEIVX2PQA5XB44BAJGBuSKWK5PS+OlM
         lCvyb05npr3wDscKJPjh7Lo2erECe6ZDeqC415IRE8UpzKTE101Ati3TIXIsnSZQi6ik
         axEz1xp7RmvS/UZRGW8dbPlKDPNWV8kWszlUk0qSDZI3rnGeS8NmDMdsLYsMwAr3lUDv
         z1ww==
X-Gm-Message-State: AJIora/yQj3z/Ev2tesUdgmSlRkCgPIcXxm6yBIPMRfP4fdoggS6H7AC
        v5e4LL2nEXPYdrC5RORojwRGgmXjOsDrK7EdMcSfB6n/yiopkYFncebxd5VjMsjaUxNGe3dC9y/
        WUulOKYU7uq7umrpcHQ==
X-Received: by 2002:a37:ab02:0:b0:6a6:b111:61a8 with SMTP id u2-20020a37ab02000000b006a6b11161a8mr16014724qke.260.1655723831796;
        Mon, 20 Jun 2022 04:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVB9PW3Ky+WzrodGlGCFi3PGmk/drfJ/8UVu4A3OwXnLHjCQPTYO8hV9gydVvPC6e9cV7P9w==
X-Received: by 2002:a37:ab02:0:b0:6a6:b111:61a8 with SMTP id u2-20020a37ab02000000b006a6b11161a8mr16014707qke.260.1655723831495;
        Mon, 20 Jun 2022 04:17:11 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r3-20020ae9d603000000b0069c72b41b59sm11914278qkk.2.2022.06.20.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:17:10 -0700 (PDT)
Date:   Mon, 20 Jun 2022 19:17:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] fstests: make sure to unfreeze test and scratch
 mounts
Message-ID: <20220620111705.zmujyr3v2f5uw326@zlang-mailbox>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619134657.1846292-3-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> Almost all of the tests that _require_freeze() fail to unfreeze
> scratch mount in case the test is interrupted while fs is frozen.
> 
> Move the handling of unfreeze to generic check code.
> For now, tests only freeze scratch fs, but to be more robust, unfreeze
> both test and scratch fs following a call to _require_freeze().
> 
> Tests could still hang if thier private _cleanup() routine tries
> to modify the frozen fs or wait for a blocked process. Fix the
> _cleanup() routine of xfs/011 to avoid that.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  check             | 14 ++++++++------
>  common/rc         |  5 +++--
>  tests/generic/390 |  2 --
>  tests/xfs/011     |  2 --
>  tests/xfs/517     |  1 -
>  5 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index de11b37e..d6ee71aa 100755
> --- a/check
> +++ b/check
> @@ -527,17 +527,21 @@ _check_filesystems()
>  {
>  	local ret=0
>  
> +	# Make sure both test and scratch are unfrozen post _require_freeze()
> +	if [ -f ${RESULT_DIR}/require_freeze ]; then
> +		xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> +		xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> +	fi

Hi Amir,

I'm wondering why not let each freeze related test cases take care of "unfreeze"
by itself? If a case freeze a filesystem which isn't on TEST_DEV or SCRATCH_DEV
(e.g. a loop device base on a file in $TEST_DIR), or other situations, then the
case still can call _require_freeze, but "unfreeze TEST_DIR or SCRATCH_MNT" can't
help.

Thanks,
Zorro

>  	if [ -f ${RESULT_DIR}/require_test ]; then
>  		_check_test_fs || ret=1
> -		rm -f ${RESULT_DIR}/require_test*
>  	else
>  		_test_unmount 2> /dev/null
>  	fi
>  	if [ -f ${RESULT_DIR}/require_scratch ]; then
>  		_check_scratch_fs || ret=1
> -		rm -f ${RESULT_DIR}/require_scratch*
>  	fi
>  	_scratch_unmount 2> /dev/null
> +	rm -f ${RESULT_DIR}/require_*
>  	return $ret
>  }
>  
> @@ -783,8 +787,7 @@ function run_section()
>  		seqres="$REPORT_DIR/$seqnum"
>  
>  		mkdir -p $RESULT_DIR
> -		rm -f ${RESULT_DIR}/require_scratch*
> -		rm -f ${RESULT_DIR}/require_test*
> +		rm -f ${RESULT_DIR}/require_*
>  		echo -n "$seqnum"
>  
>  		if $showme; then
> @@ -882,8 +885,7 @@ function run_section()
>  			_dump_err_cont "[failed, exit status $sts]"
>  			_test_unmount 2> /dev/null
>  			_scratch_unmount 2> /dev/null
> -			rm -f ${RESULT_DIR}/require_test*
> -			rm -f ${RESULT_DIR}/require_scratch*
> +			rm -f ${RESULT_DIR}/require_*
>  			err=true
>  		else
>  			# The test apparently passed, so check for corruption
> diff --git a/common/rc b/common/rc
> index 3c072c16..b87dfe05 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1540,8 +1540,7 @@ _notrun()
>  {
>      echo "$*" > $seqres.notrun
>      echo "$seq not run: $*"
> -    rm -f ${RESULT_DIR}/require_test*
> -    rm -f ${RESULT_DIR}/require_scratch*
> +    rm -f ${RESULT_DIR}/require_*
>  
>      status=0
>      exit
> @@ -3648,6 +3647,8 @@ _require_freeze()
>  	local result=$?
>  	xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
>  	[ $result -eq 0 ] || _notrun "$FSTYP does not support freezing"
> +	# Make sure both test and scratch are unfrozen at the end of the test
> +	touch ${RESULT_DIR}/require_freeze
>  }
>  
>  # Does NFS export work on this fs?
> diff --git a/tests/generic/390 b/tests/generic/390
> index 20c66e22..0f2b86fa 100755
> --- a/tests/generic/390
> +++ b/tests/generic/390
> @@ -14,8 +14,6 @@ _begin_fstest auto freeze stress
>  _cleanup()
>  {
>  	cd /
> -	# Make sure $SCRATCH_MNT is unfreezed
> -	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	rm -f $tmp.*
>  }
>  
> diff --git a/tests/xfs/011 b/tests/xfs/011
> index d6e9099e..351a574e 100755
> --- a/tests/xfs/011
> +++ b/tests/xfs/011
> @@ -17,9 +17,7 @@ _begin_fstest auto freeze log metadata quick
>  _cleanup()
>  {
>  	$KILLALL_PROG -9 fsstress 2>/dev/null
> -	wait
>  	cd /
> -	_scratch_unmount 2>/dev/null
>  	rm -f $tmp.*
>  }
>  
> diff --git a/tests/xfs/517 b/tests/xfs/517
> index f7f9a8a2..961668e3 100755
> --- a/tests/xfs/517
> +++ b/tests/xfs/517
> @@ -15,7 +15,6 @@ _register_cleanup "_cleanup" BUS
>  _cleanup()
>  {
>  	cd /
> -	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT > /dev/null 2>&1
>  	rm -rf $tmp.*
>  }
>  
> -- 
> 2.25.1
> 

