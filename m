Received: from mx1.mpynet.fi ([82.197.21.84]:58192 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeAVP5u (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:50 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 0/8] Fix build with musl libc
Date: Mon, 22 Jan 2018 15:57:11 +0000
Message-ID: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Replace some obsolete and non-standard data types, headers, macros and
symbols with standard and modern ones in order to allow building
xfstests with musl C library.

---

Changes since v1:

Split a single patch into multiple patches.

