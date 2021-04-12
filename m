Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E10C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512466102A
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhDLLyw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237792AbhDLLyt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Apr 2021 07:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72CF6102A;
        Mon, 12 Apr 2021 11:54:29 +0000 (UTC)
Date:   Mon, 12 Apr 2021 13:54:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eryu Guan <guan@eryu.me>, Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
 <YHMH/JRmzg3ETcED@desktop>
 <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <YHOW7DN51YuYgLPM@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHOW7DN51YuYgLPM@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 11, 2021 at 08:40:12PM -0400, Theodore Ts'o wrote:
> On Sun, Apr 11, 2021 at 05:32:23PM +0200, Christian Brauner wrote:
> > Ah, ok I didn't know this needed to go in there. I thinke the following
> > might be enough. Are you able to simply apply it on top?
> > 
> > diff --git a/common/rc b/common/rc
> > index 351996fc..bd913d13 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2047,6 +2047,16 @@ _require_mount_setattr()
> >  # test whether idmapped mounts are supported
> >  _require_idmapped_mounts()
> >  {
> > +       case "$FSTYP" in
> > +       xfs)
> > +               ;;
> > +       ext4)
> > +               ;;
> > +       *)
> > +               _notrun "Filesystem $FSTYP does not support idmapped mounts yet"
> > +               ;;
> > +       esac
> > +
> 
> Is there any way we can ask the kernel which file systems support
> idmapped mounts?  That way, the tests will do the right thing when run
> on older LTS kernels, and if a distribution backports idmapped support
> for some file system into their kernel, again, the right thing can
> happen automatically.

So we can detect it pretty reliably at runtime by trying whether we can
create an idmapped mount on the given filesystem. That is enough for the
idmapped mount tests here but of course has at least two drawbacks:
1. there might be scenarios where we get false negatives
   (e.g. open_tree() could fail for a lack of permissions or sm else,
   kernel might be compiled without userns support etc. pp)
2. it's heavy in so far as we have to do the whole exercise of creating
   a detached mount
So having a reliable way to detect whether or not the underlying fs
supports it could be worth it (My hope was for the fsinfo() API to grow
this "feature check" ability but oh well.).

One possibility might be to extend fstatfs() and steal one u32 from the
padding that is currently in there?

> 
> If you can't do this by checking to see if the file system will
> support a particular mount option, or some other run-time test, for
> ext4 we can signal this by checking for the existence of a file in
> /sys/fs/ext4/features, such as /sys/fs/ext4/features/fast_commit.
> (Grep for EXT4_ATTR_FEATURE and ATTR_LIST in fs/ext4/sysfs.c; it
> requires adding two lines to advertise a new ext4 feature.)

I wonder if this wouldn't be nice to have independent of whether or not
there is another way to detect it?
I'm would think that people like to see all new ext4 features listed in
there. Even if this is technically a generic vfs feature.

Christian
