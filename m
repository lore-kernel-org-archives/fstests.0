Received: from mail-pg0-f53.google.com ([74.125.83.53]:56654 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdIPEAO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Sep 2017 00:00:14 -0400
Received: by mail-pg0-f53.google.com with SMTP id 7so2505213pgd.13
        for <fstests@vger.kernel.org>; Fri, 15 Sep 2017 21:00:13 -0700 (PDT)
Date: Fri, 15 Sep 2017 21:00:08 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH] setup-buildchroot: fix finding files in
 chroot.d
Message-ID: <20170916040008.GD6901@zzz.localdomain>
References: <20170831201540.32597-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831201540.32597-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 31, 2017 at 01:15:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> get_schroot_config() sometimes didn't find the files in
> /etc/schroot/chroot.d/ because there was a typo in the regex: it used
> [0-09] instead of [0-9].  Fix it, and also cat schroot.conf first so
> that it doesn't get printed multiple times by the xargs command.
> 
> We also don't need to check whether schroot.conf exists, since it was
> already checked in check_prerequisites(), and the 'cat' command would
> fail anyway if it didn't exist.
> 

Ted, can you apply this patch?  Thanks!

Eric
