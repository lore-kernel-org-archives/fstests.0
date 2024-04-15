Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB458286A
	for <fstests@vger.kernel.org>; Mon, 15 Apr 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205365; cv=none; b=uZUSZ1yzfu++KbS6PGm+81Kk15wQXeLrZ7qMSoJ/84eaduw3+Jl/miZJOrI/uDeRBV81ZfRbHyR115fRS4ACcg/l9X9vc09K6gsc55slwZyNjEix83CdJlZA+yPDlbnLtJUd2R/6sx9+JsXb763TAcDeQXd4glULrPtd0MDoDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205365; c=relaxed/simple;
	bh=1Iw5VL2HVZufa06Im7ZhNAqnOBLMz7L663VZKa8RHSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aggKZ4hmjtq1xTeYZnAM3WjUFf0frqtjMHpS6cXb1AqM1t5xQQSmkuVC+6rdEaW5jot3hBJICCl5YO4EJdXEpMxzHxREzwiC4DboksZ8azAfCMIIkVATTzhCWOnJgOBvkyqKXsxzkfvYeqT1uum9lIvBTiEQYVmVfEoSndgEkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=h373TMu+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="h373TMu+"
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43FIMVUJ013218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713205353; bh=abeY5c5ZX0DWJzh9+LBiLUvpUsLTwvckGEabxEHmbeE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=h373TMu+UmuwHUyVqSbX9CJx7ajYyIu4PZDBOEtJNyDg1Umywg1wUQMe7uNhORbPL
	 cfKdrOlAzCGp9VDm6D2302pSVeT0XgZS+EuwTaPIb3RZ6rudXPFIVnmEclk0p8KHi3
	 GZhTd/ti/qtVq1IGW7gT1WmogvJGhnne3Fns4x30hzUD1bAWXRuPXkhmqNH3H02SDq
	 7qT3iNt4Uh2ENgVJ4HzonzzFO8WMvC1iskllHnmDkiBzuT+Fkd3o9K5+zXBQvVg8R/
	 bjj99p3RgqL1CoFOEqJJZWR8WJcErinCXzLvxQGmIKrJrnQKIqBueSTtOJiD1PszTJ
	 gDKXEjezu33tw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 44F0D15C0CBA; Mon, 15 Apr 2024 14:22:31 -0400 (EDT)
Date: Mon, 15 Apr 2024 14:22:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: xfstests flakiness in generic/095 triggered by fio 3.37
Message-ID: <20240415182231.GA2649469@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was updating various components in my xfstests test appliance, and
it appears that fio 3.37 is causing generic/095 to become flaky.
Previously, I had been using fio 3.35 and a quick test shows that fio
3.36 seems to be OK.  So the change seems to be somethinig that was
introduced between fio 3.36 and 3.37.

The test failures seem to be caused by the following unexpected
message in the output file:

fio: first I/O failed. If /xt-vdc/file1 is a zoned block device, consider --zonemode=zbd

The following comment in tests/generic/095 suggests to my suspicious
mind that the above warning message isn't getting suppressed when
--ignore_error=,EIO is passed to fio:

  # There's a known EIO failure to report collisions between directio and buffered
  # writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
  # at here.

.... but I could be wrong about that.

For now, I've just switched to using fio 3.36, since there's nothing
in my testing that really _requires_ 3.37.  It might be that we should
just work around this by filtering out the warning message in
xfstests.  Or maybe we should make a change in fio?

						- Ted

--- /tmp/b	2024-04-15 14:01:06.048592838 -0400
+++ /tmp/a	2024-04-15 14:01:02.180602551 -0400
@@ -1,18 +1,20 @@
-TESTRUNID: tytso-20240415133921
+TESTRUNID: tytso-20240415131932
 KERNEL:    kernel 6.9.0-rc3-xfstests #328 SMP PREEMPT_DYNAMIC Mon Apr 15 13:04:29 EDT 2024 x86_64
 CMDLINE:   -c ext4/4k,xfs/4k -C 20 generic/095
 CPUS:      2
 MEM:       7680
 
-ext4/4k: 20 tests, 86 seconds
-xfs/4k: 20 tests, 75 seconds
-Totals: 40 tests, 0 skipped, 0 failures, 0 errors, 161s
+ext4/4k: 20 tests, 8 failures, 86 seconds
+  Flaky: generic/095: 40% (8/20)
+xfs/4k: 20 tests, 7 failures, 71 seconds
+  Flaky: generic/095: 35% (7/20)
+Totals: 40 tests, 0 skipped, 15 failures, 0 errors, 157s
 
-FSTESTIMG: gce-xfstests/xfstests-amd64-202404151325
+FSTESTIMG: gce-xfstests/xfstests-amd64-202404122347
 FSTESTPRJ: gce-xfstests
 FSTESTVER: blktests 56d7e53 (Fri, 12 Apr 2024 16:03:20 +0900)
 FSTESTVER: e2fsprogs v1.47.0-144-g441741fc (Tue, 8 Aug 2023 16:08:52 -0400)
-FSTESTVER: fio  fio-3.36 (Fri, 20 Oct 2023 04:30:43 -0600)
+FSTESTVER: fio  fio-3.37 (Tue, 26 Mar 2024 15:13:51 -0600)
 FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
 FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
 FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
@@ -21,10 +23,10 @@
 FSTESTVER: quota  v4.05-56-g00534e7 (Mon, 29 Jan 2024 11:59:57 +0100)
 FSTESTVER: util-linux v2.40 (Wed, 27 Mar 2024 12:46:59 +0100)
 FSTESTVER: xfsprogs v6.6.0 (Mon, 5 Feb 2024 13:43:13 +0100)
-FSTESTVER: xfstests-bld f9077fe2 (Sat, 13 Apr 2024 16:34:23 -0400)
+FSTESTVER: xfstests-bld 4bb62098 12 Apr 2024 20:03:16 -0400)
 FSTESTVER: xfstests v2024.03.31-10-g554b613ae (Fri, 12 Apr 2024 22:06:49 -0400)
 FSTESTVER: zz_build-distro bookworm
 FSTESTCFG: ext4/4k xfs/4k
 FSTESTSET: generic/095
 FSTESTOPT: count 20 fail_loop_count 0 aex
-GCE ID:    7786599483943475363
+GCE ID:    6536244786506030920


Note: the changes between 4bb62098 and f9077fe2 in xfstests-bld do not
affect the test appliance.  This commits reflect some minor fixes to
xfstests-bld's regression test suite, and adding flex and
libsqlite3-dev to the build chroot, since that's needed by newer
versions of util-linux....



