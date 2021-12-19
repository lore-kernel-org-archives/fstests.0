Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8BDC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 02:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhLSCe1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Dec 2021 21:34:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42268 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLSCe0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Dec 2021 21:34:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE82DB80BA6
        for <fstests@vger.kernel.org>; Sun, 19 Dec 2021 02:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F72BC36AE2;
        Sun, 19 Dec 2021 02:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639881264;
        bh=pO2Kurb4pD6WUb7yD0jKlEUNvpaT//v62r2l0Yo1Se4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNOzei8LdC+OYUmzuSLMlPnlPXGw/E3bhUf+f3Anw2sCgw0ypVS+Nd1gVq3GdS7b6
         gFNjIOdpdyfKUdAKB6JspmZmFJ5zsAX1XkcHkitGTGsyAEma46phfZo4ZvVhysa9PI
         orPZWoc+Z1RzfqQBlVAPPsd/lqVhZpWvfS94VXhtawDVJ+3ishnpvYyAG/y4zFKPkK
         8mLoZ5Cp79pviNOd19D+EhSFeqCF6q6fl/M1qpbw6wbO6eZwaBsI31sBTqzFioxOhQ
         xcSc/lDj0966fhpz4EYoXICz3t6rD5jYlE3cnHEwb+Z5+fESVZuvpgZ1M3fLBkR3Sj
         LAUZWNHWWYj9g==
Date:   Sat, 18 Dec 2021 20:34:22 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: add _filter_bash()
Message-ID: <Yb6aLm5L+C7H3Z9P@quark.localdomain>
References: <20211214170438.16164-1-tytso@mit.edu>
 <YbqOO74Lfer5h33Y@sol.localdomain>
 <Yb4V/GBZDjcXK9qo@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb4V/GBZDjcXK9qo@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Dec 18, 2021 at 12:10:20PM -0500, Theodore Ts'o wrote:
> On Wed, Dec 15, 2021 at 04:54:19PM -0800, Eric Biggers wrote:
> > 
> > Doesn't this happen with any shell command passed to -c, not just commands that
> > run an executable?  In the commands below which are causing the problem, it is
> > actually the 'echo' built-in being used, not an executable.
> 
> Well.... it happens with all executables and *some* built-in commands
> which returns an error.  (See the postscript for a case where the line
> number is printed.)  In the case of an error opening the redirected
> standard output, such as permission denied, the difference does occur:
> 
> Compare:
> 
> % schroot -c buster-amd64 -- bash -c "echo foo >> /bin/bash"
> bash: /bin/bash: Permission denied
> % schroot -c buster-amd64 -- bash --version
> GNU bash, version 5.0.3(1)-release (x86_64-pc-linux-gnu)
> Copyright (C) 2019 Free Software Foundation, Inc.
> ...
> 
> with
> 
> % schroot -c bullseye-amd64 -- bash -c "echo foo >> /bin/bash"
> bash: line 1: /bin/bash: Permission denied
> % schroot -c bullseye-amd64 -- bash --version
> GNU bash, version 5.1.4(1)-release (x86_64-pc-linux-gnu)
> ...
> 
> I just used the example of "bash -c /etc/passwd" because it was
> simpler, and because it would be easy to verify regardless of whether
> the command was executed as root or not.  For example:
> 
> % schroot -c bullseye-amd64 -u root -- bash -c "echo foo >> /bin/bash"
> 
> would have succeeded (and corrupted /bin/bash in my chroot :-).

A good example that doesn't involve an executable would be

	bash -c "echo foo > /"

... since that command redirection will always fail.

> I suppose I could have used the "schroot -c ..." example in the commit
> description, but that's a debian-specific command, and I chose to err
> on the side of something simpler and easier to replicate.
> 
> If Eryu would prefer, I can resend with a modified commit description,
> or he can feel free to edit the commit description with the above
> example if he thinks it's clearer.

I'm more concerned about the misleading comment above _filter_bash(), not the
commit message which is less important.  Anyway, it's not too important, but I
thought it was worth pointing out.

- Eric
