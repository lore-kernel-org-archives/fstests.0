Received: from mail-io0-f196.google.com ([209.85.223.196]:32863 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcL1VIB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Dec 2016 16:08:01 -0500
Received: by mail-io0-f196.google.com with SMTP id j76so19902787ioe.0
        for <fstests@vger.kernel.org>; Wed, 28 Dec 2016 13:08:01 -0800 (PST)
Date: Wed, 28 Dec 2016 15:07:57 -0600
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v2] xfstests-bld: correct file permissions on test
 appliance files
Message-ID: <20161228210757.GA8557@zzz>
References: <1482343592-135031-1-git-send-email-ebiggers3@gmail.com>
 <20161222165551.qvccd2sv3ujhkgkk@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161222165551.qvccd2sv3ujhkgkk@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 22, 2016 at 11:55:51AM -0500, Theodore Ts'o wrote:
> On Wed, Dec 21, 2016 at 10:06:27AM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The xfstests-bld repository may have been cloned with a umask that
> > masked out the other bits.  When using --update-files in this situation
> > or when creating a GCE image, the VM ended up in a state where non-root
> > users were unable to execute anything, which made all tests using the
> > fsgqa user get skipped.  Fix this by copying the r and x group bits to
> > the other bits when creating files.tar.gz.  Also set the owner and group
> > to root while we're at it.
> 
> Wouldn't it be better to use "--mode=go+u-w"?  This will solve the
> problem for those people who use a umask of 077.
> 
> 	    	  	     	 - Ted

Yes, you're correct.  I was thinking that the user and group permissions could
be different on the files, but actually git can only store mode 755 or 644, so
we might as well use go+u-w.  I'll send a revised patch.

Eric
