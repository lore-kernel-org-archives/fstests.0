Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbaIBOWp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 2 Sep 2014 10:22:45 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 0/2] xfs buf I/O error race test
Date: Tue,  2 Sep 2014 10:22:39 -0400
Message-Id: <1409667761-50248-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Hi all,

Here's a complete test for the XFS buf I/O error race problem reported
by Alex. An incomplete rfc of this test was previously posted here:

http://oss.sgi.com/archives/xfs/2014-08/msg00261.html

This version utilizes the recently posted log recovery delay mechanism.
As such, this test only runs on kernels compiled with XFS debug support.
The first patch updates the generic require sysfs helper to support
global (i.e., non-device specific) sysfs attributes.

Brian

v1:
- Use the log recovery delay mechanism to coordinate I/O failures with
  log recovery.
rfc: http://oss.sgi.com/archives/xfs/2014-08/msg00261.html

Brian Foster (2):
  xfstests/common: don't assume sysfs attrs all reside under test dev
  xfs/051: test buffer use after free race on I/O failure in XFS log
    recovery

 common/rc         |  3 +-
 tests/xfs/011     |  2 +-
 tests/xfs/051     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/051.out |  2 ++
 tests/xfs/group   |  1 +
 5 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100755 tests/xfs/051
 create mode 100644 tests/xfs/051.out

-- 
1.8.3.1

