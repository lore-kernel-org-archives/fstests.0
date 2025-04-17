Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A91CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860574; cv=none; b=JZOgGlueQXVlBFpsz1dWRb/NOx8sUmOvWfrJq/Npia5JBsS9l7W79i8gjMfFzyX5ZTeEuu+4OWm1l1eqgRNILcGj/RQyct4DAe9A261qGDF8kIsn8POteBrMzVKzoTKbrod3oD8fzv+IRi/iA0TT1rjnXsvI1QKuczPWQrDrpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860574; c=relaxed/simple;
	bh=sCs5zcWlgQ0clyKhBNMptOpjgadv4WIchV5zxKR82O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQZTr+ynLb9V9ndjhNUQi5D+pzXlX+/zNytdFLA7i0rK7hPLiwoT9lOykzN8nbmI5RxOWmywq+QFpihSxIj0XMalJZh3jwmAxVDzBPX0ykAQ/f+cWiHeD+GPZaQaz+0Fd552vhfso9nlSeaI0mNy+ewbPtWPibyP5GYZiQu+9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XUhO1F6h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XUhO1F6h"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso3154035ad.3
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860573; x=1745465373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0eaBnY9ENvDU9vBAgn5mVHCAeLEEM7xltvFacXWMc8=;
        b=XUhO1F6hGP/Ev+4TMJvwWWPcVIj3bFupfJAClAGEYzGRcDE0cS3QlZQJWIazBGXjYh
         rmCgDkebgvFaagURIWMwSO7pCLRSZeei6O4D0mdJYdTYY5M2Rvu+fEfa0pD1V5uX7Huf
         IlUMOg8ZMr+xyFSa2BqAQlf03g3nrvsrKv9wLf5t3/tkq08qNzk9aW4abWL+T04pPoS9
         yEJW4AU3nmYhh1mMr58RbtOBRGG3EbIA0U5XrIZEdWyrYdGmWrCy89wIZLVqZCiHu1XB
         0b1Wipbx552nfLqlF1UYjA4nnxNQbE5dGUvbrei8VPSr0boHUyAuOu/RmEUR7qpmraWL
         dSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860573; x=1745465373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0eaBnY9ENvDU9vBAgn5mVHCAeLEEM7xltvFacXWMc8=;
        b=EDHRwLf58dh2sdgIqYblrEDfLFU87Mkfz2v8V8NoEnkJLl7qVzsGm8cED/JiQGPpUL
         63uUMZvTExgrZca4sCBX+GF9QCxnnCE33OosWf8i2PLTY8LNluTzfXJpFhNogkF0XsxW
         5yFvnqF3bL0lGz+vkN+8dNEpdCk01yR3btRA17n7W4X8G/sDUelN3L1A3FpjPIV/MPzy
         ynaensxV5gYiQ2yK5aR49uFxoaB/paaDwJOeLNK1My6E27j2d+ckqvVyom7sLbDlxCun
         bsl9XPphpybq83M4Nei05dAEVnsReb5053l4nvGqtINpkqLvbwbkUMkxxNz8Z8ANcBAt
         5j2g==
X-Gm-Message-State: AOJu0YxmySsIQvTFk5IeZs9uO56Gx0YS45yAgh3N+9K1P4oKsBZiVyWi
	vsFDV6Io5uzEVSxh/RQZzIh1ufcVQa3APorTK12siARvUHTXBj/nBwWizYrVSNh34eriPSc9EWr
	N
X-Gm-Gg: ASbGncuQr//aMy3DaigFBU/Gx9sKqTlXlKyF2lXGzt5zywJSrLV4jkePzK/nU+kYn5I
	zGt1btUNZNbCElT14CqOgCkWrc0Cp+3mfjxLiVVp6yNwO5pb074dAR9xxdT1BehuYxcXFrW7qfO
	6zikD86u+TXhaXlLn2srK3r3CNn+rj9ymZuiwcRZlOAIZmY4JYHAn752RmJ/NXzUEXQADI14bn6
	jC9AW8pryaUuQSRtjzrcE4R7L/M/2IkDHFHD88fbvGrfoXForzkhmEwmBldlUnM5QHMXDydbSK6
	571iFqwijUDC2ld8w1xzJEfPhDdSp54kVDi4RwJ1bDvZyAw8rp6MlulbZo8e/AOmJ2Mh6mODg0+
	IVQ==
X-Google-Smtp-Source: AGHT+IFlrsMe6RpqE964+AfisSAN8lLAcuI8UVhqs+FR6E25hxIC2FSZfsTvJBMSHwNNTJl1Z9Rnfw==
X-Received: by 2002:a17:902:ec90:b0:223:58ff:c722 with SMTP id d9443c01a7336-22c35911353mr68507515ad.28.1744860572590;
        Wed, 16 Apr 2025 20:29:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f11a98sm22694725ad.60.2025.04.16.20.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:32 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAH-1YJR;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mF3-2Q4P;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 15/28] check-parallel: de-batch test execution
Date: Thu, 17 Apr 2025 13:00:56 +1000
Message-ID: <20250417031208.1852171-16-david@fromorbit.com>
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

To improve how check-parallel runs tests, it needs to run tests
directly from the runner threads. We currently batch them based on
runtime before we execture any tests, but this results in runner 0
always having a test list with runtime longer than the test list for
runner N.

As a result, we can end up with higher numbered runners finishing
all their tests before runner 0 has even finished the first test it
was given to run. Hence we end up with check-parallel starting with
maximum concurrency, but the test concurrency reduces as the run
goes on.

To fix this, we need a dynamic test list such that each runner only
needs to be scheduled to run a single test at a time. When they have
finished the current test, they can pop the next test to run off the
time ordered stack and execute that. Hence test runners won't stop
running until there are no more tests to run, hence maximising
concurrency across the entire test run.

To do this, we first need a test list mechanism that is safe for
concurrent destacking from multiple test runners. We place the
test list in a temporary file, then use file locks to serialise
access to the temporary file.

We order the list in the test file from lowest runtime to
highest. This means that running tests from longest to shortest
runtime destacks from the end fo the file. This means that the next
test to run is always the last line fo the file and we can simply
use truncation based mechanisms to consume the test during
destacking.

Running tests individually via check like this is inefficient as
there is a lot of check setup and initialisation overhead.  However,
by increasing the utilisation of the test runner threads, overall
runtime of check-parallel does not increase with this change.
Reduction of this repeated overhead will also be addressed in future
patches.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 75 +++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/check-parallel b/check-parallel
index 6fc86fb92..e2cf2c8d0 100755
--- a/check-parallel
+++ b/check-parallel
@@ -18,6 +18,7 @@ run_section=""
 iam="check-parallel"
 
 tmp=/tmp/check-parallel.$$
+test_list="$tmp.test_list"
 
 . ./common/exit
 . ./common/test_names
@@ -150,9 +151,6 @@ if [ -d "$basedir/runner-0/" ]; then
 	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
 fi
 
-_tl_prepare_test_list
-_tl_strip_test_list
-
 # grab all previously run tests and order them from highest runtime to lowest
 # We are going to try to run the longer tests first, hopefully so we can avoid
 # massive thundering herds trying to run lots of really short tests in parallel
@@ -198,22 +196,22 @@ if ! $_tl_randomise -a ! $_tl_exact_order; then
 	fi
 fi
 
-# split the list amongst N runners
-split_runner_list()
+# Grab the next test to be run from the tail of the file.
+# Returns an empty string if there is no tests remaining to run.
+# File operations are run under flock so concurrent gets are serialised against
+# each other.
+get_next_test()
 {
-	local ix
-	local rx
-	local -a _list=( $_tl_tests )
-	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
-		seq="${_list[$ix]}"
-		rx=$((ix % $runners))
-		if ! _tl_expunge_test $seq; then
-			runner_list[$rx]+="${_list[$ix]} "
-		fi
-		#echo $seq
-	done
+	local test=
+
+	flock 99
+	test=$(tail -1 $test_list)
+	sed -i "\,$test,d" $test_list
+	flock -u 99
+	echo $test
 }
 
+
 _create_loop_device()
 {
         local file=$1 dev
@@ -240,6 +238,8 @@ _destroy_loop_device()
 
 runner_go()
 {
+	exec 99<>$tmp.test_list_lock
+
 	local id=$1
 	local me=$basedir/runner-$id
 	local _test=$me/test.img
@@ -250,6 +250,7 @@ runner_go()
 	local _scratch_log=$me/scratch-log.img
 	local _logwrites=$me/logwrites.img
 	local _results=$me/results-$2
+	local test_to_run=$(get_next_test)
 
 	mkdir -p $me
 
@@ -291,7 +292,15 @@ runner_go()
 	# Similarly, we need to run check in it's own PID namespace so that
 	# operations like pkill only affect the runner instance, not globally
 	# kill processes from other check instances.
-	tools/run_privatens ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} >> $me/log 2>&1
+	while [ -n "$test_to_run" ]; do
+		echo "Runner $id: running test $test_to_run"
+		unset FSTESTS_ISOL
+		if ! _tl_expunge_test $test_to_run; then
+			tools/run_privatens ./check $run_section $test_to_run >> $me/log 2>&1
+		fi
+
+		test_to_run=$(get_next_test)
+	done
 
 	wait
 	sleep 1
@@ -320,20 +329,32 @@ cleanup()
 	umount -R $basedir/*/test 2> /dev/null
 	umount -R $basedir/*/scratch 2> /dev/null
 	losetup --detach-all
+	rm -rf $tmp.*
 }
 
 trap "cleanup; exit" HUP INT QUIT TERM
 
 _config_setup_parallel
 
-split_runner_list
+_tl_setup_exclude_group "unreliable_in_parallel"
+_tl_prepare_test_list
+_tl_strip_test_list
+
+if ! $_tl_randomise -a ! $_tl_exact_order; then
+	if [ -f $basedir/runner-0/$prev_results/check.time ]; then
+		time_order_test_list
+	fi
+fi
+
+# reverse the order of tests so that the get_next_test() can pull from the file
+# tail rather than the head.
+echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
 if [ -n "$show_test_list" ]; then
 	echo Time ordered test list:
-	echo $_tl_tests
-	echo
+	cat $test_list
+	exit 0
 fi
 
-
 # Each parallel test runner needs to only see it's own mount points. If we
 # leave the basedir as shared, then all tests see all mounts and then we get
 # mount propagation issues cropping up. For example, cloning a new mount
@@ -349,20 +370,10 @@ mount --make-private $basedir
 
 now=`date +%Y-%m-%d-%H:%M:%S`
 for ((i = 0; i < $runners; i++)); do
-
-	if [ -n "$show_test_list" ]; then
-		echo "Runner $i: ${runner_list[$i]}"
-	else
-		runner_go $i $now &
-	fi
-
+	runner_go $i $now &
 done;
 wait
 
-if [ -n "$show_test_list" ]; then
-	exit 0
-fi
-
 echo -n "Tests run: "
 grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
 
-- 
2.45.2

