Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF7C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbhLONQq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhLONQq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 08:16:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6880FC061574
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 05:16:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB18618DB
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 13:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171FEC34605;
        Wed, 15 Dec 2021 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639574205;
        bh=8FiLZqUbNhvnq5eHQw1v8VaLd9zhPOwaJv3MVsfCqRY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dhgljgADmk+PdpVuBDijKrCTMWvfdAdurXDWfrkiLe426S7JSg8gLWUtO275Tf9Kj
         qIS6DnD6eYb/rqdQy/c4nM9TJbFY67QY4EVV6phyYBmv2XCW4ZKznX73JfR4q/zywx
         ikDZtS0WvXGk07vxhL7wlCkhh/z7DUqmHZnJHG6+RmzScq/QYvFpGunNnIWQJsPUSZ
         j9YRue2t2zXZoLUaCBFOPd+IyYrf8VQlYbjilloBRIf3tUv0C2FKbiAXxQv3TqNy/z
         RLzijl3PrmojqzaYQSXMJJxdarGhSoE1F2l6PGIkMShEuy1kecvzGBM2lIQ6yLbRM4
         gWr388LuIYHew==
Message-ID: <77fdbf9b5ac50d2e3ed4d03ef39a6dffbf891d55.camel@kernel.org>
Subject: Re: [fstests PATCH] ceph: don't run tests if we can't set a custom
 layout
From:   Jeff Layton <jlayton@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Date:   Wed, 15 Dec 2021 08:16:43 -0500
In-Reply-To: <YbYA3k3osjOy7VZq@desktop>
References: <20211207160437.184145-1-jlayton@kernel.org>
         <YbYA3k3osjOy7VZq@desktop>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, 2021-12-12 at 22:02 +0800, Eryu Guan wrote:
> On Tue, Dec 07, 2021 at 11:04:37AM -0500, Jeff Layton wrote:
> > Some of the coming fscrypt patches prohibit non-default layout changes.
> > Skip running the tests that set custom layouts if setting the layout fails.
> > 
> > Cc: Luis Henriques <lhenriques@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/ceph | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/ceph b/common/ceph
> > index ca756dda8dd3..31b169af51b8 100644
> > --- a/common/ceph
> > +++ b/common/ceph
> > @@ -19,7 +19,7 @@ _ceph_create_file_layout()
> >  	touch $fname
> >  	$SETFATTR_PROG -n ceph.file.layout \
> >  		-v "stripe_unit=$objsz stripe_count=1 object_size=$objsz" \
> > -		$fname
> > +		$fname || _notrun "setting ceph.file.layout failed"
> >  }
> 
> IMO _ceph_create_file_layout() is a helper function that does the real
> work, i.e. either prepares the test or does the test, not a function to
> check if current env & setup meets what the test needs.
> 
> So I think it's better to check the ability to change layout explicitly
> in a new _require rule. e.g. something like _require_ceph_change_layout?
> 
> Thanks,
> Eryu


Good point. OTOH, relying on this program returning an error may be the
wrong approach. What might be best is to just have a
_require_not_encrypted check. That might be more universally useful
anyway.

Let me see what I can come up with. We can drop this patch for now.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
