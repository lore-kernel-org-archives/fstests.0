Received: from mail-pl0-f65.google.com ([209.85.160.65]:44541 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeCWDat (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Mar 2018 23:30:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id 9-v6so6672117ple.11
        for <fstests@vger.kernel.org>; Thu, 22 Mar 2018 20:30:49 -0700 (PDT)
Date: Fri, 23 Mar 2018 11:30:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/4] fstests: GDBM detection cleanup
Message-ID: <20180323033033.GX30836@localhost.localdomain>
References: <20180315215455.8245-1-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315215455.8245-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: jeffm@suse.com
Cc: xfstests list <fstests@vger.kernel.org>, Luis Rodriguez <mcgrof@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 15, 2018 at 05:54:51PM -0400, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> Commit 2353022 (build: update AC_PACKAGE_WANT_GDBM() and src/dbtest.c
> to build) fixed building on newer SUSE systems but broke older ones.  Where
> we used to skip building src/dbtest on SLES systems, now we'd fail
> to build on SLES11.  The reason was that we were now detecting
> ndbm.h but also including gdbm.h, which doesn't work on older systems due
> to both defining the datum type.  It turns out that no system needs
> gdbm.h at all.
> 
> This series cleans up the macros and fixes detection for all systems that
> only have /usr/include/ndbm.h.

Thanks for the fixes and cleanups! I tested them on Fedora 27, RHEL7 and
Debian stretch, with/without gdbm devel package installed, all worked
fine. But I don't have SUSE systems by hand, I assume you've tested them
successfully.

Thanks,
Eryu
