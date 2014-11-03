Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:50411 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaKCHlF convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 3 Nov 2014 02:41:05 -0500
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id sA37f4ot006873
	for <fstests@vger.kernel.org>; Mon, 3 Nov 2014 02:41:04 -0500
Date: Mon, 3 Nov 2014 02:41:04 -0500 (EST)
From: Xu Wang <xuw@redhat.com>
Message-ID: <707521534.1995887.1415000464631.JavaMail.zimbra@redhat.com>
In-Reply-To: <195605038.1993779.1414999815830.JavaMail.zimbra@redhat.com>
Subject: btrfs/010: what's the purpose of test case
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

  I run the btrfs/010 for kernel 3.10, the result is failed. When I read the case, I think it may be wrong.
  So I post this letter, and wanna to verify it.

  The case(btrfs/010) firstly produced a file with some extents in a sub volume, then created 2 snaps of the
  sub volume. Then defrag the file in sub volume, and hope the extents numbers are same for sub volume, snap1
  and snap2.
  The btrfs's snapshot is based on cow, so defrag the original sub volume's file will not affect the file in 
  snapshot? Am I right? 
  If I am right, the operation "num_extent_orig=`_extent_count $subvol/foobar`" in btrfs/010 should be before
  the defrag operation. And I will send a patch to fix it.

  Best regards,

-- 
George Wang 王旭

Kernel Quantity Engineer
Red Hat Software (Beijing) Co.,Ltd
IRC:xuw
Tel:+86-010-62608041
Phone:15901231579
9/F, Tower C, Raycom

