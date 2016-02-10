Received: from imap.thunk.org ([74.207.234.97]:57338 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbcBJQJU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 11:09:20 -0500
Date: Wed, 10 Feb 2016 11:09:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 09/12] xfstests: generic/079 requires chattr, not xattrs
Message-ID: <20160210160918.GF26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-10-git-send-email-tytso@mit.edu>
 <20160210090909.GW11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210090909.GW11419@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 05:09:10PM +0800, Eryu Guan wrote:
> On Tue, Feb 09, 2016 at 08:49:58PM -0500, Theodore Ts'o wrote:
> > From: Hugh Dickins <hughd@google.com>
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  tests/generic/079 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/079 b/tests/generic/079
> > index 041d9c0..a2c3286 100755
> > --- a/tests/generic/079
> > +++ b/tests/generic/079
> > @@ -48,7 +48,7 @@ _cleanup()
> >  _supported_fs generic
> >  _supported_os Linux
> >  
> > -_require_attrs
> > +_require_chattr
> 
> I don't see _require_chattr in any of the common files, did I miss
> anything?

Oops, I forgot to pull that into the patch.  Thanks for catching this!

      	       	       	    	     	     	    - Ted
