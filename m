Received: from sandeen.net ([63.231.237.45]:39303 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbbJBAbP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 1 Oct 2015 20:31:15 -0400
Subject: Re: help on xfs test results
References: <560C69D9.6020807@sysam.it> <560CF355.7050200@sysam.it>
 <20151001235653.GH3902@dastard>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <560DD051.4080407@sandeen.net>
Date: Thu, 1 Oct 2015 19:31:13 -0500
MIME-Version: 1.0
In-Reply-To: <20151001235653.GH3902@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Angelo Dureghello <angelo@sysam.it>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 10/1/15 6:56 PM, Dave Chinner wrote:
> Are you testing with something like selinux or some other security
> subsystem enabled that creates attributes at inode creation time?

In theory, xfstests detects this and mounts with an fs-wide context
to avoid that...

-Eric
