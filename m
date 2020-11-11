Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE41C5517A
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559DD20658
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpGkK24a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgKKTVz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgKKTVy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Nov 2020 14:21:54 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2F420825;
        Wed, 11 Nov 2020 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605122514;
        bh=1ZQISILsX9YuU5tyv2b9IjWnTY0yenPLuU0lcepy8og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpGkK24aOygwpSrkxeWZ4MAhpbZcuKqDkGHxDBtKi+cgllzJcSCFNJRosmgm3DXx3
         8IaCvDkoVTrJrFs8S6B4e4CTuNMkmzmcLLf3UFA9qSKgSrefcT/Y2brb/kLj7tJo1z
         1pa9alxa6TUU+EdH5nGreA6QPOP32T/jobHn+F5A=
Date:   Wed, 11 Nov 2020 11:21:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] gen-tarball: add 'set -e'
Message-ID: <20201111192152.GA335825@gmail.com>
References: <20201101172450.479000-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101172450.479000-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 01, 2020 at 09:24:50AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The latest master branch of xfstests is missing a Makefile in
> tests/ceph/, which broke xfstests's 'make install'.  But gen-tarball
> didn't notice this.  Fix this by adding 'set -e', and to make this work
> adjust a couple other commands that are expected to fail.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  gen-tarball | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Ping.  Ted, are you planning to apply this?  The master branch of xfstests is
fixed now, but this gen-tarball change would still be good to have.

- Eric
