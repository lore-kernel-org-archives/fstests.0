Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:39707 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbaKSUC7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 19 Nov 2014 15:02:59 -0500
Date: Wed, 19 Nov 2014 15:02:52 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: xfstests and ext4
Message-ID: <20141119200252.GA15071@thunk.org>
References: <CAH2r5murzVmOVnRchq=U-jx74U96g7N6Y42CW0iX4HKpWnbmxw@mail.gmail.com>
 <20141114000216.GN28565@dastard>
 <CAH2r5mvi2LijxWia2sCf+em7rfPtBn_fg6WKU=aftVUTuzXMgw@mail.gmail.com>
 <20141117203804.GO23575@dastard>
 <CAH2r5mti8hVXqmKu9kJg4Xk=5nkESCAQys1BFXhR6JSDVHOTEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mti8hVXqmKu9kJg4Xk=5nkESCAQys1BFXhR6JSDVHOTEA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 17, 2014 at 08:35:39PM -0600, Steve French wrote:
> 
> Yes.  WIll do.  It is a pain in test VMs to setup git with gmail two
> phase authentication
> but doable if I set it up to send mail from a different host.

There are lots of ways to skin a cat, but I just simply build xfstests
in my standard development environment, and then either create a
completely new test VM image from scratch, which doesn't take _that_ long:

<tytso@closure> {/u1/xfstests-bld/build-32/kvm-xfstests/test-appliance}
521% /usr/bin/time schroot -c sid -u root ./gen-image
     ...
/tmp/root_fs.raw.7430: 9867/65536 files (0.0% non-contiguous), 66071/262144 blocks
65.23user 15.65system 1:25.65elapsed 94%CPU (0avgtext+0avgdata 11076maxresident)k
42inputs+970048outputs (0major+1528344minor)pagefaults 0swaps

or I'll update the VM image from my build directory, which keeps the
OS files the same and only updates the files in /root/xfstests:

<tytso@closure> {/u1/xfstests-bld/build-32/kvm-xfstests/test-appliance}
523% /usr/bin/time schroot -c sid -u root -- ./gen-image --update
	...
9.98user 1.65system 0:12.81elapsed 90%CPU (0avgtext+0avgdata 11644maxresident)k
4674inputs+178512outputs (0major+204070minor)pagefaults 0swaps

The advantage of doing it that way is that I get replicable builds for
my xfstest VM's, and it also helps keep them small (only 66 megs),
which makes them easier to move around to different test servers.

(I also like not being dependent on the version of xfslibs-dev that
Ubuntu might have decided to ship, since a while back I was stuck on
pretty ancient LTS versions due to corporate policy reasons, and there
were a few tests that required the latest versions of xfsprogs/xfslibs
in order to build and run.  So that's why I use a completely hermetic
build in my infrastructure, which can be found in my xfstests-bld git
tree if you want to give it a try.)

Cheers,

						- Ted
