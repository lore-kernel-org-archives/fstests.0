Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:35349 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754445AbbE1StJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 28 May 2015 14:49:09 -0400
Message-ID: <55676323.8020909@sandeen.net>
Date: Thu, 28 May 2015 13:49:07 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] fsstress: add the [-l loops] option
References: <1432774726-26824-1-git-send-email-tytso@mit.edu> <DD1100D8-2CD7-49B8-A046-B18BC68A87B5@sandeen.net> <20150528182509.GD18540@thunk.org>
In-Reply-To: <20150528182509.GD18540@thunk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 5/28/15 1:25 PM, Theodore Ts'o wrote:
> On Wed, May 27, 2015 at 08:32:23PM -0500, Eric Sandeen wrote:
>>
>>> +errout:
>>> +    chdir("..");
>>
>> This seems unrelated, no?
> 
> This is needed to so that we leave doproc with the same CWD that we
> entered with.  At the beginning of the doproc, we do the eqvuialent of
> 
> 	mkdir -p pN
> 	cd pN
> 
> (where N is 0, 1, 2, 3, ..)
> 
> previously doproc was only executed once, so it didn't matter what the
> CWD was when we were doing with doproc().  But since with this patch
> we are now calling doproc in the loop, the chdir("..") is required or
> each successive loop will result in a new p0 directory being created,
> and then at the end of the run, the files will be in
> 
> .../p0/p0/p0/p0/p0/p0/p0/p0/p0/...

Oh, right.  I'm sorry, inferred too much from the patch, w/o reading the
context around the context.

-Eric

