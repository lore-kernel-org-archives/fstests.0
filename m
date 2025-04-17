Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4A1C3BEA
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859538; cv=none; b=qqnmH9dNnmQKJPAnFeovUtLmigTPvm1pw+m0cy79Lw55S8Ce+2wfme5wR+PVz0fVHuyxCTA+0PRfsHWUKefl5oM0tXGP+6gl8EBLE9yt0FRdwxLqYBiWJTpsSWltIGOIzUaP2WGYdC9hECH7rA984vc6qA5tBhM4byW4Acs8mO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859538; c=relaxed/simple;
	bh=FQf6ZbR5oGnjGaJykUjHaiheJKCLxlahRk2GdoX86N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD6RZwSFQpRGgzsTERD7+4wGEGv/Xnw5pJxXNrqueZNiUU9UboJQuyHaA1fVOgz32p2Edczw8Xyo9kFUXiB2CE2rNIcQ+qrn8qUNcb+G/auBq5xsnfZQu9HhXzXw6Qbg0vUnHGz4nTBPM6JMLkf0d6MTUKK3QP6O+2oO0Llh4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ArB1hsJR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ArB1hsJR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22401f4d35aso3786245ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859536; x=1745464336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfJthm8Uu8PJ32WCYaxE34zlYJMvw55OU9t/8Diso4o=;
        b=ArB1hsJR5c/QaT2GVqrAF+INu+k6aX7eKW7thhdt2H9yS9KRMh2DVsKSkW+7RDc0nF
         GJfcdOZ9Xs7iGcZAzJ/mYur3wUq79rZlq4hsMCha5CJmh/8Fty+pyvzLq14uxP2Me+yV
         74lejkKjUOXDuisBijQUzi8ETKDpx1l7CwKNBWjbO9W6Rt1ga860VynW4UubWbynvF8t
         n+AImYc+mK1Y8azLv//PX/XYBVAb52lYgh1z5pmjIQz9Yobox4Hv8QC67zXtPpiK6kDd
         +IvMYsD5dVLUtzCZoZFxcpawUotXT1LbTOcp3zy0BHCoLJqkvk+nV/AHCMnszBDBn+Rk
         iK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859536; x=1745464336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfJthm8Uu8PJ32WCYaxE34zlYJMvw55OU9t/8Diso4o=;
        b=ioCUmjqsF4VCtAeV/rbeI8UvmDwh66q9fF0ui2bWAhsctXVIgBSnVIERfxp6/n9+hn
         tKNMstQHk0RI4ocXSuHhIa5DWGWRP1tC7GpptNn6wo4zmTn6OoLXhi7Ten27IboRA6hh
         6b4mHTV0ICJoaOjPZ+DBzg7kD0kBd5gSRypbcQL8AazfUcIDkrycWu7EFTQRN1uVL9FW
         wub0UGheeMIlt1aAVuwSsLiUjtYnyOiZ4Wcg3Gm5W4Yr5iqICe2SIg7tQrp9cYjMyOxz
         y6Rwif4ukP5BudHUui5hrwDq27XdDD0ZzxuIjMol9EX2CPHBatToFETZdZszXYyOd8pJ
         YP0A==
X-Gm-Message-State: AOJu0YxOk+Ltyu9jCnufDJ371TuaxdP98Ihfcb9ZLFRl3cIWVJEr9wWa
	5DGkXPNZ4ccg9pmoU1278E+VKzgti9zbEVwXm8r9zADD5xFGrh6iAe/jFsfi+nF6CcVw211K7jS
	k
X-Gm-Gg: ASbGncvKd5eQR5u6opKLhjX3qDwRDPU2SQ+6C5RTnc80lgJHgtpOYr0Cha9PgxjUyHq
	ijUFZ9Wn6piMFWMzw2RO6m0MMSsTd5WoC++2x+vRVUxEBKWjPVlm1L0BK4HOe+RcBkMEPZQ71Xv
	abPCo0jl6M0iQr7wvzxO54Zq+E0mnCX0l9HF6ApiyXARqwr0dZqsPrHZZC/i5bC4OtgZJbq90Ox
	B7Dews4mffOWYt0dV60kUez3faYZtAg1/n7BHLAeUPirrIO9CeYFuYWie6/amr2+e9aYq3of3/6
	FaJcOz9cAXj4nf/3g9JAeyfpopCleYg9MCPbxmsLadiRH5gbsQwP2BpZ8nLZNicICwYvCzVIp6M
	tCh7pBdXzZ0UZ
X-Google-Smtp-Source: AGHT+IEUrCAe7kJ8i1jG+mZrmTUa5Tbd4tnlsplxshNkTt2K3dDcPX8vbSlZvF7J249u0m46CGtopQ==
X-Received: by 2002:a17:903:2345:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-22c359114b0mr58295165ad.29.1744859535694;
        Wed, 16 Apr 2025 20:12:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5e9esm22306495ad.132.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAM-1lVe;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mF9-2Zge;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 16/28] check-parallel: run sections directly
Date: Thu, 17 Apr 2025 13:00:57 +1000
Message-ID: <20250417031208.1852171-17-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Currently we pass the section through to check for it to apply and
run. However, we do not reconfigure the test or external devices in
check-parallel after the initial setup, so thie results in devices
that may be incorrectly configured for the given section config we
want to run.

To fix this, we need to iterate the sections directly in
check-parallel and reconfigure the runner device setup between each
section that is run. This allows the test device and external
devices to be set up correctly for each section config.

As the test list is consumed as we walk it, we need to reset the
test list for each section that we run.

We still pass the config section through to check so that it can
also source the correct config from the section we are running.

We also add section exclusion support so that we skip sections the
same way that check currently does.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel         | 118 ++++++++++++++++++++++++++++-------------
 common/config-sections |   3 ++
 2 files changed, 84 insertions(+), 37 deletions(-)

diff --git a/check-parallel b/check-parallel
index e2cf2c8d0..23d29c7a8 100755
--- a/check-parallel
+++ b/check-parallel
@@ -15,6 +15,7 @@ runner_list=()
 runtimes=()
 show_test_list=
 run_section=""
+exclude_section=""
 iam="check-parallel"
 
 tmp=/tmp/check-parallel.$$
@@ -119,7 +120,8 @@ while [ $# -gt 0 ]; do
 
 	-f)	is_supported_fstype $2 ; export FSTYP=$2; shift ;;
 
-	-s)	run_section="$run_section -s $2"; shift ;;
+	-s)	run_section="$run_section $2"; shift ;;
+	-S)	exclude_section="$exclude_section $2"; shift ;;
 
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
@@ -202,11 +204,12 @@ fi
 # each other.
 get_next_test()
 {
+	local test_file="$test_list.$1"
 	local test=
 
 	flock 99
-	test=$(tail -1 $test_list)
-	sed -i "\,$test,d" $test_list
+	test=$(tail -1 $test_file)
+	sed -i "\,$test,d" $test_file
 	flock -u 99
 	echo $test
 }
@@ -236,10 +239,34 @@ _destroy_loop_device()
         losetup -d $dev || _fail "Cannot destroy loop device $dev"
 }
 
-runner_go()
+run_tests()
 {
+	local section="$1"
+
 	exec 99<>$tmp.test_list_lock
 
+	local test_to_run=$(get_next_test $section)
+
+	# Run the tests in it's own mount namespace, as per the comment below
+	# that precedes making the basedir a private mount.
+	#
+	# Similarly, we need to run check in it's own PID namespace so that
+	# operations like pkill only affect the runner instance, not globally
+	# kill processes from other check instances.
+	while [ -n "$test_to_run" ]; do
+		echo -n " $test_to_run "
+		unset FSTESTS_ISOL
+		if ! _tl_expunge_test $test_to_run; then
+			tools/run_privatens ./check -s $section $test_to_run >> $me/log 2>&1
+		fi
+
+		test_to_run=$(get_next_test $section)
+	done
+}
+
+runner_go()
+{
+
 	local id=$1
 	local me=$basedir/runner-$id
 	local _test=$me/test.img
@@ -250,7 +277,7 @@ runner_go()
 	local _scratch_log=$me/scratch-log.img
 	local _logwrites=$me/logwrites.img
 	local _results=$me/results-$2
-	local test_to_run=$(get_next_test)
+	local section=$3
 
 	mkdir -p $me
 
@@ -286,21 +313,7 @@ runner_go()
 
 #	export DUMP_CORRUPT_FS=1
 
-	# Run the tests in it's own mount namespace, as per the comment below
-	# that precedes making the basedir a private mount.
-	#
-	# Similarly, we need to run check in it's own PID namespace so that
-	# operations like pkill only affect the runner instance, not globally
-	# kill processes from other check instances.
-	while [ -n "$test_to_run" ]; do
-		echo "Runner $id: running test $test_to_run"
-		unset FSTESTS_ISOL
-		if ! _tl_expunge_test $test_to_run; then
-			tools/run_privatens ./check $run_section $test_to_run >> $me/log 2>&1
-		fi
-
-		test_to_run=$(get_next_test)
-	done
+	run_tests $section
 
 	wait
 	sleep 1
@@ -322,6 +335,44 @@ runner_go()
 
 }
 
+run_section()
+{
+	local section="$1"
+	local now="$2"
+	local i
+
+	echo $run_section |grep -qw $section || return
+	echo $exclude_section |grep -qw $section && return
+
+	echo
+	echo Running section: $section
+	echo
+
+	parse_config_section $section
+
+	# set up consumable test list first
+	cp $test_list $test_list.$section
+	for ((i = 0; i < $runners; i++)); do
+		runner_go $i $now $section &
+	done
+	wait
+
+	echo
+	echo Section: $section
+	echo -n "Tests run: "
+	grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
+
+	echo -n "Tests _notrun: "
+	grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
+
+	echo -n "Failure count: "
+	grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
+	echo
+
+	echo Ten slowest tests - runtime in seconds:
+	cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
+}
+
 cleanup()
 {
 	killall -INT -q check
@@ -336,6 +387,8 @@ trap "cleanup; exit" HUP INT QUIT TERM
 
 _config_setup_parallel
 
+run_section=${run_section:="$HOST_OPTIONS_SECTIONS"}
+
 _tl_setup_exclude_group "unreliable_in_parallel"
 _tl_prepare_test_list
 _tl_strip_test_list
@@ -369,23 +422,14 @@ fi
 mount --make-private $basedir
 
 now=`date +%Y-%m-%d-%H:%M:%S`
-for ((i = 0; i < $runners; i++)); do
-	runner_go $i $now &
-done;
-wait
-
-echo -n "Tests run: "
-grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
-
-echo -n "Tests _notrun: "
-grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
-
-echo -n "Failure count: "
-grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
-echo
-
-echo Ten slowest tests - runtime in seconds:
-cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
+for section in $HOST_OPTIONS_SECTIONS; do
+	run_section $section $now
+	if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
+		interrupt=false
+		status=`expr $sum_bad != 0`
+		exit
+	fi
+done
 
 echo
 echo Cleanup on Aisle 5?
diff --git a/common/config-sections b/common/config-sections
index 28bd11bab..c0ea097e8 100644
--- a/common/config-sections
+++ b/common/config-sections
@@ -436,6 +436,9 @@ _config_setup_parallel()
 		exit 1
 	fi
 
+	# strip check-parallel from the sections to run
+	export HOST_OPTIONS_SECTIONS=`echo $HOST_OPTIONS_SECTIONS | sed -e "s/$iam//"`
+
 	grep DEV $HOST_OPTIONS |grep -qv SIZE
 	if [ $? -ne 1 ]; then
 		echo "$iam config file has devices defined"
-- 
2.45.2

