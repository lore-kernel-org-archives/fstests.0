Received: from mx1.mpynet.fi ([82.197.21.84]:31394 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756330AbdLUDNT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 20 Dec 2017 22:13:19 -0500
Message-ID: <1513825990.10114.0.camel@tuxera.com>
Subject: Re: [PATCH] fstests: Add 9p network filesystem support
From: Tuomas Tynkkynen <tuomas@tuxera.com>
Date: Thu, 21 Dec 2017 05:13:10 +0200
In-Reply-To: <1513609136.28209.19.camel@tuxera.com>
References: <20171212171154.5222-1-tuomas@tuxera.com>
         <20171218141227.GB5123@eguan.usersys.redhat.com>
         <1513609136.28209.19.camel@tuxera.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, 2017-12-18 at 16:58 +0200, Tuomas Tynkkynen wrote:
> Hi Eryu,
> 
> On Mon, 2017-12-18 at 22:12 +0800, Eryu Guan wrote:
> > On Tue, Dec 12, 2017 at 07:11:54PM +0200, Tuomas Tynkkynen wrote:
> > > This commit adds support for the 9p network file system, which is
> > > mainly
> > > used by QEMU for sharing a file system from the host to the guest
> > > VM.
> > > 
> > > To run xfstests on it, launch QEMU with e.g.:
> > > 
> > > -virtfs local,path=$TMPDIR/p9-test,security_model=mapped-
> > > xattr,mount_tag=p9-test
> > > -virtfs local,path=$TMPDIR/p9-scratch,security_model=mapped-
> > > xattr,mount_tag=p9-scratch
> > > 
> > > and inside the VM run xfstests with:
> > > 
> > > export TEST_DEV=p9-test
> > > export SCRATCH_DEV=p9-scratch
> > > export MOUNT_OPTIONS="-o
> > > trans=virtio,version=9p2000.L,cache=loose,posixacl"
> > > export TEST_FS_MOUNT_OPTS="$MOUNT_OPTIONS"
> > 
> > We can take 9P_MOUNT_OPTIONS as the default value for both
> > MOUNT_OPTIONS
> > and TEST_FS_MOUNT_OPTS in common/config, similar to
> > CIFS_MOUNT_OPTIONS
> > etc.
> > 
> 
> Ok, will add in next version.
> 

Oops; no. Bash doesn't like environment variables starting with
numbers. P9_MOUNT_OPTIONS maybe then? Though honestly, I've never used
nor really understood the reason for these foo_MOUNT_OPTIONS... same
for the -nfs etc. command line flags.
