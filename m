Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5225C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 05:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhLSFYo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Dec 2021 00:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhLSFYo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Dec 2021 00:24:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25094C061574
        for <fstests@vger.kernel.org>; Sat, 18 Dec 2021 21:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 438B0B8094B
        for <fstests@vger.kernel.org>; Sun, 19 Dec 2021 05:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F7C36AE7;
        Sun, 19 Dec 2021 05:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639891480;
        bh=15v4aDnarBBL2KdC3/8jCCbSlilthnxS/Js0y251Gbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/DqrT4baYrTna4B4BCKdrSAj2uG0kyZhTOvXyK/85tWWQ4cFaKKrKa4cy7ZWajXo
         5CQbVvvN9br2j/xxvu5HT0xniaT76uv5pw8IM6QRkJDgkxl6ZzmbErNlIsMOtqHlTQ
         53ou5JglKhbRjnpqoBtpFZxf3aolpP1apfgmsC6Zng9UyIC/YQ7duQ0SxFOOWouDSG
         6NF2gNRwARi0RwUCKu4kS/zDWrP5odhYLGeZlZI2D2t5P3IAesiZqQJHUwMB5Jrslq
         MSPwgUqPzwIvCT2zRL0WItfmqFBg24zPSsCycicvUKGk8jhqRTSMTg7QR6X/zDyl2Y
         gvwHNQRDk7Zfg==
Date:   Sat, 18 Dec 2021 23:24:37 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v2] common/filter: add _filter_bash()
Message-ID: <Yb7CFcU09vtaFx79@quark.localdomain>
References: <Yb6aLm5L+C7H3Z9P@quark.localdomain>
 <20211219041638.1659557-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219041638.1659557-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Dec 18, 2021 at 11:16:38PM -0500, Theodore Ts'o wrote:
> This is needed to account for bash 5.1 adding line number annotation
> when executing a command via the -c option and it fails.  For example,
> "bash -c 'echo foo > /'" will cause bash 5.1 to report:
> 
>      bash: line 1: /: Is a directory
> 
> instead of:
> 
>      bash: /: Is a directory
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/filter     | 11 +++++++++++
>  tests/generic/572 | 33 +++++++++++++++++++--------------
>  2 files changed, 30 insertions(+), 14 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
