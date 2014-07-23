Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:45554 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaGWLIh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 23 Jul 2014 07:08:37 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/3] xfstests: defragment test improvements V2
Date: Wed, 23 Jul 2014 15:08:15 +0400
Message-Id: <1406113698-9387-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

add options to _defrag helper
add new defragment test generic/323
add new defragmentation test (compacting case)

Changes since V1: (in response to Dave's comments)
- use xfs_io helpers
- use md5sum
- generalize first test ext4/307->generic/323
- fix white space issues.
