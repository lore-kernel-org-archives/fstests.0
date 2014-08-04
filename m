Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:41567 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbaHDPMN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 4 Aug 2014 11:12:13 -0400
Message-ID: <53DFA2CD.8010101@sandeen.net>
Date: Mon, 04 Aug 2014 10:12:13 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: generic/076 cleanup
References: <53DF6C3F.6010406@plexistor.com>
In-Reply-To: <53DF6C3F.6010406@plexistor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Omer Caspi <omer.caspi@plexistor.com>, fstests@vger.kernel.org
Cc: Boaz <boaz@plexistor.com>
List-ID: <fstests@vger.kernel.org>

On 8/4/14, 6:19 AM, Omer Caspi wrote:
> While running some tests from the xfstests suite (quick group), I noticed 
> that generic test 076 doesn't clean after itself. Specifically, a couple 
> of directories (p1 and p2) remain on $TEST_DIR once the test is completed. 

> To my understanding, a test should cleanup the files it had created, so I 
> added a rm command to test's _cleanup function to fix it, which seems to 
> be OK, but I thought I'll check: is there a reason for these directories 
> to remain there after the test completion?
> 
> Omer

the test device is supposed to age, so leaving things lying around there
after the test has run is expected, and fine.

_cleanup is more about removing tmpfiles, killing any spawned threads,
etc - not about cleaning up the test device.

-Eric

