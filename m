Received: from userp1040.oracle.com ([156.151.31.81]:33190 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbcLKVwv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Dec 2016 16:52:51 -0500
Subject: [PATCH 0/7] xfstests: misc reflink test fixes
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Sun, 11 Dec 2016 13:52:45 -0800
Message-ID: <148149316504.31093.16129068344227450710.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com, darrick.wong@oracle.com
Cc: ocfs2-devel@oss.oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi all,

The following patchset enable the use of xfstests to test reflink
functionality under ocfs2.  The first patch tests the ability to reflink
into and out of inline-data files on ocfs2.  Patches 2-6 fix various
problems with the tests that came up when qualifying ocfs2.

The last patch maliciously corrupts ext4 and xfs filesystems to
exploit nonexistent checking of i_size in order to coerce Linux into
loading a file with negative size.  It then exploits integer overflows
in the VFS writeback code to hard lock the kernel.  Don't run the tests
in this patch ({ext4,xfs}/40[01]) unless you have a fixed kernel (4.10?)

Comments and questions are, as always, welcome.

--D
