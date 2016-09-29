Received: from imap.thunk.org ([74.207.234.97]:42790 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbcI2BRp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Sep 2016 21:17:45 -0400
Date: Wed, 28 Sep 2016 20:01:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160929000130.ixuytsr5euxef6vk@thunk.org>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926132503.GJ27776@eguan.usersys.redhat.com>
 <20160926151431.uhtny5tx3b436j4i@thunk.org>
 <20160927095529.GO27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160927095529.GO27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 27, 2016 at 05:55:29PM +0800, Eryu Guan wrote:
> 
> It has nothing to do with mount & umount, it's about adding a new
> "-local" option to "check", like "-nfs" and "-overlay". And do
> TEST_DEV/TEST_DIR and SCRATCH_DEV/SCRATCH_MNT validations in
> _require_test and _require_scratch_nocheck, as how we do the check for
> NFS and overlayfs. So we don't have to work around the validation by
> specifying TEST_DEV/SCRATCH_DEV in a non-block device format (e.g.
> local:/test to mimic an NFS export).

I'd have to dig and check, but as I recall, there were assumptions
that foo:/bar means "no block device" scattered around, and it's why
we have to use a similar naming scheme for tmpfs.  Is that really a
problem?  I had thought it was a standard convention for xfstests.

If we want to avoid forcing testers to use a foo:/bar naming scheme
for TEST_DEV and SCRATCH_DEV, instead of a new command-line variable,
I'd much rather have a function in rc/common that could be keyed off
the file system type.  You have to specify whether you are using tmpfs
or nfs or local in FSTYP anyway, so why not just use that?

Cheers,

						- Ted
