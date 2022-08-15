Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B485C3F6B0
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Aug 2022 09:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiHOJUG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Aug 2022 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiHOJTz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Aug 2022 05:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C99B22505
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660555193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJNMED9Rod7DrDyRtTKKQZPt4t8qCni0KgCGodbB30U=;
        b=F138QDXHV6MwkqTfdEdvxRDVtf+MhRDMwpnkUCnBizMQd5JbPW3XRjpozDA/6ZnB1Ubyrx
        JdsbRHi0zgBsUav8YZ9Qjsr+IYVYwcqdEF73M+pji7JsIcbRAuJWVKv0d29Ur9StY7UALK
        0HdaWcRhTzYONuovOV9LVKb0oYhb50s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-gPajwD7mOkuH50Xsnug6qQ-1; Mon, 15 Aug 2022 05:19:51 -0400
X-MC-Unique: gPajwD7mOkuH50Xsnug6qQ-1
Received: by mail-pj1-f71.google.com with SMTP id f16-20020a17090a4a9000b001f234757bbbso2583282pjh.6
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 02:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uJNMED9Rod7DrDyRtTKKQZPt4t8qCni0KgCGodbB30U=;
        b=AbALCssqKXRbRLRUjZuHXvWZIaFz4pdkyjUPY/xsr8vvnx7V0BxEjST0em3jMdvrrx
         0JlNgsaIX3Oyw4LI3ThN6F6ufGxPWLZ8zxMtUMaqqlWTXny1v8VVkFHWVILjTuWvFp/r
         sER596n5Sd7DIAJCO2hrR3X4dNz6KMomBvHidcc+7uDi0XvxT0d7H6zmksWUa6qEKyup
         /nQZrQQoq2AcWjPt6VDcovPeK/jzLTEXT2GtayK7PkyFGs4QPCM56MRsyaBOWqeiEJyM
         jLaBsPCh+lIBO9CKNYl0AscHUKyKveiBH/b6YPJopvV0hF8mEuEAVZC1XlYYowr1Ux9U
         1ItA==
X-Gm-Message-State: ACgBeo37Ffeyl+i0QFjgt7sXFUsB7bAnGtK1Gad804/57OgL3G+wzcs5
        TLzzNv83/7jl1tpUAxZiAUzj+USlHQtMfp46xrCJQ9EBr/fOIMjDzx9uvwS9rmRONXekTikSNAr
        AGPeGOUtU74MPIkfCXw==
X-Received: by 2002:a17:90b:4a06:b0:1f4:d8c9:7073 with SMTP id kk6-20020a17090b4a0600b001f4d8c97073mr27357147pjb.246.1660555190771;
        Mon, 15 Aug 2022 02:19:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6BPzkCpyY1/iGESePzEZTrlq20WF3G5frZdjgGjvDFbtcdLAsVWoqm8JFtlpVn06MKZWu+Bg==
X-Received: by 2002:a17:90b:4a06:b0:1f4:d8c9:7073 with SMTP id kk6-20020a17090b4a0600b001f4d8c97073mr27357129pjb.246.1660555190451;
        Mon, 15 Aug 2022 02:19:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b0016ed5266a5csm6597773plk.170.2022.08.15.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:19:50 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:19:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] dmerror: support external log and realtime devices
Message-ID: <20220815091945.t2xmvlk6fp4iyeha@zlang-mailbox>
References: <166007886131.3276417.10030668570359997591.stgit@magnolia>
 <166007886688.3276417.391273830219043567.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166007886688.3276417.391273830219043567.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 09, 2022 at 02:01:06PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Upgrade the dmerror code to coordinate making external scratch log and
> scratch realtime devices error out along with the scratch device.  Note
> that unlike SCRATCH_DEV, we save the old rt/log devices in a separate
> variable and overwrite SCRATCH_{RT,LOG}DEV so that all the helper
> functions continue to work properly.
> 
> This is very similar to what we did for dm-flakey a while back.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/dmerror    |  159 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  tests/generic/441 |    2 -
>  tests/generic/487 |    2 -
>  3 files changed, 156 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/common/dmerror b/common/dmerror
> index 01a4c8b5..0934d220 100644
> --- a/common/dmerror
> +++ b/common/dmerror
> @@ -4,25 +4,88 @@
>  #
>  # common functions for setting up and tearing down a dmerror device
>  
> +_dmerror_setup_vars()
> +{
> +	local backing_dev="$1"
> +	local tag="$2"
> +	local target="$3"
> +
> +	test -z "$target" && target=error
> +	local blk_dev_size=$(blockdev --getsz "$backing_dev")
> +
> +	eval export "DMLINEAR_${tag}TABLE=\"0 $blk_dev_size linear $backing_dev 0\""
> +	eval export "DMERROR_${tag}TABLE=\"0 $blk_dev_size $target $backing_dev 0\""
> +}
> +
>  _dmerror_setup()
>  {
> -	local dm_backing_dev=$SCRATCH_DEV
> +	local rt_target=
> +	local log_target=
>  
> -	local blk_dev_size=`blockdev --getsz $dm_backing_dev`
> +	for arg in "$@"; do
> +		case "${arg}" in
> +		no_rt)		rt_target=linear;;
> +		no_log)		log_target=linear;;
> +		*)		echo "${arg}: Unknown _dmerror_setup arg.";;
> +		esac
> +	done
>  
> +	# Scratch device
>  	export DMERROR_DEV='/dev/mapper/error-test'
> +	_dmerror_setup_vars $SCRATCH_DEV
>  
> -	export DMLINEAR_TABLE="0 $blk_dev_size linear $dm_backing_dev 0"
> +	# Realtime device.  We reassign SCRATCH_RTDEV so that all the scratch
> +	# helpers continue to work unmodified.
> +	if [ -n "$SCRATCH_RTDEV" ]; then
> +		if [ -z "$NON_ERROR_RTDEV" ]; then
> +			# Set up the device switch
> +			local dm_backing_dev=$SCRATCH_RTDEV
> +			export NON_ERROR_RTDEV="$SCRATCH_RTDEV"
> +			SCRATCH_RTDEV='/dev/mapper/error-rttest'
> +		else
> +			# Already set up; recreate tables
> +			local dm_backing_dev="$NON_ERROR_RTDEV"
> +		fi
>  
> -	export DMERROR_TABLE="0 $blk_dev_size error $dm_backing_dev 0"
> +		_dmerror_setup_vars $dm_backing_dev RT $rt_target
> +	fi
> +
> +	# External log device.  We reassign SCRATCH_LOGDEV so that all the
> +	# scratch helpers continue to work unmodified.
> +	if [ -n "$SCRATCH_LOGDEV" ]; then
> +		if [ -z "$NON_ERROR_LOGDEV" ]; then
> +			# Set up the device switch
> +			local dm_backing_dev=$SCRATCH_LOGDEV
> +			export NON_ERROR_LOGDEV="$SCRATCH_LOGDEV"
> +			SCRATCH_LOGDEV='/dev/mapper/error-logtest'
> +		else
> +			# Already set up; recreate tables
> +			local dm_backing_dev="$NON_ERROR_LOGDEV"
> +		fi
> +
> +		_dmerror_setup_vars $dm_backing_dev LOG $log_target
> +	fi
>  }
>  
>  _dmerror_init()
>  {
> -	_dmerror_setup
> +	_dmerror_setup "$@"
> +
>  	_dmsetup_remove error-test
>  	_dmsetup_create error-test --table "$DMLINEAR_TABLE" || \
>  		_fatal "failed to create dm linear device"
> +
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		_dmsetup_remove error-rttest
> +		_dmsetup_create error-rttest --table "$DMLINEAR_RTTABLE" || \
> +			_fatal "failed to create dm linear rt device"
> +	fi
> +
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		_dmsetup_remove error-logtest
> +		_dmsetup_create error-logtest --table "$DMLINEAR_LOGTABLE" || \
> +			_fatal "failed to create dm linear log device"
> +	fi
>  }
>  
>  _dmerror_mount()
> @@ -39,11 +102,27 @@ _dmerror_unmount()
>  
>  _dmerror_cleanup()
>  {
> +	test -n "$NON_ERROR_LOGDEV" && $DMSETUP_PROG resume error-logtest &>/dev/null
> +	test -n "$NON_ERROR_RTDEV" && $DMSETUP_PROG resume error-rttest &>/dev/null
>  	$DMSETUP_PROG resume error-test > /dev/null 2>&1
> +
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +
> +	test -n "$NON_ERROR_LOGDEV" && _dmsetup_remove error-logtest
> +	test -n "$NON_ERROR_RTDEV" && _dmsetup_remove error-rttest
>  	_dmsetup_remove error-test
>  
>  	unset DMERROR_DEV DMLINEAR_TABLE DMERROR_TABLE
> +
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		SCRATCH_LOGDEV="$NON_ERROR_LOGDEV"
> +		unset NON_ERROR_LOGDEV DMLINEAR_LOGTABLE DMERROR_LOGTABLE
> +	fi
> +
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		SCRATCH_RTDEV="$NON_ERROR_RTDEV"
> +		unset NON_ERROR_RTDEV DMLINEAR_RTTABLE DMERROR_RTTABLE
> +	fi
>  }
>  
>  _dmerror_load_error_table()
> @@ -59,12 +138,47 @@ _dmerror_load_error_table()
>  		suspend_opt="$*"
>  	fi
>  
> +	# Suspend the scratch device before the log and realtime devices so
> +	# that the kernel can freeze and flush the filesystem if the caller
> +	# wanted a freeze.
>  	$DMSETUP_PROG suspend $suspend_opt error-test
>  	[ $? -ne 0 ] && _fail  "dmsetup suspend failed"
>  
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		$DMSETUP_PROG suspend $suspend_opt error-rttest
> +		[ $? -ne 0 ] && _fail "failed to suspend error-rttest"
> +	fi
> +
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		$DMSETUP_PROG suspend $suspend_opt error-logtest
> +		[ $? -ne 0 ] && _fail "failed to suspend error-logtest"
> +	fi
> +
> +	# Load new table
>  	$DMSETUP_PROG load error-test --table "$DMERROR_TABLE"
>  	load_res=$?
>  
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		$DMSETUP_PROG load error-rttest --table "$DMERROR_RTTABLE"
> +		[ $? -ne 0 ] && _fail "failed to load error table into error-rttest"
> +	fi
> +
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		$DMSETUP_PROG load error-logtest --table "$DMERROR_LOGTABLE"
> +		[ $? -ne 0 ] && _fail "failed to load error table into error-logtest"
> +	fi
> +
> +	# Resume devices in the opposite order that we suspended them.
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		$DMSETUP_PROG resume error-logtest
> +		[ $? -ne 0 ] && _fail  "failed to resume error-logtest"
> +	fi
> +
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		$DMSETUP_PROG resume error-rttest
> +		[ $? -ne 0 ] && _fail  "failed to resume error-rttest"
> +	fi
> +
>  	$DMSETUP_PROG resume error-test
>  	resume_res=$?
>  
> @@ -85,12 +199,47 @@ _dmerror_load_working_table()
>  		suspend_opt="$*"
>  	fi
>  
> +	# Suspend the scratch device before the log and realtime devices so
> +	# that the kernel can freeze and flush the filesystem if the caller
> +	# wanted a freeze.
>  	$DMSETUP_PROG suspend $suspend_opt error-test
>  	[ $? -ne 0 ] && _fail  "dmsetup suspend failed"
>  
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		$DMSETUP_PROG suspend $suspend_opt error-rttest
> +		[ $? -ne 0 ] && _fail "failed to suspend error-rttest"
> +	fi
> +
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		$DMSETUP_PROG suspend $suspend_opt error-logtest
> +		[ $? -ne 0 ] && _fail "failed to suspend error-logtest"
> +	fi
> +
> +	# Load new table
>  	$DMSETUP_PROG load error-test --table "$DMLINEAR_TABLE"
>  	load_res=$?
>  
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		$DMSETUP_PROG load error-rttest --table "$DMLINEAR_RTTABLE"
> +		[ $? -ne 0 ] && _fail "failed to load working table into error-rttest"
> +	fi
> +
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		$DMSETUP_PROG load error-logtest --table "$DMLINEAR_LOGTABLE"
> +		[ $? -ne 0 ] && _fail "failed to load working table into error-logtest"
> +	fi
> +
> +	# Resume devices in the opposite order that we suspended them.
> +	if [ -n "$NON_ERROR_LOGDEV" ]; then
> +		$DMSETUP_PROG resume error-logtest
> +		[ $? -ne 0 ] && _fail  "failed to resume error-logtest"
> +	fi
> +
> +	if [ -n "$NON_ERROR_RTDEV" ]; then
> +		$DMSETUP_PROG resume error-rttest
> +		[ $? -ne 0 ] && _fail  "failed to resume error-rttest"
> +	fi
> +
>  	$DMSETUP_PROG resume error-test
>  	resume_res=$?
>  
> diff --git a/tests/generic/441 b/tests/generic/441
> index 0ec751da..85f29a3a 100755
> --- a/tests/generic/441
> +++ b/tests/generic/441
> @@ -52,7 +52,7 @@ unset SCRATCH_RTDEV
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> -_dmerror_init
> +_dmerror_init no_log
>  _dmerror_mount
>  
>  _require_fs_space $SCRATCH_MNT 65536
> diff --git a/tests/generic/487 b/tests/generic/487
> index fda8828d..3c9b2233 100755
> --- a/tests/generic/487
> +++ b/tests/generic/487
> @@ -45,7 +45,7 @@ unset SCRATCH_RTDEV
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> -_dmerror_init
> +_dmerror_init no_log
>  _dmerror_mount
>  
>  datalen=65536
> 

