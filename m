Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:34844 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbbE1SZK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 28 May 2015 14:25:10 -0400
Date: Thu, 28 May 2015 14:25:09 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/2] fsstress: add the [-l loops] option
Message-ID: <20150528182509.GD18540@thunk.org>
References: <1432774726-26824-1-git-send-email-tytso@mit.edu>
 <DD1100D8-2CD7-49B8-A046-B18BC68A87B5@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD1100D8-2CD7-49B8-A046-B18BC68A87B5@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, May 27, 2015 at 08:32:23PM -0500, Eric Sandeen wrote:
> 
> > +errout:
> > +    chdir("..");
> 
> This seems unrelated, no?

This is needed to so that we leave doproc with the same CWD that we
entered with.  At the beginning of the doproc, we do the eqvuialent of

	mkdir -p pN
	cd pN

(where N is 0, 1, 2, 3, ..)

previously doproc was only executed once, so it didn't matter what the
CWD was when we were doing with doproc().  But since with this patch
we are now calling doproc in the loop, the chdir("..") is required or
each successive loop will result in a new p0 directory being created,
and then at the end of the run, the files will be in

.../p0/p0/p0/p0/p0/p0/p0/p0/p0/...

       	   	   	     	 - Ted
