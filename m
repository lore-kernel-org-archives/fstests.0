Received: from imap.thunk.org ([74.207.234.97]:43522 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdE0Dhm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 May 2017 23:37:42 -0400
Date: Fri, 26 May 2017 23:37:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/7] xfstests-bld: get-all improvements and adding keyctl
Message-ID: <20170527033740.c6zowcfjreo6n4ow@thunk.org>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, May 25, 2017 at 12:25:42PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Patches 1-6 make some improvements to how the xfstests-bld system
> handles external git repositories --- especially, making sure the build
> system recognizes changes made to the config file.
> 
> Patch 7 adds support for optionally including keyctl (used by the
> filesystem encryption tests) in the xfstests tarball built by
> xfstests-bld.  As noted, this usually isn't needed, but it can be useful
> if the tarball is used "on its own", without being contained in a
> dedicated test appliance.
> 
> Eric Biggers (7):
>   get-all: use helper function to clone repositories
>   get-all: check out correct commits in already-cloned repositories
>   get-all: fail if optional repositories have been deconfigured
>   Makefile: always run get-all
>   do-all, get-all: run with 'set -e'
>   Makefile: check whether xfsprogs-dev exists before cleaning it
>   xfstests-bld: optionally build keyctl

Thanks, I've applied this whole series to my tree.

	     	     	  	       - Ted
