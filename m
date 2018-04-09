Received: from mail-pl0-f68.google.com ([209.85.160.68]:46537 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbeDITAS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 15:00:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id 59-v6so5739504plc.13
        for <fstests@vger.kernel.org>; Mon, 09 Apr 2018 12:00:17 -0700 (PDT)
Date: Mon, 9 Apr 2018 12:00:14 -0700
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [xfstests-bld PATCH] test-appliance: support f2fs-tools v1.9 and
 later
Message-ID: <20180409190014.GB203367@google.com>
References: <20180405222141.42376-1-ebiggers@google.com>
 <20180406133036.GD7345@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406133036.GD7345@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 06, 2018 at 09:30:36AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Apr 05, 2018 at 03:21:41PM -0700, Eric Biggers wrote:
> > Pass the -f option to mkfs.f2fs when it appears to support it.  This is
> > required by f2fs-tools v1.9 and later in order to format the filesystem
> > even when an existing filesystem is detected.  But earlier versions did
> > not accept this option.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Applied for now, but ugh.  Grepping strings out of binaries is not
> something I really like to depend upon.  Can we convince the f2fs
> folks to provide a "/sbin/mkfs.f2fs -V" which prints a version string,
> or some such?
> 

Yes, it's ugly.  As something maybe a bit better, I've proposed

	mkfs.f2fs --help |& grep -q "[[:space:]]-f[[:space:]|]"
	
in v2 of the xfstests patch to common/config.  So if that gets accepted into
xfstests I'll change this to use the same method.

Thanks,

Eric
