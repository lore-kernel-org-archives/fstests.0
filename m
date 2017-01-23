Received: from mail-io0-f180.google.com ([209.85.223.180]:36260 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWR5g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Jan 2017 12:57:36 -0500
Received: by mail-io0-f180.google.com with SMTP id j13so115812717iod.3
        for <fstests@vger.kernel.org>; Mon, 23 Jan 2017 09:57:36 -0800 (PST)
MIME-Version: 1.0
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 23 Jan 2017 09:57:15 -0800
Message-ID: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
Subject: xfstest and chromeos
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Mike Frysinger <vapier@chromium.org>
List-ID: <fstests@vger.kernel.org>

I am adding xfstest to chromeos test image, to improve chromeos
filesystems test coverage.
Doing so, I encountered to issues, documented in
https://chromium-review.googlesource.com/#/c/424372
and
https://chromium-review.googlesource.com/#/c/424191

https://chromium-review.googlesource.com/#/c/424372
- To circuvent SELinux protection we add a mount context option,
requesting to use nfs_t context. However on chromeos, we have no nfs
security context - we are not expecting usings nfs - leading to a
mount error. Shall we try to use another context or check beforehand
if a context is needed for mount?

https://chromium-review.googlesource.com/#/c/424191
- Chromeos needs libtool to (cross-)compile packages and put them at
the right place. I needed to move archived aclocal.m4 to acinclude.m4.
Does it make sense to require aclocal to run to compile xfstests?

Gwendal.
