Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:42768 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753676AbaIQBmN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Sep 2014 21:42:13 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XU4Fo-0003kW-7g
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XU4Fo-0006O6-5d
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/5] xfstests: cleanups and new tests.
Date: Wed, 17 Sep 2014 11:41:48 +1000
Message-Id: <1410918113-23516-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi y'all,

The first two patches are minor cleanup patches. The first changes
some tests that can leave large deposits on the test fs when they
fail and that can lead to ENOSPC issues on small test devices. The
second is another test that shouldn't check the scratch device at
the end.

The remaining three patches are new generic tests that exercise data
corruption issues that we've tripped over in the past week on XFS.
The test cases have been isolated by Brian Foster and Eric Sandeen -
they deserve the credit for narrowing down the minimal tests to
expose the problems. I just added a few more corner cases and
packaged them for xfstests.

These failures manifest on block size smaller than page size
filesystems, and we have XFS fixes pending for these failures:

http://oss.sgi.com/pipermail/xfs/2014-September/038191.html
http://oss.sgi.com/pipermail/xfs/2014-September/038167.html

Ext4 folks, can you confirm that both the truncate tests fail on
ext4 with data corruption on 1k/2k filesystems? I'm pretty sure that
I have the corrupt hexdump outputs in the golden output files for
the tests and if I have that means ext4 is corrupting data in a
similar manner to XFS.  Eric is already looking at this but
could probably use some more help. ;)

-Dave.

