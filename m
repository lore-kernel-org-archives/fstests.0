Received: from mail-pf0-f174.google.com ([209.85.192.174]:34188 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeARBJj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jan 2018 20:09:39 -0500
Received: by mail-pf0-f174.google.com with SMTP id e76so12907084pfk.1
        for <fstests@vger.kernel.org>; Wed, 17 Jan 2018 17:09:39 -0800 (PST)
Date: Wed, 17 Jan 2018 17:09:36 -0800
From: Omar Sandoval <osandov@osandov.com>
Subject: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118010936.GA10649@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hello,

If I run xfstests on ext4 with a kernel with CONFIG_QFMT_V2=n, the following
tests fail:

generic/082
generic/219
generic/230
generic/231
generic/232
generic/233
generic/234
generic/235
generic/244
generic/270
generic/382

Would it be possible to handle this case and skip the test instead?
