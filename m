Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCEFC0C
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964787; cv=none; b=pgLDCBhwGi5abLMA4oU8w+3f4T7/g/NqyLaqxB0IqqbuczzaBS2dXLphDzkinIeAUDDqZBTmpYollHtgCMm/Zo9jek5djsel/D4W8gmY1Q7amOTQlI61ohWtf67C0gULQx6RpBnP9Tl94l97ZM1moPhSa3LoLJZMVYSFnRRDHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964787; c=relaxed/simple;
	bh=biuZXjCha37WSuDqCEe8lsO9No2/TrE3Hj8DZ9WhgAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THvCDUPcOVJB6ouPpSn8PRgbYViC6/ia/FNn3EqsvBdrtBar617XhGID2FKRHDpGkxiiXKdD0Ha8/K36Es5VB8VqYBqh4UtY2HmrNZGHW88z4cCgVx/FQDRsMW3dV8R/3ULjIX8eIaU9kbK7/Agad4fqYFJwknP7aI4qt3z5iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FPHG6PgX; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FPHG6PgX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721964784; x=1753500784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=biuZXjCha37WSuDqCEe8lsO9No2/TrE3Hj8DZ9WhgAE=;
  b=FPHG6PgXY4GNirqIIEYIrAU1WgsVhKhA0bg9mWxM9ZAzwAx91bMUnyX7
   Pxi00CkdSVm+dRIi4BMX7KkU/CyNadAmbhYU8ZdEtmYzjkwVOj3QrKTX+
   M8d6iJJ4FrIjvIAqFdWvFenMMRyiNR6PEWAK9q+jdPvp6D/M5T06DyPFE
   Dw07Iovc7VYMo4z/y2gnuKpSRaZgQsmtyw/3C5pkaObu8GeopUW59W4I4
   ufn/g8xXjsuBsJdTCBmCKIGC1195I/jFTYWzrGvCAIaRxwDOQAyLs+KFh
   Lw9sNOyC30R60ulWI3hQeTc0bhk7xaN5DsYXgddHTkkGM/H6WP/uIvy2d
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="147630460"
X-IronPort-AV: E=Sophos;i="6.09,237,1716217200"; 
   d="scan'208";a="147630460"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 12:32:56 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 21E733B202
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 12:32:54 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 48F59D3F00
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 12:32:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D4E8E2008B38D
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 12:32:52 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 64FB71A0002;
	Fri, 26 Jul 2024 11:32:52 +0800 (CST)
From: Ma Xinjian <maxj.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Ma Xinjian <maxj.fnst@fujitsu.com>
Subject: [Issue] xfs: g/754, xfs_repair reports mismatch between format and size in symlink ino
Date: Fri, 26 Jul 2024 11:33:42 +0800
Message-ID: <20240726033342.1140741-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28552.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28552.004
X-TMASE-Result: 10--15.343200-10.000000
X-TMASE-MatchedRID: hs9D2gaFIvw23AXUgL0utSZm6wdY+F8KBGvINcfHqhfDQeGGV/t6W+K5
	fhRxt1aA7aNKlE9CoEpVhnxWlpagXFYhsfYDNozrfOaYwP8dcX6y2aVB7PCjFYX7FMW9wKnPa3A
	6hcNu8nBQlBV/yf2TpJW17JVbFIiv/ZG8oSoOiZRntEdzQBf3IascWEcqpe5Lb3Wpj9NSXKxNsi
	/bk0au/ZCmC/tkNyfQj/pFz/QcMFtar5w2HtLCZDzHAJTgtKqwMzbF1gbxlQa+NoS24uNuA659P
	qiGJBeBeNwTkAnhVbPJYSspdGUQuIKsAsgH2MpmuV7H+spKHhOd2Wz0X3OaLZsoi2XrUn/Jn6Kd
	MrRsL14qtq5d3cxkNQwWxr7XDKH8dxy/pllwtg8ubvN+CMC0IZf9wLAYEOoWpvZHnrbNE65CJk/
	qE7tnXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi

Using upstream kernel, the symlink does not get corrupted in the test of generic/754 on xfs.
But the check of xfs_repair still fails with "mismatch between format (2) and size (297) in symlink ino 139".
Does xfs_repair need to make corresponding modifications to the upstream kernel fix commit?
Could anyone help take a look?

Package Version:
kernel: 6.10.0
xfs_repair: 6.9.0

Results:
```
# ./check generic/754
FSTYP -- xfs (non-debug)
PLATFORM -- Linux/x86_64 localhost 6.10.0 #2 SMP PREEMPT_DYNAMIC Wed Jul 24 05:36:54 EDT 2024
MKFS_OPTIONS -- -f /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/xfstests/scratch

generic/754 _check_xfs_filesystem: filesystem on /dev/loop1 is inconsistent (r)
(see /root/xfstests-dev/results//generic/754.full for details)


HINT: You _MAY_ be missing kernel fix:
XXXXXXXXXXXXX xfs: allow symlinks with short remote targets

Ran: generic/754
Failures: generic/754
Failed 1 of 1 tests
```

Output of "xfs_repair -n":
```
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan (but don't clear) agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
mismatch between format (2) and size (297) in symlink ino 139
bad data fork in symlink 139
would have cleared inode 139
mismatch between format (2) and size (330) in symlink ino 140
bad data fork in symlink 140
would have cleared inode 140
        - agno = 1
        - agno = 2
        - agno = 3
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
unknown block state, ag 0, blocks 14-15
        - check for inodes claiming duplicate blocks...
        - agno = 1
        - agno = 0
entry "symlink.288" at block 0 offset 288 in directory inode 128 references free inode 139
        would clear inode number in entry at offset 288...
        - agno = 2
        - agno = 3
entry "symlink.320" at block 0 offset 312 in directory inode 128 references free inode 140
        would clear inode number in entry at offset 312...
mismatch between format (2) and size (297) in symlink ino 139
bad data fork in symlink 139
would have cleared inode 139
mismatch between format (2) and size (330) in symlink ino 140
bad data fork in symlink 140
would have cleared inode 140
No modify flag set, skipping phase 5
Phase 6 - check inode connectivity...
        - traversing filesystem ...
entry "symlink.288" in directory inode 128 points to free inode 139, would junk entry
entry "symlink.320" in directory inode 128 points to free inode 140, would junk entry
bad hash table for directory inode 128 (no data entry): would rebuild
would rebuild directory inode 128
        - traversal finished ...
        - moving disconnected inodes to lost+found ...
Phase 7 - verify link counts...
No modify flag set, skipping filesystem flush and exiting.
```
