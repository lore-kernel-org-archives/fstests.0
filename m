Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:63403 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746AbaKJB6w (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 9 Nov 2014 20:58:52 -0500
Date: Mon, 10 Nov 2014 12:58:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstests: update 'new' script v3
Message-ID: <20141110015849.GP28565@dastard>
References: <1414062518-30942-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414062518-30942-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Dimitry,

On Thu, Oct 23, 2014 at 03:08:37PM +0400, Dmitry Monakhov wrote:
> From: root <root@ts105.qa.sw.ru>

I think there is a problem with your git repo config....

> - Update script to support new test cheme tests/$fs_type/$TEST_IDX
> - Try to use first unused ID
> 
> changes from v2
>   - gawk->$AWK_PROG
> 
> Reviewed-by: Eryu Guan <eguan@redhat.com>

And it's also missing your sign-off.

The previous versions were correctly attributed, I'll pull them from
those patches, but please be a little more careful about this next
time...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
