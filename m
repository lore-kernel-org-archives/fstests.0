Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F521CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860567; cv=none; b=mndg1dLIKUMVXyPQFNqVmWoFx1kWa+D+PJ51+Srt3hIid2vNyfShovpXFUnbVEsNDlR3amOvedh7omPblvqwVo55exsP69b7kMbOhIkkaPGoUIUSubj7h5EyMr0E5b8slhP65ubPI6TqLWm7H/a5nOE6i5xBAybFhun5S6JQHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860567; c=relaxed/simple;
	bh=Oa1I65i0M9qWkjkuRdviCWWwrxF218aIYoifly5clBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkqTENLuB/wmocrQadYgm+OHuQGnZGhiVw8N0uZ7rQv2M0ilOW3ainffOxO4LBnBTrLXNomeHTX67U+CfBco3js0MIdnsGrUyK07m02jfnnQMXkXJiE3j5xW/6nGwxdKdYyAHJdHvKOayH9Yz1EUPiNFytlTNckZeuuaABcdIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=O7/jKRFe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="O7/jKRFe"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-303a66af07eso206648a91.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860565; x=1745465365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKlgksC1LoyG0GT+wsMwWWd82vm3gQTfKctDQg+5taw=;
        b=O7/jKRFeKKFEEaYbAOuQWw2bBoo899lZnND3la/NZsNUe8h5UVMfd0zD2tV3GaK94H
         kzFElhZ+K40s3PLEcFu5GMFsC2lbNSX8JN8041B64gMKAXgeULl5HVGkPACXKZxnGhqK
         MmSKDjXOWQtuRlWqiLE8M+q0c0xjavT7Zh+Yg5DfVj/cJWr710iFLNIgrGQWP5tLLEmB
         7R1jqldvRYwnc1CNNIiNEZb1tdJ/1FuGEPWn+24EK3u7ByjSlEaH+KDE7rO9pq6qgLYL
         UuWG3tc9yECnk9CiN4IU4RVI2pU0vwMqDnkSQTHqYgbbrW7usOKoeuaNrCgLU06p1VKt
         CHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860565; x=1745465365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKlgksC1LoyG0GT+wsMwWWd82vm3gQTfKctDQg+5taw=;
        b=SGeoqfoSTN1WFRIn1WBqTTQ94No6ZA5UoACkakEMnC5vuqd+vCTf2jaCyRA+yaTLXw
         4i5uNdkVU7XCrTRR7JxE5ibrVj9ndPVqey3V7TkMa8ft1paE+nrpFzeo1KCQMYlTnpy7
         RYJ7ByefmDjaazgOkUElR28vmf405aZlcKD3q8dTyjOWZJ+9Tu/uuKm5ZnZAMbNHCUm7
         sKyVeu+L4c1wc+XMTKrtUIdI1zxn2mqGR7YQJbl3jJkDpJw3sW7uv4Pq/vIDSbQQbc+Q
         /U3Ms8K0kG41lmo0osvQQNW7XPKNnGgIhFz7OvR/TjS9MJYC8ykdCsZ6KaZBkATtGpP4
         k+ig==
X-Gm-Message-State: AOJu0YxrGrVXjeb/cLy1pTUgmxrboB2pA5awlC8/pbaCvlZfJ6uG3cEw
	44NIw/4CiV6yHf+qw9odbWuRT0JjrSHqjNFtQo2PQTHT2eNgDRJg6gAM/lSKvrBKib8ysFJHvCA
	y
X-Gm-Gg: ASbGncv5LbEYIV0d1vxUF8fdk5TqLvoNb0H3XgXn+zPPrgiMHx/uUFQbl4inAj0UGSI
	IyQf85JxYAx1IEWSmMWanQsDasm2EbsGsjRQThY6n3IaPMbpLAH+DVd5IICEkZkWZP9vzK1+5Bl
	TX6WUgV9g6EUFBgIiN0iqRmcDpS4AHH5qkzxPYkEulZOYtfhQf2qNmMI4Z5dn7pVY+tBm10UTVN
	r1QgytNYUO0rKVnr37qJCrPipg9rWtty59TiA1LTiYS9FjIkVk5BvsFub1xK+zup/je4A92uWlw
	GaD64pJ6p3UhaAj0UXid1Shh9lAuoUkbzdmAkPZQfqJiOIlStWVttusDnlCFYib66ZL2giRMTC8
	/5w==
X-Google-Smtp-Source: AGHT+IErfWN9ZKhF0Ru8NH876j9KGwWGE68MXQDWtPUyeK6r0PUi5InAIyTAYGjYaSdKKfauGtR0vQ==
X-Received: by 2002:a17:90b:534d:b0:2ff:7b28:a519 with SMTP id 98e67ed59e1d1-30864172548mr6423257a91.30.1744860565337;
        Wed, 16 Apr 2025 20:29:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cbff8sm2469739a91.49.2025.04.16.20.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:24 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9l-0P8y;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEP-1JKm;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 07/28] check-parallel: adjust concurrency according to CPU count
Date: Thu, 17 Apr 2025 13:00:48 +1000
Message-ID: <20250417031208.1852171-8-david@fromorbit.com>
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

Concurrency is currently hard coded at 64 worker threads. This is
too many for small CPU count machines; the idea is to create a
sustained load of roughly one test per CPU as they are mostly single
threaded/single process tests. The number "64" was chosen because
I've been developing this functionality on a 64p VM.

Rather than hard coding the concurrency, probe the number of CPUs
available and create that many running contexts as the default
concurrency to use.

Further, add a CLI option to specify the number of threads to run so
that we can over- or under-commit the CPU resources to enable direct
benchmarking of performance with different levels of concurrency.

Let's use that capability to show how much check-parallel can
benefit small systems. Using a single check execution thread for all
tests inside a 4p control group to limit maximum CPU usage to the
equivalent of a small 4p machine:

$ time sudo numactl -C 4-7 ./check-parallel -D /mnt/xfs -t 1 -g quick -s xfs -x dump -X generic/531
Runner 0 Failures:  generic/504
Tests run: 921
Tests _notrun: 272
Failure count: 2
.....

real    61m31.362s
user    0m0.029s
sys     0m0.059s

the quick group on XFS takes *over an hour* to run.

If we use the same 4p control group setup and run with 8 test
execution threads to ensure the 4 CPUs are fully utilised for most
of the test run:

$ time sudo numactl -C 4-7 ./check-parallel -D /mnt/xfs -t 8 -g quick -s xfs -x dump -X generic/531
Runner 7 Failures:  generic/504
Tests run: 921
Tests _notrun: 145
Failure count: 1
.....

real    17m33.124s
user    0m0.009s
sys     0m0.017s

The same test run takes only 17m33s. The same number of tests were
run, the same failures occurred. [ Ignore the differences in
notrun/failure count - the multi-file aggregation currently doesn't
work correctly for the single log file case. ]

That's a reduction in test runtime of ~72% for a 4 CPU system. Or,
if we want to measure it the other way, we get a ~3.5x improvement
in runtime scalability. i.e. going from 1 -> 4 CPUs being used for
test execution (4x increase) we get a 3.5x improvement in
scalability when we go from check to check-parallel.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/check-parallel b/check-parallel
index cb5d6aedf..0649a417f 100755
--- a/check-parallel
+++ b/check-parallel
@@ -10,7 +10,7 @@
 # the loop devices.
 
 basedir=""
-runners=64
+runners=$(getconf _NPROCESSORS_CONF)
 runner_list=()
 runtimes=()
 show_test_list=
@@ -30,6 +30,7 @@ usage()
 
 check options
     -D <dir>		Directory to run in
+    -t <n>		Number of concurrent tests to  run
     -n			Output test list, do not run tests
     -r			randomize test order
     --exact-order	run tests in the exact order specified
@@ -81,6 +82,7 @@ while [ $# -gt 0 ]; do
 	-\? | -h | --help) usage ;;
 
 	-D)	basedir=$2; shift ;;
+	-t)	runners=$2; shift ;;
 	-g)	_tl_setup_group $2 ; shift ;;
 	-e)	_tl_setup_exclude_tests $2 ; shift ;;
 	-E)	_tl_setup_exclude_file $2 ; shift ;;
@@ -111,6 +113,11 @@ if [ ! -d "$basedir" ]; then
 	echo "Invalid basedir specification"
 	usage
 fi
+if [[ $runners -le 0 || $runners -gt 1024 ]]; then
+	echo "Invalid thread specificaton: $runners"
+	usage
+fi
+
 if [ -d "$basedir/runner-0/" ]; then
 	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
 fi
-- 
2.45.2

