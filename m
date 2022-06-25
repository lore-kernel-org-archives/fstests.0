Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE9C43334
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 16:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiFYQ0A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 12:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFYQ0A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F8C3886
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 09:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A3B61524
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 16:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8170C3411C;
        Sat, 25 Jun 2022 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656174358;
        bh=ve0uj61rDl+hBT7DEuuvr/8tysKdN/78hWjqkolHdVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWtA6YVHASqFlt3IgO6hrI/Q9lZKSsU4Mjg98Jljqtl9KJ1d7nUdpSWU2nPLeHxpo
         feW7Gs/6LfjObttrxrEI0WVj3mSVKcVkg5RfNu54olM+3JHwdLfFQQduFjk3lVXG8A
         CTsHcJPPCrhAFWwvEuQ0s+vTZyY8zy0ghEcKy1N+jjU9n3SwOnCPjotI/W78prbG07
         Zo0Ck/6qAUwTDfoFFytgH5Yp3B3Dg5UckZRTjTIaK/aYschz32YbwYAVI9s0Dfl/90
         wVkNN+chuN3+ylxDk1FmZ2DJE8fOdMUBMi3MSaTMvVHFzrqlYUpvqaUufCEjIbMk8V
         5b2UuV41pp08Q==
Date:   Sat, 25 Jun 2022 18:25:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v3] generic/692: test group ownership change
Message-ID: <20220625162540.lhdnqly5xzqzkesm@wittgenstein>
References: <20220615092826.2333847-1-brauner@kernel.org>
 <20220625151715.vxlq2wflms2ykcju@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220625151715.vxlq2wflms2ykcju@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 25, 2022 at 11:17:15PM +0800, Zorro Lang wrote:
> On Wed, Jun 15, 2022 at 11:28:26AM +0200, Christian Brauner wrote:
> > When group ownership is changed a caller whose fsuid owns the inode can
> > change the group of the inode to any group they are a member of. When
> > searching through the caller's groups we failed to use the gid mapped
> > according to the idmapped mount otherwise we fail to change ownership.
> > Add a test for this.
> > 
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: <fstests@vger.kernel.org>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> > /* v2 */
> > - Zorro Lang <zlang@redhat.com>:
> >   - various minor fixes
> > 
> > - Christian Brauner (Microsoft) <brauner@kernel.org>:
> >   - Expand test to also cover overlayfs on top of idmapped mounts.
> > 
> > /* v3 */
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Switch from calls to the mount binary to _overlay_mount_dirs helper.
> > 
> > - Christian Brauner (Microsoft) <brauner@kernel.org>:
> >   - Expand test to also cover non-idmapped mounts.
> > ---
> 
> We really make this test case become more complicated than its v1 version,
> for covering overlayfs on top of idmapped mounts.
> 
> I'm wondering if it's worth splitting this case to two cases, one similar
> as v1 to cover the original regression test, the other expand for overlayfs,
> although that will cause some duplicate testing steps use?

Both approaches would work. I chose to combine them because it's the
same regression just under different circumstances and because it avoids
duplicated code.

> 
> If most of you prefer this v3 version, I'd like to get more review points.

If you want to wait for additional acks then sure. But I'd like to not
put merging this off for too long.
I prefer to merge regression tests quickly so they are run as soon as
possible especially since the fix is already upstream for about 2 weeks
now.

Christian
