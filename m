Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE1C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Dec 2021 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhLRRKc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Dec 2021 12:10:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49126 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229552AbhLRRKc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Dec 2021 12:10:32 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BIHAKUA020914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 12:10:21 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 55DDB15C00C8; Sat, 18 Dec 2021 12:10:20 -0500 (EST)
Date:   Sat, 18 Dec 2021 12:10:20 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: add _filter_bash()
Message-ID: <Yb4V/GBZDjcXK9qo@mit.edu>
References: <20211214170438.16164-1-tytso@mit.edu>
 <YbqOO74Lfer5h33Y@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbqOO74Lfer5h33Y@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 15, 2021 at 04:54:19PM -0800, Eric Biggers wrote:
> 
> Doesn't this happen with any shell command passed to -c, not just commands that
> run an executable?  In the commands below which are causing the problem, it is
> actually the 'echo' built-in being used, not an executable.

Well.... it happens with all executables and *some* built-in commands
which returns an error.  (See the postscript for a case where the line
number is printed.)  In the case of an error opening the redirected
standard output, such as permission denied, the difference does occur:

Compare:

% schroot -c buster-amd64 -- bash -c "echo foo >> /bin/bash"
bash: /bin/bash: Permission denied
% schroot -c buster-amd64 -- bash --version
GNU bash, version 5.0.3(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
...

with

% schroot -c bullseye-amd64 -- bash -c "echo foo >> /bin/bash"
bash: line 1: /bin/bash: Permission denied
% schroot -c bullseye-amd64 -- bash --version
GNU bash, version 5.1.4(1)-release (x86_64-pc-linux-gnu)
...

I just used the example of "bash -c /etc/passwd" because it was
simpler, and because it would be easy to verify regardless of whether
the command was executed as root or not.  For example:

% schroot -c bullseye-amd64 -u root -- bash -c "echo foo >> /bin/bash"

would have succeeded (and corrupted /bin/bash in my chroot :-).

I suppose I could have used the "schroot -c ..." example in the commit
description, but that's a debian-specific command, and I chose to err
on the side of something simpler and easier to replicate.

If Eryu would prefer, I can resend with a modified commit description,
or he can feel free to edit the commit description with the above
example if he thinks it's clearer.

Cheers,

				- Ted

P.S. The 5.1 behavior is actually a bit more consistent, since other
errors involving built-ins do actualy print a line number (although
not a *consistent* line number between bash 5.0 and 5.1:

% schroot -c buster-amd64 -- bash -c "jobs --bad-option"
bash: line 0: jobs: --: invalid option
...

vs

% schroot -c bullseye-amd64 -- bash -c "jobs --bad-option"
bash: line 1: jobs: --: invalid option
...

So the changes in Bash 5.1 error reporting does have something to
recommend itself in terms of self-consistency, but it is a bit of pain
for xfstests, where any changes in output requires extra filter
hacking!
