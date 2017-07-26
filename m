Received: from mx1.redhat.com ([209.132.183.28]:52116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdGZHrU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Jul 2017 03:47:20 -0400
Date: Wed, 26 Jul 2017 15:47:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] Ignore "yes: standard output: Broken pipe" errors
Message-ID: <20170726074719.GW9167@eguan.usersys.redhat.com>
References: <20170725143320.10882-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725143320.10882-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 25, 2017 at 04:33:20PM +0200, Jan Kara wrote:
> Recently, some tests started failing because they had
> 
> yes: standard output: Broken pipe
> 
> in their output. Fix the problem by discarding errors from yes(1)
> program.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/rc         | 12 ++++++------
>  tests/generic/081 |  2 +-
>  tests/generic/108 |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)

I'm wondering which case failed for you and what's the diff output and
.full file? And what change caused the failure for you? Because I didn't
see any failure on my RHEL7 box nor Fedora rawhide box. I compiled
latest yes from coreutils git repo and didn't hit the error either.

So I suspect that it might be other commands in the pipeline that failed
and caused the broken pipe.

Thanks,
Eryu

