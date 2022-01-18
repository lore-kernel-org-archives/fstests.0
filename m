Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A78C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 02:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiARChm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jan 2022 21:37:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51898 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236945AbiARCcy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jan 2022 21:32:54 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20I2Wig3028549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 21:32:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8AFC815C40F6; Mon, 17 Jan 2022 21:32:44 -0500 (EST)
Date:   Mon, 17 Jan 2022 21:32:44 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Message-ID: <YeYmzJG5M0y9BcMc@mit.edu>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 17, 2022 at 03:36:54PM +0800, Yang Xu wrote:
> On my test machine, ext4/033 fails even use the non-overflow size.
> It reports invalid new size when using strtoull because errno is 1.
> 
> As man-pages said "Since  strtoul()  can legitimately return 0 or ULONG_MAX
> (ULLONG_MAX for strtoull()) on both success and failure, the calling program
> should set errno to 0 before the call, and then determine if an error occurred
> by checking whether errno has a nonzero value after the call".
> 
> So add a step to set errno to 0 before strtoull call.
> 
> Fixes: 92b9c0dedace ("ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl directly")
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

You're right of course, but out of curiosity, which C library are you
using?

						- Ted
