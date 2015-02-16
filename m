Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:16955 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752085AbbBPC2z convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 15 Feb 2015 21:28:55 -0500
From: Zhao Lei <zhaolei@cn.fujitsu.com>
References: <1423745294-20408-1-git-send-email-zhaolei@cn.fujitsu.com> <20150215230454.GF12722@dastard>
In-Reply-To: <20150215230454.GF12722@dastard>
Subject: RE: [PATCH] Fix warning of "Usage: _is_block_dev dev"
Date: Mon, 16 Feb 2015 10:27:33 +0800
Message-ID: <000d01d04990$1eea6360$5cbf2a20$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: 'Dave Chinner' <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Dave Chinner [mailto:david@fromorbit.com]
> Sent: Monday, February 16, 2015 7:05 AM
> To: Zhaolei
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH] Fix warning of "Usage: _is_block_dev dev"
> 
> On Thu, Feb 12, 2015 at 08:48:14PM +0800, Zhaolei wrote:
> > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> >
> > _is_block_dev() will show above warning when "$dev" is not exist.
> > It happened when user hadn't set $SCRATCH_DEV(optional) and check
> > $TEST_DEV.
> 
> _is_block_dev() is used in many places to check whether the block device exists.
> i.e. I'd suggest that _is_block_dev() should return an empty string to indicate
> it's not a block device rather than exit if a null. That means we don't have to
> execute _is_block_dev() in a subshell (i.e. via `_is_block_dev ...`) to prevent it
> from killing the script that runs it if the block device passed to it is null.
> 
> That means we don't have to add checks everywhere it is called, and we can
> simplify the calling convention at the same time....
> 
Thanks for your suggestion.

Are you mean this?

diff --git a/common/rc b/common/rc
index 7449a1d..12861b8 100644
--- a/common/rc
+++ b/common/rc
@@ -951,8 +951,7 @@ _is_block_dev()
 {
     if [ $# -ne 1 ]
     then
-       echo "Usage: _is_block_dev dev" 1>&2
-       exit 1
+       return
     fi

     _dev=$1
@@ -1095,7 +1094,7 @@ _require_scratch_nocheck()
                fi
                ;;
        *)
-                if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
+                if [ "`_is_block_dev $SCRATCH_DEV`" = "" ]
                 then
                     _notrun "this test requires a valid \$SCRATCH_DEV"
                 fi
@@ -1167,7 +1166,7 @@ _require_test()
                fi
                ;;
        *)
-                if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
+                if [ "`_is_block_dev $TEST_DEV`" = "" ]
                 then
                     _notrun "this test requires a valid \$TEST_DEV"
                 Fi

It is clean than before, but we still need call _is_block_dev() in a subshell to get its return string.

If we want to avoid calling _is_block_dev in a subshell, we can do following change:

_is_block_dev()
{
    return 1 if "$1" is not block dev
}
_same_dev()
{
    return 1 if "$1" and "$2" are not same dev
}

And caller code will be:

if [ ! _is_block_dev "$SCRATCH_DEV" -o _same_dev "$SCRATCH_DEV" "$TEST_DEV" ]
then
    _notrun "this test requires a valid \$SCRATCH_DEV"
fi

Thanks
Zhaolei

> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com


