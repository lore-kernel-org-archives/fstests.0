Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3620DD51
	for <fstests@vger.kernel.org>; Wed,  4 Dec 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335054; cv=none; b=UfQBFVzYL2/A5T6t3EFC/6cf11vULLHkTIiI+N97qdxRVPec1HuIBNfzSpjq7ASdFVmq0y1scVr5bNIgvIZ0Y1tBWmsrdddWLfJT1u1UpdewbuF9dIwxTucuHmvXq0BU9p12+OdPyzY0ckqZNPYxZnRjRPO984AH3t6neoXjnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335054; c=relaxed/simple;
	bh=wfRPXFKmSKrSo2E5u8PfArYlu5ngP929rbppebyIidw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkroadcCbNmQLJiAgon8+XeQGiva2x8HkHGKegcZax08IsXFlxQuNYCPyKhjAhkXTvT7N3W/W/EvcaUbU8N2l8nop8FwMALtcz8++BLwzLg5xEWXGNYxraBGCQs0R8OUd655FI/mL/z9n18NSZM4IdBx7PF9x2cVhNH3gZ54ssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKr6/zmZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKr6/zmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733335046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tdr3IYRzEcZxdjvqhvAYFLc8pCkvs1NojdiP2J7Eqo=;
	b=dKr6/zmZNywTBoXyp++93GM8GUMjHZpCHt3K+ieMqT1t6pGZKV6PO2HdCB6laGPL7zm0/6
	fTAgba7FMpy+i1duBuvAp55gkaWPz5hjJFnXGfFB26GborE8d1gK4Ta94aLwaENasF8GAM
	8i1XGAFC3JuHHIvou/3eeDxPn9Y09PY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-0jprUjbiNn-bFJeNX48yPg-1; Wed, 04 Dec 2024 12:57:24 -0500
X-MC-Unique: 0jprUjbiNn-bFJeNX48yPg-1
X-Mimecast-MFC-AGG-ID: 0jprUjbiNn-bFJeNX48yPg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2152c1dbcabso920725ad.0
        for <fstests@vger.kernel.org>; Wed, 04 Dec 2024 09:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335043; x=1733939843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tdr3IYRzEcZxdjvqhvAYFLc8pCkvs1NojdiP2J7Eqo=;
        b=rlc9x9eGFwauB5ktCdfVw3sXhulBRS1BeOhkDzXeov8wpdvAmhF38vfhjEcXoATh4M
         zJ0tbt1uXG2zhUrZQLfRoq8w+lob4EYqv0kQufOO/SmEvPcEdJcDtm32amMFR1sjMNhK
         KM8HRFy8qY4xnCP3QMueOzYLtH2dFj8/lktSul1PrGzJWOs7tkfV0AvRQS+KlnZtBwp+
         ru8hEME9IKoonOrU0MYn9/xbU2nwpZYGBXHhCRMeWoXYLrA9gtS0KR2G6xHbPP9ZdVmL
         LKkxWRuA1Lc6acN4cOhJasdm4Zbwe9YJ1r3s6mUGK0cFOkO+/qyL0w/YA2tRAZrICYj/
         yqaA==
X-Gm-Message-State: AOJu0YwELrPc7JJlTXNgwIr+lrjp818PI9ZOCFnlOB7wi/UVkMmkFQ67
	n3sAd2ExiunzIR+AzUTRZOSk/jSoqwV6MKFXdR/qNCoy2PHynZ8rSjFkJJNa3uEY0Ucg5nxTFJ6
	BMvPWEG4LKYhLTcAwXxAao5WwcrxIgnCuO0R2mCaf2QNA9Uch8mZNzV7JNvVuLmVAbw==
X-Gm-Gg: ASbGncu466mvm4TMhevMSGzF/EAqgQPiZjRjvcpFaj6Aa/5OLwcT3QlK9FDCnvf4/MX
	HxHXZ91cGYU2109ryx5RNY9sxGf6YS6zoshXLwcdjxqYtTomrReuX6RTmiPJIP/+B2iyol8k20k
	V++XkLHm85JxktKsEGJtAL7wjLAzhjTPMZM/Q6E+ig+wW3M2+QnmkwRDEg9EWhGUWbpzO68Ncta
	CycPssvQ8EVyHOV3sba8VHmKjcZR0cajEOcHXFkDGvdianl0MZq9OsBFnkyBKEV955bLAsptKaa
	WzO4O7IB9H8KgDc=
X-Received: by 2002:a17:902:f542:b0:215:9eac:1857 with SMTP id d9443c01a7336-215f3c56af7mr4075285ad.5.1733335041534;
        Wed, 04 Dec 2024 09:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExJo03nlTNHWORPUTko/sH4xh4UyeB6j1vhZDfPTw77nU2VOB3GD6qwbFXsTnrscjAdA2rgw==
X-Received: by 2002:a17:902:f542:b0:215:9eac:1857 with SMTP id d9443c01a7336-215f3c56af7mr4074555ad.5.1733335039957;
        Wed, 04 Dec 2024 09:57:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215e1f1e487sm12053015ad.141.2024.12.04.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:57:19 -0800 (PST)
Date: Thu, 5 Dec 2024 01:57:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <20241204175715.56pvxgzeb243yodz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-3-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127045403.3665299-3-david@fromorbit.com>

On Wed, Nov 27, 2024 at 03:51:32PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Lots of tests run fsstress in the background and then have to kill
> it and/or provide special cleanup functions to kill the background
> fsstress processes. They typically use $KILLALL_PROG for this.
> 
> Use of killall is problematic for running multiple tests in parallel
> in that one test can kill other tests' processes.  However, because
> fsstress itself forks and runs children, there are very few avenues
> for shell scripts to ensure all the fsstress processes actually die.
> 
> With bash, it is especially nasty, because sending SIGTERM will
> result in bash outputting error messages ("Killed: ..." that will
> cause golden output mismatches and hence test failures. Hence we
> also need to be able to tell the main fstress process to die without
> triggering these messages.
> 
> To avoid the process tracking problems, we change to use pkill
> rather than killall (more options for process selection) and we
> stop using the $here/ltp/fsstress binary. Instead, we copy the
> $here/ltp/fsstress to $TEST_DIR/$seq.fsstress so that the test has
> a unique fsstress binary name. This allows the pkill filter to
> select just the fsstress processes the test has run. The fsstress
> binary name is held in _FSSTRESS_NAME, and the program to run is
> _FSSTRESS_PROG.
> 
> We also track the primary fsstress process ID, and store that in
> _FSSTRESS_PID. We do this so that we have a PID to wait against so
> that we don't return before the fsstress processes are dead. To this
> end, we add a SIGPIPE handler to the primary process so that it
> dying doesn't trigger bash 'killed' message output. We can
> send 'pkill -PIPE $_FSSTRESS_NAME' to all the fsstress processes and
> the primary process will then enter the "wait for children to die"
> processing loop before it exits. In this way, we can wait for the
> primary fsstress process and when it exits we know that all it's
> children have also finished and gone away. This makes killing
> fsstress invocations reliable and noise free.
> 
> This is accomplished by the helpers added to common/rc:
> 
> 	_run_fsstress
> 	_run_fsstress_bg
> 	_wait_for_fsstress
> 	_kill_fstress
> 
> This also means that all fsstress invocations now obey
> FSSTRESS_AVOID environment restrictions, many of which didn't.
> 
> We add a call to _kill_fstress into the generic _cleanup() function.
> This means that tests using fsstress don't need to add a special
> local _cleanup function just to call _kill_fsstress() so that
> background fsstress processes are killed when the user interrupts
> the tests with ctrl-c.
> 
> Further, killall in the _cleanup() function is often used to attempt
> to expedite killing of foreground execution fsstress processes. This
> doesn't actually work because of the way bash processes interupt
> signals. That is, it waits for the currently executing process to
> finish execution, then runs the trap function. Hence a foreground
> fsstress won't ever be interrupted by ctrl-c. By implementing
> _run_fsstress() as a background process and a wait call, the wait()
> call is interrupted by the signal and the cleanup trap is run
> immediately. Hence the fsstress processes are killed immediately and
> the test exits cleanly almost immediately.
> 
> The result of all this is common, clean handling of fsstress
> execution and termination. There are a few exceptions for special
> cases, but the vast majority of tests that run fsstress use the
> above four wrapper functions exclusively.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

[snip]

> +# Common execution handling for fsstress invocation.
> +#
> +# We need per-test fsstress binaries because of the way fsstress forks and
> +# tests run it in the background and/or nest it. Trying to kill fsstress
> +# tasks is unreliable because killing parent fsstress task does not guarantee
> +# that the children get killed. Hence the historic use of killall for stopping
> +# execution.
> +#
> +# However, we can't just kill all fsstress binaries as multiple tests might be
> +# running fsstress at the same time. Hence copy the fsstress binary to a test
> +# specific binary on the test device and use pkill to select that only that
> +# task name to kill.
> +#
> +# If tasks want to start fsstress themselves (e.g. under a different uid) then
> +# they can set up _FSSTRESS_BIN and record _FSSTRESS_PID themselves. Then if the
> +# test is killed then it will get cleaned up automatically.
> +
> +_FSSTRESS_BIN="$seq.fsstress"
> +_FSSTRESS_PROG="$TEST_DIR/$seq.fsstress"

Hi Dave,

I'm wondering if the "$seq.fsstress" can be unique name? For example, if generic/561,
xfs/561, btrfs/561, ext4/561 run fsstress in parallel, won't they have same
"561.fsstress", then "pkill -PIPE $_FSSTRESS_BIN" kills all these cases' fsstress
processes?

Thanks,
Zorro

> +_FSSTRESS_PID=""
> +_wait_for_fsstress()
> +{
> +	local ret=0
> +
> +	if [ -n "$_FSSTRESS_PID" ]; then
> +		wait $_FSSTRESS_PID >> $seqres.full 2>&1
> +		ret=$?
> +		unset _FSSTRESS_PID
> +	fi
> +	rm -f $_FSSTRESS_PROG
> +	return $ret
> +}
> +
> +# Standard fsstress cleanup function. Individual tests can override this.
> +_kill_fsstress()
> +{
> +	if [ -n "$_FSSTRESS_PID" ]; then
> +		# use SIGPIPE to avoid "Killed" messages from bash
> +		echo "killing $_FSSTRESS_BIN" >> $seqres.full
> +		pkill -PIPE $_FSSTRESS_BIN >> $seqres.full 2>&1
> +		_wait_for_fsstress
> +		return $?
> +	fi
> +}
> +
> +_run_fsstress_bg()
> +{
> +	cp -f $FSSTRESS_PROG $_FSSTRESS_PROG
> +	$_FSSTRESS_PROG $FSSTRESS_AVOID $* >> $seqres.full 2>&1 &
> +	_FSSTRESS_PID=$!
> +}
> +
> +_run_fsstress()
> +{
> +	_run_fsstress_bg $*
> +	_wait_for_fsstress
> +	return $?
> +}
> +
>  _wallclock()
>  {
>      date "+%s"
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 3d248ee25..a6840f28c 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -444,6 +444,7 @@ void sg_handler(int signum)
>  {
>  	switch (signum) {
>  	case SIGTERM:
> +	case SIGPIPE:
>  		should_stop = 1;
>  		break;
>  	case SIGBUS:
> @@ -469,6 +470,9 @@ keep_looping(int i, int loops)
>  {
>  	int ret;
>  
> +	if (should_stop)
> +		return false;
> +
>  	if (deadline.tv_nsec) {
>  		struct timespec now;
>  
> @@ -732,14 +736,17 @@ int main(int argc, char **argv)
>  		perror("sigaction failed");
>  		exit(1);
>  	}
> +	if (sigaction(SIGPIPE, &action, 0)) {
> +		perror("sigaction failed");
> +		exit(1);
> +	}
>  
>  	for (i = 0; i < nproc; i++) {
>  		if (fork() == 0) {
>  			sigemptyset(&action.sa_mask);
> -			action.sa_handler = SIG_DFL;
> -			if (sigaction(SIGTERM, &action, 0))
> -				return 1;
>  			action.sa_handler = sg_handler;
> +			if (sigaction(SIGTERM, &action, 0))
> +				return 1;
>  			if (sigaction(SIGBUS, &action, 0))
>  				return 1;
>  #ifdef HAVE_SYS_PRCTL_H
> @@ -1196,6 +1203,9 @@ keep_running(opnum_t opno, opnum_t operations)
>  {
>  	int ret;
>  
> +	if (should_stop)
> +		return false;
> +
>  	if (deadline.tv_nsec) {
>  		struct timespec now;
>  
> diff --git a/tests/btrfs/004 b/tests/btrfs/004
> index 5a2ce9931..06eedde22 100755
> --- a/tests/btrfs/004
> +++ b/tests/btrfs/004
> @@ -17,6 +17,7 @@ noise_pid=0
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
>  	rm $tmp.running
>  	wait
>  	rm -f $tmp.*
> @@ -159,8 +160,7 @@ workout()
>  	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
>  	_scratch_mount
>  	# -w ensures that the only ops are ones which cause write I/O
> -	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p $procs -n 2000 \
> -		$FSSTRESS_AVOID
> +	_run_fsstress -d $SCRATCH_MNT -w -p $procs -n 2000
>  
>  	_btrfs subvolume snapshot $SCRATCH_MNT \
>  		$SCRATCH_MNT/$snap_name
> @@ -170,15 +170,14 @@ workout()
>  
>  	# make some noise but ensure we're not touching existing data
>  	# extents.
> -	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -p $procs -n 4000 \
> +	_run_fsstress -d $SCRATCH_MNT -p $procs -n 4000 \
>  		-z -f chown=3 -f link=1 -f mkdir=2 -f mknod=2 \
>  		-f rename=2 -f setxattr=1 -f symlink=2
>  
>  	clean_dir="$SCRATCH_MNT/next"
>  	mkdir $clean_dir
>  	# now make more files to get a higher tree
> -	run_check $FSSTRESS_PROG -d $clean_dir -w -p $procs -n 2000 \
> -		$FSSTRESS_AVOID
> +	_run_fsstress -d $clean_dir -w -p $procs -n 2000
>  	run_check _scratch_unmount
>  	_scratch_mount "-o atime"
>  
> @@ -186,7 +185,7 @@ workout()
>  		# make background noise while backrefs are being walked
>  		while [ -f "$tmp.running" ]; do
>  			echo background fsstress >>$seqres.full
> -			run_check $FSSTRESS_PROG -d $SCRATCH_MNT/bgnoise -n 999
> +			_run_fsstress -d $SCRATCH_MNT/bgnoise -n 999
>  			echo background rm >>$seqres.full
>  			rm -rf $SCRATCH_MNT/bgnoise/
>  		done &
> diff --git a/tests/btrfs/007 b/tests/btrfs/007
> index a7eb62162..d9cc32750 100755
> --- a/tests/btrfs/007
> +++ b/tests/btrfs/007
> @@ -18,6 +18,7 @@ _begin_fstest auto quick rw metadata send seek
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
>  	cd /
>  	rm -f $tmp.*
>  	rm -fr $send_files_dir
> @@ -45,7 +46,7 @@ workout()
>  	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
>  	_scratch_mount "-o noatime"
>  
> -	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n $ops $FSSTRESS_AVOID -x \
> +	_run_fsstress -d $SCRATCH_MNT -n $ops -x \
>  		"$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"
>  
>  	_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index 5811b3b33..f41d7e4eb 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -45,7 +45,7 @@ mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>  
>  echo "populating the initial ext fs:" >> $seqres.full
>  mkdir "$SCRATCH_MNT/$BASENAME"
> -$FSSTRESS_PROG -w -d "$SCRATCH_MNT/$BASENAME" -n 20 -p 500 >> $seqres.full
> +_run_fsstress -w -d "$SCRATCH_MNT/$BASENAME" -n 20 -p 500
>  
>  # Create the checksum to verify later.
>  $FSSUM_PROG -A -f -w $tmp.original "$SCRATCH_MNT/$BASENAME"
> @@ -74,7 +74,7 @@ umount $SCRATCH_MNT/mnt
>  
>  echo "Generating new data on the converted btrfs" >> $seqres.full
>  mkdir -p $SCRATCH_MNT/new 
> -$FSSTRESS_PROG -w -d "$SCRATCH_MNT/new" -n 20 -p 500 >> $seqres.full
> +_run_fsstress -w -d "$SCRATCH_MNT/new" -n 20 -p 500
>  
>  _scratch_unmount
>  
> diff --git a/tests/btrfs/028 b/tests/btrfs/028
> index f64fc831d..85e42f31e 100755
> --- a/tests/btrfs/028
> +++ b/tests/btrfs/028
> @@ -32,8 +32,7 @@ args=`_scale_fsstress_args -z \
>  	-f fsync=10 -n 100000 -p 2 \
>  	-d $SCRATCH_MNT/stress_dir`
>  echo "Run fsstress $args" >>$seqres.full
> -$FSSTRESS_PROG $args >>$seqres.full &
> -fsstress_pid=$!
> +_run_fsstress_bg $args
>  
>  echo "Start balance" >>$seqres.full
>  _btrfs_stress_balance -d $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -41,8 +40,7 @@ balance_pid=$!
>  
>  # 30s is enough to trigger bug
>  sleep $((30*$TIME_FACTOR))
> -kill $fsstress_pid &> /dev/null
> -wait $fsstress_pid &> /dev/null
> +_kill_fsstress
>  _btrfs_kill_stress_balance_pid $balance_pid
>  
>  # The qgroups accounting will be checked by 'btrfs check' (fsck) after the
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> index 19eec7851..5c09942ee 100755
> --- a/tests/btrfs/049
> +++ b/tests/btrfs/049
> @@ -39,7 +39,7 @@ args=`_scale_fsstress_args -z \
>  	-f write=10 -f creat=10 \
>  	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
>  echo "Run fsstress $args" >>$seqres.full
> -$FSSTRESS_PROG $args >>$seqres.full
> +_run_fsstress $args >>$seqres.full
>  
>  # Start and pause balance to ensure it will be restored on remount
>  echo "Start balance" >>$seqres.full
> @@ -68,7 +68,7 @@ $BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
>  [ $? -eq 0 ] || _fail "Couldn't resume balance after device add"
>  
>  # Add more files so that new balance won't fish immediately
> -$FSSTRESS_PROG $args >/dev/null 2>&1
> +_run_fsstress $args
>  
>  # Now pause->resume balance. This ensures balance paused is properly set in
>  # the kernel and won't trigger an assertion failure.
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index 6c3999463..1e871dd1b 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -19,12 +19,12 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # -w ensures that the only ops are ones which cause write I/O
> -run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 $FSSTRESS_AVOID
> +_run_fsstress -d $SCRATCH_MNT -w -p 5 -n 1000
>  
>  _btrfs subvolume snapshot $SCRATCH_MNT \
>  	$SCRATCH_MNT/snap1
>  
> -run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 $FSSTRESS_AVOID
> +_run_fsstress -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000
>  
>  _btrfs quota enable $SCRATCH_MNT
>  _btrfs quota rescan -w $SCRATCH_MNT
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index 75c10bd23..21f15ec89 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -21,10 +21,7 @@ _cleanup()
>  	if [ ! -z "$balance_pid" ]; then
>  		_btrfs_kill_stress_balance_pid $balance_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -51,10 +48,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start balance worker: " >>$seqres.full
>  	_btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -67,9 +63,7 @@ run_test()
>  	echo "$subvol_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> -
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
>  	unset subvol_pid
>  	_btrfs_kill_stress_balance_pid $balance_pid
> diff --git a/tests/btrfs/061 b/tests/btrfs/061
> index 2b3b76a7f..5a2bd7090 100755
> --- a/tests/btrfs/061
> +++ b/tests/btrfs/061
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$scrub_pid" ]; then
>  		_btrfs_kill_stress_scrub_pid $scrub_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -47,10 +44,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start balance worker: " >>$seqres.full
>  	_btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -63,8 +59,7 @@ run_test()
>  	echo "$scrub_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_balance_pid $balance_pid
>  	unset balance_pid
>  	_btrfs_kill_stress_scrub_pid $scrub_pid
> diff --git a/tests/btrfs/062 b/tests/btrfs/062
> index 4ab7ca534..a25d6d117 100755
> --- a/tests/btrfs/062
> +++ b/tests/btrfs/062
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$defrag_pid" ]; then
>  		_btrfs_kill_stress_defrag_pid $defrag_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -48,10 +45,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start balance worker: " >>$seqres.full
>  	_btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -64,8 +60,7 @@ run_test()
>  	echo "$defrag_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_balance_pid $balance_pid
>  	unset balance_pid
>  	_btrfs_kill_stress_defrag_pid $defrag_pid
> diff --git a/tests/btrfs/063 b/tests/btrfs/063
> index ea4275d29..7d51ff554 100755
> --- a/tests/btrfs/063
> +++ b/tests/btrfs/063
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$remount_pid" ]; then
>  		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -47,10 +44,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start balance worker: " >>$seqres.full
>  	_btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -63,8 +59,7 @@ run_test()
>  	echo "$remount_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_balance_pid $balance_pid
>  	unset balance_pid
>  	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> diff --git a/tests/btrfs/064 b/tests/btrfs/064
> index a8aa62513..3b98f327e 100755
> --- a/tests/btrfs/064
> +++ b/tests/btrfs/064
> @@ -22,10 +22,7 @@ _cleanup()
>  	if [ ! -z "$replace_pid" ]; then
>  		_btrfs_kill_stress_replace_pid $replace_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -57,10 +54,9 @@ run_test()
>  	_scratch_mount >>$seqres.full 2>&1
>  	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	# Start both balance and replace in the background.
>  	# Either balance or replace shall run, the other fails.
> @@ -75,8 +71,7 @@ run_test()
>  	echo "$replace_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_balance_pid $balance_pid
>  	unset balance_pid
>  	_btrfs_kill_stress_replace_pid $replace_pid
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index b87c66d6e..f0c9ffb04 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -21,10 +21,7 @@ _cleanup()
>  	if [ ! -z "$replace_pid" ]; then
>  		_btrfs_kill_stress_replace_pid $replace_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -59,10 +56,9 @@ run_test()
>  	_scratch_mount >>$seqres.full 2>&1
>  	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start subvolume worker: " >>$seqres.full
>  	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
> @@ -75,9 +71,7 @@ run_test()
>  	echo "$replace_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> -
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
>  	unset subvol_pid
>  	_btrfs_kill_stress_replace_pid $replace_pid
> diff --git a/tests/btrfs/066 b/tests/btrfs/066
> index cc7cd9b72..e3a083b94 100755
> --- a/tests/btrfs/066
> +++ b/tests/btrfs/066
> @@ -21,10 +21,7 @@ _cleanup()
>  	if [ ! -z "$scrub_pid" ]; then
>  		_btrfs_kill_stress_scrub_pid $scrub_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -51,10 +48,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start subvolume worker: " >>$seqres.full
>  	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
> @@ -67,9 +63,7 @@ run_test()
>  	echo "$scrub_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> -
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
>  	unset subvol_pid
>  	_btrfs_kill_stress_scrub_pid $scrub_pid
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index 0b4730500..768993116 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -21,10 +21,7 @@ _cleanup()
>  	if [ ! -z "$defrag_pid" ]; then
>  		_btrfs_kill_stress_defrag_pid $defrag_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -52,10 +49,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start subvolume worker: " >>$seqres.full
>  	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
> @@ -68,9 +64,7 @@ run_test()
>  	echo "$defrag_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> -
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
>  	unset subvol_pid
>  	_btrfs_kill_stress_defrag_pid $defrag_pid
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index 83e932e84..3d221259f 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -22,10 +22,7 @@ _cleanup()
>  	if [ ! -z "$remount_pid" ]; then
>  		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -52,10 +49,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start subvolume worker: " >>$seqres.full
>  	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
> @@ -68,9 +64,7 @@ run_test()
>  	echo "$remount_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> -
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
>  	unset subvol_pid
>  	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> diff --git a/tests/btrfs/069 b/tests/btrfs/069
> index 510551760..7954e80a8 100755
> --- a/tests/btrfs/069
> +++ b/tests/btrfs/069
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$scrub_pid" ]; then
>  		_btrfs_kill_stress_scrub_pid $scrub_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -55,10 +52,9 @@ run_test()
>  	_scratch_mount >>$seqres.full 2>&1
>  	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start replace worker: " >>$seqres.full
>  	_btrfs_stress_replace $SCRATCH_MNT >>$seqres.full 2>&1 &
> @@ -71,8 +67,7 @@ run_test()
>  	echo "$scrub_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_scrub_pid $scrub_pid
>  	unset scrub_pid
>  	_btrfs_kill_stress_replace_pid $replace_pid
> diff --git a/tests/btrfs/070 b/tests/btrfs/070
> index f2e9dfcb1..c18380034 100755
> --- a/tests/btrfs/070
> +++ b/tests/btrfs/070
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$defrag_pid" ]; then
>  		_btrfs_kill_stress_defrag_pid $defrag_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -56,10 +53,9 @@ run_test()
>  	_scratch_mount >>$seqres.full 2>&1
>  	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start replace worker: " >>$seqres.full
>  	_btrfs_stress_replace $SCRATCH_MNT >>$seqres.full 2>&1 &
> @@ -72,8 +68,7 @@ run_test()
>  	echo "$defrag_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_replace_pid $replace_pid
>  	unset replace_pid
>  	_btrfs_kill_stress_defrag_pid $defrag_pid
> diff --git a/tests/btrfs/071 b/tests/btrfs/071
> index 5c65bcfe0..5c2b725b0 100755
> --- a/tests/btrfs/071
> +++ b/tests/btrfs/071
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$remount_pid" ]; then
>  		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -55,10 +52,9 @@ run_test()
>  	_scratch_mount >>$seqres.full 2>&1
>  	SCRATCH_DEV_POOL=$saved_scratch_dev_pool
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start replace worker: " >>$seqres.full
>  	_btrfs_stress_replace $SCRATCH_MNT >>$seqres.full 2>&1 &
> @@ -71,8 +67,7 @@ run_test()
>  	echo "$remount_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_replace_pid $replace_pid
>  	unset replace_pid
>  	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> diff --git a/tests/btrfs/072 b/tests/btrfs/072
> index 0a3da5ffd..327508874 100755
> --- a/tests/btrfs/072
> +++ b/tests/btrfs/072
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$scrub_pid" ]; then
>  		_btrfs_kill_stress_scrub_pid $scrub_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -48,10 +45,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start scrub worker: " >>$seqres.full
>  	_btrfs_stress_scrub $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -64,9 +60,7 @@ run_test()
>  	echo "$defrag_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> -
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_defrag_pid $defrag_pid
>  	unset defrag_pid
>  	_btrfs_kill_stress_scrub_pid $scrub_pid
> diff --git a/tests/btrfs/073 b/tests/btrfs/073
> index bf7e9ca7a..b77e14c91 100755
> --- a/tests/btrfs/073
> +++ b/tests/btrfs/073
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$scrub_pid" ]; then
>  		_btrfs_kill_stress_scrub_pid $scrub_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -47,10 +44,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start scrub worker: " >>$seqres.full
>  	_btrfs_stress_scrub $SCRATCH_MNT >/dev/null 2>&1 &
> @@ -63,8 +59,7 @@ run_test()
>  	echo "$remount_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>  	unset remount_pid
>  	_btrfs_kill_stress_scrub_pid $scrub_pid
> diff --git a/tests/btrfs/074 b/tests/btrfs/074
> index f78267159..a752707db 100755
> --- a/tests/btrfs/074
> +++ b/tests/btrfs/074
> @@ -20,10 +20,7 @@ _cleanup()
>  	if [ ! -z "$defrag_pid" ]; then
>  		_btrfs_kill_stress_defrag_pid $defrag_pid
>  	fi
> -	if [ ! -z "$fsstress_pid" ]; then
> -		kill $fsstress_pid &> /dev/null
> -		wait $fsstress_pid &> /dev/null
> -	fi
> +	_kill_fsstress
>  }
>  
>  . ./common/filter
> @@ -48,10 +45,9 @@ run_test()
>  	fi
>  	_scratch_mount >>$seqres.full 2>&1
>  
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $SCRATCH_MNT/stressdir`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> +	_run_fsstress_bg $args
>  
>  	echo -n "Start defrag worker: " >>$seqres.full
>  	_btrfs_stress_defrag $SCRATCH_MNT $with_compress >/dev/null 2>&1 &
> @@ -64,8 +60,7 @@ run_test()
>  	echo "$remount_pid" >>$seqres.full
>  
>  	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	unset fsstress_pid
> +	_wait_for_fsstress
>  	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>  	unset remount_pid
>  	_btrfs_kill_stress_defrag_pid $defrag_pid
> diff --git a/tests/btrfs/078 b/tests/btrfs/078
> index bbebeff39..b802f9d86 100755
> --- a/tests/btrfs/078
> +++ b/tests/btrfs/078
> @@ -16,14 +16,6 @@
>  . ./common/preamble
>  _begin_fstest auto snapshot
>  
> -tmp=`mktemp -d`
> -
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	rm -fr $tmp
> -}
> -
>  . ./common/filter
>  
>  _require_scratch
> @@ -39,8 +31,8 @@ workout()
>  
>  	snapshot_cmd="$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
>  	snapshot_cmd="$snapshot_cmd $SCRATCH_MNT/snap_\`date +'%H_%M_%S_%N'\`"
> -	run_check $FSSTRESS_PROG -p $procs \
> -	    -x "$snapshot_cmd" -X $num_snapshots -d $SCRATCH_MNT -n $ops
> +	_run_fsstress -p $procs -x "$snapshot_cmd" -X $num_snapshots \
> +			-d $SCRATCH_MNT -n $ops
>  }
>  
>  ops=8000
> diff --git a/tests/btrfs/100 b/tests/btrfs/100
> index 46bfc4f74..a319c7bbb 100755
> --- a/tests/btrfs/100
> +++ b/tests/btrfs/100
> @@ -13,6 +13,7 @@ _begin_fstest auto replace volume eio
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
>  	_dmerror_cleanup
>  	rm -f $tmp.*
>  }
> @@ -39,8 +40,7 @@ error_devid=`$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
>  
>  snapshot_cmd="$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
>  snapshot_cmd="$snapshot_cmd $SCRATCH_MNT/snap_\`date +'%H_%M_%S_%N'\`"
> -run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n 200 -p 8 $FSSTRESS_AVOID -x \
> -							"$snapshot_cmd" -X 50
> +_run_fsstress -d $SCRATCH_MNT -n 200 -p 8 -x "$snapshot_cmd" -X 50
>  
>  # now load the error into the DMERROR_DEV
>  _dmerror_load_error_table
> diff --git a/tests/btrfs/101 b/tests/btrfs/101
> index c65e14ea0..cb14d6a07 100755
> --- a/tests/btrfs/101
> +++ b/tests/btrfs/101
> @@ -13,6 +13,7 @@ _begin_fstest auto replace volume eio
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
>  	_dmerror_cleanup
>  	rm -f $tmp.*
>  }
> @@ -40,8 +41,7 @@ error_devid=`$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
>  
>  snapshot_cmd="$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
>  snapshot_cmd="$snapshot_cmd $SCRATCH_MNT/snap_\`date +'%H_%M_%S_%N'\`"
> -run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n 200 -p 8 $FSSTRESS_AVOID -x \
> -							"$snapshot_cmd" -X 50
> +_run_fsstress -d $SCRATCH_MNT -n 200 -p 8 -x "$snapshot_cmd" -X 50
>  
>  # now load the error into the DMERROR_DEV
>  _dmerror_load_error_table
> diff --git a/tests/btrfs/136 b/tests/btrfs/136
> index 2a5280fb9..65bbcf516 100755
> --- a/tests/btrfs/136
> +++ b/tests/btrfs/136
> @@ -34,11 +34,9 @@ BTRFS_MD5SUM="$tmp.btrfs"
>  populate_data(){
>  	data_path=$1
>  	mkdir -p $data_path
> -	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $data_path`
> +	args=`_scale_fsstress_args -p 20 -n 100 -d $data_path`
>  	echo "Run fsstress $args" >>$seqres.full
> -	$FSSTRESS_PROG $args >>$seqres.full &
> -	fsstress_pid=$!
> -	wait $fsstress_pid
> +	_run_fsstress $args
>  }
>  
>  # Create & populate an ext3 filesystem
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> index f7fb65b8d..cc8e1e003 100755
> --- a/tests/btrfs/192
> +++ b/tests/btrfs/192
> @@ -13,12 +13,12 @@ _begin_fstest auto replay snapshot stress recoveryloop
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> +	_kill_fsstress
>  	kill -q $pid1 &> /dev/null
>  	kill -q $pid2 &> /dev/null
> -	"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
>  	wait
>  	_log_writes_cleanup &> /dev/null
> +	cd /
>  	rm -f $tmp.*
>  }
>  
> @@ -46,8 +46,7 @@ nr_cpus=$("$here/src/feature" -o)
>  if [ $nr_cpus -gt 8 ]; then
>  	nr_cpus=8
>  fi
> -fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p $nr_cpus \
> -		$FSSTRESS_AVOID)
> +fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p $nr_cpus )
>  _log_writes_init $SCRATCH_DEV
>  
>  # Discard the whole devices so when some tree pointer is wrong, it won't point
> @@ -135,10 +134,10 @@ pid1=$!
>  delete_workload &
>  pid2=$!
>  
> -"$FSSTRESS_PROG" $fsstress_args >> $seqres.full &
> +_run_fsstress_bg $fsstress_args
>  sleep $runtime
>  
> -"$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
> +_kill_fsstress
>  kill $pid1 &> /dev/null
>  kill $pid2 &> /dev/null
>  wait
> diff --git a/tests/btrfs/195 b/tests/btrfs/195
> index 72fc3a775..4dffddc1a 100755
> --- a/tests/btrfs/195
> +++ b/tests/btrfs/195
> @@ -49,7 +49,7 @@ run_testcase() {
>  	_scratch_mount
>  
>  	# Create random filesystem with 20k write ops
> -	$FSSTRESS_PROG -d $SCRATCH_MNT -w -n 10000 $FSSTRESS_AVOID >>$seqres.full 2>&1
> +	_run_fsstress -d $SCRATCH_MNT -w -n 10000
>  
>  	_run_btrfs_balance_start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full
>  	[ $? -eq 0 ] || echo "$1: Failed convert"
> diff --git a/tests/btrfs/212 b/tests/btrfs/212
> index f356d7d0f..745b9598a 100755
> --- a/tests/btrfs/212
> +++ b/tests/btrfs/212
> @@ -13,13 +13,13 @@ _begin_fstest auto balance dangerous
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> +	_kill_fsstress
>  	kill $balance_pid &> /dev/null
>  	kill $cancel_pid &> /dev/null
> -	"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> -	$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
>  	wait
> +	$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  . ./common/filter
> @@ -49,7 +49,7 @@ cancel_workload()
>  	done
>  }
>  
> -$FSSTRESS_PROG -d $SCRATCH_MNT -w -n 100000  >> $seqres.full 2>/dev/null &
> +_run_fsstress_bg -d $SCRATCH_MNT -w -n 100000
>  balance_workload &
>  balance_pid=$!
>  
> @@ -58,11 +58,11 @@ cancel_pid=$!
>  
>  sleep $runtime
>  
> +_kill_fsstress
>  kill $balance_pid
>  kill $cancel_pid
> -"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> -$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
>  wait
> +$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
>  
>  echo "Silence is golden"
>  # success, all done
> diff --git a/tests/btrfs/232 b/tests/btrfs/232
> index 4dcc39cc4..f843edbf7 100755
> --- a/tests/btrfs/232
> +++ b/tests/btrfs/232
> @@ -23,8 +23,8 @@ writer()
>  	trap "wait; exit" SIGTERM
>  
>  	while true; do
> -		args=`_scale_fsstress_args -p 20 -n 1000 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
> -		$FSSTRESS_PROG $args >> $seqres.full
> +		args=`_scale_fsstress_args -p 20 -n 1000 -d $SCRATCH_MNT/stressdir`
> +		_run_fsstress $args
>  	done
>  }
>  
> diff --git a/tests/btrfs/252 b/tests/btrfs/252
> index 2da02ffa1..bb111b909 100755
> --- a/tests/btrfs/252
> +++ b/tests/btrfs/252
> @@ -24,6 +24,7 @@ _begin_fstest auto send balance stress
>  
>  _cleanup()
>  {
> +	_kill_fsstress
>  	if [ ! -z $balance_pid ]; then
>  		kill $balance_pid &> /dev/null
>  		wait $balance_pid
> @@ -79,10 +80,10 @@ snapshot_cmd="$snapshot_cmd \"$snapshots_dir/snap_\`date +'%s%N'\`\""
>  # it's pointless to have them.
>  #
>  echo "Running fsstress..." >> $seqres.full
> -$FSSTRESS_PROG $FSSTRESS_AVOID -d "$data_subvol" -p 1 -w \
> +_run_fsstress -d "$data_subvol" -p 1 -w \
>  	       -f subvol_create=0 -f subvol_delete=0 -f snapshot=0 \
>  	       -x "$snapshot_cmd" -X $num_snapshots \
> -	       -n $total_fsstress_ops >> $seqres.full
> +	       -n $total_fsstress_ops
>  
>  snapshots=(`IFS=$'\n' ls -1 "$snapshots_dir"`)
>  
> diff --git a/tests/btrfs/261 b/tests/btrfs/261
> index 4052baaec..7a08b5667 100755
> --- a/tests/btrfs/261
> +++ b/tests/btrfs/261
> @@ -35,7 +35,7 @@ prepare_fs()
>  	# Then use fsstress to generate some extra contents.
>  	# Disable setattr related operations, as it may set NODATACOW which will
>  	# not allow us to use btrfs checksum to verify the content.
> -	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 >> $seqres.full
> +	_run_fsstress -f setattr=0 -d $SCRATCH_MNT -w -n 3000
>  	sync
>  
>  	# Save the fssum of this fs
> diff --git a/tests/btrfs/284 b/tests/btrfs/284
> index 6c554f325..ec3bc2720 100755
> --- a/tests/btrfs/284
> +++ b/tests/btrfs/284
> @@ -49,8 +49,8 @@ run_send_test()
>  
>  	# Use a single process so that in case of failure it's easier to
>  	# reproduce by using the same seed (logged in $seqres.full).
> -	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -p 1 -n $((LOAD_FACTOR * 200)) \
> -		  -w $FSSTRESS_AVOID -x "$snapshot_cmd"
> +	_run_fsstress -d $SCRATCH_MNT -p 1 -n $((LOAD_FACTOR * 200)) \
> +		  -w -x "$snapshot_cmd"
>  
>  	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
>  			 >> $seqres.full
> diff --git a/tests/btrfs/286 b/tests/btrfs/286
> index b8fa27673..7909fa507 100755
> --- a/tests/btrfs/286
> +++ b/tests/btrfs/286
> @@ -31,7 +31,7 @@ workload()
>  	# Use nodatasum mount option, so all data won't have checksum.
>  	_scratch_mount -o nodatasum
>  
> -	$FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT >> $seqres.full
> +	_run_fsstress -p 10 -n 200 -d $SCRATCH_MNT
>  	sync
>  
>  	# Generate fssum for later verification, here we only care
> diff --git a/tests/btrfs/320 b/tests/btrfs/320
> index 15549165e..bcfb96d1a 100755
> --- a/tests/btrfs/320
> +++ b/tests/btrfs/320
> @@ -28,8 +28,7 @@ _basic_test()
>  	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
>  		$seqres.full 2>&1
>  	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
> -	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
> -		$FSSTRESS_AVOID
> +	_run_fsstress -d $SCRATCH_MNT/a -w -p 1 -n 2000
>  	_btrfs subvolume snapshot $SCRATCH_MNT/a \
>  		$SCRATCH_MNT/b
>  
> @@ -55,8 +54,7 @@ _rescan_test()
>  	_btrfs subvolume create $SCRATCH_MNT/a
>  	_btrfs quota enable $SCRATCH_MNT/a
>  	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> -	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
> -		$FSSTRESS_AVOID
> +	_run_fsstress -d $SCRATCH_MNT/a -w -p 1 -n 2000
>  	sync
>  	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>  	echo "qgroup values before rescan: $output" >> $seqres.full
> diff --git a/tests/btrfs/332 b/tests/btrfs/332
> index ab9860668..4fcdad4cd 100755
> --- a/tests/btrfs/332
> +++ b/tests/btrfs/332
> @@ -32,7 +32,7 @@ d1=$SCRATCH_MNT/d1
>  d2=$SCRATCH_MNT/d2
>  mkdir $d1
>  mkdir $d2
> -run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> +_run_fsstress -d $d1 -w -n 2000
>  fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
>  
>  # enable squotas
> @@ -45,7 +45,7 @@ fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
>  	|| echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
>  
>  # do some more stuff
> -run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> +_run_fsstress -d $d2 -w -n 2000
>  fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
>  _scratch_unmount
>  _check_btrfs_filesystem $SCRATCH_DEV
> diff --git a/tests/ext4/004 b/tests/ext4/004
> index 20cfdb444..ab2f838e9 100755
> --- a/tests/ext4/004
> +++ b/tests/ext4/004
> @@ -12,6 +12,7 @@ _begin_fstest auto dump
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
>  	cd /
>  	rm -f $tmp.*
>  	# remove the generated data, which is much and meaningless.
> @@ -29,8 +30,7 @@ workout()
>  	echo "Run fsstress" >> $seqres.full
>  	args=`_scale_fsstress_args -z -f creat=5 -f write=20 -f mkdir=5 -n 100 -p 15 -d $dump_dir`
>  	echo "fsstress $args" >> $seqres.full
> -
> -	$FSSTRESS_PROG $args >> $seqres.full 2>&1
> +	_run_fsstress $args
>  
>  	echo "start Dump/Restore" >> $seqres.full
>  	cd $TEST_DIR
> diff --git a/tests/ext4/057 b/tests/ext4/057
> index 529f0c298..73cdf941a 100755
> --- a/tests/ext4/057
> +++ b/tests/ext4/057
> @@ -8,15 +8,6 @@
>  . ./common/preamble
>  _begin_fstest auto ioctl
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -        cd /
> -        rm -r -f $tmp.*
> -        kill -9 $fsstress_pid 2>/dev/null;
> -        wait > /dev/null 2>&1
> -}
> -
>  # Import common functions.
>  . ./common/filter
>  
> @@ -41,8 +32,7 @@ _scratch_mount
>  
>  # Begin fsstress while modifying UUID
>  fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> -$FSSTRESS_PROG $fsstress_args >> $seqres.full &
> -fsstress_pid=$!
> +_run_fsstress_bg $fsstress_args
>  
>  for n in $(seq 1 20); do
>          new_uuid=$($UUIDGEN_PROG)
> @@ -57,6 +47,8 @@ for n in $(seq 1 20); do
>          fi
>  done
>  
> +_kill_fsstress
> +
>  # success, all done
>  echo "Silence is golden"
>  status=0
> diff --git a/tests/ext4/058 b/tests/ext4/058
> index a7fc5e6c6..f85364964 100755
> --- a/tests/ext4/058
> +++ b/tests/ext4/058
> @@ -13,7 +13,6 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -
>  _supported_fs ext4
>  _fixed_by_kernel_commit a08f789d2ab5 \
>  	"ext4: fix bug_on ext4_mb_use_inode_pa"
> @@ -23,7 +22,7 @@ _require_scratch
>  _scratch_mkfs -g 256 >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount
>  
> -$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full 2>&1
> +_run_fsstress -d $SCRATCH_MNT/stress -n 1000
>  
>  echo "Silence is golden"
>  
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index f7c95c51b..8361f0431 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -19,9 +19,9 @@ _workout()
>  	echo ""
>  	echo "Run fsstress"
>  	out=$SCRATCH_MNT/fsstress.$$
> -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 $FSSTRESS_AVOID -d $out`
> +	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
>  	echo "fsstress $args" >> $seqres.full
> -	$FSSTRESS_PROG $args >> $seqres.full
> +	_run_fsstress $args
>  	find $out -type f > $out.list
>  	cat $out.list | xargs  md5sum > $out.md5sum
>  	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> diff --git a/tests/generic/013 b/tests/generic/013
> index 3a000b97f..0b86d8b33 100755
> --- a/tests/generic/013
> +++ b/tests/generic/013
> @@ -9,18 +9,6 @@
>  . ./common/preamble
>  _begin_fstest other ioctl udf auto quick
>  
> -status=0	# success is the default!
> -
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -    cd /
> -    # we might get here with a RO FS
> -    _test_cycle_mount
> -    # now remove fsstress directory.
> -    rm -rf $TEST_DIR/fsstress.$$.*
> -}
> -
>  # Import common functions.
>  . ./common/filter
>  
> @@ -30,7 +18,7 @@ _do_test()
>      _param="$2"
>      _count="$3"
>  
> -    out=$TEST_DIR/fsstress.$$.$_n
> +    out=$TEST_DIR/fsstress.$seq.$_n
>      rm -rf $out
>      if ! mkdir $out
>      then
> @@ -44,9 +32,8 @@ _do_test()
>      echo "fsstress.$_n : $_param"
>      echo "-----------------------------------------------"
>      # -m limits number of users/groups so check doesn't fail (malloc) later
> -    dbgoutfile=$seqres.full
> -    if ! $FSSTRESS_PROG $_param $FSSTRESS_AVOID -v -m 8 -n $_count -d $out >>$dbgoutfile 2>&1
> -    then
> +    _run_fsstress $_param -v -m 8 -n $_count -d $out
> +    if [ $? -ne 0 ]; then
>          echo "    fsstress (count=$_count) returned $? - see $seqres.full"
>          echo "--------------------------------------"       >>$seqres.full
>          echo "$_n - output from fsstress:"                  >>$seqres.full
> @@ -62,6 +49,7 @@ _do_test()
>  _require_test
>  
>  echo "brevity is wit..."
> +status=0
>  
>  count=1000
>  procs=20
> @@ -80,7 +68,7 @@ _do_test 2 "-p $procs -r" $count
>  
>  _do_test 3 "-p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10 -f rename=30 -f stat=30 -f unlink=30 -f truncate=20" $count
>  
> -# if all ok by here then probably don't need $seqres.full
> +rm -rf $TEST_DIR/fsstress.$seq.*
>  
>  exit
>  
> diff --git a/tests/generic/019 b/tests/generic/019
> index fe117ac8a..bed916b53 100755
> --- a/tests/generic/019
> +++ b/tests/generic/019
> @@ -22,7 +22,9 @@ _require_fail_make_request
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	kill $fs_pid $fio_pid &> /dev/null
> +	_kill_fsstress
> +	kill $fio_pid &> /dev/null
> +	wait
>  	_disallow_fail_make_request
>  	cd /
>  	rm -r -f $tmp.*
> @@ -85,13 +87,12 @@ FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0 -f setattr=1"
>  _workout()
>  {
>  	out=$SCRATCH_MNT/fsstress.$$
> -	args=`_scale_fsstress_args -p 1 -n999999999 -f setattr=0 $FSSTRESS_AVOID -d $out`
> +	args=`_scale_fsstress_args -p 1 -n999999999 -f setattr=0 -d $out`
>  	echo ""
>  	echo "Start fsstress.."
>  	echo ""
>  	echo "fsstress $args" >> $seqres.full
> -	$FSSTRESS_PROG $args >> $seqres.full 2>&1 &
> -	fs_pid=$!
> +	_run_fsstress_bg $args
>  	echo "Start fio.."
>  	cat $fio_config >>  $seqres.full
>  	$FIO_PROG $fio_config >> $seqres.full 2>&1 &
> @@ -107,10 +108,8 @@ _workout()
>  	    >> $seqres.full 2>&1 && \
>  	    _fail "failed: still able to perform integrity fsync on $SCRATCH_MNT"
>  
> -	kill $fs_pid &> /dev/null
> -	wait $fs_pid
> +	_kill_fsstress
>  	wait $fio_pid
> -	unset fs_pid
>  	unset fio_pid
>  
>  	# We expect that broken FS still can be umounted
> diff --git a/tests/generic/051 b/tests/generic/051
> index 65571fdd0..69250cde6 100755
> --- a/tests/generic/051
> +++ b/tests/generic/051
> @@ -14,18 +14,8 @@ _begin_fstest shutdown auto stress log metadata repair
>  # Import common functions.
>  . ./common/filter
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	_scratch_unmount 2>/dev/null
> -	rm -f $tmp.*
> -}
> -
> -
>  _require_scratch
>  _require_scratch_shutdown
> -_require_command "$KILLALL_PROG" killall
>  
>  _scratch_mkfs > $seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
> @@ -37,25 +27,23 @@ PROCS=$((2 * LOAD_FACTOR))
>  load_dir=$SCRATCH_MNT/test
>  
>  # let this run for a while
> -$FSSTRESS_PROG $FSSTRESS_AVOID -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
> +_run_fsstress_bg -n 10000000 -p $PROCS -d $load_dir
>  sleep $SLEEP_TIME
> -$KILLALL_PROG -q $FSSTRESS_PROG
> -wait
> +_kill_fsstress
>  sync
>  _scratch_unmount
>  
>  # now mount again, run the load again, this time with a shutdown.
>  _scratch_mount
>  $XFS_FSR_PROG -v $load_dir >> $seqres.full 2>&1
> -$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
> +_run_fsstress_bg -n10000000 -p $PROCS -d $load_dir
>  sleep $SLEEP_TIME
>  sync
>  
>  # now shutdown and unmount
>  sleep 5
>  _scratch_shutdown
> -$KILLALL_PROG -q $FSSTRESS_PROG
> -wait
> +_kill_fsstress
>  
>  # for some reason fsstress processes manage to live on beyond the wait?
>  sleep 5
> diff --git a/tests/generic/055 b/tests/generic/055
> index b1126c901..e57f95faf 100755
> --- a/tests/generic/055
> +++ b/tests/generic/055
> @@ -23,9 +23,9 @@ _do_meta()
>      param="-p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10 \
>             -f rename=30 -f stat=30 -f unlink=30 -f truncate=20"
>      _echofull "calling fsstress $param -m8 -n $count"
> -    FSSTRESS_ARGS=`_scale_fsstress_args $param $FSSTRESS_AVOID -m 8 -n $count -d $out`
> -    if ! $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full 2>&1
> -    then
> +    FSSTRESS_ARGS=`_scale_fsstress_args $param -m 8 -n $count -d $out`
> +    _run_fsstress $FSSTRESS_ARGS
> +    if [ $? -ne 0 ]; then
>  	_echofull "fsstress failed"
>      fi
>  }
> diff --git a/tests/generic/068 b/tests/generic/068
> index 1e8248b9d..26c5ceea6 100755
> --- a/tests/generic/068
> +++ b/tests/generic/068
> @@ -19,8 +19,7 @@ _cleanup()
>  {
>  	# Make sure $SCRATCH_MNT is unfreezed
>  	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> -	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
> -	wait $pid
> +	_kill_fsstress
>  	cd /
>  	rm -f $tmp.*
>  }
> @@ -54,8 +53,8 @@ touch $tmp.running
>        do
>        # We do both read & write IO - not only is this more realistic,
>        # but it also potentially tests atime updates
> -      FSSTRESS_ARGS=`_scale_fsstress_args -d $STRESS_DIR -p $procs -n $nops $FSSTRESS_AVOID`
> -      $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
> +      FSSTRESS_ARGS=`_scale_fsstress_args -d $STRESS_DIR -p $procs -n $nops`
> +      _run_fsstress $FSSTRESS_ARGS >>$seqres.full
>      done
>  
>      rm -r $STRESS_DIR/*
> diff --git a/tests/generic/070 b/tests/generic/070
> index a8e84effd..000fc0482 100755
> --- a/tests/generic/070
> +++ b/tests/generic/070
> @@ -9,19 +9,10 @@
>  . ./common/preamble
>  _begin_fstest attr udf auto quick stress
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -    cd /
> -    rm -rf $TEST_DIR/fsstress
> -    rm -f $tmp.*
> -}
> -
>  # Import common functions.
>  . ./common/filter
>  . ./common/attr
>  
> -
>  _require_test
>  _require_attrs
>  
> @@ -34,7 +25,8 @@ FSSTRESS_ARGS=`_scale_fsstress_args \
>  	-f attr_set=100 \
>  	-f attr_remove=100 \
>          -p 1 -n 10000 -S c`
> -$FSSTRESS_PROG $FSSTRESS_ARGS >$seqres.full 2>&1
> +_run_fsstress $FSSTRESS_ARGS
> +rm -rf $TEST_DIR/fsstress
>  
>  status=$?
>  exit
> diff --git a/tests/generic/076 b/tests/generic/076
> index b50c2df5e..100f19715 100755
> --- a/tests/generic/076
> +++ b/tests/generic/076
> @@ -21,16 +21,14 @@ _lets_get_pidst()
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	echo "*** unmount"
> -	_scratch_unmount 2>/dev/null
>  	_lets_get_pidst
> +	cd /
> +	rm -f $tmp.*
>  }
> -_register_cleanup "_cleanup; rm -f $tmp.*"
>  
>  # Import common functions.
>  . ./common/filter
>  
> -
>  _require_scratch
>  _require_local_device $SCRATCH_DEV
>  
> @@ -48,9 +46,9 @@ echo "*** test concurrent block/fs access"
>  cat $SCRATCH_DEV >/dev/null &
>  pid=$!
>  
> -FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000 $FSSTRESS_AVOID`
> +FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000`
>  echo "run fsstress with args: $FSSTRESS_ARGS" >>$seqres.full
> -$FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
> +_run_fsstress $FSSTRESS_ARGS
>  _lets_get_pidst
>  
>  echo "*** done"
> diff --git a/tests/generic/076.out b/tests/generic/076.out
> index 54a8f7096..74a65bdec 100644
> --- a/tests/generic/076.out
> +++ b/tests/generic/076.out
> @@ -2,4 +2,3 @@ QA output created by 076
>  *** init fs
>  *** test concurrent block/fs access
>  *** done
> -*** unmount
> diff --git a/tests/generic/083 b/tests/generic/083
> index ff4785eee..6aa0ea06d 100755
> --- a/tests/generic/083
> +++ b/tests/generic/083
> @@ -18,18 +18,9 @@
>  . ./common/preamble
>  _begin_fstest rw auto enospc stress
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	echo "*** unmount"
> -	_scratch_unmount 2>/dev/null
> -	rm -f $tmp.*
> -}
> -
>  # Import common functions.
>  . ./common/filter
>  
> -
>  _require_scratch
>  _require_no_large_scratch_dev
>  
> @@ -52,8 +43,8 @@ workout()
>  	_scratch_mount
>  
>  	# -w ensures that the only ops are ones which cause write I/O
> -	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs -n $nops $FSSTRESS_AVOID`
> -	$FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
> +	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs -n $nops`
> +	_run_fsstress $FSSTRESS_ARGS >>$seqres.full
>  }
>  
>  echo "*** test out-of-space handling for random write operations"
> diff --git a/tests/generic/083.out b/tests/generic/083.out
> index 025afe30e..b853eadb4 100644
> --- a/tests/generic/083.out
> +++ b/tests/generic/083.out
> @@ -1,4 +1,3 @@
>  QA output created by 083
>  *** test out-of-space handling for random write operations
>  *** done
> -*** unmount
> diff --git a/tests/generic/117 b/tests/generic/117
> index f9769be94..a34f86165 100755
> --- a/tests/generic/117
> +++ b/tests/generic/117
> @@ -63,9 +63,7 @@ echo Running fsstress in serial:
>  i=0
>  while [ $i -lt $ITERATIONS ]; do
>      echo fsstress iteration: $i | tee -a $seqres.full
> -    $FSSTRESS_PROG \
> -	-d $SCRATCH_MNT/fsstress \
> -	$fss_ops -S c >>$seqres.full 2>&1
> +    _run_fsstress -d $SCRATCH_MNT/fsstress $fss_ops -S c
>  
>      let i=$i+1
>  done
> diff --git a/tests/generic/232 b/tests/generic/232
> index 35934cc18..c903a5619 100755
> --- a/tests/generic/232
> +++ b/tests/generic/232
> @@ -30,13 +30,12 @@ _fsstress()
>  
>  	out=$SCRATCH_MNT/fsstress.$$
>  	count=2000
> -	args=`_scale_fsstress_args -d $out -n $count -p 7 $FSSTRESS_AVOID`
> +	args=`_scale_fsstress_args -d $out -n $count -p 7`
>  
>  	echo "fsstress $args" >> $seqres.full
> -	if ! $FSSTRESS_PROG $args | tee -a $seqres.full | _filter_num
> +	if ! _run_fsstress $args
>  	then
>  		echo "    fsstress $args returned $?"
> -		cat $tmp.out | tee -a $seqres.full
>  		status=1
>  	fi
>  }
> diff --git a/tests/generic/232.out b/tests/generic/232.out
> index 5da53d4bf..9214607f0 100644
> --- a/tests/generic/232.out
> +++ b/tests/generic/232.out
> @@ -2,6 +2,5 @@ QA output created by 232
>  
>  Testing fsstress
>  
> -seed = S
>  Comparing user usage
>  Comparing group usage
> diff --git a/tests/generic/269 b/tests/generic/269
> index 341fcd22f..979cc15cb 100755
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -21,10 +21,9 @@ _workout()
>  	num_iterations=10
>  	enospc_time=2
>  	out=$SCRATCH_MNT/fsstress.$$
> -	args=`_scale_fsstress_args -p128 -n999999999 -f setattr=1 $FSSTRESS_AVOID -d $out`
> +	args=`_scale_fsstress_args -p128 -n999999999 -f setattr=1 -d $out`
>  	echo "fsstress $args" >> $seqres.full
> -	$FSSTRESS_PROG $args &>> $seqres.full &
> -	pid=$!
> +	_run_fsstress_bg $args
>  	echo "Run dd writers in parallel"
>  	for ((i=0; i < num_iterations; i++))
>  	do
> @@ -34,8 +33,7 @@ _workout()
>  		sleep $enospc_time
>  	done
>  	echo "Killing fsstress process..." >> $seqres.full
> -	kill $pid >> $seqres.full 2>&1
> -	wait $pid
> +	_kill_fsstress
>  }
>  
>  _require_scratch
> diff --git a/tests/generic/270 b/tests/generic/270
> index cf523f4ea..aff379ac5 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -28,8 +28,8 @@ _workout()
>  	args=`_scale_fsstress_args -p128 -n999999999 -f setattr=1 $FSSTRESS_AVOID -d $out`
>  	echo "fsstress $args" >> $seqres.full
>  	# Grant chown capability 
> -	cp $FSSTRESS_PROG  $tmp.fsstress.bin
> -	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
> +	cp $FSSTRESS_PROG $_FSSTRESS_PROG
> +	$SETCAP_PROG cap_chown=epi $_FSSTRESS_PROG
>  
>  	# io_uring accounts memory it needs under the rlimit memlocked option,
>  	# which can be quite low on some setups (especially 64K pagesize). root
> @@ -37,7 +37,8 @@ _workout()
>  	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
>  	# temporarily.
>  	ulimit -l unlimited
> -	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
> +	su $qa_user -c "$_FSSTRESS_PROG $args" > /dev/null 2>&1 &
> +	_FSSTRESS_PID=$!
>  
>  	echo "Run dd writers in parallel"
>  	for ((i=0; i < num_iterations; i++))
> @@ -49,7 +50,7 @@ _workout()
>  		sleep $enospc_time
>  	done
>  
> -	$KILLALL_PROG -w $tmp.fsstress.bin
> +	_kill_fsstress
>  }
>  
>  _require_quota
> diff --git a/tests/generic/388 b/tests/generic/388
> index 89ddda31d..34609a0d3 100755
> --- a/tests/generic/388
> +++ b/tests/generic/388
> @@ -17,23 +17,9 @@
>  . ./common/preamble
>  _begin_fstest shutdown auto log metadata recoveryloop
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -	_scratch_unmount > /dev/null 2>&1
> -}
> -
> -# Import common functions.
> -
> -# Modify as appropriate.
> -
>  _require_scratch
>  _require_local_device $SCRATCH_DEV
>  _require_scratch_shutdown
> -_require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
>  
> @@ -42,20 +28,14 @@ _require_metadata_journaling $SCRATCH_DEV
>  _scratch_mount
>  
>  while _soak_loop_running $((50 * TIME_FACTOR)); do
> -	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
> -		> /dev/null 2>&1
> +	_run_fsstress_bg -d $SCRATCH_MNT -n 999999 -p 4
>  
>  	# purposely include 0 second sleeps to test shutdown immediately after
>  	# recovery
>  	sleep $((RANDOM % 3))
>  	_scratch_shutdown
>  
> -	ps -e | grep fsstress > /dev/null 2>&1
> -	while [ $? -eq 0 ]; do
> -		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -		wait > /dev/null 2>&1
> -		ps -e | grep fsstress > /dev/null 2>&1
> -	done
> +	_kill_fsstress
>  
>  	# Toggle between rw and ro mounts for recovery. Quit if any mount
>  	# attempt fails so we don't shutdown the host fs.
> diff --git a/tests/generic/390 b/tests/generic/390
> index 02f6c5eef..52270782e 100755
> --- a/tests/generic/390
> +++ b/tests/generic/390
> @@ -18,8 +18,7 @@ _cleanup()
>  	[ -n "$freeze_pids" ] && kill -9 $freeze_pids 2>/dev/null
>  	wait $freeze_pids
>  	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> -	[ -n "$fsstress_pid" ] && kill -9 $fsstress_pid 2>/dev/null
> -	wait $fsstress_pid
> +	_kill_fsstress
>  	rm -f $tmp.*
>  }
>  
> @@ -49,9 +48,8 @@ fi
>  nops=1000
>  stress_dir="$SCRATCH_MNT/fsstress_test_dir"
>  mkdir "$stress_dir"
> -fsstress_args=`_scale_fsstress_args -d $stress_dir -p $procs -n $nops $FSSTRESS_AVOID`
> -$FSSTRESS_PROG $fsstress_args >>$seqres.full 2>&1 &
> -fsstress_pid=$!
> +fsstress_args=`_scale_fsstress_args -d $stress_dir -p $procs -n $nops`
> +_run_fsstress_bg $fsstress_args
>  
>  # Start multi-threads freeze/unfreeze
>  for ((i=0; i<$procs; i++)); do
> @@ -62,9 +60,8 @@ for ((i=0; i<$procs; i++)); do
>  	freeze_pids="$! $freeze_pids"
>  done
>  
> -wait $fsstress_pid
> +_wait_for_fsstress
>  result=$?
> -unset fsstress_pid
>  wait $freeze_pids
>  unset freeze_pids
>  
> diff --git a/tests/generic/409 b/tests/generic/409
> index b7edc2ac6..ab7e7eb55 100755
> --- a/tests/generic/409
> +++ b/tests/generic/409
> @@ -25,11 +25,12 @@ _begin_fstest auto quick mount
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> +	_kill_fsstress
>  	_clear_mount_stack
>  	# make sure there's no bug cause dentry isn't be freed
>  	rm -rf $MNTHEAD
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -43,7 +44,7 @@ fs_stress()
>  {
>  	local target=$1
>  
> -	$FSSTRESS_PROG -z -n 50 -p 3 \
> +	_run_fsstress -z -n 50 -p 3 \
>  		       -f creat=5 \
>  		       -f mkdir=5 \
>  		       -f link=2 \
> @@ -56,7 +57,7 @@ fs_stress()
>  		       -f chown=1 \
>  		       -f getdents=1 \
>  		       -f fiemap=1 \
> -		       -d $target >>$seqres.full
> +		       -d $target
>  	sync
>  }
>  
> diff --git a/tests/generic/410 b/tests/generic/410
> index 902f27144..f0f0921be 100755
> --- a/tests/generic/410
> +++ b/tests/generic/410
> @@ -33,11 +33,12 @@ _begin_fstest auto quick mount
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> +	_kill_fsstress
>  	_clear_mount_stack
>  	# make sure there's no bug cause dentry isn't be freed
>  	rm -rf $MNTHEAD
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -51,7 +52,7 @@ fs_stress()
>  {
>  	local target=$1
>  
> -	$FSSTRESS_PROG -z -n 50 -p 3 \
> +	_run_fsstress -z -n 50 -p 3 \
>  		       -f creat=5 \
>  		       -f mkdir=5 \
>  		       -f link=2 \
> @@ -64,7 +65,7 @@ fs_stress()
>  		       -f chown=1 \
>  		       -f getdents=1 \
>  		       -f fiemap=1 \
> -		       -d $target >>$seqres.full
> +		       -d $target
>  	sync
>  }
>  
> diff --git a/tests/generic/411 b/tests/generic/411
> index c35436c82..3b55b4f91 100755
> --- a/tests/generic/411
> +++ b/tests/generic/411
> @@ -14,11 +14,12 @@ _begin_fstest auto quick mount
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> +	_kill_fsstress
>  	_clear_mount_stack
>  	# make sure there's no bug cause dentry isn't be freed
>  	rm -rf $MNTHEAD
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -32,7 +33,7 @@ fs_stress()
>  {
>  	local target=$1
>  
> -	$FSSTRESS_PROG -z -n 500 -p 5 \
> +	_run_fsstress -z -n 500 -p 5 \
>  		       -f creat=5 \
>  		       -f mkdir=5 \
>  		       -f dwrite=1 \
> @@ -47,7 +48,7 @@ fs_stress()
>  		       -f chown=1 \
>  		       -f getdents=1 \
>  		       -f fiemap=1 \
> -		       -d $target >>$seqres.full
> +		       -d $target
>  	sync
>  }
>  
> diff --git a/tests/generic/461 b/tests/generic/461
> index 468ce46f0..95dd6a34d 100755
> --- a/tests/generic/461
> +++ b/tests/generic/461
> @@ -14,18 +14,8 @@ _begin_fstest auto shutdown stress
>  # Import common functions.
>  . ./common/filter
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	_scratch_unmount 2>/dev/null
> -	rm -f $tmp.*
> -}
> -
> -
>  _require_scratch_nocheck
>  _require_scratch_shutdown
> -_require_command "$KILLALL_PROG" killall
>  
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount
> @@ -35,15 +25,14 @@ PROCS=$((4 * LOAD_FACTOR))
>  
>  load_dir=$SCRATCH_MNT/test
>  
> -$FSSTRESS_PROG $FSSTRESS_AVOID -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
> +_run_fsstress_bg -n10000000 -p $PROCS -d $load_dir
>  sleep $SLEEP_TIME
>  sync
>  
>  # now shutdown and unmount
>  sleep 5
>  _scratch_shutdown
> -$KILLALL_PROG -q $FSSTRESS_PROG
> -wait
> +_kill_fsstress
>  
>  # for some reason fsstress processes manage to live on beyond the wait?
>  sleep 5
> diff --git a/tests/generic/475 b/tests/generic/475
> index 4b854f9ab..9df2051fb 100755
> --- a/tests/generic/475
> +++ b/tests/generic/475
> @@ -17,11 +17,11 @@ _begin_fstest shutdown auto log metadata eio recoveryloop smoketest
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +	_kill_fsstress
>  	_dmerror_unmount
>  	_dmerror_cleanup
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -31,7 +31,6 @@ _cleanup()
>  
>  _require_scratch
>  _require_dm_target error
> -_require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
>  
> @@ -41,8 +40,7 @@ _dmerror_init
>  _dmerror_mount
>  
>  while _soak_loop_running $((50 * TIME_FACTOR)); do
> -	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4)) >> $seqres.full &) \
> -		> /dev/null 2>&1
> +	_run_fsstress_bg -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4))
>  
>  	# purposely include 0 second sleeps to test shutdown immediately after
>  	# recovery
> @@ -55,12 +53,7 @@ while _soak_loop_running $((50 * TIME_FACTOR)); do
>  	# error table helper *without* 'lockfs'.
>  	_dmerror_load_error_table
>  
> -	ps -e | grep fsstress > /dev/null 2>&1
> -	while [ $? -eq 0 ]; do
> -		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -		wait > /dev/null 2>&1
> -		ps -e | grep fsstress > /dev/null 2>&1
> -	done
> +	_kill_fsstress
>  
>  	# Mount again to replay log after loading working table, so we have a
>  	# consistent XFS after test.
> diff --git a/tests/generic/476 b/tests/generic/476
> index cf7402a12..769b3745f 100755
> --- a/tests/generic/476
> +++ b/tests/generic/476
> @@ -10,20 +10,7 @@
>  . ./common/preamble
>  _begin_fstest auto rw long_rw stress soak smoketest
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -}
> -
> -# Import common functions.
> -
> -# Modify as appropriate.
> -
>  _require_scratch
> -_require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
>  
> @@ -35,7 +22,7 @@ nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
>  fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
>  test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
>  
> -$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +_run_fsstress_bg "${fsstress_args[@]}"
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/482 b/tests/generic/482
> index 54fee07d4..8c114ee03 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -18,10 +18,10 @@ _begin_fstest auto metadata replay thin recoveryloop
>  # failure leaves the corpse intact for post-mortem failure analysis.
>  _cleanup()
>  {
> -	cd /
> -	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> +	_kill_fsstress
>  	_log_writes_cleanup &> /dev/null
>  	_dmthin_cleanup
> +	cd /
>  	rm -f $tmp.*
>  }
>  
> @@ -29,7 +29,7 @@ _cleanup()
>  #_cleanup()
>  #{
>  #	cd /
> -#	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> +#	[ -n "$fsstress_pid" ] && kill $fsstress_pid
>  #	if [ $status -eq 0 ]; then
>  #		_log_writes_cleanup &> /dev/null
>  #		_dmthin_cleanup
> @@ -48,7 +48,6 @@ _cleanup()
>  # Modify as appropriate.
>  
>  _require_no_logdev
> -_require_command "$KILLALL_PROG" killall
>  # Use thin device as replay device, which requires $SCRATCH_DEV
>  _require_scratch_nocheck
>  # and we need extra device as log device
> @@ -60,8 +59,7 @@ nr_cpus=$("$here/src/feature" -o)
>  if [ $nr_cpus -gt 8 ]; then
>  	nr_cpus=8
>  fi
> -fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 512 -p $nr_cpus \
> -		$FSSTRESS_AVOID)
> +fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 512 -p $nr_cpus)
>  
>  size=$(_small_fs_size_mb 200)           # 200m phys/virt size
>  devsize=$((1024*1024*size / 512))
> @@ -77,7 +75,7 @@ _log_writes_mkfs >> $seqres.full 2>&1
>  _log_writes_mark mkfs
>  
>  _log_writes_mount
> -run_check $FSSTRESS_PROG $fsstress_args
> +_run_fsstress $fsstress_args
>  _log_writes_unmount
>  
>  _log_writes_remove
> diff --git a/tests/generic/547 b/tests/generic/547
> index 1e3881db9..14d02b4fd 100755
> --- a/tests/generic/547
> +++ b/tests/generic/547
> @@ -14,6 +14,7 @@ _begin_fstest auto quick log
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
>  	_cleanup_flakey
>  	cd /
>  	rm -f $tmp.*
> @@ -38,10 +39,10 @@ _init_flakey
>  _mount_flakey
>  
>  mkdir $SCRATCH_MNT/test
> -args=`_scale_fsstress_args -p 4 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/test`
> +args=`_scale_fsstress_args -p 4 -n 100 -d $SCRATCH_MNT/test`
>  args="$args -f mknod=0 -f symlink=0"
>  echo "Running fsstress with arguments: $args" >>$seqres.full
> -$FSSTRESS_PROG $args >>$seqres.full
> +_run_fsstress $args
>  
>  # Fsync every file and directory.
>  find $SCRATCH_MNT/test \( -type f -o -type d \) -exec $XFS_IO_PROG -c fsync {} \;
> diff --git a/tests/generic/560 b/tests/generic/560
> index 62983d69b..067d3ec00 100755
> --- a/tests/generic/560
> +++ b/tests/generic/560
> @@ -30,8 +30,8 @@ function iterate_dedup_verify()
>  		find $dest -type f -exec md5sum {} \; \
>  			> $md5file$index
>  		# Make some noise
> -		$FSSTRESS_PROG $fsstress_opts -d $noisedir \
> -			       -n 200 -p $((5 * LOAD_FACTOR)) >/dev/null 2>&1
> +		_run_fsstress $fsstress_opts -d $noisedir \
> +			       -n 200 -p $((5 * LOAD_FACTOR))
>  		# Too many output, so only save error output
>  		$DUPEREMOVE_PROG -dr --dedupe-options=same $dupdir \
>  			>/dev/null 2>$seqres.full
> @@ -51,8 +51,7 @@ md5file=${tmp}.md5sum
>  
>  fsstress_opts="-w -r"
>  # Create some files to be original data
> -$FSSTRESS_PROG $fsstress_opts -d $srcdir \
> -	       -n 500 -p $((5 * LOAD_FACTOR)) >/dev/null 2>&1
> +_run_fsstress $fsstress_opts -d $srcdir -n 500 -p $((5 * LOAD_FACTOR))
>  
>  # Calculate how many test cycles will be run
>  src_size=`du -ks $srcdir | awk '{print $1}'`
> diff --git a/tests/generic/561 b/tests/generic/561
> index 39e5977a3..3e931b1a7 100755
> --- a/tests/generic/561
> +++ b/tests/generic/561
> @@ -13,9 +13,9 @@ _begin_fstest auto stress dedupe
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	end_test
>  	cd /
>  	rm -f $tmp.*
> -	end_test
>  }
>  
>  # Import common functions.
> @@ -23,28 +23,20 @@ _cleanup()
>  . ./common/reflink
>  
>  _require_scratch_duperemove
> -_require_command "$KILLALL_PROG" killall
>  
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  
>  function end_test()
>  {
> -	local f=1
> +	_kill_fsstress
>  
>  	# stop duperemove running
>  	if [ -e $dupe_run ]; then
>  		rm -f $dupe_run
> -		$KILLALL_PROG -q $DUPEREMOVE_PROG > /dev/null 2>&1
> +		kill $dedup_pids
>  		wait $dedup_pids
>  	fi
> -
> -	# Make sure all fsstress get killed
> -	while [ $f -ne 0 ]; do
> -		$KILLALL_PROG -q $FSSTRESS_PROG > /dev/null 2>&1
> -		sleep 1
> -		f=`ps -eLf | grep $FSSTRESS_PROG | grep -v "grep" | wc -l`
> -	done
>  }
>  
>  sleep_time=$((50 * TIME_FACTOR))
> @@ -53,7 +45,8 @@ sleep_time=$((50 * TIME_FACTOR))
>  testdir="$SCRATCH_MNT/dir"
>  mkdir $testdir
>  fsstress_opts="-r -n 1000 -p $((5 * LOAD_FACTOR))"
> -$FSSTRESS_PROG $fsstress_opts -d $testdir -l 0 >> $seqres.full 2>&1 &
> +_run_fsstress_bg $fsstress_opts -d $testdir -l 0
> +
>  dedup_pids=""
>  dupe_run=$TEST_DIR/${seq}-running
>  # Start several dedupe processes on same directory
> diff --git a/tests/generic/579 b/tests/generic/579
> index 3191342b3..4187ab0f0 100755
> --- a/tests/generic/579
> +++ b/tests/generic/579
> @@ -16,7 +16,7 @@ _begin_fstest auto stress verity
>  _cleanup()
>  {
>  	# Stop all subprocesses.
> -	$KILLALL_PROG -q $FSSTRESS_PROG
> +	_kill_fsstress
>  	touch $tmp.done
>  	wait
>  
> @@ -29,7 +29,6 @@ _cleanup()
>  . ./common/verity
>  
>  _require_scratch_verity
> -_require_command "$KILLALL_PROG" killall
>  _disable_fsverity_signatures
>  
>  _scratch_mkfs_verity &>> $seqres.full
> @@ -92,8 +91,7 @@ done
>  ) &
>  
>  # Start the fsstress processes.
> -$FSSTRESS_PROG $FSSTRESS_AVOID -p $nproc_stress -l 0 -d $SCRATCH_MNT/stressdir \
> -	>> $seqres.full 2>&1 &
> +_run_fsstress_bg -p $nproc_stress -l 0 -d $SCRATCH_MNT/stressdir
>  
>  # Run for a while.
>  sleep $runtime
> diff --git a/tests/generic/585 b/tests/generic/585
> index fb675c8d5..b95cd9abf 100755
> --- a/tests/generic/585
> +++ b/tests/generic/585
> @@ -23,10 +23,10 @@ _scratch_mount >> $seqres.full 2>&1
>  # start a create and rename(rename_whiteout) workload. These processes
>  # occur simultaneously may cause the deadlock between AGI and AGF with
>  # RENAME_WHITEOUT.
> -$FSSTRESS_PROG -z -n 150 -p 100 \
> +_run_fsstress -z -n 150 -p 100 \
>  		-f mknod=5 \
>  		-f rwhiteout=5 \
> -		-d $SCRATCH_MNT/fsstress >> $seqres.full 2>&1
> +		-d $SCRATCH_MNT/fsstress
>  
>  echo Silence is golden
>  
> diff --git a/tests/generic/589 b/tests/generic/589
> index 0ce16556a..969a8ac61 100755
> --- a/tests/generic/589
> +++ b/tests/generic/589
> @@ -28,11 +28,12 @@ _begin_fstest auto mount
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> +	_kill_fsstress
>  	_clear_mount_stack
>  	# make sure there's no bug cause dentry isn't be freed
>  	rm -rf $MNTHEAD
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -46,7 +47,7 @@ fs_stress()
>  {
>  	local target=$1
>  
> -	$FSSTRESS_PROG -n 50 -p 3 -d $target >>$seqres.full
> +	_run_fsstress -n 50 -p 3 -d $target
>  	sync
>  }
>  
> diff --git a/tests/generic/642 b/tests/generic/642
> index a7112a08f..4b92a9c18 100755
> --- a/tests/generic/642
> +++ b/tests/generic/642
> @@ -10,17 +10,9 @@
>  . ./common/preamble
>  _begin_fstest auto soak attr long_rw stress smoketest
>  
> -_cleanup()
> -{
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -	cd /
> -	rm -f $tmp.*
> -}
> -
>  # Modify as appropriate.
>  
>  _require_scratch
> -_require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
>  
> @@ -50,7 +42,7 @@ args+=('-f' "setfattr=20")
>  args+=('-f' "attr_set=60")	# sets larger xattrs
>  test -n "$SOAK_DURATION" && args+=(--duration="$SOAK_DURATION")
>  
> -$FSSTRESS_PROG "${args[@]}" $FSSTRESS_AVOID -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus >> $seqres.full
> +_run_fsstress "${args[@]}" -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/648 b/tests/generic/648
> index 29d1b470b..e4c9990e1 100755
> --- a/tests/generic/648
> +++ b/tests/generic/648
> @@ -16,16 +16,15 @@ _begin_fstest shutdown auto log metadata eio recoveryloop
>  
>  _cleanup()
>  {
> -	cd /
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -	wait
> +	_kill_fsstress
>  	if [ -n "$loopmnt" ]; then
>  		$UMOUNT_PROG $loopmnt 2>/dev/null
>  		rm -r -f $loopmnt
>  	fi
> -	rm -f $tmp.*
>  	_dmerror_unmount
>  	_dmerror_cleanup
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -37,7 +36,6 @@ _cleanup()
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_dm_target error
> -_require_command "$KILLALL_PROG" "killall"
>  _require_loop
>  
>  echo "Silence is golden."
> @@ -71,8 +69,6 @@ snap_loop_fs() {
>  	rm -f "$snap_aliveflag"
>  }
>  
> -fsstress=($FSSTRESS_PROG $FSSTRESS_AVOID -d "$loopmnt" -n 999999 -p "$((LOAD_FACTOR * 4))")
> -
>  while _soak_loop_running $((25 * TIME_FACTOR)); do
>  	touch $scratch_aliveflag
>  	snap_loop_fs >> $seqres.full 2>&1 &
> @@ -84,7 +80,7 @@ while _soak_loop_running $((25 * TIME_FACTOR)); do
>  		break
>  	fi
>  
> -	("${fsstress[@]}" >> $seqres.full &) > /dev/null 2>&1
> +	_run_fsstress_bg -d "$loopmnt" -n 999999 -p "$((LOAD_FACTOR * 4))"
>  
>  	# purposely include 0 second sleeps to test shutdown immediately after
>  	# recovery
> @@ -98,12 +94,7 @@ while _soak_loop_running $((25 * TIME_FACTOR)); do
>  	# error table helper *without* 'lockfs'.
>  	_dmerror_load_error_table
>  
> -	ps -e | grep fsstress > /dev/null 2>&1
> -	while [ $? -eq 0 ]; do
> -		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -		wait > /dev/null 2>&1
> -		ps -e | grep fsstress > /dev/null 2>&1
> -	done
> +	_kill_fsstress
>  	for ((j = 0; j < 10; j++)); do
>  		test -e "$snap_aliveflag" || break
>  		sleep 1
> diff --git a/tests/generic/650 b/tests/generic/650
> index 5d2cb8977..36a23e48d 100755
> --- a/tests/generic/650
> +++ b/tests/generic/650
> @@ -16,14 +16,14 @@ _begin_fstest auto rw stress soak
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +	_kill_fsstress
>  	wait	# for exercise_cpu_hotplug subprocess
>  	for i in "$sysfs_cpu_dir/"cpu*/online; do
>  		echo 1 > "$i" 2>/dev/null
>  	done
>  	test -n "$stress_dir" && rm -r -f "$stress_dir"
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  exercise_cpu_hotplug()
> @@ -39,7 +39,6 @@ exercise_cpu_hotplug()
>  }
>  
>  _require_test
> -_require_command "$KILLALL_PROG" "killall"
>  
>  sysfs_cpu_dir="/sys/devices/system/cpu"
>  
> @@ -71,13 +70,17 @@ test "$nr_cpus" -gt 1024 && nr_cpus="$nr_hotplug_cpus"
>  fsstress_args+=(-p $nr_cpus)
>  if [ -n "$SOAK_DURATION" ]; then
>  	test "$SOAK_DURATION" -lt 10 && SOAK_DURATION=10
> -	fsstress_args+=(--duration="$((SOAK_DURATION / 10))")
> +else
> +	# run for 30s per iteration max
> +	SOAK_DURATION=300
>  fi
> +fsstress_args+=(--duration="$((SOAK_DURATION / 10))")
>  
>  nr_ops=$((2500 * TIME_FACTOR))
>  fsstress_args+=(-n $nr_ops)
>  for ((i = 0; i < 10; i++)); do
> -	$FSSTRESS_PROG $FSSTRESS_AVOID -w "${fsstress_args[@]}" >> $seqres.full
> +	_run_fsstress_bg -w "${fsstress_args[@]}"
> +	_wait_for_fsstress
>  	_test_cycle_mount
>  done
>  
> diff --git a/tests/generic/750 b/tests/generic/750
> index dba8021d6..5c54a5c78 100755
> --- a/tests/generic/750
> +++ b/tests/generic/750
> @@ -11,13 +11,12 @@ _begin_fstest auto rw long_rw stress soak smoketest
>  
>  _cleanup()
>  {
> -	cd /
> +	_kill_fsstress
>  	rm -f $runfile
> -	rm -f $tmp.*
>  	kill -9 $trigger_compaction_pid > /dev/null 2>&1
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -
>  	wait > /dev/null 2>&1
> +	rm -f $tmp.*
> +	cd /
>  }
>  
>  # Import common functions.
> @@ -26,7 +25,6 @@ _cleanup()
>  
>  _require_scratch
>  _require_vm_compaction
> -_require_command "$KILLALL_PROG" "killall"
>  
>  # We still deadlock with this test on v6.10-rc2, we need more work.
>  # but the below makes things better.
> @@ -52,7 +50,7 @@ while [ -e $runfile ]; do
>  done &
>  trigger_compaction_pid=$!
>  
> -$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +_run_fsstress "${fsstress_args[@]}"
>  
>  rm -f $runfile
>  wait > /dev/null 2>&1
> diff --git a/tests/generic/753 b/tests/generic/753
> index e427d62d1..f5665320a 100755
> --- a/tests/generic/753
> +++ b/tests/generic/753
> @@ -16,11 +16,11 @@ _begin_fstest shutdown auto log metadata eio recoveryloop attr
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +	_kill_fsstress
>  	_dmerror_unmount
>  	_dmerror_cleanup
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -30,7 +30,6 @@ _cleanup()
>  
>  _require_scratch
>  _require_dm_target error
> -_require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
>  
> @@ -59,8 +58,7 @@ args+=('-f' "setfattr=20")
>  args+=('-f' "attr_set=60")	# sets larger xattrs
>  
>  while _soak_loop_running $((50 * TIME_FACTOR)); do
> -	($FSSTRESS_PROG "${args[@]}" $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4)) >> $seqres.full &) \
> -		> /dev/null 2>&1
> +	_run_fsstress_bg "${args[@]}" -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4))
>  
>  	# purposely include 0 second sleeps to test shutdown immediately after
>  	# recovery
> @@ -73,12 +71,7 @@ while _soak_loop_running $((50 * TIME_FACTOR)); do
>  	# error table helper *without* 'lockfs'.
>  	_dmerror_load_error_table
>  
> -	ps -e | grep fsstress > /dev/null 2>&1
> -	while [ $? -eq 0 ]; do
> -		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -		wait > /dev/null 2>&1
> -		ps -e | grep fsstress > /dev/null 2>&1
> -	done
> +	_kill_fsstress
>  
>  	# Mount again to replay log after loading working table, so we have a
>  	# consistent XFS after test.
> diff --git a/tests/overlay/019 b/tests/overlay/019
> index ae026604d..b20b7ae52 100755
> --- a/tests/overlay/019
> +++ b/tests/overlay/019
> @@ -9,6 +9,22 @@
>  . ./common/preamble
>  _begin_fstest auto stress
>  
> +# This nests multiple background fsstress instances, so we have to
> +# do some magic with _FSSTRESS_PID here.
> +_cleanup()
> +{
> +	if [ -n "$fsstress_pid_1" ]; then
> +		 FSTRESS_PID=$fsstress_pid_1
> +		_kill_fsstress
> +	fi
> +	if [ -n "$fsstress_pid_2" ]; then
> +		 FSTRESS_PID=$fsstress_pid_2
> +		_kill_fsstress
> +	fi
> +	cd /
> +	rm -f tmp.*
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  
> @@ -28,29 +44,31 @@ d_low=$lowerdir/fsstress
>  d_top=$SCRATCH_MNT/fsstress
>  mkdir -p $d_low $d_top
>  
> -echo $FSSTRESS_PROG -s 42 -d $d_low -p 4 -n 1000 -l100 -v > $seqres.full.1
> -$FSSTRESS_PROG -s 42 -d $d_low -p 4 -n 1000 -l100 -v >> $seqres.full.1 2>&1 &
> +echo fsstress -s 42 -d $d_low -p 4 -n 1000 -l100 -v >> $seqres.full
> +_run_fsstress_bg -s 42 -d $d_low -p 4 -n 1000 -l100 -v
> +fsstress_pid_1=$_FSSTRESS_PID
>  
> -echo $FSSTRESS_PROG -s 42 -d $d_top -p 4 -n 1000 -l100 -v > $seqres.full.2
> -$FSSTRESS_PROG -s 42 -d $d_top -p 4 -n 1000 -l100 -v >> $seqres.full.2 2>&1 &
> +echo fsstress -s 42 -d $d_top -p 4 -n 1000 -l100 -v >> $seqres.full
> +_run_fsstress_bg -s 42 -d $d_top -p 4 -n 1000 -l100 -v
> +fsstress_pid_2=$_FSTRESS_PID
> +unset _FSSTRESS_PID
>  
>  ret=0
> -if ! wait %1; then
> -	echo "--------------------------------------"       >>$seqres.full.1
> -	echo "fsstress on lower directory returned $? - see $seqres.full.1"
> -	echo "--------------------------------------"       >>$seqres.full.1
> +if ! wait $fsstress_pid_1; then
> +	echo "--------------------------------------"       >>$seqres.full
> +	echo "fsstress on lower directory returned $? - see $seqres.full"
> +	echo "--------------------------------------"       >>$seqres.full
>  	ret=1
>  fi
> +unset fsstress_pid_1
>  
> -if ! wait %2; then
> -	echo "--------------------------------------"       >>$seqres.full.2
> -	echo "fsstress on overlay directory returned $? - see $seqres.full.2"
> -	echo "--------------------------------------"       >>$seqres.full.2
> +if ! wait $fsstress_pid_2; then
> +	echo "--------------------------------------"       >>$seqres.full
> +	echo "fsstress on overlay directory returned $? - see $seqres.full"
> +	echo "--------------------------------------"       >>$seqres.full
>  	ret=1
>  fi
> -
> -cat $seqres.full.1 $seqres.full.2 > $seqres.full
> -rm $seqres.full.1 $seqres.full.2
> +unset fsstress_pid_2
>  
>  if [ "$ret" -eq 1 ]; then
>  	status=1
> diff --git a/tests/overlay/021 b/tests/overlay/021
> index 95a9ada5d..ee5a51007 100755
> --- a/tests/overlay/021
> +++ b/tests/overlay/021
> @@ -33,8 +33,8 @@ d_low=$lowerdir/$testdir
>  mkdir -p $d_low
>  
>  # Create 4K empty files in 4 directories
> -echo $FSSTRESS_PROG -d $d_low -p 4 -z -f creat=1 -n 1024 -v >> $seqres.full
> -$FSSTRESS_PROG -d $d_low -p 4 -z -f creat=1 -n 1024 -v >> $seqres.full 2>&1
> +echo fsstress -d $d_low -p 4 -z -f creat=1 -n 1024 -v >> $seqres.full
> +_run_fsstress -d $d_low -p 4 -z -f creat=1 -n 1024 -v
>  echo "--------------------------------------"       >> $seqres.full
>  echo "Created 1K files in lower directory.  "       >> $seqres.full
>  
> @@ -91,9 +91,9 @@ echo "Go team truncate!!                    "       >> $seqres.full
>  # Give team 'touch' a 1 second head start.
>  # Team 'truncate' players should catch up after few copy up bombs.
>  sleep 1
> -$FSSTRESS_PROG -d $d_top -p 4 -z -f creat=1 -n 1024 -v >> $seqres.full &
> +_run_fsstress -d $d_top -p 4 -z -f creat=1 -n 1024 -v
>  
> -wait %1 %2 %3 %4 %5
> +wait %1 %2 %3 %4
>  
>  echo "Silence is golden"
>  status=0
> diff --git a/tests/xfs/006 b/tests/xfs/006
> index 50b36947d..20fd104bc 100755
> --- a/tests/xfs/006
> +++ b/tests/xfs/006
> @@ -13,9 +13,10 @@ _begin_fstest auto quick mount eio
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	_kill_fsstress
> +	_dmerror_cleanup
>  	cd /
>  	rm -f $tmp.*
> -	_dmerror_cleanup
>  }
>  
>  # Import common functions.
> @@ -45,7 +46,7 @@ fi
>  # start a metadata-intensive workload, but no data allocation operation.
>  # Because uncompleted new space allocation I/Os may cause XFS to shutdown
>  # after loading error table.
> -$FSSTRESS_PROG -z -n 5000 -p 10 \
> +_run_fsstress -z -n 5000 -p 10 \
>  	       -f creat=10 \
>  	       -f resvsp=1 \
>  	       -f truncate=1 \
> @@ -57,7 +58,7 @@ $FSSTRESS_PROG -z -n 5000 -p 10 \
>  	       -f unlink=1 \
>  	       -f symlink=1 \
>  	       -f rename=1 \
> -	       -d $SCRATCH_MNT/fsstress >> $seqres.full 2>&1
> +	       -d $SCRATCH_MNT/fsstress
>  
>  # Loading error table without "--nolockfs" option. Because "--nolockfs"
>  # won't freeze fs, then some running I/Os may cause XFS to shutdown
> diff --git a/tests/xfs/011 b/tests/xfs/011
> index df967f098..ed69879c5 100755
> --- a/tests/xfs/011
> +++ b/tests/xfs/011
> @@ -26,8 +26,7 @@ _cleanup()
>  {
>  	# Make sure $SCRATCH_MNT is unfreezed
>  	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> -	$KILLALL_PROG -9 fsstress 2>/dev/null
> -	wait
> +	_kill_fsstress
>  	cd /
>  	rm -f $tmp.*
>  }
> @@ -102,8 +101,7 @@ _scratch_mount
>  
>  _check_scratch_log_state
>  
> -$FSSTRESS_PROG -d $SCRATCH_MNT/fsstress -n 9999999 -p 2 -S t \
> -	>> $seqres.full 2>&1 &
> +_run_fsstress_bg -d $SCRATCH_MNT/fsstress -n 9999999 -p 2 -S t
>  
>  iters=5
>  while [ $iters -gt 0 ]; do
> @@ -112,9 +110,7 @@ while [ $iters -gt 0 ]; do
>  	iters=$((iters - 1))
>  done
>  
> -$KILLALL_PROG $FSSTRESS_PROG
> -wait
> -
> +_kill_fsstress
>  _scratch_unmount
>  
>  status=0
> diff --git a/tests/xfs/013 b/tests/xfs/013
> index f4f406aa9..c68c6ad85 100755
> --- a/tests/xfs/013
> +++ b/tests/xfs/013
> @@ -16,16 +16,6 @@ _begin_fstest auto metadata stress
>  # Import common functions.
>  . ./common/filter
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	$KILLALL_PROG -9 fsstress 2>/dev/null
> -	wait
> -	cd /
> -	_scratch_unmount 2>/dev/null
> -	rm -f $tmp.*
> -}
> -
>  filter_enospc() {
>  	sed -e '/^.*No space left on device.*/d'
>  }
> @@ -103,8 +93,7 @@ _create $SCRATCH_MNT/dir1 $COUNT
>  _cleaner $SCRATCH_MNT $LOOPS $MINDIRS &
>  
>  # start a background stress workload on the fs
> -$FSSTRESS_PROG -d $SCRATCH_MNT/fsstress -n 9999999 -p 2 -S t \
> -	>> $seqres.full 2>&1 &
> +_run_fsstress_bg -d $SCRATCH_MNT/fsstress -n 9999999 -p 2 -S t
>  
>  # Each cycle clones the current directory and makes a random file replacement
>  # pass on the new directory. The directory is copied to the next using hard
> @@ -127,8 +116,7 @@ do
>  	_rand_replace $SCRATCH_MNT/dir$((i+1)) $COUNT
>  done
>  
> -$KILLALL_PROG fsstress
> -wait
> +_kill_fsstress
>  
>  # clean out the competing fsstress allocations, then everything else
>  rm -rf $SCRATCH_MNT/fsstress
> diff --git a/tests/xfs/017 b/tests/xfs/017
> index c40d9cf09..263ecc753 100755
> --- a/tests/xfs/017
> +++ b/tests/xfs/017
> @@ -9,15 +9,6 @@
>  . ./common/preamble
>  _begin_fstest mount auto quick stress
>  
> -_register_cleanup "_cleanup; rm -f $tmp.*"
> -
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -    echo "*** unmount"
> -    _scratch_unmount 2>/dev/null
> -}
> -
>  # Import common functions.
>  . ./common/filter
>  
> @@ -41,8 +32,8 @@ echo "*** test"
>  for l in 0 1 2 3 4
>  do
>          echo "    *** test $l"
> -	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -n 1000 $FSSTRESS_AVOID`
> -        $FSSTRESS_PROG  $FSSTRESS_ARGS >>$seqres.full
> +	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -n 1000`
> +        _run_fsstress $FSSTRESS_ARGS
>  
>          _try_scratch_mount -o remount,ro \
>              || _fail "remount ro failed"
> diff --git a/tests/xfs/017.out b/tests/xfs/017.out
> index 2d11c9492..e61793df1 100644
> --- a/tests/xfs/017.out
> +++ b/tests/xfs/017.out
> @@ -7,4 +7,3 @@ QA output created by 017
>      *** test 3
>      *** test 4
>  *** done
> -*** unmount
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index 75edf0e9c..1ecc02fe0 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -50,7 +50,7 @@ while [ $SECTORSIZE -le $PAGESIZE ]; do
>  		fi
>  		_scratch_mount
>  		# light population of the fs
> -		$FSSTRESS_PROG -n 100 -d $SCRATCH_MNT >> $seqres.full 2>&1
> +		_run_fsstress -n 100 -d $SCRATCH_MNT
>  		_scratch_unmount
>  
>  		# Test "duplicate" copy at first, if $XFS_COPY_PROG won't do it.
> diff --git a/tests/xfs/049 b/tests/xfs/049
> index 668ac3745..4163a144f 100755
> --- a/tests/xfs/049
> +++ b/tests/xfs/049
> @@ -68,7 +68,7 @@ mount -t xfs -o loop $SCRATCH_MNT/test.xfs $SCRATCH_MNT/test >> $seqres.full 2>&
>      || _fail "!!! failed to loop mount xfs"
>  
>  _log "stress"
> -$FSSTRESS_PROG -d $SCRATCH_MNT/test -n 1000 $FSSTRESS_AVOID >> $seqres.full 2>&1 \
> +_run_fsstress -d $SCRATCH_MNT/test -n 1000 \
>      || _fail "!!! stress failed"
>  
>  _log "clean"
> @@ -88,7 +88,7 @@ mount -t ext2 -o loop $SCRATCH_MNT/test/test.ext2 $SCRATCH_MNT/test2 >> $seqres.
>      || _fail "!!! failed to loop mount xfs"
>  
>  _log "stress ext2 on xfs via loop"
> -$FSSTRESS_PROG -d $SCRATCH_MNT/test2 -n 1000 $FSSTRESS_AVOID >> $seqres.full 2>&1 \
> +_run_fsstress -d $SCRATCH_MNT/test2 -n 1000 \
>      || _fail "!!! stress ext2 failed"
>  
>  _log "clean"
> diff --git a/tests/xfs/051 b/tests/xfs/051
> index 43fee4c45..bb9c36da8 100755
> --- a/tests/xfs/051
> +++ b/tests/xfs/051
> @@ -11,15 +11,6 @@
>  . ./common/preamble
>  _begin_fstest shutdown auto log metadata
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
> -	_scratch_unmount > /dev/null 2>&1
> -}
> -
>  # Import common functions.
>  . ./common/dmflakey
>  
> @@ -37,11 +28,10 @@ _scratch_mount
>  
>  # Start a workload and shutdown the fs. The subsequent mount will require log
>  # recovery.
> -$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT &>> $seqres.full &
> +_run_fsstress_bg -n 9999 -p 2 -w -d $SCRATCH_MNT
>  sleep 5
>  _scratch_shutdown -f
> -$KILLALL_PROG -q $FSSTRESS_PROG
> -wait
> +_kill_fsstress
>  _scratch_unmount
>  
>  # Initialize a dm-flakey device that will pass I/Os for 5s and fail thereafter.
> diff --git a/tests/xfs/057 b/tests/xfs/057
> index f1c947795..62eb8b93c 100755
> --- a/tests/xfs/057
> +++ b/tests/xfs/057
> @@ -26,12 +26,12 @@ _begin_fstest auto log recoveryloop
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
>  	[ -e /sys/fs/xfs/$sdev/errortag/log_item_pin ] &&
>  		echo 0 > /sys/fs/xfs/$sdev/errortag/log_item_pin
> +	_kill_fsstress
>  	wait > /dev/null 2>&1
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -53,7 +53,7 @@ _scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # populate the fs with some data and cycle the mount to reset the log head/tail
> -$FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=1 -p 4 -n 100000 >> $seqres.full
> +_run_fsstress -d $SCRATCH_MNT -z -fcreat=1 -p 4 -n 100000
>  _scratch_cycle_mount || _fail "cycle mount failed"
>  
>  # Pin the tail and start a file removal workload. File removal tends to
> diff --git a/tests/xfs/077 b/tests/xfs/077
> index 4a4ac4702..3d8ecd9f6 100755
> --- a/tests/xfs/077
> +++ b/tests/xfs/077
> @@ -54,7 +54,7 @@ ORIG_UUID=`_scratch_xfs_db -c "uuid" | awk '{print $NF}'`
>  
>  _scratch_mount
>  # Put some stuff on the fs
> -$FSSTRESS_PROG -d $SCRATCH_MNT -n 100 -p 4 >> $seqres.full 2>&1
> +_run_fsstress -d $SCRATCH_MNT -n 100 -p 4
>  _scratch_unmount
>  
>  # Can xfs_db change it?
> diff --git a/tests/xfs/079 b/tests/xfs/079
> index 46a15ed78..794d2db49 100755
> --- a/tests/xfs/079
> +++ b/tests/xfs/079
> @@ -17,19 +17,9 @@
>  . ./common/preamble
>  _begin_fstest shutdown auto log quick
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -	wait > /dev/null 2>&1
> -}
> -
>  # Import common functions.
>  . ./common/log
>  
> -
>  # Modify as appropriate.
>  _require_scratch
>  _require_v2log
> @@ -43,10 +33,10 @@ _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount "-o logbsize=32k"
>  
>  # Run a workload to dirty the log, wait a bit and shutdown the fs.
> -$FSSTRESS_PROG -d $SCRATCH_MNT -p 4 -n 99999999 >> $seqres.full 2>&1 &
> +_run_fsstress_bg -d $SCRATCH_MNT -p 4 -n 99999999
>  sleep 10
>  _scratch_shutdown -f
> -wait
> +_wait_for_fsstress
>  
>  # Remount with a different log buffer size. Going from 32k to 64k increases the
>  # log record extended header count, as the log record header can only handle 32k
> diff --git a/tests/xfs/104 b/tests/xfs/104
> index 7f11f89a5..cd625d6b7 100755
> --- a/tests/xfs/104
> +++ b/tests/xfs/104
> @@ -40,9 +40,8 @@ _stress_scratch()
>  	procs=3
>  	nops=1000
>  	# -w ensures that the only ops are ones which cause write I/O
> -	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
> -	    -n $nops $FSSTRESS_AVOID`
> -	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1 &
> +	args=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs -n $nops`
> +	_run_fsstress_bg $args
>  }
>  
>  _require_scratch
> @@ -73,14 +72,11 @@ for i in `seq 125 -1 90`; do
>  	break
>  done
>  
> -#
>  # Grow the filesystem while actively stressing it...
> -# Kick off more stress threads on each iteration, grow; repeat.
> -#
>  while [ $size -le $endsize ]; do
>  	echo "*** stressing filesystem"
>  	echo "*** stressing a ${sizeb} block filesystem" >> $seqres.full
> -	_stress_scratch
> +	_stress_scratch 
>  	sleep 1
>  	size=`expr $size + $incsize`
>  	sizeb=`expr $size / $dbsize`	# in data blocks
> @@ -92,10 +88,8 @@ while [ $size -le $endsize ]; do
>  	[ `expr $size % $modsize` -eq 0 ] && wait	# every 4th iteration
>  	echo AGCOUNT=$agcount | tee -a $seqres.full
>  	echo && echo >> $seqres.full
> +	_wait_for_fsstress
>  done
> -wait	# stop for any remaining stress processes
> -
> -_scratch_unmount
>  
>  status=0
>  exit
> diff --git a/tests/xfs/137 b/tests/xfs/137
> index dfc653573..d97942bf6 100755
> --- a/tests/xfs/137
> +++ b/tests/xfs/137
> @@ -29,7 +29,7 @@ _scratch_xfs_db -x -c "logformat -c 3" >> $seqres.full 2>&1
>  
>  # do some work on the fs to update metadata LSNs
>  _scratch_mount
> -$FSSTRESS_PROG -d $SCRATCH_MNT -n 999 -p 4 -w >> $seqres.full 2>&1
> +_run_fsstress -d $SCRATCH_MNT -n 999 -p 4 -w
>  _scratch_unmount
>  
>  # Reformat to the current cycle and try to mount. This fails in most cases
> diff --git a/tests/xfs/141 b/tests/xfs/141
> index 5e9067e24..b630ba10d 100755
> --- a/tests/xfs/141
> +++ b/tests/xfs/141
> @@ -14,19 +14,9 @@
>  . ./common/preamble
>  _begin_fstest auto log metadata
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -	wait > /dev/null 2>&1
> -}
> -
>  # Import common functions.
>  . ./common/inject
>  
> -
>  # Modify as appropriate.
>  _require_xfs_io_error_injection "log_bad_crc"
>  _require_scratch
> @@ -49,7 +39,7 @@ while [ $nr_times -gt 0 ]; do
>  
>  	# Run fsstress until the filesystem shuts down. It will shut down
>  	# automatically when error injection triggers.
> -	$FSSTRESS_PROG -d $SCRATCH_MNT -p 4 -n 999999 >> $seqres.full 2>&1
> +	_run_fsstress -d $SCRATCH_MNT -p 4 -n 999999
>  
>  	# Verify that we can remount the fs. Log recovery should handle the torn
>  	# write.
> diff --git a/tests/xfs/158 b/tests/xfs/158
> index 3c4e60f0e..89bf8c851 100755
> --- a/tests/xfs/158
> +++ b/tests/xfs/158
> @@ -31,7 +31,7 @@ _scratch_mkfs -m crc=1,inobtcount=0 >> $seqres.full
>  _scratch_mount
>  
>  mkdir $SCRATCH_MNT/stress
> -$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full
> +_run_fsstress -d $SCRATCH_MNT/stress -n 1000
>  echo moo > $SCRATCH_MNT/urk
>  
>  _scratch_unmount
> @@ -56,7 +56,7 @@ _check_scratch_xfs_features NEEDSREPAIR INOBTCNT
>  
>  echo "Filesystem should be usable again"
>  _scratch_mount
> -$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full
> +_run_fsstress -d $SCRATCH_MNT/stress -n 1000
>  _scratch_unmount
>  _check_scratch_fs
>  _check_scratch_xfs_features INOBTCNT
> diff --git a/tests/xfs/167 b/tests/xfs/167
> index f9da261db..5ef2aa2ea 100755
> --- a/tests/xfs/167
> +++ b/tests/xfs/167
> @@ -9,20 +9,12 @@
>  . ./common/preamble
>  _begin_fstest rw metadata auto stress prealloc
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	$KILLALL_PROG -r -q -TERM fsstress 2> /dev/null
> -	wait	# ensures all fsstress processes died
> -}
> -
>  workout()
>  {
>  	procs=100
>  	nops=15000
> -	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p $procs -n $nops \
> -	    $FSSTRESS_AVOID`
> -	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full &
> +	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p $procs -n $nops`
> +	_run_fsstress_bg $FSSTRESS_ARGS
>  	sleep 2
>  }
>  
> @@ -52,6 +44,8 @@ rm -f $TEST_FILE
>  workout
>  $TEST_PROG $LOOPS $TEST_FILE
>  
> +_kill_fsstress
> +
>  echo "     *** test done"
>  
>  status=0
> diff --git a/tests/xfs/168 b/tests/xfs/168
> index f187a336f..098e0c86a 100755
> --- a/tests/xfs/168
> +++ b/tests/xfs/168
> @@ -38,9 +38,8 @@ stress_scratch()
>  	local procs=3
>  	local nops=1000
>  	# -w ensures that the only ops are ones which cause write I/O
> -	local FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w \
> -		-p $procs -n $nops $FSSTRESS_AVOID`
> -	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1
> +	local args=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs -n $nops`
> +	_run_fsstress_bg $args
>  }
>  
>  _require_scratch_xfs_shrink
> @@ -73,7 +72,7 @@ while [ $totalcount -gt 0 ]; do
>  	decsize=`expr  41 \* 1048576 + 1 + $RANDOM \* $RANDOM % 1048576`
>  
>  	while [ $size -gt $endsize ]; do
> -		stress_scratch &
> +		stress_scratch
>  		sleep 1
>  
>  		decb=`expr $decsize / $dbsize`    # in data blocks
> @@ -95,6 +94,7 @@ while [ $totalcount -gt 0 ]; do
>  		. $tmp.growfs
>  
>  		size=`expr $dblocks \* $dbsize`
> +		_kill_fsstress
>  		_scratch_unmount
>  		_scratch_xfs_repair -n >> $seqres.full 2>&1 || \
>  			_fail "xfs_repair failed with shrinking $sizeb"
> diff --git a/tests/xfs/264 b/tests/xfs/264
> index 109fecd1c..a6e816d3c 100755
> --- a/tests/xfs/264
> +++ b/tests/xfs/264
> @@ -55,7 +55,7 @@ do_test()
>  	# start a metadata-intensive workload, but no data allocation operation.
>  	# Because uncompleted new space allocation I/Os may cause XFS to shutdown
>  	# after loading error table.
> -	$FSSTRESS_PROG -z -n 5000 -p 10 \
> +	_run_fsstress -z -n 5000 -p 10 \
>  		       -f creat=10 \
>  		       -f resvsp=1 \
>  		       -f truncate=1 \
> @@ -67,7 +67,7 @@ do_test()
>  		       -f unlink=1 \
>  		       -f symlink=1 \
>  		       -f rename=1 \
> -		       -d $SCRATCH_MNT/fsstress >> $seqres.full 2>&1
> +		       -d $SCRATCH_MNT/fsstress
>  
>  	# Loading error table without "--nolockfs" option. Because "--nolockfs"
>  	# won't freeze fs, then some running I/Os may cause XFS to shutdown
> diff --git a/tests/xfs/270 b/tests/xfs/270
> index 3744df5a9..d3bce386a 100755
> --- a/tests/xfs/270
> +++ b/tests/xfs/270
> @@ -80,7 +80,7 @@ if [ $? -ne 0 ]; then
>  else
>  	# no hang/panic is fine
>  	cat $SCRATCH_MNT/testfile > /dev/null
> -	$FSSTRESS_PROG -d $SCRATCH_MNT -p 4 -n 400 >>$seqres.full 2>&1
> +	_run_fsstress -d $SCRATCH_MNT -p 4 -n 400
>  fi
>  
>  # remount as rw, kernel should reject it
> diff --git a/tests/xfs/297 b/tests/xfs/297
> index 2c5b03c5c..66c5d0cc7 100755
> --- a/tests/xfs/297
> +++ b/tests/xfs/297
> @@ -16,8 +16,7 @@ _cleanup()
>  {
>  	# Make sure $SCRATCH_MNT is unfreezed
>  	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> -	$KILLALL_PROG -q -9 $FSSTRESS_PROG
> -	wait
> +	_kill_fsstress
>  	cd /
>  	rm -f $tmp.*
>  }
> @@ -37,7 +36,7 @@ _scratch_mount
>  STRESS_DIR="$SCRATCH_MNT/testdir"
>  mkdir -p $STRESS_DIR
>  
> -$FSSTRESS_PROG -d $STRESS_DIR -n 100 -p 1000 $FSSTRESS_AVOID >>$seqres.full &
> +_run_fsstress_bg -d $STRESS_DIR -n 1000 -p 1000 $FSSTRESS_AVOID
>  
>  # Freeze/unfreeze file system randomly
>  echo "Start freeze/unfreeze randomly" | tee -a $seqres.full
> @@ -60,8 +59,7 @@ while [ $LOOP -gt 0 ];do
>  	let LOOP=$LOOP-1
>  done
>  echo "Test done" | tee -a $seqres.full
> -$KILLALL_PROG -q $FSSTRESS_PROG
> -wait
> +_kill_fsstress
>  
>  status=0
>  exit
> diff --git a/tests/xfs/305 b/tests/xfs/305
> index 0ad3ef7fb..6371ed8a6 100755
> --- a/tests/xfs/305
> +++ b/tests/xfs/305
> @@ -4,7 +4,7 @@
>  #
>  # FS QA Test No. 305
>  #
> -# Test to verify that turn group/project quotas off while fstress and
> +# Test to verify that turn group/project quotas off while fsstress and
>  # user quotas are left on.
>  #
>  . ./common/preamble
> @@ -18,7 +18,6 @@ _begin_fstest auto quota
>  
>  _require_scratch
>  _require_xfs_quota
> -_require_command "$KILLALL_PROG" killall
>  
>  _scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
>  
> @@ -33,12 +32,11 @@ _exercise()
>  	_qmount
>  	mkdir -p $QUOTA_DIR
>  
> -	$FSSTRESS_PROG -d $QUOTA_DIR -n 1000000 -p 100 $FSSTRESS_AVOID >>$seqres.full &
> +	_run_fsstress_bg -d $QUOTA_DIR -n 1000000 -p 100
>  	sleep 10
>  	$XFS_QUOTA_PROG -x -c "disable -$type" $SCRATCH_DEV
>  	sleep 5
> -	$KILLALL_PROG -q $FSSTRESS_PROG
> -	wait
> +	_kill_fsstress
>  }
>  
>  echo "*** turn off group quotas"
> diff --git a/tests/xfs/442 b/tests/xfs/442
> index 77d08fda5..5cbd8dd19 100755
> --- a/tests/xfs/442
> +++ b/tests/xfs/442
> @@ -12,14 +12,6 @@
>  . ./common/preamble
>  _begin_fstest auto stress clone quota
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -}
> -
>  # Import common functions.
>  . ./common/quota
>  . ./common/filter
> @@ -72,7 +64,7 @@ _scratch_mount >> $seqres.full 2>&1
>  
>  nr_cpus=$((LOAD_FACTOR * 4))
>  nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
> -$FSSTRESS_PROG $FSSTRESS_AVOID -w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus >> $seqres.full
> +_run_fsstress -w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus
>  
>  echo "Check quota before remount"
>  check_quota_du_blocks
> diff --git a/tests/xfs/538 b/tests/xfs/538
> index 57113d341..f858cadc3 100755
> --- a/tests/xfs/538
> +++ b/tests/xfs/538
> @@ -46,7 +46,7 @@ echo "Inject bmap_alloc_minlen_extent error tag"
>  _scratch_inject_error bmap_alloc_minlen_extent 1
>  
>  echo "Execute fsstress"
> -$FSSTRESS_PROG -d $SCRATCH_MNT \
> +_run_fsstress -d $SCRATCH_MNT \
>  		$(_scale_fsstress_args -p 75 -n 1000) \
>  		-f bulkstat=0 \
>  		-f bulkstat1=0 \
> @@ -61,7 +61,7 @@ $FSSTRESS_PROG -d $SCRATCH_MNT \
>  		-f readv=0 \
>  		-f stat=0 \
>  		-f aread=0 \
> -		-f dread=0 >> $seqres.full
> +		-f dread=0
>  
>  # success, all done
>  status=0
> diff --git a/tests/xfs/609 b/tests/xfs/609
> index c23b6893d..88dc3c683 100755
> --- a/tests/xfs/609
> +++ b/tests/xfs/609
> @@ -18,21 +18,12 @@ _stress_scratch()
>  	nops=999999
>  	# -w ensures that the only ops are ones which cause write I/O
>  	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
> -	    -n $nops $FSSTRESS_AVOID`
> -	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1 &
> +	    -n $nops`
> +	_run_fsstress_bg $FSSTRESS_ARGS >> $seqres.full 2>&1
>  }
>  
>  _require_scratch
>  _require_command "$XFS_GROWFS_PROG" xfs_growfs
> -_require_command "$KILLALL_PROG" killall
> -
> -_cleanup()
> -{
> -	$KILLALL_ALL fsstress > /dev/null 2>&1
> -	wait
> -	cd /
> -	rm -f $tmp.*
> -}
>  
>  _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
>  . $tmp.mkfs	# extract blocksize and data size for scratch device
> @@ -63,12 +54,7 @@ while [ $size -le $endsize ]; do
>  
>  	sleep $((RANDOM % 3))
>  	_scratch_shutdown
> -	ps -e | grep fsstress > /dev/null 2>&1
> -	while [ $? -eq 0 ]; do
> -		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -		wait > /dev/null 2>&1
> -		ps -e | grep fsstress > /dev/null 2>&1
> -	done
> +	_kill_fsstress
>  	_scratch_cycle_mount
>  done > /dev/null 2>&1
>  wait	# stop for any remaining stress processes
> diff --git a/tests/xfs/610 b/tests/xfs/610
> index 23fbd8585..8610b912c 100755
> --- a/tests/xfs/610
> +++ b/tests/xfs/610
> @@ -18,22 +18,13 @@ _stress_scratch()
>  	nops=999999
>  	# -w ensures that the only ops are ones which cause write I/O
>  	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
> -	    -n $nops $FSSTRESS_AVOID`
> -	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1 &
> +	    -n $nops`
> +	_run_fsstress_bg $FSSTRESS_ARGS >> $seqres.full 2>&1
>  }
>  
>  _require_scratch
>  _require_realtime
>  _require_command "$XFS_GROWFS_PROG" xfs_growfs
> -_require_command "$KILLALL_PROG" killall
> -
> -_cleanup()
> -{
> -	$KILLALL_ALL fsstress > /dev/null 2>&1
> -	wait
> -	cd /
> -	rm -f $tmp.*
> -}
>  
>  _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
>  . $tmp.mkfs	# extract blocksize and data size for scratch device
> @@ -65,12 +56,7 @@ while [ $size -le $endsize ]; do
>  
>  	sleep $((RANDOM % 3))
>  	_scratch_shutdown
> -	ps -e | grep fsstress > /dev/null 2>&1
> -	while [ $? -eq 0 ]; do
> -		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> -		wait > /dev/null 2>&1
> -		ps -e | grep fsstress > /dev/null 2>&1
> -	done
> +	_kill_fsstress
>  	_scratch_cycle_mount
>  done > /dev/null 2>&1
>  wait	# stop for any remaining stress processes
> -- 
> 2.45.2
> 
> 

