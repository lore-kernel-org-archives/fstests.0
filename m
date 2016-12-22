Received: from imap.thunk.org ([74.207.234.97]:44806 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753089AbcLVQ4K (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Dec 2016 11:56:10 -0500
Date: Thu, 22 Dec 2016 11:55:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] xfstests-bld: correct file permissions on test
 appliance files
Message-ID: <20161222165551.qvccd2sv3ujhkgkk@thunk.org>
References: <1482343592-135031-1-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482343592-135031-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06:27AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The xfstests-bld repository may have been cloned with a umask that
> masked out the other bits.  When using --update-files in this situation
> or when creating a GCE image, the VM ended up in a state where non-root
> users were unable to execute anything, which made all tests using the
> fsgqa user get skipped.  Fix this by copying the r and x group bits to
> the other bits when creating files.tar.gz.  Also set the owner and group
> to root while we're at it.

Wouldn't it be better to use "--mode=go+u-w"?  This will solve the
problem for those people who use a umask of 077.

	    	  	     	 - Ted
