Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:33469 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbbEDWBu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 18:01:50 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YpOQi-0005ay-Je
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YpOQi-0006g8-Ia
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/4] fstests: xfs utility output has changed.
Date: Tue,  5 May 2015 08:01:29 +1000
Message-Id: <1430776893-25158-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

Recent updates to mkfs.xfs and xfs_repair have made them more
verbose about certain conditions, making tests fail as the error
verbosity is not masked from the tests. The first three patches in
this series address those changes.

The final patch in the series addresses the fallout from the pending
mkfs.xfs patch that changes the default to make v5 (CRC enabled)
filesystems. This causes lots more failures, because there are many
tests that use filesystem configurations that are only valid for V4
filesystems (e.g. 256 byte inodes, v1 logs, etc). This patch fixes
most of the issues arising from changing the mkfs default.

-Dave.
