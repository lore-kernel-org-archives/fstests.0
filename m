Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66864689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683535; cv=none; b=mNvRoPvjMKvfCypiAqoHpwobB1R8OyEkbh7NvGchQBQAh02H6C6JPOjCZbVXWItTuisyjs0FZz1s0dpRPVWfuUjdS4HoMVH60Q/b6J4XJ4sVotBGzJj/4ydCbTYVtamGuX8/4LJ+EBJqikQlmsiBnYsGGwCO8YfV1r3ptKrjjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683535; c=relaxed/simple;
	bh=89bFUxX41Wygscy97EW5vtGNO+ZC/d4tCi45n21ktKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYdnqTkc7Yq/N5qkgvyr8DXZpcw1+cH/OboE6XOEayCeefvyHYRIlSNHtdRrPk34jLRRtmpmZxJJ2MivA/ELGG5peagOuSC3KbEOUMHCq7NupcJ23NADjGO9dIG/HmmzB9kGLfoEZcZgXDKEJ+maVleyebcxPUYcedHExQYoyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=m8GThCmd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="m8GThCmd"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fd6a0a9cso46491905ad.3
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683533; x=1733288333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlQ35L+7JZAQDVtnnWfihYDXlIAcyIpwmQwcp2xjHxA=;
        b=m8GThCmdcvN+JubLaqC2H85V3Tfx6yNuHHJIv8i4Ef2ZinTucY4aoJDaJoVCVCpnFY
         crfiOSA9LVGyv2cwjA9kr4U4hJgvkUfDc/dt5Iu4RFg0cFkcJS1MO3ippuy1Gevj51lu
         v4HY4GhbdeCvcSPXaArvDImp6rM8XDSePrbghr8DGW/MVAQOa5Tq8OET+fpwZcKyPQwD
         IZM6uQATo4KtKtBUj7jm8MMs84FKuv3FnKV1UJk/9UTVP8sKuxVU65ef9CxaHjY6dDbp
         akK9XuEoCznQNT6E4/a06to72VxzvrKutAN9BX0SjUhOa98r6SHhavaB0CwFIjc8C6+l
         1Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683533; x=1733288333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlQ35L+7JZAQDVtnnWfihYDXlIAcyIpwmQwcp2xjHxA=;
        b=U83FjLjOBqze+71v+6tcvRYO8oVKLmPOXlYoroYhO46xBo4R9e3tIZD3qdJqheIrp/
         bT0RDwdPTDWyGqIgAKcnXMlQwHRFGla4HxEBgQzijxIbVfcQi4H2HkgLyWWsYYKy/7aQ
         QpjhSWbCMqyjmqCuG4x38YFSUB9WBJAUKuSno+WcoFq+cCOpHZ09EejEKbhTMFBAfgX6
         raaVT3fZ5oq8x48dFam2ZjPI8SGgDAFGqQKw4RHCzaUUgfBeCxmhsgrasqkagOQZDiHe
         lvt/YIM+8UClKydrkvastjgJhKn6k5Kvy55gOnSvBeRI1iOdeNSUxqZnyjnZTKmmtnnm
         C9MA==
X-Gm-Message-State: AOJu0Yw5OoWhaFpqK+BfKpGajSJBkRUn7c1ppAUCx7oU/7mBg4+zDFd8
	IywGDgFv77cqO3KEcrRPt8LUo+ShHcqpDXHTXpNpk4FE3khj1TMmsKzrx/RJvYbjKmAU+TBc3wC
	V
X-Gm-Gg: ASbGncs1mn6tjeGQC/i5J8GETIbCS6D7NlZwOM4M46vsh+WfiukfK4SmRIPDzTWeiKT
	aIPY3A3ceJtp3wN0jkS9VJ1tgRpwB3PM6gvlH5P6goAn/VI9GvILov6YT+lYAucnS0qV9Ll+WzM
	tdBqfNNbFCUdSuyh3caZjHOydpPndjkMj8cAkbzLzhc2zefeaLh+pOEY0e4lsvyIE4T1qtDYl8L
	EwHUez3HrBya1ui69I9005WbAa551Pxc3Q+IVj7CzFLMGHwa6GBnp77kcPp+PuTh3G/R7PYkCuT
	rgzfCpIP6do0WoUNUwPkLrSn
X-Google-Smtp-Source: AGHT+IHMt7uAJO012FXYhT3FnDk5zw/4DH4aRoIcWdLeFrup1Ar9Jv+7Kt2mU7IQDCCcMPz3+6yP+A==
X-Received: by 2002:a17:902:ecce:b0:20d:2804:bcde with SMTP id d9443c01a7336-21501e5c83emr23094095ad.35.1732683533034;
        Tue, 26 Nov 2024 20:58:53 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-214f87bc298sm12633165ad.226.2024.11.26.20.58.51
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:58:52 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3y-00000003ZWP-0XM4
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgh-17fu
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 40/40] fstests: check-parallel
Date: Wed, 27 Nov 2024 15:52:10 +1100
Message-ID: <20241127045403.3665299-41-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Runs tests in parallel runner threads. Each runner thread has it's
own set of tests to run, and runs a separate instance of check
to run those tests.

check-parallel sets up loop devices, mount points, results
directories, etc for each instance and divides the tests up between
the runner threads.

It currently hard codes the XFS and generic test lists, and then
gives each check invocation an explicit list of tests to run. It
also passes through exclusions so that test exclude filtering is
still done by check.

This is far from ideal, but I didn't want to have to embark on a
major refactoring of check to be able to run stuff in parallel.
It was quite the challenge just to get all the tests and test
infrastructure up to the point where they can run reliably in
parallel.

Hence I've left the actual factoring of test selection and setup
out of the patchset for the moment. The plan is to factor both the
test setup and the test list runner loop out of check and share them
between check and check-parallel, hence not requiring check-parallel
to run check directly. That is future work, however.

With the current test runner setup, it is not uncommon to see >5000%
cpu usage, 150-200kiops and 4-5GB/s of disk bandwidth being used
when running 64 runners. This is a serious stress load as it is
constantly mounting and unmounting dozens of filesystems, creating
and destroying devices, dropping caches, running sync, running CPU
hot plug, running page cache migration, etc.

The massive amount of IO that load generates causes qemu hosts to
abort (i.e. crash) because they run out of vm map segments. Hence
bumping up the max_map_count on the host like so:

echo 1048576 > /proc/sys/vm/max_map_count

is necessary.

There is no significant memory pressure to speak of from running the
tests like this. I've seen a maximum of about 50GB of RAM used when
running tests like this, so running on a 64p/64GB VM the additional
concurrency doesn't really stress memory capacity like it does CPU
and IO.

All the runners are executed in private mount namespaces. This is
to prevent ephemeral mount namespace clones from taking a reference
to every mounted filesystem in the machine and so causing random
"device busy after unmount" failures in the tests that are running
concurrently with the mount namespace setup and teardown.

A typical `pstree -N mnt` looks like:

$ pstree -N mnt
[4026531841]
bash
bash───pstree
[0]
sudo───sudo───check-parallel─┬─check-parallel───nsexec───check───311─┬─cut
                             │                                       └─md5sum
                             ├─check-parallel───nsexec───check───750─┬─750───sleep
                             │                                       └─750.fsstress───4*[750.fsstress───{750.fsstress}]
                             ├─check-parallel───nsexec───check───013───013───sed
                             ├─check-parallel───nsexec───check───251───cp
                             ├─check-parallel───nsexec───check───467───open_by_handle
                             ├─check-parallel───nsexec───check───650─┬─650───sleep
                             │                                       └─650.fsstress─┬─61*[650.fsstress───{650.fsstress}]
                             │                                                      └─2*[650.fsstress]
                             ├─check-parallel───nsexec───check───707
                             ├─check-parallel───nsexec───check───705
                             ├─check-parallel───nsexec───check───416
                             ├─check-parallel───nsexec───check───477───2*[open_by_handle]
                             ├─check-parallel───nsexec───check───140───140
                             ├─check-parallel───nsexec───check───562
                             ├─check-parallel───nsexec───check───415───xfs_io───{xfs_io}
                             ├─check-parallel───nsexec───check───291
                             ├─check-parallel───nsexec───check───017
                             ├─check-parallel───nsexec───check───016
                             ├─check-parallel───nsexec───check───168───2*[168───168]
                             ├─check-parallel───nsexec───check───672───2*[672───672]
                             ├─check-parallel───nsexec───check───170─┬─170───170───170
                             │                                       └─170───170
                             ├─check-parallel───nsexec───check───531───122*[t_open_tmpfiles]
                             ├─check-parallel───nsexec───check───387
                             ├─check-parallel───nsexec───check───748
                             ├─check-parallel───nsexec───check───388─┬─388.fsstress───4*[388.fsstress───{388.fsstress}]
                             │                                       └─sleep
                             ├─check-parallel───nsexec───check───328───328
                             ├─check-parallel───nsexec───check───352
                             ├─check-parallel───nsexec───check───042
                             ├─check-parallel───nsexec───check───426───open_by_handle
                             ├─check-parallel───nsexec───check───756───2*[open_by_handle]
                             ├─check-parallel───nsexec───check───227
                             ├─check-parallel───nsexec───check───208───aio-dio-invalid───2*[aio-dio-invalid]
                             ├─check-parallel───nsexec───check───746───cp
                             ├─check-parallel───nsexec───check───187───187
                             ├─check-parallel───nsexec───check───027───8*[027]
                             ├─check-parallel───nsexec───check───045───xfs_io───{xfs_io}
                             ├─check-parallel───nsexec───check───044
                             ├─check-parallel───nsexec───check───204
                             ├─check-parallel───nsexec───check───186───186
                             ├─check-parallel───nsexec───check───449
                             ├─check-parallel───nsexec───check───231───su───fsx
                             ├─check-parallel───nsexec───check───509
                             ├─check-parallel───nsexec───check───127───5*[127───fsx]
                             ├─check-parallel───nsexec───check───047
                             ├─check-parallel───nsexec───check───043
                             ├─check-parallel───nsexec───check───475───pkill
                             ├─check-parallel───nsexec───check───299─┬─fio─┬─4*[fio]
                             │                                       │     ├─2*[fio───4*[{fio}]]
                             │                                       │     └─{fio}
                             │                                       └─pgrep
                             ├─check-parallel───nsexec───check───551───aio-dio-write-v
                             ├─check-parallel───nsexec───check───323───aio-last-ref-he───100*[{aio-last-ref-he}]
                             ├─check-parallel───nsexec───check───648───sleep
                             ├─check-parallel───nsexec───check───046
                             ├─check-parallel───nsexec───check───753─┬─753.fsstress───4*[753.fsstress]
                             │                                       └─pkill
                             ├─check-parallel───nsexec───check───507───507
                             ├─check-parallel───nsexec───check───629─┬─3*[629───xfs_io───{xfs_io}]
                             │                                       └─5*[629]
                             ├─check-parallel───nsexec───check───073───umount
                             ├─check-parallel───nsexec───check───615───615
                             ├─check-parallel───nsexec───check───176───punch-alternati
                             ├─check-parallel───nsexec───check───294
                             ├─check-parallel───nsexec───check───236───236
                             ├─check-parallel───nsexec───check───165─┬─165─┬─165─┬─cut
                             │                                       │     │     └─xfs_io───{xfs_io}
                             │                                       │     └─165───grep
                             │                                       └─165
                             ├─check-parallel───nsexec───check───259───sync
                             ├─check-parallel───nsexec───check───442───442.fsstress───4*[442.fsstress───{442.fsstress}]
                             ├─check-parallel───nsexec───check───558───255*[558]
                             ├─check-parallel───nsexec───check───358───358───358
                             ├─check-parallel───nsexec───check───169───169
                             └─check-parallel───nsexec───check───297─┬─297.fsstress─┬─284*[297.fsstress───{297.fsstress}]
                                                                     │              └─716*[297.fsstress]
                                                                     └─sleep

A typical test run looks like:

$ time sudo ./check-parallel /mnt/xfs -s xfs -x dump
Runner 63 Failures:  xfs/170
Runner 36 Failures:  xfs/050
Runner 30 Failures:  xfs/273
Runner 29 Failures:  generic/135
Runner 25 Failures:  generic/603
Tests run: 1140
Failure count: 5

Ten slowest tests - runtime in seconds:
xfs/013 454
generic/707 414
generic/017 398
generic/387 395
generic/748 390
xfs/140 351
generic/562 351
generic/705 347
generic/251 344
xfs/016 343

Cleanup on Aisle 5?

total 0
crw-------. 1 root root 10, 236 Nov 27 09:27 control
lrwxrwxrwx. 1 root root       7 Nov 27 09:27 fast -> ../dm-0
/dev/mapper/fast  1.4T  192G  1.2T  14% /mnt/xfs

real    9m29.056s
user    0m0.005s
sys     0m0.022s
$

Yeah, that runtime is real - under 10 minutes for a full XFS auto
group test run. When running this normally (i.e. via check) on this
machine, it usually takes just under 4 hours to run the same set
of tests. i.e. I can run ./check-parallel roughly 25x times on this
machine in the same time it takes to run ./check.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check          |   7 +-
 check-parallel | 205 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+), 4 deletions(-)
 create mode 100755 check-parallel

diff --git a/check b/check
index 8131f4e2e..607d2456e 100755
--- a/check
+++ b/check
@@ -33,7 +33,7 @@ exclude_tests=()
 _err_msg=""
 
 # start the initialisation work now
-iam=check
+iam=check.$$
 
 # mkfs.xfs uses the presence of both of these variables to enable formerly
 # supported tiny filesystem configurations that fstests use for fuzz testing
@@ -460,7 +460,7 @@ fi
 
 _wrapup()
 {
-	seq="check"
+	seq="check.$$"
 	check="$RESULT_BASE/check"
 	$interrupt && sect_stop=`_wallclock`
 
@@ -552,7 +552,6 @@ _wrapup()
 
 	sum_bad=`expr $sum_bad + ${#bad[*]}`
 	_wipe_counters
-	rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
 	if ! $OPTIONS_HAVE_SECTIONS; then
 		rm -f $tmp.*
 	fi
@@ -808,7 +807,7 @@ function run_section()
 
 	init_rc
 
-	seq="check"
+	seq="check.$$"
 	check="$RESULT_BASE/check"
 
 	# don't leave old full output behind on a clean run
diff --git a/check-parallel b/check-parallel
new file mode 100755
index 000000000..c85437252
--- /dev/null
+++ b/check-parallel
@@ -0,0 +1,205 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
+#
+# Run all tests in parallel
+#
+# This is a massive resource bomb script. For every test, it creates a
+# pair of sparse loop devices for test and scratch devices, then mount points
+# for them and runs the test in the background. When it completes, it tears down
+# the loop devices.
+
+export SRC_DIR="tests"
+basedir=$1
+shift
+check_args="$*"
+runners=64
+runner_list=()
+runtimes=()
+
+
+# tests in auto group
+test_list=$(awk '/^[0-9].*auto/ { print "generic/" $1 }' tests/generic/group.list)
+test_list+=$(awk '/^[0-9].*auto/ { print "xfs/" $1 }' tests/xfs/group.list)
+
+# grab all previously run tests and order them from highest runtime to lowest
+# We are going to try to run the longer tests first, hopefully so we can avoid
+# massive thundering herds trying to run lots of really short tests in parallel
+# right off the bat. This will also tend to vary the order of tests from run to
+# run somewhat.
+#
+# If we have tests in the test list that don't have runtimes recorded, then
+# append them to be run last.
+
+build_runner_list()
+{
+	local runtimes
+	local run_list=()
+	local prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
+
+	runtimes=$(cat $basedir/*/$prev_results/check.time | sort -k 2 -nr | cut -d " " -f 1)
+
+	# Iterate the timed list first. For every timed list entry that
+	# is found in the test_list, add it to the local runner list.
+	local -a _list=( $runtimes )
+	local -a _tlist=( $test_list )
+	local rx=0
+	local ix
+	local jx
+	#set -x
+	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
+		echo $test_list | grep -q ${_list[$ix]}
+		if [ $? == 0 ]; then
+			# add the test to the new run list and remove
+			# it from the remaining test list.
+			run_list[rx++]=${_list[$ix]}
+			_tlist=( ${_tlist[*]/${_list[$ix]}/} )
+		fi
+
+	done
+
+	# The final test list is all the time ordered tests followed by
+	# all the tests we didn't find time records for.
+	test_list="${run_list[*]} ${_tlist[*]}"
+}
+
+if [ -f $basedir/runner-0/results/check.time ]; then
+	build_runner_list
+fi
+
+# split the list amongst N runners
+
+split_runner_list()
+{
+	local ix
+	local rx
+	local -a _list=( $test_list )
+	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
+		seq="${_list[$ix]}"
+		rx=$((ix % $runners))
+		runner_list[$rx]+="${_list[$ix]} "
+		#echo $seq
+	done
+}
+
+_create_loop_device()
+{
+        local file=$1 dev
+
+        dev=`losetup -f --show $file` || _fail "Cannot assign $file to a loop device"
+
+	# Using buffered IO for the loop devices seems to run quite a bit
+	# faster.  There are a lot of tests that hit the same regions of the
+	# filesystems, so avoiding read IO seems to really help. Results can
+	# vary, though, because many tests drop all caches unconditionally.
+	# Uncomment to use AIO+DIO loop devices instead.
+	#test -b "$dev" && losetup --direct-io=on $dev 2> /dev/null
+
+        echo $dev
+}
+
+_destroy_loop_device()
+{
+        local dev=$1
+	blockdev --flushbufs $dev
+	umount $dev > /dev/null 2>&1
+        losetup -d $dev || _fail "Cannot destroy loop device $dev"
+}
+
+runner_go()
+{
+	local id=$1
+	local me=$basedir/runner-$id
+	local _test=$me/test.img
+	local _scratch=$me/scratch.img
+	local _results=$me/results-$2
+
+	mkdir -p $me
+
+	xfs_io -f -c 'truncate 2g' $_test
+	xfs_io -f -c 'truncate 8g' $_scratch
+
+	mkfs.xfs -f $_test > /dev/null 2>&1
+
+	export TEST_DEV=$(_create_loop_device $_test)
+	export TEST_DIR=$me/test
+	export SCRATCH_DEV=$(_create_loop_device $_scratch)
+	export SCRATCH_MNT=$me/scratch
+	export FSTYP=xfs
+	export RESULT_BASE=$_results
+
+	mkdir -p $TEST_DIR
+	mkdir -p $SCRATCH_MNT
+	mkdir -p $RESULT_BASE
+	rm -f $RESULT_BASE/check.*
+
+#	export DUMP_CORRUPT_FS=1
+
+	# Run the tests in it's own mount namespace, as per the comment below
+	# that precedes making the basedir a private mount.
+	./src/nsexec -m ./check $check_args -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
+
+	wait
+	sleep 1
+	umount -R $TEST_DIR 2> /dev/null
+	umount -R $SCRATCH_MNT 2> /dev/null
+	_destroy_loop_device $TEST_DEV
+	_destroy_loop_device $SCRATCH_DEV
+
+	grep -q Failures: $me/log
+	if [ $? -eq 0 ]; then
+		echo -n "Runner $id Failures: "
+		grep Failures: $me/log | uniq | sed -e "s/^.*Failures://"
+	fi
+
+}
+
+cleanup()
+{
+	killall -INT -q check
+	wait
+	umount -R $basedir/*/test 2> /dev/null
+	umount -R $basedir/*/scratch 2> /dev/null
+	losetup --detach-all
+}
+
+trap "cleanup; exit" HUP INT QUIT TERM
+
+
+# Each parallel test runner needs to only see it's own mount points. If we
+# leave the basedir as shared, then all tests see all mounts and then we get
+# mount propagation issues cropping up. For example, cloning a new mount
+# namespace will take a reference to all visible shared mounts and hold them
+# while the mount names space is active. This can cause unmount in the test that
+# controls the mount to succeed without actually unmounting the filesytsem
+# because a mount namespace still holds a reference to it. This causes other
+# operations on the block device to fail as it is still busy (e.g. fsck, mkfs,
+# etc). Hence we make the basedir private here and then run each check instance
+# in it's own mount namespace so that they cannot see mounts that other tests
+# are performing.
+mount --make-private $basedir
+split_runner_list
+now=`date +%Y-%m-%d-%H:%M:%S`
+for ((i = 0; i < $runners; i++)); do
+
+	runner_go $i $now &
+
+done;
+wait
+
+echo -n "Tests run: "
+grep Ran /mnt/xfs/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
+
+echo -n "Failure count: "
+grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
+echo
+
+echo Ten slowest tests - runtime in seconds:
+cat $basedir/*/results/check.time | sort -k 2 -nr | head -10
+
+echo
+echo Cleanup on Aisle 5?
+echo
+losetup --list
+ls -l /dev/mapper
+df -h |grep xfs
-- 
2.45.2

