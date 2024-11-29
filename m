Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482C45C14
	for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732853045; cv=none; b=XDOzsWPopWeTXDqWuwBbuoYY5sSzlfff89IDi0dyhB+SVqKBo+o9el3/qK02GxkVcw1mvBOlO3UFepkgqfmFxeFis826PEbU5xDlDIzGT5zRBfHGh/w0nrdg/yqsljHQJNfGAK0PpzUs1Q9pQqKXqZY/7yeyPtF+laIISkT0NFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732853045; c=relaxed/simple;
	bh=eNx4CYCYsTB4YNiU/swQa+4hpn2C3vDQBHKoJtvBtog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMgyZGGg267xGUvzPe0sy26Z3pKpUFM4E6oxoWZ9Z5AzlAVRuFrntYBQpWoB3Z6j4hYkCjQC65YQX7EYTU2GZM99elF5rrB7Ggai5HDll1ihGQ1ZoR5HI7hZ4T2OClL1TaDfD1+DT+639lpnetRoz76S72Lc9d52D2d4cbCi8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkglD+7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkglD+7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732853042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xD6tOHNqd6IcY3bJQ8SBVOWAuW4S8Lz7pt5hmnr0F9s=;
	b=KkglD+7tvWSI6cnbZ7roTKuJzgh2/dr9aKemmyTmGjoEBnI8zC/udPJfMeJjwqad8xQEGd
	KpLTAbKSBW54/4QnxwXgAN4cTtW2YAp5DxFBbY3ntp4voJ7BsTsaP8vTpugo++Yy2bafCX
	BmF/0L4AeRFYVu9V8ZdmGjqdIkXremg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-nwd715HtOjW6X1Mb_04ApQ-1; Thu, 28 Nov 2024 23:03:59 -0500
X-MC-Unique: nwd715HtOjW6X1Mb_04ApQ-1
X-Mimecast-MFC-AGG-ID: nwd715HtOjW6X1Mb_04ApQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-211c1c131c4so22849785ad.1
        for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 20:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732853038; x=1733457838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD6tOHNqd6IcY3bJQ8SBVOWAuW4S8Lz7pt5hmnr0F9s=;
        b=Vk5mn8FzsFpT0hcvvtvx3q3MQRYWz8+MLjCDu9/g9RVXY3uDQadzkXSm5WvTjqNkwN
         xbE/barNyzFo6i9vy8n4uyaCqBCM1vwoaliZsZaYkbCYw8cDMT5VVFcFZK6UbHbj7HQS
         k1HWn8v9RBDw+3lkOjCDUgr0EPH07l8HIDhixCKpJWXBIgeZJyeSLeZ9eXJsVH+/HYkm
         A8WIlIqsmedBx5CgfDrlqx4Hzf6QwTjLck+xFWieZlJ8q6bP0fc6QoJ5s1vMCS+rJz+t
         1LJCpmJrTAverIGixinrUA+IhyiReK8ce0TLW3pbSI19Yebqp2jSSvkS6ZW9gmjFiCtj
         qdTg==
X-Gm-Message-State: AOJu0Yy7gdb/njGLFKOd/oxG7OcJqi4g5zIXigvOxs3ZbRRAxuSBrwRR
	xqN2qR4wQwZRZcAkAvsQfGtxPdGDt3N/MxXIovXG+8a6YKC80rPHZF/H5BGMR5YrdA0trTt40kl
	xoresBosj88ByWo3FxNNLxWyjmCA8P8kydog9jIRcwByniaLRaAZ5uznJmRho0mOrNg==
X-Gm-Gg: ASbGncvd1ETZQgXqxnDU3NjLtEZVzh/kule/Nt/KMF9oJr5L6Pz4QXl6cFdHY72cyp3
	OUSWi42lfXcuUIGS7DheYfCGmAi2+6bYkjlwIRyrXwUTX6SxDGnPc0tieKkrEo4vG32vWfWEtsW
	1TRokt91iYhp9+uMH48xQQfAWm7I6y7ApjCZKjse+LCC5M029ygNj9ZFuF03y/CWeRi2TdY8A6+
	aw8+eQfHDR2GXrElKtjmE96QomHZjXDOHB+eAZVr73KvnphX01fMe8wUylQdE975WMbok726P2h
	HK3yxxWhF5x7vfw=
X-Received: by 2002:a17:903:174d:b0:20c:c9ac:bd0d with SMTP id d9443c01a7336-2151d467b5emr83485905ad.19.1732853038333;
        Thu, 28 Nov 2024 20:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8V8SBKy2e/AIvPIdjAXZpYF5lbH3mRSxtGU24mqZ93WShSYwxdbjj/rNCY7tC7Cd+C03/ag==
X-Received: by 2002:a17:903:174d:b0:20c:c9ac:bd0d with SMTP id d9443c01a7336-2151d467b5emr83485585ad.19.1732853037912;
        Thu, 28 Nov 2024 20:03:57 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219672d1sm21490255ad.164.2024.11.28.20.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 20:03:57 -0800 (PST)
Date: Fri, 29 Nov 2024 12:03:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <20241129040354.k4bltuw6y2hcuver@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

I'll fix the conflict of this patch with:
https://lore.kernel.org/fstests/20241129031846.rije5u7o5o64v6gv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m8174317696134bdc64d27c2f3012f7f843135f91

by below change [1], if you have more suggestions, feel free to tell me.

Thanks,
Zorro

[1]
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 4c6396ddb..b41e1077a 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -20,10 +20,7 @@ _cleanup()
        if [ ! -z "$balance_pid" ]; then
                _btrfs_kill_stress_balance_pid $balance_pid
        fi
-       if [ ! -z "$fsstress_pid" ]; then
-               kill $fsstress_pid &> /dev/null
-               wait $fsstress_pid &> /dev/null
-       fi
+       _kill_fsstress
 }
 
 . ./common/filter
@@ -55,7 +52,7 @@ balance_pid=$!
 sleep $((30*$TIME_FACTOR))
 _kill_fsstress
 _btrfs_kill_stress_balance_pid $balance_pid
-unset fsstress_pid balance_pid
+unset balance_pid

