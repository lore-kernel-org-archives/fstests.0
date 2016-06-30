Received: from mx1.redhat.com ([209.132.183.28]:52484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbcF3Mtg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 08:49:36 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0700A92A4D
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 12:49:36 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-180.bos.redhat.com [10.18.41.180])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5UCnZ2j019397
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 08:49:35 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 0/2] xfs: test for readahead use after free panic
Date: Thu, 30 Jun 2016 08:49:32 -0400
Message-Id: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This introduces some generic dm-delay infrastructure, which is basically
copied from the existing dm-flakey bits, and a test that causes current
upstream XFS to panic.

A kernel fix will be posted shortly...

Brian

Brian Foster (2):
  xfstests: support dm-delay to introduce I/O delays
  tests/xfs: test for post umount readahead completion panic

 common/dmdelay    | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |  2 ++
 tests/xfs/group   |  1 +
 4 files changed, 182 insertions(+)
 create mode 100644 common/dmdelay
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

-- 
2.5.5

