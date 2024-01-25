Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24946131E4F;
	Thu, 25 Jan 2024 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706220643; cv=none; b=ZemIFwwGzKWrjJ8d07GwFWdJS/Rn9BVwqFs3mo8ysnnVSAbEoTb3kolaCPyC9odvs5Nm+8nn16usyzWnp96LxawwJv+TP9OS9EHyEpZgyFbnT9yYIWrIqkLd74EFZiew9GHZ2FeDZUPQfScsHwrGWQMADv34p7eMvwmGYe7BgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706220643; c=relaxed/simple;
	bh=6nEkZLZ7p3dr5kXhsPCwWR+Q+E8Pzzse+GgC+j9UQYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HC8PmupwEJyiMllPJfB3gyJDCBVb3U55qI9mJJcTneovANtQkail65TCwNZU+PfEsPW21SQoF/91CVvnSecjbJZxjSFzE87iyRu+y16HoVR2TpYPN7Tf0RRNs19aYZjNDGJisIbRPIAsj0nGhyeh1xm8q7VhMX7xaDyBsPXbGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3akNRIj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3akNRIj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=aZpAFQLkOSY2ywqiNuH8NraNKFQvOw1bfy2Vf88xMhc=; b=i3akNRIjGKWXVLMZdUIxTQq7hh
	Nub4WICTWGvyvUHlpGBmU0b8tkROiiloDx+Ixo1mtxFjz6wyagSnycDyLydpBM3qMl9iZOz6IVprM
	pE+69OHLEhwDKykOqEv/O2jSF6FnLKgDALBOeN5OeKCue8B+eMK21g3ZhgFH/7qoVWF9HMZSClVvT
	DWWlgw3hW3cx5eqLdVPqds2HjvSy0fLMG4Iv3FR7ZaKb44USX7SmcdhJQXa8igtj0UUADtvO8RjAm
	OX3A4qpQx718klRuHrJJ4eQ2vRJ1Wz4ej2JKIpqOqyQfQann2PVrj/plXp1v1fQKcNVac30Mnq/Rh
	lPQhJx7Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT7vh-000000029MB-1gng;
	Thu, 25 Jan 2024 22:10:37 +0000
Date: Thu, 25 Jan 2024 14:10:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: kdevops@lists.linux.dev, Chandan Babu R <chandan.babu@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>
Cc: p.raghav@samsung.com,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	zlang@redhat.com, Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, djwong@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	fstests@vger.kernel.org, gost.dev@samsung.com
Subject: [PATCH kdevops] fstests: provide kconfig guidance for SOAK_DURATION
Message-ID: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

The kdevops test runner has supported a custom SOAK_DURATION for
fstests, however we were not providing any guidance. This means folks
likely disable this. Throw a bone and provide some basic guidance and
use 2.5 hours as the default value. There are about 46 tests today
which use soak duration, this means if you are testing serially it
increase total test time by about 5 days than the previously known
total test time.

Note that if you are using kernel-ci and using a max loop goal of 100
that means 500 days extra, so about 1.3 years extra total test time.
If enabling soak duration you may want to then re-evaluate your loop
target goal for kernel-ci for kdevops.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Chandan, Amir, lemme know what you think of a default 2.5 hours default
if soak duration is enabled. The only thing is the math indicates that
if you are going to enable kernel-ci we won't finish this year.

To be clear, we've picked up testing with soak duration seriously for
our LBS testing. It is why we've been able to find pretty hard to
reproduce issues even on the page cache for the baseline [0], ie, without
LBS. While folks have seemed to have found value in adopting 2.5 hours
and of the results we have found, it obviously means a scaling issue
to consider to decide when we're done with testing our baseline.

At first I wrote this patch just to provide basic guidance for kdevops,
but after doing a bit of the math on how it also extends total test
time, *with* our kernel-ci effort, it reveals clearly we should probably
reconsider lowering the kernel-ci threshold a bit if adopting soak
duration.

CC'ing a bit wider audience so to get a bit better idea of what folks
might consider a sensible value for your own testing too. From what
we've been observing, SOAK_DURATION allows us to catch bugs faster than
just increasing the kernel-ci count, however, using both let's us catch
even more bugs too.

To help *reduce* the amount of time to test we've deployed many kdevops
XFS clusters to help test the baseline. This is why our count time on
kernel-ci no is about 50-60 with a soak duration of about 2.5 hours.

Also please not that the reported bugs so far are the ones with crashes,
there are other failures too, but we just haven't had the time to disect
and report failures which are non-fatal (crashes) as crashes have been
our priority.

[0] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md

 playbooks/roles/fstests/defaults/main.yml |  3 +
 workflows/fstests/Kconfig                 | 89 ++++++++++++++++++++---
 workflows/fstests/Makefile.sparsefiles    |  4 +
 3 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/playbooks/roles/fstests/defaults/main.yml b/playbooks/roles/fstests/defaults/main.yml
index 2f70f9549cde..4a1f5dec5827 100644
--- a/playbooks/roles/fstests/defaults/main.yml
+++ b/playbooks/roles/fstests/defaults/main.yml
@@ -30,6 +30,9 @@ fstests_test_logdev_mkfs_opts: "/dev/null"
 fstests_test_dev_zns: "/dev/null"
 fstests_zns_enabled: False
 
+fstests_soak_duration_enable: False
+fstests_soak_duration: 0
+
 fstests_uses_no_devices: False
 fstests_generate_simple_config_enable: False
 fstests_generate_nvme_live_config_enable: False
diff --git a/workflows/fstests/Kconfig b/workflows/fstests/Kconfig
index 985a7847b6c7..bbd8927b3cd3 100644
--- a/workflows/fstests/Kconfig
+++ b/workflows/fstests/Kconfig
@@ -760,15 +760,23 @@ config FSTESTS_RUN_LARGE_DISK_TESTS
 	  to run. The "large disk" requirement is test dependent, but
 	  typically, it means a disk with capacity of at several 10G.
 
-config FSTESTS_SOAK_DURATION
-	int "Custom Soak duration to be used"
-	default 0
+config FSTESTS_ENABLE_SOAK_DURATION
+	bool "Enable custom soak duration time"
 	help
-	  Custom Soak duration to be used during test execution. If you set this
-	  to a non-zero value then fstests will increase the amount of time it
-	  takes to run certain tests which are time based and support using
-	  SOAK_DURATION. A moderate high value setting for this is 9900 which is
-	  2.5 hours.
+	  Enable soak duration to be used during test execution. If you are not
+	  interested in extending your testing then leave this disabled.
+
+	  Using a custom soak duration to a non-zero value then fstests will
+	  increase the amount of time it takes to run certain tests which are
+	  time based and support using SOAK_DURATION. A moderate high value
+	  setting for this is 9900 which is 2.5 hours.
+
+	  Note that we have 46 tests today which will be able to use soak
+	  duration if set. This means your test time will increase by the
+	  soak duration * these number of tests. When soak duration is
+	  enabled the test specific watchdog fstests_watchdog.py will be
+	  aware of tests which require soak duration and consider before
+	  reporting a possible hang.
 
 	  As of 2023-10-31 that consists of the following tests which use either
 	  fsstress or fsx or fio. Tests either use SOAK_DURATION directly or they
@@ -786,7 +794,7 @@ config FSTESTS_SOAK_DURATION
 	  - generic/648 - fsstress + disk failures on loopback
 	  - generic/650 - fsstress - multithreaded write + CPU hotplug
 
-	  The tests below use _scratch_xfs_stress_scrub() to stress
+	  All the tests below use _scratch_xfs_stress_scrub() to stress
 	  test an with fsstress with scrub or an alternate xfs_db operation.
 
 	  - xfs/285
@@ -825,4 +833,67 @@ config FSTESTS_SOAK_DURATION
 	  - xfs/729
 	  - xfs/800
 
+if FSTESTS_ENABLE_SOAK_DURATION
+
+choice
+	prompt "Soak duration value to use"
+	default FSTESTS_SOAK_DURATION_HIGH
+
+config FSTESTS_SOAK_DURATION_CUSTOM
+	bool "Custom"
+	help
+	  You want to specify the value yourself.
+
+config FSTESTS_SOAK_DURATION_PATHALOGICAL
+	bool "High (48 hours)"
+	help
+	  Use 48 hours for soak duration.
+
+	  Using this with 46 tests known to use soak duration means your test
+	  time will increase by about 92 days, or a bit over 3 months if run
+	  serially.
+
+config FSTESTS_SOAK_DURATION_HIGH
+	bool "High (2.5 hours)"
+	help
+	  Use 2.5 hours for soak duration.
+
+	  Using this with 46 tests known to use soak duration means your test
+	  time will increase by about 5 days if run serially.
+
+config FSTESTS_SOAK_DURATION_MID
+	bool "Mid (1 hour)"
+	help
+	  Use 1 hour for soak duration.
+
+	  Using this with 46 tests known to use soak duration means your test
+	  time will increase by about 2 days if run serially.
+
+config FSTESTS_SOAK_DURATION_LOW
+	bool "Low (30 minutes)
+	help
+	  Use 30 minutes for soak duration.
+
+	  Using this with 46 tests known to use soak duration means your test
+	  time will increase by about 1 day if run serially.
+
+endchoice
+
+config FSTESTS_SOAK_DURATION_CUSTOM_VAL
+	int "Custom soak duration value (seconds)"
+	default 0
+	depends on FSTESTS_SOAK_DURATION_CUSTOM
+	help
+	  Enter your custom soak duration value in seconds.
+
+endif # FSTESTS_ENABLE_SOAK_DURATION
+
+config FSTESTS_SOAK_DURATION
+	default 0 if !FSTESTS_ENABLE_SOAK_DURATION
+	default FSTESTS_SOAK_DURATION_CUSTOM_VAL if FSTESTS_SOAK_DURATION_CUSTOM
+	default 1800 if FSTESTS_SOAK_DURATION_LOW
+	default 3600 if FSTESTS_SOAK_DURATION_MID
+	default 9900 if FSTESTS_SOAK_DURATION_HIGH
+	default 172800 if FSTESTS_SOAK_DURATION_PATHALOGICAL
+
 endif # KDEVOPS_WORKFLOW_ENABLE_FSTESTS
diff --git a/workflows/fstests/Makefile.sparsefiles b/workflows/fstests/Makefile.sparsefiles
index c5ca20a9c462..7dd129c4f9cc 100644
--- a/workflows/fstests/Makefile.sparsefiles
+++ b/workflows/fstests/Makefile.sparsefiles
@@ -44,6 +44,10 @@ FSTESTS_ARGS += run_large_disk_tests='$(FSTESTS_RUN_LARGE_DISK_TESTS)'
 FSTESTS_ARGS += run_auto_group_tests='$(FSTESTS_RUN_AUTO_GROUP_TESTS)'
 FSTESTS_ARGS += run_custom_group_tests='$(FSTESTS_RUN_CUSTOM_GROUP_TESTS)'
 FSTESTS_ARGS += exclude_test_groups='$(CONFIG_FSTESTS_EXCLUDE_TEST_GROUPS)'
+
+ifeq (y,$(CONFIG_FSTESTS_ENABLE_SOAK_DURATION))
+FSTESTS_ARGS += fstests_soak_duration_enable='True'
+endif
 FSTESTS_ARGS += fstests_soak_duration='$(CONFIG_FSTESTS_SOAK_DURATION)'
 
 ifeq (y,$(CONFIG_FSTESTS_ENABLE_RUN_CUSTOM_TESTS))
-- 
2.42.0

