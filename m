Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:57740 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbaLOVwl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 16:52:41 -0500
Date: Mon, 15 Dec 2014 16:52:36 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Check O_DIRECT support before testing direct I/O
Message-ID: <20141215215236.GM17575@thunk.org>
References: <alpine.LNX.2.00.1412152332120.21847@reiser4.gekom>
 <20141215213248.GU24183@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215213248.GU24183@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Dushan Tcholich <dusanc@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 08:32:49AM +1100, Dave Chinner wrote:
> > As there are no archives of fstests m-l I couldn't find why his 
> > patches weren't applied so apologise if this is innapropriate but  
> > I rebased his patch upon current xfstests code:
> 
> Tell me about it. If anyone knows the magic incantation to get the
> usual mailing list archive sites to answer a simple "can you archive
> this list" request, let me know, because I've tried repeatedly since
> this list was created and haven't had a single reply from any of
> them.

I recently submitted a new list request to gmane, because of a similar
frustration, about a week ago.  Looks like they created the archive:

http://news.gmane.org/gmane.comp.file-systems.fstests

And even better, it looks like postmaster@vger.kernel.org even updated
for us.

http://vger.kernel.org/vger-lists.html#fstests

Gmane is sometimes a bit slow to update, so if someone can manage to
pursuade marc.info to also archive this list, that would be a good
thing.

					- Ted
