Received: from mail-io0-f196.google.com ([209.85.223.196]:32890 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbcL1V3k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Dec 2016 16:29:40 -0500
Received: by mail-io0-f196.google.com with SMTP id j76so19943176ioe.0
        for <fstests@vger.kernel.org>; Wed, 28 Dec 2016 13:29:40 -0800 (PST)
Date: Wed, 28 Dec 2016 15:21:32 -0600
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] xfstests-bld: document how to add debian packages to GCE
 image
Message-ID: <20161228212132.GB8557@zzz>
References: <1482343592-135031-2-git-send-email-ebiggers3@gmail.com>
 <20161222170433.cbyrt2phsapq2tr7@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161222170433.cbyrt2phsapq2tr7@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 22, 2016 at 12:04:33PM -0500, Theodore Ts'o wrote:
> On Wed, Dec 21, 2016 at 10:06:28AM -0800, Eric Biggers wrote:
> > +build your own image, you must first build a 64-bit (amd64) xfstests
> > +tarball as described in the [instructions for building
> > +xfstests](building-xfstests.md).  Then copy any additional Debian
> > +packages, for the amd64 architecture, you want to include in the GCE
> > +image into the root directory of GS_BUCKET.
> 
> This is phrased a bit awkwardly.  The official way is to put the
> debian packages in kvm-xfstests/test-appliances/debs.  This works for
> both building gce-xfstests and kvm-xfstests images.
> 

That works with kvm-xfstests (gen-image), but it didn't work when I tried it
with gce-xfstests (gce-create-image) because nothing was actually copying the
debian packages into the GS bucket for the test appliance to install.  How about
we update gce-create-image to copy the debian packages from
test-appliances/debs/ into the GS bucket (maybe gsutil rsync -d to a directory
'debs'), so that it works in the way you're suggesting?

Also, Documentation/building-rootfs.md already describes adding packages for
kvm-xfstests; it's just gce-xfstests that was missing the documentation.  So
perhaps the gce-xfstests documentation should refer to the kvm-xfstests
documentation for full details on adding packages, if the procedure is going to
be the same.

Eric
