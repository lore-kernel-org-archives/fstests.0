Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:57133 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbbCTS5u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 14:57:50 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.4])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id E53E263C3A21
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 13:57:49 -0500 (CDT)
Message-ID: <550C6DAD.4060602@sandeen.net>
Date: Fri, 20 Mar 2015 13:57:49 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] fstests: Add overlayfs support
References: <550C46B2.8060407@sandeen.net> <550C4951.1030804@sandeen.net>
In-Reply-To: <550C4951.1030804@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/20/15 11:22 AM, Eric Sandeen wrote:
> If OVERLAYFS=1 is set, then every time we mount the scratch or
> test device, set up overlayfs directories under it, and switch
> the directory under test to the upper directory.
> 
> This doesn't specifically or directly test overlayfs, it simply
> runs the existing tests over it.  As such, a few tests fail,
> and may be expected to fail due to overlayfs limitations and
> caveats.  I haven't sorted through the results yet.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Zach has almost convinced me that this is the wrong approach and/or
not worth doing, or at least not merging.

Many of the failures are as a result of this being tacked on, and
several tests wouldn't be expected to work at all.

So I dunno.  What do people think; it's at least interesting on the
side, to see what falls off.

Good news is, no oopses yet! :)

-Eric
