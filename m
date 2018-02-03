Received: from mail-io0-f179.google.com ([209.85.223.179]:39904 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeBCS6r (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Feb 2018 13:58:47 -0500
Received: by mail-io0-f179.google.com with SMTP id b198so26328039iof.6
        for <fstests@vger.kernel.org>; Sat, 03 Feb 2018 10:58:47 -0800 (PST)
MIME-Version: 1.0
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 3 Feb 2018 19:58:46 +0100
Message-ID: <CAHc6FU7s_zjwCWMAWymk2oYa-JduuXObw68nD3F5nKz9X-LRGQ@mail.gmail.com>
Subject: Failing scratch mounts
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

we have many fstests that call _scratch_mount without checking if the
mount was successful. When the mount fails, the tests then write to
the underlying filesystem. Here's a list of fstests that do this for
gfs2:

  generic/029 generic/030 generic/032 generic/037 generic/053 generic/069
  generic/071 generic/084 generic/094 generic/098 generic/103 generic/105
  generic/109 generic/129 generic/130 generic/132 generic/162 generic/163
  generic/169 generic/204 generic/225 generic/231 generic/232 generic/233
  generic/235 generic/256 generic/294 generic/306 generic/319 generic/320
  generic/337 generic/361 generic/374 generic/377 generic/380 generic/390
  generic/401 generic/403 generic/412 generic/416 generic/422 generic/427
  generic/439 generic/449 generic/452 generic/453 generic/454 generic/460
  generic/464 generic/476

This is after fixing generic/270 which even fills up the scratch mount
point completely.

Since _scratch_mount is mostly used without checking for success, can
we change it to _fail by default, and introduce _try_check_mount or
similar for those few cases where we don't want to fail implicitly?

Thanks,
Andreas
