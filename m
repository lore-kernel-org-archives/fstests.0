Received: from mx1.redhat.com ([209.132.183.28]:35946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754477AbdIGH6x (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Sep 2017 03:58:53 -0400
Date: Thu, 7 Sep 2017 15:58:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 0/5] fsx additions for crash consistency tests
Message-ID: <20170907075851.GQ8034@eguan.usersys.redhat.com>
References: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 07, 2017 at 10:26:33AM +0300, Amir Goldstein wrote:
> Eryu,
> 
> This is a re-post of v3 fsx patches with a correction to
> the 2nd patch which introduces -j <logid>.

Thanks a lot for the repost! I plan to pull this log-writes work in this
week after my minor nits to the previous patchset are addressed, if
there're no more review comments/complains from other reviewers.

Thanks,
Eryu

> 
> Amir.
> 
> Amir Goldstein (5):
>   fsx: add support for integrity check with dm-log-writes target
>   fsx: add optional logid prefix to log messages
>   fsx: add support for recording operations to a file
>   fsx: add support for writing constant instead of random data
>   fsx: add support for keeping existing file
> 
>  ltp/fsx.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 214 insertions(+), 60 deletions(-)
> 
> -- 
> 2.7.4
> 
