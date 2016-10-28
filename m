Received: from mail-pf0-f175.google.com ([209.85.192.175]:34576 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756196AbcJ1Qpm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Oct 2016 12:45:42 -0400
Received: by mail-pf0-f175.google.com with SMTP id n85so40047254pfi.1
        for <fstests@vger.kernel.org>; Fri, 28 Oct 2016 09:45:41 -0700 (PDT)
Date: Fri, 28 Oct 2016 09:45:38 -0700
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] xfstests-bld: add kernel configs for 4.9
Message-ID: <20161028164538.GA53757@google.com>
References: <1477081648-86880-1-git-send-email-ebiggers@google.com>
 <20161025165116.7zzhjnfhsnwrc2r5@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161025165116.7zzhjnfhsnwrc2r5@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 25, 2016 at 12:51:16PM -0400, Theodore Ts'o wrote:
> I ended up checking in a slightly different set of kernel configs.
> The main differences were (a) enable more kernel debugging config
> options, which improve testing, and (b) removed some unneeded hardware
> support which aren't needed for running the 32-bit kernel under KVM.

Thanks!  Right now I only see the commit in the github repository
(https://github.com/tytso/xfstests-bld), not in the kernel.org repository
(git://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git).  Can these be kept in
sync, and which one (if either) is supposed to be authoritative?

Eric
