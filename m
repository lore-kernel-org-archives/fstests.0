Received: from imap.thunk.org ([74.207.234.97]:37596 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754908AbdDFPe7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Apr 2017 11:34:59 -0400
Date: Thu, 6 Apr 2017 11:34:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fstests: Remove IRIX os support from template
Message-ID: <20170406153453.2e5fhjqiamllpce4@thunk.org>
References: <20170405032628.22370-1-quwenruo@cn.fujitsu.com>
 <20170406140233.20dc6553@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406140233.20dc6553@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 06, 2017 at 02:02:33PM +0200, David Disseldorp wrote:
> On Wed, 5 Apr 2017 11:26:28 +0800, Qu Wenruo wrote:
> 
> > Since the last release of IRIX is already 10 years ago and support for
> > it has ended after 2014, there is no need to support IRIX any way.
> > 
> > Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> > ---
> >  new | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/new b/new
> > index c21d8db..eb7da0f 100755
> > --- a/new
> > +++ b/new
> > @@ -207,7 +207,7 @@ rm -f \$seqres.full
> >  
> >  # Modify as appropriate.
> >  _supported_fs generic
> > -_supported_os IRIX Linux
> > +_supported_os Linux
> >  _require_test
> >  
> >  # if error
> 
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> Looking forward to seeing the floodgates open for the rest of the Irix
> removal changes.

Wouldn't it be better to do a wholesale removal of Irix support
instead of having lots of teeny-tiny patches?

		   	       	  - Ted
