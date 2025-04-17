Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934901D514C
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859539; cv=none; b=uM66yQpUyrzKxj9Rb1T1n5XiOF7ftz/m7rIGwOHYgcYtbLHlidFciRNP6Z/yTcp4i/Px687v8R7+JSYKiORH7VWjPmONIXrdwqrLmVV0QM30qGrbzasxwJ0dI9i0IMSyGtcqCCDl6ReXnKNpyqpqb7CwtuRTt7WIaMFGcpwOi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859539; c=relaxed/simple;
	bh=IUFFqB/OKHZzwKkzUvK/kXn+DibPR+0AD9OhVunC0Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTlicK7Wwm2pLelFbutc03I+op0tYC8V+g8bh12zExvGcFy4B0oxEpXzZz7nnLvJ4qZ+TnVrCd/zQF3bYsHUsNVTZSOyGZ+xyubd4PktdTeHcehelLYsbmMhgxJzfYnvsdE2+2KinjUDXWn+N0cXkFb/g8973Vgj4tOwZz5H1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iSkZSo+3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iSkZSo+3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22409077c06so4664295ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859537; x=1745464337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB1arepRS6BG9au7HH7kzIi/mTlmU2jzdfh7Nnbxn14=;
        b=iSkZSo+3DsXEWB7LsC1wWgi/SJ9WHuH25kgu5P1SWu0cl9s2Dkma9pIziwqJdKMqED
         g+F/KEZwnvpxutn6ofl/VrJvff8HSHF7PFHVQAek+Can/a+Se6P1tCpiPyhZ/8qOBja1
         lkeJ05tT5Cyqnr2X62UefxF35e/fjxvFBxHIF96Zq/DgGsM7DZ54IeSrZe2pjxIHF1x1
         Q++Oe+ZiTmS+s9uAh7Em2nfOlIb2jDmsUkGjsf6Io3OtPuAXlG8M5qAj6KOEMD1nVhVn
         I92cIqpdqVNr/oq3U9fEmV/hW8PduS4ZK6zHxtK8jnmNHsvUBJYe13K9AHE6CmDMvLZC
         bViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859537; x=1745464337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB1arepRS6BG9au7HH7kzIi/mTlmU2jzdfh7Nnbxn14=;
        b=iuC+OJg9mdDWhZt6aYWJSMOLeLtArr4ZD8HoazyzlGvIqbRSFHYmE8u4KRdSz2me91
         Gqejr2Ii9VmFW0LK7WsFLfPX13mJHxSMJ4wR4dYewnMJdtcJ/vXRew63Itxj6gc9fZf9
         mMiJNmAdo6XOndgrlZhN0cRqyX85aI6JWs4j81tFhwcbJwOBv8n4hhgDwWVu4KZAVzUr
         NlEJRblQEFxnpmqD7M5BIFLBX7L131RxKFYw6SWaG9pU5qfFSdO9k7HYoqUPza3J3YZj
         HmpJOdLQECqMPIwyOzWXnFgvBayF5Vk3KTk4Y/BESx8ixO+BqzijT8rNxDpqqaaahryq
         C1gQ==
X-Gm-Message-State: AOJu0YwCrHea09tdtcZypf1adMV2qfsoSkG7trCAlecyxEQZm5cM8c5T
	lCMYSudgyK7pYfQIgoZIBVr+S6ZHeidHJD5nODvDdl0yZQUZYYZrkw6uwGDKwaRdpMmg5Qxv8z2
	u
X-Gm-Gg: ASbGnct7qluKxvMaohBdhaezXG37QKeKlZE6cgEbUIuKo11P5bU/bYqXQtiI9mddkm0
	7Fr01xwUChKHjWOXGrY4SR2kA/PcD0F0y4M3WebkTlQ8ucaBmXib7lC1niWwB4aYJieYtmHeIMJ
	hAgf7prNrBP0jH8f6j9vWJdM6edHJaG9/a9/pJ4I58qg3qkbMyRXip/nCQgvcXRZ9uBnMclq5xi
	INP91ekbEmfKO7L7nvpNrOJbCj6d6oujpRAGW+4gQ6fPWYx8zx/gJ9n/gl7cCIvs2XXI6DH6WLG
	BI1j7n3PqsdAr8P6rc6m1dUj9FvZIth/uecuxfyM6PHnPNMSrTc12fYvgmRU19l9qAcN947dpZL
	vE5BZRVuTFYwQ
X-Google-Smtp-Source: AGHT+IEUXD1x4HQSwa88Qx9tDzxO+H9WL7593ZFD57+GBw5/W5ot2IAWBXGGmyuocXv0i4WqOcOQpQ==
X-Received: by 2002:a17:902:e887:b0:223:619e:71da with SMTP id d9443c01a7336-22c3598627amr62158805ad.49.1744859536900;
        Wed, 16 Apr 2025 20:12:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe6df9sm22383045ad.231.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAP-1rMD;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFE-2j8M;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 17/28] check-parallel: rebuild test list when FSTYP changes
Date: Thu, 17 Apr 2025 13:00:58 +1000
Message-ID: <20250417031208.1852171-18-david@fromorbit.com>
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

When a config section changes FSTYP, we do not rebuild the test list
that is to be run. This means that if we go from xfs to ext4, the
ext4 section will still try to run all the XFS tests, and won't try
to run the ext4 tests.

To fix this for check-parallel, check if the FSTYP has changed and
if it has strip the old tests from the test list and add the new
tests back to it.

This is effectively a zero-day bug in the check config section
support code.

While there, remain the internal _tl_file variable and the filename
used to hold command line tests. The check-parallel change uncovered
that it was using the same filename ($tmp.test_list) as the test
list code was using and they were stepping on each other.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel   | 81 +++++++++++++++++++++++++++++-------------------
 common/test_list |  8 ++---
 2 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/check-parallel b/check-parallel
index 23d29c7a8..374ac8e96 100755
--- a/check-parallel
+++ b/check-parallel
@@ -175,7 +175,6 @@ time_order_test_list()
 	local rx=0
 	local ix
 	local jx
-	#set -x
 	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
 		echo $_tl_tests | grep -q ${_list[$ix]}
 		if [ $? == 0 ]; then
@@ -198,6 +197,26 @@ if ! $_tl_randomise -a ! $_tl_exact_order; then
 	fi
 fi
 
+# Build the test list from the test sepcification and FSTYP settings. This can
+# be called at any time to regenerate the list as the include/exclude lists
+# generated from the command line are retained separately to the test list
+# itself.
+setup_test_list()
+{
+	_tl_prepare_test_list
+	_tl_strip_test_list
+
+	if ! $_tl_randomise -a ! $_tl_exact_order; then
+		if [ -f $basedir/runner-0/$prev_results/check.time ]; then
+			time_order_test_list
+		fi
+	fi
+
+	# reverse the order of tests so that the get_next_test() can pull from the file
+	# tail rather than the head.
+	echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
+}
+
 # Grab the next test to be run from the tail of the file.
 # Returns an empty string if there is no tests remaining to run.
 # File operations are run under flock so concurrent gets are serialised against
@@ -242,6 +261,7 @@ _destroy_loop_device()
 run_tests()
 {
 	local section="$1"
+	local logfile="$2"
 
 	exec 99<>$tmp.test_list_lock
 
@@ -257,7 +277,7 @@ run_tests()
 		echo -n " $test_to_run "
 		unset FSTESTS_ISOL
 		if ! _tl_expunge_test $test_to_run; then
-			tools/run_privatens ./check -s $section $test_to_run >> $me/log 2>&1
+			tools/run_privatens ./check -s $section $test_to_run >> $logfile 2>&1
 		fi
 
 		test_to_run=$(get_next_test $section)
@@ -308,12 +328,12 @@ runner_go()
 	rm -f $RESULT_BASE/check.*
 
 	# Only supports default mkfs parameters right now
-	wipefs -a $TEST_DEV > $me/log 2>&1
-	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $me/log 2>&1
+	wipefs -a $TEST_DEV >> $_results/log 2>&1
+	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $_results/log 2>&1
 
 #	export DUMP_CORRUPT_FS=1
 
-	run_tests $section
+	run_tests $section $_results/log
 
 	wait
 	sleep 1
@@ -327,10 +347,10 @@ runner_go()
 	_destroy_loop_device $SCRATCH_LOGDEV
 	_destroy_loop_device $LOGWRITES_DEV
 
-	grep -q Failures: $me/log
+	grep -q Failures: $_results/log
 	if [ $? -eq 0 ]; then
 		echo -n "Runner $id Failures: "
-		grep Failures: $me/log | uniq | sed -e "s/^.*Failures://"
+		grep Failures: $_results/log | uniq | sed -e "s/^.*Failures://"
 	fi
 
 }
@@ -339,19 +359,33 @@ run_section()
 {
 	local section="$1"
 	local now="$2"
+	local results="$basedir/*/results-$now"
 	local i
 
 	echo $run_section |grep -qw $section || return
 	echo $exclude_section |grep -qw $section && return
 
 	echo
-	echo Running section: $section
+	echo Running section: $section $now
 	echo
 
 	parse_config_section $section
 
-	# set up consumable test list first
+	# update the test list if necessary, then set up
+	# the consumable test list for this section to use.
+	if [ "$last_fstyp" != "$FSTYP" ]; then
+		setup_test_list
+		last_fstyp=$FSTYP
+	fi
+	echo FS Type: $FSTYP
+
+	if [ -n "$show_test_list" ]; then
+		echo Test list to run:
+		cat $test_list
+		return
+	fi
 	cp $test_list $test_list.$section
+
 	for ((i = 0; i < $runners; i++)); do
 		runner_go $i $now $section &
 	done
@@ -360,17 +394,18 @@ run_section()
 	echo
 	echo Section: $section
 	echo -n "Tests run: "
-	grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
+	grep Ran $results/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
 
 	echo -n "Tests _notrun: "
-	grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
+	grep "^Not run" $results/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
 
 	echo -n "Failure count: "
-	grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
+	grep Failures: $results/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
 	echo
 
 	echo Ten slowest tests - runtime in seconds:
-	cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
+	cat $results/check.time | sort -k 2 -nr | head -10
+
 }
 
 cleanup()
@@ -386,27 +421,8 @@ cleanup()
 trap "cleanup; exit" HUP INT QUIT TERM
 
 _config_setup_parallel
-
 run_section=${run_section:="$HOST_OPTIONS_SECTIONS"}
-
 _tl_setup_exclude_group "unreliable_in_parallel"
-_tl_prepare_test_list
-_tl_strip_test_list
-
-if ! $_tl_randomise -a ! $_tl_exact_order; then
-	if [ -f $basedir/runner-0/$prev_results/check.time ]; then
-		time_order_test_list
-	fi
-fi
-
-# reverse the order of tests so that the get_next_test() can pull from the file
-# tail rather than the head.
-echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
-if [ -n "$show_test_list" ]; then
-	echo Time ordered test list:
-	cat $test_list
-	exit 0
-fi
 
 # Each parallel test runner needs to only see it's own mount points. If we
 # leave the basedir as shared, then all tests see all mounts and then we get
@@ -422,6 +438,7 @@ fi
 mount --make-private $basedir
 
 now=`date +%Y-%m-%d-%H:%M:%S`
+last_fstyp=
 for section in $HOST_OPTIONS_SECTIONS; do
 	run_section $section $now
 	if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
diff --git a/common/test_list b/common/test_list
index 2b3ae9fbf..092b3ed17 100644
--- a/common/test_list
+++ b/common/test_list
@@ -20,7 +20,7 @@ _XGROUP_LIST=
 _tl_exact_order=false
 _tl_randomise=false
 _tl_have_test_args=false
-_tl_file="$tmp.test_list"
+_tl_cli_tests="$tmp._tl_cli_tests"
 _tl_exclude_tests=()
 _tl_tests=
 
@@ -122,8 +122,8 @@ _tl_prepare_test_list()
 {
 	unset _tl_tests
 	# Tests specified on the command line
-	if [ -s $_tl_file ]; then
-		cat $_tl_file > $tmp.list
+	if [ -s $_tl_cli_tests ]; then
+		cat $_tl_cli_tests > $tmp.list
 	else
 		touch $tmp.list
 	fi
@@ -281,7 +281,7 @@ _tl_setup_cli()
 				if grep -Eq "^$test_name" $group_file; then
 					# in group file ... OK
 					echo $_tl_src_dir/$test_dir/$test_name \
-						>> $_tl_file
+						>> $_tl_cli_tests
 					_tl_have_test_args=true
 				else
 					# oops
-- 
2.45.2

