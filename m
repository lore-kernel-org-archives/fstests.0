Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4DFC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838D56128A
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 11:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhHXLyt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236921AbhHXLyt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Aug 2021 07:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CC6F61246;
        Tue, 24 Aug 2021 11:54:04 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:54:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Subject: Re: [PATCH] idmap: override btrfs_ioctl_vol_args_v2 if system header
 doesn't have subvolid
Message-ID: <20210824115401.qas36hnt2vfsumdx@wittgenstein>
References: <20210823182138.GF12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823182138.GF12612@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 23, 2021 at 11:21:38AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The struct btrfs_ioctl_vol_args_v2 in /usr/include/linux/btrfs.h on my
> system predates the inclusion of the "subvolid" field.  This causes the
> following build failure:
> 
> idmapped-mounts.c: In function 'btrfs_delete_subvolume_id':
> idmapped-mounts.c:9730:6: error: 'struct btrfs_ioctl_vol_args_v2' has no member named 'subvolid'
>  9730 |  args.subvolid = subvolid;
>       |      ^
> 
> Since this source file contains its own more uptodate copy of that
> structure, add some more autoconf/cpp magic so that we can override the
> struct definition if the system header doesn't have the desired field.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good! Thank you for taking the time to fix this!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
