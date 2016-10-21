Received: from mail-pf0-f176.google.com ([209.85.192.176]:33304 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbcJUUzV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Oct 2016 16:55:21 -0400
Received: by mail-pf0-f176.google.com with SMTP id 128so63042813pfz.0
        for <fstests@vger.kernel.org>; Fri, 21 Oct 2016 13:55:21 -0700 (PDT)
Date: Fri, 21 Oct 2016 13:55:18 -0700
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] [xfstests-bld] kvm-xfstests: forbid conflicting
 specifications of FSTESTCFG
Message-ID: <20161021205518.GC137744@google.com>
References: <1474664172-84173-1-git-send-email-ebiggers@google.com>
 <1474664172-84173-3-git-send-email-ebiggers@google.com>
 <20160930222158.hlqvupjhdibjhiht@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160930222158.hlqvupjhdibjhiht@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 30, 2016 at 06:21:58PM -0400, Theodore Ts'o wrote:
> On Fri, Sep 23, 2016 at 01:56:12PM -0700, Eric Biggers wrote:
> > It was possible to run kvm-xfstests with arguments like '-c encrypt
> > smoke', in which case FSTESTCFG ended up set to "4k" because 'smoke'
> > implies '-c 4k' and the second config specification overrode the first.
> > If the user tries something like this, fail with a helpful error message
> > rather than proceeding with a configuration that likely wasn't intended.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Applie,d thanks.
> 
> 					- Ted

Hi Ted,

Are you planning to push out new commits to the public xfstests-bld repository?

Thanks,

Eric
