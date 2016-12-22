Received: from imap.thunk.org ([74.207.234.97]:45056 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757704AbcLVREf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Dec 2016 12:04:35 -0500
Date: Thu, 22 Dec 2016 12:04:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: document how to add debian packages to GCE
 image
Message-ID: <20161222170433.cbyrt2phsapq2tr7@thunk.org>
References: <1482343592-135031-2-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482343592-135031-2-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06:28AM -0800, Eric Biggers wrote:
> +build your own image, you must first build a 64-bit (amd64) xfstests
> +tarball as described in the [instructions for building
> +xfstests](building-xfstests.md).  Then copy any additional Debian
> +packages, for the amd64 architecture, you want to include in the GCE
> +image into the root directory of GS_BUCKET.

This is phrased a bit awkwardly.  The official way is to put the
debian packages in kvm-xfstests/test-appliances/debs.  This works for
both building gce-xfstests and kvm-xfstests images.

And in general, you would need to use whatever debian packages for
whatever architecture is compatible for the image or chroot tarball
you are building.  For gce-xfstests, it is always amd64, since GCE
currently only supports 64-bit x86.  (But for kvm-xfstests or chroot
tarballs, it might be i386 or armhf.)

So how about,

   If you want to include any additional Debian packages, or you want
   to override the default Jessie packages with newer versions from
   jessie-backports, place them in the directory
   kvm-xfstests/test-appliances/debs.  For gce-xfstests, the packages
   must be for the amd64 architecture.

We might want break up the paragraph into multiple smaller paragraphs
just to make it easier to read.

				- Ted
