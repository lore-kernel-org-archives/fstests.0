Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342CD202C23
	for <fstests@vger.kernel.org>; Wed,  4 Dec 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335488; cv=none; b=PXSTsD8zpBeg64wZjSJ2bvT13S/+dC+THX5R2dLqMxEKoLdjCBr5gciQjYqibA47xUOml187Og5n0cdnPTgFZdDjyDDKXElxR4BR5qsQtDdUPgS2iZZWq8C0r88aC57ThzVfo+tB2I8wRJoNdpI91Oz5VatkUD7ADwmb/RsT9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335488; c=relaxed/simple;
	bh=SvEoHC+n5ftb3UWxlDIcUUVUwwSCoiJK7PId6yviEwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyGKa0Ek/ikcS9RGB8YIVswAx+LZIli1mcHzbSl9Nf8GV0gSPLWaTLq8AgPLPxtxf7H6d9SzYk12kPtFilKknkwiI1k4SkXgi0T+4SXjSqQdpKfJjlDSpq05r6ahzinMFqvzYp128LYgGDW8IAlqpSDO0y0okjtAcwgiNkMXyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6Hw2nUp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Hw2nUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733335484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haoxRFTq53VT+6zrAXyWj/xdEvEkRXuMzfO9PwTv2tA=;
	b=S6Hw2nUptRQ/pb3KfPfgI6wjqnkbuc1mciSJ9TUwqxjJg3d2CKqxfpYW1Ll2ocNdcsUNLj
	YN7mslBFtkTGLa+/zo4jqbniqkd52HFSvLbLM/HpHKmcOWkjUgWRkriCFZKkeaCag0RJcH
	b4psNnD7AUS9Q+CpInbR0pdHB/cmCbA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-Grvvlh5lNciPXvnBpfzFfg-1; Wed, 04 Dec 2024 13:04:42 -0500
X-MC-Unique: Grvvlh5lNciPXvnBpfzFfg-1
X-Mimecast-MFC-AGG-ID: Grvvlh5lNciPXvnBpfzFfg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21547722a22so332805ad.2
        for <fstests@vger.kernel.org>; Wed, 04 Dec 2024 10:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335481; x=1733940281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haoxRFTq53VT+6zrAXyWj/xdEvEkRXuMzfO9PwTv2tA=;
        b=DWWYu0qD3KzDQURBobQ96NiSIVS1VWpZ80XtSpQfyOn5WNgZLvD9w50jt8iEfIWbvm
         aj96ziLSTroKH1BGay5p/dfDxj888jc1s6sDJqIJaQWBxr6bJ0EU4UY1f4WUSkn0diFg
         Su5A49pSDIh+xbwPmNf6J6qKmMrV0/BNVGvl2qMHfY9I7zbcjl92tgY2EKzAijben4t1
         FcKQ7PQq05S6pOJELHx+pVizfFgUksMId3XSY6gI2blBT6iKK+Catxtml0Fpi0hud6mn
         LMxlzoIf9xTluRsuzZABdPhalEn34IF5IBqJZ1orMVnZbxoiqfP2DeXgzJem8JQSTeBs
         wpNw==
X-Gm-Message-State: AOJu0YyLG2ZsZg8RoqbsWLV2x4Mnoax/DqYbAIK0TQQk7SF4HC/KEQKT
	vAi4OBzsqQM8jK7OfcPpk4FAYsgPXCudxoyACwx28XHH/qiABnX55cDgcrXutUxpBfGnoL3+qtf
	tmDlHC5xUvoGvQ6++/6JleoPWYXED9ef+UMa6g8MkULNbHPcFgkqojD4lbgQ/Fet0OA==
X-Gm-Gg: ASbGncvSs5M/4yWXQV8H7EU9R6N65xMuJM2j66XsVJnV1t2ONuJfwqQsrcUCTov1Izs
	iH6BzxVpWEqA0FDJOZx5hytWDwgkH6Vczsw/aM/TbtOILMI67Joo6K77wQJeAuBRUufp//C+MqD
	xDMDdBHTlwFcDZXwKmaA+9LQSyxefMy9OUS2uMthcV5VckZ7M+yJHm4B5LoUewJybHTuRETK4YX
	pgpGomn9W4elqO2jn7sziFRCY/hz4U04IS/rdVT/k/s8xqaQJtrvDpBWt7opA+ixAPwo6R5fVro
	Rlym07YeCdHnhHc=
X-Received: by 2002:a17:903:22cf:b0:212:615f:c1 with SMTP id d9443c01a7336-215bd1c9d93mr101462075ad.14.1733335480517;
        Wed, 04 Dec 2024 10:04:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxKjAKXkJAkRu2QxdxJQf853mSgJsnuT+Qg90mUKggu8fkpievY5pgC5GVe72vs5KlncKZxw==
X-Received: by 2002:a17:903:22cf:b0:212:615f:c1 with SMTP id d9443c01a7336-215bd1c9d93mr101461065ad.14.1733335479449;
        Wed, 04 Dec 2024 10:04:39 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154e33e424sm88830845ad.144.2024.12.04.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:04:38 -0800 (PST)
Date: Thu, 5 Dec 2024 02:04:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <20241204180435.qequx4dbnhz3a2bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

Hi Dave,

The $dedup_pids is a "while loop" bash process, it isn't the $DUPEREMOVE_PROG
process itself. From my testing, this change might cause g/561 keep waiting
$DUPEREMOVE_PROG processes forever, as $DUPEREMOVE_PROG not always be killed
properly.

I'm wondering if you hope to do "pkill $DUPEREMOVE_PROG" directly? Or you'd
like to copy $DUPEREMOVE_PROG to $TEST_DIR/${othername}_duperemove, then
pkill ${othername}_duperemove ?

Thanks,
Zorro

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

