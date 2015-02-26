Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbbBZNid (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 08:38:33 -0500
Date: Thu, 26 Feb 2015 14:38:27 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH v2 1/2] xfstests: fix a typo in _require_block_device()
In-Reply-To: <alpine.LFD.2.00.1502261144090.25704@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.1502261436470.25704@localhost.localdomain>
References: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com> <alpine.LFD.2.00.1502261144090.25704@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1993084602-1424957910=:25704"
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1993084602-1424957910=:25704
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 26 Feb 2015, Luká¨ Czerner wrote:

> Date: Thu, 26 Feb 2015 11:45:12 +0100 (CET)
> From: Luká¨ Czerner <lczerner@redhat.com>
> To: Zhaolei <zhaolei@cn.fujitsu.com>
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] xfstests: fix a typo in _require_block_device()
> 
> On Thu, 26 Feb 2015, Zhaolei wrote:
> 
> > Date: Thu, 26 Feb 2015 18:38:47 +0800
> > From: Zhaolei <zhaolei@cn.fujitsu.com>
> > To: fstests@vger.kernel.org
> > Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
> > Subject: [PATCH v2 1/2] xfstests: fix a typo in _require_block_device()
> > 
> > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> > 
> > We need to check "$1" instead "$SCRATCH_DEV" in this function.
> > 
> > Changelog v1->v2:
> >  Use tab instead of space to fit new code style.
> >  Suggested by: Dave Chinner <david@fromorbit.com>
> 
> Looks good, thanks.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Based on the discussion around the second patch you need to use
proper quotes

	if [ "`_is_block_dev "$1"`" == "" ]; then

-Lukas

> 
> > 
> > Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 1ed9df5..5a8c74d 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1288,7 +1288,7 @@ _require_block_device()
> >  		echo "Usage: _require_block_device <dev>" 1>&2
> >  		exit 1
> >  	fi
> > -	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
> > +	if [ "`_is_block_dev $1`" == "" ]; then
> >  		_notrun "require $1 to be valid block disk"
> >  	fi
> >  }
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--8323328-1993084602-1424957910=:25704--
