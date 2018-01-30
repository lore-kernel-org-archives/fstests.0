Received: from mx2.mpynet.fi ([82.197.21.85]:10945 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeA3NzQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Jan 2018 08:55:16 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 0/2] Fix some _require_* checks for filesystem features
Date: Tue, 30 Jan 2018 13:54:57 +0000
Message-ID: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In a few generic tests some filesystem features are not checked (ACLs in
generic/307) or are checked incorrectly (test for fallocate() with
FALLOC_FL_KEEP_SIZE is missing in generic/{274,315}). Fix these problems by
adding appropriate _require_* checks.

