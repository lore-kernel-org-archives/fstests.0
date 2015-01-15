Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbbAOJas (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 15 Jan 2015 04:30:48 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0F9UmEQ008885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 15 Jan 2015 04:30:48 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [RFC PATCH 0/3] fstests: check dmesg after test
Date: Thu, 15 Jan 2015 17:30:28 +0800
Message-Id: <1421314231-11076-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

This patchset adds dmesg check after each test.

The first patch is a backlog patch from Eric Sandeen, which adds log
message of running to dmesg.

And the second patch takes use of this log to search for dmesg log of
last test, without clearing dmesg buffer nor dumping all dmesg to a
file, which can potentially eat all free space on testing host.

The third patch adds a function to disable this dmesg check, which can
be called by tests that generate WARNINGs/etc. on purpose, so the tests
won't fail _dmesg_check. But so far I haven't found any tests that need
this function. (Some xfs tests like xfs/111 inject corruptions on
purpose and log errors to dmesg, but _dmesg_check is unable to detect
these xfs-specific failures now.)

Right now with 3.19.0-rc4+ kernel, xfs/279 and btrfs/017 fail this
check, and btrfs/017 is a known issue, xfs/279 exposes an scsi bug

http://permalink.gmane.org/gmane.linux.scsi/98063

Thanks,
Eryu

Eric Sandeen (1):
  check: log running test to dmesg

Eryu Guan (2):
  check: check dmesg log after each test
  common: add _disable_dmesg_check function

 check     | 33 +++++++++++++++++++++++++++++++++
 common/rc |  6 ++++++
 2 files changed, 39 insertions(+)

-- 
2.1.0

