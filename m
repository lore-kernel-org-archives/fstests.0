Received: from mx2.mpynet.fi ([82.197.21.85]:15399 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758899AbdLRO66 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 18 Dec 2017 09:58:58 -0500
Message-ID: <1513609136.28209.19.camel@tuxera.com>
Subject: Re: [PATCH] fstests: Add 9p network filesystem support
From: Tuomas Tynkkynen <tuomas@tuxera.com>
Date: Mon, 18 Dec 2017 16:58:56 +0200
In-Reply-To: <20171218141227.GB5123@eguan.usersys.redhat.com>
References: <20171212171154.5222-1-tuomas@tuxera.com>
         <20171218141227.GB5123@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

On Mon, 2017-12-18 at 22:12 +0800, Eryu Guan wrote:
> On Tue, Dec 12, 2017 at 07:11:54PM +0200, Tuomas Tynkkynen wrote:
> > This commit adds support for the 9p network file system, which is
> > mainly
> > used by QEMU for sharing a file system from the host to the guest
> > VM.
> > 
> > To run xfstests on it, launch QEMU with e.g.:
> > 
> > -virtfs local,path=$TMPDIR/p9-test,security_model=mapped-
> > xattr,mount_tag=p9-test
> > -virtfs local,path=$TMPDIR/p9-scratch,security_model=mapped-
> > xattr,mount_tag=p9-scratch
> > 
> > and inside the VM run xfstests with:
> > 
> > export TEST_DEV=p9-test
> > export SCRATCH_DEV=p9-scratch
> > export MOUNT_OPTIONS="-o
> > trans=virtio,version=9p2000.L,cache=loose,posixacl"
> > export TEST_FS_MOUNT_OPTS="$MOUNT_OPTIONS"
> 
> We can take 9P_MOUNT_OPTIONS as the default value for both
> MOUNT_OPTIONS
> and TEST_FS_MOUNT_OPTS in common/config, similar to
> CIFS_MOUNT_OPTIONS
> etc.
> 

Ok, will add in next version.

> > 
> > Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
> 
> This looks fine to me overall. I did a 'quick' group test and tests
> ran
> fine, though seems that some tests failed and they and/or some of the
> common helpers may need further tweaks. I think follow-up patches
> would
> be fine.
> 

I think most of the failures are legitimate bugs in either the kernel
driver, the protocol itself or QEMU. Many of those are quite difficult
to fix in userspace-based file servers; in particular those that deal
with timestamps. E.g. generic/120 which tests that atime of a file
doesn't change on exec...

Here are some of my notes for some failing cases:

generic/037: QEMU bug CVE-2017-15038. The CVE bugfix just fixes the
infoleak, but the correctness problem with getattr() remains.
generic/062, generic/097: The 9p protocol doesn't have a way to set
empty xattrs, such a protocol message is treated as xattr deletion.
generic/003 generic/120 generic/192 generic/221 generic/307 \
    generic/313 generic/423: timestamp problems
generic/403: Can't set trusted.* xattr from an userspace file server

One additional problem I know which doesn't get exercised by any
xfstest (AFAICT) is that open("foo", O_CREAT|O_WRONLY, 0444) fails with
-EPERM, at least under some mount options (related to writeback
caching).

> > ---
> >  check         |  2 ++
> >  common/attr   |  4 ++--
> >  common/config |  3 +++
> >  common/rc     | 32 +++++++++++++++++++++++++++++++-
> >  4 files changed, 38 insertions(+), 3 deletions(-)
> > 
> > diff --git check check
> > index f8db3cd6..6078b1ef 100755
> > --- check
> > +++ check
> 
> This patch doesn't apply by default, I have to edit it manually to
> make
> 'git am' work, e.g.
> 
> --- a/check
> +++ b/check
> 
> I think 'git format-patch' would generate the correct patch format.
> 
> 

Yeah, sorry, I forgot to disable the diff.noprefix option in git before
running format-patch which leads to this. Will fix for the next
submission.

