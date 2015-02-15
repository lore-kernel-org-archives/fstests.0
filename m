Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:19236 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753070AbbBOXHY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 15 Feb 2015 18:07:24 -0500
Date: Mon, 16 Feb 2015 10:04:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Fix warning of "Usage: _is_block_dev dev"
Message-ID: <20150215230454.GF12722@dastard>
References: <1423745294-20408-1-git-send-email-zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423745294-20408-1-git-send-email-zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 12, 2015 at 08:48:14PM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> _is_block_dev() will show above warning when "$dev" is not exist.
> It happened when user hadn't set $SCRATCH_DEV(optional) and check
> $TEST_DEV.

_is_block_dev() is used in many places to check whether the block
device exists.  i.e. I'd suggest that _is_block_dev() should return
an empty string to indicate it's not a block device rather than exit
if a null. That means we don't have to execute _is_block_dev() in a
subshell (i.e. via `_is_block_dev ...`) to prevent it from killing
the script that runs it if the block device passed to it is null.

That means we don't have to add checks everywhere it is called, and
we can simplify the calling convention at the same time....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
