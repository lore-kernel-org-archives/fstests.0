Received: from nebula-exfe-02.nebula.fi ([83.145.198.164]:50554 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753669AbbH0K7D (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 27 Aug 2015 06:59:03 -0400
Message-ID: <1440673103.29614.13.camel@ari-macbook>
Subject: Re: [PATCH 1/2] Add checks for hardlinks support.
From: Ari Sundholm <ari@tuxera.com>
Date: Thu, 27 Aug 2015 13:58:23 +0300
In-Reply-To: <20150827014718.GI3902@dastard>
References: <1440580477.29614.3.camel@ari-macbook>
	 <20150827014718.GI3902@dastard>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello Dave!

On Thu, 2015-08-27 at 11:47 +1000, Dave Chinner wrote:
> On Wed, Aug 26, 2015 at 12:14:37PM +0300, Ari Sundholm wrote:
> > From: Ari Sundholm <ari@tuxera.com>
> > 
> > Signed-off-by: Ari Sundholm <ari@tuxera.com>
> 
> Why?
> 

Do you mean why this patch is needed? Because there are filesystems that
do not support hard links (at least not yet, but may support symlinks)
we would like to run xfstests on.

I'd be glad to add this explanation and reroll the patches, but I
thought this would be obvious from what the patch does.

OTOH, if you meant to ask why I have both a From: line and a
Signed-off-by: line, it's just a habit due to a pedantic reading of the
kernel patch submission instructions, which I've since applied to other
contexts as well.

Best regards,
Ari Sundholm
ari@tuxera.com

