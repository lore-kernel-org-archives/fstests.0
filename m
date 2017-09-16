Received: from imap.thunk.org ([74.207.234.97]:36650 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdIPGdV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 16 Sep 2017 02:33:21 -0400
Date: Sat, 16 Sep 2017 02:33:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] setup-buildchroot: fix copying passwd and
 group entries
Message-ID: <20170916063317.d2vypeje4tvfootl@thunk.org>
References: <20170831201450.32463-1-ebiggers3@gmail.com>
 <20170916035914.GC6901@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170916035914.GC6901@zzz.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 15, 2017 at 08:59:14PM -0700, Eric Biggers wrote:
> On Thu, Aug 31, 2017 at 01:14:50PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > create_chroot() is now supposed to add $CHROOT_USER to /etc/passwd in
> > the chroot.  However, due to a bad grep pattern, it would add multiple
> > entries if $CHROOT_USER happened to be a suffix of another username.
> > Also the passwd record is not guaranteed to actually be in the file
> > /etc/passwd.  Fix it by using 'getent passwd $CHROOT_USER' instead.
> > 
> > A similar problem existed for the group entry, but also the
> > $CHROOT_USER's primary group is not guaranteed to have the same name as
> > the user.  Fix that by using 'id -g' to look up the primary group.
> > 
> 
> Ted, can you apply this patch?  Thanks!

Oops, missed this earlier; thanks for the ping.  I've applied it.

      	     	  	    	 	 - Ted
