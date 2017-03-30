Received: from mail-lf0-f68.google.com ([209.85.215.68]:33287 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933599AbdC3NTX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Mar 2017 09:19:23 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 0/3] Improve block device testing coverage
Date: Thu, 30 Mar 2017 17:19:01 +0400
Message-Id: <1490879944-26240-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

During LSFMM we have discussed how to test lower-backend of linux IO-stack.
Common opinion was that xfstests is the most obvious solution which cover
most of use cases filesystem care about.

I'm working on integration T10-DIF/DIF data integrity features to ext4,
for that reason we need to be shure that linux integrity framework is
in working state, which is currently broken in several places.

In fact, it is relatively simple to add basic coverage tests for basic
IO operations over virtual device with integrity support. All we need
is to add lio target support.

TOC:
add lio target helpers
add test: generic/420 check information lead for lio-fileio
add test: generic/421 basic blockdev T10-DIF-TYPE1 IO
