Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752735AbeALEQV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jan 2018 23:16:21 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0C4EFQu017818
        for <fstests@vger.kernel.org>; Thu, 11 Jan 2018 20:16:21 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2fejmxgp1e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 11 Jan 2018 20:16:21 -0800
From: Richard Wareing <rwareing@fb.com>
Subject: [PATCH v4 0/3] Fix/harden "quick" tests for realtime subvolumes
Date: Thu, 11 Jan 2018 20:16:16 -0800
Message-ID: <20180112041619.540900-1-rwareing@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, eguan@redhat.com, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

See v3 cover letter, everything still applies.

Richard Wareing (3):
  xfs/realtime: Add require_no_realtime function
  xfs/realtime: Default rtinherit=1, add _require_no_rtinherit function
  xfs/realtime: Fix direct invocations of xfs_repair

 common/rc         | 28 ++++++++++++++++++++++++++--
 tests/generic/250 |  3 +++
 tests/generic/252 |  3 +++
 tests/generic/441 |  3 +++
 tests/xfs/070     |  5 ++++-
 tests/xfs/077     |  2 ++
 tests/xfs/170     |  1 +
 tests/xfs/189     |  1 +
 tests/xfs/284     |  2 ++
 tests/xfs/291     |  5 ++++-
 10 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.9.5

