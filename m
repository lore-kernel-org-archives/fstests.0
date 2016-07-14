Received: from mx1.redhat.com ([209.132.183.28]:34844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbcGNMnk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:43:40 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACC1B7EA90
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 12:43:39 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 0/6 v3] xfstests: some small fixes and mkfs validation test
Date: Thu, 14 Jul 2016 14:43:28 +0200
Message-Id: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

This set is a merge of all my recent patches. The reason for the merge is that
the patches are sequentially dependent and making a set is the safest way of
ensuring their correct order after a merge.

One patch, "filename handling - fix early wildcard expansion", was
dropped for now. Patch "add _require_xfs_mkfs_validation to common/rc" is new,
and update of xfs/096 and input validation tests were changed.


Jan Tulak (6):
  xfstests: Fix installation for extended names
  fstests: filename handling for extended names in ./check was on a
    wrong place
  xfstests: remove unused variable
  xfstests: add _require_xfs_mkfs_validation to common/rc
  xfstests: update xfs/096 for new behaviour
  xfstests: Add mkfs input validation tests

 check                              |  26 +--
 common/rc                          |  29 ++++
 include/buildrules                 |  31 ++++
 tests/btrfs/Makefile               |   4 +-
 tests/cifs/Makefile                |   4 +-
 tests/ext4/Makefile                |   4 +-
 tests/f2fs/Makefile                |   4 +-
 tests/generic/Makefile             |   4 +-
 tests/overlay/Makefile             |   4 +-
 tests/shared/Makefile              |   4 +-
 tests/udf/Makefile                 |   4 +-
 tests/xfs/096                      |   1 +
 tests/xfs/400-input-validation     | 338 +++++++++++++++++++++++++++++++++++++
 tests/xfs/400-input-validation.out |   2 +
 tests/xfs/Makefile                 |   4 +-
 tests/xfs/group                    |   1 +
 16 files changed, 433 insertions(+), 31 deletions(-)
 create mode 100755 tests/xfs/400-input-validation
 create mode 100644 tests/xfs/400-input-validation.out

-- 
2.5.5

