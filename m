Received: from mail-pf0-f195.google.com ([209.85.192.195]:46613 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeDFWRQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Apr 2018 18:17:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so1703161pfe.13
        for <fstests@vger.kernel.org>; Fri, 06 Apr 2018 15:17:16 -0700 (PDT)
Date: Fri, 6 Apr 2018 15:17:13 -0700
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] common/rc: add missing 'local' keywords
Message-ID: <20180406221713.GB40084@google.com>
References: <20180405183129.48803-1-ebiggers@google.com>
 <20180406085603.GO30836@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406085603.GO30836@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu, thanks for the review!

On Fri, Apr 06, 2018 at 04:56:03PM +0800, Eryu Guan wrote:
> On Thu, Apr 05, 2018 at 11:31:29AM -0700, Eric Biggers wrote:
> > A lot of the helper functions in xfstests are unnecessarily declaring
> > variables without the 'local' keyword, which pollutes the global
> > namespace and can collide with variables in tests.  Fix this for
> > everything in common/rc that I could find.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Thanks a lot for doing this! I need some time to do careful testing, as
> something can be broken implicitly, as the "$err_msg" usage below.
> 

Indeed, I ran the 'auto' group tests on ext4 and xfs using gce-xfstests, but
that doesn't cover everything.

> > ---
> >  common/rc | 306 ++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 158 insertions(+), 148 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 6a91850c..39e1db43 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -53,12 +53,8 @@ _require_math()
> >  _math()
> >  {
> >  	[ $# -le 0 ] && return
> > -	if [ "$BC" ]; then
> > -		result=$(LANG=C echo "scale=0; $@" | "$BC" -q 2> /dev/null)
> > -	else
> > -		_notrun "this test requires 'bc' tool for doing math operations"
> > -	fi
> > -	echo "$result"
> > +	_require_math
> 
> I think _require_math belongs to tests that take use of _math, not _math
> itself.
> 

Yes, _math is only used by generic/260 and xfs/259 which already do
_require_math, so I'll just remove _require_math from here.

> >  
> >  _dump_err()
> >  {
> > -    err_msg="$*"
> > +    local err_msg="$*"
> >      echo "$err_msg"
> >  }
> >  
> >  _dump_err2()
> >  {
> > -    err_msg="$*"
> > +    local err_msg="$*"
> >      >2& echo "$err_msg"
> >  }
> >  
> >  _log_err()
> >  {
> > -    err_msg="$*"
> > +    local err_msg="$*"
> 
> It seems the "$err_msg" in above functions need to be global,
> common/report needs it set somewhere. Perhaps we can name it with a
> leading underscore to indicate it's a global variable.
> 

Ick.  I'll add a leading underscore.

> > @@ -1130,7 +1131,7 @@ _repair_scratch_fs()
> >      *)
> >          # Let's hope fsck -y suffices...
> >          fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
> > -	res=$?
> > +	local res=$?
> >  	case $res in
> >  	0|1|2)
> >  		res=0
> > @@ -1317,7 +1318,7 @@ _is_block_dev()
> >  	exit 1
> >      fi
> >  
> > -    _dev=$1
> > +    local _dev=$1
> 
> A 'local' variable could drop the leading underscore then.
> 

Will do for here and the other places.

Eric
