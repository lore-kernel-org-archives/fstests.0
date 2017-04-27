Received: from mail-pf0-f196.google.com ([209.85.192.196]:36303 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbdD0SRc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Apr 2017 14:17:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so12599118pfd.3
        for <fstests@vger.kernel.org>; Thu, 27 Apr 2017 11:17:32 -0700 (PDT)
Date: Thu, 27 Apr 2017 11:17:30 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] android-xfstests: create loopback device nodes in
 standard location
Message-ID: <20170427181730.GB11396@gmail.com>
References: <20170311005632.130135-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170311005632.130135-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 04:56:32PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Android creates loopback device nodes in /dev/block/, where they can't
> be found by losetup.  Create them in /dev/ too so that losetup can find
> them.  This stops tests using loopback devices, e.g. generic/361 and
> shared/298, from failing.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Ted, this patch seems to have gotten lost; can you apply it?  Thanks!

- Eric
