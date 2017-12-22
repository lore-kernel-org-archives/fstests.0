Received: from mx1.redhat.com ([209.132.183.28]:35392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdLVFKA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 22 Dec 2017 00:10:00 -0500
Date: Fri, 22 Dec 2017 13:09:57 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/encrypt: Create an encrypted equivalent of
 _scratch_mkfs_sized
Message-ID: <20171222050957.GK5123@eguan.usersys.redhat.com>
References: <1513792000-25462-1-git-send-email-ari@tuxera.com>
 <20171221013802.GP5858@dastard>
 <1a058cb8-b2c0-39b5-e65d-d77264c37a54@tuxera.com>
 <20171221214657.GI4094@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171221214657.GI4094@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Ari Sundholm <ari@tuxera.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 22, 2017 at 08:46:57AM +1100, Dave Chinner wrote:
> On Thu, Dec 21, 2017 at 03:52:00PM +0200, Ari Sundholm wrote:
> > Hi!
> > 
> > Thank you for your comments. Please see below.
> > 
> > On 12/21/2017 03:38 AM, Dave Chinner wrote:
> > >On Wed, Dec 20, 2017 at 07:46:40PM +0200, Ari Sundholm wrote:
> > >>Test case generic/399 hardcodes "-O encrypt" in MKFS_OPTIONS when
> > >>calling _scratch_mkfs_sized, which only works with the mkfs of certain
> > >>filesystems. Create a new helper, _scratch_mkfs_sized_encrypted, for
> > >>handling the differences between the mkfs tools of different
> > >>filesystems. It also allows those filesystems whose mkfs doesn't accept
> > >>"-O encrypt" to skip the test gracefully until proper support is added
> > >>for them in the helper.
> > >>
> > >>Signed-off-by: Ari Sundholm <ari@tuxera.com>
> > >>---
> > >>  common/encrypt    | 12 ++++++++++++
> > >>  tests/generic/399 |  3 +--
> > >>  2 files changed, 13 insertions(+), 2 deletions(-)
> > >>
> > >>diff --git a/common/encrypt b/common/encrypt
> > >>index a6fd89d..189c59e 100644
> > >>--- a/common/encrypt
> > >>+++ b/common/encrypt
> > >>@@ -81,6 +81,18 @@ _scratch_mkfs_encrypted()
> > >>  	esac
> > >>  }
> > >>+_scratch_mkfs_sized_encrypted()
> > >>+{
> > >>+	case $FSTYP in
> > >>+	ext4|f2fs)
> > >>+		MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
> > >>+		;;
> > >
> > >This does not need to screw around with MKFS_OPTIONS. This:
> > >
> > >		_scratch_mkfs_sized -O encrypt $*
> > >
> > >Will do just fine.
> > 
> > Hmm, I don't see how that could work. At the moment,
> > _scratch_mkfs_sized only takes and uses two arguments, one of which
> > is optional. AFAICS, all additional mkfs options need to be passed
> > using MKFS_OPTIONS to _scratch_mkfs_sized.
> 
> Oh, I was under the impression that got fixed some time ago.
> Screwing with MKFS_OPTIONS means defeats some of the test specific
> mkfs option conflict resolution that some filesystem have.
> 
> i.e. when the options specified by the test cause problems with test
> run specified MKFS_OPTIONS, the MKFS_OPTIONS get dropped and just
> the test specific options are used. Setting random test options in
> MKFS_OPTIONS can cause _scratch_mkfs_sized to not use the options
> specified by the test at all...

JFYI, that was fixed in the _scratch_mkfs helper, but not the _sized
one, the fs size handling makes it special and not work well with the
generic mkfs helpers.

Thanks,
Eryu
