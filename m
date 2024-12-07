Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99F7DA9F
	for <fstests@vger.kernel.org>; Sat,  7 Dec 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733564311; cv=none; b=V6WdBRzF2fnWIjbCFNYFypaxii7Odu/OSh10NhHkab3EKpQ8Tc+yDn4oXXgPzjZnHFGSgUGlxA19yDUwxFxbUaRvKdOSq627l29AmYUc/EUTmF9865X5rK6cpb6Xf6DwFqPyfFhjx/LnwjuJwXOUTPx2mcZLw+ArxwViYrBgPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733564311; c=relaxed/simple;
	bh=PMW/ynU9elog4VNvNkUB7pQ9RPtlRoLUDsB0fb9QRTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9NuSiy/C4IDzEZoTMaCnEbEeqAuSxgkG+NI05BMfR5dGqhI6UDMOxNKxtJxXbOFRgdAgJ7lcMRx35BOG8zbfxhiTJ8emZJgnQ/H/wi7OiWsiKGUJ/piBPZttav69zlDFFjWg5cOfiQJSZ1N1WtKuBybFg8y0nDVklkEdBbJNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faZ6NEXk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faZ6NEXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733564306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3CiLFWN7sjiH78fCSafBUPav54b5qIS6EtFLP3uMzk=;
	b=faZ6NEXksU1yk8CxF+e2080vhEnTqy2FCCTEimm7GM9R3l+4mTj+H4omNO8o2DHdWdJlxC
	st8tHMqKhiPHXdOxVEB3xl+nGQOdpzNPjkoDiFtDGPpJ/D5RLhs7ugSVvbCWenghHk5ZIx
	rmug2xnKAjV2IQUbesCpRSqJKVwW0Sk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-V0qEg6w6MFayduoti-dX2Q-1; Sat, 07 Dec 2024 04:38:25 -0500
X-MC-Unique: V0qEg6w6MFayduoti-dX2Q-1
X-Mimecast-MFC-AGG-ID: V0qEg6w6MFayduoti-dX2Q
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so22556a91.2
        for <fstests@vger.kernel.org>; Sat, 07 Dec 2024 01:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733564304; x=1734169104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3CiLFWN7sjiH78fCSafBUPav54b5qIS6EtFLP3uMzk=;
        b=fMfalQ6raVnHK+DATwXlJWGXHSIGvYtyubESgMgjez+H+l9hbwtTnjgvFGk2mfBcwm
         7iG6qPOVxBDzg9uxsmh5B4wd5FZjIigHMOEP+vyC+Wg6oS4LGsmyG5N5g8sgk+K9thkn
         761WXdU4jb6KNf/aPh0jwwYQTKWjkXS5s0lu31evlePEOZ82q2wr87gzubwRRQIUWXXS
         GIotaLuRMd6Rl2ms6H1LyJh/+/f1Z/6nT4Gbct7tnAGT46vhr5SLGUZIBuc+zHXtnPvQ
         IAQfgydLm92WyS0h/ubNzfwevuESBIbKCi4ogwXof/mNXnBaaco4MUG6N3lmMItWFcb0
         5gQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfhoo80nK08gR80W7cZyNUHf23LBLzfpZc68HJ5rWbK6R1SKIcRLTmZxXlzACRJUxZl48SVedp@vger.kernel.org
X-Gm-Message-State: AOJu0YxK99QHnNoe337WsU0yi2s1pSz7T4lMZZzOhK4MsnF+midxSzNY
	ocZc27K0PTFysLpwknncJmlYrTsjlMpBHWnjPDZm61kA8IONZXd55f6yGLz9vb5LUWLFMTdAWbp
	Qlwflwmpd5D43C9/PzYNZIpzwxyCTxKkMgB1c06P/XR11651+07zx4bY=
X-Gm-Gg: ASbGncsC9Psp2woctdyQmqTaX03uA5/W8M1INnJqlrzrTawSRgLo+eT+0r12Jh+ANWx
	H+hbNo7phRcj8Y6rl/rgdGRgJVvx7YpLWy4dF2SmEaPAazPirqfrZxn44DUNHoGY1r+PSRXD8oZ
	CXgqsPXmk6tmK4Tx1kqEgfQ6p1uqhgygdugu+zjOUsvNxV6i6nzRiAQaKrhbUHN77GW7YHWhgYE
	OgXs6PJOTpwe470zCLjWZqu3YWO7DkHEg6mr69t7SrAtVFPVV1CrNDUL2OnL6KvYJYWlLaF0UEh
	qjZ/kCZipSipxj8=
X-Received: by 2002:a17:90b:558f:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2ef6aadb4cbmr10120653a91.24.1733564303801;
        Sat, 07 Dec 2024 01:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsqG95hV6HlNJBm8C6dL6oKklquJ6K4/4ZiWjJr55uw1GqN80KN0h2B9wN+v5tmZdlMDN7qw==
X-Received: by 2002:a17:90b:558f:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2ef6aadb4cbmr10120622a91.24.1733564303183;
        Sat, 07 Dec 2024 01:38:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078b46sm6353444a91.39.2024.12.07.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 01:38:22 -0800 (PST)
Date: Sat, 7 Dec 2024 17:38:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [RFC PATCH 00/40] fstests: concurrent test execution
Message-ID: <20241207093819.tpu7it6ztqzy54nc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241129042216.u2f2sl5pc553gxqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241207000917.GA7824@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241207000917.GA7824@frogsfrogsfrogs>

On Fri, Dec 06, 2024 at 04:09:17PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 29, 2024 at 12:22:16PM +0800, Zorro Lang wrote:
> > On Wed, Nov 27, 2024 at 03:51:30PM +1100, Dave Chinner wrote:
> > > Hi folks,
> > > 
> > > This patchset introduces the ability to run fstests concurrently
> > > instead of serially as the current check script does. A git branch
> > > containing this patchset can be pulled from here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dgc/xfstests-dev.git check-parallel
> > 
> > Hi Dave,
> > 
> > I've merged your "check-parallel" branch, and rebase on fstests'
> > patches-in-queue branch (which is nearly the next release). I just
> > pushed a new branch "for-dave-check-parallel" which fixed all
> > conflicts. It'll be "next next" release, feel free to update base
> > on that. I'll test that branch too :)
> 
> I ran this through my test infrastructure at zorro's request.  I saw a
> bunch of loop dev errors trickle out:
> 
> --- xfs/129.out
> +++ xfs/129.out.bad
> @@ -2,3 +2,6 @@
>  Create the original file blocks
>  Reflink every other block
>  Create metadump file, restore it and check restored fs
> +losetup: /dev/loop0: detach failed: No such device or address
> +Cannot destroy loop device /dev/loop0
> +(see /var/tmp/fstests/xfs/129.full for details)
> 
> and I noticed the runtimes for running serially went way up.  Not sure
> if that was because my dev tree has a bunch of metadir fixes in it or
> not; will run that again over the weekend with upstream tot to see if it
> that brings the total runtime back down.

Thanks Darrick! The "[PATCH] fstests: clean up loop device instantiation" does
below change [1], it looks different with your original code. You trys to check
[ -n "$XFS_METADUMP_IMG" ] before loop detaching, and you use a while loop
to do the loop detaching. Does this change break your original test?

Thanks,
Zorro

[1]
--- a/common/metadump
+++ b/common/metadump
@@ -24,17 +24,9 @@ _xfs_cleanup_verify_metadump()
 
        test -n "$XFS_METADUMP_FILE" && rm -f "$XFS_METADUMP_FILE"
 
-       if [ -n "$XFS_METADUMP_IMG" ]; then
-               losetup -n -a -O BACK-FILE,NAME | grep "^$XFS_METADUMP_IMG" | while read backing ldev; do
-                       losetup -d "$ldev"
-               done
-
-               # Don't call rm directly with a globbed argument here to avoid
-               # issues issues with variable expansions.
-               for img in "$XFS_METADUMP_IMG"*; do
-                       test -e "$img" && rm -f "$img"
-               done
-       fi
+       [ -n "$md_data_loop_dev" ] && _destroy_loop_device $md_data_loop_dev
+       [ -n "$md_log_loop_dev" ] && _destroy_loop_device $md_log_loop_dev
+       rm -f $data_img $log_img

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > The motivation for this is the ever growing runtime of fstests as
> > > more tests are added, along with the extremely low resource usage of
> > > individual tests. This means that a typical machine running fstests
> > > is under-utilised and a single auto group test set execution takes
> > > hours.
> > > 
> > > Yes, I know that I could scale out testing by running lots of little
> > > VMs at once, and I already do that. The problem is that I don't get
> > > back a complete auto test run result for hours. Want to check that a
> > > one-line fix has not caused any regressions? That's, at minimum, an
> > > overnight wait for the test farm to crunch through a dozen configs.
> > > 
> > > On my 64p/128GB RAM VM, 'check -g auto -s xfs -x dump' typically
> > > takes around 230-240 minutes to run. With this patchset applied, it
> > > runs the same set of tests in 8-10 minutes. I can run ~25 complete
> > > auto group test sets with check-parallel in the same time it takes
> > > check to run one.
> > > 
> > > IOWs, I can have the most common config complete a full regression
> > > test run as fast as I can turn around a new kernel with a new change
> > > to test. I have CPU, memory and IO to burn in my test machines, but
> > > what I lack is instant feedback for the change I just made.
> > > check-parallel is fast enough that it gives me pretty much instant
> > > feedback....
> > > 
> > > Most of this patchset is preparing infrastructure for concurrent
> > > test execution and fixing bugs in tests that I've found whilst
> > > getting concurrent execution working reliably. The infrastructure
> > > changes center around:
> > > 
> > > - getting rid of killall - there's nothing quite like one test
> > >   killing the processes of 15 other tests at the same time...
> > > - cleaning up background process instantiation and reaping, which is
> > >   a lot more important when an interrupt needs to kill hundreds of
> > >   processes instead of just a couple.
> > > - isolating error reporting (e.g. dmesg filtering) so that one test
> > >   failure doesn't trigger lots of other false failure detections
> > > - sanitising the use of loopback devices
> > > - avoiding the use of fixed device names - multiple tests need to
> > >   use dm-flakey, dm-error, etc devices at the same time, so each
> > >   test needs a unique device name
> > > - marking tests that are unreliable when outside perturbations
> > >   occur. These include tests that expect to find delalloc extents,
> > >   write specific offset patterns in memory then sync them to create
> > >   specific layouts, etc. e.g. If another test runs sync(1), then
> > >   those write patterns no longer produce the expected output.
> > > - taming tests that weren't designed for high CPU count machines
> > > - replacing `udevadm settle` calls because udev is -never- idle when
> > >   there are tens to hundreds of block devices and filesystems being
> > >   rapidly set up and torn down.
> > > - converting sync(1) and sync(2) to syncfs(2) to avoid ihaving
> > >   hundreds of concurrent superblock list traversals lock-stepping
> > >   with multiple mount/unmounts every second.
> > > 
> > > There are lots of little other things, but those are the main test
> > > and test infrastructure changes. Some of these are big - the
> > > fsstress execution rework touches 105 files, but it now means that
> > > every single fsstress execution in fstests is controlled by 4 helper
> > > functions:
> > > 
> > > 	_run_fsstress()		- run fsstress synchronously
> > > 	_run_fsstress_bg	- run fsstress in background
> > > 	_wait_for_fsstress	- wait for background fsstress
> > > 	_kill_fsstress		- kill+wait for background fsstress
> > > 
> > > The test infrastructure also automatically handles cleanup of
> > > fsstress processes when the test is interrupted, so tests using
> > > fsstress don't need a custom _cleanup() function just to call
> > > _kill_fsstress(). This is something that should have been done a
> > > long time ago, but now it is critical for being able to manage
> > > multiple independent concurrent fsstress invocations sanely.
> > > 
> > > There are some tests that just can't be run reliably in a concurrent
> > > environment - if there is outside interference in, say, page cache
> > > flushing then the tests fail. These tests have been added to the
> > > "unreliable_in_parallel" test group with a comment explaining why
> > > they are unreliable. The check-parallel script automatically
> > > excludes this test group.
> > > 
> > > The only remaining set of tests that are somewhat flakey are the
> > > tests that exercise quotas. Quota tests randomly fail for various
> > > reasons. Sometimes they don't detect EDQUOT conditions. Sometimes
> > > repquota emits weird "device not found" errors. Sometimes grace
> > > periods don't start, sometimes they don't time out, or time out and
> > > then don't trigger EDQUOT. I don't know why these weird things are
> > > happening yet, and until I properly integrate test group selection
> > > into check-parallel I can't really isolate the quota tests to focus
> > > on them alone.
> > > 
> > > There are several patches that speed up test runtime. There were
> > > several tests that were taking 12-15 minutes to run each, and these
> > > made up >95% of the entire check-parallel runtime. In general, these
> > > tests have been made to run with more concurrency to speed them up.
> > > the result is that the longest individual test runtime has dropped
> > > to around 7 minutes, and the elapsed runtime for check-parallel has
> > > dropped to 8-10 minutes.
> > > 
> > > Hence there are 39 patches that are doing prep work on tests and
> > > infrastructure to make tests run reliabily in concurrent test
> > > contexts. The last patch is the check-parallel runner script that
> > > runs the tests concurrently.
> > > 
> > > The check-parallel script is still very rudimentary. I hard coded
> > > the tests it runs (generic+xfs auto tests) and the concurrency so
> > > that I could run explicit sets of tests with './check --exact-order
> > > <list>'. It is pointed at a mounted directory, and it creates all
> > > the infrastructure it needs to run the tests within that directory.
> > > 
> > > This enabled me to break up the tests across a set of identical
> > > runner process contexts. Each runner does:
> > > 
> > > - create runner directory
> > > - create test and scratch image files
> > > - create loopback devices for test and scratch devices
> > > - sets up results directories
> > > - execute check in it's own private mount namespace so it can't see
> > >   any of the mounts that other runners are using.
> > > - tears down loopback devices
> > > - reports test failures.
> > > 
> > > If you run with the same directory over and over again, then it
> > > reuses the same runner infrastructure and test and scratch image
> > > files. The results directories are not overwritten as they are
> > > date-stamped, hence using the same mount point automatically creates
> > > a result archive for later data mining.
> > > 
> > > A typical target directory (/mnt/xfs) looks like:
> > > 
> > > /mnt/xfs/runner-0/...
> > > /mnt/xfs/runner-1/...
> > > ....
> > > /mnt/xfs/runner-63/...
> > > 
> > > And each runner directory:
> > > 
> > > log
> > > results-2024-11-19-11:22:25/...
> > > results-2024-11-19-12:36:28/...
> > > .....
> > > results-2024-11-27-13:32:42/...
> > > scratch/
> > > scratch.img
> > > test/
> > > test.img
> > > 
> > > The log file is the check output for that runner and should look
> > > familiar:
> > > 
> > > SECTION       -- xfs
> > > FSTYP         -- xfs (debug)
> > > PLATFORM      -- Linux/x86_64 test1 6.12.0-dgc+ #297 SMP PREEMPT_DYNAMIC Wed Nov 27 08:13:06 AEDT 2024
> > > MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/loop10
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop10 /mnt/xfs/runner-10/scratch
> > > 
> > > generic/387        309s
> > > generic/551        49s
> > > generic/289        2s
> > > xfs/274        3s
> > > generic/677        3s
> > > generic/143        5s
> > > generic/304        1s
> > > generic/390        4s
> > > generic/427        4s
> > > xfs/103        1s
> > > generic/252        3s
> > > xfs/045        1s
> > > generic/374        2s
> > > generic/002        1s
> > > generic/534        1s
> > > generic/039        1s
> > > generic/595       [not run] No encryption support for xfs
> > > xfs/122       [not run] Could not compile test program (see end of /mnt/xfs/runner-10/results-2024-11-27-13:32:42/xfs/xfs/122.full)
> > > xfs/556       [not run] xfs_scrub not found
> > > Ran: generic/387 generic/551 generic/289 xfs/274 generic/677 generic/143 generic/304 generic/390 generic/427 xfs/103 generic/252 xfs/045 generic/374 generic/002 generic/534 generic/039 generic/595 xfs/122 xfs/556
> > > Not run: generic/595 xfs/122 xfs/556
> > > Passed all 19 tests
> > > 
> > > SECTION       -- xfs
> > > =========================
> > > Ran: generic/387 generic/551 generic/289 xfs/274 generic/677 generic/143 generic/304 generic/390 generic/427 xfs/103 generic/252 xfs/045 generic/374 generic/002 generic/534 generic/039 generic/595 xfs/122 xfs/556
> > > Not run: generic/595 xfs/122 xfs/556
> > > Passed all 19 tests
> > > 
> > > Doing something with all the log files from a run can be done with
> > > "/mnt/xfs/*/log". e.g. grep, vi, etc.
> > > 
> > > The results directory contains the same check.{full,log,time} and
> > > test results directories as per a normal check invocation, so
> > > there's little difference in checking/analysing results with a
> > > parallel execution run.
> > > 
> > > Because the tests run in private mount namespaces, it's easy to see
> > > what check-parallel is running at any point in time using 'pstree -N
> > > mnt'. Here's a run that is hung on an unmount not completing:
> > > 
> > > $ pstree -N mnt
> > > [4026531841]
> > > bash
> > > bash───pstree
> > > [0]
> > > sudo───sudo───check-parallel─┬─check-parallel───nsexec───check───311───fsync-tester
> > >                              ├─check-parallel───nsexec───check───467───open_by_handle
> > >                              ├─check-parallel───nsexec───check───338
> > >                              ├─check-parallel───nsexec───check───421
> > >                              ├─check-parallel───nsexec───check───441
> > >                              ├─check-parallel───nsexec───check───232
> > >                              ├─check-parallel───nsexec───check───477───open_by_handle
> > >                              ├─check-parallel───nsexec───check───420
> > >                              ├─check-parallel───nsexec───check───426───open_by_handle
> > >                              ├─check-parallel───nsexec───check───756───open_by_handle
> > >                              ├─check-parallel───nsexec───check───231
> > >                              ├─check-parallel───nsexec───check───475───475.fsstress───475.fsstress───{475.fsstress}
> > >                              ├─check-parallel───nsexec───check───388───388.fsstress───388.fsstress───{388.fsstress}
> > >                              ├─check-parallel───nsexec───check───259───sync
> > >                              ├─check-parallel───nsexec───check───622───sync
> > >                              ├─check-parallel───nsexec───check───318───sync
> > >                              ├─check-parallel───nsexec───check───753───umount
> > >                              ├─check-parallel───nsexec───check───086
> > >                              ├─check-parallel───nsexec───check───648───648.fsstress───648.fsstress───{648.fsstress}
> > >                              ├─check-parallel───nsexec───check───391
> > >                              ├─check-parallel───nsexec───check───315───sync
> > >                              └─check-parallel───nsexec───check───183───bulkstat_unlink
> > > 
> > > All the other processes are in sync or dropping caches and stuck
> > > waiting for the superblock s_umount lock that the unmount holds.
> > > Finding where it is stuck:
> > > 
> > > $ pgrep [u]mount
> > > 1081885
> > > $ sudo cat /proc/1081885/stack
> > > [<0>] xfs_ail_push_all_sync+0x9c/0xf0
> > > [<0>] xfs_unmount_flush_inodes+0x41/0x70
> > > [<0>] xfs_unmountfs+0x59/0x190
> > > [<0>] xfs_fs_put_super+0x3b/0x90
> > > [<0>] generic_shutdown_super+0x77/0x160
> > > [<0>] kill_block_super+0x1b/0x40
> > > [<0>] xfs_kill_sb+0x12/0x30
> > > [<0>] deactivate_locked_super+0x38/0x100
> > > [<0>] deactivate_super+0x41/0x50
> > > [<0>] cleanup_mnt+0x9f/0x160
> > > [<0>] __cleanup_mnt+0x12/0x20
> > > [<0>] task_work_run+0x89/0xb0
> > > [<0>] resume_user_mode_work+0x4f/0x60
> > > [<0>] syscall_exit_to_user_mode+0x76/0xb0
> > > [<0>] do_syscall_64+0x74/0x130
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > $
> > > 
> > > Yup, known bug - a shutdown vs XFS_ISTALE inode cluster freeing
> > > issue that leaves pinned, stale inodes in the AIL.
> > > 
> > > The point I'm making here is that running tests concurrently doesn't
> > > change anything material in how you'd go about discovering and
> > > diagnosing failures. The only difference is in what that initial
> > > failure might look like. e.g. Failures that result in dmesg output
> > > will cause a huge number of tests to all fail with "check dmesg for
> > > failure output" reports. Hence there is a bit of sifting to find
> > > which test triggered the dmesg output, but failure detection still
> > > works just fine.
> > > 
> > > The check-parallel script is really only at proof-of-concept stage.
> > > It is sufficient to run tests in parallel, but that's about it. most
> > > of the work so far has gone into making the generic and XFS tests
> > > run reliably in parallel. I have not run any other tests, and
> > > haven't done full conversions of other test directories or C code in
> > > src/. e.g. the sync -> syncfs was only done for the common dir and
> > > the generic and xfs tests dirs
> > > 
> > > I do not plan to do these conversions for ext4/btrfs/overlay/etc any
> > > time soon as these conversions are mostly about improving execution
> > > time, not test correctness. Hence they are not a priority for me -
> > > the priority is further developing the concurrent execution
> > > environment. i.e. check-parallel.
> > > 
> > > To that end, I need to factor all the test selection and exclusion
> > > code out of check, and do the same with the actual test list runner
> > > loop. That way I can reuse all the existing code from within the
> > > check-parallel context rather than having to call check to do all of
> > > that work itself. I would like to get check-parallel to the point
> > > where it is mostly just s/check/check-parallel/ on the command line
> > > to move from serial to concurrent test execution.
> > > 
> > > I also want to try to integrate the config section stuff into
> > > check-parallel. This is more a case of defining what devices the
> > > config needs to create (i.e. as loop devices) rather than what
> > > devices it should be using. I think I can do this just by defining a
> > > different set of environment variables (e.g. NEED_SCRATCHDEV,
> > > NEED_LOGDEV, etc) and triggering the loop device creation from these
> > > variables.
> > > 
> > > In a way, the fact that check-parallel bootstraps it's own runtime
> > > environment almost makes it entirely zero-config. As it stands right
> > > now, you should be able to pull this patchset, create your base test
> > > directory (make sure you have at least 100GB of free disk space),
> > > run './check-parallel <test_dir> -x dump' and it Should Just Work.
> > > 
> > > At this point, the test infrastructure problems are largely solved.
> > > My focus is now on further development of the check-parallel script
> > > and integrating it tightly into the existing check infrastructure
> > > rather than open-coding test lists and configuration information.
> > > This will probably take a bit of time, so I'd like to get the bug
> > > fixes, improvements and infrastructure changes underway so I'm not
> > > left carrying a huge patchset for months....
> > > 
> > > ----------------------------------------------------------------
> > > Dave Chinner (40):
> > >       xfs/448: get rid of assert-on-failure
> > >       fstests: cleanup fsstress process management
> > >       fuzzy: don't use killall
> > >       fstests: per-test dmflakey instances
> > >       fstests: per-test dmerror instances
> > >       fstests: per-test dmhuge instances
> > >       fstests: per-test dmthin instances
> > >       fstests: per-test dmdust instances
> > >       fstests: per-test dmdelay instances
> > >       fstests: fix DM device creation/removal vs udev races
> > >       fstests: use syncfs rather than sync
> > >       fstests: clean up mount and unmount operations
> > >       fstests: clean up loop device instantiation
> > >       fstests: xfs/227 is really slow
> > >       fstests: mark tests that are unreliable when run in parallel
> > >       fstests: use udevadm wait in preference to settle
> > >       xfs/442: rescale load so it's not exponential
> > >       xfs/176: fix broken setup code
> > >       xfs/177: remove unused slab object count location checks
> > >       fstests: remove uses of killall where possible
> > >       generic/127: reduce runtime
> > >       quota: system project quota files need to be shared
> > >       dmesg: reduce noise from other tests
> > >       fstests: stop using /tmp directly
> > >       fstests: scale some tests for high CPU count sanity
> > >       generic/310: cleanup killing background processes
> > >       filter: handle mount errors from CONFIG_BLK_DEV_WRITE_MOUNTED=y
> > >       filters: add a filter that accepts EIO instead of other errors
> > >       generic/085: general cleanup for reliability and debugging
> > >       fstests: don't use directory stacks
> > >       fstests: clean up a couple of dm-flakey tests
> > >       fstests: clean up termination of various tests
> > >       vfstests: some tests require the testdir to be shared
> > >       xfs/629: single extent files should be within tolerance
> > >       xfs/076: fix broken mkfs filtering
> > >       fstests: capture some failures to seqres.full
> > >       fstests: always use fail-at-unmount semantics for XFS
> > >       generic/062: don't leave debug files in $here on failure
> > >       fstests: quota grace periods unreliable under load
> > >       fstests: check-parallel
> > > 
> > >  check                                         |   12 -
> > >  check-parallel                                |  205 ++++++++++++++++++
> > >  common/btrfs                                  |    4
> > >  common/config                                 |   36 ++-
> > >  common/dmdelay                                |   24 +-
> > >  common/dmdust                                 |   14 -
> > >  common/dmerror                                |   74 +++---
> > >  common/dmflakey                               |   60 ++---
> > >  common/dmhugedisk                             |   21 +
> > >  common/dmlogwrites                            |    4
> > >  common/dmthin                                 |   12 -
> > >  common/encrypt                                |    2
> > >  common/filter                                 |   17 +
> > >  common/fuzzy                                  |   37 +--
> > >  common/log                                    |    2
> > >  common/metadump                               |   32 +-
> > >  common/overlay                                |   10
> > >  common/populate                               |    8
> > >  common/preamble                               |    1
> > >  common/quota                                  |   37 ---
> > >  common/rc                                     |  166 +++++++++++---
> > >  common/repair                                 |    2
> > >  common/report                                 |    2
> > >  common/verity                                 |    2
> > >  common/xfs                                    |    2
> > >  doc/group-names.txt                           |    1
> > >  doc/requirement-checking.txt                  |    6
> > >  ltp/fsstress.c                                |   28 ++
> > >  src/aio-dio-regress/aio-last-ref-held-by-io.c |    5
> > >  src/dmerror                                   |    6
> > >  tests/btrfs/004                               |   11
> > >  tests/btrfs/007                               |    3
> > >  tests/btrfs/012                               |    4
> > >  tests/btrfs/028                               |    6
> > >  tests/btrfs/049                               |    4
> > >  tests/btrfs/057                               |    4
> > >  tests/btrfs/060                               |   14 -
> > >  tests/btrfs/061                               |   13 -
> > >  tests/btrfs/062                               |   13 -
> > >  tests/btrfs/063                               |   13 -
> > >  tests/btrfs/064                               |   13 -
> > >  tests/btrfs/065                               |   14 -
> > >  tests/btrfs/066                               |   14 -
> > >  tests/btrfs/067                               |   14 -
> > >  tests/btrfs/068                               |   14 -
> > >  tests/btrfs/069                               |   13 -
> > >  tests/btrfs/070                               |   13 -
> > >  tests/btrfs/071                               |   13 -
> > >  tests/btrfs/072                               |   14 -
> > >  tests/btrfs/073                               |   13 -
> > >  tests/btrfs/074                               |   13 -
> > >  tests/btrfs/078                               |   12 -
> > >  tests/btrfs/100                               |    4
> > >  tests/btrfs/101                               |    4
> > >  tests/btrfs/136                               |    6
> > >  tests/btrfs/160                               |    3
> > >  tests/btrfs/192                               |   12 -
> > >  tests/btrfs/195                               |    2
> > >  tests/btrfs/212                               |   16 -
> > >  tests/btrfs/232                               |    4
> > >  tests/btrfs/252                               |    5
> > >  tests/btrfs/261                               |    2
> > >  tests/btrfs/284                               |    4
> > >  tests/btrfs/286                               |    2
> > >  tests/btrfs/291                               |    5
> > >  tests/btrfs/320                               |    6
> > >  tests/btrfs/332                               |    4
> > >  tests/ext4/004                                |    4
> > >  tests/ext4/057                                |   14 -
> > >  tests/ext4/058                                |    3
> > >  tests/ext4/307                                |    4
> > >  tests/generic/013                             |   22 -
> > >  tests/generic/015                             |    2
> > >  tests/generic/019                             |   13 -
> > >  tests/generic/029                             |    2
> > >  tests/generic/030                             |    2
> > >  tests/generic/032                             |    2
> > >  tests/generic/034                             |    2
> > >  tests/generic/039                             |    2
> > >  tests/generic/040                             |    2
> > >  tests/generic/041                             |    2
> > >  tests/generic/042                             |    4
> > >  tests/generic/048                             |    2
> > >  tests/generic/049                             |    4
> > >  tests/generic/050                             |    3
> > >  tests/generic/051                             |   24 --
> > >  tests/generic/054                             |    2
> > >  tests/generic/055                             |    6
> > >  tests/generic/057                             |    2
> > >  tests/generic/059                             |    2
> > >  tests/generic/062                             |    2
> > >  tests/generic/065                             |    2
> > >  tests/generic/066                             |    5
> > >  tests/generic/067                             |   17 -
> > >  tests/generic/068                             |    7
> > >  tests/generic/070                             |   12 -
> > >  tests/generic/073                             |    2
> > >  tests/generic/076                             |   10
> > >  tests/generic/076.out                         |    1
> > >  tests/generic/081                             |    8
> > >  tests/generic/083                             |   13 -
> > >  tests/generic/083.out                         |    1
> > >  tests/generic/084                             |   12 -
> > >  tests/generic/085                             |   21 +
> > >  tests/generic/090                             |    4
> > >  tests/generic/092                             |    2
> > >  tests/generic/098                             |    4
> > >  tests/generic/099                             |    8
> > >  tests/generic/101                             |    2
> > >  tests/generic/104                             |    2
> > >  tests/generic/106                             |    2
> > >  tests/generic/107                             |    2
> > >  tests/generic/108                             |    9
> > >  tests/generic/109                             |    5
> > >  tests/generic/117                             |    4
> > >  tests/generic/127                             |   67 +++--
> > >  tests/generic/127.out                         |    6
> > >  tests/generic/135                             |   24 --
> > >  tests/generic/150                             |    2
> > >  tests/generic/151                             |    2
> > >  tests/generic/152                             |    2
> > >  tests/generic/157                             |    3
> > >  tests/generic/158                             |    3
> > >  tests/generic/159                             |    2
> > >  tests/generic/160                             |    2
> > >  tests/generic/162                             |    4
> > >  tests/generic/163                             |    4
> > >  tests/generic/164                             |    4
> > >  tests/generic/165                             |    4
> > >  tests/generic/166                             |    6
> > >  tests/generic/167                             |    4
> > >  tests/generic/168                             |    7
> > >  tests/generic/170                             |    7
> > >  tests/generic/171                             |    6
> > >  tests/generic/172                             |    6
> > >  tests/generic/173                             |    6
> > >  tests/generic/174                             |    6
> > >  tests/generic/204                             |    8
> > >  tests/generic/232                             |    5
> > >  tests/generic/232.out                         |    1
> > >  tests/generic/247                             |    2
> > >  tests/generic/250                             |    2
> > >  tests/generic/251                             |    5
> > >  tests/generic/252                             |    5
> > >  tests/generic/265                             |    2
> > >  tests/generic/266                             |    2
> > >  tests/generic/267                             |    2
> > >  tests/generic/268                             |    2
> > >  tests/generic/269                             |    8
> > >  tests/generic/270                             |   10
> > >  tests/generic/271                             |    2
> > >  tests/generic/272                             |    2
> > >  tests/generic/273                             |    2
> > >  tests/generic/274                             |    6
> > >  tests/generic/275                             |    6
> > >  tests/generic/276                             |    2
> > >  tests/generic/278                             |    2
> > >  tests/generic/279                             |    2
> > >  tests/generic/281                             |    2
> > >  tests/generic/282                             |    2
> > >  tests/generic/283                             |    2
> > >  tests/generic/306                             |    2
> > >  tests/generic/310                             |   24 +-
> > >  tests/generic/315                             |    2
> > >  tests/generic/317                             |    2
> > >  tests/generic/318                             |    2
> > >  tests/generic/321                             |    4
> > >  tests/generic/323                             |    7
> > >  tests/generic/325                             |    2
> > >  tests/generic/328                             |    4
> > >  tests/generic/329                             |    5
> > >  tests/generic/330                             |    2
> > >  tests/generic/331                             |    7
> > >  tests/generic/332                             |    4
> > >  tests/generic/333                             |    6
> > >  tests/generic/334                             |    6
> > >  tests/generic/335                             |    2
> > >  tests/generic/336                             |    9
> > >  tests/generic/341                             |    2
> > >  tests/generic/342                             |    2
> > >  tests/generic/343                             |    2
> > >  tests/generic/347                             |    2
> > >  tests/generic/348                             |    2
> > >  tests/generic/353                             |    2
> > >  tests/generic/361                             |    8
> > >  tests/generic/373                             |    4
> > >  tests/generic/374                             |    4
> > >  tests/generic/376                             |    2
> > >  tests/generic/382                             |    2
> > >  tests/generic/387                             |    2
> > >  tests/generic/388                             |   24 --
> > >  tests/generic/390                             |   11
> > >  tests/generic/391                             |    2
> > >  tests/generic/395                             |    2
> > >  tests/generic/409                             |   11
> > >  tests/generic/410                             |   11
> > >  tests/generic/411                             |   11
> > >  tests/generic/416                             |    2
> > >  tests/generic/422                             |    4
> > >  tests/generic/425                             |    2
> > >  tests/generic/441                             |    2
> > >  tests/generic/459                             |    8
> > >  tests/generic/461                             |   17 -
> > >  tests/generic/464                             |   10
> > >  tests/generic/474                             |    4
> > >  tests/generic/475                             |   17 -
> > >  tests/generic/476                             |   15 -
> > >  tests/generic/479                             |    2
> > >  tests/generic/480                             |    2
> > >  tests/generic/482                             |   12 -
> > >  tests/generic/483                             |    2
> > >  tests/generic/484                             |    3
> > >  tests/generic/489                             |    2
> > >  tests/generic/502                             |    2
> > >  tests/generic/505                             |    2
> > >  tests/generic/506                             |    2
> > >  tests/generic/507                             |    2
> > >  tests/generic/508                             |    2
> > >  tests/generic/510                             |    2
> > >  tests/generic/520                             |    2
> > >  tests/generic/526                             |    2
> > >  tests/generic/527                             |    2
> > >  tests/generic/530                             |    2
> > >  tests/generic/531                             |    8
> > >  tests/generic/535                             |    2
> > >  tests/generic/546                             |    2
> > >  tests/generic/547                             |    5
> > >  tests/generic/556                             |    2
> > >  tests/generic/560                             |    7
> > >  tests/generic/561                             |   25 +-
> > >  tests/generic/563                             |   24 +-
> > >  tests/generic/564                             |   12 -
> > >  tests/generic/579                             |    8
> > >  tests/generic/585                             |    4
> > >  tests/generic/589                             |   11
> > >  tests/generic/590                             |    9
> > >  tests/generic/599                             |    2
> > >  tests/generic/601                             |    7
> > >  tests/generic/603                             |   14 -
> > >  tests/generic/604                             |    2
> > >  tests/generic/610                             |    2
> > >  tests/generic/620                             |    1
> > >  tests/generic/628                             |    4
> > >  tests/generic/629                             |    4
> > >  tests/generic/631                             |    2
> > >  tests/generic/632                             |    2
> > >  tests/generic/640                             |    2
> > >  tests/generic/642                             |   10
> > >  tests/generic/648                             |   25 --
> > >  tests/generic/650                             |   19 -
> > >  tests/generic/670                             |    2
> > >  tests/generic/671                             |    2
> > >  tests/generic/672                             |    2
> > >  tests/generic/673                             |    2
> > >  tests/generic/674                             |    2
> > >  tests/generic/675                             |    2
> > >  tests/generic/677                             |    2
> > >  tests/generic/683                             |    2
> > >  tests/generic/684                             |    2
> > >  tests/generic/685                             |    2
> > >  tests/generic/686                             |    2
> > >  tests/generic/687                             |    2
> > >  tests/generic/688                             |    2
> > >  tests/generic/690                             |    2
> > >  tests/generic/691                             |    6
> > >  tests/generic/694                             |    2
> > >  tests/generic/695                             |    2
> > >  tests/generic/698                             |    4
> > >  tests/generic/699                             |    8
> > >  tests/generic/703                             |    2
> > >  tests/generic/704                             |    2
> > >  tests/generic/707                             |    7
> > >  tests/generic/716                             |    2
> > >  tests/generic/717                             |    2
> > >  tests/generic/718                             |    2
> > >  tests/generic/719                             |    2
> > >  tests/generic/721                             |    2
> > >  tests/generic/722                             |   15 -
> > >  tests/generic/725                             |    2
> > >  tests/generic/726                             |    2
> > >  tests/generic/727                             |    2
> > >  tests/generic/730                             |    2
> > >  tests/generic/731                             |    2
> > >  tests/generic/732                             |    4
> > >  tests/generic/735                             |    2
> > >  tests/generic/738                             |    2
> > >  tests/generic/741                             |    2
> > >  tests/generic/743                             |    4
> > >  tests/generic/744                             |   10
> > >  tests/generic/745                             |    4
> > >  tests/generic/746                             |   18 -
> > >  tests/generic/747                             |    4
> > >  tests/generic/749                             |    4
> > >  tests/generic/750                             |   10
> > >  tests/generic/751                             |    1
> > >  tests/generic/753                             |   17 -
> > >  tests/overlay/019                             |   48 ++--
> > >  tests/overlay/021                             |    8
> > >  tests/overlay/058                             |   12 -
> > >  tests/xfs/006                                 |    7
> > >  tests/xfs/011                                 |   11
> > >  tests/xfs/013                                 |   22 -
> > >  tests/xfs/014                                 |   11
> > >  tests/xfs/016                                 |    4
> > >  tests/xfs/017                                 |   13 -
> > >  tests/xfs/017.out                             |    1
> > >  tests/xfs/032                                 |    2
> > >  tests/xfs/049                                 |   39 ++-
> > >  tests/xfs/050                                 |    5
> > >  tests/xfs/051                                 |   10
> > >  tests/xfs/052                                 |    2
> > >  tests/xfs/057                                 |    9
> > >  tests/xfs/070                                 |    9
> > >  tests/xfs/073                                 |   36 +--
> > >  tests/xfs/074                                 |   23 +-
> > >  tests/xfs/076                                 |    8
> > >  tests/xfs/077                                 |    2
> > >  tests/xfs/078                                 |   20 -
> > >  tests/xfs/079                                 |   17 -
> > >  tests/xfs/104                                 |   14 -
> > >  tests/xfs/110                                 |    2
> > >  tests/xfs/118                                 |    4
> > >  tests/xfs/119                                 |    2
> > >  tests/xfs/128                                 |    2
> > >  tests/xfs/133                                 |    2
> > >  tests/xfs/134                                 |    2
> > >  tests/xfs/137                                 |    2
> > >  tests/xfs/141                                 |   13 -
> > >  tests/xfs/148                                 |   29 +-
> > >  tests/xfs/149                                 |    8
> > >  tests/xfs/154                                 |    1
> > >  tests/xfs/158                                 |    4
> > >  tests/xfs/161                                 |    2
> > >  tests/xfs/167                                 |   17 -
> > >  tests/xfs/168                                 |    8
> > >  tests/xfs/176                                 |   10
> > >  tests/xfs/177                                 |   15 -
> > >  tests/xfs/186                                 |    4
> > >  tests/xfs/195                                 |    2
> > >  tests/xfs/201                                 |    4
> > >  tests/xfs/212                                 |    2
> > >  tests/xfs/216                                 |   23 +-
> > >  tests/xfs/217                                 |   24 +-
> > >  tests/xfs/227                                 |   59 +++--
> > >  tests/xfs/231                                 |    4
> > >  tests/xfs/232                                 |   10
> > >  tests/xfs/234                                 |    2
> > >  tests/xfs/236                                 |    2
> > >  tests/xfs/237                                 |   13 -
> > >  tests/xfs/239                                 |    2
> > >  tests/xfs/240                                 |    7
> > >  tests/xfs/241                                 |    2
> > >  tests/xfs/243                                 |   11
> > >  tests/xfs/246                                 |    2
> > >  tests/xfs/250                                 |   19 +
> > >  tests/xfs/259                                 |   13 -
> > >  tests/xfs/264                                 |    4
> > >  tests/xfs/265                                 |    2
> > >  tests/xfs/270                                 |    2
> > >  tests/xfs/272                                 |    2
> > >  tests/xfs/274                                 |    2
> > >  tests/xfs/276                                 |    2
> > >  tests/xfs/289                                 |    4
> > >  tests/xfs/291                                 |    4
> > >  tests/xfs/297                                 |   12 -
> > >  tests/xfs/300                                 |    8
> > >  tests/xfs/305                                 |    8
> > >  tests/xfs/309                                 |    2
> > >  tests/xfs/312                                 |    2
> > >  tests/xfs/313                                 |    2
> > >  tests/xfs/314                                 |    2
> > >  tests/xfs/315                                 |    4
> > >  tests/xfs/316                                 |    2
> > >  tests/xfs/317                                 |    2
> > >  tests/xfs/318                                 |    4
> > >  tests/xfs/319                                 |    2
> > >  tests/xfs/320                                 |    2
> > >  tests/xfs/321                                 |    2
> > >  tests/xfs/322                                 |    2
> > >  tests/xfs/323                                 |    2
> > >  tests/xfs/324                                 |    2
> > >  tests/xfs/325                                 |    4
> > >  tests/xfs/326                                 |    4
> > >  tests/xfs/327                                 |    2
> > >  tests/xfs/420                                 |    2
> > >  tests/xfs/421                                 |    2
> > >  tests/xfs/423                                 |    2
> > >  tests/xfs/438                                 |    2
> > >  tests/xfs/440                                 |    8
> > >  tests/xfs/442                                 |   15 -
> > >  tests/xfs/448                                 |    6
> > >  tests/xfs/495                                 |    2
> > >  tests/xfs/501                                 |    2
> > >  tests/xfs/502                                 |    2
> > >  tests/xfs/507                                 |    2
> > >  tests/xfs/511                                 |    2
> > >  tests/xfs/513                                 |   48 +---
> > >  tests/xfs/519                                 |    2
> > >  tests/xfs/520                                 |    2
> > >  tests/xfs/521                                 |    8
> > >  tests/xfs/527                                 |    5
> > >  tests/xfs/528                                 |   10
> > >  tests/xfs/530                                 |   11
> > >  tests/xfs/538                                 |    4
> > >  tests/xfs/541                                 |    2
> > >  tests/xfs/544                                 |    2
> > >  tests/xfs/553                                 |    4
> > >  tests/xfs/558                                 |    7
> > >  tests/xfs/601                                 |    2
> > >  tests/xfs/606                                 |   14 -
> > >  tests/xfs/607                                 |    6
> > >  tests/xfs/609                                 |   20 -
> > >  tests/xfs/610                                 |   20 -
> > >  tests/xfs/613                                 |   44 +--
> > >  tests/xfs/613.out                             |    1
> > >  tests/xfs/617                                 |    2
> > >  tests/xfs/629                                 |    6
> > >  tests/xfs/630                                 |    2
> > >  tests/xfs/631                                 |    9
> > >  tests/xfs/790                                 |    2
> > >  tests/xfs/791                                 |    2
> > >  tests/xfs/792                                 |    2
> > >  tests/xfs/802                                 |    7
> > >  423 files changed, 1827 insertions(+), 1629 deletions(-)
> > > 
> > > 
> > 
> > 
> 

