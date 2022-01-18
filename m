Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABFEC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 13:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiARNda (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiARNda (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 08:33:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846EC061574
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 05:33:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D263EB8165F
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 13:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452B5C00446;
        Tue, 18 Jan 2022 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642512807;
        bh=S4U4zyAemhPbf2pmdZdZGcBL6Tw7aZxNsz/x91VlzHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIiouQK27ye7ZsKJ0iL2OXB+FAFzxGyEFSlmu2ZkvXfSFR8x6qbmcnZzIwPG5GPZG
         H7s4fIVvW4UXulP1ivTSO+HcVtODQsJy8Ooqn5wOL9Db5eN6KqrnCLGPTnEdN0llqC
         eJX3jx19Iah7hRBMkxLsuYX5+tT7jEy5lAqTmSNpcXMBpMAaK9ukIP9gAJtAfip7Ko
         ZUXKq7gIvNdhnb+X8SKGo3NqaxqYI3z5P89HB/VX/CvBXBJUMqpAAGvwcIU/bE4VGt
         aIhLi97s3BMO43REl+yUjyCqu+n/qg2B88TsnSJ0AgRexdFWfr5Rxd5nximpqdA4Pu
         9vT7Lx0zWXgRw==
Date:   Tue, 18 Jan 2022 14:33:22 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/2] idmapped-mounts: add fs_allow_idmap() helper
Message-ID: <20220118133322.dbxytrlj6uvqgzha@wittgenstein>
References: <20220113132421.865002-1-brauner@kernel.org>
 <YeOkVHBnpkQRQlIR@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeOkVHBnpkQRQlIR@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 16, 2022 at 12:51:32PM +0800, Eryu Guan wrote:
> On Thu, Jan 13, 2022 at 02:24:20PM +0100, Christian Brauner wrote:
> > Move the check whether the underlying filesystem supports idmapped
> > mounts into a separate helper. We will use it in the following patch to
> > make it possible to always run all tests that don't require idmapped
> > mounts.
> > 
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Eryu Guan <guaneryu@gmail.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: fstests@vger.kernel.org
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  src/idmapped-mounts/idmapped-mounts.c | 57 ++++++++++++++-------------
> >  1 file changed, 30 insertions(+), 27 deletions(-)
> > 
> > diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> > index da690779..a78a901f 100644
> > --- a/src/idmapped-mounts/idmapped-mounts.c
> > +++ b/src/idmapped-mounts/idmapped-mounts.c
> > @@ -13907,6 +13907,35 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
> >  	return true;
> >  }
> >  
> > +static bool fs_allow_idmap(void)
> > +{
> > +	int ret;
> > +	int open_tree_fd = -EBADF;
> > +	struct mount_attr attr = {
> > +		.attr_set	= MOUNT_ATTR_IDMAP,
> > +		.userns_fd	= -EBADF,
> > +	};
> > +
> > +	/* Changing mount properties on a detached mount. */
> > +	attr.userns_fd = get_userns_fd(0, 1000, 1);
> > +	if (attr.userns_fd < 0)
> > +		exit(EXIT_FAILURE);
> 
> IMHO, it'd be better to return false here and let caller decide if we
> should exit or not.

Agreed.
