Received: from mail-pf0-f195.google.com ([209.85.192.195]:35303 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036429AbdEYSn2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 14:43:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so40870544pfd.2
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 11:43:28 -0700 (PDT)
Date: Thu, 25 May 2017 11:43:24 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v2] kvm-xfstests, gce-xfstests: improve recommended
 kernel config
Message-ID: <20170525184324.GA81861@gmail.com>
References: <20170523174557.60810-1-ebiggers3@gmail.com>
 <20170525172411.tbi56oe27oz6rnuj@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170525172411.tbi56oe27oz6rnuj@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, May 25, 2017 at 01:24:11PM -0400, Theodore Ts'o wrote:
> On Tue, May 23, 2017 at 10:45:57AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Trim more unneeded features from the recommended kernel config, then
> > enable some more relatively lightweight debugging options.
> > 
> > For now, just update the latest x86_64 config.  But if people are okay
> > with these changes I'll update some of the other configs too.
> > 
> > Tested with both kvm-xfstests and gce-xfstests.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> This looks good to me.  Would you mind sending a patch which updates
> the rest of the configs similarly, so we can update all of the configs
> at once?
> 
> As an aside, I *do* use the HW_RANDOM_VIRTIO from time to time (that's
> why it was enabled in the config), and in fact kvm-xfstests is wired
> up to supply the virtio random number generator by default (since it
> doesn't really cost much):
> 
> if test -z "$NO_VIRTIO_RNG" ; then
>     VIRTIO_RNG="-object rng-random,filename=/dev/urandom,id=rng0 \
> 	-device virtio-rng-pci,rng=rng0"
> fi
> 
> But that's for my kernel RNG testing, and it's fair to say that that
> most users of kvm-xfstests won't need it.
> 

Yes I'll do that.  I'll probably leave HW_RANDOM_VIRTIO on, given that the
virtio-rng-pci device is emulated by default, and the kernel config ought to
support the default emulated hardware.  (Or else we should turn the
virtio-rng-pci device off by default.)

Eric
