Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC72BC433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34E1611EF
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhDKPNL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235503AbhDKPNK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 11 Apr 2021 11:13:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49BF2611AD;
        Sun, 11 Apr 2021 15:12:52 +0000 (UTC)
Date:   Sun, 11 Apr 2021 17:12:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
 <YHMH/JRmzg3ETcED@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHMH/JRmzg3ETcED@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 11, 2021 at 10:30:20PM +0800, Eryu Guan wrote:
> On Mon, Mar 29, 2021 at 12:33:56AM +0200, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Add a test suite to verify the behavior of idmapped mounts. The test
> > suite also includes a range of vfs tests to verify that no regressions
> > are introduced by idmapped mounts. The following tests are currently
> > available with more to come in the future:
> > 
> > 01. posix acls on regular and idmapped mounts
> 
> I'm getting failures like below when testing on btrfs and overlayfs
> 
> [root@fedoravm xfstests]# diff -u
> /root/workspace/xfstests/tests/generic/633.out /root/workspace/xfstests/results//btrfs/generic/633.out.bad
> --- /root/workspace/xfstests/tests/generic/633.out      2021-04-11 22:18: 24.458518716 +0800
> +++ /root/workspace/xfstests/results//btrfs/generic/633.out.bad 2021-04-11 22:19:58.887980770 +0800
> @@ -1,2 +1,4 @@
>  QA output created by 633
>   Silence is golden
>   +idmapped-mounts.c: 6622: acls - Invalid argument - failure: sys_mount_setattr
>   +failure: posix acls on regular mounts
> 
> Is this a known issue or test needs some fix?

Ah, this is very likely just the getfacl command missing which is part
of the "acl" package, at least on Ubuntu.

Christian
