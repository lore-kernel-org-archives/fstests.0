Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76785C54EBE
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 17:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjALRtO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjALRso (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 12:48:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C710DE
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 09:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B02B81ED7
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 17:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13603C433D2;
        Thu, 12 Jan 2023 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673543277;
        bh=2m+izrbKAs3nKuAgdYhJCzX3UwU6fftA+SJMJd6JYmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7TIl9aYxgZa0SzKgRA3ZP8K06PTkzh6WgJ/CCEKemYjtHg035bxiZfy/HdbUQBEE
         J5NsTDv2yPYZFTw9g9F+9fzytEStxlf2Ay1HqMS0vtJ4g17Osb2SDKYBXSWlpJbAwc
         xDMR2+IYIF98JOetlzw2knEHQ62MgjTzhHt8c4Kyq/1zgI7+yIsWbaJ/EvIp/s7Rm8
         O6IN6ax2G4VurXggQbtNWVerYYWhA48jVBDRQ35ozh6B485zQd9tjFHhjkL3YftKUi
         c0S94CrZ9XNQplCrVpIUx1rKvb3QvC95xXprNAbzVN2wUcmtpk1oQOES/3e7sFLZQr
         FxCre09JA3rKw==
Date:   Thu, 12 Jan 2023 09:07:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] more python dependence. was: populate: fix horrible
 performance due to excessive forking
Message-ID: <Y8A+bGITjQo1p3rg@magnolia>
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-2-david@fromorbit.com>
 <Y75Q/dBXOIeIPonK@magnolia>
 <Y79pOYhJICghtLgj@magnolia>
 <20230112112458.4b024930@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112112458.4b024930@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 12, 2023 at 11:24:58AM +0100, David Disseldorp wrote:
> Hi Darrick,
> 
> On Wed, 11 Jan 2023 17:58:17 -0800, Darrick J. Wong wrote:
> 
> > > (removexattr looks like a pain in perl though...)
> > > 
> > > Anyway it's late now, I'll look at the diff tomorrow.  
> > 
> > ...or thursday now, since I decided to reply to the online fsck design
> > doc review comments, which took most of the workday.  I managed to bang
> > out a python script (perl doesn't support setxattr!) that cut the xattr
> > overhead down to nearly zero.
> 
> IIUC we currently only depend on python for the fio perf tests and
> btrfs/154 . My preference would be to not see it spread further

I don't appreciate your dismissal of the patch before I've even posted
it!

The fstests README clearly lists python3 as a dependency.  Argument
parsing and xattr calls are provided by the base python3 runtime.  No
third party libraries are required for this new program, and if they
were, they'd be added to the README.

> (especially if it's just to shave off a little runtime), mostly because
> it's a pain for dependency tracking.
> Perhaps you could use perl's syscall(SYS_fsetxattr(), ...)? Well, that or

Raw system calls are a terrible idea for maintainability.  You'd
*seriously* rather I open-code the glibc xattr wrappers and make the
fstests community maintain that for the sake of your preference?

> rewrite it again in awk ;-P

WTAF?

--D

> Cheers, David
