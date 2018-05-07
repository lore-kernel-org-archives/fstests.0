Received: from mail-pf0-f193.google.com ([209.85.192.193]:46999 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGEWL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 May 2018 00:22:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id p12so21796080pff.13
        for <fstests@vger.kernel.org>; Sun, 06 May 2018 21:22:11 -0700 (PDT)
Date: Mon, 7 May 2018 12:22:07 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 00e3549c659c
Message-ID: <20180507042207.GG8373@desktop>
References: <5aef0d98.4e21620a.be12e.c614@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aef0d98.4e21620a.be12e.c614@mx.google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, May 06, 2018 at 10:13:39PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. Notably, the default behavior of a pure './check' has
> been changed in this update, it now runs tests only in 'auto' group by default,
> instead of all tests. But you could still use './check -g auto' as usual to run
> 'auto' tests.

Forgot to mention that you can run './check -g all' to run all tests, as
what the old './check' did.

Thanks,
Eryu
