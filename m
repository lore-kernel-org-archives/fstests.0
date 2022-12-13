Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CFEC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 19:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiLMT12 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiLMT12 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 14:27:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD354240B6
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 11:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DCD616F3
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 19:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F31EC433EF;
        Tue, 13 Dec 2022 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670959645;
        bh=iVxAeipdaBvNG/VsH+Sila9a9W7oczzzJwDMQXUUubY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzgmX+LoM1720I8qGV/8MAjJbiyVAL4PhT6ZWNGlCxdVgq3hg+Q9bE/ZZJCcs6zL8
         g1rEfpdT02fFi2OEKeUSLDyzfosAoqrSgzuKRYncJwJKuVjOX5B7qfBEqGEodfIISk
         P5TbHYWQgO5pKBBKc4nHl7B9Zi0hluYwCuRTP8FTNayHZIK+q9kJHh8kevs5Q4I0In
         FqItAc8YUhO3WaLSyfOxIpxZsemqF+vKffX4wnAHC1sz+HbJWcl2yjj8byg6z9o1ik
         Jw4Ll92uJlHh7pBXHVUYFfwRWXMBgXIF1kP95/lBVuOA8AWnEc4B58rplx8mqs7pq5
         MBo/SI3Kl7m3g==
Date:   Tue, 13 Dec 2022 11:27:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] common/attr: require xfs_spaceman for xfs acl_get_max
Message-ID: <Y5jSHQbViwRHRGd9@magnolia>
References: <20221212230820.3466-1-ddiss@suse.de>
 <20221213144152.ae7oqrhtecuqwgya@zlang-mailbox>
 <20221213163234.5ed9cfec@echidna.fritz.box>
 <20221213182531.3aqgjfzhjoaomy2k@zlang-mailbox>
 <20221213200831.427fb98a@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213200831.427fb98a@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 08:08:31PM +0100, David Disseldorp wrote:
> On Wed, 14 Dec 2022 02:25:31 +0800, Zorro Lang wrote:
> 
> > We should let xfsprogs decide how xfs_info works. xfs_info doesn't always
> > depends on xfs_spaceman, old xfs_info might use xfs_db or other things to
> > get xfs info, and I don't know if it'll be changed to use other command in
> > the future again.
> > 
> > So this change will cause all cases which call _require_acl_get_max will notrun
> > on old (maybe future) xfsprogs which doesn't has xfs_spaceman "info" command.
> > I think that's not what we want, so I'd like to drop this patch. Thanks for
> > your understanding.
> 
> I wasn't aware that the xfs_info->xfs_spaceman call path was a new
> change. With that in mind, I agree it makes sense to drop this patch.

Since 4.17, xfs_info requires xfs_spaceman if the fs is mounted, or
xfs_db if unmounted.  Before that, it required xfs_growfs and only
worked on mounted filesystems.

That said, perhaps _acl_get_max should be doing:

	$XFS_INFO_PROG $TEST_DIR | _filter_mkfs > /dev/null 2> $tmp.info
	test "${PIPESTATUS[0]}" -ne 0 && \
		_fail "cannot get maximum acl count for xfs"

Rather than spraying whatever nonsense it does if spaceman is missing?

--D

> Cheers, David
