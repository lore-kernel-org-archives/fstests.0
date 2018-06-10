Received: from mail-pl0-f68.google.com ([209.85.160.68]:38624 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbeFJNrk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Jun 2018 09:47:40 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so10830536pls.5
        for <fstests@vger.kernel.org>; Sun, 10 Jun 2018 06:47:40 -0700 (PDT)
Date: Sun, 10 Jun 2018 21:47:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/9] fstests: Conversion of tests to SPDX license tags
Message-ID: <20180610134733.GA2780@desktop>
References: <20180609015540.19385-1-david@fromorbit.com>
 <20180609021750.GA5651@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609021750.GA5651@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jun 09, 2018 at 12:17:50PM +1000, Dave Chinner wrote:
> On Sat, Jun 09, 2018 at 11:55:31AM +1000, Dave Chinner wrote:
> > Hi folks,
> > 
> > I'm attempting to post this set of patches to the list now that
> > i've done the SPDX license tag conversion on Eryu's current
> > staging tree. I'm not sure it will all get through (it's a huge set
> > of patches), so after I've send this I'll push it all to a git tree
> > branch on kernel.org.
> 
> Eryu, it looks like the majority of the patches didn't make it
> through vger and back to me. So to solve that problem, here's the
> pull request from my own repo on kernel.org. git.kernel.org doesn't
> show it up yet as I write this (hasn't mirror across), but the repo
> is there. 

Yeah, I saw only a few of them.

> 
> Cheers,
> 
> Dave.
> 
> The following changes since commit 25ce9740065e1ac00b699b3fb84cc651aeaf5032:
> 
>   generic: test swapfile creation, activation, and deactivation (2018-06-08 14:12:27 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dgc/xfstests-dev spdx-tags
> 
> for you to fetch changes up to 3805d7e97a9e62993bd6229cc73a50ec7b5fc84b:
> 
>   fstests: make lsqa.pl work with SPDX tags (2018-06-09 11:45:38 +1000)

Pulled, thanks a lot!

Eryu
