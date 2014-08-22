Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:60162 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313AbaHVNYM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 22 Aug 2014 09:24:12 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so10150668lam.28
        for <fstests@vger.kernel.org>; Fri, 22 Aug 2014 06:24:10 -0700 (PDT)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default block size from test_dev
In-Reply-To: <20140821092344.GK26465@dastard>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org> <1408194791-1797-2-git-send-email-dmonakhov@openvz.org> <20140820231450.GI26465@dastard> <87mwayqooo.fsf@openvz.org> <20140821092344.GK26465@dastard>
Date: Fri, 22 Aug 2014 17:24:07 +0400
Message-ID: <877g20r72g.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

--=-=-=

On Thu, 21 Aug 2014 19:23:44 +1000, Dave Chinner <david@fromorbit.com> wrote:
> On Thu, Aug 21, 2014 at 11:36:39AM +0400, Dmitry Monakhov wrote:
> > On Thu, 21 Aug 2014 09:14:50 +1000, Dave Chinner <david@fromorbit.com> wrote:
> > > On Sat, Aug 16, 2014 at 05:13:07PM +0400, Dmitry Monakhov wrote:
> > > > Currently default block size is frozen to 4096 which is bad for
> > > > various reasons for example:
> > > > 1) It ignores MKFS_OPT
> > > 
> > > It still ignores MKFS_OPTIONS. The test device is not made with
> > > those parameters unless you specifically remake it before every
> > > xfstests run with a different configuration.
> > Yes. Usually I recreate test_dev after config was updated.
> > And I tend to agree that this may not be suitable for others.
> > In order to fix original issue I'll remove block_size argument from
> > _scratch_mkfs_sized and pass MKFS_OPTIONS instead. This will be valid
> 
> _scratch_mkfs_sized already appends MKFS_OPTIONS to the mkfs
> command. So, really, it seems like you are trying to solve the wrong
> problem. i.e. if MKFS_OPTIONS already specifies a block size, then
> this code is causing it to be specified twice?
> 
> i.e. this code works for XFS because it checks MKFS_OPTIONS for a
> custom block size and lets that override the test specified default.
> It can do this because it uses $fssize for the siz eof the
> filesystem to create, not a block count. For ext4, you need to first
> determine if ther eis a block size in MKFS_OPTIONS, extract it if
> there is, then use that to calculate the size of the fs in blocks to
> pass to mkfs.ext4....
> 
> What you want the code already does for XFS - you just need to make
> the ext4 (and any other fs you care about) also work correctly with
> MKFS_OPTIONS....
> 
> > change because currently no one pass block_size to _scratch_mkfs_sized anyway.
> 
> perhaps because it already does the right thing for XFS... ;)
Ok, agree. Since mke2fs can not do right thing let's we do it
it for them. Updated version attached

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-common-_scratch_mkfs_sized-inherent-default-block-si.patch

>From df1cc5dd89750a419b921e12599fab644a867f4d Mon Sep 17 00:00:00 2001
From: Dmitry Monakhov <dmonakhov@openvz.org>
Date: Fri, 22 Aug 2014 17:05:14 +0400
Subject: [PATCH] common: _scratch_mkfs_sized inherent default block size from MKFS_OPTIONS


Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/rc |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/common/rc b/common/rc
index 84fef35..3fcf0a1 100644
--- a/common/rc
+++ b/common/rc
@@ -582,8 +582,19 @@ _scratch_mkfs_sized()
 {
     fssize=$1
     blocksize=$2
-    [ -z "$blocksize" ] && blocksize=4096
 
+    case $FSTYP in
+    xfs)
+    	def_blksz=`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
+	;;
+    ext2|ext3|ext4|ext4dev|udf|btrfs)
+    	def_blksz=`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
+	;;
+    esac
+
+    [ -n "$def_blksz" ] && blocksize=$def_blksz
+    [ -z "$blocksize" ] && blocksize=4096
+ 
     re='^[0-9]+$'
     if ! [[ $fssize =~ $re ]] ; then
         _notrun "error: _scratch_mkfs_sized: fs size \"$fssize\" not an integer."
-- 
1.7.1


--=-=-=--
