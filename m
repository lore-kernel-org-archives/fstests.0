Received: from mail-pg0-f68.google.com ([74.125.83.68]:38015 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdIPD7T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Sep 2017 23:59:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id m30so2240919pgn.5
        for <fstests@vger.kernel.org>; Fri, 15 Sep 2017 20:59:19 -0700 (PDT)
Date: Fri, 15 Sep 2017 20:59:14 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH] setup-buildchroot: fix copying passwd and
 group entries
Message-ID: <20170916035914.GC6901@zzz.localdomain>
References: <20170831201450.32463-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831201450.32463-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 31, 2017 at 01:14:50PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> create_chroot() is now supposed to add $CHROOT_USER to /etc/passwd in
> the chroot.  However, due to a bad grep pattern, it would add multiple
> entries if $CHROOT_USER happened to be a suffix of another username.
> Also the passwd record is not guaranteed to actually be in the file
> /etc/passwd.  Fix it by using 'getent passwd $CHROOT_USER' instead.
> 
> A similar problem existed for the group entry, but also the
> $CHROOT_USER's primary group is not guaranteed to have the same name as
> the user.  Fix that by using 'id -g' to look up the primary group.
> 

Ted, can you apply this patch?  Thanks!

Eric
