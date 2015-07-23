Received: from mx1.redhat.com ([209.132.183.28]:42413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbbGWDyK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 22 Jul 2015 23:54:10 -0400
Date: Thu, 23 Jul 2015 11:54:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/078: omit -m crc=0 mkfs option if mkfs.xfs has no
 meta support
Message-ID: <20150723035406.GG3945@dhcp-13-216.nay.redhat.com>
References: <1437553336-30408-1-git-send-email-eguan@redhat.com>
 <55AFB550.5020904@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55AFB550.5020904@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 22, 2015 at 10:22:56AM -0500, Eric Sandeen wrote:
> On 7/22/15 3:22 AM, Eryu Guan wrote:
> > This basically does the same as in commit
> > 
> > 90a3bfc xfs: be compatible with older mkfs.xfs which has no v5 support
> > 
> > which left xfs/078 behind.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> 
> This is fine as far as it goes, but I think xfs/045 needs it too:
> 
> 
> if ! _scratch_mkfs_xfs -m crc=0 >$tmp.out 2>&1
> then
>     cat $tmp.out
>     echo "!!! failed to mkfs on $SCRATCH_DEV"
>     exit
> fi
> 
> It fails "gracefully" but it doesn't need to, in this case.

xfs/045 passed on my RHEL6 test box, I think that's because xfs/045 (and
some other tests) takes use of _scratch_mkfs_xfs not call $MKFS_XFS_PROG
directly, so commit 90a3bfc takes care of all the dirty work.

Thanks for the review!

Eryu
> 
> In case I'm wrong, for this patch:
> 
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> 
> but xfs/045 might need a look too, either in this patch or a followup.
> 
> Thanks,
> -Eric
> 
> > ---
> >  tests/xfs/078 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/xfs/078 b/tests/xfs/078
> > index 32436f7..0d6eb55 100755
> > --- a/tests/xfs/078
> > +++ b/tests/xfs/078
> > @@ -87,7 +87,11 @@ _grow_loop()
> >  	echo
> >  
> >  	echo "*** mkfs loop file (size=$original)"
> > -	$MKFS_XFS_PROG -m crc=0 -b size=$bsize -d $dparam \
> > +	mkfs_crc_opts="-m crc=0"
> > +	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> > +		mkfs_crc_opts=""
> > +	fi
> > +	$MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize -d $dparam \
> >  		| _filter_mkfs 2>/dev/null
> >  
> >  	echo "*** extend loop file"
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
