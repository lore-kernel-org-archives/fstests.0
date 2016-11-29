Received: from cn.fujitsu.com ([222.73.24.84]:38188 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbcK2HdZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:25 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 00/10] Enhance btrfs qgroup test group coverage to support more mount options
Date: Tue, 29 Nov 2016 15:32:53 +0800
Message-Id: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Old test cases in btrfs qgroup test group use fixed golden output.
This limits the coverage, since mount option like compress and
inode_cache and populate output easily.

On the other hand, "btrfs check" has support for checking qgroup
correctness at least from 3 kernel release before.
And that function is proved to be stable and helped to exposed quite a
lot of qgroup bugs.

So this patchset will use "btrfs check --qgroup-report" to replace fixed
golden output, and add extra check for some existing test cases.

This will reduce false alerts and improve the coverage.
In fact, with these patches and "-o inode_cache" mount option, we have
already exposed a new qgroup bug.

Qu Wenruo (10):
  fstests: common: Introduce function to check qgroup correctness
  fstests: btrfs/017: Use new _btrfs_check_scratch_qgroup function
  fstests: btrfs/022: Add extra qgroup verification after each work
  fstests: btrfs/028: Use new wrapped _btrfs_check_scratch_qgroup
    function
  fstests: btrfs/042: Add extra qgroup verification
  fstests: btrfs/091: Use _btrfs_check_scratch_qgroup other than fixed  
      golden output
  fstests: btrfs/099: Add extra verification for qgroup
  fstests: btrfs/104: Use _btrfs_check_scratch_qgroup to replace open   
     codes
  fstests: btrfs/122: Use _btrfs_check_scratch_qgroup to replace open   
     code
  fstests: btrfs/123: Use _btrfs_check_scratch_qgroup to replace open   
     code

 common/rc           | 19 +++++++++++++++++++
 tests/btrfs/017     |  4 ++--
 tests/btrfs/017.out |  2 --
 tests/btrfs/022     |  5 +++++
 tests/btrfs/028     |  4 ++--
 tests/btrfs/042     |  3 +++
 tests/btrfs/091     |  5 ++---
 tests/btrfs/091.out |  4 ----
 tests/btrfs/099     |  3 +++
 tests/btrfs/104     | 11 ++---------
 tests/btrfs/122     |  9 ++-------
 tests/btrfs/123     |  4 +---
 12 files changed, 41 insertions(+), 32 deletions(-)

-- 
2.7.4



