Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E41C863C
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859538; cv=none; b=mhhYp0i/wamYtFL+6wV1XvVQNLVpOKzUHNXh03DTxLo/JAfh2ocsZjCgPx+DPKFg6wM/3sTqVI+ziqlNP1/9c6qSqjyTUXLNWL9P8T0SkSEHN6No6AUIkDwRCM4aGRN/F+w+4GaldlMPzEXx+878KxieZv5o7OF/Sx3gvomWoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859538; c=relaxed/simple;
	bh=hgTSmTre2NvYZJ+/9JA+o8iyiRFoEFjnGXZ6nnsNyBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh3UqsftREtoj4YCf13Fsa4WM09/ZM8la96p0PBUY/2V6aaf2qxOxfDxPjkMJc8nfUpBfkH6okPE9n02zppy5eQsWrIvIHiBqWq5dr/go4bFoqofiYWlFJr0JxVDNLicbCDGTdtRx0e/i1vALF4d4MpKcZqDAmC3lMA3a0za7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=n6AUaJIT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="n6AUaJIT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2295d78b433so3264905ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859536; x=1745464336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCYmFdvLrtVzQSRwACgXKT2fugUZmonwz0mWtOlS/5c=;
        b=n6AUaJIT4cn114bXYJ8AvieWdDanP07nNqgBwAXrO4CNGROynclSE+obF64Ss8e6ny
         qAaa3x3GG3GVZ0/qV/eExxfh7oaJ2+4lYJg7BhBKB9osqB5hEssHOhEuOMmxx5NLh6kT
         jH1zDjIh+d3Qp1BlcN7kQUv31DXan8nf+JYXHdLBRjSERsG2m1tpwDaVdJRXoiEPZEf1
         as1KggiQCv3Ms/J6toiiXJJTNPICa4+pgPvHXrF3Yfx+b9hc9zTbx8myN+2FCC+jwVqw
         G7yrpD5Hw6751OvuxulrSgOIiIBJicBL3xQtH+8+2J8qdE0ZoGueYQ3of1XmBSsaVrBE
         VxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859536; x=1745464336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCYmFdvLrtVzQSRwACgXKT2fugUZmonwz0mWtOlS/5c=;
        b=W/O/mYWDUQ0OKLsqfskGcGrkDJXJDx3oOsA1R9ys/2lSAJjmIQxEuHDgEYtLIQDEd8
         OFC5CnDUFdPwLME8MwjgNKzwr2ctY6GsgZHVVBSLJeuU53d4eaq5UhwXhP2rvWRbC1mZ
         HwU9VbUNOfSBEFq+OYH5jxVpaqNP5+q74SZkRphePLuRlNAPFlG9aStS+eQ3WrD1xQVb
         nNevJW3HsPLEMtwLqhmyl6ZwxjfLm0TJ2/Os/r8dCcaMCk5nnsWDfSVX1+lD3O0vcL0C
         bNWSALQeFE+dalZL92st+u0HpTG1OZ+CYrNWeowEczj8oc9tzuPnvTVTaH40/vHWiG/7
         OiAg==
X-Gm-Message-State: AOJu0Yx4IYlTiyi76+GR7KNvfsiTEWuWevZREiaFv5B/Xlmd8PLplmS/
	Mpw7Tf5mHYcQwmLRAO+nSaS5BFDWWJeGgZpkcGCnTKgnaJBKm8jaQMkXSsqlS2A7XH1XUhtD/Ma
	d
X-Gm-Gg: ASbGnctZxZHn6y4/6COaHOAb4ue2pb9fWgY/Hp+s9qs9/zdO1WN/BpHk7ms8GLIeSXG
	IctYlmPGtwjDnlYjBjtJgePQLaHoHm+7zgqFVnZTkTN8HAbBWcFEuU3H2JHuqahh8tUxj4X9w2W
	Um1Q3S2/9DiqvFEGlKk2Q4dzKSi9E9FrrtpXate7tZRB6fgvfiZzpbkdXg9exNXqiyzRW322q2Z
	uV2YzqQkYwRmQbc/y3t8f7a2cXaC6+EY9yfbaPjtV/rP566u9j6aFEwN8oxU+E3QUfzzarmB2mk
	K6PG3WcUdPKfxvPJKAIStdypQvJH1+cotnNBaGncszfUTA3gRxHtqVl+srFx43SK5rbdECskd/s
	dsqeq1iUI7SPX
X-Google-Smtp-Source: AGHT+IG1QLH6MEe2XfgoAP+7Tv5yt91R0GzcOhO239YeptLGcIbVi7v9OM5sLkOph7E8O+Jl9rLH7A==
X-Received: by 2002:a17:902:ef44:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-22c35990b95mr66862445ad.50.1744859536103;
        Wed, 16 Apr 2025 20:12:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d199sm22349845ad.90.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffd-00000009Y9K-3ffy;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mDu-0Dwh;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 00/28] check-parallel: Running tests without check
Date: Thu, 17 Apr 2025 13:00:41 +1000
Message-ID: <20250417031208.1852171-1-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This set of patches is intended to move check-parallel away from
using check to execute tests.

To do this, we need to share a bunch of check code between check and
check-parallel. This is mainly the code that parses and builds the
test list, the config section parsing and iteration, and the test
execution loop itself.

To do this, test list parsing and building is factored out of check
into common/test_list. check is converted to use the test list
functions at the same time, and then check-parallel is converted to
use the factored code to directly build it's test list rather than
the open coded grep hack it currently uses.  This allows
check-parallel CLI to use the same group selection interface as
check.

The next change is to factor the config section parsing out of
common/config and move it to common/config-section. This allows
check-parallel to parse and implement section iteration itself
without needing to run all the environment setup code in
common/config. This also allows check-parallel to implement it's own
config section to define the device sizes that it will use
independently of the sections that run tests.

Next, we change check-parallel to use a global test list that runner
scripts can safely dequeue the next test to run. This uses a test
list file and a lock file to serialise access to the file. Hence a
runner can dequeue the next test and remove it from the test list
file without racing with any other runner trying to dequeue the next
test to run. This means we get rid of the static per-runner test
lists that result in many runners finishing and going idle while
other test runners have pending tests still to run. i.e. all test
runners keep executing tests until there are no tests left in the
queue, hence keeping utilisation as high as possible across the test
run.

Then we factor the test execution loop out of check and put it in
common/test_exec. This abstraction makes the results array part of
the test execution, as well using a context defined helper
"_run_seq" to do the actual execution of the test. This allows the
test execution loop to be completely generic, whilst allowing check
and check-parallel to do completely independent things with
individual test execution and overall results reporting.

Finally, we change check-parallel to run tests directly via the
common/test_exec infrastructure rather than executing them via
check. This requires a new helper function that does the test
environment setup in the private mount+pid namespace, but this is
much simpler and faster than using check itself to execute
individual tests. This last bit of functionality is still a work in
progress, so this specific patch is still tagged with [RFC].

There are lots of other bits of changes. The way common/rc and
common/config are used is changed. common/config only sets up the
execution environment now, and should not contain any code that
needs to be executed outside of environment setup. It should only be
sourced once at the highest level to set up the environment, and
never called again.

common/rc is similar - all directly executed code has been removed
from it, and that is now called from the high level code that needs
initialisation work done.  It no longer sources common/config,
either. The test preamble does not need to run init_rc() any more;
they just need to source the generic and fs specific functions the
tests may run. Also, because check does some weird things and lots
of _requires....() functions assume the TEST_DEV is mounted without
first running _require_test(), it also needs to ensure the TEST_DEV
is mounted...

check-parallel can now take a "-t N" parameter to specify how many
execution threads it will use. If this is not specified, it will
default to the number of CPUs in the machine. Testing with 4p
restrictions show that check-parallel will run the quick group 3.5x
faster on a 4p system with 8 execution threads than it will with a
single execution thread. IOWs, even on small test systems,
check-parallel can result in dramatic reductions in test runtime
over check.

On a 64 p machine, testing XFS with the quick group drops from 61
minutes to just under 4 minutes. Testing XFS with the auto group
drops from 246 minutes to just under 8 minutes.

Other miscellaneous stuff in the series:

	- kill non-numeric test name support
	- creating common/exit for all the general test exit
	  functions to fix circular dependencies between common/rc
	  and common/config
	- fix iscratch_mkfs_sized to make USE_EXTERNAL on XFS work
	  the same as ext4.
	- dm-logwrites devices are now created by check-parallel
	- several test conversions from sync() to syncfs()
	- removal of a could of stale .c test source files.
	- address poor CPU count scaling in a couple of tests

I have tried not to cause any regressions for people running plain
check. I've tested that a bit with XFS and ext4, but I can't
guarantee that there aren't issues I haven't uncovered. e.g. btrfs,
as yet, is untested. It is unfortunate that the problem I seek to
address - running exhaustive check testing across many filesystem
types and configurations is prohibitively expensive in terms of time
- is the very reason I can't really adequately test check for
regressions as I develop check-parallel functionality...

Thoughts, comments and code review all welcome!

-Dave.

 .gitignore                          |   1 -
 check                               | 727 ++++--------------------------------
 check-parallel                      | 351 ++++++++++++++---
 common/config                       | 612 +-----------------------------
 common/config-sections              | 461 +++++++++++++++++++++++
 common/dmlogwrites                  |   5 +-
 common/exit                         |  48 +++
 common/preamble                     |  19 +-
 common/rc                           | 253 +++++++++++--
 common/report                       |   2 +-
 common/test_exec                    | 377 +++++++++++++++++++
 common/test_list                    | 308 +++++++++++++++
 common/test_names                   |   8 +-
 new                                 |  24 --
 src/Makefile                        |   4 +-
 src/bulkstat_unlink_test.c          |  12 +-
 src/bulkstat_unlink_test_modified.c | 193 ----------
 src/fsync-tester.c                  |   2 +-
 src/open_by_handle.c                |   6 +-
 src/scaleread.c                     | 224 -----------
 src/scaleread.sh                    |  64 ----
 src/stale_handle.c                  |  15 +-
 tests/generic/531                   |   8 +-
 tests/xfs/259                       |   1 -
 tests/xfs/271                       |   2 -
 tools/run_test.sh                   | 116 ++++++
 26 files changed, 1954 insertions(+), 1889 deletions(-)

