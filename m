Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbbBZJwS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 04:52:18 -0500
Date: Thu, 26 Feb 2015 10:52:13 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
In-Reply-To: <20150218220204.GP12722@dastard>
Message-ID: <alpine.LFD.2.00.1502261049520.25704@localhost.localdomain>
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com> <20150218012139.GO4251@dastard> <54E4679C.7030309@fedoraproject.org> <20150218220204.GP12722@dastard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Andrew Price <andyp@fedoraproject.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, 19 Feb 2015, Dave Chinner wrote:

> Date: Thu, 19 Feb 2015 09:02:04 +1100
> From: Dave Chinner <david@fromorbit.com>
> To: Andrew Price <andyp@fedoraproject.org>
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
> 
> On Wed, Feb 18, 2015 at 10:21:16AM +0000, Andrew Price wrote:
> > On 18/02/15 01:21, Dave Chinner wrote:
> > >On Mon, Feb 16, 2015 at 02:50:39PM +0800, Zhaolei wrote:
> > >>From: Zhao Lei <zhaolei@cn.fujitsu.com>
> > >>
> > >>We need to check "$1" instead "$SCRATCH_DEV" in this function.
> > >>And make tabs same with other code.
> > >>
> > >>Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> > >>---
> > >>  common/rc | 14 +++++++-------
> > >>  1 file changed, 7 insertions(+), 7 deletions(-)
> > >>
> > >>diff --git a/common/rc b/common/rc
> > >>index 7449a1d..76522d4 100644
> > >>--- a/common/rc
> > >>+++ b/common/rc
> > >>@@ -1284,13 +1284,13 @@ _require_command()
> > >>  # $1 - device
> > >>  _require_block_device()
> > >>  {
> > >>-	if [ -z "$1" ]; then
> > >>-		echo "Usage: _require_block_device <dev>" 1>&2
> > >>-		exit 1
> > >>-	fi
> > >>-	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
> > >>-		_notrun "require $1 to be valid block disk"
> > >>-	fi
> > >>+    if [ -z "$1" ]; then
> > >>+	echo "Usage: _require_block_device <dev>" 1>&2
> > >>+	exit 1
> > >>+    fi
> > >>+    if [ "`_is_block_dev $1`" == "" ]; then
> > >>+	_notrun "require $1 to be valid block disk"
> > >>+    fi
> > >>  }
> > >
> > >The change is fine - the reformating of the code is not. 8 space
> > >tabs
> > 
> > To be clear, do you mean 8 spaces or single tabs?
> 
> Single tab, but tabs are the width of 8 spaces. Same as you'd use
> for writing new kernel code.

Even I was confused by that :) Just use tabs not spaces. Width of the
tab is whatever your editor decides it is so it's irrelevant :)

-Lukas

> 
> Cheers,
> 
> Dave.
> 
