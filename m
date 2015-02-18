Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:33885 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620AbbBRWHd (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 Feb 2015 17:07:33 -0500
Date: Thu, 19 Feb 2015 09:02:04 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
Message-ID: <20150218220204.GP12722@dastard>
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com>
 <20150218012139.GO4251@dastard>
 <54E4679C.7030309@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E4679C.7030309@fedoraproject.org>
Sender: fstests-owner@vger.kernel.org
To: Andrew Price <andyp@fedoraproject.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 18, 2015 at 10:21:16AM +0000, Andrew Price wrote:
> On 18/02/15 01:21, Dave Chinner wrote:
> >On Mon, Feb 16, 2015 at 02:50:39PM +0800, Zhaolei wrote:
> >>From: Zhao Lei <zhaolei@cn.fujitsu.com>
> >>
> >>We need to check "$1" instead "$SCRATCH_DEV" in this function.
> >>And make tabs same with other code.
> >>
> >>Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> >>---
> >>  common/rc | 14 +++++++-------
> >>  1 file changed, 7 insertions(+), 7 deletions(-)
> >>
> >>diff --git a/common/rc b/common/rc
> >>index 7449a1d..76522d4 100644
> >>--- a/common/rc
> >>+++ b/common/rc
> >>@@ -1284,13 +1284,13 @@ _require_command()
> >>  # $1 - device
> >>  _require_block_device()
> >>  {
> >>-	if [ -z "$1" ]; then
> >>-		echo "Usage: _require_block_device <dev>" 1>&2
> >>-		exit 1
> >>-	fi
> >>-	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
> >>-		_notrun "require $1 to be valid block disk"
> >>-	fi
> >>+    if [ -z "$1" ]; then
> >>+	echo "Usage: _require_block_device <dev>" 1>&2
> >>+	exit 1
> >>+    fi
> >>+    if [ "`_is_block_dev $1`" == "" ]; then
> >>+	_notrun "require $1 to be valid block disk"
> >>+    fi
> >>  }
> >
> >The change is fine - the reformating of the code is not. 8 space
> >tabs
> 
> To be clear, do you mean 8 spaces or single tabs?

Single tab, but tabs are the width of 8 spaces. Same as you'd use
for writing new kernel code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
