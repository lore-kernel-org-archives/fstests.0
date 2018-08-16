Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731269AbeHPKVu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Aug 2018 06:21:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G7OU7c084126
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:21 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw2y2m7wv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Aug 2018 03:25:20 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 01:25:20 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 00/16] Fix tests to work on non-4k block sized fs instances
Date: Thu, 16 Aug 2018 12:56:30 +0530
Message-Id: <20180816072646.14490-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

This patchset fixes tests (mostly XFS specific ones) to work on
variable block size. These patches now use the output of "od" utility
to verify the contents of the test files instead of the md5sum
utility.

The patchset modifies _filter_fiemap() filter function to optionally
print the file offset range in block size units.

Chandan Rajendra (16):
  Fix xfs/009 to work with 64k block size
  xfs/050: Fix "Push past soft inode limit" case
  Fix xfs/050 to work with 64k block size
  Fix xfs/074 to work with 64k block size
  Fix xfs/127 to work with 64k block size
  Fix xfs/139 to work with 64k block size
  Fix xfs/140 to work with 64k block size
  Fix xfs/190 to work with 64k block size
  Fix xfs/299 to work with 64k block size
  xfs/325: Inject free_extent error after CoW operation
  Fix generic/102 to work with 64k block size
  Fix generic/172 to work with 64k block size
  Filter fiemap output by FS block size
  Fix generic/177 to work with 64k block size
  Fix generic/230 to work with 64k block size
  Fix generic/235 to work with 64k block size

 common/punch          | 19 ++++++++---
 tests/generic/102     |  4 +--
 tests/generic/102.out | 20 +++++------
 tests/generic/172     |  4 +--
 tests/generic/177     | 20 ++++++-----
 tests/generic/177.out | 23 ++++++++-----
 tests/generic/230     | 24 ++++++++------
 tests/generic/230.out | 16 ++++-----
 tests/generic/235     |  2 +-
 tests/generic/235.out |  4 +--
 tests/xfs/009         | 92 ++++++++++++++++++++++++++++++++++++++++++---------
 tests/xfs/009.out     | 66 ++++++++++++++++++------------------
 tests/xfs/050         | 23 ++++++++-----
 tests/xfs/050.out     | 60 ++++++++++++++++-----------------
 tests/xfs/074         | 23 ++++++++++---
 tests/xfs/127         |  2 +-
 tests/xfs/139         | 12 +++----
 tests/xfs/139.out     |  8 +++--
 tests/xfs/140         |  9 ++---
 tests/xfs/190         | 44 +++++++++++++++++++-----
 tests/xfs/299         | 23 ++++++++-----
 tests/xfs/299.out     | 60 ++++++++++++++++-----------------
 tests/xfs/325         |  5 +--
 tests/xfs/325.out     |  2 +-
 24 files changed, 355 insertions(+), 210 deletions(-)

-- 
2.9.5
