Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10B4683
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294206; cv=none; b=ClOTSzaMuS6uwQCjIOgrpiZagkvrIXUPzfrLdNBKTxqr58l5xvp5VwyAz+JrKxHDrPrt+gDyukF+fnPFV6okia67zxr5I4XDPvxqgsvGiBKBcBzbrcJxfVTw9HJ8pkTbuZ7fjhr+hpMzww2VHEAf9E2qZcf9viIWowWTeVO05x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294206; c=relaxed/simple;
	bh=xkAVfYao+oPVT7/HqZC4rii9+p2mhTUQQielzvvlwFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GcPmArKVYzL473HK8WIg+lXfBYMO9UY4NDnsbHRbpPSCcQP8l4fsWSEV10zsupcCwx89cacY9QC/1ZSLjknnJTItUh5+IM7OXof40o9mdYf50BcSqsr7Jmk0dw4wRqMxSYLoKlido+vAViQJDGtZardS/qruWDe3bNfjSBn+GKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JVRjSQIh; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JVRjSQIh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1731294205; x=1762830205;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xkAVfYao+oPVT7/HqZC4rii9+p2mhTUQQielzvvlwFI=;
  b=JVRjSQIhfPX43d6TJH/rc0mi3+tFb9xfyX54LfmS+4Jc+5eDkkpm5a0c
   1aimXZE/4R72jMhiun3I2C9zaQ3alOeVkBCdvcvutRKggQZVjr+CH9MgC
   I7kntB1XgjLYg3k74hca5gAePsiToUJxglsK6jRCGJQXgwOiIxuQb0kN7
   RbMUdXdmbNJYXbWoEUn4X3aRJtFUMMqlPVm7Am35tB684yfAdzCgcvG0M
   s1fmAw/8ZBxXjgTug+wTS9AmAThDI+olGv2FFsHagZbbrK9cBJ0jJu+WU
   YhcNOHT7e3YDk5H/Eu+O3LzhQGcx0Q6HeFO+G3Lb/QHA6VASyJWqYoHXv
   w==;
X-CSE-ConnectionGUID: IQz81oMJQqKT8wK1dONnBQ==
X-CSE-MsgGUID: gU+oSCFvQWO6DMmDxbZ59w==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="180063264"
X-IronPort-AV: E=Sophos;i="6.12,144,1728918000"; 
   d="scan'208";a="180063264"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 12:02:13 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E166D29F6
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 12:02:11 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 89F33D53E7
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 12:02:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 29B4C1E9B8F
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 12:02:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A020F1A000B
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 11:02:08 +0800 (CST)
From: Ma Xinjian <maxj.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Subject: [issue] low version kernel crashes after adding support for unshare on XFS testing
Date: Mon, 11 Nov 2024 11:01:58 +0800
Message-ID: <20241111030158.731362-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28790.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28790.004
X-TMASE-Result: 10--6.756500-10.000000
X-TMASE-MatchedRID: pYHuQ09G4Ox8M8QL/JCA9MYv//yaWh0DP8UQejhp29rk6Qbi+9i6D7OE
	dy34ZwwEGVnAavDyvK0GitjzOkctvViylHBnm2jGb/oIJuUAIuF9v5k7uQeUSJ3Njchze0K0W+3
	e86Jezphg6ZNcQTGwL/PSha9YEXOwe3aa+kbxaJmp3Btb1bH20Fgx9rCMvPo/5fdCVQd48grFOJ
	/VdJZBtU7G8mDfBcQz7Gwv1cOg4ZMfE8yM4pjsD23U7j2vVURrxEHRux+uk8irEHfaj14ZyWLMa
	gPN5XeEogPYffuEC0Uc3rvwgS+ZcqgUhai0fZ86tBtmcEdCXM4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi all

Since xfstests-dev commit 34ce77ce867d27ad7ad9a180489e4311c3cd15e4("fsx: support unshare range fallocate mode") and
ff07e0a329361c752d77d0f446d247f0ebdb5418("fsstress: add support for FALLOC_FL_UNSHARE_RANGE")
when running the testcases which use fsx or fsstress on XFS filesystem on Rocky 8.10 (e.g. generic/075 and generic/013),
the kernel crashes with the following call_trace, could someone help take a look?

[ 4670.432330] INFO: task fsstress:336323 blocked for more than 120 seconds.
[ 4670.432334]       Not tainted 4.18.0-553.el8_10.x86_64 #1
[ 4670.432335] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4670.432336] task:fsstress        state:D stack:0     pid:336323 ppid:336321 flags:0x00000080
[ 4670.432339] Call Trace:
[ 4670.432341]  __schedule+0x2d1/0x870
[ 4670.432347]  schedule+0x55/0xf0
[ 4670.432349]  schedule_preempt_disabled+0xa/0x10
[ 4670.432352]  rwsem_down_write_slowpath+0x370/0x570
[ 4670.432356]  ? xfs_buffered_write_iomap_end+0x5c/0xe0 [xfs]
[ 4670.432400]  down_write+0x29/0x50
[ 4670.432401]  xfs_ilock+0x98/0x100 [xfs]
[ 4670.432435]  xfs_buffered_write_iomap_end+0x5c/0xe0 [xfs]
[ 4670.432467]  ? xfs_iunlock+0xcb/0x110 [xfs]
[ 4670.432499]  iomap_iter+0x77/0x360
[ 4670.432502]  iomap_file_unshare+0x76/0x1c0
[ 4670.432504]  ? kmem_cache_free+0x116/0x300
[ 4670.432509]  xfs_reflink_unshare+0x55/0x150 [xfs]
[ 4670.432543]  xfs_file_fallocate+0x3b3/0x480 [xfs]
[ 4670.432575]  ? __inode_security_revalidate+0x63/0x80
[ 4670.432578]  ? selinux_file_permission+0x10c/0x140
[ 4670.432581]  vfs_fallocate+0x140/0x280
[ 4670.432584]  ksys_fallocate+0x3c/0x80
[ 4670.432586]  __x64_sys_fallocate+0x1a/0x30
[ 4670.432588]  do_syscall_64+0x5b/0x1b0
[ 4670.432591]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
[ 4670.432594] RIP: 0033:0x7f0b8f8d662b
[ 4670.432598] Code: Unable to access opcode bytes at RIP 0x7f0b8f8d6601.
[ 4670.432599] RSP: 002b:00007ffee0ad3da8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
[ 4670.432601] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0b8f8d662b
[ 4670.432602] RDX: 00000000001d6c8b RSI: 0000000000000040 RDI: 0000000000000003
[ 4670.432603] RBP: 0000000000000080 R08: 000000000000002a R09: 0000000000000000
[ 4670.432604] R10: 00000000000967a4 R11: 0000000000000246 R12: 0000000000000040
[ 4670.432605] R13: 00000000000967a4 R14: 00000000001d6c8b R15: 00007f0b901906b8

Best regards
Ma


