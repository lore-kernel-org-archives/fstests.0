Received: from imap.thunk.org ([74.207.234.97]:47758 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdAaD4a (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Jan 2017 22:56:30 -0500
Date: Mon, 30 Jan 2017 22:56:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] xfstests-bld: populate keyring with default key for
 test_dummy_encryption
Message-ID: <20170131035628.24cbkhydecitmmhr@thunk.org>
References: <20170130213647.14843-1-ebiggers3@gmail.com>
 <20170130224238.3ez7gcx2wh32xh6o@thunk.org>
 <20170130230352.GA24293@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130230352.GA24293@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 30, 2017 at 03:03:52PM -0800, Eric Biggers wrote:
> On Mon, Jan 30, 2017 at 05:42:38PM -0500, Theodore Ts'o wrote:
> > On Mon, Jan 30, 2017 at 01:36:47PM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > We can improve test coverage and simplify the test_dummy_encryption
> > > kernel logic by requiring userspace to add a default master key to the
> > > keyring.  Update xfstests-bld to do this.  This allows xfstests-bld to
> > > test kernels with the corresponding kernel patch applied ("fscrypt: make
> > > test_dummy_encryption require a keyring key").  It can still test older
> > > kernels too; the key just doesn't get used in that case.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > This is upstream already.  (commit: ce7ef24b3ef1940)
> > 
> > 					- Ted
> 
> I don't see it.  Can you push out what you have, to both the kernel.org and
> github repositories?

Done.  (I thought I had, but looks like I had only pushed it out to github somehow).

              	  	    	     	   - Ted
				   
