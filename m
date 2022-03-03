Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A7AC433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 23:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiCCXsu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiCCXst (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 18:48:49 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45B1463BD3
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 15:48:02 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 69820532480;
        Fri,  4 Mar 2022 10:48:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nPvAt-001D04-Tk; Fri, 04 Mar 2022 10:47:59 +1100
Date:   Fri, 4 Mar 2022 10:47:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/4] README: Fix setup, btrfs and distro info
Message-ID: <20220303234759.GI3927073@dread.disaster.area>
References: <20220303132804.4151-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303132804.4151-1-gniebler@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=622153b1
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
        a=7-415B0cAAAA:8 a=iSfEJviiXCEjhs1BNMUA:9 a=6RyHdP9wf0s6W1bbVaoE2bQoMl4=:19
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 03, 2022 at 02:28:00PM +0100, Gabriel Niebler wrote:
> The README had some incorrect environment setup information in the quick start
> section and some outdated info related to btrfs testing.
> 
> This patchset fixes that, while also adding some more distro specfic setup info.
> 
> Gabriel Niebler (4):
>   README: Fix environment setup quick start
>   README: Adjust and add btrfs testing information
>   README: Add command to install required packages on SUSE
>   README: Fix indentation to be consistent

This document is in the process of a major update:

https://lore.kernel.org/fstests/20220228202849.183568-1-aalbersh@redhat.com/T/#m257b55c7ee6a2fb3de17df5ea2c575e2541e01f6

It would be best to check whether these issues still need fixing
after the above patch is applied and then rebase the changes on top
of that to be consistent with the new structure and layout.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
