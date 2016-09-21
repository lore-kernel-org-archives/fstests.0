Received: from mx1.redhat.com ([209.132.183.28]:51452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934344AbcIUOaq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Sep 2016 10:30:46 -0400
Date: Wed, 21 Sep 2016 22:30:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/3] modify xfs/ quota tests to work on generic
 filesystems
Message-ID: <20160921143044.GL27776@eguan.usersys.redhat.com>
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <ef6b5c28-9579-c13e-0547-17d05f150714@sandeen.net>
 <20160921093721.GK27776@eguan.usersys.redhat.com>
 <a9112b04-17a3-dbdc-7c19-b2490875b6fd@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9112b04-17a3-dbdc-7c19-b2490875b6fd@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 21, 2016 at 08:02:39AM -0500, Eric Sandeen wrote:
> >>  #
> >> +# checks that xfs_quota can operate on foreign (non-xfs) filesystems
> >> +# Skips check on xfs filesystems, old xfs_quota is fine there.
> >> +# Appends "-f" to enable foreign behavior on non-xfs filesystems if available.
> >> +#
> >> +_require_xfs_quota_foreign()
> >> +{
> >> +    if [ "$FSTYP" != "xfs" ]; then
> >> +	$XFS_QUOTA_PROG -f -V &>/dev/null || \
> >> +		_notrun "xfs_quota binary does not support foreign filesystems"
> >> +	XFS_QUOTA_PROG="$XFS_QUOTA_PROG -f"
> >> +    fi
> > 
> > Mixing space and tab in this function.
> 
> yep -
> 
> As do the functions before and after it - are we going with a strict
> rule now or going for consistency with the rest of the code?

I think currently the rule is that we use tab as indentions for new
code, e.g. new functions, new tests, as long as the new code doesn't mix
with existing code. And we only go for the consistency when modifying
old code with spaces as indention.

I just searched for Dave's explanation, hope this explains better than
my words :)

   - some of the code uses 4 space tabs. When adding code into
     such functions, please use 4 space tabs. New code should
     use 8 space tabs, but only if it's not surrounded by code
     that is using 4 space tabs.

Thanks,
Eryu
